Return-Path: <florian.vaussard@gmail.com>
From: Florian Vaussard <florian.vaussard@gmail.com>
To: devicetree@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Peter Rosin <peda@axentia.se>,
	Slawomir Stepien <sst@poczta.fm>,
	Joachim Eastwood <manabian@gmail.com>,
	Matt Ranostay <mranostay@gmail.com>,
	Cristina Moraru <cristina.moraru09@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Florian Vaussard <florian.vaussard@heig-vd.ch>
Subject: [PATCH v2 1/4] iio: potentiometer: mcp4531: Add support for MCP454x, MCP456x, MCP464x and MCP466x
Date: Sun, 26 Jun 2016 22:22:44 +0200
Message-Id: <1466972567-9580-2-git-send-email-florian.vaussard@heig-vd.ch>
In-Reply-To: <1466972567-9580-1-git-send-email-florian.vaussard@heig-vd.ch>
References: <1466972567-9580-1-git-send-email-florian.vaussard@heig-vd.ch>
List-ID: <linux-iio@vger.kernel.org>

This patch adds support for MCP454x, MCP456x, MCP464x and MCP466x parts.
The main difference with currently supported parts (MCP453x and alike) is
the addition of a non-volatile memory in order to recall the wiper setting
at power-on. This feature is currently not supported and only the
volatile memory is used to set the wiper.

Acked-by: Peter Rosin <peda@axentia.se>
Signed-off-by: Florian Vaussard <florian.vaussard@heig-vd.ch>
---
 drivers/iio/potentiometer/Kconfig   |  6 ++--
 drivers/iio/potentiometer/mcp4531.c | 72 +++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/potentiometer/Kconfig b/drivers/iio/potentiometer/Kconfig
index 0941c8d4..55c2414 100644
--- a/drivers/iio/potentiometer/Kconfig
+++ b/drivers/iio/potentiometer/Kconfig
@@ -49,8 +49,10 @@ config MCP4531
 	depends on I2C
 	help
 	  Say yes here to build support for the Microchip
-	  MCP4531, MCP4532, MCP4551, MCP4552,
-	  MCP4631, MCP4632, MCP4651, MCP4652
+	  MCP4531, MCP4532, MCP4541, MCP4542,
+	  MCP4551, MCP4552, MCP4561, MCP4562,
+	  MCP4631, MCP4632, MCP4641, MCP4642,
+	  MCP4651, MCP4652, MCP4661, MCP4662
 	  digital potentiomenter chips.
 
 	  To compile this driver as a module, choose M here: the
diff --git a/drivers/iio/potentiometer/mcp4531.c b/drivers/iio/potentiometer/mcp4531.c
index 3b72e1a..2251173 100644
--- a/drivers/iio/potentiometer/mcp4531.c
+++ b/drivers/iio/potentiometer/mcp4531.c
@@ -8,12 +8,20 @@
  * DEVID	#Wipers	#Positions	Resistor Opts (kOhm)	i2c address
  * mcp4531	1	129		5, 10, 50, 100          010111x
  * mcp4532	1	129		5, 10, 50, 100          01011xx
+ * mcp4541	1	129		5, 10, 50, 100          010111x
+ * mcp4542	1	129		5, 10, 50, 100          01011xx
  * mcp4551	1	257		5, 10, 50, 100          010111x
  * mcp4552	1	257		5, 10, 50, 100          01011xx
+ * mcp4561	1	257		5, 10, 50, 100          010111x
+ * mcp4562	1	257		5, 10, 50, 100          01011xx
  * mcp4631	2	129		5, 10, 50, 100          0101xxx
  * mcp4632	2	129		5, 10, 50, 100          01011xx
+ * mcp4641	2	129		5, 10, 50, 100          0101xxx
+ * mcp4642	2	129		5, 10, 50, 100          01011xx
  * mcp4651	2	257		5, 10, 50, 100          0101xxx
  * mcp4652	2	257		5, 10, 50, 100          01011xx
