Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A5A39A7FD
	for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 16:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771950817; cv=none; b=C4aJqo3ns+MuHCWGYXuENjt7g6j12Nbt2Dbl5YU9b5BntMocLaEZNCWPDNu/bqXN2GP20Tc1HA3Su0XTp11+gA/sqPaF/vgkt8HIVTPr9pIfdMXLSHKozl1UULXHJ1gS7gRjovR9RUzd5GcZuq6zDBAELKyn2dpO8ifdW37G7h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771950817; c=relaxed/simple;
	bh=YigxfMcUM7F7wDTso5bAXadDsaOG75M8ya7KhfWn3JY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vtkv7JXtz6qrBUKZa0vz25CXMS1xrB7pegjY1t1Z8BPweXhOuHqi+Zl/xuAuye7Piv18JzspvPVXN8/Bi3W9GnwbMTLdPcF9ZJ0qybXJqQQtYE38UrylOh7Y3OPa2gMQskMQLYiTJBvLqhvqIKCe00as8h7Xb9PJtIAGF54FZGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLQN89SA; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLQN89SA"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d4c307db9aso3140676a34.3
        for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 08:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771950815; x=1772555615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5QZMGPSayDx6CXME04ten6dFk9tjtVuD/jHId3mdxWg=;
        b=YLQN89SAHacD0pms5YQcewzUGRfmvpyV1ixLd8JJVN1A/2kMDU4a29b4b3huFxKyAF
         MFEN3Z8cN7Uf7QTyPtjX3IIthtuzG9n+c0p5P5ME2hVnl36LLDNsZgl8kuLE8HJpXMbn
         MdYniRM22iEBM9hitfS69hX6aXEbZUKdG0Z8yam0BLf0U6Dy/JUohmrv3GJ2yitjRZmU
         OEArKf5AT7aiUqYD87etLAXOVszlso+w/mlWU2vmKGqp2kGPPYdCcQ+Mgf4RTaeeWYIu
         sa5mq2HcBfGjjAb9INvsVFp8em0MJ3vnoYIgloZ7IunVMQGVKmvjIE+4jAEIK+cdipzL
         DfTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771950815; x=1772555615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5QZMGPSayDx6CXME04ten6dFk9tjtVuD/jHId3mdxWg=;
        b=CqeBpMrmLLeKeCzLqTSuTad+dE572odJ4bN/IpbRKjwRTF3XPLlXD+x4KqRRzmNRuE
         nWTpRf+thgrHgg3L5rLsZwD+FVHhznSwPq7eJMrSCgHJm0g1lg6XejsGMY78vpvXjvuV
         gLLtYwONg+2w82pBNMznhnNbleWr1Opo387fEjOl6z8gcWbqw4qttUVnRFNLy9fHEm06
         KGEI1UoAoGHpBTB5JpJjD4tVVfOR9d9Qvz+61p9JNOzFjEnv2Jb/6EQu7gVwLfyy3+KB
         LPzKITFo2sqrt82YZDr1RUB+pbUsuHUZTQu2M4GcIds/OmP/O7rzVnuwbtWCsBgVWAsC
         wHuw==
X-Gm-Message-State: AOJu0YwLxwUjOic5+ARBRCrlgczlYJ974Qgzm9+priE1Jhe7wClVJTih
	uaQKO/I7FdcSpSVHGWbwA5FfVf2m/1QsNFk4o9Mw13aoaKChgfUDHJA4n2VXqw==
X-Gm-Gg: AZuq6aKYeWXgf5QNvYfIwoeLTUG9H3dBmjVCtdliRJKm1+eLxyvd+9BRH82gM0emM3A
	LvUAEkyONqCRguZKRFhwYa7zvdgQN9ct6tPYOZs/yYcWjFswwwPL0UrVgz+15adJr1iDp9K7wAB
	zdnKQEqgai6UNoHB4B6ucwg766GFk29FwwO75sHYu1ML91mPTTaxcus8MrLip/6bdDrMXGPAMht
	p2qItTcF2KxvBRapXv6uWWqafUtoShOsSeWTxGdUloEES9XIFtZmjsSThxPwVvSocGsEtYXS2g8
	pK/lZRmXZ4TpD6Glq9OrNuV7YzNSoxpnNWtohdihnNIMt/mVqvxCr+A4k0I6ZYyunf0R92COU/v
	2yPvo4SUOYBZjNLdkXL2xhLgQI89BJBbW9XN7ra/P6UemPiECMkA6GeaWRR98CnNDr6ajU30/l+
	m5L7YtOvb1oC9ATvGSzKjN
X-Received: by 2002:a05:6830:6603:b0:7d1:91c9:9e5a with SMTP id 46e09a7af769-7d52beab9camr7144263a34.8.1771950814470;
        Tue, 24 Feb 2026 08:33:34 -0800 (PST)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d52d0725c4sm11060130a34.25.2026.02.24.08.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 08:33:33 -0800 (PST)
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
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 3/3] arm64: dts: rockchip: Add icm42607p IMU for RG-DS
Date: Tue, 24 Feb 2026 10:31:05 -0600
Message-ID: <20260224163109.370930-4-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260224163109.370930-1-macroalpha82@gmail.com>
References: <20260224163109.370930-1-macroalpha82@gmail.com>
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

