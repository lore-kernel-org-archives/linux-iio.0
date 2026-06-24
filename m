Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59332285060
	for <linux-iio@vger.kernel.org>; Wed, 24 Jun 2026 18:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782325970; cv=none; b=c8KCs4/J7XSjuFiha23e7gPYdktCRQmxl1nMAQoMbXwcVDAn84XablktgobIxlWJTaCl2stlh0F/KPOYiFDi8/HxLjXk98OBYSjfxr1efDV/fq3xbh/KDQd8U7XDb05Dsnks31aB1UvT+ie3DKKKe5cc/R/j8wMRbeI96IJuq28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782325970; c=relaxed/simple;
	bh=44wlK79p2iFBlaDNEJYYoVrsZ4V64y2DhfrkrngDWyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kAoLz2e11vWo5l69R/+pid1kA2wvActCTEAd5ctEC1P84seF/4Hw0qGDBTLXF6kPAnEY+MV/r05Fu7nzRTGpaLJ1yiisW0gGuKoLWT5RyjZOHk0VDsCPH46Z9lWL9qNKtw2Xdgf8XhxCl5IgDoZSiufIoOLRK8R6xopctc8fV90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o6kTQC46; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o6kTQC46"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6a0e4f0342aso1039813eaf.3
        for <linux-iio@vger.kernel.org>; Wed, 24 Jun 2026 11:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782325968; x=1782930768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KaUmQ9JpbnpkUCaTH5UXy4GKoNzMoHaVL3LWpQbAxts=;
        b=o6kTQC46oH0D9sztNHJL97SV4mMMSm9+i6pSZh7uhCzV8FYM5jp4DooCiL+yG8M+3x
         mdmUQP041sVy4tFJJpirYLAObk7jcKnawV0D4+rwzrot6D6IvwEk8yItSveBG1QMZIrI
         NS5nbfI20fZQKD1ICZmpP8VIRLbZNg7gwOTdNfa4cEb4Z11dQjURrQgrSSFY27feq6Pg
         4smUIO0lh/BHjEh55PvNdl6SMSpXtVlNPmjcAfxbV/iMC/scIVHIzG0TSJ7qcn0EF6M5
         HH4u17YvqXVrUS05zXiq+jF9v6arURvcbukS54T72WaJCtMfISOg0/MrVACTO7sJ/NZY
         ZY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782325968; x=1782930768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KaUmQ9JpbnpkUCaTH5UXy4GKoNzMoHaVL3LWpQbAxts=;
        b=lIYEWxizQLbMANcShoGrxU1AZ8qV4fU9OsSuJ8TGtN2uh/YDhQxYh51LTclxCfBRhU
         z0dnqFgp3WdLXgeJy2xN0Ef/m0y9GyWS/FkvD1pDipCZJbo4rwxlKaxAW7yjT+WsZBVJ
         KSuL536osXhZ7ghRIAHffYylVFTnFp+4IfLs7joq4VavnJDu0BcqYeCMpecBKPsNP9Ms
         WJEnhkarQdF4NiDUsfZoUDVxTsxL/JGxUueFVKcLYtMczA3uJdeLja954OO0Fuc9dkm/
         DJx9YDQfc7iv6O8tulOe27MdaQFCzB7GplDwgquuo+pEu0cztGeY6B5DLYHzCE70pMlz
         a+hg==
X-Gm-Message-State: AOJu0YywmuZCXUNWLhQF+n6mLP9MphuacrOS2a7dj4HiDVBevX+r/vny
	JmrQbxaY8soEvjQsbkxNE8pyqT4/sA0IsMDVJtC//n19TkXktjNXwsFZdKD6F/cN
X-Gm-Gg: AfdE7clRR4doeXkrbbOPWycR5rr93cVklRMkdsb4JIMi7dNIVLgpXi7WZGbNCMvLIJu
	CdQMs/VIJd4La//+eQLado4ar3rsnmcmtgI/ocsMsim20woXxlhBVhnLglcBwpNeCqga4C6YG3N
	O6KWHZjQCNtrxeHN9NNMxR79ZGDSYvO7GLYk6XHBg5hZeIVlt1YQzMSri+pCqMw0fqZXFbf7TCp
	5aDxdaFMLMcvcrIxV0rE6Egp8fwcyudZOZe+T5/GEwKpi9nnHp4FsE6IsJR1JCR5pSoJkSNSasI
	KcrXO3hA6xhGetFbfRjtOp2SY3hC11bjbrmcA9LQOOWBUfw9ABswAqKxdCiBfs5oDkM2SvC/vaF
	FRgI90WxfxTTJqMdwkBfc78NkWNAE91B2BMl5Qo02OhtKD+Xy+I6WciU8hW9f0hBsfg7AqeQQJu
	v52gKsbJo1rgc=
X-Received: by 2002:a05:6820:98e:b0:69e:35a5:1358 with SMTP id 006d021491bc7-6a122f85448mr3073013eaf.27.1782325968322;
        Wed, 24 Jun 2026 11:32:48 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4472f042517sm9968060fac.13.2026.06.24.11.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 11:32:48 -0700 (PDT)
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
	Chris Morgan <macromorgan@hotmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH V14 1/9] dt-bindings: iio: imu: icm42600: Add mount-matrix
Date: Wed, 24 Jun 2026 13:23:40 -0500
Message-ID: <20260624182350.50467-2-macroalpha82@gmail.com>
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

Add mount-matrix attribute to schema. This attribute has been supported
since the first revision of this driver, but was not documented.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../devicetree/bindings/iio/imu/invensense,icm42600.yaml        | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
index 119e28a833fd..9b2af104f186 100644
--- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
@@ -53,6 +53,8 @@ properties:
   drive-open-drain:
     type: boolean
 
+  mount-matrix: true
+
   vdd-supply:
     description: Regulator that provides power to the sensor
 
-- 
2.43.0

