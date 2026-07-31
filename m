Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39B13D79FB;
	Fri, 31 Jul 2026 08:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785486655; cv=none; b=pW+qbrDCAvS+RkMKvHHkBIkz1/ROE5uztunGdhbZ5NeBn/Nsmm6GON5e1CCI9yCZo3O//BZrWsfDFpapOrkX2XVix5G90njuFve8RKRr2KGnl2AFv7EYp270r4ZpOSSBRAQjqqRT0ntG17PZDgYbdS3gjsglWgsnbITBWloIDIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785486655; c=relaxed/simple;
	bh=0VvITTeunSEU6FCLG4ijPHfeaeaSvHajzzyBtcY6sRs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FZocl3ubRyELaEHafaKARMHjgXYh0sg9W0Vs1BSs3ssNdJlEkbjc2ez1vF12hiLwA4Iam6cwdjKbMyDBovDG35N9FIszw/apqmli9EiR+F/cUHTMg/aaf8/yBk8z8fqyY9zKwXUx5HjakimrHZPBE+ab+76+eaRTX7kv098Ky98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=oZEhuk1n; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="oZEhuk1n"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V7xZPK2896907;
	Fri, 31 Jul 2026 04:30:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=63ZkX
	592KKn9v//pOFBQ06ZojesSMW5WCSx2R34ED7M=; b=oZEhuk1nRV1tzP7BxEXnn
	zD+6zd1TiCz3gAwB+BYo9QrTgMfbCY02h5IVfr41z/P70Bnxdy/QpCK70g+cWQIW
	x8uVJt0u2TTget8TZRUfvinpF7hrTFikLY1mtY7wh/wYE5ZtI3Wxw6BK6jZQW0iX
	rOt/hOYVTY0UM/VrknmZnAYdLIQ3EDnj/miE091S1NoxUGHO3PsPdbygmYiqwi8x
	2gJy5nyMEE+WBV2Hb5Olf3WXe/BaZ9EYgAbJZjJ+SkRK1/UPYa15IsdDM9YQ5Pvu
	IoDwYdJsU+A1umY5PIuDBBSxJo/+XCner1MCNC9q9S+PTzjDZ1CyPtIPCDd6BqQ+
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fqag4kd2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 04:30:34 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66V8UXsh039897
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 31 Jul 2026 04:30:33 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 31 Jul
 2026 04:30:32 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 31 Jul 2026 04:30:32 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.148])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66V8UDN7026738;
	Fri, 31 Jul 2026 04:30:27 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah
 Khan <skhan@linuxfoundation.org>,
        Radu Sabau <radu.sabau@analog.com>,
        Marcelo
 Schmitt <marcelo.schmitt@analog.com>,
        Jorge Marques
	<jorge.marques@analog.com>,
        Salih Erim <salih.erim@amd.com>,
        Matti Vaittinen
	<mazziesaccount@gmail.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        <linux-iio@vger.kernel.org>, <linux@analog.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: [PATCH v2 1/4] iio: adc: ade9000: introduce chip_info structure
Date: Fri, 31 Jul 2026 11:29:47 +0300
Message-ID: <20260731082951.1228-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731082951.1228-1-antoniu.miclaus@analog.com>
References: <20260731082951.1228-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=V/tNF+ni c=1 sm=1 tr=0 ts=6a6c5d2a cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=Zyf-6xheGXU4bo_EAj4A:9
X-Proofpoint-GUID: VCE5jxiVnDK2FL-w2cCEbtRTRTTUqeBB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA2MCBTYWx0ZWRfX3iBvKTDR7yeh
 xbPvp9dC4h6oNpBwKuiB0nWK6cDZlpQQGOhuKe60QjUIP1PTDW0F5xhF92uuRw3dTJjW1kM04lQ
 GsdhX78i21YRSGsBbZvqbTda47GI+EVHfa1YuzY/bK+Z2irqzc3NVTeYnszsZXR0mhZW90D8/XF
 vuj2t1HpQ9J8TE1TtEP/Y/uHbAycMgxlzhP0Nae8uSBKrSsDgYavfK4HGWSqgqsmfx1XRRTDdW8
 qXod3HXT84KwlUDgmGWMunobrHInszzYmQcc+hSWnzCzrLSlD8K9BhMuJTZYK/kIDxpnCysNalw
 MU763uRtKDSG8lAPbVuB3LdYi/AUJkwEZgHGk6Szti6eoeJRg6sjEBkCM80BYQ9y6ePsXL1QCUP
 0NMERIg3Dm0JN3HDJCTkC1p9okQ8A/6ibUXkupb7UQEJvUSls5Unvw45DdRbwP3BU7Hg/n95GOK
 8EoE+z22YJPBikUZZ5A==
