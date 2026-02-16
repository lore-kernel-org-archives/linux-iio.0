Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9D31F2BAD;
	Mon, 16 Feb 2026 09:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771235495; cv=none; b=PX4G4hYLKRKAjF8/9JwR0UelahuzY8OHWnCiKv8POe/c3Pjc1t75ysr9F6V156z2EPgd9PkzwT935Txmyv8BIcSLIi/wzSShTZuIJ3QDGvRGmaYsU6vusDXMCu6BKSIdCeVBkpgUhypTcaqZmgjOvkJisEEbsHV7Ac2jpqM6hx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771235495; c=relaxed/simple;
	bh=D3v7/sXyD0jGBAqByjwaJDkuX8eMSK2kHPn117Mji44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MzfqTo/XaUhbA9LjPAPsDTIxkV5YiYxWiqm8KdPBXuGPY3TIioNiDNLHJmGVwGXHGEzPvhDyoCZlxkp8D/T4AfFlLlYsrdGPueW2FJNanbOZprqV+RLGD0YeMtGlCDu5f5vLJVXgibjfpmdkpsGeWMF/aIkbXpIiKSUqr0oIyw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ihGV0110; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ihGV0110"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61FNxfwd730281;
	Mon, 16 Feb 2026 09:51:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=8Jd7ztAgpZFaztKeAqo297ra9fHRo
	SgkJcdOPGyVxig=; b=ihGV0110BEShvSq3DWvLZIeUsXaUhamBnRChIgkNYZ83d
	n4GldE63XkcNKzSKt0idcY7b8xrrposS/h+5ArKzvp0ykDPFODrs3Q63Qqgfm3Pk
	TacawoGmdYGeyUQllntr1inHfQzEdhm7gikI6cHlMTYoziuAk2hLuerwFL5qTupe
	H5YZDy7aQjWPcmOXUHqYl5uBdLQgZ3U0CT2MyBdOyZ6usxjOwHQswP+9sjeto+8A
	W3Rq8ihr2rVNXUITz69LvAKvhbe0xLp8vrbTNluKDykL7WxhnCLjpq2z1BaMLL89
	b6PndcZ5AWRWknka/2YfrZI77a4p07isuPoQ5wpIA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4caj6m9tc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Feb 2026 09:51:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61G7R0lS029631;
	Mon, 16 Feb 2026 09:51:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cafgjfgdf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Feb 2026 09:51:15 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 61G9pEHA034713;
	Mon, 16 Feb 2026 09:51:14 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4cafgjfgcj-1;
	Mon, 16 Feb 2026 09:51:14 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Andrew Ijano <andrew.ijano@gmail.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH next] iio: sca3000: simplify with spi_get_device_match_data()
Date: Mon, 16 Feb 2026 01:51:05 -0800
Message-ID: <20260216095110.1062611-1-harshit.m.mogalapalli@oracle.com>
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
 definitions=2026-02-16_03,2026-02-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602160082
X-Proofpoint-GUID: VtgzPaGxJf08Z1BDrHdb9YJpLOy76pen
X-Proofpoint-ORIG-GUID: VtgzPaGxJf08Z1BDrHdb9YJpLOy76pen
X-Authority-Analysis: v=2.4 cv=JO82csKb c=1 sm=1 tr=0 ts=6992e894 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=IpJZQVW2AAAA:8 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8
 a=lsRt6yUIgdeWpme2pw8A:9 a=IawgGOuG5U0WyFbmm1f5:22 a=zq9cQQxCjHtRaWh5T9cX:22
 cc=ntf awl=host:12148
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDA4MiBTYWx0ZWRfX/Am8gd43BtFu
 QwCSPKrtT5K+mMvDFtz9zOxLHS8r5/UAt1+NyKGd3VTXiVm6VeodcRoEzebCIsqMO3CzE2it5P+
 OtQRv3TrWkpISVAWY9yTh43S7zkKgQjYxEOHGdxc3u902bDVsXDoZIcilP5S80Hy4osMHBfFttQ
 QYla+ooH86Xl/L0U8ZKQlxD4a6/IZBy9wYLHbQlB1o6eDhKncAiG476YXhke2yC9zGmaNyo0MAT
 bROqHTC7LOfbr17cxwI8kA+bKPT6Twvlzhjx5ojCkIXm+sM1ohHSFheMm90RCvSdyA1haSso79V
 y48A4Sx6qwvcvmtb/w/5EjM2fy4UnmEwxNPqh6K1+rVaGN/1rvk8+RrBPFRVBYFXWFL9vE3RiZI
 xshxVzHKon6Lqzgie513utvAKSJ0SOJ6FHsNK5j6si37qNm/HG2KH2Qimi8Ai7YrhwO2Ttc+t76
 YdBvPPpEUgEXVFoN7O8KLy8m68JQfMcAKNltk5Oc=

Refactor each sca3000 variant with it's own chip_info struct, update the
sca3000_probe() to use spi_get_device_match_data().

Suggested-by: David Lechner <dlechner@baylibre.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
Only compile tested.
---
 drivers/iio/accel/sca3000.c | 129 +++++++++++++++++-------------------
 1 file changed, 61 insertions(+), 68 deletions(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index d4c117f54a07..9d6ee83f48ae 100644
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
@@ -1469,10 +1461,11 @@ static int sca3000_probe(struct spi_device *spi)
 	st = iio_priv(indio_dev);
 	st->us = spi;
 	mutex_init(&st->lock);
-	st->info = &sca3000_spi_chip_info_tbl[spi_get_device_id(spi)
-					      ->driver_data];
+	st->info = spi_get_device_match_data(spi);
+	if (!st->info)
+		return -EINVAL;
 
-	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->name = st->info->name;
 	indio_dev->info = &sca3000_info;
 	if (st->info->temp_output) {
 		indio_dev->channels = sca3000_channels_with_temp;
@@ -1513,10 +1506,10 @@ static int sca3000_probe(struct spi_device *spi)
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

