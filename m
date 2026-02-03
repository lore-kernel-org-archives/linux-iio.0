Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58E43A9DAD
	for <linux-iio@vger.kernel.org>; Tue,  3 Feb 2026 14:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770129606; cv=none; b=LI8XDa0ewSMCxlSkf9LImD+34X9d2ReiZUyJGqhqGpCOZigNHTfs29178QWn1iBm/t6PNoWvBfRNpHw+kCQLLd3YkodayrMoxfZeMdni0jOI2nFqOiyCytkYudkqh4sGAKQjZRNxp2gm5fzCZoKoTNSXTU1MQInaQH57SULmBJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770129606; c=relaxed/simple;
	bh=VHzxBohPKCqJnn1a5IySFpJSEFHGzZmaehMCiqtsArA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZTA2pBE1E/GN7VQ73IX6FwQXn1WV9lAjEk5WISOPqEFvyHFQ3xuHo7xGMJgYSHOisnRzAcI+HbIMFcnzpeGUKDy56S64qjYUsSZYbRBkQrlDFjyVqxOIv8AoSzCgd3gsNMeSwvu4XpC1zrv/+HbDDLs7GfA+RDII8KB8ixNNN/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UyxMGH3p; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyxMGH3p"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-81f4ba336b4so4753260b3a.1
        for <linux-iio@vger.kernel.org>; Tue, 03 Feb 2026 06:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770129604; x=1770734404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GzfJiaPT96fMYUkv4izOERX1QNP3Us0TjLYccqND2uU=;
        b=UyxMGH3pFLYN0Aui55Aadszg08bt1H1eVEQH65CIMiVxMwchm1zFInJw+KnA3rueAY
         L5Fa/7GNhogMoRUlVwERe+JC0TpmcDAkwMDfwjSn2oIpE3GRA/yn054vWxXJD3HBZxzv
         bBUsIwd2dMZRa/QAeGq1xpzFmKQoSVSsbXx0GkbnXxwD/eJ10vIfV0vwDBDU+V4xWwc4
         4cgJbsaxdi1RtxGjQL+ZK3OJoL0V3Cd70EFqcCufIwGnTMzPn+30DVttjq1Hxtk8NbFe
         3P8pYepHTkJt+nb5EFhe6PXcr0IctkP/OF+oM0ma9SyPoXbi2MBkk0RM5BNLowgttUWE
         zO1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770129604; x=1770734404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GzfJiaPT96fMYUkv4izOERX1QNP3Us0TjLYccqND2uU=;
        b=ibIJoQycPmPg1jzyPRADUQMDnCKI0yv6frnczn/RWOqdk+BxX4ZViIIFRp0DpcEPG2
         fYQfjggK7XMbTAS8if86XrF1rDru7CtLFPuepYpkM2uQCzN8QV009WByvo1nq2RH9Gij
         njRVn02AVkYsSHclCnLEY1dhnKWrc9uZomYTucomP8blC76+afMEz+WWClnA3zb3FK/J
         u/SakSpuHppJ3aISjS2kslF1FlIkkG/6iC18pkoyAd2yn+xRvY2WFG3SEsMkCQM49mqI
         hsahbH9mowHrY6DZPh1eTioPiYp2W8HZ7/Mba5m7LHte6hL+8taTRNbyuHCKu80S8uwW
         1E/A==
X-Forwarded-Encrypted: i=1; AJvYcCV3dR0zxLNsBqzJE8r0faKz+4F2FZ+Mxk5B6hVlBteTdslanaFLERnSVs+e31bFW6wlKdi6rlL0OCY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2t0IP0mYjzPVfCX31i2yfWTZ4sH63yeHsvbeqb9zWgVCHOeda
	AOTj9YoDLH2Z4hoDzyFTvTVv2O6KiMVB0Zvp4go9miowf3/poqmVGgRi
