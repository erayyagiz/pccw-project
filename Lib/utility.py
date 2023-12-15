from robot.api.deco import keyword
from webdriver_manager.chrome import ChromeDriverManager
from webdriver_manager.firefox import GeckoDriverManager
import string
import secrets


@keyword('Get Driver Path')
def get_driver_path_with_browser(browser_name):
    """
            Keyword to get the path for the browser
    """
    if browser_name.lower() == 'chrome':
        driver_path = ChromeDriverManager().install()
    elif browser_name.lower() == 'firefox':
        driver_path = GeckoDriverManager().install()
    return driver_path


@keyword("Generate Random Special")
def generate_random_special_chars(length):
    """
            Keyword to generate random special characters
    """
    str_characters = string.punctuation + "çÇğĞıİöÖüÜşŞ" + "诶必西弟衣艾付记" + "记ДЖИ" + "ØΔΦΨ"
    res = ''.join(secrets.choice(str_characters) for x in range(int(length)))
    return str(res)
