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
Subject: [PATCHv2 5/8] staging: iio: isl29028: deprecate use of isl in compatible string for isil
In-Reply-To: <cover.1418763328.git.arno@natisbad.org>
References: <cover.1418763328.git.arno@natisbad.org>
Message-Id: <f935306404d9b6d8a37862987122b6988cb6ffff.1418763328.git.arno@natisbad.org>
Date: Tue, 16 Dec 2014 22:20:37 +0100
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
