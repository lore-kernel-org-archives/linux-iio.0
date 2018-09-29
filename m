Return-Path: <SRS0=NE5I=ML=gmail.com=jmkrzyszt@kernel.org>
From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
	Peter Korsgaard <peter.korsgaard@barco.com>,
	Peter Rosin <peda@axentia.se>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Jiri Slaby <jslaby@suse.com>,
	Willy Tarreau <w@1wt.eu>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>,
	Lukas Wunner <lukas@wunner.de>,
	Rojhalat Ibrahim <imr@rtschenk.de>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Tony Lindgren <tony@atomide.com>,
	Yegor Yefremov <yegorslists@googlemail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-serial@vger.kernel.org,
	Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
	linux-kernel@vger.kernel.org,
	Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH] gpiolib: Fix incorrect use of find_next_zero_bit()
Date: Sat, 29 Sep 2018 14:20:22 +0200
Message-Id: <20180929122022.6825-1-jmkrzyszt@gmail.com>
In-Reply-To: <20180923235336.22148-2-jmkrzyszt@gmail.com>
References: <20180923235336.22148-2-jmkrzyszt@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Commit b17566a6b08b ("gpiolib: Implement fast processing path in
get/set array"), already fixed to some extent with commit 5d581d7e8cdc
("gpiolib: Fix missing updates of bitmap index"), introduced a new mode
of processing bitmaps where bits applicable for fast bitmap processing
path are supposed to be skipped while iterating bits which don't apply.
Unfortunately, find_next_zero_bit() function supposed to skip over
those fast bits is always called with a 'start' argument equal to an
index of last zero bit found and returns that index value again an
again, causing an infinite loop.

Fix it by incrementing the index uncoditionally before
find_next_zero_bit() is optionally called.

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
Marek,

Could you please test it on top of next-20180920 with "gpiolib: Fix
missing updates of bitmap index" and optionally "mmc: pwrseq_simple:
Fix incorrect handling of GPIO bitmap" also applied?

Thanks,
Janusz


 drivers/gpio/gpiolib.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 6ae13e3e05f1..940b543e966d 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2878,12 +2878,11 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
 			int hwgpio = gpio_chip_hwgpio(desc);
 
 			__set_bit(hwgpio, mask);
+			i++;
 
 			if (array_info)
 				i = find_next_zero_bit(array_info->get_mask,
 						       array_size, i);
-			else
-				i++;
 		} while ((i < array_size) &&
 			 (desc_array[i]->gdev->chip == chip));
 
@@ -2903,12 +2902,11 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
 				value = !value;
 			__assign_bit(j, value_bitmap, value);
 			trace_gpio_value(desc_to_gpio(desc), 1, value);
+			j++;
 
 			if (array_info)
 				j = find_next_zero_bit(array_info->get_mask, i,
 						       j);
-			else
-				j++;
 		}
 
 		if (mask != fastpath)
@@ -3191,12 +3189,11 @@ int gpiod_set_array_value_complex(bool raw, bool can_sleep,
 					__clear_bit(hwgpio, bits);
 				count++;
 			}
+			i++;
 
 			if (array_info)
 				i = find_next_zero_bit(array_info->set_mask,
 						       array_size, i);
-			else
-				i++;
 		} while ((i < array_size) &&
 			 (desc_array[i]->gdev->chip == chip));
 		/* push collected bits to outputs */
-- 
2.16.4
