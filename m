Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794903871;
	b=XaNZBEYnhDsq4jKrQ5ZEN0mjN5DOoDfSo6UYI9EImx2zM7yN/7AAmSwaIgYCkxadv+oy
	 ZaBGf3FXtQBhnj3x5IVwsnxd9pLol4G9vJJul+95saM9jvJ7dAJWOUcxDGVbPp+ZrYliR
	 lSHWQz6FbFPA+UXQg5hMWMddERErQvex+54ftb3DS73CYiZ3Xt4DjYKbEiUqn6DG7ctS+
	 S+4dUwgKtyPNjonR0dZDKHq+8z5eJLWYfFLec91v9ZOh1i7Q8Hjs4ahkA6L5VKVtGrf9u
	 110i5fi9sdCdGXCWxfIIfZnlY8k3FE05ZWoyb5UiXIcHE7vZlCWZ9bBLg1qzKYiVegw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794903871;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=xw3xnb7M3ni/K395S76W5M9HsZ1EBFx8fzPBd64UQdY=;
	b=4KOGAtEC+v0ICxicy9OccCkC5wRTrCb8NXnR5r0jiJldWRC5i9rfkFZfoG50uY/Fvds8
	 ERkIHaJGlvmmLeUjopVlyWCJLxZSKN2G++e1OshS4GythyvqI12XciadYKmLTLDBcuBPK
	 J2ToAPzxxhlnX5XnW+hpoy0hJ16W8Bkb5IOBI4dVsMSVfTvnpH1Gj9lP2wLdtXa7Kk7Bs
	 pu0eN47MEAHmWfIC96IOnwv+e2Wh9htzgCJdv5WWlIaCUjOTCgKNFsNSSI9cpM3WtKXPD
	 6ERh9TMGrqZBe6jcl2B7oc7+5rv5x3H54uhvca51Pnnw3etP4X6kFvibdDEcS4zkSqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fairphone.com;
	spf=pass smtp.mailfrom=fairphone.com;
	dkim=pass header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=SHbfSFnd;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A7860A2601
	for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 08:24:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00A7860A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=SHbfSFnd
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c506a231b88so621642566b.3
        for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 00:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1794903868; x=1795508668; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xw3xnb7M3ni/K395S76W5M9HsZ1EBFx8fzPBd64UQdY=;
        b=SHbfSFndESk1yY8b/OsbMm/euo3XP110OsJVHrsLsdYSpOY39tPL6ns+z+sdP0oJFk
         khgUnzyP3YKajHvNhpszCJiaRzKRtMHkVX8NHWr2m6xdTSFCkJU4ClvYmgNS47iMqn4G
         MHFIuQFpZCo4vBGjxab09RtA+7HfZ2oVkncRvzSkTZ6cfeuB7KTtE4BuPY3EDJRdjcQy
         rShqUqiojPjqHm1NaYlFFxn4ErPnsIL6rn0ToRgLYlEY44TbdaQYdlDTMUIDSsEtNCTE
         K//0K3ZfoWwvtEJJmfmTtkf3aQ0EqnWbrYdeUoEqBUPRYmpIiWaE/5EELg2nOLU5GFEt
         jkew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794903868; x=1795508668;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xw3xnb7M3ni/K395S76W5M9HsZ1EBFx8fzPBd64UQdY=;
        b=YxY4bPI1SnxWMMF8jVBB6PuBbl9eP9/kAMdd0iLlx/xSc+lR0ag8Of+tQkm9lKmBjI
         ZT0MulgdDMDbjh4ChLxddPpESnzaWCqzEOCAY61APKPA2yNx+q7buC9YqtIvgaDjRLTy
         wtmIJnw7PDecqtBDgE/KYZpsbxoNPs7frLi1oGcR9yGHWCp12ag1S9U+xf8a1cCUG8wi
         SttIct5WAsblXMCw4Ypa/vQFFFsrBVo1tctEh99/hg99HxNE5/3N7GGjEtM+FCAXGLbv
         bBTq1h0ve83cKfG0wKM55YMTaiFaOv6b+8Xna5zcY/ustptncRb1QGpcCvOFoYxevfK0
         ca4A==
