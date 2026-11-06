Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981150;
	b=0Gn5Je1tODxPiv7LFnYr0EKKRhvrTxbi/vocSF47hR52SY00/6EGWEWapYZqxefM8paK
	 8TxDvmHbiwWxD3Fm2zHoekD33+59ot/X5bJYTP/fADBljBxhNirj2ZTo7L/XXObc0LC5l
	 NeeS/nrfLz8O+xJhdEGcupU2lDaR0iRpLUEOGMcKw72nLrBsIeb9EDUVPuiJ4vPnHbPea
	 J/CdUWfHFkUZMZSs6bwBsLPeglegkPFWNi35e6dDAH/HbeG4TIB6sg97eFCfWwcxH1Uko
	 KmvklHiOoVGlQ1TR0dMSr4d2CrKoIF/GwdySQcLmqs2TTrFGxODaKJq1czHiz4m7lCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981150;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=pR2k8jySF6aNsQGNkq82mR/Qt6mHsapdF37Q1IrGrAY=;
	b=vzeFUOLschqSGANActs67AoC6UGO8G6gSw9iuPCntMKk0vg0BWMA02I0Fz7fgFp86NwD
	 8cG6KgMWJUJIUwKvgGcBUcv1K41LnVK+97NUdC2HIXMqo0PftWgratjGlywjMWcHf+T0s
	 6vGrK+NgYIbDM96cDq+kPeCI+7v0Qsx5h8jzKjGP2H2EqjXYdMFf/ItGZjrDaOqXD6j2Q
	 h8e2JqJjXbUzbcUGAo7dxZATOTKZLYNA3+Y6rTJ1v49ZR2zrJaNaHE0nGG5oeaXgBk7br
	 jn/Xwa1jiPXzGJ7s9lzpmD9renEyuaXIp5c4Gd8R8KdNyI8gcL15ydUFZv1AHC3ha4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=TACoRZcY;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=YVYTbojn;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F327606A331;
	Fri,  6 Nov 2026 16:05:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F327606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=TACoRZcY;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=YVYTbojn
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F4FAT3366340;
	Fri, 6 Nov 2026 11:05:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=pR2k8jySF6aNsQGNkq82mR/Qt6mHsapdF37Q1IrGrAY=; b=TACoRZc
	YpcuafoUgI3VNH05/BpDJWSYN7dPhAQ1DPbwRaVTvRqxjb34SfvpTBQHWN9lIXHS
	yXypfX2Xctis7YRS4LXBQjcNRvTPQoQfmZwcRIAxUErPNBDZF/jCXmsCK+baSXcu
	z9A475qSt0AVFNyeqj/1Z5kTqaefSn3DSUlFClTBTNnVr+6eFxqXTYQswA+c5SSL
	gOaoPtEW7Tb+9A1FnqsVKD856gfd8PFFeb+AuJrb98fObTEBnhdGCtndjC3hqBec
	JII3OuK+o7KEv9hO001Jv6/YILnr5BDo/bLXFHHe3xX79dBY3WBSv+RD9gf4VQWJ
	Ef0u1QUNIRYceYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=pR2k8
	jySF6aNsQGNkq82mR/Qt6mHsapdF37Q1IrGrAY=; b=YVYTbojnmcSF3P3dK4hq3
	zIC9EuxBZ+KPdIpWtNmcZb65iPRrKp9SLrPJqgD7b2whS9wF98MdQcHLI9PVac2+
	HxkML7iuWhJxxUwyrky1aU0IqYBtmE1NaFRWkzpjOOcoHxfIl7V7IM8ZlN111zSP
	q+zRb4xJ72cLAb0C34PamnlBfI01Gphpdtg6KeERJ9Z4X01a05CpfYihePH8P0R1
	hhRExWMTgx9eDGMdwr05KHwhfVh9AwYTksehwgkQGUP1JMv0JwmyMopNLOySNTaA
	qfw/mYtPvZO94oYp4+ccwrMIoS8L34utGPOBKsLIvQtFRh8dDVCtuyUou1Rww6Bu
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hs3qacyym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 11:05:45 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6A6G5ilC036359
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 6 Nov 2026 11:05:44 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 6 Nov 2026 11:05:44 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 6 Nov 2026 11:05:44 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 6 Nov 2026 11:05:44 -0500
Received: from arch ([10.135.2.92])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6A6G5TDI016340;
	Fri, 6 Nov 2026 11:05:36 -0500
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
Subject: [PATCH v3 1/7] pwm: core: add pwm_get_waveform_step_might_sleep()
Date: Fri, 6 Nov 2026 18:05:13 +0200
Message-ID: <20261106160529.876251-2-Nicolae-daniel.Deaconescu@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2MyBTYWx0ZWRfX8S/D1COKpCg7
 kQ3/rFtsEbHfZO2HVZ8Nc0W0fd+cbp6YbXP24XIDoOkhY8H5dNcHp4K3576IY5Ia6cChK8LX5Hk
 Nkq9KjCpDw/sbf3YtH0gjDpOpx+4FvjEXE7BdpyBEsSKK2OvwJzW5iJeoPr9kBMRtypcV/sx9F5
 6S1Oh8jxm2o2YD1oGgycjxG2/s4J8EbIbPz8aZIVCpjLmAX6deq8Rpf/7qLUEs4AOfpW2P9WVyz
 eMQFT8CyCEE5c9Ot34Sf8dFz0sZ1m6p/64bD4oGHMBm2aDIS6lc5x1ubMtb5HVgosB6r4RN89b/
 qCNlmgyYp7mG+FUu8/QVJqAa7pQQIcldlo9C3xmuyOxqEtr06Jj9vyCyqklGNkqaCh8cC8yhpeJ
 riUHU4PmZMdShKW2NdoFkaI35qCt2k4ZroV3c5SPs1cLscbfPJD4VXLP7WTU1fybsQexbysfBxW
 8GJmeljj99XYlK0drWQ==
