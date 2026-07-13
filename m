Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3A038237F
	for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 22:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783980077; cv=none; b=GYakmgZo8DsVZzmc10pDURBVAda/aaOxw0prEaH3XcpBRwKAfr5Ocg7stuBY3ktFvQTjUUdDxCSwBqfNW40MNo9HuZNkR7ef0y597Q+JRoZ100YWQU/rVRrl/F8GeP1coOIotn5/NikvM1W60fz7CnlYbvyzdY2KAOSF0ulMzBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783980077; c=relaxed/simple;
	bh=gZAVNAenNNe8ShNpW+y1uL8RlMk/a2pYRFQS9VthVm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aWKw60iXg/On/P0rDRt6qeJYO1UkJpqWzoJZJb2/7LwCRyGm6I5MT3Bm9V7+MQYATBubMFOZFDIF08xYuA4frK/GD4DsRTSAt6ej+gcMEayMAPE2eVG28cgztuo22nCYF0OesQGfeP1ivjqD1X8m2c9A0A+pJNhjO+t6F6Zpi/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YvU6kJGY; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvU6kJGY"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-44cd237446cso215851fac.1
        for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 15:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783980075; x=1784584875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a0mdfiM3qjdIeg57ItkPiqiLUsLGffK5s/s59dcT3jw=;
        b=YvU6kJGY0u+SquAgYoo1dyWh/jXFGCy175kOAxHA+2a6Ctg4lqFPH0XUMSyGnkNi0h
         jjrVBStyhfVC5anUaIcfJRi53o0ZlkoZscFuchkI01mQHgci2O5xxSMiYdYU/FSTLFs2
         0qLSo4smY+QFwzSGIBBWY+2SLzKWjFr5gQWr2wR2br5pXd9oaoP9jq0acLLKvpoK4c+V
         Cy5pdx4Mb2gGgZioPr+nSbh9M0Uwy3IjXQXKCsUh/R474tm69g1BkBbrbzPzVHZfwnXi
         NBTLsPz+9e+XzXuCF+pHqmU5F6IfaoDDBVJfy9Rxmm5qCPZGv6g+OXNupK3qO5vtkemJ
         SgWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783980075; x=1784584875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a0mdfiM3qjdIeg57ItkPiqiLUsLGffK5s/s59dcT3jw=;
        b=jOl4ORpd/Howm4N4Amdng67sfW2vP8uDLqepNKYhuSkeoU3soUOa024/TcpJRF13ex
         yJlz0TjKIA790ec9sjV4lBlOpTbpiC2oRYeWsdKD9Xx9RfD9UnC6bhbR88jzV2IxreLx
         ABq2/FGklKbz34bvAewvrk1JDRQl6sag4rfukuZht+au/ZSiuOW9tubr7xcXNRakwAHQ
         GBooPhCNC05arUKHbhLIyHCFphg1RUCRCi6JCgiLHH2q4zyqYHe/PmgvjaGuPqlyhCKn
         +BtaMNASgGPCn7UCYqifRXXrUDp0D0stsC7+kEMvTwKTaSERFQtXR4D8yss2M11L2AFE
         /QRA==
X-Gm-Message-State: AOJu0Yzlc+gekCYFVxY7sHDDEbyi0KzfC0PVdywzXQouBLDhlSb/jm1j
	eQ+NFYu/TuIoYmK06XBorKoFdqfa55BTpndG1QBihIHfYFAc0L5q9xlubs4qkg==
X-Gm-Gg: AfdE7cmopD0f2u8egQt8uReL2tUuijyx3A5HWBxFtYQKtjMaHYlkkDX9r8e3c25sXUb
	hByuwCRC0/fkFoc1jXGh+k0Tzor+59o8mQQOWwOHsflSI35IEgyAy3vCTNj/0Tbu/rqY3e7pH/C
	+8UPOyKZk7pPFH3XXgGDFmMTxFA36BKi3tdrXRGl97s7VWgOyEoY6NnXLYu7+93JQHLis7zU3do
	c8M3kvZGm0OON5Kq7vtM0Em08wdsHPbIcIQDtrq7jG+1Qb1B9ny8b4NA4K3eE2NuizbBZC2y2Y2
	7qa5m2pF3QGe+sC2gVbevVk1Y0W/iCZuHp/Te5jA2kQylq3dHADGU2RmgVLgVbCYcjTG2r3V838
	KlJoVTff1Z/fN96VSGxNTcUGcHKFOmSw4oq2LViPS8BUhQIGJ53aE5cCaUxiObwzv+Nf2W+DmUB
	1ri7bq8MbfiBISsEQY8ioz+w==
X-Received: by 2002:a05:6808:d52:b0:495:eb85:fc31 with SMTP id 5614622812f47-4a42ababf2dmr7011314b6e.1.1783980075443;
        Mon, 13 Jul 2026 15:01:15 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a1acc82f3csm12939785b6e.3.2026.07.13.15.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 15:01:14 -0700 (PDT)
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
Subject: [PATCH v16 10/10] arm64: dts: rockchip: Add icm42607p IMU for RG-DS
Date: Mon, 13 Jul 2026 16:58:40 -0500
Message-ID: <20260713215842.69097-11-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713215842.69097-1-macroalpha82@gmail.com>
References: <20260713215842.69097-1-macroalpha82@gmail.com>
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

