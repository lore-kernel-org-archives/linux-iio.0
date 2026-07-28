Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0667141930F
	for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2026 22:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785279496; cv=none; b=lKSg2LFb/snQfXvXMB0+CryPyz7osjj37/RjvL306pFsLABzcw3WfNpvbrG4btfg0abYTRdSb9h+eY0MqzjSlzD0xN/6KhiOrZbd+lDI9hTOfsINY73BTN9VEAlZmM5y2acdrrgYD/HvGByjBMaWwWG6fKktunR1smIZhsJEcc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785279496; c=relaxed/simple;
	bh=gZAVNAenNNe8ShNpW+y1uL8RlMk/a2pYRFQS9VthVm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ft81adjnGCTKrOE1gj8f93IcSQNzTUrfcLXgHOsWPWlAdMMfUMhSO09dUb9gw4kJ5xW1kyVKN7uJaQpis2YxtbrJGck8H5uxaI5Otk5GHnlslGwxGorUx13hKSdlnTeYWmCfT6WMO3l8uOUPOPxgyFYfRxk60vhnwYkxrwBiUao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NxZ5D+xR; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxZ5D+xR"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-44ae14b4fd6so130386fac.2
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2026 15:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785279494; x=1785884294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a0mdfiM3qjdIeg57ItkPiqiLUsLGffK5s/s59dcT3jw=;
        b=NxZ5D+xR9vFeQeN7GGppFvCkY5CyIJ2DFLe7Aql5KixIayPMpEJQOtwDs4O3OMPThz
         NefCRduJGkGeHNHiC0eEKZ8LTY6ctzJhyhsVHjwfU+fTAiF9XpOObKi5thdl+Xwa5XT2
         PLqVHuIe63KF9Fcb+Uywvu5z/lIz6keSl0dikIsdYsx4QIg21J/l5Ee1rztx4AfQ6r+o
         EYrkwOZVc09ATuqrYPbBjge55ut+BcKg9GB/RuakLyLvvY5ABI+MZ9Fk46cRf7PswrCa
         HjW48L9jaT67TuY8nmCK3fCiMT+d/jALLtOjdZkNZZ5OX6UmFIFU8ev8SHA6pBZnIKUj
         YlFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785279494; x=1785884294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a0mdfiM3qjdIeg57ItkPiqiLUsLGffK5s/s59dcT3jw=;
        b=DXvussCO2s+BWJ/v1zRq7HgJzu9Sn6O1Aqn13ZI90vBu39DNi6mrPHn+4oqVnN+xE2
         3ev6XBilUpUSu8PCjt6I1/HUaY0xsofAXkVHpqL4n1qhCQ9ogsskbAKY/Bo1iInUsuKb
         lS3w/N5yukqHqEKIzzLuJfYxACptJ93NreDcqg6p20Q3xe9UwP9hiZcD3gv2q7Y9O3qN
         OfXGblsiE1ivakuQ6wVrEi81MXk4DvG0pF7hZrOXIQ19g6pJQi4dCo4s4MXcEVV/ezr/
         mAX4K3uLqxRr852ByJhxeVAZlB0urlsxu+c4dPc6oW0v8eqBF8rP4uWirNBAtlc03htt
         iYLQ==
X-Gm-Message-State: AOJu0YxXpo0eLIM82hB78A75cJ3jzZrkqpQtvNGy82cEahhn6baRzmWO
	TiTPmWTICCmL39zFxqvK5OAYr4D12F/HLcSLfwEPaiR9zyBPPsT++tjU4m80kw==
X-Gm-Gg: AR+sD11KR/ShGSkfTI+kMIbpN4HQVd5ADwIfVYRvPkreX+rFbaFHVdZbjy+Mjxi/DfN
	hKEu6QJ1RwuAKf1v1ibuGlYBH4hVk5gNonJPEdlBE2MBCDrR4bpaODxTW7wPE9VIaV47MZY31bI
	Ac3gOYMeEtE5lzJcW/eOb20sIbmmij2EH7Vf+asxwz1wm65Jx2i40B415B/DjJ+c3ATqofV9txk
	Rkaf8in/NLVvkkpGs6AS803fuCHEdaCyqNJiZTMVlkx1j8buOpib/K34wdYOOuISuKAlTS6txsB
	yb7kf6w9vtxdC7q+Iql7TPGXATPj2np6K3L6WxssCQgq3M05tarp1kKf9tAE15LC4F1RFJtYDrE
	ZrHAZgGJGqqWGUCLAZzuQKv+0bco0fNa86v697zikljAUQGMkILNEU7CmMgt+FX7Xh2lOuoev6p
	WhNSUb8H9H12NBjNnxUGe9HrNNKhoK8WibUY4uXpqnkalxLmE5js3tW5HRxpUAtCmlVXniFWTfK
	59S8K1FS6zxa5wLxCU=
X-Received: by 2002:a05:6870:5b95:b0:447:9dcd:ad3 with SMTP id 586e51a60fabf-4586cb510a9mr2652330fac.18.1785279493899;
        Tue, 28 Jul 2026 15:58:13 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0:9162:e42b:cb94:2d55])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4588646ade0sm990277fac.5.2026.07.28.15.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 15:58:13 -0700 (PDT)
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
Subject: [PATCH V21 9/9] arm64: dts: rockchip: Add icm42607p IMU for RG-DS
Date: Tue, 28 Jul 2026 17:55:40 -0500
Message-ID: <20260728225542.174825-10-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728225542.174825-1-macroalpha82@gmail.com>
References: <20260728225542.174825-1-macroalpha82@gmail.com>
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

