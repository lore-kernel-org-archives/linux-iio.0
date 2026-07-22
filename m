Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD043C13EE
	for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2026 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784734947; cv=none; b=jWIkV0+rO1yKGtAzmODwtAx9Lafo3xlEiDr1dNKDMiiqbFi/ZbhnYIVtsS1SYxiqumK3+eOB/U03L0JoldJ9L1YAw+Cfttag3+pmm2zbrUmz1fAZHwoEBbSlzrh8fWgUOaj4BfDpewoygGo92kXYWn9UOTVA7vnT4wqz+XLk5Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784734947; c=relaxed/simple;
	bh=gZAVNAenNNe8ShNpW+y1uL8RlMk/a2pYRFQS9VthVm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AI+73fJZI7rLCrjR6EUqYDp0yCI6s5mXeLi1u8vGq6R2D9Sfai6ZQmgNG0NzEHPkm4SnACY6BRWytEXDyw6DC1GYVobqlODLJ1y4GFzp8vCsMxt9hKtvQCf//6CTJRY0oM0HA0fGS+wTF2RmCRVW8Z631QTuT2f4VdnFCqVADDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTOtyts0; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTOtyts0"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7eb6573bd52so6885858a34.3
        for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2026 08:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784734942; x=1785339742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a0mdfiM3qjdIeg57ItkPiqiLUsLGffK5s/s59dcT3jw=;
        b=TTOtyts0IbyFwiG+WFMdztr+YD5ZPz6gTHZ8YLO7eNG+2zXXQ1Pnvtlf/c12RdPieA
         rLiG0PQ/i2Hn5vWdmVlM/5Sua4HObinDxn/Gf5Iwl6i+lpm/83pQu7X4tg2A/DL3Ndoe
         udbidrBuDPnUjdCbrVSG6/6UJhfFNVelczDvJod22t2QleTkPNE2URu4IXSm7uo7zTM6
         ycu5qCQp51KYV31hCisTMNB1PFM8slR3VXryMLP+dBgP1aeLBtEC0KNvBb2hRMtWGx3K
         gjjQ71BF5yKXlAoBL+00m+aBnN6WmN7P+XTbG7rlByyD31yPm6hGFycQfTWHAvWhJH/p
         thzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784734942; x=1785339742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a0mdfiM3qjdIeg57ItkPiqiLUsLGffK5s/s59dcT3jw=;
        b=E+0CczR8Q281W11yLl+jhHG75Sx0UgpO9/a3lo0C9lLZPocn0bTrFD5AE+IpOBZFjM
         +X6SHjivxL1Elp8jd8CN0IBwMYBHGum8qijQHdjoMzHWWmuQPnZ39GN0OVMtUJ46uBVK
         biy4uZ4gOZdjNaQvoSki7dF2mjbXxnmeq2Cl3JsOOv6s35XPdQp+GHLeC9H/9d3BGvkv
         zLrhCtsCj/Qe2yqOmHBLUjSyP+AAg6qYg96SpDQA4f2fXu7k5epV0Jx5MS5WKS2hiEl4
         V8M6UhVXKxM3cycuAoW/AOPi8ygZGUG34X2bth3zOcMo/ryctgYjFxFLlAm+YD/PP3R7
         H2LQ==
X-Gm-Message-State: AOJu0YyXv1kwBY1EZV9GU6p7cmyfNDHSgLJ9HizPIp3Dux+S7As2gTDW
	t/Ksu56DQZxqz7+CRCdlU8WzNZs0g2bo4cU9Swa/IPgn5ms9NJTdGjhTz6sv2A==
X-Gm-Gg: AR+sD12+uktU8BYn4FB2YxZgzRaCxwtIR1cx6Ty1OCB00Jkk3UISpr+0ibblRCiLNyC
	JthckmFUsJL+C/yOllqvOSxIpWZ8KhXpUxKNK6SZI3fbSVt7lbDL1uP9yqeBKg/u9Z46EXNL/KE
	k5xATIvkvHTqI1xcnbdlEouBuLlsHwwwpzT2L8Z4qHRlHs5msrtgvtzeVqH4imOEdMiBkK+Zggq
	75Q1SvQdZAtRJbFn3vn6/ALUK5HMMOweG5l2RkXMyAcjE1BvKUhBpi1e4kuYt7Eoz7F+9Rxf84e
	70TqMmeg1KiKu4ZHENy9/eYFB3iUTvYSpBc9MAVsffS797N8H8URlAETrcT/tevrgXv6/XgwCEs
	NvCKKrtgNiOmazqdHjczM0sgV7KI3JqUT2eXc0zekKJETEd2s/8cpWTkLq2lxeYl/B7vn/w2vjX
	pQ
X-Received: by 2002:a05:6820:c91:b0:69e:97da:285a with SMTP id 006d021491bc7-6a5366ba46dmr11304145eaf.29.1784734942387;
        Wed, 22 Jul 2026 08:42:22 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6aac3a494d4sm1300804eaf.3.2026.07.22.08.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 08:42:21 -0700 (PDT)
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
Subject: [PATCH V19 9/9] arm64: dts: rockchip: Add icm42607p IMU for RG-DS
Date: Wed, 22 Jul 2026 10:39:40 -0500
Message-ID: <20260722153942.144387-10-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722153942.144387-1-macroalpha82@gmail.com>
References: <20260722153942.144387-1-macroalpha82@gmail.com>
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
 arch/arm64/boot/dts/rockchip/rk3568-anbernic-rg-ds.dts | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-anbernic-rg-ds.dts b/arch/arm64/boot/dts/rockchip/rk3568-anbernic-rg-ds.dts
index 8d906ab02c5f..b770bfd5268d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-anbernic-rg-ds.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-anbernic-rg-ds.dts
@@ -871,7 +871,13 @@ aw87391_pa_r: audio-codec@5b {
 		sound-name-prefix = "Right Amp";
 	};
 
-	/* invensense,icm42607p at 0x68 */
+	icm42607p: imu@68 {
+		compatible = "invensense,icm42607p";
+		reg = <0x68>;
+		mount-matrix = "-1", "0", "0",
+			       "0", "1", "0",
+			       "0", "0", "-1";
+	};
 };
 
 &i2c3 {
-- 
2.43.0

