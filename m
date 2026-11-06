Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981154;
	b=34pEh4KDjI9rG12LtBTKOZazo8ukYzqnYTzVoRxhgAOcVjG7U53J/95MVbNfQVwF8GBV
	 1hD4j8kH1/KgSmogTHUZkxf1eqZohuAgfq3PDnJBIXGv5TJ9KmSiZcVPcxkzbyexO/Fr2
	 yg6xb4sC5+fgHZ+U1fV/tsPfM5OWLMCJ1OiSMGJ4fSolNAP+t02xKswA/ZsEhJx6szYUM
	 jvkkGLO3G3eLdyEqAMLA0IPVCu8h14XLd5au+eI3QgfKfTKlHFnHt54+k9eLf98N6N8TV
	 A0QvFy0QHXTVWPc0QRwSypXf+ImChouV8w0TvI5jwV/NP7LIsiOE07TrBqnNzv+h+Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981154;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=BKY5BDD26pjkS6zaiy1EJDscUh0piDDDnffwWtceLOk=;
	b=INC9UB4VuL4YRViIahp/a/eqzP3XZCAthGlGTouvWFO0hhyB/neYmx4F5WR/pRgjd8nv
	 4hIEcUEhwcXxyp3/10io6Q9JhpzgpxyRgthM89ScxzRFY1b+XUL+6emFQIt1c1xRgZBZ5
	 AD3rHORArTB8UrAg02Dc4E7Jb4GUAhIqQYOtKNOi1ltGpMpe6MtOTsdc7WCQhSElkqhjS
	 9Ocu0b1TJyoYk8zHs8a8rehMydOJMpp6asbgzvmiUzCL8f0Idy9ivYlEswbQWdSMkEdlf
	 ERbrXwpyD+k3CLk/5uyWK+RkEVP7EXdK8VUd6Nt7L7KG4Ta9f2XOP73xMP8sMUrF26A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=iHeYNlgG;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=c5YWwE46;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7478A606A338;
	Fri,  6 Nov 2026 16:05:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7478A606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=iHeYNlgG;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=c5YWwE46
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F3qCp1282647;
	Fri, 6 Nov 2026 11:05:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=BKY5BDD26pjkS6zaiy1EJDscUh0piDDDnffwWtceLOk=; b=iHeYNlg
	GADFqu76DC6rbiA0/8MGknEKv8e2FMlOzYPxtGIFCo8/t/Rf94VP9ww6bQ5ljCFK
	oPHQgyp+M8GbQ5G6nbayEGgmfUUyWyuMUFhycZmpuMOLmGn6CbdwSxmmLnBfaewH
	8HKwTHD0N68GMKi67BU7HZqp/mw9/Y56Nnqev/Ae1ktrHO2lyh6E26BBgXWdF42V
	8zN4caeU2ZB1PcfcfVgt5i9D8OrY0LD+9VCnN0a4/ZCaO48gLTO9ApxrGQwBThe6
	Ue8IfKDpJYbrbA4MWRU1j3OuaSr87fJz8sU/Mpn5pZKWTx5DEu4QSufUwjLfeIIp
	nMgF/RW+suxSoVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=BKY5B
	DD26pjkS6zaiy1EJDscUh0piDDDnffwWtceLOk=; b=c5YWwE469XfFf5jTgJtYh
	bJWfUHW+uhT88gqgusYbrgjz3bn2oJlctSVAzEzkXFCby/0lsJ/dOiHhXGZVDCrR
	FRq5j85CiydI7xDer/6AO3Ze/QLkwWWySY7yVErY+XyJwhzM3GUxPei5V8VK4MBn
	fvXkXniNacOdLB15ksNs95IpJrn/LJtG+g7sGWlkNh79FSvMm9fz52jy9Eja4TC/
	xgdwkm5Jg3FGEULL29k7SkmcCjTLaQSIAmZ1dF/a+fkjkTaWZ/Gcy+r3g5yocIoH
	a2JqW2cxzl4Z8gEyGVjqsrtYWjDW/HDMIhyW8N1226HuxHl8RZOQaKxjnpJRHU7H
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hs3q1d50y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 11:05:51 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6A6G5oXs036371
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 6 Nov 2026 11:05:50 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 6 Nov 2026 11:05:50 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 6 Nov 2026 11:05:49 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 6 Nov 2026 11:05:49 -0500
Received: from arch ([10.135.2.92])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6A6G5TDK016340;
	Fri, 6 Nov 2026 11:05:42 -0500
From: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring
	<robh@kernel.org>, David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        "Trevor
 Gamblin" <tgamblin@baylibre.com>,
        Joshua Crofts <crofts@kernel.org>,
        "Sergiu
 Cuciurean" <sergiu.cuciurean@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Nicolae-Daniel
 Deaconescu" <Nicolae-daniel.Deaconescu@analog.com>
