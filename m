Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84182425CC0;
	Fri, 27 Feb 2026 14:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772200956; cv=none; b=FYYL5ZKi0xp16u+mvKyh55ls9Y4Gcx5V9Ml+z/1Rjduk1vf6oK9MWb0O6fXGRD/yW5egQrSXHiugUEB6oJ11Q+a2HPcl0sOAymBeGLCO/odJGIP/pBQ/5BzHqIrGypQJdrH0ltryLEHAx1I6E3y3bXAmXh/qTOPU9h7JBUcpYBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772200956; c=relaxed/simple;
	bh=v86xXTeVxTMvVGf1thyODtL1X0KlBxfFI3afYE0/HII=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HzcdmNEo8j1LUELxkHs0MewFGdNEVa6KUUM63tnmqbELHdFAZUckr1Hu0nodyddeFKqkxEBKEvYNtEsN5YE3ZzHn32TqMBx/enasvhCCf2QdBrb850pR1qHTIf/AjccxTw6Q12dJYepiAq4wSzpM1btbymz9QeCANujN3svhcxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=spaGrKt5; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="spaGrKt5"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R8SE9n1868874;
	Fri, 27 Feb 2026 09:02:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Hl+po
	7naQ5bu38zu1PL9JxNMil9BWfkuByY8PFeWlvk=; b=spaGrKt51Mk9o6dBnS/lO
	kAylgJxR1d4UiotxhXXzCzdV06F35E7IsLhCV692ktrtDJiBRtNLEby87p7OnXf+
	+ZOrCvAiwOCPS/hGlJXmIY+YlV1UEmWpysbtVRXcsitoNjRAZnPPiIVfOWIXPX2p
	HzgKQlHPCFYuuSROtM4iuIrphsKvaLYFKUE/rbv0lNvLlGFoGkbkxhPy5TT2HURm
	mUhZbddhT3hnElJmNxSZBThjVWj66LkSOL5BYtckSjvuM0cihoOGYBCd4jxMshSC
	c1e8v2jQTy/T3+iF/S/CC3O1ZEobmFAQMMxkP6b0bVfdlYYV3qp2oymmh/vruG2N
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4chvwgbena-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 09:02:20 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61RE2Jmg064813
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 27 Feb 2026 09:02:19 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 27 Feb 2026 09:02:19 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 27 Feb 2026 09:02:19 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 27 Feb 2026 09:02:19 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61RE1t3r001982;
	Fri, 27 Feb 2026 09:02:13 -0500
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
Subject: [PATCH v4 05/12] iio: frequency: admv1013: add dev variable
Date: Fri, 27 Feb 2026 16:01:34 +0200
Message-ID: <20260227140152.77529-6-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260227140152.77529-1-antoniu.miclaus@analog.com>
References: <20260227140152.77529-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=Dcgaa/tW c=1 sm=1 tr=0 ts=69a1a3ec cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=10hQEsXEFSuYOAtga18A:9
X-Proofpoint-GUID: cVo8QEK1lzubd74GU6kX9T-QIVzLx7lv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDEyNCBTYWx0ZWRfX6hwKPIvLS71M
 RwHN/G0eFsSQT2x8l+GjvNTNFoA7wT4w4Uy81lE5wUvpuuMo3Ehyja+p9OhOORnymvI4sLlmxCj
 x3y9zflDhtFi9c3mZb4TCodt3ZohM/UC3kVT+t5oZpMpXbxq10m0ja/9sipl9o9/AndyO9G9RYl
 LZPu6DqrbU5+OlSWsKcReo5nmBW7Sm3GQZWUyVfnNdqbx2hjwLvwKI2TU+5Ur7iJb18Wj9+G8y0
 QGgrSxh7aXkvMEu2ohh5RK1QQxkHChrvTYDwI1p4SgpDGRXuJFVfxkzg6+9JsMqLKfTmDaNw8eL
 wVcrYGPfNBC/ugwRfSAK5s6fKvcy6XLbbsmc5CWOj/Fx9mU3bHbqIqrXB2xB79VDNUWnVOLimbD
 DaKm8cHzD/ognTZJCK6YM0je46K62QJq63qxIkrXy8q+uu8wOopbLVHU6tOt4mF4+voB/cURmJ3
 owmvJMSkTQKZGMq9eKw==
