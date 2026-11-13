Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794585906;
	b=pymN/Kamenk6sf6mLfk2CLplcMpwbBTytVSP2pursNNHU0Nsj5hejpkHxfMxFjxN/dlA
	 6hrDIiQP+SCcOJHzLV535UfHa7Vlgh2gA/e0p1UVQIlQpk4jPlU2ibGl6+s2v3dR9Gzgu
	 UopoNCYg53yiWg+huzPYI8yLe0jfXuxIfK7eTdajWAU0kIQlSMgmAgaDu+EEqTUaJpJgU
	 zZc3fb/euloE8zzUQnvAjCqurPGuZ+wDgLzQzfdGLxu5qi40pvzhpRT86B0XNwlkvQy4W
	 Vt2mBPXg+r7MYIDKQrl5FsP4B7t6qHkRf3H5+tIYwkXjh4+Yi58Ec6pdID7wKI16abA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794585906;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=7Kw3jpXIq4jFZtKzMcPDKxBZyvXYg2GOy824z751lHM=;
	b=vnkW+SuS9mqShqIVB2gwXBNlkShomKX4vHPaqqYg3Ma+ngC3yd13z0fvro8rvftO8DcK
	 UZ/YZJyelyZwHj8+gBl79FgYfl8EEaEjfQJS3UO17xzehFkGm7r4vLxIl42Yh/6pO2WIl
	 mgJJKIAK0lI6M0mc5AkFjMRE5kQxBNoZnRRti4Zj9Hl2VUzpoDvsW9r87D0z985s2xIqP
	 PizwkBVSzCfNbKhGkPe3DrJrqZajivoIgulLAotzMtdCERJP3HPTyqbUGoXUFLLIVYBQS
	 PD+OE7Bs/YptRFOxoCKHttCIr0wHcrmKnffPb2g/Zz1wnqjqtj+58ZFwdBetMZ335wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fairphone.com;
	spf=pass smtp.mailfrom=fairphone.com;
	dkim=pass header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b="SOb/xgQc";
	arc=none smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D32607620E
	for <linux-iio@vger.kernel.org>; Fri, 13 Nov 2026 16:05:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28D32607620E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=SOb/xgQc
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b6e7a05225so2214628a12.0
        for <linux-iio@vger.kernel.org>; Fri, 13 Nov 2026 08:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1794585904; x=1795190704; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7Kw3jpXIq4jFZtKzMcPDKxBZyvXYg2GOy824z751lHM=;
        b=SOb/xgQcyJqJV3fKqjmRGGbJgehdAOrhA3EbTniYpSFN9VG1M8/QE6f0G5SaWLB67B
         wX3cksYY2S+OXmZfAKrm8S8bm9fssk/Fd5med7zF1L0uhNZbzjHhV4WfOcS70B2DmX4w
         MaOdUK8lcTnJ0ABUJzCvWVLoRpVNd0U0vaEcEV0JlfPZy+HDNcjk9VG5yr5GCHZPdcBi
         tVCkSDlzKAy1dBv9LaTKGzdR+x9fwiUA+4Ekkz0C5Nqb/re+BZ4MMule3tszbeJ2zRXY
         SVBlR96YUFt/di8TxXsZRllTLOy+i9T5HIfJBglIHabYyg+5kJb7RjoYoU1/9WHf1WWe
         MyrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794585904; x=1795190704;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7Kw3jpXIq4jFZtKzMcPDKxBZyvXYg2GOy824z751lHM=;
        b=SgxXUUkrqynPAOISn4UFYNHeuU9CsGt+DwCMX3/VN/uKKxSOjmFIfdtuWp/3adO5Kv
         vqvipvNZxYnlScr8VYZtyiE1iwP7kcMzoIF/P3eph6X4/Ji+EpfREudFktdbrT6vt8DB
         +DxP4qBVH/BzG8N2Ckp91t/88gCPmYBfxaPHES/BYe24TWlY1vMRdY3uCmlxVqJ2tebm
         dWP7k8ylp/EjQ8oKqrip/UBRDXCx+evQa+hrhgZdpquhx2VqA/eeoiTQSCk9suOCT1at
         t9QVWK/pX5pR4Yp9iscVtvmxeD/pemW4bHHyjna4drXpkrYDb4wSRWoVpXHqUtBvfBdE
         jmHw==
