Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B49847D455
	for <linux-iio@vger.kernel.org>; Sat, 12 Sep 2026 13:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789219554; cv=none; b=XuwGPowXo6RFIoZKeZHHBbBh2Gx3Zv1Gp2lZssnCvm6zZZ2ht0evADUuftd6oEhU1mGgcpsyAXdnNAymKUPjBUc7qE7/WC8nb2eCaRdoSG5K6lziG2Ixd/PLMylpZJulpNLRtVBarRYLifqfV3jb12R8f9Tlcrpe2axriU8u/hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789219554; c=relaxed/simple;
	bh=wFxXi8Z9WcIxFPd9fUaEH26jlrgztUaT4NJh8D572Es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iOucwF5/jSVeUhIBz/uxFgkLZCKXW+38Kn7OKwxK/EWiuplNkitvxdCfm9BOv07JVhlc183vywtSx2Y+ZYDpmYX6m76zL2hlxNdBfp87dRUQEfPSS1e72L9CPteD7wJh17d0tSyzohlKXor8wXP9Ag850HWbc+A0SwUk4S8HIBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etBpPYNs; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etBpPYNs"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b965f447cso3509665e9.3
        for <linux-iio@vger.kernel.org>; Sat, 12 Sep 2026 06:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789219551; x=1789824351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PW1ixTgxWimSTTjdthxgReSlmPLPKmDhq2QrwAvzdaI=;
        b=etBpPYNsF/ubdtDNby7KvNJx4F4IVT3PgBg1+ROGg9f6I/4V8iNYgW/80tykxUlsx+
         Is2mrQtMHaDIqXW/otcaB+DbECqTnmeZpBWr35EXK5k6XJhhe6DY2eZllCleCn08t/mA
         cgdIhgrVMAjrxXhxyQSMF4Z/ZOIyWY/BsKUtfJZC8G1V8VeOkYT0oNs4tjFmwM4/kFca
         IP1I6Rq4NwrkoOvP6t6Ryb/zqZG3NUyHJhkm+f8tIrr+QULvX536+uFY1y9N5ly4qYyO
         EZjplgXbMH/R9+T/TuYb0wdFvkBRZqy1aiwRBdyNE9NjBr/Fkgy2+QXap75oGDw4lxOi
         cy9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789219551; x=1789824351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PW1ixTgxWimSTTjdthxgReSlmPLPKmDhq2QrwAvzdaI=;
        b=hjawrQFwU/+nk9ac1hCkuNe0cJyGHbckj1vgEDSa7hxm+FIoK1fti9Rd+AONmHHrmi
         u4Zwlz8wE5useF4MtDzYxqMk4WUqZh/Djhiac8T/vqjfvn0yWQ0b3e5eWQtZ7YaavC2l
         39pmzWhw+kNjKASPqLPRjfCjRGBqFgIouoL/rtF2QnOp04sOz1quioE9KnS2xDQtmCfY
         BHCLaSXZ5a8zazN8ylUOdOLANoueJnDBeJKOEnAsqDf2Hm6Q5Nv6byNtG3//W4NbAbiA
         mEyV5foUzzqx8t2i5kS1rLLKNi5j4yi2hVKXUNmv9q1798y4T1qk2KEao4allOwuq5Qv
         i9Iw==
X-Forwarded-Encrypted: i=1; AKwUvBxCkfgFars9HxKoRbp4CDQyXMUWXDDTpvnI56RtWA5IRDN43S3b0oZdcJmkRxsEcluwGKoV2EcxpBg=@vger.kernel.org
X-Gm-Message-State: AFuF++nTQbPl1rb9JT/QLtTBK9U6vJc0/H5EW7Rdjgu2u7016CO84vnF
	76TeBDdn7A/s6k/VvvjpgUW1q6VSk/7HLOM8bvnPT4Xc8bjmp55qCBaS
X-Gm-Gg: AYBFou07ny6ibYqLaF516hpdRjEkjvyqoif6eMNFNKHVpuSCTH47O/4n5fOQZN0USEn
	WCtSYFs8VFmhf/PEnWNin6DUnHtwIpfiOvV21xmslySNRrzNqe/Zw9Udc0B+Ux9W1BnpOh5KOwe
	LGX013BNHBHv2RWI5rSRFNynlbzpOEG+1BNfeS4JGCnZkGK7hZiwmbvQ9qUrCXcJodV3H8iYlEC
	/KfaksegxPzuAm79DsRLETXw30d94pNxY2OpB2XiouuP8PnFDbMXw4ZVdmyz2bJTgj4WyFw3a9n
	Tb+ONQ+BU4rezecoXy+pntIVWBoOQqsDOt28tJFAK2Mun83LCLf5rq1YZBV/dmxZwauB/vdKYC8
	mhfrluDPrJbzLcBeEBMBlcrm9YicLdgFvYisb6qeW0KeBJjvo+bB49A2tuSZRALg4KuGGEyvS5L
	lPrVAqz82g708ZOaJf1adJOwhj4X1CoVPbVFL0p1tnSU/RBFz2qzbz8RRxR078XJyG5FuMI3VJJ
	OAS9HV/5G+bFl/Pwg==
X-Received: by 2002:a05:600c:19c9:b0:49e:6683:d23c with SMTP id 5b1f17b1804b1-49e6ca4003cmr24788655e9.0.1789219551327;
        Sat, 12 Sep 2026 06:25:51 -0700 (PDT)
Received: from fedora ([154.182.88.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb33ee8bsm12684503f8f.15.2026.09.12.06.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 06:25:50 -0700 (PDT)
From: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
To: jic23@kernel.org,
	gregkh@linuxfoundation.org,
	nuno.sa@analog.com,
	Michael.Hennerich@analog.com
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	joshua.crofts1@gmail.com,
	Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Subject: [PATCH v6 1/3] staging: iio: adc: ad7816: Sort headers alphabetically
Date: Sat, 12 Sep 2026 16:25:15 +0300
Message-ID: <20260912132517.55686-2-abdelnasserhussein11@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260912132517.55686-1-abdelnasserhussein11@gmail.com>
References: <20260912132517.55686-1-abdelnasserhussein11@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sort the include directives alphabetically to improve readability and
maintainability. This is a precursor cleanup patch to prepare for the
addition of new headers in subsequent changes.

Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
---
 drivers/staging/iio/adc/ad7816.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 30644d2d7c54..9e43ce83e071 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -5,19 +5,19 @@
  * Copyright 2010 Analog Devices Inc.
  */
 
-#include <linux/interrupt.h>
-#include <linux/gpio/consumer.h>
 #include <linux/device.h>
+#include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
 #include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/sysfs.h>
 #include <linux/list.h>
-#include <linux/spi/spi.h>
 #include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
+#include <linux/sysfs.h>
 
+#include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-#include <linux/iio/events.h>
 
 /*
  * AD7816 config masks
-- 
2.54.0

