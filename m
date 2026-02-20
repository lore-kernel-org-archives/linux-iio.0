Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B779B31D375
	for <linux-iio@vger.kernel.org>; Fri, 20 Feb 2026 09:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771579158; cv=none; b=HsuU9OFBoPaEQvNbLIqSP+cV3MzOKASWWijnfk6MQDzqNplh9JuA/4M4IvaN6oFZge+JubOgy+F3DIrjp9mTiE4yX9rW9hmv2p5cveNoMvwQFQ62pt03ZF8ywPcWgTfY/+wD50ORbDbXtUqLgT9Jni82Hb//7yZ/g6BAp5JCxU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771579158; c=relaxed/simple;
	bh=C+wsarVI55ZZRQ3B5XA+RMI2p40E5xuzn687URb4gIE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WeiU9Hy4n7pcSideEWdX1jeDcSqzX4yH3e1mfYeFCoM3f2k45ZRsWgWgg/oguP4sp5SA3KrNYbtKa7sIf3IBldfvRXkK2UL/y97ORDKdESUFDa7F/PvGCUwFPn3fGvA1bvNZPOOV0QkdDpnweTyrNRiE/iJVVN84wZ62g8GJqow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=iaAcC00L; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="iaAcC00L"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b8fd976e90cso255364366b.0
        for <linux-iio@vger.kernel.org>; Fri, 20 Feb 2026 01:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1771579155; x=1772183955; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u6F37dsCD+l3Kjiw05UW38NxOXviWKT0380mYL15ak4=;
        b=iaAcC00LodtDz/r4vB+VTwoeWfpGCyQrFsYFj91kPksn2uYUwl0oLdm1Y3bJuQcmyh
         /t7R96eK34WUvAtIxI42JeW0vhs8RpFvOqN5alRsbzuSTda5dlC28zuuER/aQ8MzpaEI
         ULeGO9eD1iTZQOYoFo5XhemBGdl28Q9jRUZeTJqrfBMzwWFZYoa26eYhF9u8+KHEXHyl
         E0BTC6WpeiCX/f3EE6GgSRB1B8dSROAoyr4rd3gy1DxGXCCcup2LKE0xUFq14OpVsS56
         5NyHf26vXjju4yn0eLFUj4F6uEuCl2jFgi8nBGkVrW/w2c8iw1B8GRPRvNI4Y/fzC3KM
         uKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771579155; x=1772183955;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u6F37dsCD+l3Kjiw05UW38NxOXviWKT0380mYL15ak4=;
        b=rFKMD4X+p7oEoOLPZ8O55JhVOIzlEKawDUbcK6I2IM6fnABS6bNWyPZO5jWIhN/1IY
         eenPtYIZHeYIwDnq5EcndSaFVsRrEn1VE2zDd9UINUQpt4VP57Jv/tB68RLiWG2KqtZE
         rNX0NXVcFxmJl2kMmZ0krjaoizrRT+dAf7oNvvAFIbHbBn3rZleiEcjoCoyVQLfuQmew
         y4WhZA1SOre0landfapXCgZ6qNRpXwQ/m59X1EkxjsHYIj4otkFqNBL5/7/1SjuJC0Rp
         uDFTqlkpaAyDKydaMpsIGOj26vf3ICRtSxWrP1bPHY1Da7m4l655UhW8c/98XMlOJLgW
         PovA==
X-Forwarded-Encrypted: i=1; AJvYcCXbqbscgX2McW1LoGB70oKFhocEa/QDDq0S/OVC87E6+ej5dh6HQTlxUHciqkki7OHIFTa2OhYPIPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRNSAKF0+xPXvlRNFyjOD/5XGco3tiH9/ipz+EteW0q+l5pmjK
	YqGC4DHUSp7aqhRLzmJfknfjqfW/Tw+7247yLvJw88gmRHJc1Y+zV1TzbWJhcVPC1yK9kvCa3Fe
	/ABVa
