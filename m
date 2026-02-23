Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1932A350A3A;
	Mon, 23 Feb 2026 13:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771852500; cv=none; b=irRfBvC9vHQxZYwC9EsCTt2JjXIctx1PWNZkZr/UrxsCTO6BkZXFA11V/ashykIzopNSJg/8znWKdJ5OoHvemV3Z2UZ8Ra9cpC/6l+Ls39GGo6GjKSCwDP/ekWmHbzArYsL+rkG7l0sUYKgGC7y2fwD8+GpmaKefacy2PWRkftc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771852500; c=relaxed/simple;
	bh=zoRRQ2Y+uOTVBOcGOroJE1GMkC7URafjlCM95HMX7MQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cm8aagLBvcTOI2Onm5MJPeN4ebghyZ+gRP0nuxtsWuSjaJ0X5QUxYZDn7Dfh3hVLERXcCncn7RRM7syHEgn0Ieg1EIhJcJLC0Ov3VncHTrbm9VxpJ/7WjOTPhXz4ubW4bdOSZby+n/oZ6FIEKCJVvAhFqvXnQFhliPKVwwKEoWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=rDhAdCXk; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="rDhAdCXk"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61N80KUN818277;
	Mon, 23 Feb 2026 08:14:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Y/kEl
	OwJQuMO9xmSTzf9jfBYP+Ja0F98LNQ/0sYtOGs=; b=rDhAdCXkwMk7Myb+4Hqqx
	l89zxiusPIo3U+XfRS1D32gJdOZIAa6HK9T9eJIWOYrJAF1oamvdy/Tz+c1WTSYN
	RSsUHmaLKnLN9x24OxJPpX92dDR+CDF5pKf0e8/XZDQ/5/IDkyzkVqUL/FzDdEpB
	FEH7UzSzoQrv4mMuZkb/Rxo/Q+K9jacOitqPndYeUWOdYHG7z675pt2Ok+UbMAgt
	C5WYRjlY+vSucJL7akx4chgx9C4m5hE36zdR2dhcNLeCiPybP10Pp+Q0E77HHCSn
	5SRJezP+vjKkXbdfLF8eLcx8XCAfWU8L9+SkdatiwkywAZl2dBOLDGidjSDpsouw
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cg7p02y7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 08:14:43 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61NDEgZI009730
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 23 Feb 2026 08:14:42 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 23 Feb 2026 08:14:42 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 23 Feb 2026 08:14:42 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 23 Feb 2026 08:14:42 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61NDEMXZ006594;
	Mon, 23 Feb 2026 08:14:36 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "Jonathan Cameron" <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 03/12] iio: frequency: admv1014: introduce struct device variable
Date: Mon, 23 Feb 2026 15:13:54 +0200
Message-ID: <20260223131418.55414-4-antoniu.miclaus@analog.com>
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
X-Proofpoint-ORIG-GUID: B8fm6KfHYtjkPFfneOnmLBm75iBu9LPZ
X-Proofpoint-GUID: B8fm6KfHYtjkPFfneOnmLBm75iBu9LPZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDExMyBTYWx0ZWRfX9RNsj4/RVr2h
 pfEIcZx33ErcWbKpWcpPtoOT1lc8OFUJZbi4y7AB+vJqE/3Ac9pHvSe6cO0khTooK4LjvmgME/9
 tMOWpd9iPj9MAy5SNFU6xvUf9q47yL9Ve4nRonTvSJ889pQads7khYZ2pJNgI/qxPYMIXtby6LE
 uXm37EJEgF0Y8spLVR0k7TRV4n1gVZT+Y4/E0CJZkFNBs13j5OAjREY33gPP1bXM1P7vqEQPeOW
 Tp6Rt0rCrFOo9QK+UbQwMXrufoOOh1nlm8T+48KoUFbajHPmzoRv5laABQRvyUoVjlQY5j6t4Ac
 q6DSdx1IzYZgX4axzzD9nhQfoZ4kRIj9o2dW8ctHB3wm1Ky8KsEalidHmhk2nA1z+dudoG7HMZw
 Q5jBUFY9mvxlnPfG17+MYHMOPY3s+827Zfbw3MUOrf8tYl3CtWtUPUJNmUqq7UXXvWM9eYEtV+W
 Da/YmUkpiOqW+vURzdg==
