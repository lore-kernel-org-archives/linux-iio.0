Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5BF3A9DAD
	for <linux-iio@vger.kernel.org>; Tue,  3 Feb 2026 14:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770129610; cv=none; b=usbQVkbpiPtOfZo65WFuVo8mBxSnOl2SypyJ1zT+egykP7BFii6FLP9m7WsuZIhmDGcfAfZAO+Br6kKsE0Zswg9c4GpdAuN4gcpOwEOVbAW5DfO82yxvq21a2txCtb561e5hxepDejsyCCleaDy/1Z1ERZHkNph2QeW0jr6EBtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770129610; c=relaxed/simple;
	bh=eCh1JlqigfgpIfO+qIsvmTVA08jKK4MFxzSQjJHW420=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eSpWg5UUTumBBZ2SqiZSyrOYr7NDRdhKJLr00BvmnnT7PEmFKAJi4fIczQvTpAVHdErKfvpzSOeLiHKA4K/gzj3ewD1kMqameceiUE/2EWnRJKiH+U4gB2Pt9geJ0byETuesSnUNPd3c5qXVbKDqnGYEjttQ0LrQtamC71AsFWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJDQvPlG; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJDQvPlG"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8220bd582ddso3377562b3a.2
        for <linux-iio@vger.kernel.org>; Tue, 03 Feb 2026 06:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770129609; x=1770734409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OSwiV30p2Rwa/WNUs6szqKx/rYH4lygABVF3uf9QiEA=;
        b=AJDQvPlGv4Q+LdmsgYzZsDCHfNoPNv8cW3PJLNYJmSsIMjPiNVWfeGRyFz7P+ASIJD
         8YYeygP08n2pJhz1pDE2HPsZ4Zz56WJ7TGk7Z5nNrobmNumUWFaRniczDbRLfj7K8HHq
         kCRsPiPvMl616nqF9YNZt3tCYBTqXaX3VBBUtllOOq1UOayNsIM85Dd8/gaNWK2f5PUc
         nCADrT4no6t/VUSngerf6fNUTp4LolSXPv8dS82GezLg2EJLWE6mBUhWArPJyXAcVg8/
         M5o7BO5ZlN0gsYfXBqJFBlRUqDkZeUp4b/oHOoiZW5Ap/2gZ/YLQCut0Gvl62JC0anbj
         szow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770129609; x=1770734409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OSwiV30p2Rwa/WNUs6szqKx/rYH4lygABVF3uf9QiEA=;
        b=GH6Cw/TTbECfDHCl9CKHVllF5+oirXJMKk3CyDa/a/gGByvCMcs6u31N8tvOjpuzJ+
         SCicGNI4EaApGHueVpzPrOziyHW5eeqlof9Tim1Y9zknw3FfxO6nsJ2DUVoYsyYIRtR8
         hLWjiTW5pZ39HAZ4mYMzLwMZPfGpGAQ7BrwQ9KDbc5q3IBHQY4bm4valGJi/y+kzULws
         p1NH4vguf24EzXVihiKbrqvGUvCLlPcgJhAZb399J7kKiOjl5i4Cby29D6X7efW/cBRm
         /10Fmhku4Y3f6FojLM1uxo2dUkT+9nhy8Z1HsLupxEmwRAT7k4qDw/pTEzQ/Xj+e5HUA
         sbKw==
X-Forwarded-Encrypted: i=1; AJvYcCX45rr8mvBGo3xvAQkrGkSf5vAaTw0gD0ui6zRrPW5lgBjMR0fKUzWEGd300n9C8EH2e8wcolRRsMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBOjTXL72cWWBjnMHN0SShIgxv8B5T5I1g9uPugKn0uNBu1OZ6
	OcoyJcs8+PYiTojRNggJ8GBDx4oS8VEVNZbx1ci41QquHIxGTwCMs83/
X-Gm-Gg: AZuq6aKBriyHo4IRAIrXx50JpWO2iulmkHox6sEaKTCuZ4haaNVchWseGVbf25+Botv
	Nugy8JKX/OCX2wZXS0DDQQolCzWlxVIdNmvkId0AmJy2RTHnSUOw9ifdfxLioPA4vdxNI9I34qD
	2ocwLCpJ76qhR6zkDmTtKwXYXrzd58CVbj3cdfucqlRWEjIuZ5vZ91/q9pBIVQiHGz1MOelzOab
	Ifj6oT295UXeIC/Yd7hXwQ1K4BS03Ji64gb1AUHk9jf3ANT/ei513zT5JWJnoi5/MLd6xOLetRZ
	Yo+/rpzQxgqpSqmB2DmVrg2ByYVC6YEfWCKxQsBvBvjlpHpA3AITNTU2ZquJDP2YD0Gmflu5s5K
	Fk2rbATNi+SNDE7b0ZnGq065+80BEWXsw3odrN6fZpuvDhuiD673t5V2i3pwc3oFzGtj5yY9SH4
	83nM4q/yTfHjijDD7Ri/I=
X-Received: by 2002:a05:6a00:2313:b0:81d:dd3a:b8f5 with SMTP id d2e1a72fcca58-823aa9597afmr14495016b3a.38.1770129608775;
        Tue, 03 Feb 2026 06:40:08 -0800 (PST)
Received: from arch.localdomain ([2409:8a28:a52:d2b1::1004])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b1ee89sm19810313b3a.14.2026.02.03.06.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 06:40:08 -0800 (PST)
From: Jun Yan <jerrysteve1101@gmail.com>
To: devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org
Cc: linusw@kernel.org,
	stephan@gerhold.net,
	hns@goldelico.com,
	jic23@kernel.org,
	Jun Yan <jerrysteve1101@gmail.com>
Subject: [PATCH v3 2/3] dt-bindings: iio: magnetometer: bosch,bmc150_magn: add bmx055 magnetometer binding
Date: Tue,  3 Feb 2026 22:39:42 +0800
Message-ID: <20260203143946.301233-3-jerrysteve1101@gmail.com>
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

Add the device-tree binding for the bosch BMX055 IMU (magnetometer
part), which is compatible with bmc150_magn.

Datasheet: https://cdn.sparkfun.com/assets/b/9/1/f/4/bst-bmx055-ds000_datasheet.pdf
Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
---
 .../iio/magnetometer/bosch,bmc150_magn.yaml        | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/bosch,bmc150_magn.yaml b/Documentation/devicetree/bindings/iio/magnetometer/bosch,bmc150_magn.yaml
index a3838ab0c524..09d1dc861d4f 100644
--- a/Documentation/devicetree/bindings/iio/magnetometer/bosch,bmc150_magn.yaml
+++ b/Documentation/devicetree/bindings/iio/magnetometer/bosch,bmc150_magn.yaml
@@ -21,11 +21,15 @@ properties:
     description:
       Note the bmm150_magn is a deprecated compatible as this part contains only
       a magnetometer.
-    enum:
-      - bosch,bmc150_magn
-      - bosch,bmc156_magn
-      - bosch,bmm150
-      - bosch,bmm150_magn
+    oneOf:
+      - enum:
+          - bosch,bmc150_magn
+          - bosch,bmc156_magn
+          - bosch,bmm150
+          - bosch,bmm150_magn
+      - items:
+          - const: bosch,bmx055_magn
+          - const: bosch,bmc150_magn
 
   reg:
     maxItems: 1
-- 
2.52.0

