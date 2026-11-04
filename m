Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793798542;
	b=tncDPDRkqqDzz8paWNUJyurgE8mQE66MW4lP6il+EVV5j5oEP5vx0cgGKFgaPJEAcIDf
	 R+1VTcuMXEGsIuls9wRTHk/tBDFC9B/mT52nYU5g+sVZV7Meg3/BUBOMy/jUkha6MRJw6
	 S0Gw8cyjqaGOtyObAc6H8FZ553v0NMlVo8CSS1OkEjozimFyHsUgeXUc95829K1lKUIh6
	 rugw5QqSjd234Uyhsg9p9pR/YtROyW2V14mgNc3G0SquhBH3MLmzL/Zze3kWQ/Y8uyVKR
	 ku6jeDrs6RSqfn61nZ6Vd9bvaT7DIwlJSSq4G9GOr7G9iZpK0D4zGXUusQF1ORKj/JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793798542;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=wj7IdaAdZuhAGKNv/HrQ0yJHDsJqs0v6JAP+eJCVLYk=;
	b=mbKaE+TaI5DvcmzNhZ2NmfxuYQGdcxPB/kZCFn8lSflJd9+bPJC5K/QCWaKUlF6j6TIx
	 zXX03j9SqIYTaBoBkTgvoH3TB4WuXjFXEKoc8geaGT0rDgS3PKVipIJa9GcceL5F0eJIi
	 XfqixN99kdTMCmq7XqMPHJOwBXknUw1jF+otnE0uzPrlDGBtX1wBEIU/wL4bDmOcEmxHQ
	 U2zGn0AjdfZH2EnUHULUfmjV7qedk9zaqfm1qOs0UPTXk2zGRmNJOHrMaTezfQB/6kFt0
	 r/ik8XWF1uUSzMZR+E/Z3HGqAe0m3MXJxm7xL5jUY3ta9GAUmrDVZ03HDHGBRFNE1xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=o4QTZgYr;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=wQ7v2Okw;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE9B606A326;
	Wed,  4 Nov 2026 13:22:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFE9B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=o4QTZgYr;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=wQ7v2Okw
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4Bd6st1972338;
	Wed, 4 Nov 2026 08:22:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=wj7IdaAdZuhAGKNv/HrQ0yJHDsJqs0v6JAP+eJCVLYk=; b=o4QTZgY
	r3D8zJNkHjThZmei7gtLDRyNRvOIGMf10YztfHf8k1+z+5ORgRhrem1NGbUiKCfo
	K6DGyvGxb/PGJv2zcdX+9RroW+rWZ/Gp2ck3ixMVnkZNP+aq0BhnZQiQaI15A41A
	vb4MV6gSBzBQkeYXDzvHwF3FHNtrp8SdQ/fV8enhLdV1fRCTYO7gcMHwR0IHo2Za
	0MWKXFf+S+gtdwpdQ5bt/ELFC/CFzdpuvIA93URLO7KddhLNRZfKc9fBOP1eeYUh
	o5p0iIcsELUUDI6BnzWH20dt/fKlX9nvTznconu31b6b5/XtdW3gckJ78K8+/ltQ
	iULq6brAlLvQkZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=wj7Id
	aAdZuhAGKNv/HrQ0yJHDsJqs0v6JAP+eJCVLYk=; b=wQ7v2OkwkvhSsU8kYWCAU
	AlfnULxs/WqiGff/frHKASCIw+QM3fXzFSR6PRtqVE9ixR2UQR/x/dvXJ2pGZHgM
	dMjxEEjqWDjU1NkB2Mp6tbDK372FMHhHPGHaYkb/updNNMcF8YtOyrrU0+RMM0LR
	qNYG8Ln0jnLNRsYFO2drvvzj6ntdklRnwrZ8vk6MG69RMEAQ0hGmM5Xb361NR9+Q
	NifhPd/qBJ41mNp+5MQ6w/j1fyvs1Qv4EN3BHAAyqXHj2MJY7C26ipbiTYR7z4UD
	Mb3LEOlIlu5HkzRHYcJx6mMXR53itGKBzwsmbUmITJbMDdcWr8I4wD1xbumeRdDh
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hqk2pwxwh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 08:22:18 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 6A4DMG3f028023
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 4 Nov 2026 08:22:16 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 4 Nov
 2026 08:22:16 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 4 Nov 2026 08:22:16 -0500
