Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1AD31BC8D
	for <linux-iio@vger.kernel.org>; Fri, 20 Feb 2026 09:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771579155; cv=none; b=jts+b7k9IwUpuA7ssX9eEdY41KtrgFdc7Bt0LUB9DQd4vKSUHTjxos6YQZbh0AicIseQiXH48/8VWmXlkQ0zCpIIDFvcvQXD4EwwjTQwScJf1qJ8tPO+2Y6AEtfj9O44D8jBrorxJuBXULwawaqXXeGrC7HW9PysBf/52PZC+iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771579155; c=relaxed/simple;
	bh=Pa8v8Yv22/bRxGvwx9RtUWdjQtXpeSx595DQVqT0p/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ODhlP/iHjMsGCujcpwFftITyTrru9YVdcbwjw1FzB+YR3ScRKOkrZSzvcLoFE9tYuwXrolWuf/2apaWbFsJYGR51P4EXSg9pMvgHuNlP7BER53dQCy/YMuS+NhiJGTAHWHpz8e4BPQK0u9JrRO5YdeLPkqXMlUCJ+qGbVtn8QT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=j/gZjPgA; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="j/gZjPgA"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b8f992167dcso237526766b.1
        for <linux-iio@vger.kernel.org>; Fri, 20 Feb 2026 01:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1771579152; x=1772183952; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A3S6MbSTO4MkMrBu9nf7AbP35XblYDK2xH6bZHiUcC4=;
        b=j/gZjPgAXIEfqCa3x5ZZMGaAdM+s9QAgSqGdu4G6P3MgKIrYP9g0jJ+senPJQ4mXiC
         hmkOBVYGlvu/wgYnkBD15Octv/CHxo5MRVrogrmvjc4a6jkMp3USYt2C/enUkcu33BU5
         e+Fy45KJwhQuf9MWNpvW0sfWtE4A6N4sp5v2mBiLFgRzJUB+6sTmqzgPZeimwfqLrJir
         hIVcXQvctj8xyg1TGh1QvoMqWIjlMe6V7NLcyeirD0R0afHa0owLgtz5ydcp4JDG+h8x
         0v0sAI593ToH//x8hPM4MLe+iHlrl/+39ubgKcLjD7HvAijsP96m30W8gvKDHFOdp/JP
         vwdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771579152; x=1772183952;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A3S6MbSTO4MkMrBu9nf7AbP35XblYDK2xH6bZHiUcC4=;
        b=aJxtzW98nRwXqRiTpqmhxrmQKaqr+gFuxckM3gt7vghi/iDBQji92DHPWRvjob/FCA
         ZRgF0DNhHGyttuWr9tH8KUYx/q6LzsU66ZGH7801q1nn+s+LjUWmtRN3xPGPD/pc4DBu
         Kcc229JyM7t2suuIAeLozmPVL06Z/nvaWM8H4m5DxJUupWEaEDqLk75h/d4F7TtkhxnD
         jWHl6mXoPu/edmnChcFJeMXX6IsMKziP2de9SJW013V+rf4xjunu46oRhx5HDDfCzylk
         05H7+37PHYAPiOiEJptOUpS5NqBzp1PBDgQN7EcMlJcqh9+wiBe+fZ1y8uQvPwiY6Ufq
         G1fA==
X-Forwarded-Encrypted: i=1; AJvYcCXy57zDfHgONBPjzYHTnR0IOMIh6HRbvNwxPl3YDWIjNpQDdfB4wPynqDL4Dq2oN1w35S5jpUjJ5Pg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2+hsmw+/FTgao23syfzpf6p/8M1wEjjkuCfrsfTOxnBMjE+68
	BWI2FhOfEaTlM/bY/wrAjmDl7GwVdDzgPX+Hchi49Z9HnsxkymK3LhOo/KhTV+43Y/CLZuL7Ex0
	6E79L
X-Gm-Gg: AZuq6aJnqCw0FzkhJ54ztmt52QPS9FpCkc+KNx9g4zVyZFu4K37X6rzCblLA4xU2RlF
	39hSR9sO3w0ckwntqs9AAH/VqpxiurMVUSwm1bidFrkZOEWjRGTCyLh1QhBEe+saoM1SudjPACJ
	Er5PDyklxl/RCTGwwI5amshxyf4ceSSa5MCiGvS2pWOKZ6CvenP1q1o18uv02CHnsukIrEPsOGp
	/0HYbs75PNvt4B8p5vwmuyUs2RBFg/coWGr+X3VP8dhKIRarKZIZN/79sXW1dQqUwsX8LwSOKqb
	hzveL+qXvO/1OzYOg5r3yK95n5VDJSHQDTVkOoMWICCiHpdylgKeOlpyMvDcDtRclHXVyNU9OE0
	kPb79o4jMDyYxDS9t1oIEJpo++Na3UyaEgxi7JG1iLC2LhPRMEzm44SqocFWKfln/U+UcgGMcaD
	hcPQK4dhltzzZnw4Hm+3dtH6EyU/r+iPHr/x4QY+Se2hJ/VR3k1BlE8H8HLaRdK4xc6C6gKK5ky
	VIgsr25H8C3lJMV
X-Received: by 2002:a17:906:ef0c:b0:b8e:7208:ffe0 with SMTP id a640c23a62f3a-b903dd028c7mr585851766b.58.1771579151978;
        Fri, 20 Feb 2026 01:19:11 -0800 (PST)
Received: from [172.16.220.101] (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc769111fsm667098666b.57.2026.02.20.01.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 01:19:11 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 20 Feb 2026 10:19:05 +0100
Subject: [PATCH v2 1/5] iio: adc: qcom-spmi-adc5: Add battery thermal
 channels
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-bat-temp-adc-v2-1-fe34ed4ea851@fairphone.com>
References: <20260220-bat-temp-adc-v2-0-fe34ed4ea851@fairphone.com>
In-Reply-To: <20260220-bat-temp-adc-v2-0-fe34ed4ea851@fairphone.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Hans de Goede <hansg@kernel.org>, 
 Jens Reidel <adrian@mainlining.org>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771579150; l=4306;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=Pa8v8Yv22/bRxGvwx9RtUWdjQtXpeSx595DQVqT0p/4=;
 b=bI5SYVmFRauGR8YDVWfVU+87qHPMpEth/dQ/iA9E/N8ZOyC5gGBcOJDpqvzwHD9JvAKCcXzkN
 ow+00MWJnqPAwq5M5XrtNEKDKuV4iVKMSto5MZq9pp2/uJF5AdqGX4v
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
index af3c2f659f5e..6ad75368d3a3 100644
--- a/drivers/iio/adc/qcom-spmi-adc5.c
+++ b/drivers/iio/adc/qcom-spmi-adc5.c
@@ -543,6 +543,12 @@ static const struct adc5_channels adc5_chans_pmic[ADC5_MAX_CHANNEL] = {
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
2.53.0