X-Proofpoint-GUID: WD4kmsJerCmrCXVF1_vuKfinS6CETT0O
X-Authority-Analysis: v=2.4 cv=NbBzRGD4 c=1 sm=1 tr=0 ts=6aedfad9 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=_X9df9m0ht8a1tI6V-EA:9
X-Proofpoint-ORIG-GUID: WD4kmsJerCmrCXVF1_vuKfinS6CETT0O
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2MyBTYWx0ZWRfX5fKCAdJHJzjL
 jhevQUwu4dWJwKdqaK9ngH9D37tQM6r/0CjLKnRXtoQX6B6ONB2XV/wJW7yCK8YFB5Oi0vDyiIs
 vd6k298RNXUsBNDJdv3Jy730mFPH2VAU5/1iPVctWNfpHm8Bkl2Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060063

A consumer that must meet minimum times, or place an edge relative to the
cycles of a clock a PWM gates, can't do that with the waveform API alone.
Rounding functions round down, so a minimum needs margin. Margin size is
the PWM step, known only to the provider.

Let the provider report the rate of the clock its timing derives from, and
the clock cycles per step. A consumer then works in whole steps, converts
to nanoseconds rounding up, and gets that waveform back from the hardware.
Without this, a consumer reads the rate from a clock it gets on its own.
That describes a relationship the hardware doesn't have, and breaks if the
PWM divides its clock.

Signed-off-by: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
---
 drivers/pwm/core.c  | 65 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pwm.h | 34 ++++++++++++++++++++++++
 2 files changed, 99 insertions(+)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 2a050ff4608b..c8f9a53af770 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -14,6 +14,7 @@
 #include <linux/of.h>
 #include <linux/pwm.h>
 #include <linux/list.h>
+#include <linux/math64.h>
 #include <linux/mutex.h>
 #include <linux/err.h>
 #include <linux/slab.h>
@@ -325,6 +326,67 @@ int pwm_get_waveform_might_sleep(struct pwm_device *pwm, struct pwm_waveform *wf
 }
 EXPORT_SYMBOL_GPL(pwm_get_waveform_might_sleep);
 
