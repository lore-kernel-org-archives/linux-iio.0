Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794903871;
	b=Uj5zgblLWmprb/foYGOaWf1en4MKDHMrC70v1xAA4cm2qaHpJEH2dg1fWuIuCbaDIYgP
	 JYmDbn9MrKI0IThyVA/4QDyRzMOtflQkdqtw6fmw2xmmhCcf6K9T5NJpX9w0b92xg/DxN
	 HH5MajcHN3I1UFEk99Bmb89feIDe4fUFgbygFc8ljKxcHOV6bMlxFDxoWXbSTQCXAesNj
	 qnfGG9nhPeaecWCelI5LWB4gpPi6wOG12uNb7BHRrofDt66Fa137F7kYaTCWcVUvO94xe
	 5Q5lWLb6m+tu8x/Q3q2Sm5ubpOdOWrXDyq8WvNHjozpdaA/pgv71N0jvVGykLZFIEqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794903871;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=FIAdVkEWa+YKpNqjyEpkUHZm+KoAzH84s76F1+g9tmo=;
	b=5rBq9PzjmAft1OZ/ZOg0mvMTfA181mFcD39NysnvDrp9jJKaTUcuoRPRHd403ouSiw30
	 FSrTw+OgkDp9ihZytFy+kOTFHtROkWmfzIKdZFLG29lGReY4p9PUITSkyEjrRq2Ww/6W5
	 xRoH6L28Xfdg/AmrobqlC97JsT012vUBr1rXR4fAL9R+DE4JzugbNdNS9ypPiJxtJty0o
	 sb1OzWpDvn+gpGAKN3tBaPaH6W71QMsCu0DstVOmV7TmEQWbSSlPcoJ4R23NUXQq/Oh8j
	 ajd0xVYRHl4NyONZQfVok79swCh/BC6ZTHc581fWg4TYyFFla5KGYD++mqs5OtkSoMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fairphone.com;
	spf=pass smtp.mailfrom=fairphone.com;
	dkim=pass header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b="m5rd/aHW";
	arc=none smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC0260A262C
	for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 08:24:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BC0260A262C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=m5rd/aHW
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b47c1a3c74so6459465a12.3
        for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 00:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1794903870; x=1795508670; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FIAdVkEWa+YKpNqjyEpkUHZm+KoAzH84s76F1+g9tmo=;
        b=m5rd/aHW4x8+LC4Hoff/y+voqA2dzKC/QkkgsLWsQFHr+HtEIpj0YzM8GS/0DT4I4/
         gwV4XFvMdtCFyCncu1foTtxnDag3pLIodRg9GKg4EOvngWrgE7sZf/xsl6V+6Ap5bEyj
         IfqsLVRwRZ3PRMZAO15NX/asAngzwzq9p1KuCe5/mpybyPr7EGhUvziZOlA73MmTyKbC
         C0w+7/iASWvgEdcoZAcQ+u0CcLjvDSlVePv0LRLBtM4mwr3FChD8MUkxDKZFSxIvNkyy
         vVEs8Kiu6GDR0RjpRDwnNpojC2/T6aoCDk0SEKATRH5nXRiR+Xqd4hY0eQczVQSmDFra
         uDPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794903870; x=1795508670;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FIAdVkEWa+YKpNqjyEpkUHZm+KoAzH84s76F1+g9tmo=;
        b=ZMTLlCNwfyanWsSpOlVQEaI4LdW/N9ojPNq1VF9vPqmXvcfOteZQTMGflcnFlCI/Ag
         CxdTJzQSnl8Z2wI7dMmUAilWLDx85SY/8v0zQmQJ20TK+Jf3FmJNJ91CBAz20pJKR1Lj
         9yZ3TSPFG7BPQtUG43suKzEJZjxAHdX9+DbpaNGxGEFdPjJFYX/3Wp9KqxjPClCPZzSa
         jMUw/NQAbb6ThfBLpJVk3HsWJMrb2wSgzhcffkLTQiVCHbNxxkrJ115ydFtJJ6qq9kPp
         A3S6ej1+lIJ12eTOlkvJQ3X1TijHIy1Gu7YHtdWRxSEDSbsCBUhehAajb+vubA1ACuLN
         ctHQ==
X-Forwarded-Encrypted: i=1; AL+hErEqCI9kdvU7FlgE2s8aJGOpJqWYTmdgBuslZQVU0eRdaUDvL0erulLKxA/JlYScpT5eQ+i6/mE92ZA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9n+szgcuSAIeeVgOgPWIItQiIF7Z3PSWk1MucvDZs0q0tswylX
	MJL9O33zXRHq0G39VzpFOIsI2Rs6QCfsjRAiLivd4E7jYyukHfUthu3sG+PmASGEIQg=
