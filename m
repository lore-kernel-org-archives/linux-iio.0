Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54273B52E9;
	Fri,  3 Jul 2026 10:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783073465; cv=none; b=l2cIMpK/gc/44qg5uQVY/QcqzslmaO2qtr8p5tRNFJYm1t/Ik2/Rd6pQ2hPxEdrWEOSpdypomZtpq4TMIWYY8RFR+CKIT+nkLUPRd2L7FacmMOqPxCy/5hZS6j2LmDEz0vEunRHJghwK8xIgoEbvXEEAX7kQtcCYws/50G6AGh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783073465; c=relaxed/simple;
	bh=y7OUyc466rnbOPh8YNl/5C3aSoa1ZjzAo7GOKmYV6o8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=PnRN/mifl6U3Vkju6axa3KoPGuR8GPemmICIsnsV/KQom53bR1hTq6PqwSZHmlq51Jehzo3HRTmiWEBmLoUjBaSvM7MgnzCaM9Dlb+GgzEvH71+t/zYNVuJSZ1yRdtNAnNdvDOUG3PbT5dM0rpNQ40uoBVtg8i5bHtVyzMMBumI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=uFfZ1K5n; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="uFfZ1K5n"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6635vnM7228931;
	Fri, 3 Jul 2026 06:10:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=XO8n1
	a1F9TK7XNoaKth8CAdvUU9aFxddL5D8pM/l2UE=; b=uFfZ1K5nJH/MWcwgZHXUs
	sY//X3yui3Que1PPG8xatR1PjDBOSU7qZdSxgxJAuHvFZZfGND6x/6G8WdCQqswn
	FuaIbhkK7pv5T9Z15CbaA07Lj9EBmGO+rLyJgFtrYPullvH4XRVVWbDSBwFtFtG+
	AUS85sYJN175mWW19ZSbZfUkV5eb+JKk+cQ6Tx7abgNTlzcL2Um2EYowPHWBxmXa
	IOxicrGX9PxwTo2SEDvH3GSoEXwz0m8aSQpYNRB3WyjJyF5FkrFutW48iRgZYC3W
	oIl19AmeJi4YxSwEIwNLz6SMczHdtHYj0OlPLlR0eH3fHIoPDteFDq6M57qd6e16
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4f65ckhe06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 06:10:59 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 663AAw4F011030
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 3 Jul 2026 06:10:58 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 3 Jul
 2026 06:10:57 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 3 Jul 2026 06:10:57 -0400
Received: from analog.ad.analog.com ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 663AAOlJ024695;
	Fri, 3 Jul 2026 06:10:50 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Fri, 3 Jul 2026 18:10:10 +0800
Subject: [PATCH v4 5/6] iio: dac: ad3530r: Make regmap_config selectable
 per chip
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260703-iio-ad3532r-support-v4-5-69d9a336f4e8@analog.com>
References: <20260703-iio-ad3532r-support-v4-0-69d9a336f4e8@analog.com>
In-Reply-To: <20260703-iio-ad3532r-support-v4-0-69d9a336f4e8@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy
 Shevchenko <andy@kernel.org>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux@analog.com>, <devicetree@vger.kernel.org>,
        Kim Seer Paller
	<kimseer.paller@analog.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783073424; l=3796;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=y7OUyc466rnbOPh8YNl/5C3aSoa1ZjzAo7GOKmYV6o8=;
 b=qmzOcXttxGoBjTVcUNC8alPLi6sgNr77EtGWSjv6l6ugsFR1jQAuBtKpYaGDBu+1NrftLR0JP
 VkH5r/Mzi5QAyS0DJQpHUZbxXkEFfpgVpSBirzCeiacYvVxzO7nDCn/
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: tGvpFfv2NRHSP0ZfDudW2LL6jZIhUTfa
X-Proofpoint-ORIG-GUID: tGvpFfv2NRHSP0ZfDudW2LL6jZIhUTfa
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA5OCBTYWx0ZWRfX99/yRE7cFdG/
 gNSE7R5R9DcCt1QVOnq6LaQDUGfqzl2hyNQ8mIEDueRfdxMPwj2iQGqug33lG27/eUEtOAExNNo
 uqNNxpA/45IneXlde8J/HIVeRKi+fSUwHYopY/gH3JkPwLJ6gj4O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA5OCBTYWx0ZWRfX6bDtnSGUbCvn
 vloA+uq4heO21wAToWRf+Pl/CSbbidYo6J5eCxpicixIogY2orw20i1Q5wXZvfJHym852rZussR
 qr0pDAZ+HCHkwrng1gRKWlXxGnW7CV9x7lUxea/kwXUsoXKXGfRvf/3M3kgNKK9/MGyfqw8wD0O
 /hnnMYgKyYnHO6Xcsn+3usXrtbo+uJylosZGK7PCdRlGyIXxtcsv4Ry1rx6W5Po7cA+2lsPH932
 RaDicCrQ+XGYCCMlQXL7LdF0yTnpHjOAjggGdzA4iFs1qz7k4SLOhnVp+Vso5iKdZyugUitUVL8
 xUZe+65+qJ+Tgu+T0mRvyhuOIegG3FTBmEMAJAi2nrxHp1hdSbWAjz6g/1NDSNqM+P8JMBefRy4
 b6XGbyna3gDODBqT+J4hMQ8tH3XLKrymG5jiiBcg4o7Gr/8UNEVPOVEfYRIysoSAIis8Q3rogk/
 b5YYMzLJxsR5hMctnaw==
