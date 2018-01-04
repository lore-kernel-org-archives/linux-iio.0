Return-Path: <SRS0=cr0b=D7=gmail.com=venkat.prashanth2498@kernel.org>
From: venkat.prashanth2498@gmail.com
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org,
	Venkat Prashanth B U <venkat.prashanth2498@gmail.com>
Subject: [PATCH] Drivers:iio:dac: Remove unneeded conversion to bool
Date: Thu,  4 Jan 2018 17:28:12 +0530
Message-Id: <1515067092-5219-1-git-send-email-venkat.prashanth2498@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

From: Venkat Prashanth B U <venkat.prashanth2498@gmail.com>

This is a patch to the mcp4725.c file which
fixes the following coccinelle warning:

WARNING: conversion to bool not needed here

Signed-off-by: Venkat Prashanth B U <venkat.prashanth2498@gmail.com>
---
 drivers/iio/dac/mcp4725.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
index afa856d..8f8c529 100644
--- a/drivers/iio/dac/mcp4725.c
+++ b/drivers/iio/dac/mcp4725.c
@@ -476,7 +476,6 @@ static int mcp4725_probe(struct i2c_client *client,
 		goto err_disable_vref_reg;
 	}
 	pd = (inbuf[0] >> 1) & 0x3;
-	data->powerdown = pd > 0 ? true : false;
 	data->powerdown_mode = pd ? pd - 1 : 2; /* largest resistor to gnd */
 	data->dac_value = (inbuf[1] << 4) | (inbuf[2] >> 4);
 	if (data->id == MCP4726)
-- 
1.9.1