X-Proofpoint-ORIG-GUID: VCE5jxiVnDK2FL-w2cCEbtRTRTTUqeBB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA2MCBTYWx0ZWRfX+Nx6bFnGrok3
 sart7jNbakh4Xihee0NdpUKN8AKJIqd23aFAZKgXlznnLPXS1Kn3mQmY1nVocID6eMx/rJbkHQy
 YxkEAXfVgRASwjgUGQdxDc3nzA1KTOtga7JsFl5p8P97KkxlJFnP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310060

The driver currently hardcodes the device name and the full-scale ADC
codes used to derive the IIO scale attributes. In preparation for
supporting additional parts of the ADE9000 family, move these
part-specific values into a new struct ade9000_chip_info and retrieve it
via spi_get_device_match_data() at probe time.

The channel table and its size are also referenced through the chip_info
so that parts with a different channel layout can be added without
touching the probe path.

No functional change intended for the ADE9000.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v2:
- introduce the "respective datasheets" comment wording here to avoid
  churn in the ADE9078 patch.

 drivers/iio/adc/ade9000.c | 63 +++++++++++++++++++++++++++++----------
 1 file changed, 47 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
index c6c3ea953fea..030bb9109ab6 100644
--- a/drivers/iio/adc/ade9000.c
+++ b/drivers/iio/adc/ade9000.c
@@ -242,14 +242,6 @@
 #define ADE9000_LAST_PAGE_BIT		BIT(15)
 #define ADE9000_MIDDLE_PAGE_BIT		BIT(7)
 
-/*
- * Full scale Codes referred from Datasheet. Respective digital codes are
- * produced when ADC inputs are at full scale.
- */
-#define ADE9000_RMS_FULL_SCALE_CODES	52866837
-#define ADE9000_WATT_FULL_SCALE_CODES	20694066
-#define ADE9000_PCF_FULL_SCALE_CODES	74770000
-
 /* Phase and channel definitions */
 #define ADE9000_PHASE_A_NR		0
 #define ADE9000_PHASE_B_NR		1