+ * mcp4661	2	257		5, 10, 50, 100          0101xxx
+ * mcp4662	2	257		5, 10, 50, 100          01011xx
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License version 2 as published by
@@ -37,18 +45,34 @@ enum mcp4531_type {
 	MCP453x_103,
 	MCP453x_503,
 	MCP453x_104,
+	MCP454x_502,
+	MCP454x_103,
+	MCP454x_503,
+	MCP454x_104,
 	MCP455x_502,
 	MCP455x_103,
 	MCP455x_503,
 	MCP455x_104,
+	MCP456x_502,
+	MCP456x_103,
+	MCP456x_503,
+	MCP456x_104,
 	MCP463x_502,
 	MCP463x_103,
 	MCP463x_503,
 	MCP463x_104,
+	MCP464x_502,
+	MCP464x_103,
+	MCP464x_503,
+	MCP464x_104,
 	MCP465x_502,
 	MCP465x_103,
 	MCP465x_503,
 	MCP465x_104,
+	MCP466x_502,
+	MCP466x_103,
+	MCP466x_503,
+	MCP466x_104,
 };
 
 static const struct mcp4531_cfg mcp4531_cfg[] = {
@@ -56,18 +80,34 @@ static const struct mcp4531_cfg mcp4531_cfg[] = {
 	[MCP453x_103] = { .wipers = 1, .max_pos = 128, .kohms =  10, },
 	[MCP453x_503] = { .wipers = 1, .max_pos = 128, .kohms =  50, },
 	[MCP453x_104] = { .wipers = 1, .max_pos = 128, .kohms = 100, },
+	[MCP454x_502] = { .wipers = 1, .max_pos = 128, .kohms =   5, },
+	[MCP454x_103] = { .wipers = 1, .max_pos = 128, .kohms =  10, },
+	[MCP454x_503] = { .wipers = 1, .max_pos = 128, .kohms =  50, },
+	[MCP454x_104] = { .wipers = 1, .max_pos = 128, .kohms = 100, },
 	[MCP455x_502] = { .wipers = 1, .max_pos = 256, .kohms =   5, },
 	[MCP455x_103] = { .wipers = 1, .max_pos = 256, .kohms =  10, },
 	[MCP455x_503] = { .wipers = 1, .max_pos = 256, .kohms =  50, },
 	[MCP455x_104] = { .wipers = 1, .max_pos = 256, .kohms = 100, },
+	[MCP456x_502] = { .wipers = 1, .max_pos = 256, .kohms =   5, },
+	[MCP456x_103] = { .wipers = 1, .max_pos = 256, .kohms =  10, },
+	[MCP456x_503] = { .wipers = 1, .max_pos = 256, .kohms =  50, },
+	[MCP456x_104] = { .wipers = 1, .max_pos = 256, .kohms = 100, },
 	[MCP463x_502] = { .wipers = 2, .max_pos = 128, .kohms =   5, },
 	[MCP463x_103] = { .wipers = 2, .max_pos = 128, .kohms =  10, },
 	[MCP463x_503] = { .wipers = 2, .max_pos = 128, .kohms =  50, },
 	[MCP463x_104] = { .wipers = 2, .max_pos = 128, .kohms = 100, },
+	[MCP464x_502] = { .wipers = 2, .max_pos = 128, .kohms =   5, },
+	[MCP464x_103] = { .wipers = 2, .max_pos = 128, .kohms =  10, },
+	[MCP464x_503] = { .wipers = 2, .max_pos = 128, .kohms =  50, },
+	[MCP464x_104] = { .wipers = 2, .max_pos = 128, .kohms = 100, },
 	[MCP465x_502] = { .wipers = 2, .max_pos = 256, .kohms =   5, },
 	[MCP465x_103] = { .wipers = 2, .max_pos = 256, .kohms =  10, },
 	[MCP465x_503] = { .wipers = 2, .max_pos = 256, .kohms =  50, },
 	[MCP465x_104] = { .wipers = 2, .max_pos = 256, .kohms = 100, },
+	[MCP466x_502] = { .wipers = 2, .max_pos = 256, .kohms =   5, },
+	[MCP466x_103] = { .wipers = 2, .max_pos = 256, .kohms =  10, },
+	[MCP466x_503] = { .wipers = 2, .max_pos = 256, .kohms =  50, },
+	[MCP466x_104] = { .wipers = 2, .max_pos = 256, .kohms = 100, },
 };
 
 #define MCP4531_WRITE (0 << 2)
@@ -187,6 +227,14 @@ static const struct i2c_device_id mcp4531_id[] = {
 	{ "mcp4532-103", MCP453x_103 },
 	{ "mcp4532-503", MCP453x_503 },
 	{ "mcp4532-104", MCP453x_104 },
+	{ "mcp4541-502", MCP454x_502 },
+	{ "mcp4541-103", MCP454x_103 },
+	{ "mcp4541-503", MCP454x_503 },
+	{ "mcp4541-104", MCP454x_104 },
+	{ "mcp4542-502", MCP454x_502 },
+	{ "mcp4542-103", MCP454x_103 },
+	{ "mcp4542-503", MCP454x_503 },
+	{ "mcp4542-104", MCP454x_104 },
 	{ "mcp4551-502", MCP455x_502 },
 	{ "mcp4551-103", MCP455x_103 },
 	{ "mcp4551-503", MCP455x_503 },
@@ -195,6 +243,14 @@ static const struct i2c_device_id mcp4531_id[] = {
 	{ "mcp4552-103", MCP455x_103 },
 	{ "mcp4552-503", MCP455x_503 },
 	{ "mcp4552-104", MCP455x_104 },
+	{ "mcp4561-502", MCP456x_502 },
+	{ "mcp4561-103", MCP456x_103 },
+	{ "mcp4561-503", MCP456x_503 },
+	{ "mcp4561-104", MCP456x_104 },
+	{ "mcp4562-502", MCP456x_502 },
+	{ "mcp4562-103", MCP456x_103 },
+	{ "mcp4562-503", MCP456x_503 },
+	{ "mcp4562-104", MCP456x_104 },
 	{ "mcp4631-502", MCP463x_502 },
 	{ "mcp4631-103", MCP463x_103 },
 	{ "mcp4631-503", MCP463x_503 },
@@ -203,6 +259,14 @@ static const struct i2c_device_id mcp4531_id[] = {
 	{ "mcp4632-103", MCP463x_103 },
 	{ "mcp4632-503", MCP463x_503 },
 	{ "mcp4632-104", MCP463x_104 },
+	{ "mcp4641-502", MCP464x_502 },
+	{ "mcp4641-103", MCP464x_103 },
+	{ "mcp4641-503", MCP464x_503 },
+	{ "mcp4641-104", MCP464x_104 },
+	{ "mcp4642-502", MCP464x_502 },
+	{ "mcp4642-103", MCP464x_103 },
+	{ "mcp4642-503", MCP464x_503 },
+	{ "mcp4642-104", MCP464x_104 },
 	{ "mcp4651-502", MCP465x_502 },
 	{ "mcp4651-103", MCP465x_103 },
 	{ "mcp4651-503", MCP465x_503 },
@@ -211,6 +275,14 @@ static const struct i2c_device_id mcp4531_id[] = {
 	{ "mcp4652-103", MCP465x_103 },
 	{ "mcp4652-503", MCP465x_503 },
 	{ "mcp4652-104", MCP465x_104 },
+	{ "mcp4661-502", MCP466x_502 },
+	{ "mcp4661-103", MCP466x_103 },
+	{ "mcp4661-503", MCP466x_503 },
+	{ "mcp4661-104", MCP466x_104 },
+	{ "mcp4662-502", MCP466x_502 },
+	{ "mcp4662-103", MCP466x_103 },
+	{ "mcp4662-503", MCP466x_503 },
+	{ "mcp4662-104", MCP466x_104 },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, mcp4531_id);
-- 
2.5.5
