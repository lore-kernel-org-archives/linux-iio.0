Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C565D3ED13F
	for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 18:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773945155; cv=none; b=KQQ5fh6O6hXmv1BqsqDaCsAJdqqq6reGT2ypDxWfpB1fePFtKn+9nBJwrKj4RHlkdslNrTzypJjsnp2fBVQRLmEgeGamQZGlpKwzfefbj+uap639Aa5ZyzAgDrV10Wj/RvsTSp+5/Aogng3eMzLytGySXZx2d7aKYS25kXPTdcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773945155; c=relaxed/simple;
	bh=YigxfMcUM7F7wDTso5bAXadDsaOG75M8ya7KhfWn3JY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IMc+tagszL3JKhSXQGJmAr0c3uA+hC25x98PZgsl8A2HHfIctRQAiZcnAfKTaTgS8OWJJuxg3WGrhdvwbvSZ6Ry71C2h99sDcjQmy7JoTOFoY1I40zZVUQXpztn42SCRIKqel8+/yX/8fiQ7j2HsPY35VJOUoZT+bCiaw31YoGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DxO86JH+; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxO86JH+"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d7c76e1951so1033030a34.1
        for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 11:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773945149; x=1774549949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5QZMGPSayDx6CXME04ten6dFk9tjtVuD/jHId3mdxWg=;
        b=DxO86JH+8iYKPqyAIEek9guoY84PO1h5c0e5QWkz6VrwyN+ozRhrulcuoF+YI4sDU3
         Fm4OoFpY+zqegnSBIQN18p6nUtdQYmS/VghA+AYXbSPnPpQbBFXvW927QM7skEV/mIrd
         mou7kt4pNQbBPr0+x6tWby3t75gGW0QQCbCyxYPEsw+CW4y+GAEmCW/WiD2DqxrMcgyu
         7Lkn7Plam1g8Sspn9xJkuvFOikdRfUHjHK9gCxJwK8ApTgUpsMGfoj7/wt8pCe1h6YLz
         pSEa3urOFs1hNLB2hwZsp42/FxHzHGipiMFn608K3X+kStxnc7YAgmZC5jZCo8qTuuHz
         K4VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773945149; x=1774549949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5QZMGPSayDx6CXME04ten6dFk9tjtVuD/jHId3mdxWg=;
        b=o4FytS3X0ppHOdRR6WRDs8ccytgFm6Y6AY4IoLKFEQ6pJpJUeJP0xz2psvxxUdZVmu
         RmMT11rRII4TnpvrExrgZuEjwaEaxXx+887eBIIy4wcaSxQhENw7Tt8nUdhKuyZPk0r8
         Hk53qH/Y+kM7hwNSBE+Zp6HbzkfPa/oRQYcGPHPas0UZelyZQC500P8sRTEYjrJlOJoS
         3jzKyJbIKRUrP+3k2gJ9HzROQ+CT8YRYIey/IDDKbp2SLaCdWWLc4EpKdoKJLPQJyKqd
         z+rNQ3YmX4r6d90uhfrCyQ3Rldp/o/Jr0mqlfq+S2cjt8r/p1jcPGkkM7N/sU3bsrnof
         bbZw==
X-Gm-Message-State: AOJu0YyEhlwrp2ADnbLsI4PNblzIv7kWGSp/jUxQn0SBIs6ahcIANPhp
	+WTcZph2M1OAwu5EWcrAiK4n0UPR1ddk15djPkWrKjBJHX95MvybwaeWxN1FgQ==
X-Gm-Gg: ATEYQzyo1BSZMjseyddK05u35IMUAufA92RIR3wFadmzpeqOalbQXgJFrNWwlyCy38n
	/Tv7sLJXC6Ulr7IXgY7mEcUjh4R+OkkJr6PmHeF2uKVCI3QT7KYpzyb885pPNuYREErTHAjQFtk
	DfXsjNLvbmTSZoMnxM0PDuw9Bbb7nKBB8q69MsIJjEiYahW34V1CO+9w1hf1PVpt2YBv5VT7oJ7
	vcEJDvJokktNhgdF6AlQnOJYLcwcbZgxz015Zrqyj9RedBQ6zw3BddvbSxtOPrlOtWe3WP+TzhJ
	fFAP+Rr7McYiMp3J/oIZAeZKKoil4czBqkzo9iWKITmE8RdyUcUtoF50n09kdMB8lOfR4YBXwnT
	DIGk68AE3BPpYsFY9AVEybsFGFNoFXs8QjuoFUtCZc6bTnSIVTc/71DB1RfJDhsv6RxQVL53jn9
	TGbi94qQHfHL32PlVj6rG6
X-Received: by 2002:a05:6830:82e1:b0:7d7:c985:3a39 with SMTP id 46e09a7af769-7d7eae9634emr171528a34.10.1773945148951;
        Thu, 19 Mar 2026 11:32:28 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7eadcb11csm172193a34.13.2026.03.19.11.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 11:32:28 -0700 (PDT)
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
Subject: [PATCH V2 5/5] arm64: dts: rockchip: Add icm42607p IMU for RG-DS
Date: Thu, 19 Mar 2026 13:29:41 -0500
Message-ID: <20260319182956.146976-6-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319182956.146976-1-macroalpha82@gmail.com>
References: <20260319182956.146976-1-macroalpha82@gmail.com>
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
index 8d906ab02c5f..dca270abc475 100644
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
+				"0", "1", "0",
+				"0", "0", "-1";
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

