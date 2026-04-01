Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1203F8DEC
	for <linux-iio@vger.kernel.org>; Wed,  1 Apr 2026 16:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775060751; cv=none; b=SuAAEJdOwApwTIaurNWryKuuAt8FoTNVh0ODKQS5vT11X/dhkvGHRVan/fsjj4yW013qsjJDlsIRzVAv87aQDZVh0sE8s6cNovfu0Ho14DjWqU5PNOy/T81jvGwGHDhJO6b0HGkA2y4IUioPjfJCGZMenT9V2nyCuZr22Q2XFZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775060751; c=relaxed/simple;
	bh=8dXLQMW8sVIcuzDqL6BA+V3ONKfbGvxIejWx1vqWCqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J1MbUngwKW1ZZUbS/OYsZSZUpOvT7ipzV3qh4tM2wCQo+Jnh4bO2jgvtyyFNTw6hGWXlVxNaqHBHVSsi59CibxU2fWsUvNmZoVryghkjdRA8llSCCqK8+f3APQWkeuN7T5MlzwUtoVzj2kWBRl97SerqLE30ldQtfVKKjvLnPWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mirrorstack.ai; spf=none smtp.mailfrom=mirrorstack.ai; dkim=pass (2048-bit key) header.d=mirrorstack-ai.20230601.gappssmtp.com header.i=@mirrorstack-ai.20230601.gappssmtp.com header.b=qD7jEojr; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mirrorstack.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mirrorstack.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mirrorstack-ai.20230601.gappssmtp.com header.i=@mirrorstack-ai.20230601.gappssmtp.com header.b="qD7jEojr"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35da9692ec3so3063845a91.1
        for <linux-iio@vger.kernel.org>; Wed, 01 Apr 2026 09:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mirrorstack-ai.20230601.gappssmtp.com; s=20230601; t=1775060746; x=1775665546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYbjRDMYvPXm7PwKTidWBLBGSVwyNzNOx/MgyeEmpgE=;
        b=qD7jEojremObzSB6ufDiJ2ljuL1Am72xsEl5c20ThlHvZ17AuVapEEzS5FH9TZU783
         h3HmDUl9OJfvvsQ8ydUgKGlfbjYTHiJ1TizYvq+LwOq/7aIUUq3MSNrfAkyVz8L/Kp27
         nEDUQ+7Ztdauc6aLIHJO0F5r7TB59r9JXr9fr0jmZulJilEQ8dpIOsFVhYkfsmVEB6oj
         cWBSNXpSkiuJZ0AxX/y7Mba1MlWMbkmBDYAICEc69hL5Eu8X1uNAyI221fUJ1vffvBwe
         zPynoWFF5dvPn168ucoPEFsFiZVgoUOHBKLdDbFmVSdqi8TntL3FX3yFOyGyTG7ZxcVl
         Tetw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775060746; x=1775665546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WYbjRDMYvPXm7PwKTidWBLBGSVwyNzNOx/MgyeEmpgE=;
        b=tXd/JhCOBgBxdMbK7YjI0aTT98/2NbFPJWt9/cxlcxKGHBr4NdQ4MdZRpByA77zqt9
         JQe3J+fmeHTfFJfHtwLUw+NhS2PeoBI6KdzlyIi7sQaGhS5j+uDlkovd/3GnZ9cCGohE
         PRHhSGzc0Zbaqon2z8iK7dMYUHDgBzYYP2Z56m7Jvh+5KijFc40oKJcBAjIpisoZc57v
         5zk4BczwARo+as3cg+uHdjpaWs3TtApilMkTJ2BdFvT44SOYRV8Hz74Vq/rp6yNwv821
         +3ScrftKr79N2ZqVELvYLRdNvySB9Mbpw+aRGFNdi7fyF6qd2BnQXrQ8rldI3fiPx+Cj
         dhcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlEZGIlGpZPsUUQb88RSLaM3CvauU29U1c88beVc82GJB7I+uNwr7vvaUJoiHZ0JkxDExgxO9+lS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGm6YrJ3UiVXVNJ56cd5D+OmUhv2M+/NznllUK0LVJoshf6Ijw
	GP/mCtwnVy/1lXA7zTnlOqymbpk+awwYrIHR6599g8eJRkD4Kq6fLA0SRYr4Pb9Vhs4+