X-Authority-Analysis: v=2.4 cv=Fq4IPmrq c=1 sm=1 tr=0 ts=699c52c3 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=WtxQy0Aqn4yjT93-wUwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_02,2026-02-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 impostorscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602230113

Add struct device *dev local variable to simplify repeated &spi->dev
dereferences. Where spi is no longer needed beyond &spi->dev, replace
struct spi_device *spi with struct device *dev = &st->spi->dev.

No functional change.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/frequency/admv1014.c | 49 ++++++++++++++++----------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/frequency/admv1014.c b/drivers/iio/frequency/admv1014.c
index 7a8f92ec80a2..ce1b40336e15 100644
--- a/drivers/iio/frequency/admv1014.c
+++ b/drivers/iio/frequency/admv1014.c
@@ -609,16 +609,16 @@ static void admv1014_powerdown(void *data)
 static int admv1014_init(struct admv1014_state *st)
 {
 	unsigned int chip_id, enable_reg, enable_reg_msk;
-	struct spi_device *spi = st->spi;
+	struct device *dev = &st->spi->dev;
 	int ret;
 
 	ret = regulator_bulk_enable(ADMV1014_NUM_REGULATORS, st->regulators);
 	if (ret) {
-		dev_err(&spi->dev, "Failed to enable regulators");
+		dev_err(dev, "Failed to enable regulators");
 		return ret;
 	}
 
-	ret = devm_add_action_or_reset(&spi->dev, admv1014_reg_disable, st->regulators);
+	ret = devm_add_action_or_reset(dev, admv1014_reg_disable, st->regulators);
 	if (ret)
 		return ret;
 
@@ -626,16 +626,16 @@ static int admv1014_init(struct admv1014_state *st)
 	if (ret)
 		return ret;
 
-	ret = devm_add_action_or_reset(&spi->dev, admv1014_clk_disable, st->clkin);
+	ret = devm_add_action_or_reset(dev, admv1014_clk_disable, st->clkin);
 	if (ret)
 		return ret;
 
 	st->nb.notifier_call = admv1014_freq_change;
-	ret = devm_clk_notifier_register(&spi->dev, st->clkin, &st->nb);
+	ret = devm_clk_notifier_register(dev, st->clkin, &st->nb);
 	if (ret)
 		return ret;
 
-	ret = devm_add_action_or_reset(&spi->dev, admv1014_powerdown, st);
+	ret = devm_add_action_or_reset(dev, admv1014_powerdown, st);
 	if (ret)
 		return ret;
 
@@ -644,7 +644,7 @@ static int admv1014_init(struct admv1014_state *st)
 					 ADMV1014_SPI_SOFT_RESET_MSK,
 					 FIELD_PREP(ADMV1014_SPI_SOFT_RESET_MSK, 1));
 	if (ret) {
-		dev_err(&spi->dev, "ADMV1014 SPI software reset failed.\n");
+		dev_err(dev, "ADMV1014 SPI software reset failed.\n");
 		return ret;
 	}
 
@@ -652,13 +652,13 @@ static int admv1014_init(struct admv1014_state *st)
 					 ADMV1014_SPI_SOFT_RESET_MSK,
 					 FIELD_PREP(ADMV1014_SPI_SOFT_RESET_MSK, 0));
 	if (ret) {
-		dev_err(&spi->dev, "ADMV1014 SPI software reset disable failed.\n");
+		dev_err(dev, "ADMV1014 SPI software reset disable failed.\n");
 		return ret;
 	}
 
 	ret = __admv1014_spi_write(st, ADMV1014_REG_VVA_TEMP_COMP, 0x727C);
 	if (ret) {
-		dev_err(&spi->dev, "Writing default Temperature Compensation value failed.\n");
+		dev_err(dev, "Writing default Temperature Compensation value failed.\n");
 		return ret;
 	}
 
