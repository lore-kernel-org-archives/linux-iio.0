Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795087519;
	b=3CTmd5dYbLsSXh/3iezDWCnlAiZCsxZKJaU+lWs1jp8DD5KhqL37ffqhxUY6VslSbtv3
	 Ggh3QvUFsI4ZuhX1qJiOxQKGkRKqMjPBQ7FLdInFBMqhT+EQ3BqHeOkFm/MseS72JBllB
	 RLz9f8UIP7sLmUxGYJwtbAVCJ57C43i2gUXBBiwS5FglRGu0P41saIgY8Y51BQSa/O6Sf
	 3iAPVqZv16nXQw47ADztt2km3Zqg8Bnm4uLZj/I6lQpsD++23MGtfBjfBTlUUOpY4eDGZ
	 HiNLmOCQN+AL9CuciCK7dlWExqhWVRLTwf9W0Sekt3M7Yf7vBKfn0TUBlKpZ5js+6Og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795087519;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=SdmfMZw5B+xeSRSzE0tx74A08vZ4+o+YB6IOJQnorus=;
	b=rdxp+4xM0Svgaf3bq3/IwDT+h7avcFgMztUj0eqFLVnd9zrj6pi+fu1VyfY74IBScHyd
	 QwwxUCYiX/TdwNDnt34uJh3tTi8wNiQLUYbKjZs5BNNr8ikkOLCr1YahncpM6FKzj+H0P
	 HNt//mFFYOB5e/iICgHeYQA5dOSJb0uu5PvzelHX7reQ22fJUeryc1x2THjiWcxU9myY4
	 qwA42tjDwbAUb5n8256ECpDyI6bVxLClWPg9ZREA1RB58FzTQIvbrDGekq3Cciyuffnrb
	 IrpzOYxU8CErjfQB/3YkYuCpA9CJ3zX6GCw+eCY4vjj3WvhMit/IuaKYaPgNc7SB2iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b="uJu/NjSD";
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=udFYAsjk;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D81A60A2603;
	Thu, 19 Nov 2026 11:25:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D81A60A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=uJu/NjSD;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=udFYAsjk
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJB04rb1377258;
	Thu, 19 Nov 2026 06:25:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=SdmfMZw5B+xeSRSzE0tx74A08vZ4+o+YB6IOJQnorus=; b=uJu/NjS
	DzY1nkoSB4hL8WJm5AvEEw6mtAlfHyGghohSY01q/Rg/O1mB6KCu5AECuYej8rcL
	Dm8nQfI70FkUNDMeWPHYgmFwqa8HtyFx0xWMbJUYEsfbaKq+OOL86312UkHM1Lvl
	7XkzG5w+t8yJea3ck2MnWSKhY+TpqQXXBF6KOD0ge1c5SXFLI/NfWk7UruC2pBjI
	srTOZ5CCBVVyx/FYQzboyNFz/J+KGkXc9SWPoqhlzKeZArKCLhjwkBrmJ3qTiKwn
	fe4XgGIv/Bh17tK8XNy99Vgp+ytkU0FhAtEhZv2TrwE5fYgzdrKXA2iWrdVLbqpd
	IqIKoK6d8mRdt7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=SdmfM
	Zw5B+xeSRSzE0tx74A08vZ4+o+YB6IOJQnorus=; b=udFYAsjks1UwwzdT7KNCD
	ezpCaEclGIkJ12e9vV2X3f/HzR2GVvZGtLJDoC0l6LQb3p/1KU22wWgcW1r9y+1L
	DtC07kV6tYHiMrN+Okz3nD8phwxlrN0QkL26IpO9jV0UuUxMWovATi43oWDajnID
	Y16JbZPiGXz0W3WWMkPMBTTaF2dxX4+Z611VCJhsPfpldBvT27HpImvsOhvM6e6T
	NE2Hqsjm1bB72pRLV1o/YiWMZSr1Be59RIxF1DI7BCcbQwH8U1J7XiCVO+6ZT7zR
	8LcrFRoWsn977DjabgmQcsFTUw8tKUzk/Cb9eoUR5uuuxz6uknFZLXXeJ7TtrmK8
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4j1ptmu38b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 06:25:16 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6AJBPFVt011121
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 19 Nov 2026 06:25:15 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 19 Nov
 2026 06:25:15 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Thu, 19 Nov 2026 06:25:15 -0500
Received: from arch ([10.135.2.95])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6AJBOocK010881;
	Thu, 19 Nov 2026 06:25:07 -0500
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
Subject: [PATCH v4 3/6] iio: adc: ad7625: fix sampling frequency handling
Date: Thu, 19 Nov 2026 13:24:17 +0200
Message-ID: <20261119112437.197306-4-Nicolae-daniel.Deaconescu@analog.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119112437.197306-1-Nicolae-daniel.Deaconescu@analog.com>
References: <20261119112437.197306-1-Nicolae-daniel.Deaconescu@analog.com>
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
X-Proofpoint-GUID: YpJfM1rw4EEv7qQtqdlA58aLSIxoXQzP
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA0NSBTYWx0ZWRfXwKx2SIq6+tDE
 bMm8ox+Se9yekpSsDSXNsv5eZFTyoruv0R1ypfAKCdmGVIZlUJ85C+ktHDvr8MD+FF1WVWAWjUT
 TudYV39L+6JhSmBXIny5kby05SfDLuRO13hptkAD1cHsVbMrSmh4
X-Authority-Analysis: v=2.4 cv=dqNOmFg4 c=1 sm=1 tr=0 ts=6afedc9c cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=8MR3j3Xn5CCrLiW-EVgA:9
X-Proofpoint-ORIG-GUID: YpJfM1rw4EEv7qQtqdlA58aLSIxoXQzP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA0NSBTYWx0ZWRfX5OsLaujvfVVp
 84t9YrqEHgL2k4Ud23g4xx+Q7WULVvuHyXenfskqPOe43gy17epNSgm49nKoHnqbAAHiRJ8Tbyx
 /fxRwebm7VNW1Ts45GUCwj/uA/ypRziuZ6KZSRs3HX8cLieKhjbLUJW6FCnQ5BQ6S1YIhGcvnWb
 oyHqVUL6oiFjmWczf1SpzwjGSrx2Ta9NA+RxEHwLDEm3w369eySSl3ADL3LiiyMGVCawPpdmmEg
 ZY2FE6pUUah0jfkwHiOZyYE/HJWJLeuZaALkTg/5FywIEpDm6I9SHuFb9RFoQ/qWjGxQIzwV9ji
 YRlMMxIoCvHfdE/eEp0cJlbV7BjvZ92BKqVSmeMf69yhYZYbQZldWmdUclrmazkiaXT3EA8LMt7
 3NG2HxJys1tlaLfX6HE/F/dTw68iM8OfUrOLmk3H46kkwaNhOCcSBW85cFalaYYUttOEhdz+M+f
 uNPyEe89EHlQ0/dcwBQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190045

Fix sampling frequency handling issues:

- Fix issue where writing 0 to sampling_frequency caused a division by
  zero. Return -EINVAL.
- Fix issue where a waveform rounded up by the PWM went unreported:
  pwm_round_waveform_might_sleep() returns 1, which
  ad7625_set_sampling_freq() passed on while dropping the new waveforms.
  Return -EINVAL.
- Fix issue where probe() continued after failing to set the initial
  sampling frequency, leaving the PWMs unconfigured. Return the error.

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

