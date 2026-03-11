Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EFC394478
	for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 22:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773268930; cv=none; b=J7kFtKp3RMN580VKlbfWEJ2ltJ7f20eYPWbOaMUNx6qkkZaoLy7kTholFrq6gCnpMUgr58idHtfZUlLYfmFDmMb8ADiD+rttcluDwTKUiIVXGW0/zRGyMsRsnxam57cmMnVZp4yERL9CyFlvMdaCkgd9gmf7HRDit09WakZncKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773268930; c=relaxed/simple;
	bh=uELJpnMSysadI2Kpm5r/ZVI/JZrV+BrD8kTnJQ7zQLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YUvQzuHDpJeOUppPZoK8B1v5XSn0t6ZOaRAol+vFsk543nvHAVLwMyQtToQYNehOQg9uuSgb7/t2bKWMj3ssJHJLqQ6sjT5DGZxqm7PcuEV7sN2Gq1a1M64vwpbnNHFDRvablftuL8ohqsyC29yFgGGlg943ZyI1sKpfONAdDGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ae505619baso3073625ad.2
        for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 15:42:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773268928; x=1773873728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yXmdF0x3IxYZ25KG6QGT1Bi2RMkVMfC0MXaDAqIpvF4=;
        b=FV5wxWQ5DxL+V/5ekjkO9h1TgYzc17f4ajjClJU8OTXo1bujk2s/VcgeMBE9Ioe8d7
         PiKdA2EgKf0/jssywC0sjiPH57VVokFyDM6Jpr1B1luleOecYiK+ebClv3ICdeBH+dNj
         PIieoZZGJh5JmV8pkeHfErXHOMtAzIp1hTp9fcJ5jfrFSxn0tMjW+Pqsynxw+VGRllD6
         j6PhGx2mX9WJaMy9fIq5fvYdLe9aSUGz1nrqYbAPyeI56piOl1NeT+VyKJwsbghnC+V1
         PVWv7lD0DHBllUIsPmy6wfwbG30muqk2JgSzx4tNJlPtl9ofLX0iqk6d+Mu7X7qUleaA
         4OjA==
X-Gm-Message-State: AOJu0YzkosS8gPkZac9iRmj6bAViT15PoEcOayRGrm5CEG38ngPf1iAM
	VxTEGOCZR9jDWW6q2PO0jtGlHPleM+2CL4gm4JYWXJAX2bUGF4O/T4y6r1zLDg+LYRU=
X-Gm-Gg: ATEYQzwGunzJauQdUA43uFxpyct8fe7tDwr2/DJTGBRF4iwUDb3l/KHqaSByD4BlHLh
	Di6Jimx7aogpybjt+rlQbEV8CJLyUh8E+60pCZZ0m3qoNHpulVZxR4x0EF4fuAgjWSw8Fe/FwMw
	acsBtjrriFZESAgkSdPTrbhK0MA6npfTYWg5BHFj1625onNSfGNzNdGgG7QA679veM02AT8aiD2
	wD2pD5jb4xDorqlf/oFVQ71JN068HRmBC6OJYRn+tAn+HcF4mYyhGuUrumrFOa6syDN48dweYYa
	m6VJvnowpEiGkqO8vgHRnZL6dXFb25T4Q1qSpscv0XFaPNGkm7bRPUkiDMcRdastm23Q53DapA+
	tPNLfkeSZBtRqhiafv8QudIltEs9AAd3171/xyvWgewiGKIcWd3pwujpT7kmSNpPMIl6IXlXpp7
	99wocYjhJ1fx34u0VfvI4Vzp2dKeFBSZpdCxqVUC8=
X-Received: by 2002:a17:903:2305:b0:2ae:5063:b3e0 with SMTP id d9443c01a7336-2aeae7a2fa8mr41433705ad.9.1773268928078;
        Wed, 11 Mar 2026 15:42:08 -0700 (PDT)
Received: from archlinux.www.tp-link.com ([103.135.252.26])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae35ef5asm32854975ad.65.2026.03.11.15.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 15:42:07 -0700 (PDT)
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
Subject: [PATCH v3 1/2] dt-bindings: iio: proximity: add ST VL53L1X ToF sensor
Date: Thu, 12 Mar 2026 04:40:36 +0600
Message-ID: <20260311224044.21480-2-email@sirat.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311224044.21480-1-email@sirat.me>
References: <20260311224044.21480-1-email@sirat.me>
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