Subject: [PATCH v3 3/7] iio: adc: ad7625: fix sampling frequency handling
Date: Fri, 6 Nov 2026 18:05:15 +0200
Message-ID: <20261106160529.876251-4-Nicolae-daniel.Deaconescu@analog.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106160529.876251-1-Nicolae-daniel.Deaconescu@analog.com>
References: <20261106160529.876251-1-Nicolae-daniel.Deaconescu@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: ce8T9UlUVmoNEGfrYcPqKUnEuLpzfuCD
X-Authority-Analysis: v=2.4 cv=EqNHPicA c=1 sm=1 tr=0 ts=6aedfadf cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=8MR3j3Xn5CCrLiW-EVgA:9
X-Proofpoint-GUID: ce8T9UlUVmoNEGfrYcPqKUnEuLpzfuCD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2MyBTYWx0ZWRfX3iXgqp+itKHa
 0bjES7jZkz80966QTkB+Uent45CNxnO1FFAvYoCYoCa3nDZAzCbm1iePVeSL1wJBB/gCnbSxVCF
 kT3XS4IQlomkU68ARsMK32Xg96GOMdO4rtQZek7sWxWARp6dFagK13gxwsId7bZtiSEh41ZjGyQ
 f8HkIIywfOXddFKT1H/zgDvNYJ6dXl1zTBcTnT2tSQ0t+Wd0TEdQmmLF18yCZb0tCvf6bwTubi3
 DgeN7Rc+f3H7LTN+Z9bahIO+dZPTDUFlNcExFNk90NIIgQuCJnl/Dgow/ROvx5rqJMrSMVHCSHE
 KhnaXpzOKZin/sbwW/2fXMdJWl0RNoxPlVp7T1D8cTJXtBAfpG5rdZq1MCoGDXp3nbjoJ+LZ3QN
 pQPLuqVj9Z9cdB7aH3/rhwqW+l3DWmVMkb8QXs5uOW/dwXTaNUg5LpXvU1wfF4qaD8QC9eB0p8O
 vA2j5xqjNUiAQ2i6tTQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2MyBTYWx0ZWRfX/jOjZ75bJWAX
 mlKZ+hdQhe6DC6mFIPv5M2z3Z3Di16Cppmmg6fWDJjlBJ0tTunqK/GVSYc/ygVB+/O3lmHvvIN4
 HzRu6DPTF/xH37gMopDw+50gd77pu2va8np9Ws0/oIuXJy6kba5b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060063

Fix sampling frequency handling issues:

- Fix issue where writing 0 to sampling_frequency caused a division by
  zero. Return -EINVAL.
- Fix issue where a waveform rounded up by the PWM went unreported.
  pwm_round_waveform_might_sleep() returns 1 in that case and
  ad7625_set_sampling_freq() passed it on, so the sampling_frequency write
  returned 1 and the new waveforms were dropped. Return -EINVAL.
- Fix issue where probe() continued after failing to set the initial
  sampling frequency. The dev_err_probe() result was not returned, leaving
  the PWMs unconfigured. Return the error.

Fixes: b7ffd0fa65e9 ("iio: adc: ad7625: add driver")
Signed-off-by: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
---
 drivers/iio/adc/ad7625.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7625.c b/drivers/iio/adc/ad7625.c
index e73a5c9e7f0b..ade2f2368bd8 100644
--- a/drivers/iio/adc/ad7625.c
+++ b/drivers/iio/adc/ad7625.c
@@ -178,6 +178,9 @@ static int ad7625_set_sampling_freq(struct ad7625_state *st, u32 freq)
 	unsigned long target;
 	int ret;
 
+	if (!freq)
+		return -EINVAL;
+
 	target = DIV_ROUND_UP(NSEC_PER_SEC, freq);
 	cnv_wf.period_length_ns = clamp(target, 100UL, 10UL * NSEC_PER_USEC);
 
@@ -188,8 +191,10 @@ static int ad7625_set_sampling_freq(struct ad7625_state *st, u32 freq)
 	cnv_wf.duty_length_ns = st->info->timing_spec->conv_high_ns;
 
 	ret = pwm_round_waveform_might_sleep(st->cnv_pwm, &cnv_wf);
-	if (ret)
+	if (ret < 0)
 		return ret;
+	if (ret)
+		return -EINVAL;
 
 	/*
 	 * Set up the burst signal for transferring data. period and
@@ -205,8 +210,10 @@ static int ad7625_set_sampling_freq(struct ad7625_state *st, u32 freq)
 	clk_gate_wf.duty_offset_ns = st->info->timing_spec->conv_msb_ns;
 
 	ret = pwm_round_waveform_might_sleep(st->clk_gate_pwm, &clk_gate_wf);
-	if (ret)
+	if (ret < 0)
 		return ret;
+	if (ret)
+		return -EINVAL;
 
 	st->cnv_wf = cnv_wf;
 	st->clk_gate_wf = clk_gate_wf;
@@ -646,8 +653,8 @@ static int ad7625_probe(struct platform_device *pdev)
 
 	ret = ad7625_set_sampling_freq(st, default_sample_freq);
 	if (ret)
-		dev_err_probe(dev, ret,
-			      "failed to set valid sampling frequency\n");
+		return dev_err_probe(dev, ret,
+				     "failed to set valid sampling frequency\n");
 
 	return devm_iio_device_register(dev, indio_dev);
 }
-- 
2.56.0

