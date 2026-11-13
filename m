Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794585901;
	b=EWLhrzHrKxac4mew+4tCaxKmIeUmNhNKU49FJ7lcMhgIpZSREFV+skEoFhhFIibybsxU
	 FIq5Xy902Shns2FhJPwCiTmxfdJyP7isyKTdTK+BA/rfd6YxV6LqQjFzxlkgE/NUbHsaz
	 Ln+hiBbfZIJAJkbM4974LVwrW6Yk+Y1HtMuc24jQ1loi6DFj6TS+ZJGW8HyojKtHSH5jr
	 sqKQ+giZwTbqmm39awS5Cs4crNR253PsjgYfYwY97yG4ezZHZJsiqFv4rn4svDE2ahNp2
	 xnViBkfMMEsMZGW/rqgoaxQSCLedkX7ica1+LR+1zwh7hfUFlugJvsKIdXsTSn2Qd/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794585901;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=FO0bSEZPctK4SYPQqqbCp52sfheQb98k2br9y1SkDKs=;
	b=CETABydqP8JPIeynnuJSpgTxENUZzTra2jVNIoYAA473iyozwl/xWaYV0Dm1tbnQmGqo
	 L6BfjqlkiytHZJbmLFlQ9N9FDFmud25Lc4ZYIID3VTXXDo1f9ctIYddhTZDZeZl4pPret
	 D9++gxH8nr92LJ2cmdZPp+bIPobpPlLoJODsXTFWQ0t1XyetgaxPXJ+nNQK7tmcz1nZcV
	 qI1TmBqYkdQfYEOR1pd5P1mA1Gr7Gu9ETC9oviIjEHjXQn55wc1tlrrltbsmz74SbbtUs
	 2byOCL7eynvUrxaKvpJW/wxkwNoPBnmLlQ3njpWtB5dGWmaDOCoiC38Dub7ErZJCscQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fairphone.com;
	spf=pass smtp.mailfrom=fairphone.com;
	dkim=pass header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b="UbcRd/9F";
	arc=none smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C26606FFD6
	for <linux-iio@vger.kernel.org>; Fri, 13 Nov 2026 16:05:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0C26606FFD6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=UbcRd/9F
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b633ddfad6so2200261a12.3
        for <linux-iio@vger.kernel.org>; Fri, 13 Nov 2026 08:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1794585899; x=1795190699; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FO0bSEZPctK4SYPQqqbCp52sfheQb98k2br9y1SkDKs=;
        b=UbcRd/9FwWBdLAt5jyAX8bSLG00aIKvRanBB1yuP9xq1emw0f4SmvcZ8KpwCIjoSUq
         bgEKSheDRaM1VXBBhmS1+aEiaRkNbcxgfhOHxm3ypbyFeXnqUebBrxX3WrpusQjvZlcN
         Qoi13ObKTXUrQdg96Onqr0+BNJGgn8WqlDnl/bqWngrR28/VwudT8Dm302ZpSRkU3jem
         H3KEu9go6LCQSxTirg8LvOvTZFdLHD40dqigtl0xPT4KBKicv7zEhR97Sj9HqRRqlYya
         50caTAqTLqT/FYpXHQZ0Wn5tgKbOTHhheOCW0cJ1LuyiOf5OP1F86TdNjKW+UI+2VPfZ
         vInQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794585899; x=1795190699;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FO0bSEZPctK4SYPQqqbCp52sfheQb98k2br9y1SkDKs=;
        b=ync2j4IiPq0586BQ995A9JNA32ubIBSK5BdKHgffgqDDlgkej65HDGkEi87r+wfkeO
         QeU9WJL2j6PTVjOli5vJ7SKfSjadQ28vIcYMTMALlU8cJnJObXzuGBskODSCn9nLQtPQ
         NSM7yZSCXDIRalwLtc5BZh0OF2kak0CPsEx8tjCqN/OJM3WTlbLHhEffkGxgRI9umuPK
         CN7Rqs1KdTXnaoFJ0BuWHS5PmLBgCkiqLW0d4EeoXoB1wtXpYfvUvu3zovSfufD1NKYm
         IlwJIRTUnxE+PNt6kZNIh9wwYld53ZBbdJkgKc6uuw5t3cWuby9ARv1GtgrTiOmS8pfL
         fFAQ==
X-Forwarded-Encrypted: i=1; AL+hErGumBXnDES2EZs91EvwymnSeA1am9bYY9MR+4tfTA/cP1eVkZyVJ9gQBdsMbitKs+EGBib46GRVwO4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+gplBwSF/Icm4zUG6Nq27hZJ36+NclvQ/2NyqP1tgQ+KSVgqTr
	aUGaUKi/U1fndMokXzWTJtqS6AVPoYGKdppDFHZ+mTPiU5qamIohFX24iR0X/IjnTmY=
