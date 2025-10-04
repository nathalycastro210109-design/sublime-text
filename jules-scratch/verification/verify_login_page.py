from playwright.sync_api import sync_playwright, Page, expect
import pathlib
import os

def verify_login_page(page: Page):
    """
    This test verifies that the login modal appears after clicking the login button.
    """
    # 1. Arrange: Go to the index.html page.
    # Correctly construct the file path for cross-platform compatibility.
    file_path = os.path.abspath('index.html')
    page.goto(f"file://{file_path}")

    # 2. Act: Find the "Login" link and click it.
    login_link = page.get_by_role("link", name="Login")
    login_link.click()

    # 3. Assert: Confirm the login container is visible.
    login_container = page.locator(".login-container")
    expect(login_container).to_be_visible()

    # 4. Screenshot: Capture the final result for visual verification.
    page.screenshot(path="jules-scratch/verification/verification.png")

# Main execution block
if __name__ == "__main__":
    with sync_playwright() as p:
        browser = p.chromium.launch(headless=True)
        page = browser.new_page()
        try:
            verify_login_page(page)
            print("Verification script ran successfully.")
        except Exception as e:
            print(f"An error occurred: {e}")
        finally:
            browser.close()