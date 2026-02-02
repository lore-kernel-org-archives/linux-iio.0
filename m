Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505B935E548
	for <linux-iio@vger.kernel.org>; Mon,  2 Feb 2026 11:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770030202; cv=none; b=JEAR0fmuDiwtmFzN5KLBE078UJvXacDIZ/GDwh7Gdz2kaBNpeyFkkE50GpeKGH1ycfbOZbaK8cYJ38XroxVUi45ckPlQx14pmwkZt9C7hDFdYAQNUyAV4EdggYAsj304p2KmY/Y6G/bUV5xtA3JAK0H0P1iJ50keVCCmfvrHFE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770030202; c=relaxed/simple;
	bh=yTtbDUH7h9q2+38woekWPadTUUe8Zbfb7Iak30jumAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n2Z+LYTPXCwYcCvfA+h7VvNVl4jUA7XytkmI2hsstr9nJKzPHk9gybYYnFxDDPriYj8LplJaCQmHHOIYDmBQri1gdbODPFgtjjIOlZ5KmrtnA/cL4av57NMMSdNUMlE/pcKpXcGcaL4RGr/c9C2lV1sYUydDCFs+vL8sxyB8Zy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JmwF48mP; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmwF48mP"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a09a3bd9c5so30327895ad.3
        for <linux-iio@vger.kernel.org>; Mon, 02 Feb 2026 03:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770030200; x=1770635000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0RGrXzKhNs45miO5ytEOVS2CdY77HA45k8SNWSJuX68=;
        b=JmwF48mPdD1gBzewFcEFYfwSYTvIvN8DIr3NTHx2deq/YGS9JvOFGMcrLs0tW868KV
         g5jl29Rg2A0QHsvgS926J93bxVxroWdHr/G4IFjyR4y2A3K4NDUEzjlGRslkOVeWenhM
         Ug8Dlbi6v0ahtz+jbNBNqBfX3H4TMFr209GhbciEjVDfDQWblahTsYyhZozbbMhfqWCk
         xMfiGKfWNEC6hkHxuOibIIgKpgnYYAsRIz6AGT60G2CfK7zFcP2poaGHK/mqXKUZI9Me
         66U6rCzceZjqhodB/CSASxcMSUdZ0ATc0suruSub/4Kt5YfelJPNS/zfEoohveVz1gCq
         I7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770030200; x=1770635000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0RGrXzKhNs45miO5ytEOVS2CdY77HA45k8SNWSJuX68=;
        b=P+QkYxR9ZHieuCPBfUCOyBUGLDoFvFhtVskPJRagCbs2hXqvUTS2qjWberPembv+6X
         iUfPziyvqJ3op+b8hvnFdFhGabk7Fn5CRz+uGsDmFbKcawOxGgudQ+BmTiL/n0sximmo
         mUG2ZhxeXoPif4+rsbkD+6vIWFqBl9gSdgHW7Uv1aj/+NpOspJ+CbYX8S0swIJ6Y7AOR
         BS7PjXmO2sJsTxNriPgaFAZU9VQsuY566VOw+qmBKs+I7vg2NO3aI9aZI+t7Qhw+grGG
         oIErcGsqC+Y9AL5b3Ga8KGPaDRG2cwDaKLr4RbFd6G8DUZo9JOqE/8w65nZLYdyAF0zf
         X1BQ==
X-Gm-Message-State: AOJu0YzCJyeEYRzb51I78tndXdwg1MNNW0Bpv8iOs+EUc93ay42in0yQ
	7sbAuzwn0Vt5sFcQFip8SoVfCLiW8G7xVeLL/VINsGvkNAbR1R0rWc0CyYwrPh5GeWk=
X-Gm-Gg: AZuq6aIGGo4BBTXRc+8WdycnawYBe8VXTrriHIzLAX8WWTOtJc75vCfDWtmzfKC/HS9
	KoJdQt5b+0rNy+uZ97ic10IYQOiTYP7VljSNEkrkP0HAlBLC45JKSH9Y9Hnk/QXMFjkJzLGhpql
	Zuu7cyBa6TwZNNvDHqTYpgKkK7mBS8rxIYg5416vI0XRbhr4mrHV3NO/N2P2QrDdOsj3ocks+oe
	DkKUstU0bu3y7TXxGc8O/LdKVZktDbGKbKIvj2pwe5bxYrai68hIa1cCSSykgmEW7mS4p7gD2BA
	UoeRGb9NmVc1SYP6rku1dhF64O9YxUoBxwyamCMmnhX5puBm6GjCVncTgw4qJ2eJkioapVPugML
	DexSw4zTUxhF5we0EawNeZ8Wh884U/PtLiH9OVX8D1RyBCZij/KFSyDn8Az4ETWFIvqxkNTrh8U
	X2itEnUy88XqxhLg5UpqE=
X-Received: by 2002:a17:903:f8d:b0:2a3:1b33:ae11 with SMTP id d9443c01a7336-2a8d9949210mr121680155ad.53.1770030200410;
        Mon, 02 Feb 2026 03:03:20 -0800 (PST)
Received: from arch.localdomain ([2409:8a28:a52:d2b1::1004])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b5df0desm144007105ad.82.2026.02.02.03.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 03:03:20 -0800 (PST)
From: Jun Yan <jerrysteve1101@gmail.com>
To: linux-iio@vger.kernel.org
Cc: linusw@kernel.org,
	stephan@gerhold.net,
	hns@goldelico.com,
	jic23@kernel.org,
	Jun Yan <jerrysteve1101@gmail.com>
Subject: [PATCH v2 1/3] dt-bindings: iio: accel: bosch,bma255: add bmx055 accel binding
Date: Mon,  2 Feb 2026 19:02:58 +0800
Message-ID: <20260202110304.236320-2-jerrysteve1101@gmail.com>
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

Add the device-tree binding for the Bosch BMX055 IMU (accelerometer part),
which is compatible with bmc150_accel.

Datasheet: https://cdn.sparkfun.com/assets/b/9/1/f/4/bst-bmx055-ds000_datasheet.pdf
Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
---
 .../bindings/iio/accel/bosch,bma255.yaml      | 43 +++++++++++--------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
index c1387e02eb82..5c44b8cf156a 100644
--- a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
@@ -16,25 +16,30 @@ description:
 
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
+          # bmc150-accel driver in Linux
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
+          # bma180 driver in Linux
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

