Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2ECF3C6A25;
	Mon, 30 Mar 2026 11:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774869668; cv=none; b=k5E65abrq/U4Ysbo0OxBINlAHTlmYnHLo/MAhR6qNbmGxI4AcVBm110MuQuPIf6t9pcYZbGzvrmofUbrSSn+T6EtByMiRLkLt0045K3+EWcoP+s5VuwJXEbbtolqMYlYlorClZg+XEAJHWKuXb7ZrAkUN62Jx0SnybXQHHc5Yt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774869668; c=relaxed/simple;
	bh=47mVUW2psllq0uhogJHNG9F8n8nba0TWZqKrUOzLChg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PVq7G7n4G9YnqsG1rHgwF5lTiV2s9XSSrsKrkbQ/b+kE3FU1/mKTOssa5K8OE/EOOet/5aL/IqfwFyIO0MnGWsb9KnG7nz/NBWb4BbcsD+RxI8BjxLBe5S+hw0ShxwEMTGcAqbB3lPYIQYAVkDNMraJ4t1Kl9zO1zCEjkyhR1/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ykpJAM6w; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ykpJAM6w"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UAwJqK2844923;
	Mon, 30 Mar 2026 07:20:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=2Fxoe
	yzIAW10Eh10xTn7QFh3pJaxE+OXdOfFLhBqMzI=; b=ykpJAM6wVTkuuzf/3URP6
	rVrCoxDhbVBbR4+GuDw/sTbFWohm1zHJrPLGD9uv/ivxzJo/mWzW1k9mPikFgR3N
	AjLpkgqyAJTsHr91NEd0eiAFf0i4iYqluCO6vvgG+ECVJJ8eHpxxBzFWanQjw53K
	TTC6BJ2xmM8DvD+38b6XKL1rPbnLuCrXC5Ze/2N8Vm0HU31WCoBjz0njEUnO2dKe
	AxEpj8NJiS8cArgA1HfTYpXTtqaak11mJxLL0v+/pWPjQ7LLG5/pCcDGGSYkQwrc
	b2DkYJTF6r+w+JK3TTilWMbgtVZotbinjrmmSoTec2p5Gdbr1KdjfyvsDW2WSmcV
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4d6bw0xs1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 07:20:44 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62UBKgYj026928
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 30 Mar 2026 07:20:43 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 30 Mar
 2026 07:20:42 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 30 Mar 2026 07:20:42 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.204])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62UBKDgb014225;
	Mon, 30 Mar 2026 07:20:34 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Jorge Marques <jorge.marques@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan
 Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Marcelo Schmitt
	<marcelo.schmitt1@gmail.com>,
        Renato Lui Geh <renatogeh@gmail.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 08/13] iio: adc: ad7791: add dev variable
Date: Mon, 30 Mar 2026 14:18:51 +0300
Message-ID: <20260330111856.121589-9-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330111856.121589-1-antoniu.miclaus@analog.com>
References: <20260330111856.121589-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: mpAj8H6K6hMpalFUszT6W82H_4BpZcRf
X-Authority-Analysis: v=2.4 cv=BqyQAIX5 c=1 sm=1 tr=0 ts=69ca5c8c cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=-Vny9m8iCYfL8Uq4-AMA:9
X-Proofpoint-ORIG-GUID: mpAj8H6K6hMpalFUszT6W82H_4BpZcRf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA4OSBTYWx0ZWRfX9npSaEQZCik7
 +rY0RvpDnHutSo8YBIuVx78q7Y/dB1psOQhLI6wSxyccYeuT5qdxLyIA88fqiychJvaAGjeI/NK
 hAi6SeQghJIBONZhRt//9I6217o2V6VOJPQBVwqw8fSHDWJpck9pbvs2iepDNjDLZyEMIwdN1ht
 /3m38USiMYit0e/P3svPi27dWgos0tJNVw4BkN5eq1ALdnjau4Qwelg4TsHq9keBBWSLwHIyIT4
 fLCTo0dPmp5TeTnEngG8NxXXAW7Lwv8fVvU8zIYgctI8rK4DqdRewejqL1Xg8Q+LaTn3ay4UUph
 S+l9cnAZna931GSvmJuLkSwLoJsdnj+gECOTxR9j4jO2RrE4Px7ZRnKg/xEQuDSdTqfKc1gwUQa
 bPqN91s2ZIjIi5BJ0T31cygB99TojLNpVoTUDawuEGiqk3toZi11xJDZG6EXQwOV76nvzkJ06Y0
 InFVdnt56DsOgbFZ8uw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1011 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300089

Add a local struct device pointer to simplify repeated &spi->dev
dereferences throughout the probe function.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/ad7791.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad7791.c b/drivers/iio/adc/ad7791.c
index 041fc25e3209..ab1ab0d88492 100644
--- a/drivers/iio/adc/ad7791.c
+++ b/drivers/iio/adc/ad7791.c
@@ -407,7 +407,8 @@ static void ad7791_reg_disable(void *reg)
 
 static int ad7791_probe(struct spi_device *spi)
 {
-	const struct ad7791_platform_data *pdata = dev_get_platdata(&spi->dev);
+	struct device *dev = &spi->dev;
+	const struct ad7791_platform_data *pdata = dev_get_platdata(dev);
 	struct iio_dev *indio_dev;
 	struct ad7791_state *st;
 	int ret;
@@ -417,13 +418,13 @@ static int ad7791_probe(struct spi_device *spi)
 		return -ENXIO;
 	}
 
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
 
 	st = iio_priv(indio_dev);
 
-	st->reg = devm_regulator_get(&spi->dev, "refin");
+	st->reg = devm_regulator_get(dev, "refin");
 	if (IS_ERR(st->reg))
 		return PTR_ERR(st->reg);
 
@@ -431,7 +432,7 @@ static int ad7791_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = devm_add_action_or_reset(&spi->dev, ad7791_reg_disable, st->reg);
+	ret = devm_add_action_or_reset(dev, ad7791_reg_disable, st->reg);
 	if (ret)
 		return ret;
 
@@ -447,7 +448,7 @@ static int ad7791_probe(struct spi_device *spi)
 	else
 		indio_dev->info = &ad7791_no_filter_info;
 
-	ret = devm_ad_sd_setup_buffer_and_trigger(&spi->dev, indio_dev);
+	ret = devm_ad_sd_setup_buffer_and_trigger(dev, indio_dev);
 	if (ret)
 		return ret;
 
@@ -455,7 +456,7 @@ static int ad7791_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	return devm_iio_device_register(&spi->dev, indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static const struct spi_device_id ad7791_spi_ids[] = {
-- 
2.43.0

