Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704053C0A08
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 20:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784579183; cv=none; b=Xfdq78OZpQ2cYknohaR2X5kFjuztyKaenDOQqsAlyfkaqMkzEJNKwDYmzyEXaDDgCxxfGJcv2rWCCnUSyRAbj+88AVB3aSgVJJ9ohIyY8lXIJH0QeczbiNDuAdaYQwRhVKUXWx4+m2/otw9ihHcXbOScM8tXOzhfho7IBWeg69k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784579183; c=relaxed/simple;
	bh=gZAVNAenNNe8ShNpW+y1uL8RlMk/a2pYRFQS9VthVm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H8189Q7TBmjcfmdkJ67vYgfyNW0zwNKbBk+zNfiFhWCOhvs4Lt5BrplHP7tegJ9x4FjVQGnCYyO4+0leyeZ77jDNetEilwjwZHWYDTzQq4AqjwLo6bxZtVMxuEOJycIMg/AW3QKyHFs4CeFhnoRL2WOApQAC++Q18sQdJ8tljQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCsuKnVq; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCsuKnVq"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-495c63c41ceso5114728b6e.2
        for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 13:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784579178; x=1785183978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a0mdfiM3qjdIeg57ItkPiqiLUsLGffK5s/s59dcT3jw=;
        b=jCsuKnVqOJmeFZ+aV2Byh3oeXuLoT84Q9OwX/2/QNlyKfDVRCJUqLS7ucvdw2Gemd8
         UZ/sCqvBEMGxwuAo92auNqMql1zTM60XMSFINPHOpq7pQRSaZNF6f/DhmGWli4zTTC2O
         mSTYe+PNVqi/b+c4ubGP7u9lq2rcEXWvw27r1y0T/cKY0SOzk6P9nkTj8KRnj+vzgDKb
         Luc+it5lbu7SZXciGu2b04ICLwN76lVNWHYCVoOb5tzCIWq6yZ6hyr5cqK3jW+PG7Ov0
         RFB1cxtFKsVwp6eEBiiIJ7/WfJOkwio9EkKGz/WWcYAqssPrQkOdGhUdEKTW5ziqHmUg
         xlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784579178; x=1785183978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a0mdfiM3qjdIeg57ItkPiqiLUsLGffK5s/s59dcT3jw=;
        b=niDmYQwKLyOzMR+Le0TSvVe7fZ7I9GU0TQnUoBICF34G7W9/8mWpHSIMkpyhLK1dPH
         vUE8wI9R5S79L2oBmoOncQF6COoS62Vda7J52hJsU6Sqp5q4zOrl49PWH4uG+CZ9wq3k
         EBG6Leix2DUiG6pvHcwdR9cc1wHHHt+BUHqwzhEAnPPueNI6F86hCq3eOk7dm/pfagfI
         znFaJ0kW/G86yMXYWBlYj1WMkjGVgBZRqQpd3MWRXf+X7doM2uDq5h8CVw5jXDFjXTI6
         mb1bJm1JWXl1fBMFc+P1GKdU+49p1z/EoiWSPIsmroXcr1DhDtYpDWqEfjXoV2I25uYJ
         nqxw==
X-Gm-Message-State: AOJu0YyFfVRMQEBlRjSIDsyKLCboUOK12xzlVVLxD77z+nL50iyWPEYj
	cma+E2fRJPebTFW4eNUher3QO8tWhyV74L+jvOZfJd+unQkZNU7WZOXV9bXplg==
X-Gm-Gg: AfdE7cn/lxiv6OMDbYYTAiRuilcUIvM8Fyin5g9pvkCX0iVbQVlk2w7WOFklE0bJQQy
	Rin8k4PVoVPb4icBEzgk1rbuhQ0o2fxG/0R04sXRrgioFa7RMVCQdOFa0gCqmBHnhrvIMaFto04
	Q+5iIbzh1880yVPwHhx1h+hlWSwDkLjHViqJi31AX7/fo5iagk3MH3/oB2bumTRtLd1gF+O6/tf
	D2b//XkIyOkIIYN/zLtJzEoUi3+5zW7ekOl9sgn92nMye6IOtfnTLD7Y+zZae8bAOI9joeSdmpp
	pOdxN10CG18NRgtJAOWL85DLKRHcYi8RdVjZ7olqdWurk02CWa/ol9iZoFZTzluD+mBCfDNEyor
	i4g43JIeTImwxAksFmWUXJMiV8csltFagz6mYpRomtAfiZHnTZ9/Zv5GdTzqpMTG5RXu3rsEuW/
	u13uUzj+Iws2mGsU4QFaIHEA==
X-Received: by 2002:a05:6808:f8a:b0:497:e1b7:d7bf with SMTP id 5614622812f47-4a4d039ba7cmr8747067b6e.32.1784579178321;
        Mon, 20 Jul 2026 13:26:18 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0:9988:5abf:3c51:d168])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a4d3e5a0cdsm8029550b6e.18.2026.07.20.13.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 13:26:17 -0700 (PDT)
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
Subject: [PATCH V18 9/9] arm64: dts: rockchip: Add icm42607p IMU for RG-DS
Date: Mon, 20 Jul 2026 15:23:41 -0500
Message-ID: <20260720202343.70138-10-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720202343.70138-1-macroalpha82@gmail.com>
References: <20260720202343.70138-1-macroalpha82@gmail.com>
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

