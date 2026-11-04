Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793798578;
	b=afV+t9XpqdLhGd34aybAcnLxi0DB82zdPe7Dz+1ykHxK1YVCOu8gOlpJ6qOp9FoVhxJX
	 AS53mkoUuHf8JxUhqDDvxVM65dH4dDGJE7zf9nNQdByflA2QVnxJbfyOwLKFjMYjcw3cg
	 G+ZBrcI6pxPJEfqJc4WDDvPKzwKKtp3/S6Wr9dheDSoPQcgh5sZeO2GADN+LrblF2rFrs
	 ck41yiC150mysVa5lH3nMwZ5vrSBcxEBmdNy+hatrKWv2TJ1ckK6Jnt0JPzXn7zgV/CEz
	 y2jfq4y1UDSoNeGPcUpt06aR/djN+/X+DBmJi229eWGrkOxj0tZ0ZmDFJtU8OfATCxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793798578;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=3LvEXk5FHs4avjcyN0cE0WqhxnHG/x+L7FFkra6vnXg=;
	b=HpSH5tnHCle9PAftGG27357IMSs14KHjcBDX640AIKo4BGalRYSNqJgORt/ql27aqtVp
	 A65T9WCmsmqGxIgcAq7YaaJ0vLBUJcIq8a8T1sj+1E3kkL0DjbnLRteEcgha1Fug7JPqz
	 3x5ywZFndvhahN8KJycqxoCfdxsm4K/Pe/Q8y2WjP9PdD5zRB/7C0WuEO+9YS/+S0GXcn
	 i4Ifm+dlPjtijZ9xuq9hM/CfO/QjkX3TnqnRW221ko9zCzQGOCOyfMjBG96AzdrsrYk/C
	 QgqzZiAO6QtdCa4I4hpiChlgfGt5k05jDmr1jS9hQNKPqGoAn3BreeJh/bf31/c4XkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=R74urMFL;
	dkim=temperror header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=iLC7q4VZ;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D61B606A31B;
	Wed,  4 Nov 2026 13:22:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D61B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=R74urMFL;
	dkim=temperror header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=iLC7q4VZ
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4BdFE01972390;
	Wed, 4 Nov 2026 08:22:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=3LvEXk5FHs4avjcyN0cE0WqhxnHG/x+L7FFkra6vnXg=; b=R74urMF
	L2MYVaHKD/TTfWkP+viDuTplFOxehTFF6KhBAMkOPlEt0y+2oZnXtCakq6F8KWzM
	J6M8r5wpbgf9aNeDJqIL9ram5nk4EPOUIaAr969SN1iTMyV9q9GEcc4eFJC4SeqT
	/D+G0b/2Av11n9Vi4bLvAKWG8+DwafH2REewOiBxTGOeCOT1bbBpwKkhYABAeIGJ
	8xymge0U/ydOpjlhQi+eVM5g2XTwgiS5K4L7igiaTwpUnz0xEdbPBwMySWOcHFHR
	Fz4tv8etgEdS6NWVro0/VO5y2ZFyNIX4eSi8ra3isBBOMzvlAG4WEFPxrinDUaJt
	R+Nz70OzbMk+FVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=3LvEX
	k5FHs4avjcyN0cE0WqhxnHG/x+L7FFkra6vnXg=; b=iLC7q4VZPUTkWggPBriGp
	mrJPPJ5lpMDfofARhmCVxasEfwXXcPS7/HvaIkvxyGsL/ZYn4n/xQ4RHjfTUXhHP
	sU004rhT/o4+Qw2gCPd5HAXzkG42UIP79Y5RHAB7mN39LCHwP+da/nNaniSpTCqm
	J5dQoqEjVDZwV+Jh+SuHmc3taNFnvMdybUm3Z6Pu+KANsHPzLHqh9xwhAG2QFxgS
	RA4G5Vo8FFZks/uiFQH1Xf15ETOVeHPJssS0OT1vtIDc+NfLbczOEZPOa4APhDd1
	GuQSJ/ja2lLsBOlgQfYxKgB5n1pu+SrHLD8ibftcLon2XBtzBpGm+cxBlnvWMI6W
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hqk2pwy2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 08:22:47 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 6A4DMkwO028044
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 4 Nov 2026 08:22:46 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 4 Nov
 2026 08:22:21 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 4 Nov 2026 08:22:21 -0500
