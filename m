Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FAE3A874C
	for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2026 15:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784734933; cv=none; b=iBpWcJ2G7eAHECl69r+3TJbzGUSJxK8he8nJdfLQiIW5WVx5AcfAJkhh3bZDvd9hTdZQaQQgf5ISP9THF+FbvAmWnIyJMMkneW4Pr4E3s8vkYWMuiIoGbkV/AcwqpqjUy+y8ZUuZyoHI0HGoB4EOtRXlUFB0gpOu7arlPCxKMEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784734933; c=relaxed/simple;
	bh=44wlK79p2iFBlaDNEJYYoVrsZ4V64y2DhfrkrngDWyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PXGr5N0JfoqAW8XuUzDWvt+AVA2kI49PxpbyIHPne/lQDpQK+SHicnU5wXQp2mj3FLQ40JK3t/UvFhqnAQBZmDJRRRNv6O09enIT5X9VYT4VkbDMfSbbbCkA/I/4KguxGiidx8TNhldSEpuRLZa9ZoumUzng4uElpT/5gvjunME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ba3GQ1tj; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ba3GQ1tj"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7e9ecb1e13cso9686971a34.3
        for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2026 08:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784734930; x=1785339730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KaUmQ9JpbnpkUCaTH5UXy4GKoNzMoHaVL3LWpQbAxts=;
        b=Ba3GQ1tjDyQNycDl4IgPEGI6ktBpv3EfJZOb+g+WHGrRCESei07uRI1opo0HKBEFZ+
         BiQ354im6H3QfxobuijXIeEcFNX1icf1MF7iWlRI7+nczvIZDnWJ+Y0GSDVAo6P7UViM
         foFgt/7cqfpQ7cwTHG4a0fnEM3w4G/kfvYYwmkbhRXp5QIaECvjvwdUvVP/xPS5iFjEA
         3F/kdfsoA2zC3vNov4OrAvj/BsWegkXXfkLi5PWg6SWMmHipoXKMWTZtDug8eJfW3uyn
         ry8k0jP1b6VsMKWDY+J2Zn2r0hU90t/RcYYe9gnHGgmVuCgKhlIDytVvOiuoLrFDGOmr
         j9Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784734930; x=1785339730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KaUmQ9JpbnpkUCaTH5UXy4GKoNzMoHaVL3LWpQbAxts=;
        b=knlJGzVB3/rERGNfZM2a9nz6uSsuxHCGuGfxXrnkYi9XMEL3xGgGMC+AyXEQh8ypPY
         GOmo4vpZskdUUKXehQRuO9xmZ8ZyDgsOD/BJSASVbohywf2uiCnbn8Cc527dxF/a9U3+
         4p4vJeZ0epn0ID5yTvrCZRPDEipN0WRBvdFMGW4+tymA8TJpIp9xSss7PRbwRab9n46z
         /4XYCujKb9Oy6vS60pyiXBdNc78PN3zSUAlhWv9WjgMp1LVbFzZwG5Vrne2btgQh9Amc
         O3KepnLn/nmNFFxzD+Rq2o0JlTFffEYSKA52X6g5p/p8yGlOPyP6ac9sk0mEP2jpEObA
         IMng==
X-Gm-Message-State: AOJu0Yx1WEKM1G9V/WEjGRSCZzKZEPFr3dRZCwgj9vxiarfidtHyBKZN
	rr4DzqaPYlb0ci8CL/8UgJvh7Mr/as2wjJio/my5hhAHeKHD9ojNDpahyzwW9Q==
X-Gm-Gg: AR+sD138rDd0CSNiW4Ck8pqAZC5l0i1vArROQXvTSFtAIeIBWK6IiHpzVzyL+zFHTVH
	BdiqqduQE80JCHbWKWAEGJvZ56TK2P76PCJnvduxJ068sIx6rB39JQzbmKsWn42wWIrU62ici+I
	qqDIIKhiCw7xYMEYc+fBgO59eiKDMocto40W7m1U3BmLuZDMiw6OQ2tYZwDHEKR/B1tWvM5jWVF
	AcJkOm00qzuojFSg8fh8Um1Z/GTFPHM96mx5gANLPNcD3bWUfaXF5khJ/k8h/Hg3CfNCTK+9LS9
	UioP0itERgd3Zsjsf1PLRrjzuznO4kkNiNWK527w7ppETVSN73it5pLKcpxiTDxznuxg6Dwtig/
	jShNcIwBe6fP1BZtizdAOvbi+RPK6YH8wC7GqG4oAQ6NRaHdBaupS/0HTLYNIJAEHdopDvjFZ0F
	bwfpqp9Xs7O7s=
X-Received: by 2002:a05:6820:4b87:b0:6a3:14f3:3cd8 with SMTP id 006d021491bc7-6a53687c6e5mr11326683eaf.52.1784734929965;
        Wed, 22 Jul 2026 08:42:09 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6aac3a494d4sm1300804eaf.3.2026.07.22.08.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 08:42:08 -0700 (PDT)
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
Subject: [PATCH V19 1/9] dt-bindings: iio: imu: icm42600: Add mount-matrix
Date: Wed, 22 Jul 2026 10:39:32 -0500
Message-ID: <20260722153942.144387-2-macroalpha82@gmail.com>
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