X-Authority-Analysis: v=2.4 cv=XoLK/1F9 c=1 sm=1 tr=0 ts=6a478ab3 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8
 a=Bo8ZYxL833ZGXk9ZXiQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030098

Devices with a larger register map need their own regmap_config so
debugfs register access stays within each device's address range.

Move the config into the chip_info table and let probe pass the per-chip
config. All current devices share the same config, so no functional
change.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 drivers/iio/dac/ad3530r.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/dac/ad3530r.c b/drivers/iio/dac/ad3530r.c
index 42e77b150760..be63eb819c93 100644
--- a/drivers/iio/dac/ad3530r.c
+++ b/drivers/iio/dac/ad3530r.c
@@ -68,6 +68,7 @@ struct ad3530r_chan {
 struct ad3530r_chip_info {
 	const char *name;
 	const struct iio_chan_spec *channels;
+	const struct regmap_config *regmap_config;
 	int (*input_ch_reg)(unsigned int channel);
 	int (*sw_ldac_trig_reg)(unsigned int channel);
 	const unsigned int *interface_config_a;
@@ -368,9 +369,16 @@ static const unsigned int ad3531r_op_mode[] = {
 	AD3530R_OUTPUT_OPERATING_MODE_0,
 };
 
+static const struct regmap_config ad3530r_regmap_config = {
+	.reg_bits = 16,
+	.val_bits = 8,
+	.max_register = AD3530R_MAX_REG_ADDR,
+};
+
 static const struct ad3530r_chip_info ad3530_chip = {
 	.name = "ad3530",
 	.channels = ad3530r_channels,
+	.regmap_config = &ad3530r_regmap_config,
 	.num_channels = ARRAY_SIZE(ad3530r_channels),
 	.sw_ldac_trig_reg = ad3530r_trigger_sw_ldac_reg,
 	.input_ch_reg = ad3530r_input_ch_reg,
@@ -386,6 +394,7 @@ static const struct ad3530r_chip_info ad3530_chip = {
 static const struct ad3530r_chip_info ad3530r_chip = {
 	.name = "ad3530r",
 	.channels = ad3530r_channels,
+	.regmap_config = &ad3530r_regmap_config,
 	.num_channels = ARRAY_SIZE(ad3530r_channels),
 	.sw_ldac_trig_reg = ad3530r_trigger_sw_ldac_reg,
 	.input_ch_reg = ad3530r_input_ch_reg,
@@ -401,6 +410,7 @@ static const struct ad3530r_chip_info ad3530r_chip = {
 static const struct ad3530r_chip_info ad3531_chip = {
 	.name = "ad3531",
 	.channels = ad3531r_channels,
+	.regmap_config = &ad3530r_regmap_config,
 	.num_channels = ARRAY_SIZE(ad3531r_channels),
 	.sw_ldac_trig_reg = ad3531r_trigger_sw_ldac_reg,
 	.input_ch_reg = ad3531r_input_ch_reg,
@@ -416,6 +426,7 @@ static const struct ad3530r_chip_info ad3531_chip = {
 static const struct ad3530r_chip_info ad3531r_chip = {
 	.name = "ad3531r",
 	.channels = ad3531r_channels,
+	.regmap_config = &ad3530r_regmap_config,
 	.num_channels = ARRAY_SIZE(ad3531r_channels),
 	.sw_ldac_trig_reg = ad3531r_trigger_sw_ldac_reg,
 	.input_ch_reg = ad3531r_input_ch_reg,
@@ -533,12 +544,6 @@ static int ad3530r_setup(struct ad3530r_state *st, int external_vref_uV)
 	return 0;
 }
 
-static const struct regmap_config ad3530r_regmap_config = {
-	.reg_bits = 16,
-	.val_bits = 8,
-	.max_register = AD3530R_MAX_REG_ADDR,
-};
-
 static const struct iio_info ad3530r_info = {
 	.read_raw = ad3530r_read_raw,
 	.write_raw = ad3530r_write_raw,
@@ -559,7 +564,11 @@ static int ad3530r_probe(struct spi_device *spi)
 
 	st = iio_priv(indio_dev);
 
-	st->regmap = devm_regmap_init_spi(spi, &ad3530r_regmap_config);
+	st->chip_info = spi_get_device_match_data(spi);
+	if (!st->chip_info)
+		return -ENODEV;
+
+	st->regmap = devm_regmap_init_spi(spi, st->chip_info->regmap_config);
 	if (IS_ERR(st->regmap))
 		return dev_err_probe(dev, PTR_ERR(st->regmap),
 				     "Failed to init regmap");
@@ -568,10 +577,6 @@ static int ad3530r_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	st->chip_info = spi_get_device_match_data(spi);
-	if (!st->chip_info)
-		return -ENODEV;
-
 	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulators),
 					     regulators);
 	if (ret)

-- 
2.34.1

