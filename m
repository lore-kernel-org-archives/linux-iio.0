Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794903869;
	b=swtiC4GzM1YpcQZgnz+B5Yi2rUr/xTau9gC6c+pAYfo1ekdLk4dNn6Z1e5psj+WbiehL
	 ggvAUZGHkhYJSSBizB2+LwNsRiOMSDPCxw9qSoDk6pYqv+sXWDhJzjKEMjQcE4VgvcTtZ
	 U1IKqxpMmfw3ouJYKsW9s+Ky+43uxH0dBx1+bjspYK9EGAxS6zZSXnki1aZCqbVjFnVnZ
	 CZXvUJP84aEDPvwT3F/41aWOLux/H2LZdCmIAJ/2f2s8IbJFoKK07F467d6Ojvoxkp/mY
	 cDc7zSAEDFWkf0S7SNyh67wBEVTCKAGoEvuaxpuHrS0bhvK2Qx7eumh3GfHGKYYkOmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794903869;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=EgrVZa2eZmqWGHTSXzSBkx9rK3FiMfFpfyVDiLiMkq8=;
	b=jEkhq/e6o86caFNAC6dCbw00RjJhcK5qjum67TefT5E7QvglN/bMHXe7Q40e3b2v2H4w
	 GIjBc0EEn3t+jKa6BcT9ynAHBZy/Ni0yKnh9J/ffPVntdJcZer+tgYjSHX6Oyg8+ExRgA
	 jgHDhl7rex64fqgIr93g5qnr5jLb0OUifNB00NxjlePQhkxcyi4qL3MlLN2Iw9Pyk45ON
	 Y6r28okQllDLANnXoMxQNqbU/frd1Jpi9RhDY3H/F2e6FJur6xU4cYsoLPN0VJaoWd+xJ
	 NPdLJWZeaHQGjPNOKMmOE5eW3nRD9e2XckG1aGWUtA9ANJPA+Y1qsRxvTldjIFks75Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fairphone.com;
	spf=pass smtp.mailfrom=fairphone.com;
	dkim=pass header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=qJ0w7yjt;
	arc=none smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8827606A8A2
	for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 08:24:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8827606A8A2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=qJ0w7yjt
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b6f42095bcso6098552a12.3
        for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 00:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1794903867; x=1795508667; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EgrVZa2eZmqWGHTSXzSBkx9rK3FiMfFpfyVDiLiMkq8=;
        b=qJ0w7yjtJE1lC1zKPwOibwHew9VyeF40XwkE7/3yvx5PT+Ju5NAaJ4PAYpSd+gwHGY
         w7cc1v7y04SypaBVvpt0FdJ28SLaaLsSZoQeNlJY+q4fNMRgEosPLHV3CHWwRikNnAx1
         GmpPsBD7FywbCP4QoC/tQcG+Bwl3jGw0dQYN3ntPTRr5NsIOkJK7aiGBYTPyHA9B3Yhf
         m9wg2+ELiGZz1v/ioIhxWmVh2DL4jz1BZ6oJLEFOPFEMV0/0NSkxHHhQAeV0VysiAjI7
         ZrbLuE9PTGnkywNGKg28gayA6JsZ5rWJo/l+NwLWZQZynBQktGrHxtKU7fZkqerZZW1Y
         G6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794903867; x=1795508667;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EgrVZa2eZmqWGHTSXzSBkx9rK3FiMfFpfyVDiLiMkq8=;
        b=LVsGL13kA2UsZt5PTGbfr2ESbnLxfuErvN7/7wp5poQwwsJqdcMS4Zb/yHG5zBtnts
         RFtmjoBxHyQnyznZjrq1QY1pJHADuK8MBIyCs0+H4yViNVBea1ZBVFFEYnCJrNwGAESw
         FNplUxYdAVBOp3m7T4d6iBVYVWICogGkX9tFaK1ewPi8IHYX77gIMUZDIeEiJBRPne2i
         MpXHKc30ImxhEzRe3D2aoZ6seAzrSSd6ONMuYsSu5zEw79jPCds9uwm9368/+Jb5qLnx
         SfHP094rhZr8DrJA81Bz+guULSn9iK4fC4RFXuj/lqRjTJ9tGAM4AjQdCDkNFz2ZNTcy
         2LDA==
X-Forwarded-Encrypted: i=1; AL+hErHFHjSdGTbc615cSG/17+3GcK7B2imTvphWhK63xVBfe9fZzEHcR9H20V39pR5atcHPkKZ5x+syYuY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9JppTXz+PhTnjF7jQ/tthGOqeUHJjGEpdeRCFahaQr7LkiOA4z
	Uy7M5L2gl5C5x4DfttcuelZ1tKldyaS2Zo3V6COzagsm4R8/ckIP7N1/+miBZK+5fLc=
