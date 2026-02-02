Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB2735B143
	for <linux-iio@vger.kernel.org>; Mon,  2 Feb 2026 11:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770030206; cv=none; b=Apdbl51Sq2Vfe7zhRosmb5hT3Nlt1H5J9UUQ6dTm8WodlsE2uRfMc2CNwvQk0Dou5uiAPds2tWMw7WFWY0U1QPli9+Ql17ic9jUKwTE1Z6R793a+wNjTzbr8SPT4fnJH6ne1wOUdBVrW7PQnCUZfeX1iiFf1vf/5w0jLc6lDeFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770030206; c=relaxed/simple;
	bh=eCh1JlqigfgpIfO+qIsvmTVA08jKK4MFxzSQjJHW420=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p4CAlFziAECaTvtQb8VNKWYpReEeby3n83cUeyNW1aB8RLYK3JptrEkBidvIIOfLj2w/Rwrfkzh6JER0Ggtz2DrN5mbvkMwSzdfuapQ3c+4n4bLebVm5ZIF6gxda9KAt5AdlmGQIKN0/7kSpeL6/yVTE1s3OOAzcxQe1sWEKKN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aYATB3TT; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYATB3TT"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-29f102b013fso45585015ad.2
        for <linux-iio@vger.kernel.org>; Mon, 02 Feb 2026 03:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770030204; x=1770635004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OSwiV30p2Rwa/WNUs6szqKx/rYH4lygABVF3uf9QiEA=;
        b=aYATB3TT0GziKl8DitQSvlgy+Mab4RDdjfV72JqcOT7lcxcTspflJrqFxJoqCwGGzU
         szisRz6ce2Bcua+9WEx+tVreBDmSQqQuPWhva63TZ9yjF4Ui74K4GfR1/kTH/revDyam
         dVCUaBXxkP+Ut++h6tIm4oeYZb/PeJnY9aP9S02Q11dYuvDqxFHnJ/j100tFHltMDnm8
         WMRjLN/6wd/R0ucimsDNKSDOqVdoWUBk4bJM6QKcLrGU9xoUeDyvpcu1vHzn+cuTAMSV
         ueFA/gOXWBcIWSFi/anoVFCwEA67t8+GbjOgQp/TuhkaDsd44UdCTlWiMKmD3VxJ5Y1s
         NWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770030204; x=1770635004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OSwiV30p2Rwa/WNUs6szqKx/rYH4lygABVF3uf9QiEA=;
        b=iOsPA/9nDWzuETUKLuoM1XA9DGPwzADbE6GckNxJ/yxhekiROIZbi3rbh34jEbH4Gd
         6F48A0dAy5Mfx4ZtYc/+tXlqn4iVPx38y0TNbOWt1iruPaKVxxzq868YYceP0OIolxKk
         raiINs2YekD+XsqwmVP67ZachAgD+TEE1bRWWnK7nqzxcwKNMefi3dMZ2nW7mfUkCHL9
         psmvIyEoEYlSQqmZAJ1Umnou61i0lwrjDtNw0nhN8oJnKc/1YN06f1F6ykYZGF/aS/ja
         sB6fmAJpLWiJCfvdlFtgo6vj+e215nZyBjIccH7+ihyMPDeJLmFPGodSv88fAZCoegjA
         grNw==
X-Gm-Message-State: AOJu0YxYS6wvyDaKZMEsoSKOcN4pfH8l4NKumYOtkNnTRRPwp0QUB6cI
	HyYO4Bntk+2/DHSjXr9VVN2z+TQiWtX9RZH+3O4yCnvKxaB0RP5orWHco6Jzn4nr1Vo=
X-Gm-Gg: AZuq6aLXQD0YCeTGlT0qVU6uWRl/2aIC6OxKe9aDwaGsu+syILjM+nxUEbiaSkqL60E
	EXxf1dkVa4ymeQFZDjd8x+eLKVeokdityl+x/wBuJS/4DWLBq2D8SsPxYZDPaa5qpkUgkS73XxZ
	WO6to6P7bM/3sa4cNZPeE8+bqi0X8oN1GLDBtvRqmh4JMWxWX4ZiZhfZjAnld6wiK0s2PNOHTKk
	aXx20RI+cyJ+2Gjh/sgqSdyotiwtDAVHUL8yh49U/8x2EzYp2e9YYy1zKfGyCgr/UJ89knqBx5S
	P+WsIR+IEZs0k6rbFcxyaFN9BxPH1s/sVCXVsLmobBViuLVXOcka8bOo8w2KK1tb0XifNW/p5Pe
	s5UIh+pcwwZKp8sXwGWieXvoJUINZ3bK3lUOzUt5eYzq6XNs7GxPsLUG9oaONhKMPom0juPLsIp
	zYeDhXU/Mc
X-Received: by 2002:a17:903:3508:b0:2a0:c35c:572e with SMTP id d9443c01a7336-2a8d99129e0mr103171915ad.30.1770030204459;
        Mon, 02 Feb 2026 03:03:24 -0800 (PST)
Received: from arch.localdomain ([2409:8a28:a52:d2b1::1004])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b5df0desm144007105ad.82.2026.02.02.03.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 03:03:24 -0800 (PST)
From: Jun Yan <jerrysteve1101@gmail.com>
To: linux-iio@vger.kernel.org
Cc: linusw@kernel.org,
	stephan@gerhold.net,
	hns@goldelico.com,
	jic23@kernel.org,
	Jun Yan <jerrysteve1101@gmail.com>
Subject: [PATCH v2 2/3] dt-bindings: iio: magnetometer: bosch,bmc150_magn: add bmx055 magnetometer binding
Date: Mon,  2 Feb 2026 19:02:59 +0800
Message-ID: <20260202110304.236320-3-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202110304.236320-1-jerrysteve1101@gmail.com>
References: <20260202110304.236320-1-jerrysteve1101@gmail.com>
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

