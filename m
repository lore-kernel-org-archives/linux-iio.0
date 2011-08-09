Return-Path: <error27@gmail.com>
Date: Tue, 9 Aug 2011 21:06:16 +0300
From: Dan Carpenter <error27@gmail.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Greg Kroah-Hartman <gregkh@suse.de>,
	Michael Hennerich <michael.hennerich@analog.com>,
	"open list:STAGING - INDUSTR..." <linux-iio@vger.kernel.org>,
	"open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
	kernel-janitors@vger.kernel.org
Subject: [patch] Staging: iio/dac/ad5504: uninitialized variable in error
 handling
Message-ID: <20110809180616.GC3830@shale.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

If we hit the "goto error_disable_reg" then the "st" variable is
uninitialized.

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/drivers/staging/iio/dac/ad5504.c b/drivers/staging/iio/dac/ad5504.c
index 1915f45..88512dd 100644
--- a/drivers/staging/iio/dac/ad5504.c
+++ b/drivers/staging/iio/dac/ad5504.c
@@ -338,7 +338,7 @@ error_free_dev:
 	iio_free_device(indio_dev);
 error_disable_reg:
 	if (!IS_ERR(reg))
-		regulator_disable(st->reg);
+		regulator_disable(reg);
 error_put_reg:
 	if (!IS_ERR(reg))
 		regulator_put(reg);