X-Gm-Gg: AYBFou3UY0NkNzNEKsVFBgm6dF7NLUU0lro2SYcd7/Eo05ciROrNmm4tn+HrjKCBCua
	wenqVI25nm5BiHRhlQWu8+Bw1l673rJx9+YHwWRaNZp2n071wQjU3coH016ZfJ4EaOSuhzgv6Dt
	05F7Odl2YxZqwHGUZ3i+DkdnyXcUoeDUc+1ccm3nTdujh/MjvXsoRQ7jqe9YzgubzfEH/dTppTX
	a8awaVANCkWzdez02xhu26bXpoE9Co2WeNr9CWvx5bcI+cmK8eG38JqSsSD+YKkGM0o+K1rlYdO
	YAnGeOELN6Vr5hh3N++lxw+RWdiAReyA/01c0o3laeb9+pkKr5cnzJPzWw9nRUm+crzhUGeiTfd
	EqFW66Sv5jk5uCd+ko2QriR9JcmlFi1ul+JeVqpI9AROVCL8DEOdKACive7gF8T2Sz6IxYw451C
	lw5wiRckWHs8UzoUYaz3voJ8hufP437JfXoT1lRAc6RDcXlCwYJbaE3CegGdpbqACGGDFPc6Lep
	9Xv2ulr/cmMLREJf3ur0lDuqMgsXK28NOYK8xQNwUsD4O1dK0XSPt93TndeeO5Lnk2RTBlXPLQ1
	H+QdmsdXoDDwIlfVW+S5tLAuAAVGrw8S0cEn3wIspvoWWxTbwuYi5XHtnqJuFTWWKDry/w+C2R0
	G2BsWBmyYptf9djNm1a8psFoH+I6p8E/XXgHDF5uVa5TRTXkw
X-Received: by 2002:a05:6402:88a:b0:6b5:5530:c9af with SMTP id 4fb4d7f45d1cf-6b7c0bb79ebmr6791992a12.15.1794903867414;
        Tue, 17 Nov 2026 00:24:27 -0800 (PST)
Received: from [192.168.101.179] (2001-1c04-0504-7401-4b2e-1820-6d24-b264.cable.dynamic.v6.ziggo.nl. [2001:1c04:504:7401:4b2e:1820:6d24:b264])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c23611casm5616953a12.9.2026.11.17.00.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:24:26 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Tue, 17 Nov 2026 09:23:13 +0100
Subject: [PATCH v4 3/5] thermal/drivers/generic-adc: Allow probe without TZ
 registration
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
Message-Id: <20261117-bat-temp-adc-v4-3-14d5d309ebfa@fairphone.com>
References: <20261117-bat-temp-adc-v4-0-14d5d309ebfa@fairphone.com>
In-Reply-To: <20261117-bat-temp-adc-v4-0-14d5d309ebfa@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794903862; l=2598;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=IewvetNZMf9FalFWEd0iq4I/lCqxZHq/FLtsO53H2jA=;
 b=K0QTEVwf1uzSjckbKxKpcCKrAkkngarK9NjPv21hTvhJ9thkoh3P+WGons6vpo/CWOd5JylkV
 h4KSZ3LpFcKCi0kZt4zAzExS9pRPsxol5yvMrSY/2FHbt73E/Xe8w2m
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

If the devicetree node is not referenced in a zone under /thermal-zones,
devm_thermal_of_zone_register() will fail with -ENODEV.

Since the driver is now also registering as an IIO device[0], allow the
probe to continue without the thermal zone.

We also can't use gadc_thermal_get_temp() anymore because we haven't
necessarily initialized tz_dev.

Link: https://git.kernel.org/torvalds/c/3762f5851ac5 [0]
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/thermal/thermal-generic-adc.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/thermal-generic-adc.c
index c6a7a65aa6a6..b73cd47bffa6 100644
--- a/drivers/thermal/thermal-generic-adc.c
+++ b/drivers/thermal/thermal-generic-adc.c
@@ -55,9 +55,8 @@ static int gadc_thermal_adc_to_temp(struct gadc_thermal_info *gti, int val)
 	return temp;
 }
 
-static int gadc_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
+static int gadc_thermal_iio_to_temp(struct gadc_thermal_info *gti, int *temp)
 {
-	struct gadc_thermal_info *gti = thermal_zone_device_priv(tz);
 	int val;
 	int ret;
 
@@ -70,6 +69,13 @@ static int gadc_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 	return 0;
 }
 
+static int gadc_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
+{
+	struct gadc_thermal_info *gti = thermal_zone_device_priv(tz);
+
+	return gadc_thermal_iio_to_temp(gti, temp);
+}
+
 static const struct thermal_zone_device_ops gadc_thermal_ops = {
 	.get_temp = gadc_thermal_get_temp,
 };
@@ -90,7 +96,7 @@ static int gadc_thermal_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_PROCESSED:
-		ret = gadc_thermal_get_temp(gtinfo->tz_dev, val);
+		ret = gadc_thermal_iio_to_temp(gtinfo, val);
 		if (ret)
 			return ret;
 
@@ -193,16 +199,13 @@ static int gadc_thermal_probe(struct platform_device *pdev)
 
 	gti->tz_dev = devm_thermal_of_zone_register(dev, 0, gti,
 						    &gadc_thermal_ops);
-	if (IS_ERR(gti->tz_dev)) {
-		ret = PTR_ERR(gti->tz_dev);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev,
-				"Thermal zone sensor register failed: %d\n",
-				ret);
+	ret = PTR_ERR_OR_ZERO(gti->tz_dev);
+	if (ret == -ENODEV)
+		dev_dbg(dev, "Thermal zone sensor register failed: %d\n", ret);
+	else if (ret)
 		return ret;
-	}
-
-	devm_thermal_add_hwmon_sysfs(dev, gti->tz_dev);
+	else
+		devm_thermal_add_hwmon_sysfs(dev, gti->tz_dev);
 
 	return gadc_iio_register(&pdev->dev, gti);
 }

-- 
2.56.1

