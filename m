Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6903093DF
	for <linux-iio@vger.kernel.org>; Wed, 24 Jun 2026 18:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782325976; cv=none; b=Q3MsOAnbOG6ssTWLcsa6mmCIOUZb7hDOCSI9V67Ea4oKZwUBWEA4l+S2rrE8GL3fWth0xyCD2Fl1hw7umQK7Ff+TdXMPb33Vyow4B2AcLDLJSgndsk4is9hdfHrBAxyH6bfY3S9OEV08PiUMd7gkNSiil6EwulrlCi5WshBphZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782325976; c=relaxed/simple;
	bh=gZAVNAenNNe8ShNpW+y1uL8RlMk/a2pYRFQS9VthVm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ljurxFVc6jwZ0ZpwqLG8gZnYFb7F72lMd2DyyigGPY3/eCN/CIJ14f9BspTImMGfQyPtDQZ9b5vGvzMxC+2ubmSLoOCVpLKq7B2TAs0A/9sxwotJlxK2G5tfTmDRvNQRZYfuYGTQzVytTX0tsGiq+1fqLDDMDlaIso+FxPy4kCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHMCX+Qj; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHMCX+Qj"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6a1009f6adeso1027549eaf.3
        for <linux-iio@vger.kernel.org>; Wed, 24 Jun 2026 11:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782325974; x=1782930774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0mdfiM3qjdIeg57ItkPiqiLUsLGffK5s/s59dcT3jw=;
        b=HHMCX+QjhW9Wcy9mve1Xo867jOACT/rhhwUVz/KvVkd/IvMfXridR+st1jag92867m
         ElMYmmJERztW9uKkfVvm6zC6SvzaKnacgbw+mzEepJlW6S7kwA20Kw+3dw9JuqkzySQ9
         Q7kkzzb8yihyHPoebf9M4PwtptS2yWGhkJOR5Z56Zl1XcFJ06gQ2yAl0C2uGG2yvQ8bO
         E98ewwkVIjTSW/KTC8eZJ8uAteUPw3lkJqUP6kvAX8r40RAqnX+dyBilJqpc25FasHES
         7cnIQJ9I1LdlCxiFm4Ysbl6D/H1cAD5guyyMrPg5DbNIXFZka3b9sJD3hAlVAIJobE/L
         Zwxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782325974; x=1782930774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a0mdfiM3qjdIeg57ItkPiqiLUsLGffK5s/s59dcT3jw=;
        b=cpmQaCN2SoH0fiDl4c9xiRceCwqLm80kHj/b/q0KZ+Bh1FFkGJbSRCD2KGDCI5OeNl
         suXmcbIWrwg/uNTLSqIhR9YdDmjhyV0NW4qRqOLuqa3JlOSYDEiM0bGWl6ClT97zDCYF
         p4fG9K3GFS1t1hHBGBzobZSm8Gov8eyzJ1WsmlXQMGTWxhTYjzHplaTsi8E4S8bQ3txD
         7askzhEY6bBX2F5+t87DppeMgVqXDJytEi9rsoEAEfg9Z6DUEQhFfNT9nUGnxYv97B0v
         iBBeAg7OswOwyr6l3x4OoUAVTVC0sMSwii3H1G0sQKTF+9tA3SQ0DUlyPP8KtRSimiG0
         wXrg==
X-Gm-Message-State: AOJu0YyD+7rm0V8x1P3Izn+tmDAId4r4EwjcGbpORaAnW5rR/hs8oFp0
	I+HnnF5YxCe8dqu6eP7vAnY6Wac1Cor+W0IEfod4LpX8btuh8B3bb9+ZCTtTSb0n
X-Gm-Gg: AfdE7clUrfLljMHSJnAKZhftRQago8Ra0hiXP/yD/rjuNULm/QkHlI4hr19CqgclFoY
	+cWguVnISssX40tkdV13S4XQu0vCbWxqUT0ZjEWlIzzj9LapBZBagkEYDbRxVcYIAJyObIoAbjd
	+TuoqsW+CnB9LQF93BC340sTFbmOEqbjUQrwvHUVVkHrORZOhXhpW/PAbQvqSnTekSb4PrvcwIZ
	oHqsPxtsalg26O1hGopYaftceG1fep4ZwCJy4rB8c1wx8d7lopHPrHuyBggmdTdj5RCa7Kob1FS
	Sck2edO3Kqhs7YxVITsFPP24j14F15SMMHvmg5j2/g4RHtk/yYMvy/vxou722LzrMtXe4CwCUja
	v6Q70iGQFojUoLxuBkIIb2CJTq47hxhz+1ZX2jPJbbQkPXcGHdSclmimYc+pSc8Rg6VwJ7psWTo
	Btw7Nqe/nRtjw=
X-Received: by 2002:a05:6820:2d0c:b0:6a1:22cd:9001 with SMTP id 006d021491bc7-6a12317cc8dmr3100975eaf.24.1782325974036;
        Wed, 24 Jun 2026 11:32:54 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4472f042517sm9968060fac.13.2026.06.24.11.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 11:32:53 -0700 (PDT)
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
Subject: [PATCH V14 9/9] arm64: dts: rockchip: Add icm42607p IMU for RG-DS
Date: Wed, 24 Jun 2026 13:23:48 -0500
Message-ID: <20260624182350.50467-10-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260624182350.50467-1-macroalpha82@gmail.com>
References: <20260624182350.50467-1-macroalpha82@gmail.com>
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

