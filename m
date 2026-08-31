Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E038D39CCFA
	for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 21:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788210835; cv=none; b=UC5M6vZ3ZyXyede5/ZqXuLlXZnFip2ZRjJ1adMWI8UGqlt/ndX+jyd8ImWvRGXWYKFNv7GNVZe9RqMhZdif1u+jgxo4lytU43J22/FcFFjDQz42pp3t5QXdGQOPW2OY3tFJOnskjrc/Vy2nyHjd5I+JFQk5FtAPe5opK1uDHCQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788210835; c=relaxed/simple;
	bh=c1kpDXLLAzdZm5rs2ETbE/7TO3I2DSL19IHJCzFyRZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XLvjE5tZ1821dx8Upeb6L6qFuAG3oqfQYgnpmp+GrBy1jt0xChh2uY0y9dskyMlbaD/9mhozzamaIi0pu1WIYav9YLIyD3f5Lw34fD3lD7k9RZBFtQUuu7KUq7GMbA27SbzBSzBwVROPxRPv7ooTnrnf3iLyA1n/bEMBS/63ctg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXWSjwf1; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXWSjwf1"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-498028b3d5eso45896985e9.1
        for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 14:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788210832; x=1788815632; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XKzkLe41uuu5Pw2n4p3dvsG3NzOD2toE69Y9PiVCR9A=;
        b=nXWSjwf1Pe+QzVmgqXnvx4/2Fk5Hp+41P10kd4zaUKvX+SHGXATDour8IvfhD/IB6s
         fwroRok09w/MNgNT9duDvII/bKzoH8t2ODHv9Xsq7KDsysEXqNliuIYak33sELzBp24j
         4AVuiQzLlUR4aHb0uBwZDtT8O8/tvjnHDRupg3rkSyFdU7Wbdo1oU/NUqhy4B6OC+jmE
         +Hkn1sC0J8VgGCDOnChkQZB7PkQWkvXRss9vuYq7wn0/Vnvlikeu/TxKuDKpOzf8JWlf
         H8cm46THE+z5JSfSHZT7loGAKrR7rNjWx70dDT+mYpE6UduVoS23XpkxYNJH02yMYd6p
         WlIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788210832; x=1788815632;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XKzkLe41uuu5Pw2n4p3dvsG3NzOD2toE69Y9PiVCR9A=;
        b=Kg8sSNMTpqP0UfAeNxLdQZQuunzffWX3fm+VX4vxMGDNVkjmxNx5DIurcHr8lkatEc
         Nfx7vQYLd4vf6R1P2cs8cI9D0i1t+V1DzNrXiYiTmyvaaga/j3AHlSJ9MldKt8BXnr/u
         uFk2UMe4bOVAxn0Ahif5pY2QALV5Fm4qmXLXCap6n0DEV0fMYjr4PM0fDqklKOSJuDQl
         TU/E8hl/u44qvLxkZWG+zH3oZQkZtZ2TTL8lM6mIPhUA0tZWZb4T1uakRqcYE3kFxOXh
         gQ/Y+w8Bb6BZ6v86LGjLlohxS9Np8l8/at89QUBg0woEgBIeyuBf11rowEz1nZGadaLE
         x3XQ==
X-Gm-Message-State: AFuF++kPAQ/hslGQOJVnQdbU96WA6uX0K+f9EjzVBvfWw7Uwe8KWg42h
	do1mnRkLyQ6NSEobjmGXNLDzWv8ZcM2gbB1Pb3UMBp5bHx5/oX1Z/F52
X-Gm-Gg: AR+sD13RwvmQ5VC4iCqjpcC7uZ8B3x1LFb0O7pzPQtAaHUAESfEP+XlA2UAnhqdinn2
	4WHWX/HdV9/iqlq62R+RjKtENjDzDQig3GIBEHnRGGNB6z8hirCEA0vgoKcSJn/7hJcz9qKQQg4
	2r4K/paOpBD8w1WD0xSxziWGNT39cX6B9PqWkaarvaw8i/yJtiElVJ5sf3qNoYx3v/OBgCmZBLQ
	eqo0SpSQ0w6mLTBzyxQo/zMDcr5ZkpIRINQilrfPNbgTMR/8zlEPTwXGNXGfhmT9lo1vmFTlHqC
	Aaw08UDizsaI/8jBUHtC+P4aMVVMZiUqbjS6M7FFlTjfvuP/HIRzi1grYrrmI7gRfUVad62wFy2
	3/ivUAYqyq1ved2HzDsvmW4ey3U6B3vl8SHDxhqAnKyo3O+gsX8OeD5spsCZDaxB8+Idjx2ubyg
	IMy+MF0o53YoaBscRbCI8fj8OIwSM9nCnOnpCCSyf/5TPpMydd/uzSwhOHCRYDfkSXIprlbdxxj
	3jspU1YJs5C7WB2mNX2kWIfa9/chmNNTASlgUaQhmx5fhp48tj/rLtYYmjtbOOWbKPIjFPxDY4a
	llnZ3zuVi7N5zjVTn+qX6xmkkK4FMuG5O9cUb/FbjFx9aXLyoPFGHxEwQ0MCmnMGGJGjb6DiVdZ
	Hcv1cb53/LMbn7pELgpjcFgo4
X-Received: by 2002:a05:600c:3584:b0:49c:dada:30b7 with SMTP id 5b1f17b1804b1-49cdada30e1mr69494335e9.2.1788210831846;
        Mon, 31 Aug 2026 14:13:51 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce1754csm17695925e9.10.2026.08.31.14.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 14:13:51 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 31 Aug 2026 23:13:40 +0200
Subject: [PATCH v2 10/11] iio: temperature: tsys02d: reorder headers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-kernel-header-removal-v2-10-b92b580ef5eb@gmail.com>
References: <20260831-kernel-header-removal-v2-0-b92b580ef5eb@gmail.com>
In-Reply-To: <20260831-kernel-header-removal-v2-0-b92b580ef5eb@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Crt Mori <cmo@melexis.com>, 
 Puranjay Mohan <puranjay@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788210819; l=842;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=c1kpDXLLAzdZm5rs2ETbE/7TO3I2DSL19IHJCzFyRZI=;
 b=/9T0HwT2kFNaIK5SxjBYoSNF4M4fJ0efFXJu9yZX4lr3Iv2RiwO4bP03Dc1illoS3q6eFB4Rd
 XZymG4VHGU6AgaEiPmRVWvPZLN1dRZiVyJocbctFdLobZCUPouIRnUP
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Sort the headers alphabetically and group the IIO specific headers
separately.

No functional change.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/temperature/tsys02d.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/temperature/tsys02d.c b/drivers/iio/temperature/tsys02d.c
index 3ef72347456e..377e27b45fdd 100644
--- a/drivers/iio/temperature/tsys02d.c
+++ b/drivers/iio/temperature/tsys02d.c
@@ -10,11 +10,12 @@
  *  http://www.meas-spec.com/downloads/Digital_Sensor_TSYS02D.pdf
  */
 
-#include <linux/init.h>
 #include <linux/device.h>
+#include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/stat.h>
 #include <linux/module.h>
+#include <linux/stat.h>
+
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 

-- 
2.55.0

