Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E4C16DEB1
	for <linux-iio@vger.kernel.org>; Sat, 15 Aug 2026 18:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786818469; cv=none; b=Uobm9P2IDb9AhfmGjrhYu+W5rE+8kMY15CL603XV+6jrqbPMjyojtJf8N8rmbg4aXHR0m0yVA7Ew0NOMZsutKa5/toLGub7pJ3A/P9tjkt5xDEJMLNBcRMjUS4fPj7zI5nwAxg6EGSdGqoJEvIA2fw0MsfPoqLH3IfaK8eGgbUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786818469; c=relaxed/simple;
	bh=e7aY8RoBsrWBG6a9U6OMT5zRTLoJdj0QhzWlYzdSrq4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XbzqK7Ns/wnhOBcjCWNk+QhDPRGhbi2M/u5oLKzV+pa61Zf875s5SQLBk1TCn+jow0Oab9O3g216ZAdFnzJfN+YtoA3jy03YD7yX7oJ2H4sCBCpB7BEvvZrkmvq2lUNf98nLHKY2TRxf0+ydb/NnzEnhNHQzfOn/U7pbfb08eZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2sX9d3u; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2sX9d3u"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-836c718715fso24943587b3.0
        for <linux-iio@vger.kernel.org>; Sat, 15 Aug 2026 11:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786818467; x=1787423267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=T/buIIFnv6/D7oLvzCykrE1/BtlNbe9gyY08m7xmYoo=;
        b=L2sX9d3uy8/pryu9/EWshe0KvjkonBpWZ3ak6im/VNhIIsofz72WoeUYszHw4zg0oR
         XsD8Nr5+35h9EItaYtQns9n6Lm7R34JYNqf0/53rJtH89BPiaDMgr2ABdd1ujlETjdId
         P3VbA7OgPottaeOHgfwVDlt3YU9+g/PeHizlN8DXo9oJSiopbgRvoShJz9R9oK74FZGf
         v0nTZ5xIPcWUpnozLa/tXZuNR04q9lhw4aVisYbp/DUAsnhlmrzOWtGvo7Cx7YmT4Ocl
         4E/522802COKFg+20xway4npz7x5Qnd1O1WALI/4U2HO0516Ms7Q/ftoMVuy6/jLeXzi
         N1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786818467; x=1787423267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T/buIIFnv6/D7oLvzCykrE1/BtlNbe9gyY08m7xmYoo=;
        b=MP7hqmFqNMXtNJAUBV6Px+0Jaq4r6PmLYYgDZH3bVUwv5UTVOUP4mIIGTrc374NJbI
         a4yCIDHp5L9oFlH4jlSXTQZN21u1p/EIx9dHIDejtsbXDlk+ujagU4K7f5T3FYbJuzZP
         iOIWljOLoTc1wd60CVnAVzZjLQO3m1kXDrdS660tz8MkZ7mZhOQTyqWjanxtpxerHYeK
         DAbO87wIZxxaIDG8UYOp2h/QKLczLGjObzD3lzI8Yh0E1QxJK4f7cT9NZ0/pS6kFkSHB
         3S4LGZ60ul/WM4HCsGF/LAi0DyAQl9tIJoWQ2kJaRRQk1k57rMjc+Ade8lky5a+8Ztu7
         NJTg==
X-Forwarded-Encrypted: i=1; AHgh+RqQd6JH5hhvD4IdOD4AmJj3pDm/STx5cnFMn3JE2ef62RMvGN0lYhZMsos8ggQepdZUaioY0QcxUSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOTc0kJci0gs6BfAr22S74Cgb29V5AbJ5BJu6ZXF0rKO6wicZA
	Ppu+n6My68FMB3cM9VnxlbSZvpE6CM8B2dvRxjXuacATdY/I69sJvIo=
