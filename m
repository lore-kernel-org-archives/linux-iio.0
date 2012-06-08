Return-Path: <dan.carpenter@oracle.com>
Date: Fri, 8 Jun 2012 09:55:37 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [patch 2/2 -next] iio: frequency: adf4350: fix an initialization
Message-ID: <20120608065537.GD26673@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

Sparse complains about this:
drivers/iio/frequency/adf4350.c:58:29: warning: Initializer entry defined twice
drivers/iio/frequency/adf4350.c:59:10:   also defined here

It looks like '|' was intended here instead of ','.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Guess work on my part.

diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
index 4729bba..59fbb3ae 100644
--- a/drivers/iio/frequency/adf4350.c
+++ b/drivers/iio/frequency/adf4350.c
@@ -54,7 +54,7 @@ struct adf4350_state {
 static struct adf4350_platform_data default_pdata = {
 	.clkin = 122880000,
 	.channel_spacing = 10000,
-	.r2_user_settings = ADF4350_REG2_PD_POLARITY_POS,
+	.r2_user_settings = ADF4350_REG2_PD_POLARITY_POS |
 			    ADF4350_REG2_CHARGE_PUMP_CURR_uA(2500),
 	.r3_user_settings = ADF4350_REG3_12BIT_CLKDIV_MODE(0),
 	.r4_user_settings = ADF4350_REG4_OUTPUT_PWR(3) |