X-Gm-Gg: AZuq6aIgf6bIE1lKImSadS5MU/kSsVK68Oi5JfQTx8bsrarg6otSCJJcr1pGKSPUSvB
	jZ/B7soPo33IqF3Q7yTiWLvvT1+Izjft2GZY1haYcpSaskJBb1oFF2E/6UkEdqyXFaX5s1RNPQT
	L3aP6Q8nhPLygMTlfiamjl5BiHxhTQybD54dnC54+1VJBPO9leTBK56etmw9uuwPyN2FTT0SsyB
	ZQBfB/MAPBLIsUz4qAubXtUh5ZJDKlPN10skVrPt4Zzz19shPwaw4nLUAhrazSahBwZHDCKNUft
	9Od+8IuNKeGpvdn+2Jdki0bM+74DtHzAxxGxVC6tlF1P+VXzSLnhbOxibY+tVjjFJ/E5P8IpIlj
	uBsre0uCwbFGU+9kG4L4UW18OEvz6xvQ16MjHi0sfg4a+RqNrmjasZ/zyICDTnbtZSf9SpzTBfI
	Hx5NKv0G4p
X-Received: by 2002:a05:6a00:8583:b0:823:998:95b0 with SMTP id d2e1a72fcca58-823ab72da1emr12015775b3a.35.1770129604102;
        Tue, 03 Feb 2026 06:40:04 -0800 (PST)
Received: from arch.localdomain ([2409:8a28:a52:d2b1::1004])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b1ee89sm19810313b3a.14.2026.02.03.06.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 06:40:03 -0800 (PST)
From: Jun Yan <jerrysteve1101@gmail.com>
To: devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org
Cc: linusw@kernel.org,
	stephan@gerhold.net,
	hns@goldelico.com,
	jic23@kernel.org,
	Jun Yan <jerrysteve1101@gmail.com>
Subject: [PATCH v3 1/3] dt-bindings: iio: accel: bosch,bma255: add bmx055 accel binding
Date: Tue,  3 Feb 2026 22:39:41 +0800
Message-ID: <20260203143946.301233-2-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203143946.301233-1-jerrysteve1101@gmail.com>
References: <20260203143946.301233-1-jerrysteve1101@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the device-tree binding for the Bosch BMX055 IMU (accelerometer part),
which is compatible with bmc150_accel.

Datasheet: https://cdn.sparkfun.com/assets/b/9/1/f/4/bst-bmx055-ds000_datasheet.pdf
Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
---
 .../bindings/iio/accel/bosch,bma255.yaml      | 41 ++++++++++---------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
index c1387e02eb82..969a8ed3f539 100644
--- a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
@@ -16,25 +16,28 @@ description:
 
 properties:
   compatible:
-    enum:
-      # bmc150-accel driver in Linux
-      - bosch,bma222
-      - bosch,bma222e
-      - bosch,bma250e
-      - bosch,bma253
-      - bosch,bma254
-      - bosch,bma255
-      - bosch,bma280
-      - bosch,bmc150_accel
-      - bosch,bmc156_accel
-      - bosch,bmi055_accel
-
-      # bma180 driver in Linux
-      - bosch,bma023
-      - bosch,bma150
-      - bosch,bma180
-      - bosch,bma250
-      - bosch,smb380
+    oneOf:
+      - enum:
+          - bosch,bma222
+          - bosch,bma222e
+          - bosch,bma250e
+          - bosch,bma253
+          - bosch,bma254
+          - bosch,bma255
+          - bosch,bma280
+          - bosch,bmc150_accel
+          - bosch,bmc156_accel
+          - bosch,bmi055_accel
+          - bosch,bmx055_accel
+
+          - bosch,bma023
+          - bosch,bma150
+          - bosch,bma180
+          - bosch,bma250
+          - bosch,smb380
+      - items:
+          - const: bosch,bmx055
+          - const: bosch,bmc150_accel
 
   reg:
     maxItems: 1
-- 
2.52.0

