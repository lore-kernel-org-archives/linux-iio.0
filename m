Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF9D37474B
	for <linux-iio@vger.kernel.org>; Fri,  1 May 2026 22:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777673673; cv=none; b=uHVSkeg7ydh8IM7FfiRI1+aFyeO1w/MnZnxG/J7fTluoOrztJdhHcVWmzEJtl+uW8sl3ARi5N6RbpjgMT3Cwx52UYGoms6Rb1DcdMQhamVt7hGl2o/gp/7IDxWuUbUmAzLNFo0cXRRmqEy+K3P+3nz5gHkkcBeill/aLW6WiJIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777673673; c=relaxed/simple;
	bh=7P166A8vdKpbCTvjwJ0c7DTCaR8r6ukvy1kUs71vwQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jWY5UH/TdlFcfuBnQS44O5o2kpWL8bGdPsmvgvOHzetIE2Um5qhYNNlU/TPrUiJkFf/qIqi8MV5JF1q9pmJcfeMaGZ3OKGzN4w7sRW91ATMDqgzoc0zoiLcSotLDG8Y+eF+IzadbCiQjWHESRKU/+Qn0Ziefy+VRJ/Kmynq55Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nUq7eB3F; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUq7eB3F"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7de44ed7a11so2003886a34.1
        for <linux-iio@vger.kernel.org>; Fri, 01 May 2026 15:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777673670; x=1778278470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wNoA18UrHfHWWifSIaqhsuJYv6mLpyyKyk6HN99Blw8=;
        b=nUq7eB3Fdq3tn3y/xIB0/XXeIoRO8UL/xCcJY99gxmHee7wE1PdYodi5xpsi9ye5ps
         Fcg0JbxKmevmCHmOMriEkAQ9KB60v7x7AQHjoOPyex7FjtNK2KIp1b132/1KN7Kfunha
         yVQcI5lXi16NnLFJcxtFPYS1pk+Rf/3Fk8Aa23XHvMzk9PDpi1C1pyjxS/BBweFYvO7z
         WdpSN/POv9wwxEMPZAXxmvxLTGO2m7iU0eEpDhmZTmc7nGCvlkPy/Lr23oR6smj4gL4v
         DXWDw/OaUTqUrfNTMJGqwSjMQFHVoKIDJRNtbp/e/OlYeT2WdmgR/MJP2rEUJQRdD4RC
         P8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777673670; x=1778278470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wNoA18UrHfHWWifSIaqhsuJYv6mLpyyKyk6HN99Blw8=;
        b=CUylkDe3ClJWYpl9SJ+ojFF1BxatLU8B/ecOcqjo72f2+iG23pPxjlElrr/QfTFh4f
         GyZ13byPjQny+7+/zjTwRbGML9nDbB+RqOoqyA0/abl8rqPTDPjsLESPop3gVR3IP0EQ
         XhPA1irySbtmI7IQPqbGjScw4Rzynnv2+VzBtwQOeBskaZQtGCgPsMXDmTB9bRDwc+sn
         WaefcOQjTn/adCRqsv7O7HRjhI8taVngHT4K6zZ1UwW4filkYMAUmbsXzhrwtBYPv73h
         BbOrwIOr78mRCXVsqVnxTnCIJf6u0NoM5+AEgM2VFXYTmY3zFz/wSdFQoH97yKef4ATn
         Y+9g==
X-Gm-Message-State: AOJu0YzQmmmgQtGbarNu9tVHSSQsWcpwlrUAIyzBOBGaJJPcntffuMJR
	XHn9oGsHCqxBoyBn/uw422DijZdS4f2EX2Bp6OortQrGCZdIa/zHYu48eu/JHw==
X-Gm-Gg: AeBDieu3oS2OlqzLEfVY6uztb21odZfEuZ/Tu26EZuhFwy4YNkfaj00et4MFgsxBoX0
	GI1ntktBlaAWxGLLL83PxJDrYyzwK43quncwJCrLpkXLheBzVv3ghly48aw8fECQZFbWAQkOLUw
	AsArPTbU0Plxo+ZEqzdgRSujUALI5f5geiSRL7ZGmV5xScChHPp9yxXNpBqDOMOiMBM3LklDVhG
	QDU3NcqVivWiI1SfUcLiH8TqWaxIlDt0IHJkQ1MitxLx7po39uCo0Wd6mI6F5/r7/S80ryO6aqw
	Z+1g98PO6RRo3BOJxEV42IQCogt8ggA6xG/bS78obYpS5jMmc6Nfn3p5eyEXxv8HoLh/gdL206J
	uivvGTsoQCBWH2Sx3PcaQXEgKImi3CTZpSXtrioLn7IfgbX2HwEfmNuNU6grJjXzOedkx35g5g6
	WW+hH0HbRKqreN6zyG8u1HycWDKeAC7Tc=
X-Received: by 2002:a05:6830:3983:b0:7d7:c985:3a30 with SMTP id 46e09a7af769-7dee1290d54mr922365a34.11.1777673670535;
        Fri, 01 May 2026 15:14:30 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ded51a9612sm1827337a34.26.2026.05.01.15.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 15:14:30 -0700 (PDT)
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
Subject: [PATCH V4 10/10] arm64: dts: rockchip: Add icm42607p IMU for RG-DS
Date: Fri,  1 May 2026 17:11:49 -0500
Message-ID: <20260501221152.194251-11-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260501221152.194251-1-macroalpha82@gmail.com>
References: <20260501221152.194251-1-macroalpha82@gmail.com>
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

