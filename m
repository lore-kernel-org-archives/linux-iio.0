Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3D237CD2E
	for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 22:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783980068; cv=none; b=MU/UhDFsOBbnZwOregCGsUNcSQR2NDP0mJg8WOEzh85iEEhkiyQjdSjTMA3aW9E/uuQDOKSKe0800kAAj9MNpNvj99NNHUucM7BWm5ta0K5k07iKBICbVPu6xRPjAhPWefx5pb1bbr7fnwM+Cbdvhbfb9jngO2V5cc8L+YgP9R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783980068; c=relaxed/simple;
	bh=44wlK79p2iFBlaDNEJYYoVrsZ4V64y2DhfrkrngDWyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TfnSMiuxM+WLyAbjPSpht/EE5ScLr3J70EPHKiuj2wXlurpwJpgBFjRZ/UunZeD1y39SmkI1blyyEeqbn5s8B4+2eYtbf0qwP9PL+XkNkWSnanHRqNt/VhLPfimKgZof+q+WFx9h0ciHC5tR3uF6rIVI50WqYf71sBxglMorVXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VIYXWdSO; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIYXWdSO"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-497d3e4460aso400494b6e.1
        for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 15:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783980066; x=1784584866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KaUmQ9JpbnpkUCaTH5UXy4GKoNzMoHaVL3LWpQbAxts=;
        b=VIYXWdSOr1lqb01DpmTIciJSang1LexoD9oWWAQRYpviKVRF4Ke7XPwmxQDucVVoNG
         ozAJYJm62Dv3/gDtPnLG+n2FMooz65IucLweocg4iQOPs4OEF5HMHkFKsv98KdDKjwIh
         sMhlxGCL1WxSTp1HkFlplL9kGbq2tBJfdhANCJR2/5mIPyxpVQGRHbbstIY/8fYp53Wq
         YE7VsPe9gDP/+5FNdUumKp4dtCHwk/BvTjL/88E4Rf5bwQlGaejgnvFGuF92ckugVfIZ
         V06sJgopW0hrXP8YdviQcJqHmpP+BZNOnvMEB9RzHejFDXiGNZ8Bm4EYELlt2Hay4DBE
         idig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783980066; x=1784584866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KaUmQ9JpbnpkUCaTH5UXy4GKoNzMoHaVL3LWpQbAxts=;
        b=hP8+AF4a3v3VnLn4FskrGKTm1PZ9JSqV9G+4K6OYfCI/MFYpmlfLeteiLDGoC9O0N+
         259SzYlTqQcskJv9INLOhIaIRnJ/ZtPd1rkZZa6v7UKRIcU67A9xSIARZzvOG9zXtD45
         to1RWVrrkfwBlNWFHoTtip/r9pybO8B9Qu4JlSUkgy3PMJpJTaHLAXq/oxj7bIvJc8o8
         mnncmC8Ndzm7zSSilhqplHgjN1kV+ZaeIcHR0qs0Q86ac4UUbFWKEvPcZVkwGJ5FiGJb
         Xn5GFKAvD2T3YOLt601PMLN4iGsuehGdfr6C6tU02gWBwW4oIBTyIx6BkrzQva4FmlLe
         jVbA==
X-Gm-Message-State: AOJu0YyY+DD1iSJMgUVClsWl4U7TbcEjya1A+8c1U9Cr8iHVmqTYrzsF
	lktoheFVgRx7DMQ3OaGjtrFIH6X10O2FhOS2gorIPCD6/ypIJBXWSP4ctNDQAg==
X-Gm-Gg: AfdE7ckeEk5X28/+L0qWnEyG7v+HoQEwN00Q8n1Dbs5TnaQod7YD8iEsSoKxFOQu4wc
	a56Huu9h4EQUH+jfY0bmOhsZI7SGC3a6lJKgrV1pww+oS5qvLRJOZD0Y7Ga3jPpcy2kZU/Xb3LB
	v2KOKAn988JWGg6omEe0Mu7DEtYEBbhrnYjkN3Tu7qlJmYSYG2ebXiAPJVYtLtn+hD1fR1Ati2+
	8M2IaTVUXUfxASFa6NntGpxMM9BZXea4+Hj9wXiTk3jo62Ch05Nas9oruJxdLKD3S91Rqy8hORl
	dwT0FtitHx1JTDkW0tt/j3g3nRK/4p+2zTGHR/SPAnmUDfKrrEN/9iBTiSMOj4O8fqKObS0O3au
	xQEfO6d0mEDK5PJXCPmu4wVMXBVtH++Ih70oZySIRW1Zd5pr6oWIAtYy+83khk5WD+HZMmyIFql
	L+RRSwEMs03tI=
X-Received: by 2002:a05:6808:bc2:b0:497:cfda:3c0f with SMTP id 5614622812f47-4a40f048b13mr10541643b6e.29.1783980066006;
        Mon, 13 Jul 2026 15:01:06 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a1acc82f3csm12939785b6e.3.2026.07.13.15.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 15:01:05 -0700 (PDT)
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
Subject: [PATCH v16 01/10] dt-bindings: iio: imu: icm42600: Add mount-matrix
Date: Mon, 13 Jul 2026 16:58:31 -0500
Message-ID: <20260713215842.69097-2-macroalpha82@gmail.com>
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

