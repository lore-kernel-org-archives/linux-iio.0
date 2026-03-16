Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA1F3D16E5
	for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 17:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773681596; cv=none; b=sNgU4Y26ECNM6QH1MzjJnnNwaD4ZE/x+tNUkhTob01ZolGykt1TUafmE/GG4mQSYiWyEw/BZHi67Hy0AVLBCXj4IpdyUPqX/CdQnuPrOtBpEbmED+xJsZEiHDZG9+xixYWwt3hCE4bYOXStCpNVaaY7SwXjR7b1fEZysYJR0y6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773681596; c=relaxed/simple;
	bh=FyYL7KjhfBkhq4Z8eKOH65vilPS2pr7+rN80jiOzQpc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NWQ4F0p8Ni8E3QBB4EAH2UtuEr22A9B5hMb5b/Tq+ocWKsijoFf57p4svNBoGzz2jYYWffeERGFtIcKMIMUgShu8uKxwIYq8cCMC5lKys98HpKdCpcO6R6u4RLw0qOxGvLbK7uhvksT/oApJ1Y/WYiDNdp6dZ8Ov+JDMmA2F4wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4NhUkx5; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4NhUkx5"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b9795ca4e6dso383234766b.2
        for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 10:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773681593; x=1774286393; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AGTiQESNTxF+kqg9mPQcr06UPYRyUnWm55j6lAp7RWY=;
        b=N4NhUkx5yXG1WNgC3quqRNlR4pOqVEOUR6t8Il2JDWvlcGTLYM7CLixNyI8Mnwrl9Z
         mX/NyoniGiquWWQNCFwgbx4Ly21QuGOEQezjG2b5H1CUm3jMJeeVYxvGzLj78LOC75cZ
         JSIoF/ppNljUvPY82OOyvk5Uof1QCUD+JbDkP9OqIUemhx4TEa7d954jfmJtq15DuugJ
         ELnuSMIsBSWxp4OwADccnLXbKBnj+qCfFaStgJRTFK13npZid0HQ3VrwERqTKNxkYCBr
         3KSbWHBBR7vKFPLyCOTwlXCZa/EPPsdJfm18rvzUhBJ8SxQ/znsdzPyE/gSHUlyzqbK/
         QtIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773681593; x=1774286393;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AGTiQESNTxF+kqg9mPQcr06UPYRyUnWm55j6lAp7RWY=;
        b=fZ+PBXQT2AFUqE29oUApYTol6D5HHIUt+Fkl6cgpP6m5QLRiSkfMKUKrbrNEyZOcFh
         TXQxcm3Y712sArrBVDfgYIyAEAXA66svPYx7yCmhwP42XIL3uGCszga2cuXKdOI+C9AA
         eBqA5vX5RofIyRpT5DX+P0Z1s2MjoyExTeRANvz2mt1DBAz+rEk+EtC0pOGXN30hF2P9
         olXjJ+Pm21jtWg5kZLpo+CntAtuCGJIpeCWeZppGycXImPBmD9o/ZdAKSmmGb88AtcPX
         VRw9JG6DSTlRezA2uTmeUgx4SnUEJTlpdo+mxO1bB2A5A2vAmoM9FhfbcGGsD90oS7C6
         NxrA==
X-Gm-Message-State: AOJu0YwniuzicY93eA54vGcXxQyeMBWrhj2M0xRTbeSmeEXAELSzzKZU
	63uyiQP6gu/OCCM9qquhRgGij5oy1AkKDJkPi2HRLAwKDcgh0hGjqUsO
X-Gm-Gg: ATEYQzyQlK2gaWLMyWyLF16XHb7iTDgkAP/jQBsjQeGEkmYPQFVG3CRwqTA2+Dfwi7M
	52WZ3eXhYZD+4gNbeqoMFaJyXBfxOI2G9nydd67uZazQvyqvd9U+nPerGX0UlUmr4rX0OLEdbOR
	dPMX01nc8Mas+8Tt4ZLVNKzIIAYkTuASq46Rh70EoX0DWMO0c/2dQUSGrIyiWgUTRXfZJRk83UE
	vf6DxK0DP/Jj4PEST5KA455YNhAWxuqgYwuwzRg9zSe6Nd8pN3NdhnLgv3ksfvJUhci5OH2psKB
	NWQYQ4ZEfzJuLydh3mq3ap5s7uQ/ZiPCXzhUcttDBML0fDMFNYC2iReMP8fu3KeZOx4xiDiRwr2
	flA7DVSbIWwpOC3yXoiGEuKU8dBMywxN+Gdx94hz9Kc1IGetZm9aMzj3x0tsAkkWT1QI8CEgDwp
	aOKIerN4FC0odAzUc5V0gTKtc2jA==
X-Received: by 2002:a17:907:e2d2:b0:b94:c55:81d2 with SMTP id a640c23a62f3a-b9764f4bdf8mr721875566b.1.1773681592603;
        Mon, 16 Mar 2026 10:19:52 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97846174cfsm505940266b.22.2026.03.16.10.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 10:19:51 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Mon, 16 Mar 2026 19:19:46 +0200
Subject: [PATCH v4 2/7] iio: light: vcnl4000: sort includes by their name
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-vcnl4000-regulators-v4-2-854fc2eaf54b@gmail.com>
References: <20260316-vcnl4000-regulators-v4-0-854fc2eaf54b@gmail.com>
In-Reply-To: <20260316-vcnl4000-regulators-v4-0-854fc2eaf54b@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 phone-devel@vger.kernel.org, Erikas Bitovtas <xerikasxx@gmail.com>
X-Mailer: b4 0.14.3

Sort include headers by file name for better readability.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
 drivers/iio/light/vcnl4000.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 5e03c3d8874b..939ff2d65105 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -18,12 +18,12 @@
  */
 
 #include <linux/bitfield.h>
-#include <linux/module.h>
-#include <linux/i2c.h>
-#include <linux/err.h>
 #include <linux/delay.h>
-#include <linux/pm_runtime.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
 #include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
 #include <linux/units.h>
 
 #include <linux/iio/buffer.h>

-- 
2.53.0

