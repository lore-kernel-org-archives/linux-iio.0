Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4983C37C0FB
	for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 18:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788202033; cv=none; b=u7ATvrMnUptvup/4bvq7Z9D6n/3w6KS/CHTTjyoQ27sPalyNDofJ0pHS6f8OonyaPLqPyewoqmP35TDjhU9jmkJLhrEBH9CeeSNue14uTmoi8Vd6Wq/6iG97MMV2T2bJp1kRobToAD03+fg6TUHpvMshF5gz0CgFsTNxwCF7wIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788202033; c=relaxed/simple;
	bh=0YlE6cJLfILSdZce+43bxbJ0SE8HpVovxfqoxR7adec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O77YKZMxXv9fVIqqo1iZaJbQ4vZknvdTqtsCSMKo0IJiiiP0v7BdlzxNYFtX78a3IocV3wcreBrfnth55u9rof6jtwdSLG5U+fHQTPFv6FzwWUhfBUBrmzGHfRPgpoXbVO0nXDLVgkxROoyghkue+8d2N+caFXOUd/wW2PjyQuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGvZLHaX; arc=none smtp.client-ip=74.125.227.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGvZLHaX"
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-398b9f722abso708522a91.0
        for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 11:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788202030; x=1788806830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lWHgwZjI8PJHAdOh0hOZPcNPrnvuZLiyr/mlCNOBOjU=;
        b=SGvZLHaX5DNZzM522kKdlxEUeQvDIoBHpMF7W5D0oYeZL1mMvHLYpy0sCWoVNrpHo+
         blKxBTu0qN2FhQLu30whRxeJsXipOKmsDD+v7vT3bXYa+qj9WmbiJL/Rxi/T3iNjJjU9
         21V/SLuL8Dz46uYqSSaj/DO6swSvAx+7IexnLAm9qnP0x+aFm6ZuvRt3TP0xHvbjJN6o
         bwpF42XzND0dTNdTAb9ZTHPuWOwRNN5jFt9BBex2f/UsyeJktLNa36L/vlqgNxsp8xkt
         7vvBupExfvgbBHOXPVZP+PTrlLgp65GVFaki5mgB4cuXR2xKEmgDEDbli0ROftjVO27K
         Ia0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788202030; x=1788806830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lWHgwZjI8PJHAdOh0hOZPcNPrnvuZLiyr/mlCNOBOjU=;
        b=EUpOTj4CDsY8+iusxmMzglKLZSUCk9JHYyg8TzO+gDGvAKO1f+Pdd9wYkO8GAzW3pU
         6n6Ij22B2iNzSPPyuPKxpyC2b9qJYpUosQEeYz0CH4fUdXQY3HWgXuozhPDY8avkDE/x
         XKVj8TV47sDeAbckkrG+RqwlelM6Q0qREWmveclNpOFMhRSDWC1+IIlH98IVSEL/9W4V
         PVlpwJmV8ScrJBzCnVpuruJpn/bSeqYQgAGM1btvEFYbSjd4tRKF/j33z9gwQumPF9aN
         OfY36S4cQk0g6v1fpAbqdU1QMD2czOeNgQsVcYfovL0oIJdOwfOwAcGGuxEIPJfd4zMn
         LiJA==
X-Forwarded-Encrypted: i=1; AKwUvBzmytlLF+tZWgOf/nujQ2R7+XemfvMmSDQNgcbX17OaU7jgs9FDrGGObdPPuTVfxtY0DosgCbbBBqc=@vger.kernel.org
X-Gm-Message-State: AFuF++lOiXd31/zLHlooq4+BsDqNNIWvXtSfhb72BSBCQAE+XK3iGIYC
	U/QKZjrBJatjG+JANUtHqfAxmK8lVqnvnQF4VQo9M3UEDBHFJDMR8DHY
