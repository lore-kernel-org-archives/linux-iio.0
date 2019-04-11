Return-Path: <SRS0=YN3l=SN=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE45CC10F14
	for <linux-iio@archiver.kernel.org>; Thu, 11 Apr 2019 00:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C563220818
	for <linux-iio@archiver.kernel.org>; Thu, 11 Apr 2019 00:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbfDKAgf (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 10 Apr 2019 20:36:35 -0400
Received: from lists.gateworks.com ([108.161.130.12]:17669 "EHLO
        lists.gateworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbfDKAgf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 Apr 2019 20:36:35 -0400
Received: from 68-189-91-139.static.snlo.ca.charter.com ([68.189.91.139] helo=rjones.pdc.gateworks.com)
        by lists.gateworks.com with esmtp (Exim 4.82)
        (envelope-from <rjones@gateworks.com>)
        id 1hENUi-0003X9-Ke; Wed, 10 Apr 2019 17:23:08 -0700
Received: by rjones.pdc.gateworks.com (Postfix, from userid 1002)
        id 25DEA1A42DD0; Wed, 10 Apr 2019 17:12:31 -0700 (PDT)
From:   Robert Jones <rjones@gateworks.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Robert Jones <rjones@gateworks.com>
Subject: [PATCH v2 2/2] iio: accel: add support to LIS2DE12
Date:   Wed, 10 Apr 2019 17:12:09 -0700
Message-Id: <20190411001209.29488-3-rjones@gateworks.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20190411001209.29488-1-rjones@gateworks.com>
References: <20190305203252.13647-1-rjones@gateworks.com>
 <20190411001209.29488-1-rjones@gateworks.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support to STMicroelectronics LIS2DE12 accelerometer in
st_accel framework.

http://www.st.com/resource/en/datasheet/lis2de12.pdf

Signed-off-by: Robert Jones <rjones@gateworks.com>
---
 drivers/iio/accel/Kconfig         |  2 +-
 drivers/iio/accel/st_accel.h      |  2 ++
 drivers/iio/accel/st_accel_core.c | 76 +++++++++++++++++++++++++++++++++++++++
 drivers/iio/accel/st_accel_i2c.c  |  5 +++
 4 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 4a1f133..62a970a 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -223,7 +223,7 @@ config IIO_ST_ACCEL_3AXIS
 	  Say yes here to build support for STMicroelectronics accelerometers:
 	  LSM303DLH, LSM303DLHC, LIS3DH, LSM330D, LSM330DL, LSM330DLC,
 	  LIS331DLH, LSM303DL, LSM303DLM, LSM330, LIS2DH12, H3LIS331DL,
-	  LNG2DM, LIS3DE
+	  LNG2DM, LIS3DE, LIS2DE12
 
 	  This driver can also be built as a module. If so, these modules
 	  will be created:
diff --git a/drivers/iio/accel/st_accel.h b/drivers/iio/accel/st_accel.h
index fd53258..9d25955 100644
--- a/drivers/iio/accel/st_accel.h
+++ b/drivers/iio/accel/st_accel.h
@@ -34,6 +34,7 @@ enum st_accel_type {
 	LIS3LV02DL,
 	LIS2DW12,
 	LIS3DHH,
+	LIS2DE12,
 	ST_ACCEL_MAX,
 };
 
@@ -57,6 +58,7 @@ enum st_accel_type {
 #define LIS2DW12_ACCEL_DEV_NAME		"lis2dw12"
 #define LIS3DHH_ACCEL_DEV_NAME		"lis3dhh"
 #define LIS3DE_ACCEL_DEV_NAME		"lis3de"
+#define LIS2DE12_ACCEL_DEV_NAME		"lis2de12"
 
 /**
 * struct st_sensors_platform_data - default accel platform data
diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 9930edf..5ff04d9 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -831,6 +831,82 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 		.multi_read_bit = false,
 		.bootime = 2,
 	},
+	{
+		.wai = 0x33,
+		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
+		.sensors_supported = {
+			[0] = LIS2DE12_ACCEL_DEV_NAME,
+		},
+		.ch = (struct iio_chan_spec *)st_accel_8bit_channels,
+		.odr = {
+			.addr = 0x20,
+			.mask = 0xf0,
+			.odr_avl = {
+				{ .hz = 1, .value = 0x01, },
+				{ .hz = 10, .value = 0x02, },
+				{ .hz = 25, .value = 0x03, },
+				{ .hz = 50, .value = 0x04, },
+				{ .hz = 100, .value = 0x05, },
+				{ .hz = 200, .value = 0x06, },
+				{ .hz = 400, .value = 0x07, },
+				{ .hz = 1620, .value = 0x08, },
+				{ .hz = 5376, .value = 0x09, },
+			},
+		},
+		.pw = {
+			.addr = 0x20,
+			.mask = 0xf0,
+			.value_off = ST_SENSORS_DEFAULT_POWER_OFF_VALUE,
+		},
+		.enable_axis = {
+			.addr = ST_SENSORS_DEFAULT_AXIS_ADDR,
+			.mask = ST_SENSORS_DEFAULT_AXIS_MASK,
+		},
+		.fs = {
+			.addr = 0x23,
+			.mask = 0x30,
+			.fs_avl = {
+				[0] = {
+					.num = ST_ACCEL_FS_AVL_2G,
+					.value = 0x00,
+					.gain = IIO_G_TO_M_S_2(15600),
+				},
+				[1] = {
+					.num = ST_ACCEL_FS_AVL_4G,
+					.value = 0x01,
+					.gain = IIO_G_TO_M_S_2(31200),
+				},
+				[2] = {
+					.num = ST_ACCEL_FS_AVL_8G,
+					.value = 0x02,
+					.gain = IIO_G_TO_M_S_2(62500),
+				},
+				[3] = {
+					.num = ST_ACCEL_FS_AVL_16G,
+					.value = 0x03,
+					.gain = IIO_G_TO_M_S_2(187500),
+				},
+			},
+		},
+		.drdy_irq = {
+			.int1 = {
+				.addr = 0x22,
+				.mask = 0x10,
+			},
+			.addr_ihl = 0x25,
+			.mask_ihl = 0x02,
+			.stat_drdy = {
+				.addr = ST_SENSORS_DEFAULT_STAT_ADDR,
+				.mask = 0x07,
+			},
+		},
+		.sim = {
+			.addr = 0x23,
+			.value = BIT(0),
+		},
+		.multi_read_bit = true,
+		.bootime = 2,
+	},
 };
 
 static int st_accel_read_raw(struct iio_dev *indio_dev,
diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
index de8ae43..4e54477 100644
--- a/drivers/iio/accel/st_accel_i2c.c
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -102,6 +102,10 @@ static const struct of_device_id st_accel_of_match[] = {
 		.compatible = "st,lis3de",
 		.data = LIS3DE_ACCEL_DEV_NAME,
 	},
+	{
+		.compatible = "st,lis2de12",
+		.data = LIS2DE12_ACCEL_DEV_NAME,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_accel_of_match);
@@ -140,6 +144,7 @@ static const struct i2c_device_id st_accel_id_table[] = {
 	{ LIS3LV02DL_ACCEL_DEV_NAME },
 	{ LIS2DW12_ACCEL_DEV_NAME },
 	{ LIS3DE_ACCEL_DEV_NAME },
+	{ LIS2DE12_ACCEL_DEV_NAME },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, st_accel_id_table);
-- 
2.9.2

