Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B00C39EF0E
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 22:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778624355; cv=none; b=ODwXH4dKHtIRiT1BqcgOQgieM9tjQvUPLWweCFwwdaxma871pv7aA2Rw5raMf9DcuqveEMRfeKBRiv5ie6diznhYfjAtZANEENNViHaUMsWDfLjdCkh2V0jlNEfR6L1XQgvpYB55Kemj9O2Mx1gqSvcGmV6YsrCZCj2qjZ1YuPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778624355; c=relaxed/simple;
	bh=7P166A8vdKpbCTvjwJ0c7DTCaR8r6ukvy1kUs71vwQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U5g+ebEsK/Lmd074qg+iXLS6FocySHf0iFTyYKOm0N83XV8XLT6UzSxCEGvmTWkiqWwkXi92CECc9XV+8t7XvbnXpXI1JsZVzqQQFKy5BqD5ZoEhkTStDYTEKA7YjeXatREJJAxFUtcQwmzlzMmSyOfdMXyCjyAb9Vpf8nyD8D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fbfg3b4f; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fbfg3b4f"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-47c35be02fdso2416159b6e.3
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 15:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778624353; x=1779229153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wNoA18UrHfHWWifSIaqhsuJYv6mLpyyKyk6HN99Blw8=;
        b=Fbfg3b4f7XmrwZB5r2LLGY1pyQAwbg/VDc2bdkYDTOrOzsW9jAreqX1nnVLXMZ/rFl
         rfvuAx72VgjFOuR6pJGPhjmgrxCroX4Ph7FOVvDMhyHp2CwqJDQwI1RI54E/m1ouTy6n
         NxuMmXHpg9uQQL3UGpfbFWU279W89pU1rdC4NbMTmwQVF8y3ZMbiSUqR0f71k1IXvW9e
         gfFGIMe6G5km43f2d2Ruh44bibd0AsmlLASVT4copBCxFeplwhIMOgrzM8m3QaRXlVLi
         wH9Qae/mxFcyJNDFRbexCE8A1oDzHcqnHTUSv7esHDBS+T70+1A5aWWAsE5uw7GUuBlz
         Vjww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778624353; x=1779229153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wNoA18UrHfHWWifSIaqhsuJYv6mLpyyKyk6HN99Blw8=;
        b=SxsqSwEmbgOGEBrdovR3A/+QEq8dOupXip86XgyBwDDBxBU3SJGdC4vWC4gM3O0hAO
         q7DgqUndkLY8tWINGm4aYeqf1YwC5U9mknMhgxEG56a6kbqWp47S2a7FHOxSxnM5GsMh
         N8DeAddmrBmNq+I81zyYq6QqzWyNVoCFaUXPgpLPJ/yOIfJrmR1ueIqHxOa5Acq8gCh+
         F4w8N+Bn3w99X9p42QnQDXygJEbchuRYIgjJdkL6Hd1/A/Wj0hdbBC3ONa+RuLJo+0tL
         CLyd2VgWKCdFtMQYSAxcpmvYaPPaI9C1WihG3GEdkMkdTz0mqaSzyxeW1ZtpVO/QFOsS
         Y8Zw==
X-Gm-Message-State: AOJu0YxKtXVkz/1NTZpDJAqll1285FWx5nUnZ5O+cL4n1UjZNPNKY8OA
	GqMFVcssmh98Hcupx10eZGM6Jiwd+pxCR6qZO9OpieEty4NaXenPDL6mNhaNXCC6
X-Gm-Gg: Acq92OFYvA1zrqVYs8NvtzQRhNZ9kSPb9lfrnwBZS6JwxmPlV9LVE88C5fnDAOSjF+7
	c1yKhW6+nHY75INLP7EoffjNrQtc+RoA80vfUA2fe6i2l7qCsDqS3EEfeoohpn62W26qfPsXRaC
	sSCOaBW7x7BrJc9KaJ/mHyQG/tfilOgqbkeVCrqyHYM1//UCPzVHQGbdpugXO9nVCeLUSey5IbQ
	wQweQptoUlesMREAXMOzXxiTjQzwxPOGQhG0iGJ0U1lDSIgjjQpO5vYfkoRJJjbehmcFt5tF2lz
	Bvjp0dhzWFTszyjqrAqWfZEevM48JW4QC1PtEy/o5LuooBDD28CYwNH7hx2NBkzqlyJQED3qmcl
	CuqnEWADfY3gOPeDq+7itWZcSlYRK2dGyZXlpojxwcRMMu3ZsdZukX0AivRAMh2Cfk8bgKk3be5
	a65R3WX5DMzZYNz1iCmcIp
X-Received: by 2002:a05:6808:1c0e:b0:47c:3f6f:db97 with SMTP id 5614622812f47-482b2b8a364mr584683b6e.21.1778624353379;
        Tue, 12 May 2026 15:19:13 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c76986f87sm23291473b6e.13.2026.05.12.15.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 15:19:12 -0700 (PDT)
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
Subject: [PATCH V6 11/11] arm64: dts: rockchip: Add icm42607p IMU for RG-DS
Date: Tue, 12 May 2026 17:16:32 -0500
Message-ID: <20260512221634.256747-12-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512221634.256747-1-macroalpha82@gmail.com>
References: <20260512221634.256747-1-macroalpha82@gmail.com>
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

