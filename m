Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE50C1A5B8B
	for <linux-iio@vger.kernel.org>; Sat, 21 Feb 2026 14:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771683184; cv=none; b=jNw1Nrabvj+CVo+hBnneSI560M2+lbno6dND1bZ/mQb9fRb9U3Hn5xTBFauGjwKu/9fPiLZ9LAbqI/g/NI5qn4KsJ5dNXOQYiYwNTFnnv3L10ZcDafkWrchUSKImEtcWo2rgI98i2xjz349UM98K6ZBgL5mvzsQcIbz+pNiGcM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771683184; c=relaxed/simple;
	bh=NIUoJr1XY5gdclV6RiHFGBT9P8aW+Ke2Acc0QjgcK1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UVSfglVvVFousiGx/fhyO0xkJ2LlMFKTMZMmE0FuYP+DmgdXtT3ngt09LZ242k03mX5MDut2J+QyOSraMTOiHh9Mq38wvfWqnKgwPubgrCfZwO4Cta4eC3tEW+ywepbYrx2lHCifBxbQR4BC9a68NV7i6uZhhoCL6N1K1aeRCeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/HR9H4T; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/HR9H4T"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4836f363ad2so31913355e9.1
        for <linux-iio@vger.kernel.org>; Sat, 21 Feb 2026 06:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771683181; x=1772287981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qaomPLaqyB2XegpBtyCcwnlVmceyjniRY76DonELa74=;
        b=f/HR9H4TRytclwOhPHDC+sydNGO0mbSRc0NzIVUYL5BktxHT/AJXziT+3dtTiib04b
         llWg2Gyb++WUlZb9RsMxW1ZRX/xeW2/ZZ/ZHOJ7fR7rPDCFLr+QXMctV1o985Zefsyh6
         Thmi0yxCgU0qsHm1W2xNr8XBmZDRguo5nKeY6ydBZXsRxJcmfGzsIZ76dcK7ss8aq3tN
         iYUV9YT3JMBgp2bDBPvGY1US8palIGJuA8FibS8NQRC/U9BpoD4at6RdMbjcHg6Jaqy9
         66yfNPtiGJmY6DwC3q42m3yIg9Wb3I4cmbf5FHgiGsTj3bamuPmCNfLPhxfjjpNc4aMS
         eLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771683181; x=1772287981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qaomPLaqyB2XegpBtyCcwnlVmceyjniRY76DonELa74=;
        b=gopYDP8yf0kypTaRq+7i2gpjXJS8irzghhO/gnGpmOwskMA+ZVjDT/Hr9Btlbc2Sk0
         fpN2MqXAMcoY+fpF5179SdXQ1RORipLJQqcmsJdG64Ihy19wWApPoZPLusqNiwlVn+pt
         bFe18lqKPhTH0P9/+ZUQFJ3RePb3zp+mTG/fpIBhuty7fz6OBXEL1PEr3nFeuEwguKVJ
         zi/KvGHDrY7qoeDgQzTcIu6RstyN4b+h3qns/37JpF8O9H9UeJ3I/8UcT+Qd6n8j6u1x
         XN7h2z+t1PDR5Xc+QKMn+ZTdH0OXb9m2JjEaE6YGVVhs1t8G/rg17k5PPTChS1bLA4UW
         qkyw==
X-Gm-Message-State: AOJu0YwfoFLMYe3tcHZWcuGLeMXw/uxyQqeYjKl6LAgEUaq8hxj/htOr
	JPPPstiq6nHA3L8HD8UTTOoMQwgO3m6FPuulY4vdh2oDbYsNJXMldACjyYx4LsmC