X-Gm-Gg: AYBFou2MGcK8VC5NNMlumVYQVkR8fi57E6Y+8Vi8cFLq4QYQo7Tek+pNNGQo38Vih1N
	wYpjYk/dUBM4jHezXCQS4GBFs15Y/iHsZs9DtU+NK2eF59zupD+FvVd1n5XoNkpLzNg670opVhK
	VwEYEriSjdHwI8QfeeqPymejQCk431iUR5+AddsUkPOXKptGi0nrelA51emvKI1w86axWNNccjv
	GytBNfMM8nh5cbf/sXTWwRspTwiJ2100jFnazLQbx42B0ojRDvC7nZmuhEZCG8pGcKY+zSBcFeE
	I7cVRYmi/HwKPwvwXQeTtHjstlydZAX6ko6EDSqNlA/WDChBxSfnl/AH7YWs0rJSV8wv3mtRg/M
	KapIaLI4oGO9TVayuUBtn5Inq2Nc80U1pQPWWRzwfxtYAnA0NbmZbTp3EMKAibgaPAQc6KO/xRK
	gL2AMR6Tt+kWo+CuMlbAhTpcB3t2tM5pgdapvSe0NfNcRu96/47pcCgasR/T6ERo4IWJFMI2V3j
	QUC7+uQn7bWj8vPxMbDh3d/xNZI1/q4VqxyXgGiWTogiD/rvGGMLxkn4tw6cveD8DurthE9Dudu
	VwhYAYkrZ8gX2ScdKfP/pKvjsIieD7bPXBQf71c1tnJMzL6JYfk4wfcSJuJqktD7PL4K
X-Received: by 2002:a05:6402:849:b0:6b7:c9d4:6b96 with SMTP id 4fb4d7f45d1cf-6b7c9d47044mr1699353a12.8.1794585899214;
        Fri, 13 Nov 2026 08:04:59 -0800 (PST)
