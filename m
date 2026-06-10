Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8049334E760
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 17:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781114247; cv=none; b=DOa/7FvgNQEFYDYQZUvRNOd5h8wL/IlPwAhkrJcO+5xSL9krzruVSTbTo+agqrqYPqAQJHqwbyJSEK/wVSNSaCunD5oIusq+jZazJYkjcRpHwITkbN4XzbF9dAEVuJ7xNwLyl1/ciyYJhwGD4v5ulUE42Db8jgx/njqXSVKT5ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781114247; c=relaxed/simple;
	bh=44wlK79p2iFBlaDNEJYYoVrsZ4V64y2DhfrkrngDWyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kUdqO1LKg22B1LLHgV1/cg/mh31eSFaylY8IJLdZT3QbHB1NjCFEI2ZKTYYRNsTcgDlJhPZ/E+ylSMLzQ2K/aCz4o/xdREEU6Nntmva4/kOHPmXxK3Q6cdnfqiWnmnCbS25N8yDVhzx2XSpW4nyZ/uZGnDzbngkNqSdVX2c9g/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFQ/mtFb; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFQ/mtFb"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-43b7e186a0cso2882039fac.0
        for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 10:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781114245; x=1781719045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KaUmQ9JpbnpkUCaTH5UXy4GKoNzMoHaVL3LWpQbAxts=;
        b=PFQ/mtFbxOCTuAWLzTUf8OFwRQfXrsae36LGpAIVvW52amyN7MCgSjLhulB+PKm7Pr
         qUcLXhg1ChgosTcmzzN4bW6WytFQjSxFt7orQCTBb/DRDYFc8DnIVnXXw86aUD7XiHBO
         QE8UPLqeVhf7mUGIZAOsC+UpeAbYx2jMVJJWOR5rG+nj9RkcT1+D4AFiQoOJPQrWfymR
         NjsUCpDF3Rh5y7v3b2UN05eP0J3PILdrwIuRFCeU+lp2ij5NoMxmkAMUE7BoeSYND4nK
         qfVp6tyFq7lAUOj1F5dRqyOkMrFN1CXRjRALznp2d4uq1jGKNpn0lD1VuJdKup6+5WMM
         iFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781114245; x=1781719045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KaUmQ9JpbnpkUCaTH5UXy4GKoNzMoHaVL3LWpQbAxts=;
        b=MV1JoAT4GpGZb04PUF/Vyd0sdoyeehjlWYnofqLeqiVrx3/rElXMSMEFMuE41OyszH
         MBJ+V4owH6/ro2b4o8KJp2RqMKkzXzJTBXz7ExBRwUUSp9m2CPOrdb8XyBng/c1Xs/sN
         ZkDlhhgr+K+NuXN37H0D6rAqu9JH4fI8IVrWJIv7j6gzpYVGQphVcHqmrFGJwqJplW5U
         /M5aFsWSFdE2TBlN0DPXXIcewUGSVX9A55vz/k7HabTmsLMYt+cI5y6qQu01DI7GxCNA
         W3WO/9PsLz0I4z7MbtTZ7LqDtB1veEms8mlVaTreQt720r+z6rJGPQ9xVelYluU+dXDU
         Oulw==
X-Gm-Message-State: AOJu0YyuJ4Og4L5caOKPnA1/rsA/Bl+KdRDdMTpgPbTsLCDBA/Hehp56
	WS3kmlV23UoQpfCz/gpfxKfVDeGErMAzyHF4m4cM5zPjkS0NS+LF6hk5WTFQMQ==
X-Gm-Gg: Acq92OEtFrRiAvPE4bRPCrM+zXrikoZPEfWmdbwgWWzqE6pH+2dIjlUYb4l5Rt+sU6R
	Un322TFZ4d2rpgVKQkoKG+Ynz1GvnBlai4HZBonZW4xsXQ7xgxnrGTcKa5onTyLpQ1659ePBeGY
	ivNyx6tjsmu8vTz8MwdAgbSDiqxQ7Seak2NMxrXYFTatJNo1jzEVDgNOgXvrqMluAT0ew/E3WVb
	GMKi9VUXdkVwhWKRTmJTxH2belNXyQyxAMcVa7NlzDh/Z6YBCac1zXGZ6kbpCrp1AIah6w8UvoM
	GFpwaEUe+/qdXZwBOaWlOG2+AaQmi9hiUqMa/4GgVB88lgP+tbxAqQVriNBvY9dPnCxoIV9Vecz
	lCaNKoW8X7MXGaxTzQ25qnOfvvGCnbVlEyxUDyQDpP0Dfc8p5ky81ReTYrhUkLH8QCFzmgjWLER
	f4Rn0OstpNV/9SJ03TPvRiTyvdXgP4fEWGHaj0N9msuOS8xPKF6NKmvoTjsMKpYh+o
X-Received: by 2002:a05:6870:ac27:b0:441:3803:7c99 with SMTP id 586e51a60fabf-4413d6439a2mr15545593fac.10.1781114245453;
        Wed, 10 Jun 2026 10:57:25 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0:b86b:51ed:28ca:695f])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-440d7d4f449sm21180794fac.8.2026.06.10.10.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 10:57:25 -0700 (PDT)
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
Subject: [PATCH V11 1/9] dt-bindings: iio: imu: icm42600: Add mount-matrix to icm42600
Date: Wed, 10 Jun 2026 12:54:45 -0500
Message-ID: <20260610175455.19006-2-macroalpha82@gmail.com>
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

