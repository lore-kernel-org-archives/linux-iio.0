Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793798572;
	b=SVPw20BuB986sjGV/+n/VstJsf2vNtxp3QLu2FW2mBo5WvxP94MvnAuGs1/au+Xt7VlE
	 5mnZi0zOlPeAq3c3MmlCVAMzMFKlmWt6IAq1wG0/HMmqlc7k2uf8t8bf9foTYqMwjMAyT
	 iJSAdgMcVMAq0nT1IXHK4k8DXPwfOmvzAyXTZWdw6VibBjX2Dhvk5U4uEoJfZA2I3J5Zs
	 xBvI294jfwK8OGAMoitrgWLy4YKnpNG0lCi4U0efSFmRZTUpGbn2J9BMfaKKxRtmqJqCd
	 sRBxBihGZ4tayymgZzkFTO3uXU9eKLiYxRv3wBlKTmqLzq7AyFZM4qqJnGh1wfsBhJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793798572;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=YDZHR9qFsO6dyLaqAzaJixg0alKntbG5o2zWYPGUTq0=;
	b=1dC9Z2S6NbJQNbqaha9Bla3zK/fcS+gzestnbDOMsTgWGZg3i1Cu4qfgkl3XBsF3ERTv
	 wvWRwjnNEakCtYJNNj/cSwVIFW01Be1bXzdcCBJp5U4DhMbG7AcacuVPN65kksDp/FbHW
	 xlQFb75JOTlD47OMJshJcHK3x6MUplP+AxhwDqRbqdgw9ctH0lVytEp6c8xS6hoLE70II
	 Pt+920PoHQdqVOLpWdqLuxZwCmDU3tAC9dsJ0qrSV+AZq1UJOFPkfVu0FeZrsxxiOZ3hE
	 Ucw2QhFQz8BVt/JRT+ccsqiSbGmqEr0CDJJg0iSh3DWq1PStl0760cToQZDEq6SERtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=DpqUf65t;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=FQNjjFeK;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D639606A326;
	Wed,  4 Nov 2026 13:22:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D639606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=DpqUf65t;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=FQNjjFeK
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4Bd19K2876149;
	Wed, 4 Nov 2026 08:22:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=YDZHR9qFsO6dyLaqAzaJixg0alKntbG5o2zWYPGUTq0=; b=DpqUf65
	tw8+VEDDTgaHwpBMDPsUjItpG+FT35ltIr3JJFjXJ52X3rblYF+aAO8A2N4qNJke
	sylJ+Tnzl08V5pLVte6AjuJM1r+xvGKBiZv2sZ3lcYm2StmI09xoeQVwcSpfGYJT
	x5kMrQaPMeQ1wZU8+QJXSkK8SuyYzZodqwppLiwZ/WhQLX4BD7rfxdAjO7tOZ1I5
	AOc9bhY2WSP6crnjDnSBsNRTjgPiivFsSsqsLrNSJY/1LsPnSELU89hqbLKVwe5+
	m+C9m09Wg0GCRgUkuEgPg3csQLOWd6FDbb/Fz25hz4hK1nFk7A4G64f4Bubu+o/3
	UOL+VORnswHwoXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=YDZHR
	9qFsO6dyLaqAzaJixg0alKntbG5o2zWYPGUTq0=; b=FQNjjFeKzixHCYFJ4aWlj
	W5hJPrNPNcRVnYtvETAwo7d41TYUjj26ib9TDiwI16YpRldin56Sh5FC6GChvEG3
	t0I+rlfJspbT/5mFuJAPejbHIr+FDnk1/1jqjB4Ep7PNXKSv3GMRwGmzLzENsqdA
	TgJXdBZdA0U3b41IzHiVJSEW2adpDbbrKhnv+Wf5p76oPu6ATlACBeifXzmXsNYW
	tuKituLlpYbIE0AafFIhVYLDmjlzMSte2t2DuuwjvG1h+KH29XjMvIjUUGSoKuPJ
	6mPNSOJ/e6VOb2Q1Un2jT5QXT7jP9F+QPLabRUPuw7Da+NROAqb2Yt4sWOSgLeXI
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hqrk4v951-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 08:22:47 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 6A4DMkwN028044
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 4 Nov 2026 08:22:46 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 4 Nov
 2026 08:22:12 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 4 Nov 2026 08:22:12 -0500