X-Gm-Gg: AZuq6aL0L0UUkv3HNgZEzcvoN0rSKEmQna2S+mgNP9U0FELyUfvUd0TzlEHuI/mTufQ
	sa8cNFwIHghOCdPehTaQGySCVnxRNg+EWx1hdqpXrfASaKM7d1VKHlp5yT3EFh+PrKa/E+RNbuz
	yrj9mDjq/HbDoeTSi3T9Sm6Nisv/T6BZuneHjGKfJm6nhbDuTOHNQrn0YLi2sx3+v5FIZev3H1q
	4m4FM7NUbWgRfMZmz0tbqrcRwO+3w1kGnUOodLy7k4DY6r/RVWq8AvrA2stFPgx7Po/TVmMUeag
	KHcE/E3MhHf7CSenJyseMIAj5L333KoGC5QXY60DaysVCNrs9BsMmto3sFF9KWu5gpzlLwuGVpf
	9vC6wTccAHJa9SRJAgRoYYYdOJ814NsrzGrcUUHJakw2EUoKm2HCpLAvYA2JDLBsagc4s/8mQBA
	rL9U5xMEvtYFoul0rwUPw9ayfsCanfhUqz8iWIxSfoYSNN0E+u8xUVvJQs6zcWKUV0i0vwoYRTR
	fOvPg==
X-Received: by 2002:a17:907:86ac:b0:b87:3c4a:e68a with SMTP id a640c23a62f3a-b9072e7a717mr62188166b.9.1771579154631;
        Fri, 20 Feb 2026 01:19:14 -0800 (PST)
Received: from [172.16.220.101] (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc769111fsm667098666b.57.2026.02.20.01.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 01:19:14 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 20 Feb 2026 10:19:08 +0100
Subject: [PATCH v2 4/5] arm64: dts: qcom: pm7250b: Define battery
 temperature ADC channels
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-bat-temp-adc-v2-4-fe34ed4ea851@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771579150; l=1351;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=C+wsarVI55ZZRQ3B5XA+RMI2p40E5xuzn687URb4gIE=;
 b=T4QbfcfFNBuzPHyJEr/F2U8LVosN8lPbSUjMYubLbaa2KgB748SbdekHcjXI0agmKW1SoNgGy
 vLJ7EthvVKhBSFCWTH42xcBLl0ss7sWNlc20UjjFtalqtW2vF3aSf04
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add the definition for these ADC channels to the PM7250B definition.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/pm7250b.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm7250b.dtsi b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
index 0761e6b5fd8d..c96089520548 100644
--- a/arch/arm64/boot/dts/qcom/pm7250b.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
@@ -156,6 +156,22 @@ channel@1e {
 				label = "chg_mid";
 			};
 
+			channel@2a {
+				reg = <ADC5_BAT_THERM_30K_PU>;
+				qcom,hw-settle-time = <200>;
+				qcom,pre-scaling = <1 1>;
+				qcom,ratiometric;
+				label = "bat_therm_30k";
+			};
+
+			channel@4a {
+				reg = <ADC5_BAT_THERM_100K_PU>;
+				qcom,hw-settle-time = <200>;
+				qcom,pre-scaling = <1 1>;
+				qcom,ratiometric;
+				label = "bat_therm_100k";
+			};
+
 			channel@4b {
 				reg = <ADC5_BAT_ID_100K_PU>;
 				qcom,hw-settle-time = <200>;
@@ -164,6 +180,14 @@ channel@4b {
 				label = "bat_id";
 			};
 
+			channel@6a {
+				reg = <ADC5_BAT_THERM_400K_PU>;
+				qcom,hw-settle-time = <200>;
+				qcom,pre-scaling = <1 1>;
+				qcom,ratiometric;
+				label = "bat_therm_400k";
+			};
+
 			channel@83 {
 				reg = <ADC5_VPH_PWR>;
 				qcom,pre-scaling = <1 3>;

-- 
2.53.0