X-Gm-Gg: AYBFou3rZ9JFoeKWvoe56Sv7fm6q3nn1aWT3q5DNW0U6G2nt9tIjncVIcGZVt/FCv6A
	IsE+XvNWgGu2dD/AoTsFt5N3lZTZAcIbphSRXNcPXMST3Y+IgewlXU9oYURPgVY5eNL1orYR6Cf
	D8Kgq2KjYkK62hqGE5jGkBsTncHOebaI/ulHP4i9tGBVlq3WbzrZXqEzCRLbnRDFwhId6uGKNfg
	izv+52F6gZuc2RshliTHz5AgIzBMfRcVHIP78BSdsCPLaQVB3cbYLPvPK5sTtjZaxAOG+/epii6
	Mh7P2kJmAVYB2L5JbaVsqPNTNyLKTQGSVFym5mtw77FOFJclfoKSdVFfng0k8vltgAINQoVkM9d
	8SX3IBEtdH/tFF8AYf2DEqbTp0iLTIjxmccswo8Vr3hmgUeI0dIsJg9x/DTEP02usRV+/L49yrM
	J5SgYs6+OTRbBGwMWBNFO83iAehUglZvSGNFF71pyhgbayxlCUuLYe1N1bNiYXRRrfS+15mi+91
	LYE++WS
X-Received: by 2002:a17:90a:a81:b0:398:d6f4:c61a with SMTP id 98e67ed59e1d1-398d6f4c86dmr12291951a91.17.1788202030379;
        Mon, 31 Aug 2026 11:47:10 -0700 (PDT)
Received: from DESKTOP-M0MLFVC.localdomain ([165.99.41.159])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0dc854dsm29459223c88.10.2026.08.31.11.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 11:47:09 -0700 (PDT)
From: Shehryar Ahmad <shehryar.amd@gmail.com>
To: jic23@kernel.org
Cc: nuno.sa@analog.com,
	Michael.Hennerich@analog.com,
	dlechner@baylibre.com,
	andy@kernel.org,
	gregkh@linuxfoundation.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	devicetree@vger.kernel.org,
	marcelo.schmitt1@gmail.com,
	danascape@gmail.com,
	Shehryar Ahmad <shehryar.amd@gmail.com>
Subject: [PATCH 1/3] iio: accel: adis16201: merge adis16203 support from staging
Date: Mon, 31 Aug 2026 23:41:59 +0500
Message-ID: <20260831184201.34416-2-shehryar.amd@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831184201.34416-1-shehryar.amd@gmail.com>
References: <20260831184201.34416-1-shehryar.amd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Merge the ADIS16203 360 degree inclinometer driver from staging to
mainline ADIS16201 driver. Register addresses and external SPI interface
are identical between both. Some things that differ like write mask, and
calibbias bit width are handled by per chip struct differ_info, handled
by of_device_id match data in probe, following the same pattern used in
adis16475 which selects per-chip data directly via of_device_id.data and
spi_get_device_match_data(), adis16480 does similar but via a different
mechanism (index into an array via the SPI ID table).

Channels arrays are kept separate to avoid dropping const and kmemdup
would be extra failure point if memory allocation fails and is memory
inefficient.

GENMASK is still same instead of range check to keep adis16201 behaviour
unchanged

Signed-off-by: Shehryar Ahmad <shehryar.amd@gmail.com>
---
 drivers/iio/accel/adis16201.c | 289 ++++++++++++++++++++--------------
 1 file changed, 174 insertions(+), 115 deletions(-)

diff --git a/drivers/iio/accel/adis16201.c b/drivers/iio/accel/adis16201.c
index ba0f97944..ee8efeed2 100644
--- a/drivers/iio/accel/adis16201.c
+++ b/drivers/iio/accel/adis16201.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * ADIS16201 Dual-Axis Digital Inclinometer and Accelerometer
+ * Analog Devices ADIS16201 Inclinometer/Accelerometer and ADIS16203 Inclinometer Driver
  *
  * Copyright 2010 Analog Devices Inc.
  */
@@ -13,93 +13,187 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/imu/adis.h>
 
