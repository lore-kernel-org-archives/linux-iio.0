Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AF13B7B83;
	Fri,  3 Jul 2026 10:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783073460; cv=none; b=uvcQk8ZR/ZejM8YnjRw2Do9Asfh0khBvVTxDaFSfHZ7J6dCfZ8dRnxn9vHnMmOLq9tLSoXjyFXIprgFms0Ifna5KaMM72b/zs9RlDYid6s0H2IdaHnEx6KhcjYXzbpTJO4pO/7iRHq58oic5coA0KHNMsUkFNTxvQfrCsyz+/z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783073460; c=relaxed/simple;
	bh=I1AkH8OqgkBrB3GsCTg5pGaRf5/SuDxri3XgLKifGsg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=fCnE4deNLrC5JJT0PARcl60WDu0coN0LxCw9XGIWIkSvN0mxECuulslDJE6K7uTLOfHLlAxWZloBAdfZMRBhBwHtRGb+U22KTgDguJO+obOyMHH0GZzacTia5v2+NNLILJ9lvgFfkzoZn1nT5rO8+zsDJ/oQQHqZXwsX0zax84U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=GlEaXMqj; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="GlEaXMqj"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6635vrYg310175;
	Fri, 3 Jul 2026 06:10:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=1HExD
	I5a7u3CW+GBpuoC+AgCFR/0e0sD5hBszC2q4fE=; b=GlEaXMqjcRE0C0kYb3Hhs
	iIgKpqOgszAX0JPf99N4Vo0siQRFkANoZlUGUUnL/PsvzL8yeZM4HPH0qdVKEMr2
	MrQFbpG7LtHn/5TuJjM1Bvie3uSUEppBD8iORh9bhi3Hr+G50EeIk/9oY8HAKgHo
	nNGLdolTlfqxpIPuO08Fs8Nc3TJelB5H/PuZJ/IMA9sw8Khw+oqFBzzfgSDcU9i7
	uw4xTh76QtFyWXhSCGzPPvpIPuycZlo0dzjbeYso2FB/4w9/fNvHsrXWDvpMancn
	AMn81x0g/Gpp6gwP6g2RHo0+DCZWbiwQA7AOfsXOr8yuUhy6m+7lkENOSsCdIwgG
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4f658j1eb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 06:10:49 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 663AAmcB011018
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 3 Jul 2026 06:10:48 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 3 Jul 2026 06:10:48 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 3 Jul 2026 06:10:48 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 3 Jul 2026 06:10:48 -0400
Received: from analog.ad.analog.com ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 663AAOlH024695;
	Fri, 3 Jul 2026 06:10:42 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Fri, 3 Jul 2026 18:10:08 +0800
Subject: [PATCH v4 3/6] iio: dac: ad3530r: Convert sw_ldac_trig_reg to a
 function pointer
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260703-iio-ad3532r-support-v4-3-69d9a336f4e8@analog.com>
References: <20260703-iio-ad3532r-support-v4-0-69d9a336f4e8@analog.com>
In-Reply-To: <20260703-iio-ad3532r-support-v4-0-69d9a336f4e8@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        "Andy
 Shevchenko" <andy@kernel.org>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux@analog.com>, <devicetree@vger.kernel.org>,
        Kim Seer Paller
	<kimseer.paller@analog.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783073424; l=3307;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=I1AkH8OqgkBrB3GsCTg5pGaRf5/SuDxri3XgLKifGsg=;
 b=XQDitmjTMGn2dQWGfdGEDBEU0bF4ftCqP9ieOJJsZUfv/1eUzEJo0A1S71079igq/JokRAvQ1
 Qx9s2Uq0kaNCla5zjY7A4+fmMaLWw62E804dOaTBGnlVtcaOVtqhx+d
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=eMsjSnp1 c=1 sm=1 tr=0 ts=6a478aa9 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8
 a=Jx9qUr-dXdPhytUwuuUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 0uAEti_9LmL9jW2evfuifB32Ks-jDsGk
X-Proofpoint-ORIG-GUID: 0uAEti_9LmL9jW2evfuifB32Ks-jDsGk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA5OCBTYWx0ZWRfXyE6XsFcXfZIc
 TfYvALhlXLMixgI+/hu86mAEA7LU1YftdQB4OhbPAKd+Tz0TNRmMJ/TKNiVXBa6ncvZCWxMrnNR
 Vcdc/jT/N96xyKjqqOFj62RaudZFTf5tTQkqj+oXZ6v9aCePeHVNHVG0ThOD5x3OKRBi5ivtAY6
 /JMhKDClDBbha2xXcR2gZSdjBy5sCFwaTNz2vTjwTde2NdwdH+OAXZKYCt8aCyLlQoGx8c1lJd1
 TOBMUveQYhnnEh3qmno+z6L0uDO+d5PmTwhbZSh7TrcXPE/7cUm5s/gTbi/SSJbSbZMIz7nsJXl
 cx3PAgCKG8iHpeh1FVGlUXEYCLiepPpNLymfx3Bky8z7nxoFReZp2Mky8HvT69R0M0XBobxTxwD
 lsb9pSy5U41Lt2ufLYxjHY4IT0TZFHVAIZPPW2Pna5BLhqh0zmQE0B/ozzsMy4DFNtLfSQn6hCR
 Eaf82HfL7ZPJxm02Mfw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA5OCBTYWx0ZWRfX7qTkJ0D3mQMU
 fbNH4STw9OkNpEx6iCc52jzOGvRARcdbfDOpAzHM/fPEPOPFsoil958lTGK0nScgsbjIoZGXdL1
 /XAklVNoX7vkAjBnv7Rr5tGF0AKEqOryrJM0yw8o1MZeIjoE2Dxc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030098

