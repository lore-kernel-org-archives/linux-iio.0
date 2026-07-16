Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78B737267E
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 18:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784226545; cv=none; b=a4/SNkGXecgH2u7GcN/BVT0NqExtBOBHjaQa4aW3vUXDPyMAdCNdBjr6Cbf2BG79e9hkEFyX63iEg1XHt+u0p9qN6OjsilMyHh2ugPGHABEqN6Y/6hnZnI9yFHsR9MsaJb3Tk9eUsmniZ+dRXcOMzY3XkIbTwsqrQzxCST8yPUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784226545; c=relaxed/simple;
	bh=44wlK79p2iFBlaDNEJYYoVrsZ4V64y2DhfrkrngDWyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CuzVIwu8GFI6qyIWgxOfHX0Om7++mkchr6V+aX3RGc5g92fJZ/Do0YGLQlgtmGjdD7/rZC/+4fvPfx52sETLXGKO8xec286xYgQX0YBWX4RuYc2Lzk+U/A9UD0qPCamRor5y9Y1gECUvgJwk9+Bnb3wmFKb3dEpciLrWdOo0Il8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8elpYg/; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8elpYg/"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7e6128bd9b3so3568141a34.1
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 11:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784226541; x=1784831341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KaUmQ9JpbnpkUCaTH5UXy4GKoNzMoHaVL3LWpQbAxts=;
        b=W8elpYg/o17CJ3I5vH0ni9eyjza9a229wrX9ZFHJu867O6vJmLd1OiOPh17zJmdkg1
         /Sp8siVUC6QoqH94RJmrTAmCOT4fJ2tzFQ6HJrNGAL1eN/4v5uqBPaVDgP0nB9dwAQix
         8hQhtugJMI437fpEsnX0qcqwzrx97Jc3TMdG11Aks4z5T8f454a07TbjAiIrxSVddqOE
         SsrFXDOMjltb39SJQvgkIPqGEYxeqzyC6cOCNmo4Qd+d0VwSkutQrEMdFVjhcv0TX4DU
         YldC8XuU3ZcR+h18hsM7I9OaH3Xn/riDqlkJPkE9T64kahrvIIFMWlSkoNTdxTLuO5Gh
         skGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784226541; x=1784831341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KaUmQ9JpbnpkUCaTH5UXy4GKoNzMoHaVL3LWpQbAxts=;
        b=K4ZFOHXOEzhwfObw1wWZo4c5zPovBIlDjOAYEpA7Httl6WEo3tZG14NNVDYlT+lGJg
         fKU687o1etNS8Padmc0DymXRtqcWbWLbg5D+zZGdHQCJMk4I92O4YSCCeahqnwgk7h+R
         97aOKgi7ykmTbNG2sHzI4Wn3ZkgAwpPk1axPdnAcl6W9h+4Zf2ujHJtI51Zk5K+wklho
         EEO9o0LzyM1kMIuocbyryYJ6x/IVTfHI+jyyx9GoT8kcxAKzxS4Hl4GVHvMFgnqXJhV7
         ndbJX3tvcfT43zwsdqntgN8db2kci+iBjjoYJ/hbH6XYFsiALqaP5frArI8FUU9k5ZFm
         9OVg==
X-Gm-Message-State: AOJu0YxQpO720C/KIKy5XGQfuS8DzUOpo1D4l+JcBuskNjgZpWCEcuXK
	CzGnAQLQcFcF/ShT5Yb68Dbtyq0bplnXQmrWTQx92FcMMYsjuOQIfXKUBDU3+g==
X-Gm-Gg: AfdE7cmhrpvzECM7p3AL4npYb1oYrvsMA31psNl9bCX93/R58LjpROTU4iYuHTHpr6M
	aTKW1HYap5Fqqj3S6/b9AD/YlpQ6C7SKbUQAKpC+TuMIgaCxD9q0pr9zgbw6NHZw/CQxBhxN1ik
	9hP1IH39dasaRtsHBBN//PoHaQldb3k1WxQxouiRWOTXYS2hhqHJYZvJFk0neGpvr/xdOQmKTkk
	tKm5oJY/ccJqQwvCoYoWRat9h/RuyzHCjvrGnxlBgDIQe9qDu6m6dceUeq/HCo1cBBXLFxgIJzu
	+wdMGO0RvAUWkY5vKRWXQKS50BkzWfEg8vvMXL5FH91fIP1XDt+6u1te2/QP6W6skEHgmUXiHwy
	e+nqtDVCARiGVVJsNQw1NMU5Bswgi1/dOfj08jqC3TkpBmBOSo+b5C6aZ9m72rF+C1HYCmYaLuF
	/R
X-Received: by 2002:a05:6830:6416:b0:7e6:f582:955e with SMTP id 46e09a7af769-7ec59baf6d2mr5210296a34.10.1784226541322;
        Thu, 16 Jul 2026 11:29:01 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcb3f6826sm19939993a34.27.2026.07.16.11.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 11:29:00 -0700 (PDT)
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
Subject: [PATCH V17 1/9] dt-bindings: iio: imu: icm42600: Add mount-matrix
Date: Thu, 16 Jul 2026 13:26:28 -0500
Message-ID: <20260716182637.24310-2-macroalpha82@gmail.com>
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

