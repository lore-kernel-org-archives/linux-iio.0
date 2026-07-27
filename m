Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17843CF67F
	for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 19:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785180093; cv=none; b=Vg/l5V/n9Fiq7z3w//zL7YuAKHHPKz9qJVQ09lJUQ8vCUJAHTqZyJBa9OkvqiTIjpdaGnAb8ULCl2XdvClMXJ/3cuUlMl3eTk1S72fp0J/ib0q6PU43/DPawkNxZTLOcFZEV2BycREoFpdiv0JrMPdzcM4e3eZ5A31t96jBoUik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785180093; c=relaxed/simple;
	bh=bB7cTFtQkA6GY2hg96XdtGA5bAmnXPgrq8JSiOvFnOM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cbuDBOMKbQMazSoaw6DJQXh3CrP3RxNw2MILy6t1aTVD15GFQyTOiR3xdS2zDB6qCVHeyGVFA2NXiCDUk5TH+60oFKcJQIENkJBFjgYT/mZAZ/Tl+mawqU/w4Co5elpRCwuAQOp98RweBT5md8fhNB5OPkENesDrpC0FRIqbj6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVBgNBUW; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVBgNBUW"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cf41bab353so43988395ad.0
        for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 12:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785180091; x=1785784891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wctmwy/+rV9SrvO63suyHx9jYj3uIcWMAuL/oEwqgBs=;
        b=TVBgNBUWbJ/SJCTKD6IVbq6oKN/9kYxV/GsIoCdVyPuYrM6PlaHQz1RpwiC1QEEryy
         F0vrRzg7wNjWhBoED10HfjIgvZgN7+N+lCZylXXEWENQW0YaZFLxo465OwGz+n0WpMU5
         BVarM3lN1HCCmd25ysZFHmnxv7flASIj6HKjcyADCIad96PiycV0GC6IXDzdqga0Hs8o
         TZr22rYwri2n+9RlOL9eZlWh4TSoinawYFcA5Dxk105lSts3p+6lQVCOpghwRlr2QgkK
         HnJNGMjzuTYURJZDcw1CA/qH3KYjBasG725TQeG22eEVSyOmKqTYxZcDh+R82/85bCJ0
         qdpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785180091; x=1785784891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wctmwy/+rV9SrvO63suyHx9jYj3uIcWMAuL/oEwqgBs=;
        b=V9KXu/lHCzexV1zT+Nf98h5NiG25J9wUVjxYmd8D+DoByrRFB+32CAdV2LaP9w4aD2
         0Y23mFBgn/xvuZbxaxuIDA8LhQRGIw4ANj9wc9184yBFVusTnn0yzzgT4uWOkH1i01Ew
         r/r96SQ6wx/pIvG5Y7JyA6Qp7dek7E4/CWKseLAK5n8N6XWIQvvgrfXHyFPF1nmxszSI
         P0BCPZiD0gRin8KcWCa/ImO/mrYKE3bf7MJ/vdddpum9odMdpv7kVrSkMPcEw6pOieDM
         hS0N22LmDsX1NgS3Bc2MSXopUvyMfp1Y5KyRNfgH+x9S4gvP8tZ1j4ZGUJ9A9BeiRZcU
         Y60w==
X-Forwarded-Encrypted: i=1; AHgh+RprM+8xP/nFHMe5kYNDMtgssxn4ICDWUD+cpBAk+qkbfgErJW/Fq46r5VzrmEeJ8Mew96hH7HuGFIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKzgnnljfMF0b4f2pFfDIr+uHW3JH1peh/WDfiGjK0eOZEbUVg
	HnFT7VUPP/f1oQ7mFCA6C+GzVvTC1m5HMn3WEYfG4LRvaxsSmFXCD6YS
X-Gm-Gg: AR+sD11ieovpFi1/d7hZBEKGA5PaeI7L8c3i4t68DFMCEHrUqr5FAQ/ixeSZdxwILJ0
	yhPvNtS559COH7Wx8eSGw2PaqKrBlv49/82QObU4MnWxrWIi5YgBJPGpZsqYkUUZoZzgXPNyWOQ
	6eFWN3JD9Ra7kPRBY8E8jpVIHL89nwVy7i2009jPrqyiWwPq4mw+M7ro8G3pEj4/0IGFZ0VFRcG
	6obIVkbzDFrzlQ5ZpFtsF/+2p6UqF1MhDJzCS6u0p78X9+MoChXZhzZUY8xh9PE4xeqjtX6EaI/
	O0XisZKeVPyHYDZmO7Z6aAMjvdOuDxnS1an7n7tVE9aRfT8gz0HwiNFpF1+6RV7HXKP89WId//R
	0tuLixr55WWvMyrMlkBI69DKKfqZpIbhNaAvwUXZFAB9J0he6D/eNB4gQhW4GBSJdeTNka0G7gW
	rkyc+WxDwI5zEDrFj3sscqWhlGet/syWmWORIxQbCkJl5dI5NRqiNf
X-Received: by 2002:a05:6a21:496:b0:3bf:e24e:3afe with SMTP id adf61e73a8af0-3c67e060010mr9471885637.43.1785180090860;
        Mon, 27 Jul 2026 12:21:30 -0700 (PDT)
Received: from debian.ari ([152.58.178.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc549b11sm37595470eec.18.2026.07.27.12.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 12:21:30 -0700 (PDT)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v2 3/6] iio: adc: ti-ads1015: sort headers alphabetically
Date: Tue, 28 Jul 2026 00:50:59 +0530
Message-Id: <20260727192102.37968-4-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260727192102.37968-1-architanant5@gmail.com>
References: <20260727192102.37968-1-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reorder include headers alphabetically to comply with the preferred
coding style and improve maintainability.

No functional changes.

Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ti-ads1015.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 3a14fdab56d8..293fdd49381f 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -11,24 +11,24 @@
  *	* 0x4B - ADDR connected to SCL
  */
 
-#include <linux/module.h>
 #include <linux/cleanup.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/irq.h>
-#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pm_runtime.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
-#include <linux/pm_runtime.h>
-#include <linux/mutex.h>
-#include <linux/delay.h>
 
+#include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
 #include <linux/iio/iio.h>
-#include <linux/iio/types.h>
 #include <linux/iio/sysfs.h>
-#include <linux/iio/events.h>
-#include <linux/iio/buffer.h>
-#include <linux/iio/triggered_buffer.h>
 #include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/types.h>
 
 #define ADS1015_DRV_NAME "ads1015"
 
-- 
2.39.5

