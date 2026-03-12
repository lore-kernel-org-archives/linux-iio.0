Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88E02F39C2
	for <linux-iio@vger.kernel.org>; Thu, 12 Mar 2026 18:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773340669; cv=none; b=jzVLH1K3DntDwsAWsFN4mqCrQWfsUi3Wb6vi4gBuScfKw6OLfzgcd3BAlKXozZnFJPk4qBiusw4qh7xtI5OiQbF1IkIvF1yciqK9wIUTIoIH3h7JmlRH8cjmr5XR3MX+GqDRXe5RrnbDUye9tTFv5YJ24+81f6y0yv0t/05rVww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773340669; c=relaxed/simple;
	bh=uELJpnMSysadI2Kpm5r/ZVI/JZrV+BrD8kTnJQ7zQLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bbcooB9rEURIaUhwFXfq/c4pREf8aVtJFOg4KZbmQjB002hsLOTWURCFfa//PzBbhkIKpp74BPO3LUXO11EX3mqKoNB0jvLO2F+9o5/U+NiFQxztBOu6OURnMLQ4PeKVsJBkfj4kWu00mZxK7S9NCjrHZAxpq3T6fMCFjqiVV0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-358ed696623so624369a91.0
        for <linux-iio@vger.kernel.org>; Thu, 12 Mar 2026 11:37:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773340668; x=1773945468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yXmdF0x3IxYZ25KG6QGT1Bi2RMkVMfC0MXaDAqIpvF4=;
        b=tFiL+3wvJyJJj5WY6Nd2EdPdGCR+IeZ24F7TEXncOv1WHpu2YPnmJusGzD42QlDUv+
         1boANUPzADEeC0EPRD5gLwghSsYSPgzF3nExd57ZIYtmWQRxmLR6GSZxJveXLGZ8ce70
         1YDP/Fd7LsMBXfOnQVbofbmpcirx831O3/rPY6OoBhTHRTjASSlGh60a0otexGnRNRhc
         XQOBG2K7ty9I9vDVQo6em34fQRO0hyWV7V+Ckl7L3xQv3JOwSgzclbAoMoBIJcvp9LLk
         BMnJKmQM2xuOb1Dze+BpnJScqFrvTMlEW8XZOAO97y84g7/9B6+xHdNktt1hPCbWyD+P
         iY/g==
X-Gm-Message-State: AOJu0YwKzb6J+3NcHgCNCd79Sz3hUS2Wn9V/2gTJhcYGqaG2u0FlsoP+
	TOshewdRE4tydeymKxzx7MoRc/GlUrs0oMpJwmZXDAzytK4fExIYGWXAkEVH9JhmkG6noHOu
X-Gm-Gg: ATEYQzxvwoPUa/iefxY2uqwLXl0wR/ALzO5qEMveaZ4XRPYwHVa6QurqynEBhPIuQc2
	ztoc8xn2Ra06Hne0Q+vS44Ph47nWHk8zb/qCjrBhK8d0BjB1Vo7fV8n2mk2Nt/3K8XmG6HGmOQ1
	RCteX5IpeRWwUns62m8gi9hsxa+hhpubgYIdnBowpqJWDRl/e8tqRlO9RQCdBoxAhAQO4CVaPXL
	xbHIMxxGg0CDq61qA7cxzXhw03BmuOxUr+maEAgKgCSwmhl/ST30w4pyyQdCNZKQYqXZ2qEawF0
	VjMzch2AONEaZr/tlDhzMF+bztwgn1LtTa5sn93MVL+6sJ0eWhFd1ZOnsQFJ9J2HvdZvZFQqIN7
	0IEHYa9xt7/gvovL+DXZTVCIIKB4Cgv5CD66xutDn5VtKNVF92ZP69MdZCnsqcksqAurMjTFhJ6
	pLJFZQ8WXnjaSCKg==
X-Received: by 2002:a17:90b:3c89:b0:35a:18b1:c245 with SMTP id 98e67ed59e1d1-35a21e38ebdmr575392a91.3.1773340667984;
        Thu, 12 Mar 2026 11:37:47 -0700 (PDT)
Received: from archlinux ([103.135.252.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a11b42ce4sm3645612a91.6.2026.03.12.11.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 11:37:47 -0700 (PDT)
From: Siratul Islam <email@sirat.me>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	Siratul Islam <email@sirat.me>
Subject: [PATCH v4 1/2] dt-bindings: iio: proximity: add ST VL53L1X ToF sensor
Date: Fri, 13 Mar 2026 00:37:17 +0600
Message-ID: <20260312183721.40482-2-email@sirat.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312183721.40482-1-email@sirat.me>
References: <20260312183721.40482-1-email@sirat.me>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree binding documentation for the STMicroelectronics
VL53L1X Time-of-Flight ranging sensor connected via I2C.

Signed-off-by: Siratul Islam <email@sirat.me>
---
 .../devicetree/bindings/iio/proximity/st,vl53l0x.yaml      | 7 +++++--
 MAINTAINERS                                                | 6 ++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/proximity/st,vl53l0x.yaml b/Documentation/devicetree/bindings/iio/proximity/st,vl53l0x.yaml
index 322befc41de6..0852259754f5 100644
--- a/Documentation/devicetree/bindings/iio/proximity/st,vl53l0x.yaml
+++ b/Documentation/devicetree/bindings/iio/proximity/st,vl53l0x.yaml
@@ -4,14 +4,17 @@
 $id: http://devicetree.org/schemas/iio/proximity/st,vl53l0x.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: ST VL53L0X ToF ranging sensor
+title: ST VL53L0X/VL53L1X ToF ranging sensor
 
 maintainers:
   - Song Qiang <songqiang1304521@gmail.com>
+  - Siratul Islam <email@sirat.me>
 
 properties:
   compatible:
-    const: st,vl53l0x
+    enum:
+      - st,vl53l0x
+      - st,vl53l1x
 
   reg:
     maxItems: 1
diff --git a/MAINTAINERS b/MAINTAINERS
index 61bf550fd37c..a142a97be4cb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25093,6 +25093,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/proximity/st,vl53l0x.yaml
 F:	drivers/iio/proximity/vl53l0x-i2c.c
 
+ST VL53L1X ToF RANGER(I2C) IIO DRIVER
+M:	Siratul Islam <email@sirat.me>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/proximity/st,vl53l0x.yaml
+
 STABLE BRANCH
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 M:	Sasha Levin <sashal@kernel.org>
-- 
2.53.0

