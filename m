Return-Path: <arno@natisbad.org>
From: Arnaud Ebalard <arno@natisbad.org>
To: Jonathan Cameron <jic23@kernel.org>,
    Hartmut Knaack <knaack.h@gmx.de>,
    Lars-Peter Clausen <lars@metafoo.de>,
    Peter Meerwald <pmeerw@pmeerw.net>,
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    Arnd Bergmann <arnd@arndb.de>,
    Mark Rutland <mark.rutland@arm.com>,
    Darshana Padmadas <darshanapadmadas@gmail.com>,
    linux-iio@vger.kernel.org,
    devel@driverdev.osuosl.org,
    Andrew Morton <akpm@linux-foundation.org>,
    Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
    Alessandro Zummo <a.zummo@towertech.it>,
    Peter Huewe <peter.huewe@infineon.com>,
    Linus Walleij <linus.walleij@linaro.org>,
    Thierry Reding <treding@nvidia.com>,
    Mark Brown <broonie@kernel.org>,
    Arnd Bergmann <arnd@arndb.de>,
    Rob Herring <rob.herring@calxeda.com>,
    Pawel Moll <pawel.moll@arm.com>,
    Stephen Warren <swarren@wwwdotorg.org>,
    Ian Campbell <ijc+devicetree@hellion.org.uk>,
    Grant Likely <grant.likely@linaro.org>,
    devicetree@vger.kernel.org,
    linux-doc@vger.kernel.org,
    Rob Landley <rob@landley.net>,
    rtc-linux@googlegroups.com,
    Jason Cooper <jason@lakedaemon.net>,
    Guenter Roeck <linux@roeck-us.net>,
    Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
    Kumar Gala <galak@codeaurora.org>,
    linux-arm-kernel@lists.infradead.org
Subject: [PATCHv1 4/7] staging: iio: isl29028: deprecate use of isl in
 compatible string for isil
In-Reply-To: <cover.1418688042.git.arno@natisbad.org>
References: <cover.1418688042.git.arno@natisbad.org>
Message-Id: <d28a812f3a873654d573aed18bbcf9dc0c22c6fd.1418688042.git.arno@natisbad.org>
Date: Tue, 16 Dec 2014 01:23:42 +0100
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>


"isil" and "isl" prefixes are used at various locations inside the kernel
to reference Intersil corporation. This patch is part of a series fixing
those locations were "isl" is used in compatible strings to use the now
expected "isil" prefix instead (NASDAQ symbol for Intersil and most used
version). The old compatible string is kept for backward compatibility.

Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
 drivers/staging/iio/light/isl29028.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
index e969107ddb47..6440e3b293ca 100644
--- a/drivers/staging/iio/light/isl29028.c
+++ b/drivers/staging/iio/light/isl29028.c
@@ -537,8 +537,8 @@ static const struct i2c_device_id isl29028_id[] = {
 MODULE_DEVICE_TABLE(i2c, isl29028_id);
 
 static const struct of_device_id isl29028_of_match[] = {
-	{ .compatible = "isl,isl29028", },
-	{ .compatible = "isil,isl29028", },/* deprecated, don't use */
+	{ .compatible = "isl,isl29028", }, /* for backward compat., don't use */
+	{ .compatible = "isil,isl29028", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, isl29028_of_match);
-- 
2.1.1