X-Gm-Gg: AYBFou2WKg5GZDpNnxWWZkQed1q6ldhUAbaNYv5jRWkOYcXiCAuctFfmISrhHIQHAPQ
	nFi31OowJupMewWBJa2bZa5315J5s3p0Rl9OaGuoYIxtnnMSs/DB6JiK1tfIUH4/igtV9HPfIxY
	ueDUi768PIYpYfKO8JrbbSV1ugUbGqNASpB2ULJ9JuXAqWkU9fiLLoIMAY3axYSiKVYMA9Rwmfu
	fJnX/y7ZnaLeJCceS+F7dhzKMggpy3c9B7+rJIj//PN133GnbUKTZDQ70CzIMvnC3rVJstNG3K4
	2EkCMGy65eNIhiJW7ZQRd9G+c2mxZBcr+fSw1rkrGl8jUHew4CT0NJiuob382yWWV3ChdhA3ZT2
	x91HxHjl8iU7kOXLsHeW0ER91B/cz6jK/oel7M+yOEV5brTYnDacG4G7s12aVIF3jivsLQxLdBN
	+TxjhTDGr7nMznDsbWtmt1uZR/OrvQLM8nknVo9SA6XK50oxUaWcj9A9GMD6ndPRdsGZTUBv0TX
	/5nSIpUuPYIHzzHwxHGtXzydl9b2s6FtWAG1KaLiKfaKdvngJFBXRqwEe280N6tYeEBtXB5N4nY
	0SbARvX8q4CeGblTWj4bTGBH5TL7+IHetlWy9EmqdPsuJ1dRr09ZDkbYkNojaiUuBE9so18O00c
	rlzgG3RZL3mqYxnzMF/tsO2t0pj5sti8Ew52QXNP+L3aLKgcB
X-Received: by 2002:a05:6402:4349:b0:6b7:cad6:a020 with SMTP id 4fb4d7f45d1cf-6b7cad6a0cdmr8624241a12.8.1794903869734;
        Tue, 17 Nov 2026 00:24:29 -0800 (PST)
Received: from [192.168.101.179] (2001-1c04-0504-7401-4b2e-1820-6d24-b264.cable.dynamic.v6.ziggo.nl. [2001:1c04:504:7401:4b2e:1820:6d24:b264])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c23611casm5616953a12.9.2026.11.17.00.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:24:29 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Tue, 17 Nov 2026 09:23:15 +0100
Subject: [PATCH v4 5/5] arm64: dts: qcom: sm7225-fairphone-fp4: Add battery
 temperature node
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261117-bat-temp-adc-v4-5-14d5d309ebfa@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794903862; l=2686;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=UM7jmORMPxSdPO1xNc3zcibihjU+NS+ZaaeZNpYbWE8=;
 b=bSCoKLweeKiJ1WF6rrWxDJ5PvVPJnM1jcFj2jNkvwbajxykkdKa/8c/FNqE+qSnRKKtFDBFZe
 6H+h7QU7eoJBq1AUVzYpXMfKx8YKghowLXcfI8OqIxgz9zMVaz1nDYE
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add a generic-adc-thermal node to convert the voltage (in millivolt)
read by the battery temperature ADC into degree Celsius (in
millicelsius) using the provided lookup table.

This will later be used as input for the fuel gauge node (QGauge on the
PM7250B).

The lookup table is generated using a Python script:
https://codeberg.org/lucaweiss/batt-ntc-calc

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts | 83 +++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
index 37aa272019cc..0b8c6f353f96 100644
--- a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
+++ b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
@@ -96,6 +96,89 @@ memory@efe01000 {
 		};
 	};
 
+	bat_therm_sensor: thermal-sensor-bat-therm {
+		compatible = "generic-adc-thermal";
+		#thermal-sensor-cells = <0>;
+		#io-channel-cells = <0>;
+		io-channels = <&pm7250b_adc ADC5_BAT_THERM_30K_PU>;
+		io-channel-names = "sensor-channel";
+		/*
+		 * Voltage to temperature table for 10kΩ (B=3435K) NTC with a
+		 * 1.875V reference and 30kΩ pull-up.
+		 */
+		temperature-lookup-table = <
+			(-40000) 1673
+			(-38000) 1649
+			(-36000) 1623
+			(-34000) 1596
+			(-32000) 1566
+			(-30000) 1535
+			(-28000) 1502
+			(-26000) 1467
+			(-24000) 1430
+			(-22000) 1392
+			(-20000) 1352
+			(-18000) 1311
+			(-16000) 1269
+			(-14000) 1226
+			(-12000) 1182
+			(-10000) 1138
+			 (-8000) 1093
+			 (-6000) 1049
+			 (-4000) 1004
+			 (-2000) 960
+			       0 917
+			    2000 874
+			    4000 832
+			    6000 791
+			    8000 752
+			   10000 713
+			   12000 676
+			   14000 640
+			   16000 606
+			   18000 573
+			   20000 541
+			   22000 511
+			   24000 483
+			   26000 455
+			   28000 430
+			   30000 405
+			   32000 382
+			   34000 360
+			   36000 340
+			   38000 320
+			   40000 302
+			   42000 285
+			   44000 269
+			   46000 253
+			   48000 239
+			   50000 225
+			   52000 213
+			   54000 201
+			   56000 190
+			   58000 179
+			   60000 169
+			   62000 160
+			   64000 152
+			   66000 143
+			   68000 136
+			   70000 128
+			   72000 122
+			   74000 115
+			   76000 109
+			   78000 104
+			   80000 98
+			   82000 93
+			   84000 89
+			   86000 84
+			   88000 80
+			   90000 76
+			   92000 73
+			   94000 69
+			   96000 66
+			   98000 63>;
+	};
+
 	msm_therm_sensor: thermal-sensor-msm {
 		compatible = "generic-adc-thermal";
 		#thermal-sensor-cells = <0>;

-- 
2.56.1