Received: from HYB-aFjnqsVU6Ag.ad.analog.com ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6A4DLnam008011;
	Wed, 4 Nov 2026 08:22:03 -0500
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
Subject: [PATCH v2 1/5] pwm: core: add pwm_get_waveform_step_might_sleep()
Date: Wed, 4 Nov 2026 15:21:39 +0200
Message-ID: <20261104132143.215581-2-Nicolae-daniel.Deaconescu@analog.com>
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
X-Proofpoint-ORIG-GUID: 2dN9yWcXiq7n0rc3XkEHiPOAezpt-F17
X-Proofpoint-GUID: 2dN9yWcXiq7n0rc3XkEHiPOAezpt-F17
X-Authority-Analysis: v=2.4 cv=Y7RtIReN c=1 sm=1 tr=0 ts=6aeb31a7 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=drBN_b8uElmDllIq1doA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA1MyBTYWx0ZWRfX5SiYKLkA1CSp
 bmB7w4b0N18E+uFJfcjAGH6H2o/Tf7Pi9QF3urVVnj+ZOnX2MCpSb24QEVWUI+F4EfEkLLEWil4
 VWm8+Q/1spmRSiMRv1kJkO6OeMLEIMFYVwNej/cqX5VXyqyPJ8Lz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA1MyBTYWx0ZWRfXxV8F9hsmgkdb
 5r0RiB2XbzumLmnU8hEM+VmBwI3hfXzM/HNK2JacbqlayuBbOMbiQgfBex4WrnqYondxcQ/a6NJ
 OfSSNPOSbE1LgqVxEKIlwI4G6B3aoXLYSflnVNcEjoQSum6/+T8pwzw2XOqTD0rBHmf+e8gh8mo
 YoHxSCUBXbEL227RUvS5pEhYCdDmdEOXU/SM3Dag2d6r3QpUCp0HArJaWhlkodfqRs6jRIGVuSH
 D3ID0nsMp4NMpgeLA8gLyfQO+SObcMtChVpvuBlRM+8nfPby07+PwodVnMrf1i843hxTAJL2PON
 zddZjWHyuA4OHRnlRDXrBaAcyv0WnxyvlxZJaYP8qjJl2+xAyVlvjjOwrJZ8vwBAYCjnO36QiQW
 MrHB499bDNLv66iYJuuL5TnElzhc6fRsF3Gw6O/BIB4VAScSJlmEt0Am4priTPMVMCu5WliKLui
 UIUBpTQpS8c3co6P79A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 bulkscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040053

A consumer that has to meet minimum times, or place an edge relative to
the cycles of a clock that a PWM gates, cannot do that with the waveform
API alone. The rounding functions round down, so a minimum has to be
requested with some margin, and the size of that margin is the step of
the PWM, which only the provider knows.

A provider can report the rate of the clock its timing is derived from
and how many cycles of that clock one step lasts. A consumer can then
work in whole steps, convert them to nanoseconds rounding up, and get
that waveform back from the hardware. Without this, a consumer has to
read the rate from a clock it gets on its own, which describes
a relationship the hardware doesn't have, and is wrong if
PWM divides the clock.