X-Gm-Gg: AZuq6aJes1e3ndfDwiuci+wg+F/Uy+84xqB0rW2T5Fg7ORfiNv/3NdZ8tJQFfTRcSr4
	8/RAbAfMhztJmhXGpwoo219kktZR7imAbHx2mBrMC2RWHfDFwdgErp+Jd8aGn2wIbyxFB5/9dBp
	w+hg+hxzVb+8r9PVTdRtEz3vm9BwVB5qknf2SShSmk05cXHG5QXf6mEjv17dR89WD48XFn1cQKr
	qzgD4MS+EfHyQjzGlavFuFv6bvnORDEhnpbe0WIeJCiy5x9Uc1Yj+05tytbU6ODyaW2qj1BRQ1A
	sPQW1Y/1PED0tr2nrJ1ekFMi9hnwowkt5B5eOZqxRFOUnJqgckPuigRdu9Iq3sHi0MRI2RrvGqE
	aII0cOcOdTvMo1ua37mFAx/MCE4PdCWaZSCQucGz8Xb0WhWBlLQsgMaueEpstYvtTaE1UlxOw2P
	SuKhEmoRIQ1be9JcllJkWs/et/O70gOroyAD0nbkPU8LGbgs6TH6TbDzPLoESPQh9rHeeYsrdb
X-Received: by 2002:a05:600c:45ce:b0:477:93f7:bbc5 with SMTP id 5b1f17b1804b1-483a95b5835mr47780805e9.10.1771683180862;
        Sat, 21 Feb 2026 06:13:00 -0800 (PST)
Received: from db07.1337.ma ([197.230.240.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a3e01c27sm50169825e9.9.2026.02.21.06.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 06:13:00 -0800 (PST)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: linux-iio@vger.kernel.org,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	rdunlap@infradead.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees-archive@lists.linuxfoundation.org,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Taha Ed-Dafili <0rayn.dev@gmail.com>
Subject: [PATCH v4 0/4] iio: accel: adxl345: Implement event scaling and ABI compliance
Date: Sat, 21 Feb 2026 14:12:43 +0000
Message-ID: <20260221141251.34855-1-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series addresses ADXL345 driver non-compliance with the IIO ABI for
event thresholds.

Currently, the driver exposes raw values for thresholds
(e.g., tap, activity) without providing the necessary scale factor to
convert them to SI units (m/s^2), as mandated by the ABI.

This series implements `IIO_EV_INFO_SCALE` in the IIO core and applies it
to the ADXL345 driver, ensuring that userspace can correctly interpret
threshold values. It also cleans up existing documentation errors and
typos.

Changes in v4:
- Patch 3: Fix missing IIO_EV_INFO_SCALE handling for MAG/MAG_ADAPTIVE
  events by moving the check to the top of adxl345_read_event_value().
- Patch 3: Explicitly reject writes to IIO_EV_INFO_SCALE with -EINVAL.
- Patch 3: Fix bitmask ordering and whitespace alignment in event spec
  arrays.
- Patch 4: Update documentation table with the exact sysfs scale
  attributes generated by the IIO core.
- Patch 4: Sort the entire event attribute table alphabetically
  (David Lechner).

Changes in v3:
- Patch 1: Revert "axis" to "axes" in documentation.
- Patch 2: Reword commit message to "Implement support for".
- Patch 4: Remove repetitive scale values from every table row.
- Patch 4: Fix typo in commit message.

Changes in v2:
- Add core infrastructure for IIO_EV_INFO_SCALE.
- Implement event scaling (0.612915 m/s^2) for ADXL345.
- Fix technical math and decimal errors in documentation.
- Clean up grammar and pluralization in .rst file.

I would like to thank Jonathan Cameron for catching the missing MAG scale
handling via static analysis, David Lechner for the alphabetical and
bitmask ordering feedback, and Andy Shevchenko and Randy Dunlap for
catching the whitespace inconsistencies.

Taha Ed-Dafili (4):
  docs: iio: adxl345: fix typos and grammar
  iio: core: Add IIO_EV_INFO_SCALE to event info
  iio: accel: adxl345: Implement event scaling for ABI compliance
  docs: iio: adxl345: update math and examples for scaling

 Documentation/iio/adxl345.rst    | 79 ++++++++++++++++++++------------
 drivers/iio/accel/adxl345_core.c | 37 ++++++++++-----
 drivers/iio/industrialio-event.c |  1 +
 include/linux/iio/types.h        |  1 +
 4 files changed, 78 insertions(+), 40 deletions(-)

-- 
2.47.3

