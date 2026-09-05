Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6830124A05D
	for <linux-iio@vger.kernel.org>; Sat,  5 Sep 2026 09:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788601046; cv=none; b=WJh+5BYWdaNCT0WcbodF7aMyDjXK73QNFwi7Z9FiaGRFpU6xdN7XKYyiGA8ktsYwzeDdfKzM8VojAQ3V+zUeRDAv708stVReQrYSVyqDkUkjIFfL3jzG0tn1TSNtYH1lWcGnS97QpocgpIzssJacz+3adi+bwzX3PWe0eP3J8BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788601046; c=relaxed/simple;
	bh=bgK+DZod7mmJgogZgW1zioKzetKNGqoKIW9z56Vpb+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UswacV91UdPDbE0adhOaLSZMDNzSFY2DXTIpYU6W1USvRDDqyiAd23Q5mIH6lYce9bTkTkXgi7SngOuh76EiZLoaWNhxttYs8uuxRiliPMss6gQ03xcn978378DpYfdAHSZjNNcfoeqUpEX2IevNLkuB5jAmcnDGyyNgWvT9miw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMkXDOnU; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMkXDOnU"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so1757487a91.2
        for <linux-iio@vger.kernel.org>; Sat, 05 Sep 2026 02:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788601045; x=1789205845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H2F/5Rn1z2wIFmLqiH74YcGVKvaBMa7CAe2jvYLlnR4=;
        b=bMkXDOnUhFY952NeJ7mzCCk5f1M5IfgmOHE19Fe+IcCesYYwXKAgt1XQWtuv1X6Frp
         l+srvH7ueIGWkqZ1dUigfw09Fhkrsfu0mBmMF5CTQtAcZher/hm4HhnjUYtduC2dtQOw
         wXgMd9afjuOQFxWu8DkGazMVbw1kUHq0DHUhAEkZfFln9lbwG4tsuUjnk3MBGYkOCRGM
         jumYEk8KHnqtaDttthoEJpMzmwypf12MDX7qluj4zteke2iegEq8CMD31U5zhWN1Ch6X
         6+SllM4rfA2mbxoylUpDiqfk8BUQeZ0rm4HMPEDZ1HpccePsrp0duON61KbT236gLIGP
         fKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788601045; x=1789205845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=H2F/5Rn1z2wIFmLqiH74YcGVKvaBMa7CAe2jvYLlnR4=;
        b=XL3+tx5aGWFOOAIA5z8tDK3gDJmEyr9lrUoCqk04BO8h5n2gjU5AQd4IhznvUuAer+
         QT0I3Fhs8F/CiYOIpkB/I7graTTX5RVb7/pFho8e4FImJpixIcwOYRnpLAKuTRORfp8D
         QPDEGM2aOm+9xkkbm4/wkzrID18qM1VwPs0/5yPp3qgA7kietqwz3wFBNHPOiTQrFAl4
         82mtl/e+CaQo+VEQklAp+Ks5mbBchURk2fRrjrcD39HBJG2VfhaNTUbsWnxPVzurj0R/
         N8h2qi7jdlaYT4hwIA5C6QuQHMuxtNWXj6AqbVZe+nB02y+ZnPUzkcFNGMGoTJElSJTb
         6w8g==
X-Forwarded-Encrypted: i=1; AKwUvBxm41/lig3i1Dj9D1AXBTz5o10ibjq+lK1wPrYu5vQ8YFSA272LJKc53gjVOX7b8lFRbbNdxn00j64=@vger.kernel.org
X-Gm-Message-State: AFuF++nZtH/+0LgPJmXDKwbzcpaLLMA6YqwEfS+5tP/lyhogQUB7zhVg
	olf3S39hB0Hhus1NujBVDgLva5HHj9EpuE2nYeiGzaEakTTjasykxB2d
X-Gm-Gg: AYBFou2bu/Knms4+Dj/l5dRlTOlnkXwku2Jw2GxiUANHiEP487Y6IhafVQGymjKkTHA
	Ls3iU/5XwAmQFPuBu/zxZWPJf/oqO0NsPTLSOqdrOTovuLewUKPLo77E+t1kdtKQVSezGXbCNeW
	rUqHMaA1m6EwfSeMF7V/KgyHzLn938k7jPktKg9BsgM1DkuK2oxbjpFlkbQeM2PwkX89R+DFaHj
	rY0zK37G89VNvz5jLkEeJeKGhqabExIVzJoFmguakJjQOnBHxz9uJvs59oGi5CGsn8zv6Q3uMD5
	ugNJU/7Wuye8G0/2phurjt1yIOpffxugWyhuLQTrGPHuObpv/MCT9m/tvWwdXHmAixGhNX5gDXj
	F4ojdKKiESFU0nXduAkL3fZ+CKlNLUGb0nfovgJjPP3fAjfNbpK5DvqBmhYIGNmCq5I6001p96z
	qtV2lvBokgIiF3Swun4UbdvVfiAXyBHA1LMeSZK/dEYQY3GS9V2s+5MPUQPg==
X-Received: by 2002:a17:90b:1e03:b0:398:b17b:3bd2 with SMTP id 98e67ed59e1d1-39b260dda6emr15831418a91.4.1788601044620;
        Sat, 05 Sep 2026 02:37:24 -0700 (PDT)
Received: from ubuntu.. ([2405:201:8026:213e:5b5:60e7:9f67:1689])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08d086adsm15763353a91.15.2026.09.05.02.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 02:37:24 -0700 (PDT)
From: mdshahid03@gmail.com
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohammad Shahid <mdshahid03@gmail.com>
Subject: [PATCH v3 1/6] iio: adc: bcm_iproc_adc: sort headers alphabetically
Date: Sat,  5 Sep 2026 15:06:26 +0530
Message-ID: <20260905093631.48667-2-mdshahid03@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260905093631.48667-1-mdshahid03@gmail.com>
References: <20260905093631.48667-1-mdshahid03@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Shahid <mdshahid03@gmail.com>

Sort the Linux kernel headers alphabetically to improve consistency
and make the include list easier to maintain.

Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
---
 drivers/iio/adc/bcm_iproc_adc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
index ab66b97d2f04..e46e3761993a 100644
--- a/drivers/iio/adc/bcm_iproc_adc.c
+++ b/drivers/iio/adc/bcm_iproc_adc.c
@@ -3,14 +3,14 @@
  * Copyright 2016 Broadcom
  */
 
-#include <linux/module.h>
-#include <linux/io.h>
 #include <linux/clk.h>
-#include <linux/mfd/syscon.h>
-#include <linux/regmap.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 
 #include <linux/iio/iio.h>
 
-- 
2.43.0

