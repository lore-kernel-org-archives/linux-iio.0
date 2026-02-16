Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC4D29E101;
	Mon, 16 Feb 2026 10:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771237510; cv=none; b=qIa8rpt3192kX2ZjIHDeO5bFhwd7HFW8k3TdKYCj4R30cczNSotNEBITyT9nISAI1R2fwuq7AAPM/X+YiTD+cwosV4RgPZsYr15l15dacAfeHxCXsM4DJ5lbF7uGxjFbatXu9J3/XeDVWolOVOKjEOk2j9fjhyGZaInBZXLvEtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771237510; c=relaxed/simple;
	bh=8DROzJZ+0rYeEPmwsGBfdpOldzRINQE0QDPwJptpmUI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a+N2DdwUPfB8SnMIEhXLUAAnZyTsfJmZFu0XLYkuTiwA9dXIs6yBehVNQhA2/0Rux3ThqTJ3M9/n858g0NTfV8RNuPfdLrPfpB3QzfQW6nEInx5Xc/ghQyGMv31vmhpfV6N9XVtOnrqkzZUq7ZhoS7R9wmqfmAf14tqE8gnfARY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oXQqLnTV; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oXQqLnTV"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61FNk9IM266556;
	Mon, 16 Feb 2026 10:24:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=JBi171xcQMNHPUomFzkoHrzLNyxGz
	Kdu4OVAaBTgUCw=; b=oXQqLnTVpMqUQuWV0Fztyv9EYiWm96JY/Rbco6ZQroaeE
	4ffbj97kNO+3D+zi7IiznslS5lHGAyFx80Vl2xXzDWym72J6+ln5W5oTXQ4DWulL
	vDXLdXEtmmMpHDMQCxRsfvxVGkUt43tRqam5TOUkZcdFY3PV/IKZUmkjEW7ZvIrt
	xQXTKr47pCdUDJy4es+DrpLuXSFkWzI9yfxuBQntBLerWAi1IZN86Hd4fEWYHJk+
	5OvnBDXLfzMbAree7v0I57S3wN3sYNGuJuZMvYfKK6X49kR7W8QIVnqIhjnA6Jv5
	oZYaGmdJsxrcKmJNtFUvNwf4Ik22OzGGO1FSgSqAg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4caj041uxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Feb 2026 10:24:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61GA5x0t029631;
	Mon, 16 Feb 2026 10:24:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cafgjghb8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Feb 2026 10:24:57 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 61GAOvbi002807;
	Mon, 16 Feb 2026 10:24:57 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4cafgjghah-1;
	Mon, 16 Feb 2026 10:24:57 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Andrew Ijano <andrew.ijano@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH next v2] iio: sca3000: simplify with spi_get_device_match_data()
Date: Mon, 16 Feb 2026 02:24:48 -0800
Message-ID: <20260216102453.1063866-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_04,2026-02-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602160087
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDA4NyBTYWx0ZWRfX6z1+t59LWgd+
 IUzORACna5ZZivyiZw0eYQjvkijpp2us0C/9r8P+2jwCvI8oudpMj5ui4ar3jXa5v21DDzY/FcU
 pGq+RdDPNXNcOva97QjiVzMAQsRkki+4+PtPXk5RiGp8GgS7KjyZQAfltBZdS+ZWxmREo4HmYwD
 3zWrwdFKCdWc8JPvFy1s1v41r+p5p4CkzoyICg/Kfn+9H8qvq+jpunexNJH+keQXJgeRtni9CZT
 YL2TrggRhwi6AkRpmGZSZiK9igdGH5EIb29Vwi5TMBCDLaFi/oZqwYaLeMdbji4JMi6iiGigMph
 hsYLRkwk8ex7r3UoYSnvDxo977NDZpGw6huDuafDq2T6XPEyiGxuo2L4WxWqWD6ESHnClQi6Pz+
 hur3tgfY/Qke8CYFqMJ/h/dioaUQ9LZoyvZ4Q97ZnSpTpXnPhyAp4qT6lZQDKuZAxWt0fcBSvD9
 oIAJ4byrf5BB5Y1Tw9JkbU67t5RoL1SJ1skitClE=