The software LDAC trigger register is stored in the chip_info table as a
fixed register address. Devices with a multi-bank register architecture
select the trigger register based on the channel being updated, which a
single static address cannot express.

Convert sw_ldac_trig_reg into a function pointer that returns the
trigger register for a given channel, mirroring the input_ch_reg
callback.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 drivers/iio/dac/ad3530r.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/dac/ad3530r.c b/drivers/iio/dac/ad3530r.c
index 9d4545e2c9b3..7841546f0c07 100644
--- a/drivers/iio/dac/ad3530r.c
+++ b/drivers/iio/dac/ad3530r.c
@@ -69,8 +69,8 @@ struct ad3530r_chip_info {
 	const char *name;
 	const struct iio_chan_spec *channels;
 	int (*input_ch_reg)(unsigned int channel);
+	int (*sw_ldac_trig_reg)(unsigned int channel);
 	unsigned int num_channels;
-	unsigned int sw_ldac_trig_reg;
 	bool internal_ref_support;
 };
 
@@ -190,6 +190,16 @@ static ssize_t ad3530r_set_dac_powerdown(struct iio_dev *indio_dev,
 	return len;
 }
 
+static int ad3530r_trigger_sw_ldac_reg(unsigned int channel)
+{
+	return AD3530R_SW_LDAC_TRIG_A;
+}
+
+static int ad3531r_trigger_sw_ldac_reg(unsigned int channel)
+{
+	return AD3531R_SW_LDAC_TRIG_A;
+}
+
 static int ad3530r_trigger_hw_ldac(struct gpio_desc *ldac_gpio)
 {
 	gpiod_set_value_cansleep(ldac_gpio, 1);
@@ -215,7 +225,7 @@ static int ad3530r_dac_write(struct ad3530r_state *st, unsigned int chan,
 	if (st->ldac_gpio)
 		return ad3530r_trigger_hw_ldac(st->ldac_gpio);
 
-	return regmap_set_bits(st->regmap, st->chip_info->sw_ldac_trig_reg,
+	return regmap_set_bits(st->regmap, st->chip_info->sw_ldac_trig_reg(chan),
 			       AD3530R_SLD_TRIG_A);
 }
 
@@ -335,7 +345,7 @@ static const struct ad3530r_chip_info ad3530_chip = {
 	.name = "ad3530",
 	.channels = ad3530r_channels,
 	.num_channels = ARRAY_SIZE(ad3530r_channels),
-	.sw_ldac_trig_reg = AD3530R_SW_LDAC_TRIG_A,
+	.sw_ldac_trig_reg = ad3530r_trigger_sw_ldac_reg,
 	.input_ch_reg = ad3530r_input_ch_reg,
 	.internal_ref_support = false,
 };
@@ -344,7 +354,7 @@ static const struct ad3530r_chip_info ad3530r_chip = {
 	.name = "ad3530r",
 	.channels = ad3530r_channels,
 	.num_channels = ARRAY_SIZE(ad3530r_channels),
-	.sw_ldac_trig_reg = AD3530R_SW_LDAC_TRIG_A,
+	.sw_ldac_trig_reg = ad3530r_trigger_sw_ldac_reg,
 	.input_ch_reg = ad3530r_input_ch_reg,
 	.internal_ref_support = true,
 };
@@ -353,7 +363,7 @@ static const struct ad3530r_chip_info ad3531_chip = {
 	.name = "ad3531",
 	.channels = ad3531r_channels,
 	.num_channels = ARRAY_SIZE(ad3531r_channels),
-	.sw_ldac_trig_reg = AD3531R_SW_LDAC_TRIG_A,
+	.sw_ldac_trig_reg = ad3531r_trigger_sw_ldac_reg,
 	.input_ch_reg = ad3531r_input_ch_reg,
 	.internal_ref_support = false,
 };
@@ -362,7 +372,7 @@ static const struct ad3530r_chip_info ad3531r_chip = {
 	.name = "ad3531r",
 	.channels = ad3531r_channels,
 	.num_channels = ARRAY_SIZE(ad3531r_channels),
-	.sw_ldac_trig_reg = AD3531R_SW_LDAC_TRIG_A,
+	.sw_ldac_trig_reg = ad3531r_trigger_sw_ldac_reg,
 	.input_ch_reg = ad3531r_input_ch_reg,
 	.internal_ref_support = true,
 };

-- 
2.34.1

