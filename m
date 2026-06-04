Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAF943D4E8
	for <linux-iio@vger.kernel.org>; Thu,  4 Jun 2026 20:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780604461; cv=none; b=R34L/v3KcH71WRdweIM7KVWUcw2EA/cXOwxhyIgSVI2hGMa02asObDAfYnd6bPcC8VrUbConA6f8aajWq3aBGqvDOjllixCY1H3AMKC95GYi3KPTwGroASYTrshPq7HQcMDsiJ2/BZr9Oa99/RbfMvlDojB8ScIc06X8qrFllU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780604461; c=relaxed/simple;
	bh=L61hJtY12uF/pzRq8lWfif5l+zawxDPfdRCujTKkYJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uh7FxIRz8Klft6YwcmSm4+twCvAx/OV5LPTtsLpHNTidv33wVUEkrhGpoxwwa3pecdZuV2F7QdvclIz4/0pUyVDC5Ajt3aEBCl6a5aRLbRDdDatpPIUDOifc7XdBbEPLEWuDJyXOXlCN4gESoJLwqueagydFHZ0PW92IDvzn5jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qH8DoBCT; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qH8DoBCT"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7e6f586a0d5so494307a34.0
        for <linux-iio@vger.kernel.org>; Thu, 04 Jun 2026 13:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780604459; x=1781209259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BSjRTgvqZkDXu2MLipTCwmEQqCL/hU0TCzAIiZ1kK58=;
        b=qH8DoBCT//lco7FGKFgbg/dc6Q85q6AGpomIiVF8e0gRLBH6VOEuOoN/uJnklU6lAm
         1s27MOM0aR9yA0o+SPwr3mRt07rwP2SUeEvrQr1TkgTt0iUjIND0gSPxCL3C708BhxBc
         TpCHJsbYKNlBJSiLbcjI3xrPvN8mgRmV6xofFLiWH1hRCVRwwDtj7dDlmy0pOoSLz2Fv
         y3VTdaxshF5doolFXdCgUbOpX2phSsVZEz20F60ou27DwuEb+6NB/jXI37CK6tvr3oLJ
         Tea+rXxq37UjBSPiRrm7z0jAn+jf93A4HKqYoL51YOGfT1jy0la/HDtZTZ85ntINkm2S
         OJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780604459; x=1781209259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BSjRTgvqZkDXu2MLipTCwmEQqCL/hU0TCzAIiZ1kK58=;
        b=YjqXckEuiRsUK8qIu5H6pZD32UjXFv6PG+6rRZuQPnWfEnc7i+kOSvmVKp4z/5modJ
         ueP1zfJ9JHRNw64keWNlQQRZt4oBwr481IcltPHw186JD4DjvV8ByVdD+NTSpAUZMvxB
         /nOE8D/88WADrNd40bBkIVOW3ObfMFtp3K6a5lVTrjnepx4EZTNv6HkvWn3yjxY/NlSL
         elWtrpZEC8NJRJu3B6rQ3KCDL0sZu7ExbmEviHC1o7JA5jvG6z57i4d7zgiDr1E8rTI/
         xTQOcFpcVd1oNuzljgG1PkbfJxaH5kDF6Bt2vgDVDkTepam9q8wSEqS9xv/nSSXdPwgK
         wL2g==
X-Gm-Message-State: AOJu0YyoVGnCw0m4X97y/5BE1rzykLf+W+KDLvq6Qzmuy19kjpH6DRV1
	MjX59Pk0HE8z0n1Yvz92YQ6Y0460sAzHeczHVTTU04wM1LBOIerXwDzRP6xLnLqT
X-Gm-Gg: Acq92OH5R0Na/RsMpk7xHffZIs5sjl2FCuivu84aqomQMUsRKRs/ZLsaoIIV1vwO+D4
	OGTJdPpwWyNz9MP4TjQT++SPXU0PpvqwI/DeWg0UuHD4QyieqSRn5ksnKvp2WzmQZU6PjXHkH1X
	yQEEu6jbTde+b8O/+2TfLsYwWrJ7+uFCJEkIOEpacNI730mTkpHMERFm9vPJB7cHJlMEIdv1InE
	6J1D5/+8ymJq9p3cAUHIQgraxal48m+EIS2d7XFlwvGNacbMLTs/obfclSyDv8MTGUP0V7YDbTq
	VliUL4SpfZzX3TE+AZx7B5DhnbVJbDfwpm4atLhP2SNSeuKttvT4PKphfaQshzqmMHooWIdepXK
	31dSFo9OOEjJsyRgNGtNCaTsXG5Fshrboc1Yrv5wLI3kmHom7R6Yot+2R6pUbs9QWWACv/x3HxZ
	td74978+DExPlwtBiRssCcK4XtB6TnzAo=
X-Received: by 2002:a05:6830:2781:b0:7dc:da80:42b8 with SMTP id 46e09a7af769-7e70ca13f4emr137409a34.18.1780604459351;
        Thu, 04 Jun 2026 13:20:59 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6e796c675sm4541800a34.24.2026.06.04.13.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 13:20:58 -0700 (PDT)
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
Subject: [PATCH V10 9/9] arm64: dts: rockchip: Add icm42607p IMU for RG-DS
Date: Thu,  4 Jun 2026 15:18:31 -0500
Message-ID: <20260604201832.60656-10-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604201832.60656-1-macroalpha82@gmail.com>
References: <20260604201832.60656-1-macroalpha82@gmail.com>
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
index 8d906ab02c5fb..b770bfd5268d8 100644
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