-#define ADIS16201_STARTUP_DELAY_MS			220
-#define ADIS16201_FLASH_CNT				0x00
+#define ADIS16201_STARTUP_DELAY_MS			        220
+#define ADIS16201_FLASH_CNT					        0x00
 
 /* Data Output Register Information */
-#define ADIS16201_SUPPLY_OUT_REG			0x02
-#define ADIS16201_XACCL_OUT_REG				0x04
-#define ADIS16201_YACCL_OUT_REG				0x06
-#define ADIS16201_AUX_ADC_REG				0x08
-#define ADIS16201_TEMP_OUT_REG				0x0A
-#define ADIS16201_XINCL_OUT_REG				0x0C
-#define ADIS16201_YINCL_OUT_REG				0x0E
+#define ADIS16201_SUPPLY_OUT_REG					0x02
+#define ADIS16201_XACCL_OUT_REG				        0x04
+#define ADIS16201_YACCL_OUT_REG				        0x06
+#define ADIS16201_AUX_ADC_REG				        0x08
+#define ADIS16201_TEMP_OUT_REG				        0x0A
+#define ADIS16201_INCL_OUT_REG		                0x0C
+#define ADIS16201_YINCL_OUT_REG				        0x0E
 
 /* Calibration Register Definition */
-#define ADIS16201_XACCL_OFFS_REG			0x10
-#define ADIS16201_YACCL_OFFS_REG			0x12
-#define ADIS16201_XACCL_SCALE_REG			0x14
-#define ADIS16201_YACCL_SCALE_REG			0x16
-#define ADIS16201_XINCL_OFFS_REG			0x18
-#define ADIS16201_YINCL_OFFS_REG			0x1A
-#define ADIS16201_XINCL_SCALE_REG			0x1C
-#define ADIS16201_YINCL_SCALE_REG			0x1E
+#define ADIS16201_XACCL_OFFS_REG			        0x10
+#define ADIS16201_YACCL_OFFS_REG			        0x12
+#define ADIS16201_XACCL_SCALE_REG			        0x14
+#define ADIS16201_YACCL_SCALE_REG			        0x16
+#define ADIS16201_INCL_OFFS_REG			            0x18
+#define ADIS16201_YINCL_OFFS_REG			        0x1A
+#define ADIS16201_XINCL_SCALE_REG			        0x1C
+#define ADIS16201_YINCL_SCALE_REG			        0x1E
 
 /* Alarm Register Definition */
-#define ADIS16201_ALM_MAG1_REG				0x20
-#define ADIS16201_ALM_MAG2_REG				0x22
-#define ADIS16201_ALM_SMPL1_REG				0x24
-#define ADIS16201_ALM_SMPL2_REG				0x26
-#define ADIS16201_ALM_CTRL_REG				0x28
-
-#define ADIS16201_AUX_DAC_REG				0x30
-#define ADIS16201_GPIO_CTRL_REG				0x32
-#define ADIS16201_SMPL_PRD_REG				0x36
+#define ADIS16201_ALM_MAG1_REG				        0x20
+#define ADIS16201_ALM_MAG2_REG				        0x22
+#define ADIS16201_ALM_SMPL1_REG				        0x24
+#define ADIS16201_ALM_SMPL2_REG				        0x26
+#define ADIS16201_ALM_CTRL_REG				        0x28
+
+#define ADIS16201_AUX_DAC_REG						0x30
+#define ADIS16201_GPIO_CTRL_REG						0x32
+#define ADIS16201_SMPL_PRD_REG						0x36
+
 /* Operation, filter configuration */
-#define ADIS16201_AVG_CNT_REG				0x38
-#define ADIS16201_SLP_CNT_REG				0x3A
+#define ADIS16201_AVG_CNT_REG				        0x38
+#define ADIS16201_SLP_CNT_REG				        0x3A
 
 /* Miscellaneous Control Register Definition */