@@ -668,7 +668,7 @@ static int admv1014_init(struct admv1014_state *st)
 
 	chip_id = FIELD_GET(ADMV1014_CHIP_ID_MSK, chip_id);
 	if (chip_id != ADMV1014_CHIP_ID) {
-		dev_err(&spi->dev, "Invalid Chip ID.\n");
+		dev_err(dev, "Invalid Chip ID.\n");
 		return -EINVAL;
 	}
 
@@ -677,19 +677,19 @@ static int admv1014_init(struct admv1014_state *st)
 					 FIELD_PREP(ADMV1014_QUAD_SE_MODE_MSK,
 						    st->quad_se_mode));
 	if (ret) {
-		dev_err(&spi->dev, "Writing Quad SE Mode failed.\n");
+		dev_err(dev, "Writing Quad SE Mode failed.\n");
 		return ret;
 	}
 
 	ret = admv1014_update_quad_filters(st);
 	if (ret) {
-		dev_err(&spi->dev, "Update Quad Filters failed.\n");
+		dev_err(dev, "Update Quad Filters failed.\n");
 		return ret;
 	}
 
 	ret = admv1014_update_vcm_settings(st);
 	if (ret) {
-		dev_err(&spi->dev, "Update VCM Settings failed.\n");
+		dev_err(dev, "Update VCM Settings failed.\n");
 		return ret;
 	}
 
@@ -711,14 +711,14 @@ static int admv1014_init(struct admv1014_state *st)
 static int admv1014_properties_parse(struct admv1014_state *st)
 {
 	unsigned int i;
-	struct spi_device *spi = st->spi;
+	struct device *dev = &st->spi->dev;
 	int ret;
 
-	st->det_en = device_property_read_bool(&spi->dev, "adi,detector-enable");
+	st->det_en = device_property_read_bool(dev, "adi,detector-enable");
 
-	st->p1db_comp = device_property_read_bool(&spi->dev, "adi,p1db-compensation-enable");
+	st->p1db_comp = device_property_read_bool(dev, "adi,p1db-compensation-enable");
 
-	ret = device_property_match_property_string(&spi->dev, "adi,input-mode",
+	ret = device_property_match_property_string(dev, "adi,input-mode",
 						    input_mode_names,
 						    ARRAY_SIZE(input_mode_names));
 	if (ret >= 0)
@@ -726,7 +726,7 @@ static int admv1014_properties_parse(struct admv1014_state *st)
 	else
 		st->input_mode = ADMV1014_IQ_MODE;
 
-	ret = device_property_match_property_string(&spi->dev, "adi,quad-se-mode",
+	ret = device_property_match_property_string(dev, "adi,quad-se-mode",
 						    quad_se_mode_names,
 						    ARRAY_SIZE(quad_se_mode_names));
 	if (ret >= 0)
@@ -737,16 +737,16 @@ static int admv1014_properties_parse(struct admv1014_state *st)
 	for (i = 0; i < ADMV1014_NUM_REGULATORS; ++i)
 		st->regulators[i].supply = admv1014_reg_name[i];
 
-	ret = devm_regulator_bulk_get(&st->spi->dev, ADMV1014_NUM_REGULATORS,
+	ret = devm_regulator_bulk_get(dev, ADMV1014_NUM_REGULATORS,
 				      st->regulators);
 	if (ret) {
-		dev_err(&spi->dev, "Failed to request regulators");
+		dev_err(dev, "Failed to request regulators");
 		return ret;
 	}
 
-	st->clkin = devm_clk_get(&spi->dev, "lo_in");
+	st->clkin = devm_clk_get(dev, "lo_in");
 	if (IS_ERR(st->clkin))
-		return dev_err_probe(&spi->dev, PTR_ERR(st->clkin),
+		return dev_err_probe(dev, PTR_ERR(st->clkin),
 				     "failed to get the LO input clock\n");
 
 	return 0;
@@ -756,9 +756,10 @@ static int admv1014_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
 	struct admv1014_state *st;
+	struct device *dev = &spi->dev;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -787,7 +788,7 @@ static int admv1014_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	return devm_iio_device_register(&spi->dev, indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static const struct spi_device_id admv1014_id[] = {
-- 
2.43.0

