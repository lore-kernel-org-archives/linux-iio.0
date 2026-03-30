Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7C82E8DEC
	for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2026 20:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774900876; cv=none; b=i5rQFFQFbfeod+ogjWcowZRELH5Kq8FapwUBa+ePMjabsWEbSxrMecq7M5NFVVJ1mDTaP3ZGM7rEJtEjcWS7Y+c/dYDjHM21SMQrWi9Br9WCcf21XPfAe0ryjb/MAv+7DPvP9UBXffomS5uyHivvfW5rkzAOOrYJxYHHomEkrNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774900876; c=relaxed/simple;
	bh=P2GkHmZFdqZhu/4XFycrBk2b0Q7p3JNJsFH9NHtU9wE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IrXifr7WUxrAT4yEA6PDeEou0/Wic/4w5ZtfZ8vLgCq99+93AGtOpXvYo74pAkmg5Ngeb5n7HYNxQVW5H/UykM5tcsx0VKhWowy5hZ/yaYiAJ7LvTco9YXRYKvhDk5iuNClra+5toCsV83Tr1WfgSv1ljud1G6PkYKOiGKnOV3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtiZOUVF; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtiZOUVF"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7d7f592b8beso4182304a34.1
        for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2026 13:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774900873; x=1775505673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LxIwxmn6J4qQSSCoJJc8i/ANaXaz6gkd+aLXiTOc6XA=;
        b=dtiZOUVF8dDuFxE8ZsC3qGe7t7pGMCs6dNG/yOuYtBG+thCD4akLa7ymYh44W6cJc3
         VKqn0+cBParMFGhhVGLwYs5tPkgOSawm1Z4VGnep4XmrkL4SoNIcraAIjF4n28UUh6nA
         gzhofoQ4CXw+X6LlSgsEgGJA/3fLQdNaBVAOY4w9DTKi3KqU/557GY0VS/tBavoEIdji
         8ZgC+mKxx9tMaLT5QCaPYgFc/a+gZ2Wy9PLrATCy+TgEwq/p/ZfnSSidfjFN+C93zMoS
         n2hS+WlrYl203nCfreTzoVfZ4TVY+oOGbI9ZaQfIhuJL8/IET6Ih1suIBYl0QnhuqAEb
         CKFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774900873; x=1775505673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LxIwxmn6J4qQSSCoJJc8i/ANaXaz6gkd+aLXiTOc6XA=;
        b=aRNMdTMTTAAc+atPKhIaORgOj/yE8lDwa1ONvSqTLgTXFFQVbd4h36oUZdo33amrgm
         XVwZTYS/Qv00x2JnsHvRXydlT4bbAnTnWtvS0VdvEsFnGyhFTJGpsC0dUzF1YmNBsxrx
         TwIKkbcMes8U+2QffIBZxjR7PGXQDRvFHWj6p7T89y92yFVzC+QhyVz0sxvotq91lNws
         eQdPcha4sC3fOTqWeXxQk0im2DPNgEksC0OZmRg452Pkn0zVzqeV3sTqx6a4bGaknWY+
         T++8mHK+fjEAoC5YXvy48/cKoDUsUKtFS78ZCW5NkhluqaJSiLrnQm0ApflVtAhJWAwN
         GDPg==
X-Gm-Message-State: AOJu0YxKfQDyfVbVEDgjYFpOnGtQ9TMIlDCqoNbGyIwwL8qaDMnLifBk
	xNRVNzM/k8vjH/Cp/+9fZ29EV+c5xwHcpvkYqLMrb51i7VroCrU+Az0ExkGO1JaW
X-Gm-Gg: ATEYQzwdZC0A29jgODy3RM1Y6k94+6YTfpyoVb/mEKf3Tq9fyXgLyzAE7K/WphG6jxK
	Sy10SpVjNBEEpMQ1eB3HaGQcTUqhuENBW1MRPaGAf87D9mVyTGZKjbilUXrKQphYNPaq7ZOqm8Q
	K501N9+2EcfPWEs/KJrHYEXnhWWFE1P+K5Lx38WbtWxsZ/CHSOJjcqWOFHEWDaU6p/Cq3S1U9Rn
	/6o0zOho4IHwOr11O/qwGgGdqBp7WRTcWut0XwP/ropDnHlc99RGJfxqd1Lc+K4ZyquXTRU0muc
	4GiU7Gymu/5WXsEZID7HwDYB7ZuHxZiRSYt8WEJsyG/7B5l+YUEqV6b6+VX1HV8Ns3+c4SpvX1M
	uQkGPgdUaeluWFvBdCcabCF75uKdOVpM6Qr/Vf8CQ9cf3gDckevgX4csGhWcMHdF36IX3gKKQ1R
	ERHz1svnl/6L4Z3Cpf
X-Received: by 2002:a05:6830:380e:b0:7d7:ef0a:1ceb with SMTP id 46e09a7af769-7d9fadbd658mr7337761a34.9.1774900873526;
        Mon, 30 Mar 2026 13:01:13 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a336353sm6601068a34.2.2026.03.30.13.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 13:01:13 -0700 (PDT)
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
Subject: [PATCH V3 9/9] arm64: dts: rockchip: Add icm42607p IMU for RG-DS
Date: Mon, 30 Mar 2026 14:58:53 -0500
Message-ID: <20260330195853.392877-10-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330195853.392877-1-macroalpha82@gmail.com>
References: <20260330195853.392877-1-macroalpha82@gmail.com>
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
index 44de35bcd001..834d2c940810 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-anbernic-rg-ds.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-anbernic-rg-ds.dts
@@ -872,7 +872,18 @@ aw87391_pa_r: audio-codec@5b {
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
@@ -933,6 +944,13 @@ &i2s1_8ch {
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