X-Authority-Analysis: v=2.4 cv=O+w0fR9W c=1 sm=1 tr=0 ts=6992f07b b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=IpJZQVW2AAAA:8 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8
 a=lsRt6yUIgdeWpme2pw8A:9 a=IawgGOuG5U0WyFbmm1f5:22 a=zq9cQQxCjHtRaWh5T9cX:22
 cc=ntf awl=host:12148
X-Proofpoint-GUID: EGXUYyRB6KN1bmsmE-UMvE7jH_M53x8N
X-Proofpoint-ORIG-GUID: EGXUYyRB6KN1bmsmE-UMvE7jH_M53x8N

Refactor each sca3000 variant with it's own chip_info struct, update the
sca3000_probe() to use spi_get_device_match_data().

Suggested-by: David Lechner <dlechner@baylibre.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
Only compile tested.

v1->v2: Andy suggested we drop a NULL check on
spi_get_device_match_data() failure. Also added Andy's RB.
---
 drivers/iio/accel/sca3000.c | 127 +++++++++++++++++-------------------
 1 file changed, 59 insertions(+), 68 deletions(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index d4c117f54a07..eeb313056259 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -172,6 +172,7 @@ struct sca3000_state {
 
 /**
  * struct sca3000_chip_info - model dependent parameters
+ * @name:			name of the chip
  * @scale:			scale * 10^-6
  * @temp_output:		some devices have temperature sensors.
  * @measurement_mode_freq:	normal mode sampling frequency
@@ -194,6 +195,7 @@ struct sca3000_state {
  * sca3000 variant.
  **/
 struct sca3000_chip_info {
+	const char		*name;
 	unsigned int		scale;
 	bool			temp_output;
 	int			measurement_mode_freq;
@@ -208,69 +210,59 @@ struct sca3000_chip_info {
 	int			mot_det_mult_y[7];
 };
 
-enum sca3000_variant {
-	d01,
-	e02,
-	e04,
-	e05,
+static const struct sca3000_chip_info sca3000_chip_info_d01 = {
+	.name = "sca3000_d01",
+	.scale = 7357,
+	.temp_output = true,
+	.measurement_mode_freq = 250,
+	.measurement_mode_3db_freq = 45,
+	.option_mode_1 = SCA3000_OP_MODE_BYPASS,
+	.option_mode_1_freq = 250,
+	.option_mode_1_3db_freq = 70,
+	.mot_det_mult_xz = {50, 100, 200, 350, 650, 1300},
+	.mot_det_mult_y = {50, 100, 150, 250, 450, 850, 1750},
 };
 
-/*
- * Note where option modes are not defined, the chip simply does not
- * support any.
- * Other chips in the sca3000 series use i2c and are not included here.
- *
- * Some of these devices are only listed in the family data sheet and
- * do not actually appear to be available.
- */
-static const struct sca3000_chip_info sca3000_spi_chip_info_tbl[] = {
-	[d01] = {
-		.scale = 7357,
-		.temp_output = true,
-		.measurement_mode_freq = 250,
-		.measurement_mode_3db_freq = 45,
-		.option_mode_1 = SCA3000_OP_MODE_BYPASS,
-		.option_mode_1_freq = 250,
-		.option_mode_1_3db_freq = 70,
-		.mot_det_mult_xz = {50, 100, 200, 350, 650, 1300},
-		.mot_det_mult_y = {50, 100, 150, 250, 450, 850, 1750},
-	},
-	[e02] = {
-		.scale = 9810,
-		.measurement_mode_freq = 125,
-		.measurement_mode_3db_freq = 40,
-		.option_mode_1 = SCA3000_OP_MODE_NARROW,
-		.option_mode_1_freq = 63,
-		.option_mode_1_3db_freq = 11,
-		.mot_det_mult_xz = {100, 150, 300, 550, 1050, 2050},
-		.mot_det_mult_y = {50, 100, 200, 350, 700, 1350, 2700},
-	},
-	[e04] = {
-		.scale = 19620,
-		.measurement_mode_freq = 100,
-		.measurement_mode_3db_freq = 38,
-		.option_mode_1 = SCA3000_OP_MODE_NARROW,
-		.option_mode_1_freq = 50,
-		.option_mode_1_3db_freq = 9,
-		.option_mode_2 = SCA3000_OP_MODE_WIDE,
-		.option_mode_2_freq = 400,
-		.option_mode_2_3db_freq = 70,
-		.mot_det_mult_xz = {200, 300, 600, 1100, 2100, 4100},
-		.mot_det_mult_y = {100, 200, 400, 7000, 1400, 2700, 54000},
-	},
-	[e05] = {
-		.scale = 61313,
-		.measurement_mode_freq = 200,
-		.measurement_mode_3db_freq = 60,
-		.option_mode_1 = SCA3000_OP_MODE_NARROW,
-		.option_mode_1_freq = 50,
-		.option_mode_1_3db_freq = 9,
-		.option_mode_2 = SCA3000_OP_MODE_WIDE,
-		.option_mode_2_freq = 400,
-		.option_mode_2_3db_freq = 75,
-		.mot_det_mult_xz = {600, 900, 1700, 3200, 6100, 11900},
-		.mot_det_mult_y = {300, 600, 1200, 2000, 4100, 7800, 15600},
-	},
+static const struct sca3000_chip_info sca3000_chip_info_e02 = {
+	.name = "sca3000_e02",
+	.scale = 9810,
+	.measurement_mode_freq = 125,
+	.measurement_mode_3db_freq = 40,
+	.option_mode_1 = SCA3000_OP_MODE_NARROW,
+	.option_mode_1_freq = 63,
+	.option_mode_1_3db_freq = 11,
+	.mot_det_mult_xz = {100, 150, 300, 550, 1050, 2050},
+	.mot_det_mult_y = {50, 100, 200, 350, 700, 1350, 2700},
+};
+
+static const struct sca3000_chip_info sca3000_chip_info_e04 = {
+	.name = "sca3000_e04",
+	.scale = 19620,
+	.measurement_mode_freq = 100,
+	.measurement_mode_3db_freq = 38,
+	.option_mode_1 = SCA3000_OP_MODE_NARROW,
+	.option_mode_1_freq = 50,
+	.option_mode_1_3db_freq = 9,
+	.option_mode_2 = SCA3000_OP_MODE_WIDE,
+	.option_mode_2_freq = 400,
+	.option_mode_2_3db_freq = 70,
+	.mot_det_mult_xz = {200, 300, 600, 1100, 2100, 4100},
+	.mot_det_mult_y = {100, 200, 400, 7000, 1400, 2700, 54000},
+};
+
+static const struct sca3000_chip_info sca3000_chip_info_e05 = {
+	.name = "sca3000_e05",
+	.scale = 61313,
+	.measurement_mode_freq = 200,
+	.measurement_mode_3db_freq = 60,
+	.option_mode_1 = SCA3000_OP_MODE_NARROW,
+	.option_mode_1_freq = 50,
+	.option_mode_1_3db_freq = 9,
+	.option_mode_2 = SCA3000_OP_MODE_WIDE,
+	.option_mode_2_freq = 400,
+	.option_mode_2_3db_freq = 75,
+	.mot_det_mult_xz = {600, 900, 1700, 3200, 6100, 11900},
+	.mot_det_mult_y = {300, 600, 1200, 2000, 4100, 7800, 15600},
 };
 
 static int sca3000_write_reg(struct sca3000_state *st, u8 address, u8 val)
@@ -1469,10 +1461,9 @@ static int sca3000_probe(struct spi_device *spi)
 	st = iio_priv(indio_dev);
 	st->us = spi;
 	mutex_init(&st->lock);
-	st->info = &sca3000_spi_chip_info_tbl[spi_get_device_id(spi)
-					      ->driver_data];
+	st->info = spi_get_device_match_data(spi);
 
-	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->name = st->info->name;
 	indio_dev->info = &sca3000_info;
 	if (st->info->temp_output) {
 		indio_dev->channels = sca3000_channels_with_temp;
@@ -1513,10 +1504,10 @@ static int sca3000_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id sca3000_id[] = {
-	{"sca3000_d01", d01},
-	{"sca3000_e02", e02},
-	{"sca3000_e04", e04},
-	{"sca3000_e05", e05},
+	{"sca3000_d01", (kernel_ulong_t)&sca3000_chip_info_d01},
+	{"sca3000_e02", (kernel_ulong_t)&sca3000_chip_info_e02},
+	{"sca3000_e04", (kernel_ulong_t)&sca3000_chip_info_e04},
+	{"sca3000_e05", (kernel_ulong_t)&sca3000_chip_info_e05},
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, sca3000_id);
-- 
2.50.1