@@ -290,7 +282,29 @@ enum ade9000_wfb_cfg {
 #define ADE9000_ADDR_ADJUST(addr, chan)					\
 	(((chan) == 0 ? 0 : (chan) == 1 ? 2 : 4) << 4 | (addr))
 
+/**
+ * struct ade9000_chip_info - part-specific configuration
+ * @name: IIO device name reported to userspace
+ * @channels: channel specification for this part
+ * @num_channels: number of entries in @channels
+ * @rms_full_scale_codes: digital code produced at full-scale RMS input
+ * @watt_full_scale_codes: digital code produced at full-scale power input
+ * @pcf_full_scale_codes: digital code produced at full-scale xI_PCF/xV_PCF input
+ *
+ * The full-scale codes are taken from the respective datasheets and are used to
+ * derive the IIO scale of the raw measurement channels.
+ */
+struct ade9000_chip_info {
+	const char *name;
+	const struct iio_chan_spec *channels;
+	unsigned int num_channels;
+	unsigned int rms_full_scale_codes;
+	unsigned int watt_full_scale_codes;
+	unsigned int pcf_full_scale_codes;
+};
+
 struct ade9000_state {
+	const struct ade9000_chip_info *info;
 	struct completion reset_completion;
 	struct mutex lock; /* Protects SPI transactions */
 	u8 wf_src;
@@ -623,6 +637,19 @@ static const struct iio_chan_spec ade9000_channels[] = {
 	ADE9000_POWER_FACTOR_CHANNEL(ADE9000_PHASE_C_NR),
 };
 
+/*
+ * Full-scale codes referred from the respective datasheets. These are the
+ * digital codes produced when the ADC inputs are at full scale.
+ */
+static const struct ade9000_chip_info ade9000_chip_info = {
+	.name = "ade9000",
+	.channels = ade9000_channels,
+	.num_channels = ARRAY_SIZE(ade9000_channels),
+	.rms_full_scale_codes = 52866837,
+	.watt_full_scale_codes = 20694066,
+	.pcf_full_scale_codes = 74770000,
+};
+
 static const struct reg_sequence ade9000_initialization_sequence[] = {
 	{ ADE9000_REG_PGA_GAIN, ADE9000_PGA_GAIN },
 	{ ADE9000_REG_CONFIG0, ADE9000_CONFIG0 },
@@ -1064,7 +1091,7 @@ static int ade9000_read_raw(struct iio_dev *indio_dev,
 			case ADE9000_REG_CI_PCF:
 			case ADE9000_REG_CV_PCF:
 				*val = 1;
-				*val2 = ADE9000_PCF_FULL_SCALE_CODES;
+				*val2 = st->info->pcf_full_scale_codes;
 				return IIO_VAL_FRACTIONAL;
 			case ADE9000_REG_AIRMS:
 			case ADE9000_REG_AVRMS:
@@ -1073,14 +1100,14 @@ static int ade9000_read_raw(struct iio_dev *indio_dev,
 			case ADE9000_REG_CIRMS:
 			case ADE9000_REG_CVRMS:
 				*val = 1;
-				*val2 = ADE9000_RMS_FULL_SCALE_CODES;
+				*val2 = st->info->rms_full_scale_codes;
 				return IIO_VAL_FRACTIONAL;
 			default:
 				return -EINVAL;
 			}
 		case IIO_POWER:
 			*val = 1;
-			*val2 = ADE9000_WATT_FULL_SCALE_CODES;
+			*val2 = st->info->watt_full_scale_codes;
 			return IIO_VAL_FRACTIONAL;
 		default:
 			break;
@@ -1692,6 +1719,10 @@ static int ade9000_probe(struct spi_device *spi)
 
 	st = iio_priv(indio_dev);
 
+	st->info = spi_get_device_match_data(spi);
+	if (!st->info)
+		return -ENODEV;
+
 	regmap = devm_regmap_init(dev, NULL, st, &ade9000_regmap_config);
 	if (IS_ERR(regmap))
 		return dev_err_probe(dev, PTR_ERR(regmap), "Unable to allocate ADE9000 regmap");
@@ -1726,7 +1757,7 @@ static int ade9000_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	indio_dev->name = "ade9000";
+	indio_dev->name = st->info->name;
 	indio_dev->info = &ade9000_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->setup_ops = &ade9000_buffer_ops;
@@ -1736,8 +1767,8 @@ static int ade9000_probe(struct spi_device *spi)
 		return dev_err_probe(&spi->dev, ret,
 				     "Failed to get and enable vdd regulator\n");
 
-	indio_dev->channels = ade9000_channels;
-	indio_dev->num_channels = ARRAY_SIZE(ade9000_channels);
+	indio_dev->channels = st->info->channels;
+	indio_dev->num_channels = st->info->num_channels;
 
 	ret = devm_iio_kfifo_buffer_setup(dev, indio_dev,
 					  &ade9000_buffer_ops);
@@ -1768,13 +1799,13 @@ static int ade9000_probe(struct spi_device *spi)
 };
 
 static const struct spi_device_id ade9000_id[] = {
-	{ .name = "ade9000" },
+	{ .name = "ade9000", .driver_data = (kernel_ulong_t)&ade9000_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ade9000_id);
 
 static const struct of_device_id ade9000_of_match[] = {
-	{ .compatible = "adi,ade9000" },
+	{ .compatible = "adi,ade9000", .data = &ade9000_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ade9000_of_match);
-- 
2.43.0