X-Forwarded-Encrypted: i=1; AL+hErFD+0ryaaZUxTMrbAiIAY04o5IogG7Oe3BdeMtQjBtEsTMqb39nRdkL7meD7tjVoCNTc9NZb2aiLfc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9QhFPjMCLOTKAtFiBY3oAiH1I04CdgGQTaCApcsRTVz3TRuqan
	hQ9+fyfLrkfPVsX7sPPobVuhj1bdk1g0xWdeK7UYvDUfK686y9suZby4BmQEy2myE4s=
X-Gm-Gg: AYBFou2Z50Dp5KBe850oIqJNI/AIup64qqUzPV8dXUuFR/lTBnPk9vKyw8Cg/pOVtwR
	U/oXgswHK25R+yigNhc9f4xyuL9ssPqRMiWix6inCe9EefSM+FzzwkP7MMowQKg2Grb7zIUkVnp
	8rSEzBPD3CvcoX+9zMTy7UlbkTbGJ+PPb9zkDuTPRoxtyNsbEPGUQf4g2XL1FOn+mwKoX48A1AZ
	mpzEss7AUvYS+H6jkjk//fyzL5ou9OmtDRWJ/7Kap354NJ9TQ+a9nGeyRC38BtRISsebUdD8gDv
	KeW/v9zJ+64vH6BkrZKLFaestjYdlxhqEy84pticnHa6zBQNWVGA3lR2z47+IWm+9UWn2xohqHP
	FdjRr6bD//bc6cSxq4Z2vImQowArt/+qCCbCK/0HGmkLAk0HgIAJKQ7Vv6A1eOxsZtlXt/xhXhF
	TGvj1Ha2DFPWuZnKkLDTf6o8EE/O0Kug6v1ALeiG/9b3ENsgR0fXK9K47V1fcYL0eWXwQqsRtGD
	XzRpTNPzeYDwFb4h2IKbmtcyGTNHh0zkpAZ/zhHkhWsl+vXg8XpxSQJhzxBGrJHT/BtNJWgWssJ
	uaGnD7bxhO2F3Bo3e4TkmzQz2SV8XgISBfXvKn5YDyHbj/la5DnmX9JEtaVodKq1AQQCT369cW2
	jKsE99No+0VzUz7dXtWdmsSQ1gd0uvWCnE/L4Ilq2+KtH6+/P
X-Received: by 2002:a17:906:7315:b0:c42:fc8b:6c7a with SMTP id a640c23a62f3a-c5096550449mr1132986666b.41.1794903868527;
        Tue, 17 Nov 2026 00:24:28 -0800 (PST)
Received: from [192.168.101.179] (2001-1c04-0504-7401-4b2e-1820-6d24-b264.cable.dynamic.v6.ziggo.nl. [2001:1c04:504:7401:4b2e:1820:6d24:b264])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c23611casm5616953a12.9.2026.11.17.00.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:24:28 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Tue, 17 Nov 2026 09:23:14 +0100
Subject: [PATCH v4 4/5] arm64: dts: qcom: pm7250b: Define battery
 temperature ADC channels
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
Message-Id: <20261117-bat-temp-adc-v4-4-14d5d309ebfa@fairphone.com>
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
 devicetree@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794903862; l=1412;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=b7mnu5CgjN796/wKAPryTmfFj9uk8BxPsgl2XchGimQ=;
 b=IEavwQRoBZ9J/7BaFptQKLVBcbOzlROC3o7elEG/KJxaOX+vWhvHEkOrTZSwFs3fttmOJJc3Q
 PHcebENwoAHAURwSzKsaLbonycN9YknjNtC/PDT1eB5SmaSrhF3UTW2
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add the definition for these ADC channels to the PM7250B definition.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/pm7250b.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm7250b.dtsi b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
index 43cab07126c5..91e83587adf2 100644
--- a/arch/arm64/boot/dts/qcom/pm7250b.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
@@ -155,6 +155,22 @@ channel@1e {
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
@@ -163,6 +179,14 @@ channel@4b {
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
2.56.1