Received: from [172.16.240.104] (144-178-202-142.static.ef-service.nl. [144.178.202.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c264d99csm1123946a12.36.2026.11.13.08.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 08:04:58 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 13 Nov 2026 16:56:42 +0100
Subject: [PATCH v3 1/5] iio: adc: qcom-spmi-adc5: Add battery thermal
 channels
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-bat-temp-adc-v3-1-743979a8fd90@fairphone.com>
References: <20261113-bat-temp-adc-v3-0-743979a8fd90@fairphone.com>
In-Reply-To: <20261113-bat-temp-adc-v3-0-743979a8fd90@fairphone.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Hans de Goede <hansg@kernel.org>, 
 Jens Reidel <adrian@mainlining.org>, 
 Casey Connolly <casey.connolly@linaro.org>, Val Packett <val@packett.cool>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794585895; l=4306;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=Ls9YOP9s76H+ik3WPl/H56mlsU6FAYkwGa/NKoyDkp4=;
 b=R2YRFU8uP5cAi2o3bXqmiSspceyOk5f/xOzUX7K2BBsMMg/O0iMgjMpLnMhrGAQUny70QlwBl
 qtDr/DTeAoaBpRRa50quPWV3UdAiGi4AjIKM55zMif+7z9CRpgHfylz
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add the BAT_THERM channels with millivolt as output, which can then be
used along with information regarding the NTC in the battery, to get the
actual battery temperature.

A static lookup table in the ADC driver won't work since different
devices have different Ohm and Beta values in their battery NTCs, for
example a NTC can be 10kOhm & B=3435K.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/iio/adc/qcom-spmi-adc5.c         |  6 ++++++
 drivers/iio/adc/qcom-vadc-common.c       | 16 ++++++++++++++++
 include/linux/iio/adc/qcom-vadc-common.h |  3 +++
 3 files changed, 25 insertions(+)

diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
index d57ba8526e0c..24ac84580570 100644
--- a/drivers/iio/adc/qcom-spmi-adc5.c
+++ b/drivers/iio/adc/qcom-spmi-adc5.c
@@ -542,6 +542,12 @@ static const struct adc5_channels adc5_chans_pmic[ADC5_MAX_CHANNEL] = {
 					SCALE_HW_CALIB_DEFAULT)
 	[ADC5_XO_THERM_100K_PU]	= ADC5_CHAN_TEMP("xo_therm", 0,
 					SCALE_HW_CALIB_XOTHERM)
+	[ADC5_BAT_THERM_30K_PU]	= ADC5_CHAN_VOLT("bat_therm_30k_pu", 0,
+					SCALE_HW_CALIB_THERM_VOLT)
+	[ADC5_BAT_THERM_100K_PU] = ADC5_CHAN_VOLT("bat_therm_100k_pu", 0,
+					SCALE_HW_CALIB_THERM_VOLT)
+	[ADC5_BAT_THERM_400K_PU] = ADC5_CHAN_VOLT("bat_therm_400k_pu", 0,
+					SCALE_HW_CALIB_THERM_VOLT)
 	[ADC5_BAT_ID_100K_PU]	= ADC5_CHAN_TEMP("bat_id", 0,
 					SCALE_HW_CALIB_DEFAULT)
 	[ADC5_AMUX_THM1_100K_PU] = ADC5_CHAN_TEMP("amux_thm1_100k_pu", 0,
diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
index b03cf584b165..09a13e2b0ef4 100644
--- a/drivers/iio/adc/qcom-vadc-common.c
+++ b/drivers/iio/adc/qcom-vadc-common.c
@@ -309,6 +309,10 @@ static int qcom_vadc_scale_hw_calib_therm(
 				const struct u32_fract *prescale,
 				const struct adc5_data *data,
 				u16 adc_code, int *result_mdec);
+static int qcom_vadc_scale_hw_calib_therm_volt(
+				const struct u32_fract *prescale,
+				const struct adc5_data *data,
+				u16 adc_code, int *result_mdec);
 static int qcom_vadc7_scale_hw_calib_therm(
 				const struct u32_fract *prescale,
 				const struct adc5_data *data,
@@ -333,6 +337,7 @@ static int qcom_vadc7_scale_hw_calib_die_temp(
 static const struct qcom_adc5_scale_type scale_adc5_fn[] = {
 	[SCALE_HW_CALIB_DEFAULT] = {qcom_vadc_scale_hw_calib_volt},
 	[SCALE_HW_CALIB_THERM_100K_PULLUP] = {qcom_vadc_scale_hw_calib_therm},
+	[SCALE_HW_CALIB_THERM_VOLT] = {qcom_vadc_scale_hw_calib_therm_volt},
 	[SCALE_HW_CALIB_XOTHERM] = {qcom_vadc_scale_hw_calib_therm},
 	[SCALE_HW_CALIB_THERM_100K_PU_PM7] = {
 					qcom_vadc7_scale_hw_calib_therm},
@@ -583,6 +588,17 @@ static int qcom_vadc_scale_hw_calib_therm(
 				 voltage, result_mdec);
 }
 
+static int qcom_vadc_scale_hw_calib_therm_volt(
+				const struct u32_fract *prescale,
+				const struct adc5_data *data,
+				u16 adc_code, int *result_uv)
+{
+	*result_uv = qcom_vadc_scale_code_voltage_factor(adc_code,
+				prescale, data, 1000);
+
+	return 0;
+}
+
 static int qcom_vadc_scale_hw_calib_die_temp(
 				const struct u32_fract *prescale,
 				const struct adc5_data *data,
diff --git a/include/linux/iio/adc/qcom-vadc-common.h b/include/linux/iio/adc/qcom-vadc-common.h
index 3bf4c49726a7..ce037994b019 100644
--- a/include/linux/iio/adc/qcom-vadc-common.h
+++ b/include/linux/iio/adc/qcom-vadc-common.h
@@ -93,6 +93,8 @@ struct vadc_linear_graph {
  *	voltage (uV) with hardware applied offset/slope values to adc code.
  * @SCALE_HW_CALIB_THERM_100K_PULLUP: Returns temperature in millidegC using
  *	lookup table. The hardware applies offset/slope to adc code.
+ * @SCALE_HW_CALIB_THERM_VOLT: Returns voltage in uV of a temperature channel.
+ *	The hardware applies offset/slope to adc code.
  * @SCALE_HW_CALIB_XOTHERM: Returns XO thermistor voltage in millidegC using
  *	100k pullup. The hardware applies offset/slope to adc code.
  * @SCALE_HW_CALIB_THERM_100K_PU_PM7: Returns temperature in millidegC using
@@ -114,6 +116,7 @@ enum vadc_scale_fn_type {
 	SCALE_PMI_CHG_TEMP,
 	SCALE_HW_CALIB_DEFAULT,
 	SCALE_HW_CALIB_THERM_100K_PULLUP,
+	SCALE_HW_CALIB_THERM_VOLT,
 	SCALE_HW_CALIB_XOTHERM,
 	SCALE_HW_CALIB_THERM_100K_PU_PM7,
 	SCALE_HW_CALIB_PMIC_THERM,

-- 
2.56.1

