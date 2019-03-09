Return-Path: <SRS0=9Bew=RM=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD18C43381
	for <linux-iio@archiver.kernel.org>; Sat,  9 Mar 2019 01:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 489EC2133F
	for <linux-iio@archiver.kernel.org>; Sat,  9 Mar 2019 01:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfCIBOs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 8 Mar 2019 20:14:48 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:37841 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726375AbfCIBOs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 8 Mar 2019 20:14:48 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x291BEkZ010784;
        Sat, 9 Mar 2019 02:14:23 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2r2ng2erp3-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Sat, 09 Mar 2019 02:14:23 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6DCDF31;
        Sat,  9 Mar 2019 01:14:22 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2DCF6140B;
        Sat,  9 Mar 2019 01:14:22 +0000 (GMT)
Received: from SFHDAG2NODE1.st.com (10.75.127.4) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Sat, 9 Mar
 2019 02:14:21 +0100
Received: from SFHDAG2NODE1.st.com ([fe80::4413:c8c:992b:bb90]) by
 SFHDAG2NODE1.st.com ([fe80::4413:c8c:992b:bb90%20]) with mapi id
 15.00.1347.000; Sat, 9 Mar 2019 02:14:21 +0100
From:   Denis CIOCCA <denis.ciocca@st.com>
To:     Robert Jones <rjones@gateworks.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>
Subject: RE: [PATCH 2/2] iio: accel: add support to LIS2DE12
Thread-Topic: [PATCH 2/2] iio: accel: add support to LIS2DE12
Thread-Index: AQHU05drWhKzGrITDU+6kapNNnQGs6YCg6Rg
Date:   Sat, 9 Mar 2019 01:14:21 +0000
Message-ID: <4e7c32c8a3d74636a6bf5e82d8fa4b72@SFHDAG2NODE1.st.com>
References: <20190305203252.13647-1-rjones@gateworks.com>
 <20190305203252.13647-3-rjones@gateworks.com>
In-Reply-To: <20190305203252.13647-3-rjones@gateworks.com>
Accept-Language: it-IT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.44]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-09_01:,,
 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Acked-by: Denis Ciocca <denis.ciocca@st.com>

Thanks,
Denis

-----Original Message-----
From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org> On Behalf Of Robert Jones
Sent: Tuesday, March 5, 2019 12:33 PM
To: Jonathan Cameron <jic23@kernel.org>; Rob Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org; linux-iio@vger.kernel.org; Hartmut Knaack <knaack.h@gmx.de>; Lars-Peter Clausen <lars@metafoo.de>; Peter Meerwald-Stadler <pmeerw@pmeerw.net>; Robert Jones <rjones@gateworks.com>
Subject: [PATCH 2/2] iio: accel: add support to LIS2DE12

Add support to STMicroelectronics LIS2DE12 accelerometer in st_accel framework.

http://www.st.com/resource/en/datasheet/lis2de12.pdf

Signed-off-by: Robert Jones <rjones@gateworks.com>
---
 drivers/iio/accel/Kconfig         |  2 +-
 drivers/iio/accel/st_accel.h      |  2 ++
 drivers/iio/accel/st_accel_core.c | 76 +++++++++++++++++++++++++++++++++++++++
 drivers/iio/accel/st_accel_i2c.c  |  5 +++
 4 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig index 898839c..ffd0b4d 100644
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
diff --git a/drivers/iio/accel/st_accel.h b/drivers/iio/accel/st_accel.h index fd53258..753a5671 100644
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
+#define LIS2DE12_ACCEL_DEV_NAME		"lis2de12_accel"
 
 /**
 * struct st_sensors_platform_data - default accel platform data diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 9930edf..aebd611 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -831,6 +831,82 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 		.multi_read_bit = false,
 		.bootime = 2,
 	},
+	{
+	.wai = 0x33,
+	.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
+	.sensors_supported = {
+		[0] = LIS2DE12_ACCEL_DEV_NAME,
+	},
+	.ch = (struct iio_chan_spec *)st_accel_8bit_channels,
+	.odr = {
+		.addr = 0x20,
+		.mask = 0xf0,
+		.odr_avl = {
+			{ .hz = 1, .value = 0x01, },
+			{ .hz = 10, .value = 0x02, },
+			{ .hz = 25, .value = 0x03, },
+			{ .hz = 50, .value = 0x04, },
+			{ .hz = 100, .value = 0x05, },
+			{ .hz = 200, .value = 0x06, },
+			{ .hz = 400, .value = 0x07, },
+			{ .hz = 1600, .value = 0x08, },
+			{ .hz = 5376, .value = 0x09, },
+		},
+	},
+	.pw = {
+		.addr = 0x20,
+		.mask = 0xf0,
+		.value_off = ST_SENSORS_DEFAULT_POWER_OFF_VALUE,
+	},
+	.enable_axis = {
+		.addr = ST_SENSORS_DEFAULT_AXIS_ADDR,
+		.mask = ST_SENSORS_DEFAULT_AXIS_MASK,
+	},
+	.fs = {
+		.addr = 0x23,
+		.mask = 0x30,
+		.fs_avl = {
+			[0] = {
+				.num = ST_ACCEL_FS_AVL_2G,
+				.value = 0x00,
+				.gain = IIO_G_TO_M_S_2(15600),
+			},
+			[1] = {
+				.num = ST_ACCEL_FS_AVL_4G,
+				.value = 0x01,
+				.gain = IIO_G_TO_M_S_2(31200),
+			},
+			[2] = {
+				.num = ST_ACCEL_FS_AVL_8G,
+				.value = 0x02,
+				.gain = IIO_G_TO_M_S_2(62500),
+			},
+			[3] = {
+				.num = ST_ACCEL_FS_AVL_16G,
+				.value = 0x03,
+				.gain = IIO_G_TO_M_S_2(187500),
+			},
+			},
+	},
+	.bdu = {
+		.addr = 0x23,
+		.mask = 0x80,
+	},
+	.drdy_irq = {
+		.addr = 0x22,
+		.mask_int1 = 0x10,
+		.mask_int2 = 0x00,
+		.addr_ihl = 0x25,
+		.mask_ihl = 0x02,
+		.addr_stat_drdy = ST_SENSORS_DEFAULT_STAT_ADDR,
+	},
+	.sim = {
+		.addr = 0x23,
+		.value = BIT(0),
+	},
+	.multi_read_bit = true,
+	.bootime = 2,
+	},
 };
 
 static int st_accel_read_raw(struct iio_dev *indio_dev, diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
index de8ae43..cb6eb6f 100644
--- a/drivers/iio/accel/st_accel_i2c.c
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -102,6 +102,10 @@ static const struct of_device_id st_accel_of_match[] = {
 		.compatible = "st,lis3de",
 		.data = LIS3DE_ACCEL_DEV_NAME,
 	},
+	{
+		.compatible = "st,lis2de12-accel",
+		.data = LIS2DE12_ACCEL_DEV_NAME,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_accel_of_match); @@ -140,6 +144,7 @@ static const struct i2c_device_id st_accel_id_table[] = {
 	{ LIS3LV02DL_ACCEL_DEV_NAME },
 	{ LIS2DW12_ACCEL_DEV_NAME },
 	{ LIS3DE_ACCEL_DEV_NAME },
+	{ LIS2DE12_ACCEL_DEV_NAME },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, st_accel_id_table);
--
2.9.2

