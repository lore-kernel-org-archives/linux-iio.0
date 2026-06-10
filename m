Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE4A3264EF
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 17:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781114255; cv=none; b=fkePj3UbTVVhyogAVTLmT/tp6OVL3+S/Hc7wQ8/utln5Tw1TjiWzKAIsHFC/Y8uH5NBGfdaavZ2BALvYXaRK+TBs8PEfhSXGImFCATCN0EebipB6bwgw0mKajkSt80GHISilBw4wqAScplXvfxVGhrvBHRDq0Wz+u4tY3VbG4Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781114255; c=relaxed/simple;
	bh=gZAVNAenNNe8ShNpW+y1uL8RlMk/a2pYRFQS9VthVm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=po73N8jrvQNpd2QC91tm+y5jY29MxJkTEScnN9PJA6Fw4moiP/fgbaHGJKiH/guMBnxpCBX0r86cScXf/GHa3DXPFAFOBzRPkTQWXf+91jLg0hiDG4h1SYDB1rIrZIp3vbVAs2pVRZj1OnP5iqFTFsfqdRf+xxFTTSiZupZQOhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ElLv9txd; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElLv9txd"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-43d1470491aso2433861fac.2
        for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 10:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781114253; x=1781719053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0mdfiM3qjdIeg57ItkPiqiLUsLGffK5s/s59dcT3jw=;
        b=ElLv9txdq33qNxHsOJtaDVtTKbDCPNuW30dhPlXK+lb29s8HrS0BQTh6Q7b6fCajFl
         i794/CkfLOXGwgZ3s7RR19hQVqhVAUwyouOGyHqErxdasZnOw/IjsXp9HOxwdeNNpzmY
         mm0pmcWLDKEcSY3OCKNMwPwDiT+euWA7dnpfsXSyt3wOR1TW4IMrsRfcB4+gE5edWnzg
         4zZdwZY+LDb2lourKKbOU/30r80Sb4R4q9pJyRZgyDoF4NSLVEAIewIWRqaggblRbBJk
         jKQb8fvtkWoBZxGGFKNAvqCC+GvQwPeMsmnCNrfuVK37647ZQ/bQqC8OKEs1XE5Goza6
         gtGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781114253; x=1781719053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a0mdfiM3qjdIeg57ItkPiqiLUsLGffK5s/s59dcT3jw=;
        b=JnniZD01FlcQivlc1XZxItN0T7ovFmk3qzUX4Gyw3jK9KiycGoS1rqcgMeq91MuqF+
         971d0ljgZcTvWpYhURx72mcgfr+tokMz+Oqc2MUNQGihojaQowe7fxZzmtQBQOXFuGjW
         Zjdhpk2C92ye4wwNnV6f4nxiJEk+S95+UWTbAoGL1wU9+4/GNwDuGlPUvVzUKR28YBFd
         dBKsCX8FiXfCQjxdv5AdaAmULssSixSIEJQhgVGxMcSmgRxaTw6WwTPZ1qRtfEvwnEtq
         GdXE/RXKukyFXQ2smbUM/eDlsfD9Qfyu/zbgoOk/UakLbDHETlZd49E1Mh+K33I16Ixj
         Zxtg==
X-Gm-Message-State: AOJu0YwtTD8URtrMgxXokKQ7nGvfixPiFFHojk9+IjtKMHVMKvW/OpDx
	0sztco5aJbFpSANoo1CeM0D9NRDndg7ZKBo47fOuxmPXyrjCYw3lYeUWYh69jQ==
X-Gm-Gg: Acq92OFvPmQ/jVAo5bh20VUWs51dE9mJRlAgh7dowvgVXrA4rgjD2R5oibr9GicF2Ev
	PAvpB9dmGupumNM0w0zOxE1AH5QuTA+Z/cvG7MbX8JsZaZvijCMWgfnsD459mMP3RGUQSK3iB9U
	6lq37UCG4VMIGJSolm0oKwuojEUl+A7606Kl+PihhlR7yosbuEYF8JrvJHP3Y0qC/CKSM/zoLhy
	Z62RL4eI5tlaEpf5Cvk1q766EZrRVWvU+/rnLdGL8vwS4uRdJ4ohY4YSDsXX+JrpM6QDW+O1WPo
	+327ZMoaO3TXT/ATRDlI9Bsnbr0GZylwlbvIKjk366P0LwuAK1LQbGrq4xWKpjyk7YQpu/Z75xR
	dfam43XhTY7eZLNDBZRhkfPpjc3VyIsA+uaY0i0hpo0ON3vEWq+OIh6ILmN/Yx8jpTdV7SZ0v0g
	kijd+z2QjN/kYYIvOdPLecEDMcpqy7x+RxadY3hf86S8TWXzSWODFmPg==
X-Received: by 2002:a05:6870:c26e:b0:440:67b1:b5b1 with SMTP id 586e51a60fabf-4413d6ba671mr14468737fac.21.1781114252742;
        Wed, 10 Jun 2026 10:57:32 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0:b86b:51ed:28ca:695f])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-440d7d4f449sm21180794fac.8.2026.06.10.10.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 10:57:32 -0700 (PDT)
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
Subject: [PATCH V11 9/9] arm64: dts: rockchip: Add icm42607p IMU for RG-DS
Date: Wed, 10 Jun 2026 12:54:53 -0500
Message-ID: <20260610175455.19006-10-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610175455.19006-1-macroalpha82@gmail.com>
References: <20260610175455.19006-1-macroalpha82@gmail.com>
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

