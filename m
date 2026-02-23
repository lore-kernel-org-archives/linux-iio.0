Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2AC36680D;
	Mon, 23 Feb 2026 13:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771852493; cv=none; b=dNF/7y1l37LwvyILh4AvFew2FqLU7drz0d8YTTfB49WoXI1YUagjQkS2ErNYHVDzOIigpFIh2c8al5vn8OXCJbQCNFxSuYJ5w+6v5vUecAU2OG6BwYYuFd1T1lU48b1gnaG9fmvXTnuUWkhUjj/tkrC+9I8M/8yPp+KyS3iGaKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771852493; c=relaxed/simple;
	bh=Wfcw7h2HRxMJ3tUvGKVFqAlsgmbs4Z3t6y9mEavclcw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=miAzEiE4pHCGAhJzMNwKT8jYmgMQkETxCEdbD0qxtpOiG0hkT4U4c3xpglmEvfOZqpxD1nRQsWu2S65jPFAsVyoR9v+BondcCsD6fX9f4lN9W5Pkt94Lu2hIIMWjp638MoMJyJx16XvoWDYsx/4yCXHOGvm+tvWH+a8VP20q2wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=yZxKnMJ/; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="yZxKnMJ/"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NCkFXD1743403;
	Mon, 23 Feb 2026 08:14:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=W8KTF
	OozPbxLj2Q7nSU/Hh2MnTSqLb3qfKDpWFLdoJo=; b=yZxKnMJ/u92KLjxtbQ1E4
	LTp3zcKsY9/BF4e309DSkRK/+hPIuvQmZIQwmGXCNxc0Y2k2/7t/W9+3MMjqX+PB
	8ySgvm3kgN5F44AZP/M+uuiZIXKiPS0znKeZXHf1VW5kpAvfIk1vvaaRjLkQTwJ+
	MqUWJsm/y7EZxz3DZ3giE3vGjsCy/jMzqCArUZJTZjUd1hwnaR7liTGfK9h+grAX
	O6A2KvpfEL+MwtQ559uUzSNmHPYf/gWoJsJNeXg73Kk+klEnHUIKyBlYY/azongA
	kbuCXkQRKFeIC986rXbD11/bw1NJ0YQLNav8iLIuUoWwdvVAOvg1UnWxXFFBnaDf
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cg7p4k2wd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 08:14:37 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61NDEaLS009724
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 23 Feb 2026 08:14:36 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 23 Feb
 2026 08:14:36 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 23 Feb 2026 08:14:36 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61NDEMXX006594;
	Mon, 23 Feb 2026 08:14:30 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan
 Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 01/12] iio: frequency: adrf6780: introduce struct device variable
Date: Mon, 23 Feb 2026 15:13:52 +0200
Message-ID: <20260223131418.55414-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223131418.55414-1-antoniu.miclaus@analog.com>
References: <20260223131418.55414-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDExMyBTYWx0ZWRfX9TmG67M7mYRX
 cMeSE1SlKkxAdbZn0ScQlwDEXni0XVapcbAY07gH47gOGum0pAfB2z3cJhSQqnn583DJUKaj74M
 +fMS6UZImYBC/9ecJGYp4GfM4pwCcnnkW5QqNDhAVtv61e2V14gMoPlRHSJt6/E42SDcCQQMIgb
 lm9Bcims8mMB1bk0RO/gnSwXBQvDCSC6tzfRHNul4afKcmeWgd0LIhlFbN5vyNU86J6+sYiXA3U
 0KzVEqOzgFP2VPxWyYi82XZUz0Mpxdtw2IzF8n2jxH8Ii6O/Ih58E7GABCgkpoI8L4cZrEzsWaI
 /5ux8BO7bKeEyXC53vw22h35RvVdG7uQEragdhFprPMHAJGGQnW6mNjWT3xJLzZ4p5SQzTNAZ0u
 mDVbXzKmDta21s7rTERDYhk/fvqpovusuNoPKgB/eGifQZ1Qm3gKy3vkkDkNzsnV+HHXnrRgdtl
 B+QGdI/rTKq0ofLo2AQ==
X-Proofpoint-ORIG-GUID: GRwOeCJO2EcVg691PS8GesiCo7vs4O41
X-Authority-Analysis: v=2.4 cv=LfgxKzfi c=1 sm=1 tr=0 ts=699c52bd cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=hY51SqySecd9eNirzRkA:9
X-Proofpoint-GUID: GRwOeCJO2EcVg691PS8GesiCo7vs4O41
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_02,2026-02-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0 clxscore=1015
 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230113

Add struct device *dev local variable to simplify repeated &spi->dev
dereferences. Where spi is no longer needed beyond &spi->dev, replace
struct spi_device *spi with struct device *dev = &st->spi->dev.