Received: from HYB-aFjnqsVU6Ag.ad.analog.com ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6A4DLnao008011;
	Wed, 4 Nov 2026 08:22:12 -0500
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
Subject: [PATCH v2 3/5] iio: adc: ad7625: fix sampling frequency handling
Date: Wed, 4 Nov 2026 15:21:41 +0200
Message-ID: <20261104132143.215581-4-Nicolae-daniel.Deaconescu@analog.com>
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
X-Proofpoint-GUID: bHbkJuaiVQ1FKcjGJX0H6GMlGNUPw5QA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA1MyBTYWx0ZWRfX6Ma72Htyg4Ls
 2Osfobr14PK/bB4fn1Fl3HBMP+AzDhHQ457w1WD22oHev7CNIdFZ1+AYDK1xHstDprze/1XKrML
 LFcEDlEnsm/pLygo3qjdbaD76Q4wsPBCnebHG1VeyJlpPae6BHp7
X-Authority-Analysis: v=2.4 cv=NPlAaE6g c=1 sm=1 tr=0 ts=6aeb31a8 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=GsnR7v6S-VPzw9YOTZ8A:9
X-Proofpoint-ORIG-GUID: bHbkJuaiVQ1FKcjGJX0H6GMlGNUPw5QA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA1MyBTYWx0ZWRfX0k+PLEMyJugp
 LFit1OqDspHGRYnhGt9q7X9ERd06XKBPZBrQzp9N67DaBN7jiBuQdGBRsI4XPXpFnADx6jEwdhV
 j3JJnaBo2KX96bxA32It+vshWMKi4G3Kf6GOfoHIKtYI9F7DBMHnbXEOC1dKHMVg50a6qZzyGUQ
 F3oxyM+O1BrGEYXmGOcfx8FvXxevRDep+fk+D4Nmt9yMeqdNXicAIrRy/emKQXtKthxJ/SB4M02
 jXSGRZsoOVWpyi2DREg/JssOU2WSA2UvDeL+2OJ7D2ogAEDdfutJJN9X/eIP4rWy8tMwv9WUTHk
 abbQFoVA8tLGFnOX402DiAKh3tyfXedmzGOjvSbbQpwo5FebmT+9s1ix1QVQozhjFYZZ6/m7fmP
 byoT2fTZsls5tENZYrLVyH0Q1qqF3LUVcKr9ufqradRcu1GQO4BQWIdMB7zcubnpSik3bPZ8AOd
 TRimLvmBXn2x36SesZg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040053

Fix the following issues in the handling of the sampling frequency:

- Fix the issue where writing 0 to sampling_frequency caused a division
  by zero. Return -EINVAL instead.
- Fix the issue where a waveform that the PWM had to round up was not
  reported as an error. pwm_round_waveform_might_sleep() returns 1 in that
  case and ad7625_set_sampling_freq() passed it on, so the write to
  sampling_frequency returned 1 and the new waveforms were dropped. Return
  -EINVAL instead.
- Fix the issue where probe() went on after failing to set the initial
  sampling frequency. The result of dev_err_probe() was not returned, so
  the PWMs stayed unconfigured. Return the error.

Fixes: b7ffd0fa65e9 ("iio: adc: ad7625: add driver")
Signed-off-by: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
---
 drivers/iio/adc/ad7625.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7625.c b/drivers/iio/adc/ad7625.c
index e73a5c9e7f0b..0de7f29797ef 100644
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
 
@@ -189,7 +192,7 @@ static int ad7625_set_sampling_freq(struct ad7625_state *st, u32 freq)
 
 	ret = pwm_round_waveform_might_sleep(st->cnv_pwm, &cnv_wf);
 	if (ret)
-		return ret;
+		return ret < 0 ? ret : -EINVAL;
 
 	/*
 	 * Set up the burst signal for transferring data. period and
@@ -206,7 +209,7 @@ static int ad7625_set_sampling_freq(struct ad7625_state *st, u32 freq)
 
 	ret = pwm_round_waveform_might_sleep(st->clk_gate_pwm, &clk_gate_wf);
 	if (ret)
-		return ret;
+		return ret < 0 ? ret : -EINVAL;
 
 	st->cnv_wf = cnv_wf;
 	st->clk_gate_wf = clk_gate_wf;
@@ -646,8 +649,8 @@ static int ad7625_probe(struct platform_device *pdev)
 
 	ret = ad7625_set_sampling_freq(st, default_sample_freq);
 	if (ret)
-		dev_err_probe(dev, ret,
-			      "failed to set valid sampling frequency\n");
+		return dev_err_probe(dev, ret,
+				     "failed to set valid sampling frequency\n");
 
 	return devm_iio_device_register(dev, indio_dev);
 }
-- 
2.34.1

