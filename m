Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810424749FB
	for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2026 22:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785279488; cv=none; b=foSJJVFW9Dx911/kFdu7btuaFzJz/0On/iLfb/mFdLokePSkD4205cEcH/kh6619Rmr9iLXwKem9xkcCNgGzBZyzSkBCmUAI4wwXdAndRIVzm7AxCGWNSQvgViT7LMJs/NyUNSOM+56UtegGQd3l2N5wDjj9YXk6OhFCuJMMO5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785279488; c=relaxed/simple;
	bh=44wlK79p2iFBlaDNEJYYoVrsZ4V64y2DhfrkrngDWyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZyCVTMlTDaZmTWrqfUI/+f0xRKbHRQB/ADsshOcIRfyzQ+dej/8FLtYN2LBjwFnmeWQMYaF88AEwFGMRH/wHlUTlAcW6AXPMy+7BF7Q+FE0xtwk2gYtLk8KHbt3SRN0PCUm2WE833pm0Ptzl4ZpjUNTufqBgRfoZqYqnmbZPfMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cPfn6F/X; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPfn6F/X"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6aca0f482e5so252608eaf.2
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2026 15:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785279486; x=1785884286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KaUmQ9JpbnpkUCaTH5UXy4GKoNzMoHaVL3LWpQbAxts=;
        b=cPfn6F/XeGNh8VaSgyg4yYEgM9fBNHyGt4SsToqX7On/v//46Xe1OP8aeTRF3YiPH/
         udPRmvvGU30lbabXr7ncYXSeeEZ4a5/Nvu4bxIcEuVOvy3apmKFNY1rPlldTW6rT3wRi
         gXx9PkGCnYslURpzMdr7r+Gg/3q/DXaGD0uSKxCYh88oDamzYBepYk8VQOTg2p1iEoFZ
         bSpkEkXF6CRP8jRh5wqI4mRbPetWr+W6wGzpat37Mdz9pUHyOu9X2E1D1N86gnDBRrSL
         kPNPjU7ekS8JhpQLZFJ8tpqIGioBx958Tjx8SVKH9w2DN0u1nDVzeNzuUM6eG+aIz4Ru
         vPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785279486; x=1785884286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KaUmQ9JpbnpkUCaTH5UXy4GKoNzMoHaVL3LWpQbAxts=;
        b=Xo5abigB+XBg4ha6c54qDo4FuHsqlnLQUbxoZS9GGzRjVs03iiejl5hMSMDuDdRHVt
         sdVUcFn+NmPQwHavAXbusgP/PFgQpD3/WTTpykX2WByin/CfbyzWO11Qt1l+AZjPtXCm
         9/LPpb966kJ492MVKcItnAWCmc0LjoaBnSJ76gSzdSIgR2Df0ue3s+nlHaDxIXHJ9MPN
         a3/3U036w3CK+sA3lCvKbNnvQJhdNJFTbHSLy7Ey31GVXpT7gbcMnKHTOldX7qQzzgLa
         SX4TyQ7oitsEO6qebwmH5Pw3nExHxFRrQd2m1XITthCzTnJijRZEn/VBVeVemBNxa2tN
         5z/A==
X-Gm-Message-State: AOJu0YzDHNt4Mmt1IK24anz3Hf6IKTiIs+0S/nvK4MBltuZPrcJsyfl7
	/UjyzkhPUjygnhuIENVLZY0u00whx+49XoabVF8QXD1H+OHeq7QyfO/2/GB5EA==
X-Gm-Gg: AR+sD13b7Vn4KwuDWeGf5uuBXAR8Pk5aopCoVlM1UDQUcRJq/ZO14jSGEXTIjpF40+b
	/qEhAGaMpFVSnZgEaUswI3rHkbD3lLRUNUvtC6Woegt8EqqS7yjYSvI/LS1EyMPNP81a1+Qsc0c
	c1/ofhA5mTO/iILDuE5ETkK3PmRwXt/sw1wDGE/3qX/KEOpVWisccyIPfP6XgoX/9LVC7Vztfj6
	1KLzNppUUbkRdDf8LpIhb3RrQEj5TO6CZnAJfhgWppVYcmvBpGrXDtzf1GH2ttmAJ4AUx2W1Gwx
	Xvw0qUuk8AU1EmVQ2ehdTIVeYTEBetXArXVDnmZHAquPhGSVr9iRo/9xx37dOCLSxtBnrdAFUwA
	AY8AwXprI4OdX+shi4Yo5m/CkgEVR+DVrvx999I1aEDDfgCL7zWU7Ct3xSqhWAvt/S4sdOYMSzs
	FcZcszDp8FYvE05imzyTxJ1A==
X-Received: by 2002:a05:6820:818b:b0:6aa:f2f9:b3ee with SMTP id 006d021491bc7-6ac969c2ebcmr2480939eaf.6.1785279486135;
        Tue, 28 Jul 2026 15:58:06 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0:9162:e42b:cb94:2d55])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4588646ade0sm990277fac.5.2026.07.28.15.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 15:58:05 -0700 (PDT)
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
Subject: [PATCH V21 1/9] dt-bindings: iio: imu: icm42600: Add mount-matrix
Date: Tue, 28 Jul 2026 17:55:32 -0500
Message-ID: <20260728225542.174825-2-macroalpha82@gmail.com>
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