-#define ADIS16201_MSC_CTRL_REG				0x34
-#define  ADIS16201_MSC_CTRL_SELF_TEST_EN		BIT(8)
+#define  ADIS16201_MSC_CTRL_REG				        0x34
+#define  ADIS16201_MSC_CTRL_SELF_TEST_EN		    BIT(8)
 /* Data-ready enable: 1 = enabled, 0 = disabled */
-#define  ADIS16201_MSC_CTRL_DATA_RDY_EN			BIT(2)
+#define  ADIS16201_MSC_CTRL_DATA_RDY_EN			    BIT(2)
 /* Data-ready polarity: 1 = active high, 0 = active low */
 #define  ADIS16201_MSC_CTRL_ACTIVE_DATA_RDY_HIGH	BIT(1)
 /* Data-ready line selection: 1 = DIO1, 0 = DIO0 */
-#define  ADIS16201_MSC_CTRL_DATA_RDY_DIO1		BIT(0)
+#define  ADIS16201_MSC_CTRL_DATA_RDY_DIO1		    BIT(0)
 
 /* Diagnostics System Status Register Definition */
-#define ADIS16201_DIAG_STAT_REG				0x3C
-#define  ADIS16201_DIAG_STAT_ALARM2			BIT(9)
-#define  ADIS16201_DIAG_STAT_ALARM1			BIT(8)
-#define  ADIS16201_DIAG_STAT_SPI_FAIL_BIT		3
+#define  ADIS16201_DIAG_STAT_REG				    0x3C
+#define  ADIS16201_DIAG_STAT_ALARM2			        BIT(9)
+#define  ADIS16201_DIAG_STAT_ALARM1			        BIT(8)
+#define  ADIS16203_DIAG_STAT_SELFTEST_FAIL_BIT      5
+#define  ADIS16201_DIAG_STAT_SPI_FAIL_BIT			3
 #define  ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT		2
 /* Power supply above 3.625 V */
-#define  ADIS16201_DIAG_STAT_POWER_HIGH_BIT		1
+#define  ADIS16201_DIAG_STAT_POWER_HIGH_BIT		    1
 /* Power supply below 2.975 V */
-#define  ADIS16201_DIAG_STAT_POWER_LOW_BIT		0
+#define  ADIS16201_DIAG_STAT_POWER_LOW_BIT		    0
 
 /* System Command Register Definition */
-#define ADIS16201_GLOB_CMD_REG				0x3E
-#define  ADIS16201_GLOB_CMD_SW_RESET			BIT(7)
-#define  ADIS16201_GLOB_CMD_FACTORY_RESET		BIT(1)
+#define ADIS16201_GLOB_CMD_REG				        0x3E
+#define ADIS16201_GLOB_CMD_SW_RESET			        BIT(7)
+#define ADIS16203_GLOB_CMD_CLEAR_STAT               BIT(4)
+#define ADIS16201_GLOB_CMD_FACTORY_RESET		    BIT(1)
 
-#define ADIS16201_ERROR_ACTIVE				BIT(14)
+#define ADIS16201_ERROR_ACTIVE				        BIT(14)
 
 enum adis16201_scan {
-	ADIS16201_SCAN_ACC_X,
-	ADIS16201_SCAN_ACC_Y,
-	ADIS16201_SCAN_INCLI_X,
-	ADIS16201_SCAN_INCLI_Y,
 	ADIS16201_SCAN_SUPPLY,
-	ADIS16201_SCAN_AUX_ADC,
 	ADIS16201_SCAN_TEMP,
+	ADIS16201_SCAN_AUX_ADC,
+	ADIS16201_SCAN_INCLI,
+	ADIS16201_SCAN_INCLI_Y,
+	ADIS16201_SCAN_ACC_X,
+	ADIS16201_SCAN_ACC_Y,
 };
 
 static const u8 adis16201_addresses[] = {
 	[ADIS16201_SCAN_ACC_X] = ADIS16201_XACCL_OFFS_REG,
 	[ADIS16201_SCAN_ACC_Y] = ADIS16201_YACCL_OFFS_REG,
-	[ADIS16201_SCAN_INCLI_X] = ADIS16201_XINCL_OFFS_REG,
+	[ADIS16201_SCAN_INCLI] = ADIS16201_INCL_OFFS_REG,
 	[ADIS16201_SCAN_INCLI_Y] = ADIS16201_YINCL_OFFS_REG,
 };
 
