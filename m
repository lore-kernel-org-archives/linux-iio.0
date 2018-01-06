Return-Path: <SRS0=Rp4e=EB=gmail.com=venkat.prashanth2498@kernel.org>
From: venkat.prashanth2498@gmail.com
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org,
	Venkat Prashanth B U <venkat.prashanth2498@gmail.com>
Subject: [PATCH V3] Drivers:iio:dac: Remove unneeded conversion to bool
Date: Sat,  6 Jan 2018 20:23:29 +0530
Message-Id: <1515250409-3240-1-git-send-email-venkat.prashanth2498@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

From: Venkat Prashanth B U <venkat.prashanth2498@gmail.com>

This is a patch to the mcp4725.c file which
fixes the following coccinelle warning:

WARNING: conversion to bool not needed here

Signed-off-by: Venkat Prashanth B U <venkat.prashanth2498@gmail.com>
---
change log v2:-
Fixed version log issue.

change log v1:-
Instead of inadvertent removal of complete statement, only the
conversion to bool is removed.
---
 drivers/iio/dac/mcp4725.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
index afa856d..8b5aad4 100644
--- a/drivers/iio/dac/mcp4725.c
+++ b/drivers/iio/dac/mcp4725.c
@@ -476,7 +476,7 @@ static int mcp4725_probe(struct i2c_client *client,
 		goto err_disable_vref_reg;
 	}
 	pd = (inbuf[0] >> 1) & 0x3;
-	data->powerdown = pd > 0 ? true : false;
+	data->powerdown = pd > 0;
 	data->powerdown_mode = pd ? pd - 1 : 2; /* largest resistor to gnd */
 	data->dac_value = (inbuf[1] << 4) | (inbuf[2] >> 4);
 	if (data->id == MCP4726)
-- 
1.9.1