X-Gm-Gg: ATEYQzzLnC7MUtPe068zZv8y7ifwxjvt6eEfhy0VrjN4Fw39HOScDlNFhxvhMImFTe5
	2ZHjgn0YUkL41ChHVihXdZjlAysgJq36Vf8Gspcz9OR+oq1YCb1WPrPG+CknKhf6tHDplIDqk2w
	pRTNSt5THWHGExUoAUMbhq118QBWGEdAtxoPaXkWvZuzH3SydAlB/p8AjQw169wgoiyXT/Ic6E/
	0xf11m/+wfx27147D1fAmwo72V6/c34Yj2zw9aHpsi3O9ijM1rdy2OxuPHiHnVNQ87zavTt1GYe
	XLOLzsgdRGC2ivrzEkDr/0/P4MvrHYm3e/H+CbFtPzrvAtt9+9vlNvGdo30I7UVE3IoaqWwukfG
	Qi/nc5agO0JjDshnOx5g34H1S43YPBl4yh5r06IxIzzJbj7d4mhJWezUeJ5ggERzJnszQlkvPQT
	Kc7K8YFxmVmb/plD45KJ/wZ8kTvMmWrXcLNY9inLRdwxaVJR1eQIbx2RxvMOvP6qLf/ZYdGhvX5
	nDoq9DEGAVbaUnlizha66/qKdKcw8/ApRDWoz8Zmg==
X-Received: by 2002:a17:90b:5107:b0:359:f3b1:6811 with SMTP id 98e67ed59e1d1-35dc6e77e5dmr3618101a91.1.1775060746179;
        Wed, 01 Apr 2026 09:25:46 -0700 (PDT)
Received: from ip-172-26-8-186.ap-northeast-1.compute.internal ([2406:da14:e8:bc00:e546:17ee:7142:6d05])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dd35e34eesm281813a91.2.2026.04.01.09.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 09:25:45 -0700 (PDT)
From: Sheng Kun Chang <nothingchang@mirrorstack.ai>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	gregkh@linuxfoundation.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sheng Kun Chang <nothingchang@mirrorstack.ai>
Subject: [PATCH 2/3] staging: iio: adis16203: align MODULE_LICENSE with SPDX identifier
Date: Wed,  1 Apr 2026 16:24:56 +0000
Message-ID: <20260401162458.88110-3-nothingchang@mirrorstack.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260401162458.88110-1-nothingchang@mirrorstack.ai>
References: <20260401162458.88110-1-nothingchang@mirrorstack.ai>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SPDX license identifier is GPL-2.0+ (GPL v2 or later) but
MODULE_LICENSE was set to "GPL v2" which indicates GPL v2 only.
Change to "GPL" which means GPL v2 or later, matching the SPDX
header.

Signed-off-by: Sheng Kun Chang <nothingchang@mirrorstack.ai>
---
 drivers/staging/iio/accel/adis16203.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
index 830ff38fd..0ea127c9c 100644
--- a/drivers/staging/iio/accel/adis16203.c
+++ b/drivers/staging/iio/accel/adis16203.c
@@ -310,6 +310,6 @@ module_spi_driver(adis16203_driver);
 
 MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
 MODULE_DESCRIPTION("Analog Devices ADIS16203 Programmable 360 Degrees Inclinometer");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
 MODULE_ALIAS("spi:adis16203");
 MODULE_IMPORT_NS("IIO_ADISLIB");
-- 
2.43.0