+/**
+ * pwm_get_waveform_step_might_sleep - Query the granularity of the waveforms
+ * Cannot be used in atomic context.
+ * @pwm: PWM device
+ * @step: output parameter
+ *
+ * Stores in @step the clock rate the timing of @pwm is derived from and how
+ * many cycles of that clock one step lasts. Period, duty length and duty
+ * offset are multiples of that step, so a waveform that is asked for in whole
+ * steps, and is within the range of the hardware, is not changed by rounding.
+ * Compute the length in nanoseconds of n steps
+ * as n * @step->clk_cycles_per_step * NSEC_PER_SEC / @step->clk_rate_Hz and
+ * round it up, because pwm_round_waveform_might_sleep() and
+ * pwm_set_waveform_might_sleep() round down.
+ *
+ * The values can change when a clock changes its rate, so they are only valid
+ * as long as the provider's input clocks are not reconfigured.
+ *
+ * Context: May sleep.
+ * Returns: 0 on success, -EOPNOTSUPP if the provider doesn't report it or a
+ * negative errno
+ */
+int pwm_get_waveform_step_might_sleep(struct pwm_device *pwm,
+				      struct pwm_waveform_step *step)
+{
+	struct pwm_chip *chip = pwm->chip;
+	const struct pwm_ops *ops = chip->ops;
+	int ret;
+
+	might_sleep();
+
+	if (!pwmchip_supports_waveform(chip) || !ops->get_waveform_step)
+		return -EOPNOTSUPP;
+
+	guard(pwmchip)(chip);
+
+	if (!chip->operational)
+		return -ENODEV;
+
+	if (IS_ENABLED(CONFIG_PWM_DEBUG) && chip->atomic) {
+		/*
+		 * Catch any drivers that have been marked as atomic but
+		 * that will sleep anyway.
+		 */
+		non_block_start();
+		ret = ops->get_waveform_step(chip, pwm, step);
+		non_block_end();
+	} else {
+		ret = ops->get_waveform_step(chip, pwm, step);
+	}
+	if (ret)
+		return ret;
+
+	if (!step->clk_rate_Hz ||
+	    step->clk_rate_Hz > mul_u32_u32(step->clk_cycles_per_step, NSEC_PER_SEC))
+		return -EINVAL;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pwm_get_waveform_step_might_sleep);
+
 /* Called with the pwmchip lock held */
 static int __pwm_set_waveform(struct pwm_device *pwm,
 			      const struct pwm_waveform *wf,
@@ -1710,6 +1772,9 @@ static bool pwm_ops_check(const struct pwm_chip *chip)
 		if (!ops->apply)
 			return false;
 
+		if (ops->get_waveform_step)
+			return false;
+
 		if (IS_ENABLED(CONFIG_PWM_DEBUG) && !ops->get_state)
 			dev_warn(pwmchip_parent(chip),
 				 "Please implement the .get_state() callback\n");
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index b11ae91723f8..c52f4c9153c2 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -76,6 +76,34 @@ struct pwm_waveform {
 	u64 duty_offset_ns;
 };
 
+/**
+ * struct pwm_waveform_step - granularity of the waveforms a PWM can generate
+ * @clk_rate_Hz: rate of the clock the PWM's timing is derived from
+ * @clk_cycles_per_step: number of those clock cycles one step lasts
+ *
+ * The period, the duty length and the duty offset of a waveform are multiples
+ * of one step, which lasts @clk_cycles_per_step / @clk_rate_Hz seconds. A PWM
+ * that divides its input clock in hardware has @clk_cycles_per_step > 1. A
+ * waveform that is asked for in whole steps, and is within the range of the
+ * hardware, is not changed by rounding.
+ *
+ * The step is the same for every waveform and for the period, the duty length
+ * and the duty offset, so a provider whose granularity depends on the
+ * requested period (for example through a prescaler) can't describe itself
+ * with it. One step also has to last at least 1 ns, otherwise rounding a
+ * length in nanoseconds up can add a whole step.
+ *
+ * A consumer that needs a minimum time, or that has to place an edge relative
+ * to the cycles of the clock a PWM channel gates, can use this to ask for
+ * the next possible value instead of one that is rounded down, and to compute
+ * the frequency a rounded period results in without the error of the
+ * nanosecond resolution of struct pwm_waveform.
+ */
+struct pwm_waveform_step {
+	unsigned long clk_rate_Hz;
+	unsigned int clk_cycles_per_step;
+};
+
 /*
  * struct pwm_state - state of a PWM channel
  * @period: PWM period (in nanoseconds)
@@ -287,6 +315,9 @@ struct pwm_capture {
  * @round_waveform_fromhw: convert a driver specific waveform presentation to struct pwm_waveform
  * @read_waveform: read driver specific waveform presentation from hardware
  * @write_waveform: write driver specific waveform presentation to hardware
+ * @get_waveform_step: optional, report the granularity of the waveforms. Called
+ *	with the chip locked, so it must not sleep on an atomic chip and should
+ *	report a cached clock rate instead of calling clk_get_rate()
  * @apply: atomically apply a new PWM config
  * @get_state: get the current PWM state.
  */
@@ -305,6 +336,8 @@ struct pwm_ops {
 			    void *wfhw);
 	int (*write_waveform)(struct pwm_chip *chip, struct pwm_device *pwm,
 			      const void *wfhw);
+	int (*get_waveform_step)(struct pwm_chip *chip, struct pwm_device *pwm,
+				 struct pwm_waveform_step *step);
 
 	int (*apply)(struct pwm_chip *chip, struct pwm_device *pwm,
 		     const struct pwm_state *state);
@@ -394,6 +427,7 @@ static inline void pwmchip_set_drvdata(struct pwm_chip *chip, void *data)
 /* PWM consumer APIs */
 int pwm_round_waveform_might_sleep(struct pwm_device *pwm, struct pwm_waveform *wf);
 int pwm_get_waveform_might_sleep(struct pwm_device *pwm, struct pwm_waveform *wf);
+int pwm_get_waveform_step_might_sleep(struct pwm_device *pwm, struct pwm_waveform_step *step);
 int pwm_set_waveform_might_sleep(struct pwm_device *pwm, const struct pwm_waveform *wf, bool exact);
 int pwm_apply_might_sleep(struct pwm_device *pwm, const struct pwm_state *state);
 int pwm_apply_atomic(struct pwm_device *pwm, const struct pwm_state *state);
-- 
2.56.0