X-Gm-Gg: AR+sD12PfmNxNNT7MBiMRwYkNCs05XIZQePSOb+PgjASBqT6aTmXMLjxU8MnORcROsb
	W9sJSVu9ja9BRsU+Dm9VLEWPGUptNo1GsIfFF6JJVOQZoy8/nLWiagDtqpm+NCjAisSCCvLOFG/
	4HSa8rR3o88pLEQtGHn7d4b8mrEtUE86Pk2xvSozni/3B+379FLZMn6DVGyHSVvuYx6EP4+Txhm
	Hcb9AJglk2fWAGizcDqEBW7NrpEitUBijG6bFa0gbhNSjtMa4Wz1ciTyYUScfpDlGjbKGZGnCG7
	cvb0BIbrwYu6Y0zd0RitQvVtSYJWL37aWT3byYztXoC4IEophfH8ppu3m6Iu1o8fivFY9ffKaX8
	v48f4IgQO6eVdz+UEK01ToGk9SWSehA5/uMQD9Zm9kj87z0P0t3igkyniUeX5WzIALUHC6MLkZA
	QoqhKsiKS7728JboBTEDYStPy33JMoF9yZqhekQUhso7m1P3ydHc8sEHibNxb9daPhRToJyUNaA
	/PoArfWIngsqDhtyQHMuHZkTl4jzQ==
X-Received: by 2002:a05:690e:150e:b0:66c:484c:867f with SMTP id 956f58d0204a3-66c72d2c9d0mr4859747d50.45.1786818466646;
        Sat, 15 Aug 2026 11:27:46 -0700 (PDT)
Received: from daffodil.tailc06997.ts.net ([163.152.162.75])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66c75c5dd24sm2598154d50.6.2026.08.15.11.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 11:27:45 -0700 (PDT)
From: Arka Mondal <arkamondalofficial@gmail.com>
To: jic23@kernel.org,
	Michael.Hennerich@analog.com,
	nuno.sa@analog.com
Cc: andy@kernel.org,
	andriy.shevchenko@intel.com,
	dlechner@baylibre.com,
	rohitsarkar5398@gmail.com,
	venkat.prashanth2498@gmail.com,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arka Mondal <arkamondalofficial@gmail.com>
Subject: [PATCH v2 0/3] iio: adis: fix unprotected debugfs reads
Date: Sun, 16 Aug 2026 03:27:23 +0900
Message-ID: <20260815182726.11796-1-arkamondalofficial@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Four open coded file operations in three ADIS drivers are passed to
debugfs_create_file_unsafe(). None of them call debugfs_file_get(), so
debugfs_remove_recursive() does not wait for a read in progress and
unbind frees the iio_dev underneath it.

Andy Shevchenko <andriy.shevchenko@intel.com> asked on v1 whether these
could use DEFINE_DEBUGFS_ATTRIBUTE() instead. They cannot, as it formats
a single u64, and these handlers print up to four registers, e.g.
"%.4x%.4x%.4x-%.4x" in adis16136. Converting them would change what the
files return.

adis16475 and adis16550 already split this way, using
debugfs_create_file() for their open coded firmware files and
debugfs_create_file_unsafe() only for the DEFINE_DEBUGFS_ATTRIBUTE ones.
This does the same for adis16480, adis16400 and adis16136.

Compile tested only; no ADIS hardware available.

Changes since v1:
1. patch 2: changelog rewritten to explain why serial_number cannot use
   DEFINE_DEBUGFS_ATTRIBUTE(). Code unchanged.
2. patches 1 and 3: unchanged, Reviewed-by added.

Link to v1:
https://lore.kernel.org/r/20260814090728.965922-1-arkamondalofficial@gmail.com

Arka Mondal (3):
  iio: imu: adis16480: fix unprotected debugfs reads
  iio: imu: adis16400: fix unprotected debugfs reads
  iio: gyro: adis16136: fix unprotected debugfs reads

 drivers/iio/gyro/adis16136.c | 2 +-
 drivers/iio/imu/adis16400.c  | 2 +-
 drivers/iio/imu/adis16480.c  | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)


base-commit: 3d6d817622b0a9721e3cc404df3469171582be13
-- 
2.55.0