Received: from HYB-aFjnqsVU6Ag.ad.analog.com ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6A4DLnan008011;
	Wed, 4 Nov 2026 08:22:08 -0500
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
        Trevor
 Gamblin <tgamblin@baylibre.com>,
        Joshua Crofts <crofts@kernel.org>,
        Sergiu
 Cuciurean <sergiu.cuciurean@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Nicolae-Daniel
 Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
Subject: [PATCH v2 2/5] pwm: axi-pwmgen: report the waveform step
Date: Wed, 4 Nov 2026 15:21:40 +0200
Message-ID: <20261104132143.215581-3-Nicolae-daniel.Deaconescu@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261104132143.215581-1-Nicolae-daniel.Deaconescu@analog.com>
References: <20261104132143.215581-1-Nicolae-daniel.Deaconescu@analog.com>
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
X-Proofpoint-GUID: C7EqxUD2gIn-30GZsGURmG-RD2w9oQX4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA1MyBTYWx0ZWRfX8J8gld1aiz/t
 gHWHf3RkaRi72deFi8HCVdnARkLihpKy1C/vlCBRZx8VVh6RFCTirBPW0cRS0DH1vfcj3o9XhaB
 rCcihBfSBZgx+WELFbGWBideGWbXPAJQ9AaG/wg8uplSemXVDU8U
X-Authority-Analysis: v=2.4 cv=NPlAaE6g c=1 sm=1 tr=0 ts=6aeb318a cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=aASXySr_LHO6eXd1yVMA:9
X-Proofpoint-ORIG-GUID: C7EqxUD2gIn-30GZsGURmG-RD2w9oQX4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA1MyBTYWx0ZWRfXy6xUmX+6vY31
 zByjP+mjnMYrNYAuvVgPtCbBuQvHUGDNtxe6qwGHSlCZNYAeM2gk/QnJ+hmHfqgcpwjO1GCoRLt
 Zdpa0p3FYjYilAc1GBDMggt6I97/6WGsEWKBUBfTdXoa4ofRvtH5HkSLVa726jb/YsZMfKLDGfm
 ZJQj+nSLIbOd7nadi9x0JiSq/+dq2Pd9vlXS3pJowWU3TPljAIx/qgWUAXep9OZLjAHlF+sUiQA
 6suFyU1SXbexMoCVaxo8TOXLujphlFfrbZ2NSFwo+yCUzbTHsoc2Y5GU88LJLHd2Ri0Ulvwe6a+
 8rNWDJoCmklh1S1Ih+4g8qMiic6fqUnEeYQMyT1WzXFK/RYkr4yIUt16ZZ4vO48UOu43EsCZkQJ
 zcnn+4GmMFdzRjHxpRigUBbaA9iZRK3f2Mqb7/xZHKSYmkGZLm2Z7Rm/t2ZDc9JX2Z9bR/ngfsP
 YShZmWaHFflqH28eq4A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 clxscore=1011 priorityscore=1501 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040053

The period, duty and offset counters of the AXI PWM generator count
cycles of its external clock, without a divider. Report that clock rate
and one cycle per step.

Signed-off-by: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
---
 drivers/pwm/pwm-axi-pwmgen.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
index b40522f01002..5b6a6943d08a 100644
--- a/drivers/pwm/pwm-axi-pwmgen.c
+++ b/drivers/pwm/pwm-axi-pwmgen.c
@@ -136,6 +136,18 @@ static int axi_pwmgen_round_waveform_fromhw(struct pwm_chip *chip, struct pwm_de
 	return 0;
 }
 
+static int axi_pwmgen_get_waveform_step(struct pwm_chip *chip,
+					struct pwm_device *pwm,
+					struct pwm_waveform_step *step)
+{
+	struct axi_pwmgen_ddata *ddata = axi_pwmgen_ddata_from_chip(chip);
+
+	step->clk_rate_hz = ddata->clk_rate_hz;
+	step->clk_cycles_per_step = 1;
+
+	return 0;
+}
+
 static int axi_pwmgen_write_waveform(struct pwm_chip *chip,
 				     struct pwm_device *pwm,
 				     const void *_wfhw)
@@ -201,6 +213,7 @@ static const struct pwm_ops axi_pwmgen_pwm_ops = {
 	.round_waveform_fromhw = axi_pwmgen_round_waveform_fromhw,
 	.read_waveform = axi_pwmgen_read_waveform,
 	.write_waveform = axi_pwmgen_write_waveform,
+	.get_waveform_step = axi_pwmgen_get_waveform_step,
 };
 
 static int axi_pwmgen_setup(struct regmap *regmap, struct device *dev)
-- 
2.34.1

