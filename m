Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9288037BE89
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 18:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784226552; cv=none; b=pwtflpWWpI1EhVkU5Ybm/XV9ieCIfS9Pqgnmg1Zw0lSAXyzIpVJAmZU0gL1z06r5msRiptvNZVIcwONyXAnedzk9Z+VolrhQR8TSe5tdD+I24iY5EqphSlkBz18+F1v3nlLtch9BzpHnsgqPMEXXpIrUfJMjqfj89vqkvfk2VS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784226552; c=relaxed/simple;
	bh=gZAVNAenNNe8ShNpW+y1uL8RlMk/a2pYRFQS9VthVm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rghEpGFkbtsgI3WLDvd9J9DynZbI2k5jZ59nW82ZgEDn2aZD3kD+LwSoybIIsxGwWZ30/safQ/+GFwTZTIEx+1M4GKHnuRavSLjD2zQEB8yvJfcxxQDljc6REGHR1Of1bxonIdhFmtg1S3ViqnXF9TtkM5ZGxo31WoiyKdZqBnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SeBbESi6; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeBbESi6"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7e9ecb1e13cso5287672a34.3
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 11:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784226549; x=1784831349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a0mdfiM3qjdIeg57ItkPiqiLUsLGffK5s/s59dcT3jw=;
        b=SeBbESi621SDyL2bHe2iOsUBNNr50i4WMQ8WV/aLwCvTAAzl4D+nPd3ZTPi6xrvCGf
         xR4XL1Eal5AxCmDaOV2lPK/BmY9lzPGlc6CF5ScmSVEIL19y3mILzRKH76dANMz6QJBq
         +qf7nM0BrZqulgFWLF22kjigoeKmDkFlsyCtZjlg79LG9IjMFiHX6LZyaIWi5SQ58SUi
         G5YBlWlAI33DN5+vHKXOF/3dqwOCrA/4dzXrsvdffw+z028eEbPnZHxp1t14t8HIe/cf
         zoFjLkWVLdVPRGD0lacsvi+YJF6fog0LiOH3+cIQ9DhzcCyMWWCoW/K9wuraYGh+3Nyv
         pH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784226549; x=1784831349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a0mdfiM3qjdIeg57ItkPiqiLUsLGffK5s/s59dcT3jw=;
        b=Fspm66HcYXTUN/Tn7SG8N0zS/oTRmizQ5wCKnP8qiKC5E8FwXw42Zl0+BCfW/8brv7
         6E2ZNbu82HjEAb8JwA28nBB34E1ne0zi9+IJRGhTqhYmnxPOrCbWT6jPPwI4n2dQ4RZp
         r3RpA4r/cDbqmXvmu5dcSZ9iXCT796CPTFQ2I4Dluzk95hTJ/W0YAQNv9ccPgq+EcUIR
         1uQQbgBxC/RudxDYh8DAChgXCgWxhvm7meYsT3bhITlAImO8HpoE+p9knrwwQnfRHduO
         tybq8ZLo8XQAwznj001spUujOIBbYyFmMUYBiHIOUNNPgETzUIdtBq+AVhJGvzel/RvF
         CvUw==
X-Gm-Message-State: AOJu0Yy8vezO2W9hUncwO202tE8XUsDlZ3cPFAupMCWEdvTO8+gl85+1
	xADVW5wsafhR58ao7GnFxQRUGuoWaltLdLmf7Yi8RQcX/6zTmIN2TiRDIlnFzg==
X-Gm-Gg: AfdE7cmXjpx4vwBXeNXF0UT9+7+PQU7lI7sEh+CR4mrs2VVm9TYcL7RXYCGANyJRge8
	l10tE1JaQmZvjLuiNRQv2ANvbvceMufhYrkSK/wOX/rlk45MCeqZEmiR5pduOEAkxD6HJFnmIPl
	696fm4zocmx0q6kuyn/ZDWIod8rYaqgC6QpWwxhaH+X8zSjDOi4nEIHqbBuV9ZeCWyv7XOZbWe8
	2rY6jIFf1X6QF5KGTbzsyVUSDCiHatLRLhc65+WReFreQkpgCmQ7dUtZAlrl0kRl/pyP6SFjqYl
	ay3IzK13rT8T1alsej/NWhpbuaFaCz00nTVu2V6zt3PQGcI7QEdL13Mx9pNd8bZ1QcfJ9yaTHcF
	vEYwDSgqyB6ktlG2DCFwUeAmZ3z1t6xCGiLw4bmh7oydiOeKDweCQ014PxUZ7PU+IfR7vkZ1ZPE
	nG
X-Received: by 2002:a05:6830:6d4e:b0:7dc:df37:844b with SMTP id 46e09a7af769-7ec59b0dbf1mr5341717a34.4.1784226549257;
        Thu, 16 Jul 2026 11:29:09 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcb3f6826sm19939993a34.27.2026.07.16.11.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 11:29:08 -0700 (PDT)
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
Subject: [PATCH V17 9/9] arm64: dts: rockchip: Add icm42607p IMU for RG-DS
Date: Thu, 16 Jul 2026 13:26:36 -0500
Message-ID: <20260716182637.24310-10-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260716182637.24310-1-macroalpha82@gmail.com>
References: <20260716182637.24310-1-macroalpha82@gmail.com>
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