+static const struct iio_chan_spec adis16201_channels[] = {
+	ADIS_SUPPLY_CHAN(ADIS16201_SUPPLY_OUT_REG, ADIS16201_SCAN_SUPPLY,
+	0, 12),
+	ADIS_TEMP_CHAN(ADIS16201_TEMP_OUT_REG, ADIS16201_SCAN_TEMP, 0, 12),
+	ADIS_ACCEL_CHAN(X, ADIS16201_XACCL_OUT_REG, ADIS16201_SCAN_ACC_X,
+		BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
+	ADIS_ACCEL_CHAN(Y, ADIS16201_YACCL_OUT_REG, ADIS16201_SCAN_ACC_Y,
+		BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
+	ADIS_AUX_ADC_CHAN(ADIS16201_AUX_ADC_REG, ADIS16201_SCAN_AUX_ADC, 0, 12),
+	ADIS_INCLI_CHAN(X, ADIS16201_INCL_OUT_REG, ADIS16201_SCAN_INCLI,
+	BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 12),
+	ADIS_INCLI_CHAN(Y, ADIS16201_YINCL_OUT_REG, ADIS16201_SCAN_INCLI_Y,
+		BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 12),
+	IIO_CHAN_SOFT_TIMESTAMP(7)
+};
+
+static const struct iio_chan_spec adis16203_channels[] = {
+	ADIS_SUPPLY_CHAN(ADIS16201_SUPPLY_OUT_REG, ADIS16201_SCAN_SUPPLY, 0, 12),
+	ADIS_AUX_ADC_CHAN(ADIS16201_AUX_ADC_REG, ADIS16201_SCAN_AUX_ADC, 0, 12),
+	ADIS_INCLI_CHAN(X, ADIS16201_INCL_OUT_REG, ADIS16201_SCAN_INCLI,
+		BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
+	ADIS_TEMP_CHAN(ADIS16201_TEMP_OUT_REG, ADIS16201_SCAN_TEMP, 0, 12),
+	IIO_CHAN_SOFT_TIMESTAMP(4)
+};
+
+struct differ_info {
+	u16 write_mask_incli;
+	unsigned int incli_scale_val2;
+	unsigned int read_bits_incli;
+	const struct iio_chan_spec *arr_chans;
+	u16 diag_stat_mask;
+	unsigned int num_chans;
+};
+
+static const struct differ_info adis16201_diff = {
+	.write_mask_incli = GENMASK(8, 0),
+	.incli_scale_val2 = 100000,
+	.read_bits_incli = 9,
+	.arr_chans = adis16201_channels,
+	.diag_stat_mask = BIT(ADIS16201_DIAG_STAT_SPI_FAIL_BIT) |
+		BIT(ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT) |
+		BIT(ADIS16201_DIAG_STAT_POWER_HIGH_BIT) |
+		BIT(ADIS16201_DIAG_STAT_POWER_LOW_BIT),
+	.num_chans = ARRAY_SIZE(adis16201_channels)
+};
+
+static const struct differ_info adis16203_diff = {
+	.write_mask_incli = GENMASK(13, 0),
+	.incli_scale_val2 = 25000,
+	.read_bits_incli = 14,
+	.arr_chans = adis16203_channels,
+	.diag_stat_mask = BIT(ADIS16203_DIAG_STAT_SELFTEST_FAIL_BIT) |
+		BIT(ADIS16201_DIAG_STAT_SPI_FAIL_BIT) |
+		BIT(ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT) |
+		BIT(ADIS16201_DIAG_STAT_POWER_HIGH_BIT) |
+		BIT(ADIS16201_DIAG_STAT_POWER_LOW_BIT),
+	.num_chans = ARRAY_SIZE(adis16203_channels)
+};
+
+struct adis16201_state {
+	struct adis adis;
+	const struct differ_info *info;
+};
+
+static int adis16201_write_raw(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       int val,
+			       int val2,
+			       long mask)
+{
+	struct adis16201_state *st = iio_priv(indio_dev);
+	int m;
+
+	if (mask != IIO_CHAN_INFO_CALIBBIAS)
+		return -EINVAL;
+
+	switch (chan->type) {
+	case IIO_ACCEL:
+		m = GENMASK(11, 0);
+		break;
+	case IIO_INCLI:
+		m = st->info->write_mask_incli;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return adis_write_reg_16(&st->adis, adis16201_addresses[chan->scan_index],
+				 val & m);
+}
+
 static int adis16201_read_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
-			      int *val, int *val2,
-			      long mask)
+			      int *val,
+			      int *val2, long mask)
 {
-	struct adis *st = iio_priv(indio_dev);
+	struct adis16201_state *st = iio_priv(indio_dev);
 	int ret;
 	int bits;
 	u8 addr;
@@ -126,6 +220,11 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
 			*val = -470;
 			*val2 = 0;
 			return IIO_VAL_INT_PLUS_MICRO;
+
+		case IIO_INCLI:
+			*val = 0;
+			*val2 = st->info->incli_scale_val2;
+			return IIO_VAL_INT_PLUS_MICRO;
 		case IIO_ACCEL:
 			/*
 			 * IIO base unit for sensitivity of accelerometer
@@ -135,10 +234,6 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
 			*val = 0;
 			*val2 = IIO_G_TO_M_S_2(462400);
 			return IIO_VAL_INT_PLUS_NANO;
-		case IIO_INCLI:
-			*val = 0;
-			*val2 = 100000;
-			return IIO_VAL_INT_PLUS_MICRO;
 		default:
 			return -EINVAL;
 		}
@@ -157,13 +252,13 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
 			bits = 12;
 			break;
 		case IIO_INCLI:
-			bits = 9;
+			bits = st->info->read_bits_incli;
 			break;
 		default:
 			return -EINVAL;
 		}
 		addr = adis16201_addresses[chan->scan_index];
-		ret = adis_read_reg_16(st, addr, &val16);
+		ret = adis_read_reg_16(&st->adis, addr, &val16);
 		if (ret)
 			return ret;
 
@@ -174,49 +269,6 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
-static int adis16201_write_raw(struct iio_dev *indio_dev,
-			       struct iio_chan_spec const *chan,
-			       int val,
-			       int val2,
-			       long mask)
-{
-	struct adis *st = iio_priv(indio_dev);
-	int m;
-
-	if (mask != IIO_CHAN_INFO_CALIBBIAS)
-		return -EINVAL;
-
-	switch (chan->type) {
-	case IIO_ACCEL:
-		m = GENMASK(11, 0);
-		break;
-	case IIO_INCLI:
-		m = GENMASK(8, 0);
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return adis_write_reg_16(st, adis16201_addresses[chan->scan_index],
-				 val & m);
-}
-
-static const struct iio_chan_spec adis16201_channels[] = {
-	ADIS_SUPPLY_CHAN(ADIS16201_SUPPLY_OUT_REG, ADIS16201_SCAN_SUPPLY, 0,
-			 12),
-	ADIS_TEMP_CHAN(ADIS16201_TEMP_OUT_REG, ADIS16201_SCAN_TEMP, 0, 12),
-	ADIS_ACCEL_CHAN(X, ADIS16201_XACCL_OUT_REG, ADIS16201_SCAN_ACC_X,
-			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
-	ADIS_ACCEL_CHAN(Y, ADIS16201_YACCL_OUT_REG, ADIS16201_SCAN_ACC_Y,
-			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
-	ADIS_AUX_ADC_CHAN(ADIS16201_AUX_ADC_REG, ADIS16201_SCAN_AUX_ADC, 0, 12),
-	ADIS_INCLI_CHAN(X, ADIS16201_XINCL_OUT_REG, ADIS16201_SCAN_INCLI_X,
-			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 12),
-	ADIS_INCLI_CHAN(Y, ADIS16201_YINCL_OUT_REG, ADIS16201_SCAN_INCLI_Y,
-			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 12),
-	IIO_CHAN_SOFT_TIMESTAMP(7)
-};
-
 static const struct iio_info adis16201_info = {
 	.read_raw = adis16201_read_raw,
 	.write_raw = adis16201_write_raw,
@@ -224,6 +276,7 @@ static const struct iio_info adis16201_info = {
 };
 
 static const char * const adis16201_status_error_msgs[] = {
+	[ADIS16203_DIAG_STAT_SELFTEST_FAIL_BIT] = "Self test failure",
 	[ADIS16201_DIAG_STAT_SPI_FAIL_BIT] = "SPI failure",
 	[ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT] = "Flash update failed",
 	[ADIS16201_DIAG_STAT_POWER_HIGH_BIT] = "Power supply above 3.625V",
@@ -248,56 +301,62 @@ static const struct adis_data adis16201_data = {
 	.timeouts = &adis16201_timeouts,
 
 	.status_error_msgs = adis16201_status_error_msgs,
-	.status_error_mask = BIT(ADIS16201_DIAG_STAT_SPI_FAIL_BIT) |
-		BIT(ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT) |
-		BIT(ADIS16201_DIAG_STAT_POWER_HIGH_BIT) |
-		BIT(ADIS16201_DIAG_STAT_POWER_LOW_BIT),
 };
 
 static int adis16201_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
-	struct adis *st;
+	struct adis16201_state *st;
+	struct adis_data data = adis16201_data;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(struct adis16201_state));
 	if (!indio_dev)
 		return -ENOMEM;
 
 	st = iio_priv(indio_dev);
+	st->info = spi_get_device_match_data(spi);
 
 	indio_dev->name = spi->dev.driver->name;
 	indio_dev->info = &adis16201_info;
-
-	indio_dev->channels = adis16201_channels;
-	indio_dev->num_channels = ARRAY_SIZE(adis16201_channels);
+	indio_dev->channels = st->info->arr_chans;
+	indio_dev->num_channels = st->info->num_chans;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = adis_init(st, indio_dev, spi, &adis16201_data);
+	data.status_error_mask = st->info->diag_stat_mask;
+	ret = adis_init(&st->adis, indio_dev, spi, &data);
 	if (ret)
 		return ret;
 
-	ret = devm_adis_setup_buffer_and_trigger(st, indio_dev, NULL);
+	ret = devm_adis_setup_buffer_and_trigger(&st->adis, indio_dev, NULL);
 	if (ret)
 		return ret;
 
-	ret = __adis_initial_startup(st);
+	ret = __adis_initial_startup(&st->adis);
 	if (ret)
 		return ret;
 
 	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
+static const struct of_device_id adis16201_of_match[] = {
+	{ .compatible = "adi,adis16201", .data = &adis16201_diff },
+	{ .compatible = "adi,adis16203", .data = &adis16203_diff },
+	{ }
+};
+
 static struct spi_driver adis16201_driver = {
 	.driver = {
-		.name = "adis16201",
+		.name = "adis16201_adis16203",
+		.of_match_table = adis16201_of_match,
 	},
 	.probe = adis16201_probe,
 };
 module_spi_driver(adis16201_driver);
 
 MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
-MODULE_DESCRIPTION("Analog Devices ADIS16201 Dual-Axis Digital Inclinometer and Accelerometer");
+MODULE_DESCRIPTION("Analog Devices ADIS16201 Inclinometer/Accelerometer and ADIS16203 Inclinometer Driver");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("spi:adis16201");
+MODULE_ALIAS("spi:adis16203");
 MODULE_IMPORT_NS("IIO_ADISLIB");
-- 
2.43.0

