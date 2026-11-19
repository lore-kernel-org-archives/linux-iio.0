Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795087514;
	b=3+nIor7Re3G2LkO1VTQ+o3PX+lYJCQcVmG+iMkpmH52pSmJVkxK0qBMBSDfPFnIAJTNL
	 WkWUQHGBzRdQpCFhGbfuYbY0xvY7ho1/Qiui+vYMsnxTWI5Gcj8AnrEHlqmz7JUzc6jnc
	 0U3+J3nH387OJMMxW/RDj3/1lj89/NWBvjmLQ36kmjvnzGBNC2v/lwUq0lRF2egOIkjYo
	 Q497wfu9Kg+MghdEZnPj1/HIjL94e5s7uHAEe7pE65FG/N0OoXSrvHS/OltuTrAOm+07o
	 g8cHEbfWYgWP9LjBTxjrEeSbWFxUo/6o8jQo2TS30FDNI8TKDYBY4wuFqBoCpGOlOTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795087514;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=THcBf87oz1eX07+briADBz7uklAtcodqUOv06L9IAUQ=;
	b=v//L/HaG9dXb3H0eejvMpUoH7D8w5JBZdL0vJcQ9wKEYUPS/UjdOtHUNiKr37BuNdOgL
	 pZqzs13zpxj30jI3+6F/DEmYEODJQf175834IYZir2gl1Gieph8eKmCafUVPQNTKS8TM4
	 JBCt777gWRNKnoGefzWPqYCKYkoDTfXpPHrnnfdQhxv40alAocvPl73OcTbAQjD5MrNh/
	 7n7boZznYJCeksyWXFFQiyWxkr0iwWHWbGPjsnllttljh1/83xEMS0SDXwtWzKMT86oqu
	 QB7KxguulGA9L/8uSwqhzu6vcuKTedNiMvX9arsO0bs3xG09TXYCNq7xW22SmxreS3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=mzVeFQ4h;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=toZz9QtM;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19247606A330;
	Thu, 19 Nov 2026 11:25:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19247606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=mzVeFQ4h;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=toZz9QtM
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJAxYHL3113107;
	Thu, 19 Nov 2026 06:25:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=THcBf87oz1eX07+briADBz7uklAtcodqUOv06L9IAUQ=; b=mzVeFQ4
	h/382g4vnRLHDBk+6WHVHIZ3bDozNafVxVqi3yS0PrdFj7ddpt3q/PlPV6HUzBlA
	M6rPVknLXpmZOfI6YFntZvOGztf4fxMc4FsiQoKAlIhpW5OhZ3CxdCnY3zVS+XJv
	Ow5L3KdThFIwUZpnswjlLjVPfvqkYKQbPxmyF/nQ3D3HKyVVOFfWf+IivlXbkh2x
	iUwo7ZKuvyU34LYLcmRQD2nZuupGDsg/Clwb3UuW6Kf3DvTJokNEOdQ7lCTwEoZH
	AD8RDhqpT6gsOcOwfomrj/zT7e/cu/MKMSeaj/Oxi3XCJt9IXHBxfoSYhAUDuKfb
	P+mCLt9iqo6gpmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=THcBf
	87oz1eX07+briADBz7uklAtcodqUOv06L9IAUQ=; b=toZz9QtMymFF0LCAnh6dK
	7Tx/6yNzFolVyOw2zx3OB/nDltod82MO8UEnbLUHuvovu03gMRD+N1nbBAYRTC0h
	i+rp7B1rwQLocHi39MiccYn7wmkMbY669Sn+WxhNOgnRXS2X8hbsyoQMYuT/zb3o
	jMcAo9DgNp1Uc2OlQmoj699TuCQSPGdVF7mJLWJxt1cutEtOLMbUdfUZsevxvi9z
	cOxX2FL4/d9eUtlAZWSOuTVpKG78cd3yWJxwDu/3LF+h0/iecVSwNIWWJqzbpnZ/
	2AZNFHRRtYWLv/lIlVBh75tqrkhwoXaBJOFInYX1rdwV6UwitC1wQaZFusMnHaOR
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4j1pbqb8an-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 06:25:10 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6AJBP9jV011110
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 19 Nov 2026 06:25:09 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 19 Nov
 2026 06:25:08 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Thu, 19 Nov 2026 06:25:08 -0500