X-Forwarded-Encrypted: i=1; AL+hErEhVrhmZyWjAwUy+JpsE+NJAKpCafUzyLhd1Lc799eRNZ5fXlyvy4heYVJlDtIafVv/VC7ksys5osc=@vger.kernel.org
X-Gm-Message-State: APuU4Z92gDq6MGt7n87Vn7oIdk1D2gF/Uls+H9FG79gA3+LaujwEhhWC
	3ojhtT9tlB2VTVcUQJsmuBtS8izHW8TiwuiydevKgBYNKXSmTTjDhP1r5Yiop4pQles=
X-Gm-Gg: AYBFou0OvbbwFYrsICUyhbBM5pa8wQ93F7yu8LKtqklZQcfeFHS34M2UEkMxJJf1UCC
	66QhaNfXuIyOiVPaQllNU/LvtjQJ2wqARHctzn9GQt0hq7tmYTgnCl6emtzxlzW3pe/hyBhELUp
	hislwBqPu4B6sNYWOTYJ/2ywUmolswHKsCKeODXGzfdfbCrrLFXl0fqk1VbdfcZ/viWI3Ue4eYS
	REZOsP1yiqeEv6BS4jWp+r6gDKC6JU8/Ttbid+u8PK/wGcs0VJ/cNsbCmneYFgvexFVywu+VU9U
	rRN0/u0Ik5ZR+3Wl7Y81H/qIIpoafYpqqtwnfnD/3oiGay07m43zfJmBvBfpgCn091wTMWVCyF9
	/y4qujboVUyYfnWk7W6aZI6s+01zr+uqjC64pgCNXXt365sIhklxoy+YoJPAN5c1a8hVAXi+wuL
	mcagdFHOz36n1bD4p4jqkldmP1f/g0LMXBcAxeELaPrVdjra/3bsDQdPRTjgfXkspcb8ZHryl+q
	b8fbXWDRtHdL29UcaSI7j6q7SpFGwqMkxaSRfDnDFKtsK+h4783UyIsVyTy8ImaFycBUDdTZWmE
	EYBzcNabUCQiAtIOD+4j74VsLGnPFtF0wfImEa655gvBQZUONmmvsiXVXfAGSnqwDacTokxASBB
	9Si+mfYU=
X-Received: by 2002:a05:6402:222c:b0:6b4:d1ed:95b3 with SMTP id 4fb4d7f45d1cf-6b7c0d200eemr1933559a12.41.1794585904556;
        Fri, 13 Nov 2026 08:05:04 -0800 (PST)
Received: from [172.16.240.104] (144-178-202-142.static.ef-service.nl. [144.178.202.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c264d99csm1123946a12.36.2026.11.13.08.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 08:05:04 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 13 Nov 2026 16:56:46 +0100
Subject: [PATCH v3 5/5] arm64: dts: qcom: sm7225-fairphone-fp4: Add battery
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
Message-Id: <20261113-bat-temp-adc-v3-5-743979a8fd90@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794585895; l=2551;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=BTbJE+uVkaO8/e9NHFNdcxadF4slrFM2xvgSTnvAGGo=;
 b=cVBBAj087LJNnomjguZpThneLwRiRu9MSVg4YxOXarDvVQijERMPCJyr2UsYdSnMUUXSAZRwj
 dA3YJuS87CcBsIa8XButhSk1nsJGHUrL0+mPVI/KRuZHfjefLVspIaC
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add a generic-adc-thermal node to convert the voltage read by the
battery temperature ADC into degree Celsius using the provided lookup
table.

This will later be used as input for the fuel gauge node (QGauge on the
PM7250B).

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

