Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B4E421247
	for <linux-iio@vger.kernel.org>; Sat, 15 Aug 2026 17:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786816658; cv=none; b=U3ZSxPf9nsy/Ah8T1ZlQORRCuSIkrSm1rnmkFqFhV2vQFF7po7sbDasizHTab3PDJ6MlOikdcvv+lKW6rWAYkSwMoGa7g6EGNahzCbN53gIHE4kkjnsoeHZtoXrPuSTfPelvDyPj2JJ7HlZYE+cpPzn5fK13hfNCmvnffLvoaEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786816658; c=relaxed/simple;
	bh=AeUWK9KTNL9iOk0hdKtVrjRhS3S61rLqS2g0KoG6Huo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xl/mHpIUKTcBjFQNKPc47VIh5HvwCc/QAlGmmuq17+NPfdZVZ1suGdl4qcRpOQdR9CNL/87CibV+QsmllvBVGzM5E+Z8DvphnOPxYLIaJRcdNwvJYbXxYYlo6qvpoqn9r564zV9VkRa62mc3DZR5i/H9vsdsRETTrPgcoluOUIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ss+uj1FT; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ss+uj1FT"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ce7d2adef4so34842195ad.3
        for <linux-iio@vger.kernel.org>; Sat, 15 Aug 2026 10:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786816656; x=1787421456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AehCQZa2iclY84/hbLMAU5UmVBAWJJzCqw3aMGV9CYw=;
        b=ss+uj1FTONunp6+ppJv6wowJWG6DVtFZcfwPeAA/WW4I8jFFu1XN+xgrcWYWE7ptxO
         8uV0lu+hh2YIfnIW/3gad8S/xBhgmngyCmeM/HT6xgJ1oaH+PSFM+PWM3oOjAqwQUfri
         iL/sv4TQxuiMInYqC396IyENK3UT8/MXg5/7pKdkAnJ6J5nG0XrwAHL8W6Rt8ChzFzlP
         BrU8kT22zMOsCsRcCwBPieJbyxPbdgQ5Y0YZ1a+YlivQdcoZX195X28VcyEj48Km/gwN
         n8VMmS1PjK4ZFsx6Celh+02jTWuYuJMVWKubJgo6xSOkq0fXCe/hpflithTt4dirkFMo
         Ou1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786816656; x=1787421456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AehCQZa2iclY84/hbLMAU5UmVBAWJJzCqw3aMGV9CYw=;
        b=nh0H2KPYCjKGZVdc1hoaXKi5Kj4Rl2k4wngUWTCdsl1K1m4pR9348PbOqgU7ZJ5KP+
         tmBZq/MfkGS//QZv3OiKKJdNdjQpnOCbCMmqNmMA/0LEgZs/UmTVwdhD9Q7TXYLBfY7/
         9XqU5uS9f1my10KGc4v8IKhWv4zX7PVPDzV7+hUiP5jc4plq9TLnMQBq+4HPCasRc8ty
         1b4ACImvxkNaOUCdCQU5uYru0WqcmkQstI6Wu3Ea32U0F/FlJTiFVOGwCFBm8Q2uiKq6
         ZCqX8k0Yj15pEXpx4rFuiJQsfbGu+vAWfSf2O7BjVeSpz352HgL5sV0ieFctTt9Q+lSL
         wnIw==
X-Forwarded-Encrypted: i=1; AHgh+RrbWb1W6fTt0abTnDIElry6wApqViQWoEJJSUTX6z/5Q91fApj3suOcrixAie4MG7/VrQ59KWOdjws=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyit4LyI+rxdJmABlmmUJsA1BB3m0YtTECt3U+usKGQM7SmumGY
	pfJ62RS5WWvZ/BaHGAkFcVgA5KeoTf6r4KySivmX5+3hue7/2e8VLDpdvs7VcimP