No functional change.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/frequency/adrf6780.c | 45 ++++++++++++++++----------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/frequency/adrf6780.c b/drivers/iio/frequency/adrf6780.c
index a7a21f929970..918a7a511d09 100644
--- a/drivers/iio/frequency/adrf6780.c
+++ b/drivers/iio/frequency/adrf6780.c
@@ -346,13 +346,13 @@ static const struct iio_chan_spec adrf6780_channels[] = {
 static int adrf6780_reset(struct adrf6780_state *st)
 {
 	int ret;
-	struct spi_device *spi = st->spi;
+	struct device *dev = &st->spi->dev;
 
 	ret = __adrf6780_spi_update_bits(st, ADRF6780_REG_CONTROL,
 					 ADRF6780_SOFT_RESET_MSK,
 					 FIELD_PREP(ADRF6780_SOFT_RESET_MSK, 1));
 	if (ret) {
-		dev_err(&spi->dev, "ADRF6780 SPI software reset failed.\n");
+		dev_err(dev, "ADRF6780 SPI software reset failed.\n");
 		return ret;
 	}
 
@@ -360,7 +360,7 @@ static int adrf6780_reset(struct adrf6780_state *st)
 					 ADRF6780_SOFT_RESET_MSK,
 					 FIELD_PREP(ADRF6780_SOFT_RESET_MSK, 0));
 	if (ret) {
-		dev_err(&spi->dev, "ADRF6780 SPI software reset disable failed.\n");
+		dev_err(dev, "ADRF6780 SPI software reset disable failed.\n");
 		return ret;
 	}
 
@@ -371,7 +371,7 @@ static int adrf6780_init(struct adrf6780_state *st)
 {
 	int ret;
 	unsigned int chip_id, enable_reg, enable_reg_msk;
-	struct spi_device *spi = st->spi;
+	struct device *dev = &st->spi->dev;
 
 	/* Perform a software reset */
 	ret = adrf6780_reset(st);
@@ -384,7 +384,7 @@ static int adrf6780_init(struct adrf6780_state *st)
 
 	chip_id = FIELD_GET(ADRF6780_CHIP_ID_MSK, chip_id);
 	if (chip_id != ADRF6780_CHIP_ID) {
-		dev_err(&spi->dev, "ADRF6780 Invalid Chip ID.\n");
+		dev_err(dev, "ADRF6780 Invalid Chip ID.\n");
 		return -EINVAL;
 	}
 
@@ -426,18 +426,18 @@ static int adrf6780_init(struct adrf6780_state *st)
 
 static void adrf6780_properties_parse(struct adrf6780_state *st)
 {
-	struct spi_device *spi = st->spi;
-
-	st->vga_buff_en = device_property_read_bool(&spi->dev, "adi,vga-buff-en");
-	st->lo_buff_en = device_property_read_bool(&spi->dev, "adi,lo-buff-en");
-	st->if_mode_en = device_property_read_bool(&spi->dev, "adi,if-mode-en");
-	st->iq_mode_en = device_property_read_bool(&spi->dev, "adi,iq-mode-en");
-	st->lo_x2_en = device_property_read_bool(&spi->dev, "adi,lo-x2-en");
-	st->lo_ppf_en = device_property_read_bool(&spi->dev, "adi,lo-ppf-en");
-	st->lo_en = device_property_read_bool(&spi->dev, "adi,lo-en");
-	st->uc_bias_en = device_property_read_bool(&spi->dev, "adi,uc-bias-en");
-	st->lo_sideband = device_property_read_bool(&spi->dev, "adi,lo-sideband");
-	st->vdet_out_en = device_property_read_bool(&spi->dev, "adi,vdet-out-en");
+	struct device *dev = &st->spi->dev;
+
+	st->vga_buff_en = device_property_read_bool(dev, "adi,vga-buff-en");
+	st->lo_buff_en = device_property_read_bool(dev, "adi,lo-buff-en");
+	st->if_mode_en = device_property_read_bool(dev, "adi,if-mode-en");
+	st->iq_mode_en = device_property_read_bool(dev, "adi,iq-mode-en");
+	st->lo_x2_en = device_property_read_bool(dev, "adi,lo-x2-en");
+	st->lo_ppf_en = device_property_read_bool(dev, "adi,lo-ppf-en");
+	st->lo_en = device_property_read_bool(dev, "adi,lo-en");
+	st->uc_bias_en = device_property_read_bool(dev, "adi,uc-bias-en");
+	st->lo_sideband = device_property_read_bool(dev, "adi,lo-sideband");
+	st->vdet_out_en = device_property_read_bool(dev, "adi,vdet-out-en");
 }
 
 static void adrf6780_powerdown(void *data)
@@ -450,9 +450,10 @@ static int adrf6780_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
 	struct adrf6780_state *st;
+	struct device *dev = &spi->dev;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -467,9 +468,9 @@ static int adrf6780_probe(struct spi_device *spi)
 
 	adrf6780_properties_parse(st);
 
-	st->clkin = devm_clk_get_enabled(&spi->dev, "lo_in");
+	st->clkin = devm_clk_get_enabled(dev, "lo_in");
 	if (IS_ERR(st->clkin))
-		return dev_err_probe(&spi->dev, PTR_ERR(st->clkin),
+		return dev_err_probe(dev, PTR_ERR(st->clkin),
 				     "failed to get the LO input clock\n");
 
 	mutex_init(&st->lock);
@@ -478,11 +479,11 @@ static int adrf6780_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = devm_add_action_or_reset(&spi->dev, adrf6780_powerdown, st);
+	ret = devm_add_action_or_reset(dev, adrf6780_powerdown, st);
 	if (ret)
 		return ret;
 
-	return devm_iio_device_register(&spi->dev, indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static const struct spi_device_id adrf6780_id[] = {
-- 
2.43.0

