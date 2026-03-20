Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A973D812A
	for <linux-iio@vger.kernel.org>; Fri, 20 Mar 2026 16:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774025149; cv=none; b=nRTCzuVhklDVIMH56hOzet6i4zdVRgb0sR7yGkPbkbGGXvdjhHKDlg6Ff46nqLbHzoSRENiQsRV1UNBffTXZcDKj7NkvenrigFaHM8FY6CmtZ8Gg7a0ks4jR2eWIbQRK+w1IcheuZVxfMiARONfj7RitAUerwqP+fjRgQpsfnRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774025149; c=relaxed/simple;
	bh=FyYL7KjhfBkhq4Z8eKOH65vilPS2pr7+rN80jiOzQpc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TrMHxy39u1/86FnOtianmViX/Kcew0mOGQuWzd/x+Gtx3SBHBBaNjfgEQpyOCBCNNvuEau3rAiCRnNoMjDujLgaAH2epNx3z99X+e5145MgWH1q8+rIKkWAQdt0KdbmHBQctMpYsDZjAFPyeILhsojySV5+9LhGz5J9gekq1Khg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggb+tcOd; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggb+tcOd"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6686d06c411so3410874a12.3
        for <linux-iio@vger.kernel.org>; Fri, 20 Mar 2026 09:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774025146; x=1774629946; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AGTiQESNTxF+kqg9mPQcr06UPYRyUnWm55j6lAp7RWY=;
        b=ggb+tcOdscs9eAYb2e5tKZQk+kYeBWr0YUE4G3u/8CrB98na6hfC4/nlQ9YZY0vG4G
         J/qMUikmGXDksQECftmOJ7t34pgaEgTAXbN0Y0ViNimfZz01VakjTty+H74kwEPnZX2M
         mkcw8Ztd8WVUGaxIwHJ3doZ2+jCv/Pl0BWYcSTu+d7GXXdkmJOmR1KYGBauuWrt3Fmi5
         TLkVcoQ5HLWg3S8Hnhje2IsFZDM2ZayW4ADGsN4dTeay8nxR1p3FAm3gDs0pN5r42L0k
         6ejQDQVHWsL6j1i+Ldjica4ALzeKpVDxvuH9/PFeIb+2PNQQq5G7CUR35fSdj1OwNGZ+
         VmFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774025146; x=1774629946;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AGTiQESNTxF+kqg9mPQcr06UPYRyUnWm55j6lAp7RWY=;
        b=mPF1Zg+1tNdD/H82xkbBNYnIPEoksJNU6qt0Ozt+TqPJv0UaJiSFQ9UiEHrUVtIKMk
         +xY2rh/OUYB4SQQpMpvXTrbsUEulrFb9Yy+mcF9TiW3inDQKu1hL7EutzWS7z2ghFdsv
         p1llQVjJIu4ffv+ohaTOcc2/XFqfSciblHTrSo22urO137ZsQWzyCkdsZazcMrENqv1j
         mZCufe8gbrNgJuIFznr7+fAe15gMvenH1ZqcK078AYj72gJGKVMb+TJ08Gx/2rkonGf+
         0R10upZJ+bCkMriJyAjODwckeuTNvIy4A32+wzPkMVrle3iWO+1b0V4RyyJ1huy5cbG8
         KL4A==
X-Gm-Message-State: AOJu0Yw5a+6bvdg92lwUz+OFfw8J9z/rlkhs2dLUbMTHjuMmjLQu2S3e
	48AKrI45V0lf/gaG2Guf9lSBfl8JNUbOi1OqDFM/1L+h0/o+d0B+VXym
X-Gm-Gg: ATEYQzyxwYiOYc2TR7tb9ErxxQx/eCnbhYjgGwYzAggMNYvRUI+ur6OAgfwe+aLf7Je
	7Vd5LzNH937CftiOjFV6ktdhKr2XvOGJHWQW01Zgwpexd6sKoUQhTEr/CvNGBRo6b1GP3kvZt8L
	9HQrmskQN06Fj6pAhNObsYsahTNHyLuY0Sfry5sdBVfVu2vxfYxUHKldHUMcXNRtEPgEDIdNH29
	uN8DyW+vul+ixqrq67KgELl+E1D63eW9IWcmtrjM2mMTB7SdZeoRVzKSq2/luxcx8XsRRJ7OssH
	BBizEhh2obWToR1M8q3gvA8sXlAL+3Aj/c7NTDBl17uwHUzQRreIDtKaDkM34rpUIRWLI4vfxNS
	Lju7hOiWr+SjPxoq7sobWM3mZRa8FcdoWFC6vaQ6CmP2CeJSqSOy3BgV+WdxwMKq5XFSLEhgnTs
	vsShaqLVl8mqDE/zqap1gQFuAirA==
X-Received: by 2002:a17:907:c70c:b0:b96:eb7e:bc55 with SMTP id a640c23a62f3a-b982f1edf01mr278179666b.10.1774025145822;
        Fri, 20 Mar 2026 09:45:45 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b98335f1747sm176730466b.33.2026.03.20.09.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 09:45:45 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Fri, 20 Mar 2026 18:45:37 +0200
Subject: [PATCH v6 2/8] iio: light: vcnl4000: sort includes by their name
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-vcnl4000-regulators-v6-2-0d24d20b1a5b@gmail.com>
References: <20260320-vcnl4000-regulators-v6-0-0d24d20b1a5b@gmail.com>
In-Reply-To: <20260320-vcnl4000-regulators-v6-0-0d24d20b1a5b@gmail.com>
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