X-Proofpoint-ORIG-GUID: cVo8QEK1lzubd74GU6kX9T-QIVzLx7lv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_02,2026-02-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 phishscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602270124

Introduce a local struct device pointer in functions that reference
&spi->dev for device-managed resource calls and device property reads,
improving code readability.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/frequency/admv1013.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/frequency/admv1013.c b/drivers/iio/frequency/admv1013.c
index d8e8d541990f..d29e288da011 100644
--- a/drivers/iio/frequency/admv1013.c
+++ b/drivers/iio/frequency/admv1013.c
@@ -518,11 +518,11 @@ static int admv1013_properties_parse(struct admv1013_state *st)
 {
 	int ret;
 	const char *str;
-	struct spi_device *spi = st->spi;
+	struct device *dev = &st->spi->dev;
 
-	st->det_en = device_property_read_bool(&spi->dev, "adi,detector-enable");
+	st->det_en = device_property_read_bool(dev, "adi,detector-enable");
 
-	ret = device_property_read_string(&spi->dev, "adi,input-mode", &str);
+	ret = device_property_read_string(dev, "adi,input-mode", &str);
 	if (ret)
 		st->input_mode = ADMV1013_IQ_MODE;
 
@@ -533,7 +533,7 @@ static int admv1013_properties_parse(struct admv1013_state *st)
 	else
 		return -EINVAL;
 
-	ret = device_property_read_string(&spi->dev, "adi,quad-se-mode", &str);
+	ret = device_property_read_string(dev, "adi,quad-se-mode", &str);
 	if (ret)
 		st->quad_se_mode = ADMV1013_SE_MODE_DIFF;
 
@@ -546,11 +546,11 @@ static int admv1013_properties_parse(struct admv1013_state *st)
 	else
 		return -EINVAL;
 
-	ret = devm_regulator_bulk_get_enable(&st->spi->dev,
+	ret = devm_regulator_bulk_get_enable(dev,
 					     ARRAY_SIZE(admv1013_vcc_regs),
 					     admv1013_vcc_regs);
 	if (ret) {
-		dev_err_probe(&spi->dev, ret,
+		dev_err_probe(dev, ret,
 			      "Failed to request VCC regulators\n");
 		return ret;
 	}
@@ -562,9 +562,10 @@ static int admv1013_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
 	struct admv1013_state *st;
+	struct device *dev = &spi->dev;
 	int ret, vcm_uv;
 
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -581,20 +582,20 @@ static int admv1013_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "vcm");
+	ret = devm_regulator_get_enable_read_voltage(dev, "vcm");
 	if (ret < 0)
-		return dev_err_probe(&spi->dev, ret,
+		return dev_err_probe(dev, ret,
 				     "failed to get the common-mode voltage\n");
 
 	vcm_uv = ret;
 
-	st->clkin = devm_clk_get_enabled(&spi->dev, "lo_in");
+	st->clkin = devm_clk_get_enabled(dev, "lo_in");
 	if (IS_ERR(st->clkin))
-		return dev_err_probe(&spi->dev, PTR_ERR(st->clkin),
+		return dev_err_probe(dev, PTR_ERR(st->clkin),
 				     "failed to get the LO input clock\n");
 
 	st->nb.notifier_call = admv1013_freq_change;
-	ret = devm_clk_notifier_register(&spi->dev, st->clkin, &st->nb);
+	ret = devm_clk_notifier_register(dev, st->clkin, &st->nb);
 	if (ret)
 		return ret;
 
@@ -606,11 +607,11 @@ static int admv1013_probe(struct spi_device *spi)
 		return ret;
 	}
 
-	ret = devm_add_action_or_reset(&spi->dev, admv1013_powerdown, st);
+	ret = devm_add_action_or_reset(dev, admv1013_powerdown, st);
 	if (ret)
 		return ret;
 
-	return devm_iio_device_register(&spi->dev, indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static const struct spi_device_id admv1013_id[] = {
-- 
2.43.0

