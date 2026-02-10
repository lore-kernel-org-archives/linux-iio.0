Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF0C38A9B7;
	Tue, 10 Feb 2026 17:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770745920; cv=none; b=sTw2wVCrdAXYhbub8CCIgVQVaXOWcLKCRgLUowEnBFQFEAw3b7lchJGDhKPopn+cez8UJ1dN7ZI7WuNmFs8Z1/ZKGumAjqTXLA0ltgR9DGyRNBjZhiilo2+jCIhZ7RAv9PE2f/+iWfwCinOzaJ9VsQ3vu2XbQdo2GXj7x2tv0+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770745920; c=relaxed/simple;
	bh=jFJE5rZREnhpR0O4RGEZWM1SSsyzHXg3WvE3QmF7PvY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Mc01Hqlj76Wc6qU+tTjyl5plPRL9bQyaYrCyqzps8/BdyCjgbph1WgEo8x+oqT+48TtwIh2+BFzmbR7WFEmpuFufjHJZXWJKjBd2W+9YOIobwnSBsrp5f+Vbu+O3i2k6Q4Kuy9mf/vMw/hQZ23xwYKjA8LTHqkmq4mgxvjWSVWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=WjtDv6Du; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="WjtDv6Du"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61AF6QEP3275581;
	Tue, 10 Feb 2026 12:51:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=ZJDMj+SZhuZOOpMdW1S8J/0rHg4
	UY1h305Eb2Hsnn2U=; b=WjtDv6DuedxJZfTOAhxVqMuw28yvphEQm3Xy67oKLFV
	A2iAJvNCL1qUMGpbz04ZNVfKyr8Y3qwcPdP0oquFpgJfQiXC2vOrHrXR+aefph7j
	+eQ1Mvtt+kbbp0VLvgzJ9g7R1ikSH4V6A16LWof+eyTb8bBURr7/yyE3zD/CwFlX
	QuZbaIJQDdYMZ+VaMGj7kMFGm4+77cfYA4bsgg+G7d5T2ACRL0+wvDCqnjVHA/K7
	SA0450Bt8XEhxp+sXTBc7TciZG47AJq6HoRkxJzASGSkG/5tIyxhZp34M+X3MZEW
	R0oSe9WR+aigRB7UEepYI83N3ltsP21qvUbM5XalIvQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c6042w64m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Feb 2026 12:51:54 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61AHprRW003333
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 10 Feb 2026 12:51:53 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 10 Feb 2026 12:51:53 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 10 Feb 2026 12:51:53 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 10 Feb 2026 12:51:53 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61AHphPd031424;
	Tue, 10 Feb 2026 12:51:46 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] iio: dac: max5522: use devm_regulator_get_enable_read_voltage()
Date: Tue, 10 Feb 2026 19:51:27 +0200
Message-ID: <20260210175137.44178-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: WEL-1Dw8gHNuwQGa4HFLur1R1J9G3Yf5
X-Authority-Analysis: v=2.4 cv=ENILElZC c=1 sm=1 tr=0 ts=698b703a cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=gAnH3GRIAAAA:8 a=qytwyTAFfLj1kSSnGBsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDE0OSBTYWx0ZWRfX53gO+f7wyvkN
 bLAUI8WkstTL0Xt/wi3NUwRPiPF/t8y1o52hJ6aXZHh6u9NnK8bDasSmmRdzs9uhwF4jq09vvCv
 5zd98P/h/9EBDr3/o9iEmF8qgsINTgk42EQSF/FPGmlE7g8ByIs4tPyIZm0goNmPQqSNXaY2mAj
 6XIYgR98hC+ZDBG4IuVRdT3Bs3QKQ06m+7op38KgJzfXQT12/gRw5IKKRMwLBsxVReKPz1WQjz8
 fEZK4K6z5CLJa+VJxebcn/ftuhAukdA1FhxtaFrbnba+SZqvGqxgVM0/lihCUpyq7ndHOMQW17+
 41yB5WX/pl3d3cM+noIOOkK1PfBhNEWI0ss5RMVl4wvD2weT5yKolcjw/gCstHObp/B8r/Ljitx
 yjzKEnMGBJn35ainnuDmwUwCsAyLPg==
X-Proofpoint-GUID: WEL-1Dw8gHNuwQGa4HFLur1R1J9G3Yf5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_02,2026-02-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2602100149

Simplify probe by using devm_regulator_get_enable_read_voltage() to
get, enable and read the regulator voltage in a single call, caching
the value at probe time.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/dac/max5522.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/dac/max5522.c b/drivers/iio/dac/max5522.c
index 1b8fe6b8d26e..cda1cf572e77 100644
--- a/drivers/iio/dac/max5522.c
+++ b/drivers/iio/dac/max5522.c
@@ -34,7 +34,7 @@ struct max5522_state {
 	struct regmap *regmap;
 	const struct max5522_chip_info *chip_info;
 	unsigned short dac_cache[2];
-	struct regulator *vrefin_reg;
+	unsigned short vref_mv;
 };
 
 #define MAX5522_CHANNEL(chan) {	\
@@ -79,17 +79,13 @@ static int max5522_read_raw(struct iio_dev *indio_dev,
 			    int *val, int *val2, long info)
 {
 	struct max5522_state *state = iio_priv(indio_dev);
-	int ret;
 
 	switch (info) {
 	case IIO_CHAN_INFO_RAW:
 		*val = state->dac_cache[chan->channel];
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		ret = regulator_get_voltage(state->vrefin_reg);
-		if (ret < 0)
-			return -EINVAL;
-		*val = ret / 1000;
+		*val = state->vref_mv;
 		*val2 = 10;
 		return IIO_VAL_FRACTIONAL_LOG2;
 	default:
@@ -147,16 +143,11 @@ static int max5522_spi_probe(struct spi_device *spi)
 	if (!state->chip_info)
 		return -EINVAL;
 
-	state->vrefin_reg = devm_regulator_get(&spi->dev, "vrefin");
-	if (IS_ERR(state->vrefin_reg))
-		return dev_err_probe(&spi->dev, PTR_ERR(state->vrefin_reg),
-				     "Vrefin regulator not specified\n");
-
-	ret = regulator_enable(state->vrefin_reg);
-	if (ret) {
+	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "vrefin");
+	if (ret < 0)
 		return dev_err_probe(&spi->dev, ret,
-				     "Failed to enable vref regulators\n");
-	}
+				     "Failed to get vrefin regulator\n");
+	state->vref_mv = ret / 1000;
 
 	state->regmap = devm_regmap_init_spi(spi, &max5522_regmap_config);
 
-- 
2.43.0

