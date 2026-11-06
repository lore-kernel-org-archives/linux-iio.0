Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981152;
	b=JD7XxBtq69RLEMNnu5x+d+l8paPGmfl3HLe0jN198/5HgPaIUm09N2nQNCUBoWKyZfyB
	 YYWQpS7Q10qQb/hrOVJk+i1SaxAQ+7TBnN1poNpu0hRFxGzKgeTtDJ0c/Wf7VRAl32R4R
	 GlQ3q7PePHP8l6bACE8SQX7I08rdU7UbPpySmt6Ku4n5ZYi4z+hfWAPw6CqeQ47TSJH+7
	 XeAMoF55gNRgvoRZ6hPjGpehoIDBCMAVvD1vrhJnaLAHsFckGpwHrkKXoIBR7JJC178j3
	 PuNua4+Ehz73lTHOov0nAYLwoppOWS/TXhVbMtRgWgsaA8Tw30KqPW2lHziCCazB96Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981152;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=+cNwt+gUJSYsLFI9L0pTVdxeZNg0s+CZpU43mw4icwE=;
	b=2GaHz1y/nGKuWcy5B9iEv0vh5tAu/IGdwDysnm87iLfVJRzY6nfOFRvTwTue6BZWqSEu
	 fNhdslV12RJ6WdrImhEVgdJr8b5An3T8rFK621z/7I7jqgGlzFyZimwCmthHl061qmKIH
	 haU3M4BJPJ7zMVCEdkB6JaXdBd72q4VbqKLJH8MmBrVz8GkAeZ+6ew7dIHcmONx+hyM2u
	 s+aJ+YHumRoR/BvhWx5iGzgJjyKiNL/iXet0y92IXeLtaO8winKs1JM33hh7V/ZEVVF0o
	 YAYIEV12X5ItUPRAzqXaEZEPwz0hav7a0SahGPa93u5lN4Sg8hPtdQzGKbdNjEChu1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=uHIamcs0;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=OpES2zhp;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40AB606A33F;
	Fri,  6 Nov 2026 16:05:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C40AB606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=uHIamcs0;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=OpES2zhp
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F49Qn833050;
	Fri, 6 Nov 2026 11:05:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=+cNwt+gUJSYsLFI9L0pTVdxeZNg0s+CZpU43mw4icwE=; b=uHIamcs
	0um3JNn34o/HTB8w/E9d6b80fooTke16mo1pFUXcxXtX7xGhy2qYUeugH7A8jVzy
	GNPmX9GNw5kEXPXozCMXe/AXOGy+EXiIMe1r7RBQrCEM2OnFuCjiLF/undlo+ee1
	409H9vwANybSoRN+VbvMdl469pCfz13qnv0o8Gm6M4zSbOW3tT0nd2NjvGSg4Rks
	GXMopJNxR6X7aGPX1Baw5qrUUiOYHIMnnElvOFnLFnPJonUbv479jcV1GKGTKbXy
	6zJnNYP70Q5d4vuNbuVYL/w3lNUHJgfk2AwlWVcpaAEe41TTa8iHssxuwMTxgKkY
	mU+JmldsXqXaeLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=+cNwt
	+gUJSYsLFI9L0pTVdxeZNg0s+CZpU43mw4icwE=; b=OpES2zhpbS7W4jUw8uCQa
	KHZvtq/GKjbYJyFHOpM17UOtfunVnucDKPhoJU/PnPIYubmrVbumESaLmUerV7YA
	mYsTD3gKpP33tUGSOX+rZCrf9S3rSvKTjmhFRqc8VO5zyZCz41C7jFGNc+mchoCS
	QdovSNv+JYhXSX/hc0Adb83eFo0HyC0STJXx8Vz900kXH4ku3gdyDFadj5hCzcuM
	+/P3RqpoKxW3Ug05uqUqENB8nZCz+2jJXSOsiEO7MNFn7s/qBnrsOa7VKv51Ny68
	ofl6cUmcJENS/XoDrk+xeJJm/TckPZkOt7FbcUJh+noFIv3HX5VcqlFnvvdes2gY
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hs3q052bb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 11:05:48 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 6A6G5llo052468
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 6 Nov 2026 11:05:47 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 6 Nov 2026 11:05:47 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 6 Nov 2026 11:05:47 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 6 Nov 2026 11:05:47 -0500
Received: from arch ([10.135.2.92])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6A6G5TDJ016340;
	Fri, 6 Nov 2026 11:05:39 -0500
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
Subject: [PATCH v3 2/7] pwm: axi-pwmgen: report the waveform step
Date: Fri, 6 Nov 2026 18:05:14 +0200
Message-ID: <20261106160529.876251-3-Nicolae-daniel.Deaconescu@analog.com>
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
X-Proofpoint-ORIG-GUID: PkVuwnvN3SSgMF0l5I2ReT-_oU_8pf_6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2MyBTYWx0ZWRfXxtvIYXo9bPwP
 modQXKAJA4wQ7Myld3b28MpDRlXlhfM1hN13i8wORYsIQx3VnFKx4h6OHyYjxqSjcrm77n/A6Un
 eA5VmTKscWSMhoGSVD3TocOjul8oY1cHDfUv93kzp7SVeefWq+iK
X-Authority-Analysis: v=2.4 cv=Lt8HWXdc c=1 sm=1 tr=0 ts=6aedfadc cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=aASXySr_LHO6eXd1yVMA:9
X-Proofpoint-GUID: PkVuwnvN3SSgMF0l5I2ReT-_oU_8pf_6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2MyBTYWx0ZWRfX9Ty6O/eqwjGX
 qvNxSQB4rZIsNEHZ9V3teZHKP5G9MOLhK81/6f6IjbXKcIIycD40NW+aXMQ1CjFCga9gTRmUhFA
 ofUxybliw33Z8DTYkS+IChAts+37DkZPtIEPi3/sBY9NionvhyqtJlvM01kiDx/wMlKKsB5hNTC
 /VXIzHgItWl2GThrCKRirRzuX4VqeBbBieQtHgUdWvgc91iGn81m4bRk3nsbQdWadz2JqMEQ/+4
 CoX3fHLDvilg7I4bO1QY7gmsmcXIGtZWRr3CuinBuV+fou77pgWMiMIxft1JxJNUdPkB8qnkQbZ
 nt4sYbcasysqtZSwsalRWtzCVL/D1LeImTz/9iaqMjEi/8H1ftjIfjHvbYice3vFrxecqFJaWZW
 f+Ken7sbrkO3bCUgxooB8GkEPSa51EjFuxWCvhu2aLd1fvPcb5KQzJZsN1wnBRXJE7koVgbJzUG
 P8FQn6gYw902AmcRNvw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060063

The period, duty and offset counters of the AXI PWM generator count cycles
of its external clock, without a divider. Report that clock rate and one
cycle per step.

Signed-off-by: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
---
 drivers/pwm/pwm-axi-pwmgen.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
index b40522f01002..6b15244efabf 100644
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
+	step->clk_rate_Hz = ddata->clk_rate_hz;
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
2.56.0

