Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82673C552D
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 19:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778354511; cv=none; b=ryu8k9EUOYI4U+sn6oCmkL43TeTyEPVMB8xEA4aL3ZA95BDNiKDmXe+M5N1Sp67tIjkdkYTWsOyq8AjxXE3An6i46IU+EuSafvUJo24HkldMzWqbY79c38Tjcw7Gd1I8dLGSdxaKBk4dfIo8tMzBwlRFEHO4oRiySozc+Urav6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778354511; c=relaxed/simple;
	bh=7P166A8vdKpbCTvjwJ0c7DTCaR8r6ukvy1kUs71vwQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iZbazf34u8oUF83w/dvmZBK0wer5if4f1RZfgZc8pEHtIKJSL7/wmX7iweDo+Niv04n7tpazj1+U8QtWfBNCB395C6C9iiN39Hyf4UlryIDOFwbt/P865FUDtQ4LBRzHFDZELzhrAG3kQIsRs9cq9JxgLofbwDjnYwWod5i6B0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n0ac2Z0h; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n0ac2Z0h"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6949831a7bcso1663397eaf.1
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 12:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778354508; x=1778959308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wNoA18UrHfHWWifSIaqhsuJYv6mLpyyKyk6HN99Blw8=;
        b=n0ac2Z0hpp2ofBDlk7KTDo4BFTFRDRqoQoYOSvG5mizJJlfbQRyGQK77V7ZfuVpklS
         UI094MNcLQ/jCp5lHWbAZmaeoQ6eZCg7yZ5MxiPsFqXuzfLz9V3S/XN9rsZ6r5AtT67s
         tvM3nUMsA3qAj4DzdkCwFnt3gJ6s57VCCr+ex6/i4fbCHsVS/zvczrj4r6mXUTklcZTL
         zwcffvJj/smb8BcD0IS0JjGUBQSphRWacRUxQTTEkYXVO4BVLmunfGQnu6xnusMcovsr
         AZvdh05jDTP4TjC9kQi7ZgmLaXCtnXFZKxqqc75jgfqtWaT35+rtjoTqfxdXLg9qaAsP
         zvrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778354508; x=1778959308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wNoA18UrHfHWWifSIaqhsuJYv6mLpyyKyk6HN99Blw8=;
        b=ifxo6nuSaOF8wjbj77U0xLgR+/j9FTbop0aYL/j4RO6WdSoF7BmlSR6dT6KqQsYayi
         NYlGJgVTHoreK+t2Xtvdqb/QyaKZV7/OA3jfgZwYjKxSLw2TEjly2QCFf1qAwBs0H0fe
         SoOMsG564V62MgrUNybf5ozBGjOwl6gcUP1QOBVb4SpbDJqX0ClwIRqzOCiRfJ3cDINN
         B5RtBdg+76n8gK0lbDtx40SN4Cv574phMAdz+brYWnfw1ysjr0c8z1lj+ZeIPtMNghwx
         v0THyHwpNnj0Gy3cOdvPPjep6V/UeVTwpXINqmOuWcjLTsQa/ZJwd5Sus7YiUMD5yloW
         PxfQ==
X-Gm-Message-State: AOJu0YwH7EdNcITz58HiPZocbNMrIVCDU+Z6K/2PcCY5+MOUImc7QLTq
	WJU3StZrGigNbBFoVZri77KRZWXEUgUEh//FEakPLsckl/JFtIJrsUbd9URl7A==
X-Gm-Gg: Acq92OFU4TAM2Wn3E/oq3/vX8bpIwH7URt5RqkAVjO4cTO+ytVhexjsjCufj03ey/az
	FMIExlB5GsZ9/pM2aY4ViqiwDK6HJYR3SgvkDQYWu7w+ujm1LPwjO1RToJdapp+taxCfKnWODcc
	ntt7TahQRevZ8SfFfGdWG8uGh/4ZPOCYUXGZHm9jotCyXuSdYVgSWld2MrlXjruqb2e9QraMD4p
	ehXB8zgUBrf+hEjfOzmxx2y4sqNrQ8WGyBeMb+iHInApsR63E3c10hHCBpPNkSouekzkamiy6Nx
	ALcxj8u/gtIEYtOr5Yemwd5ARCZtkOMkhCIaLC8Vr1Pnjt0T4Z+bGnqxdE4K3yD5VaT9EnZyFrI
	3T+2byg41Y0qt6ZSlXDVj+py5REalI/EI/i+VBuDEQnf7xECIGfK/djP+iqtuAW1D5rA/HUBQ/C
	RVIUfHi9ueGaNyFk9QFsDg
X-Received: by 2002:a05:6820:1503:b0:694:a362:e3ab with SMTP id 006d021491bc7-69b25d2bb6emr4168344eaf.55.1778354508542;
        Sat, 09 May 2026 12:21:48 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4355736f517sm5243896fac.12.2026.05.09.12.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 12:21:48 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-iio@vger.kernel.org
Cc: andy@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com,
	jic23@kernel.org,
	jean-baptiste.maneyrol@tdk.com,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	andriy.shevchenko@intel.com,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V5 11/11] arm64: dts: rockchip: Add icm42607p IMU for RG-DS
Date: Sat,  9 May 2026 14:19:05 -0500
Message-ID: <20260509191907.24734-12-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260509191907.24734-1-macroalpha82@gmail.com>
References: <20260509191907.24734-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add the Invensense ICM42607P IMU for the Anbernic RG-DS. Mount-matrix
was tested with iio-sensor-proxy and reports correct orientation.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../dts/rockchip/rk3568-anbernic-rg-ds.dts    | 20 ++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-anbernic-rg-ds.dts b/arch/arm64/boot/dts/rockchip/rk3568-anbernic-rg-ds.dts
index 8d906ab02c5f..875ca884deca 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-anbernic-rg-ds.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-anbernic-rg-ds.dts
@@ -871,7 +871,18 @@ aw87391_pa_r: audio-codec@5b {
 		sound-name-prefix = "Right Amp";
 	};
 
-	/* invensense,icm42607p at 0x68 */
+	icm42607p: imu@68 {
+		compatible = "invensense,icm42607p";
+		reg = <0x68>;
+		interrupt-names = "INT1";
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PD6 IRQ_TYPE_EDGE_FALLING>;
+		mount-matrix = "-1", "0", "0",
+			       "0", "1", "0",
+			       "0", "0", "-1";
+		pinctrl-0 = <&accel_irq>;
+		pinctrl-names = "default";
+	};
 };
 
 &i2c3 {
@@ -932,6 +943,13 @@ &i2s1_8ch {
 };
 
 &pinctrl {
+	accel {
+		accel_irq: accel-irq {
+			rockchip,pins =
+				<0 RK_PD6 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
 	gpio-keys {
 		vol_keys_l: vol-keys_l {
 			rockchip,pins =
-- 
2.43.0