Signed-off-by: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
---
 drivers/pwm/core.c  | 63 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pwm.h | 32 +++++++++++++++++++++++
 2 files changed, 95 insertions(+)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 2a050ff4608b..6184f17497f0 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -325,6 +325,66 @@ int pwm_get_waveform_might_sleep(struct pwm_device *pwm, struct pwm_waveform *wf
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
+ * offset are multiples of that step, so a waveform asked for in whole steps
+ * is not changed by rounding. Compute the length in nanoseconds of n steps
+ * as n * @step->clk_cycles_per_step * NSEC_PER_SEC / @step->clk_rate_hz and
+ * round it up, because pwm_round_waveform_might_sleep() and
+ * pwm_set_waveform_might_sleep() round down.
+ *
+ * The values can change when a clock changes its rate, so they are only valid
+ * as long as the provider's input clocks are not reconfigured.
+ *
+ * Returns: 0 on success, -EOPNOTSUPP if the provider doesn't report it or a
+ * negative errno
+ * Context: May sleep.
+ */
+int pwm_get_waveform_step_might_sleep(struct pwm_device *pwm,
+				      struct pwm_waveform_step *step)
+{
+	struct pwm_chip *chip = pwm->chip;
+	const struct pwm_ops *ops = chip->ops;
+	int ret;
+
+	if (!pwmchip_supports_waveform(chip) || !ops->get_waveform_step)
+		return -EOPNOTSUPP;
+
+	might_sleep();
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
+	if (!step->clk_rate_hz || !step->clk_cycles_per_step ||
+	    step->clk_rate_hz > (u64)step->clk_cycles_per_step * NSEC_PER_SEC)
+		return -EINVAL;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pwm_get_waveform_step_might_sleep);
+
 /* Called with the pwmchip lock held */
 static int __pwm_set_waveform(struct pwm_device *pwm,
 			      const struct pwm_waveform *wf,
@@ -1710,6 +1770,9 @@ static bool pwm_ops_check(const struct pwm_chip *chip)
 		if (!ops->apply)
 			return false;
 
+		if (ops->get_waveform_step)
+			return false;
+
 		if (IS_ENABLED(CONFIG_PWM_DEBUG) && !ops->get_state)
 			dev_warn(pwmchip_parent(chip),
 				 "Please implement the .get_state() callback\n");
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index b11ae91723f8..f6e943607542 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -76,6 +76,32 @@ struct pwm_waveform {
 	u64 duty_offset_ns;
 };
 
+/**
+ * struct pwm_waveform_step - granularity of the waveforms a PWM can generate
+ * @clk_rate_hz: rate of the clock the PWM's timing is derived from
+ * @clk_cycles_per_step: number of those clock cycles one step lasts
+ *
+ * The period, the duty length and the duty offset of a waveform are multiples
+ * of one step, which lasts @clk_cycles_per_step / @clk_rate_hz seconds. A PWM
+ * that divides its input clock in hardware has @clk_cycles_per_step > 1.
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
+	unsigned long clk_rate_hz;
+	unsigned int clk_cycles_per_step;
+};
+
 /*
  * struct pwm_state - state of a PWM channel
  * @period: PWM period (in nanoseconds)
@@ -287,6 +313,9 @@ struct pwm_capture {
  * @round_waveform_fromhw: convert a driver specific waveform presentation to struct pwm_waveform
  * @read_waveform: read driver specific waveform presentation from hardware
  * @write_waveform: write driver specific waveform presentation to hardware
+ * @get_waveform_step: optional, report the granularity of the waveforms. Called
+ *	with the chip locked, so it must not sleep on an atomic chip and should
+ *	report a cached clock rate instead of calling clk_get_rate()
  * @apply: atomically apply a new PWM config
  * @get_state: get the current PWM state.
  */
@@ -305,6 +334,8 @@ struct pwm_ops {
 			    void *wfhw);
 	int (*write_waveform)(struct pwm_chip *chip, struct pwm_device *pwm,
 			      const void *wfhw);
+	int (*get_waveform_step)(struct pwm_chip *chip, struct pwm_device *pwm,
+				 struct pwm_waveform_step *step);
 
 	int (*apply)(struct pwm_chip *chip, struct pwm_device *pwm,
 		     const struct pwm_state *state);
@@ -394,6 +425,7 @@ static inline void pwmchip_set_drvdata(struct pwm_chip *chip, void *data)
 /* PWM consumer APIs */
 int pwm_round_waveform_might_sleep(struct pwm_device *pwm, struct pwm_waveform *wf);
 int pwm_get_waveform_might_sleep(struct pwm_device *pwm, struct pwm_waveform *wf);
+int pwm_get_waveform_step_might_sleep(struct pwm_device *pwm, struct pwm_waveform_step *step);
 int pwm_set_waveform_might_sleep(struct pwm_device *pwm, const struct pwm_waveform *wf, bool exact);
 int pwm_apply_might_sleep(struct pwm_device *pwm, const struct pwm_state *state);
 int pwm_apply_atomic(struct pwm_device *pwm, const struct pwm_state *state);
-- 
2.34.1