Received: from arch ([10.135.2.95])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6AJBOocI010881;
	Thu, 19 Nov 2026 06:25:02 -0500
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
Subject: [PATCH v4 1/6] pwm: core: add pwm_get_waveform_step_might_sleep()
Date: Thu, 19 Nov 2026 13:24:15 +0200
Message-ID: <20261119112437.197306-2-Nicolae-daniel.Deaconescu@analog.com>
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
X-Proofpoint-GUID: eLyJoSbRe1zXhY4uYgMGzLHayzNZsHVf
X-Proofpoint-ORIG-GUID: eLyJoSbRe1zXhY4uYgMGzLHayzNZsHVf
X-Authority-Analysis: v=2.4 cv=LNzz05W9 c=1 sm=1 tr=0 ts=6afedc96 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=_X9df9m0ht8a1tI6V-EA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA0NSBTYWx0ZWRfX5JIw0m0zd1LO
 WKanRfVXokgysxfIkhGwDZB/rwW6vtfttsU8tpM/wHyO5sjHO4oToKIy4beAkuAeQUwjz9N3h7X
 4P0uo+84f6f2uLhz3noUTGZSO0cjL1xJktqWa4T4fnbG+uNB5ej4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA0NSBTYWx0ZWRfX4Pq9neKyEbMi
 1o1TdFyyzUf3sp3I2ULa+b+WD7BHXEnBgS03pTTHW97X/bKVWH/63PQ0TOp4JezQTPHJvOM0vk5
 gKYJBkN4IeeHXV/USYjvsa1EnmVaTgJzhIetEl6u9GpVtWwyLjwRA0o2GI6D9scMRyPabHO/x9Q
 z6p6FD2ydnIqIGgmcEiY+LZNH+3UenCr9cZy425Pdtu2kGI9AzlpOqUUzHgFYkyI4UdQ7iclkcP
 eeCWc+6DpciwmUs8uConqtBowktVw020nSr9lCFpxLafe+U+Yf9WiLhrbQikVZtYXTaHXPXUmE+
 T5PUW5FHf3XhmyqDmD2WG27J6gmyVslk6wtGI7HLpU/Wnwq30FkTQjVNOoi7XwFBd47JrIdd1us
 iQ9+6ltJXcORu2zc/CBj8zkp0X85qCKLfPSdpJyxI3WWM/fGBbuptopvQNvq4924HAjhBKTYcTU
 FbcNbrpixhgub1wRmfg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 suspectscore=0 phishscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190045

A consumer that must meet minimum times, or place an edge relative to the
cycles of a clock a PWM gates, can't do that with the waveform API alone:
rounding goes down, and the margin a minimum needs is the PWM step, known
only to the provider.

Let the provider report the rate of the clock its timing derives from and
the clock cycles per step. A consumer then works in whole steps and rounds
up when converting to nanoseconds, instead of reading the rate from a clock
it gets on its own, which breaks if the PWM divides its clock.

Signed-off-by: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
---
 drivers/pwm/core.c  | 69 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pwm.h | 34 ++++++++++++++++++++++
 2 files changed, 103 insertions(+)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 2a050ff4608b..a63b8f65a43d 100644
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
@@ -325,6 +326,68 @@ int pwm_get_waveform_might_sleep(struct pwm_device *pwm, struct pwm_waveform *wf
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
+ * Compute the length of n steps in nanoseconds as
+ * n * @step->clk_cycles_per_step * NSEC_PER_SEC / @step->clk_rate_Hz and round
+ * it up, because pwm_round_waveform_might_sleep() and
+ * pwm_set_waveform_might_sleep() round down. The product can exceed 64 bits, so
+ * compute it with mul_u64_u64_div_u64_roundup().
+ *
+ * The values can change when a clock changes its rate, so they are only valid
+ * as long as the provider's input clocks are not reconfigured.
+ *
+ * Context: May sleep.
+ * Returns: 0 on success, -EOPNOTSUPP if the provider doesn't report it or a
+ * negative errno.
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
@@ -1710,6 +1773,12 @@ static bool pwm_ops_check(const struct pwm_chip *chip)
 		if (!ops->apply)
 			return false;
 
+		if (ops->get_waveform_step) {
+			dev_warn(pwmchip_parent(chip),
+				 ".get_waveform_step() needs .write_waveform()\n");
+			return false;
+		}
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