X-Gm-Gg: AR+sD13U1kHZVJLt2dXPPSIVC0SCE43c9MwHvrc/liaszLYHd+qhWTEi6VWFxmL5576
	Krgb9LtzYso9n/tQjL981VfUTk7WNTrra9bMapkfEu4iAyXDrNQ5oKCBki1Q/jxhYOywOemnfws
	ucabEYGhNr1AARkp7zOZG3Ldo+rVEPoTI91qzicZCTpQKyQz0oIiIagJepN7tfqqmtOvZB3UUxt
	LFHED1H9W+0lUryzcLNWC3Aec/eC7RPXeWlgZSiYcyBsfYKNjNbOlK7f6wO5jlv1bDZ5ppyGYyj
	rNKi0vhtJZrsDyRqNQJbaXSA5WzrQO5fv9KTYMXRxbL78O0FaPnVTdCPqnnPVW+LtAtSj66hkwI
	pvQUM8op85X91MWLxpfDYf5+LnRgdtS6WYZ9BccKduTq43BeCv+5uXPiMMY2RVtDtpzKY4MiANL
	E8UTO1UPE01hfuj46gn//yLIoqtWRs1L5NvP1rAFVYShwXD7rEUqG87pvYe6jOeVNmJ5zfenhJi
	9pRW+r0
X-Received: by 2002:a17:90b:1c0a:b0:38a:c3f:3b87 with SMTP id 98e67ed59e1d1-3933b8721acmr13531166a91.12.1786816656373;
        Sat, 15 Aug 2026 10:57:36 -0700 (PDT)
Received: from yash-Bravo-15-B5DD.. ([2409:40d4:1248:1816:fcb7:1765:17f9:b9a5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320ea2fcfb8sm17305163eec.21.2026.08.15.10.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 10:57:36 -0700 (PDT)
From: Yash Suthar <yashsuthar983@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	andriy.shevchenko@intel.com,
	yashsuthar983@gmail.com,
	grondon@gmail.com,
	linusw@kernel.org,
	hexlabsecurity@proton.me,
	sakari.ailus@linux.intel.com,
	srinivas.pandruvada@linux.intel.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] iio: accel: bmc150: DMA-safe buffers and use iio_push_to_buffers_with_ts()
Date: Sat, 15 Aug 2026 23:27:25 +0530
Message-ID: <20260815175728.99541-1-yashsuthar983@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The trigger path used a plain s16 buffer while the FIFO path already had
a properly typed scan member (__le16 + aligned timestamp). Those two
buffers did the same job, and s16 does not represent little-endian data.
Drop the duplicate, keep scan at the end of struct bmc150_accel_data with
IIO_DMA_MINALIGN, and use it for both the trigger and FIFO paths.

The FIFO and read_raw buffers are passed to regmap bulk/raw reads, which
is not DMA-safe. Move them into struct bmc150_accel_data after scan and
aligned to IIO_DMA_MINALIGN.

Finally, replace the deprecated iio_push_to_buffers_with_timestamp() with
iio_push_to_buffers_with_ts() so the push sites pass an explicit buffer
size.

This supersedes the earlier standalone patches:
Link: https://lore.kernel.org/linux-iio/20260808220236.421832-1-yashsuthar983@gmail.com/
Link: https://lore.kernel.org/linux-iio/20260809111303.496393-1-yashsuthar983@gmail.com/

Link to v1: https://lore.kernel.org/all/20260814101845.301769-1-yashsuthar983@gmail.com/

Changes in v2:
- patch 1: restore early error check flow
- patch 2: keep fifo_buff declaration in one line

Yash Suthar (3):
  iio: accel: bmc150: use aligned scan buffer for both trigger and fifo
  iio: accel: bmc150: use DMA-safe buffers for regmap bulk reads
  iio: accel: bmc150: use iio_push_to_buffers_with_ts()

 drivers/iio/accel/bmc150-accel-core.c | 24 +++++++++++-------------
 drivers/iio/accel/bmc150-accel.h      | 19 ++++++++++---------
 2 files changed, 21 insertions(+), 22 deletions(-)

-- 
2.43.0

