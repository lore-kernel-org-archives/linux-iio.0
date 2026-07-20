Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E882C3BBFD6
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 20:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784579167; cv=none; b=Y8UbH7zjQzMeqQJH7YMWqNSRqI7jHPHxMYNIDmFb+hCUzWtyWBxHxNhMfQaW/LwRFb3obW8HTIHBOfkXHD4W2uPyEU+aT2vlac0EnkS6U9x3EE7Z8VYN4B7oAek6nArUxwDyKLCjwCFxudKLiM6m9sm7Qpnjs61FfohRtERPJ2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784579167; c=relaxed/simple;
	bh=44wlK79p2iFBlaDNEJYYoVrsZ4V64y2DhfrkrngDWyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gnz9arl9c2TqJAewr9ltLaRFLvUv+dZWYbM8k5eNf552c56Wr6xL8ZT7dA26s/c4m0dN6CfHJ3Hl4so6gdD3MjK/pLdlB56G0zd0eGT2ObPMfdw9SRG4AzPxyZ06m+KqTHWwuhJwVjiMwlEn7Fx9m+VcD8+QjSWuD2bNqF4gkys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQTteM5e; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQTteM5e"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-491bc1d4e6bso7061951b6e.0
        for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 13:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784579164; x=1785183964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KaUmQ9JpbnpkUCaTH5UXy4GKoNzMoHaVL3LWpQbAxts=;
        b=NQTteM5eSBB9+BHj42/k1Sn021geTGnJB7ZVQgq/RHjTzJUWfK/kTZchuHAaL7gXkx
         vGDfJZomFDx2EA0VQ5kUCKqreguKv7tEFO1bBfoLdfg2jb9b9Q1fg2jqQQWcapl/rAq0
         crOd0YrYVtvOh7f+CiQwPIKDTw8ynllaU3K61NbSgBNhUl5czzCeSmkzxjpo7IG84eDT
         2OtDwkrdzx4W7UhwSfeRO4+2eKEWxlumaRdQhKKp/pDrNWtiz4Fh2qpfgZhttZiEaVvm
         C9G6a743dIGyKFHHuRPrVGZoq+kpm+7wVVqqspePnhsvdMVqfGA6eRSjVxRcmSHmG49u
         TpZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784579164; x=1785183964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KaUmQ9JpbnpkUCaTH5UXy4GKoNzMoHaVL3LWpQbAxts=;
        b=LiBuHyeY40+AImnGZwNMTJDDrDl88OK9L+hTQ7ej15kzFa8bhMDVkLl0QhI80kG3+j
         oE6VVOUn1TmT1n6fGzUqhJgwNFQJLED9j9Ovf/jYCl+C4EX/6GJ6Zqb2yLWuHIRXHvKN
         y1gsI3AC8F7KTogllNFou8Th6MyZ/eqaOFadfyf0+ncd5s4kkugeH2i1Db2bRsg2f2mI
         GsHEgG2Soqm2z6k7d/uGPM6XVAFBk1JxBAtMXK79nJsrLvZYuXm8WPgcWwmaCpfCOm3j
         18QNnlOf6MazUlAnXUvRP23Ok0P3+KqwxkYADWhhL0ESaMiNlwFlkhnJ/TZraodZOrZr
         91NA==
X-Gm-Message-State: AOJu0YwK1RdUkY4DMv47bwKZOaPtqLMWMmpiS8Y3UBMudLyBxuVLrMq5
	L48ohllPnMRADNCjER3RK/f7qB2JZeeB7CCCtlXf2jyf8O3WbyeOF5u/YzHkKA==
X-Gm-Gg: AfdE7cmosauvTd6G0IAYK3bVzRcWC6T+6RrtjNC1E/0w7ycn7/9hrZeY3b8qw5OYFFL
	Wv/5c1YLeI66h72LfsIP0A2WFp4pEDbIayNiy+MC4Z+6XRG5BKbclcd1ICCJ5FmsgYlUfOkE/xt
	L+cIWibhtSMOInC24mm1B0wMUUxLTEAIIo7Nix9vLsRsWzze1e84dWzj783fmc2EfMyhbqaMJn/
	m1CZ1m43eXhmXZypd2h6dL0GPMC0ikYCwUe5X+WfXQjJmV2m/p2ebirs0TtaqamzdAXhrUfiVhn
	R+4FHZRpEAc1W6mHeXYtbd2Lj/VVMHoAM/dHIzqBFuqIxEQzsSIoN4epbXxIjpewp3uF8kuxGPo
	E4V+024ORQx7sSW+2XnAwKT2DVukHgfFpTLCWST59D9gLepYpBbXiSl+SvXaa75s4bHx6HetRMc
	3tsLkTAMyHPkw4MfS6z2izzg==
X-Received: by 2002:a05:6808:4fc8:b0:49b:40b1:2d7f with SMTP id 5614622812f47-4a4d0392e6bmr9614571b6e.34.1784579164367;
        Mon, 20 Jul 2026 13:26:04 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0:9988:5abf:3c51:d168])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a4d3e5a0cdsm8029550b6e.18.2026.07.20.13.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 13:26:03 -0700 (PDT)
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
Subject: [PATCH V18 1/9] dt-bindings: iio: imu: icm42600: Add mount-matrix
Date: Mon, 20 Jul 2026 15:23:33 -0500
Message-ID: <20260720202343.70138-2-macroalpha82@gmail.com>
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

