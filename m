Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155E83E49DE
	for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2026 08:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787647931; cv=none; b=q35gDlSEPK4a1jw1qJJ/2qFSEKGz8rAioWDvwhQLvM8tx8/V1U+wHTEf8sOZlY6JcWW6M8/MxEkBmAg/VasyKmZW3QYxFBu8zhjFmVeGqg9F8o80Yx8s/sTkOWi9eYKgkmaGL2e6U0UpxrWFisSCD+2mKd1I8huem+5wIMKppTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787647931; c=relaxed/simple;
	bh=VKMDL07sLr7LbZt82TUIHGSLkr70YD0v/4T4k6XUbRE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jLkt6arrrEVTJt4a6cp6YAhegyRPf4lqr/3ChWkYH+hvasVjyWN1Aez/qlyJ4T2osRbxK7VnHiP5JyctXsoR0eyLMMR7rym3PuGPnQoR1y6TU4pKBrBsS2G0YT5Ofy8D1C4uZf0u2Egfj14b8bHZT7U4DI2ag/oL6w4f96eBOZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJWbO6VD; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJWbO6VD"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d53197d8b5so42014615ad.3
        for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2026 01:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787647929; x=1788252729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SeFWWXdSP58uLbYYiN12WkJAIPfpSpNXceEQnAekcAE=;
        b=FJWbO6VD715FFuzv49kcEGd5Wql+3MUoq3CvxsFgdG7fSPuFw8ZBWj7y3XRhOGfi5h
         zQY142bo+I7N9duxT3Y7ENqhhwoCuHslNGgN3bET8wDVHmnje3GW1qsK5asGdNz/AOTw
         Qj5Q9BWhW6Brl4G4O+fZBLuDrlDjsvwG44Fzo8K578Kj9Db5ANj/2ReOJMuR2hdXyjt8
         cufblxozeVc9D8WeIwMqRFSPsqdmQraHIBdDigcVy983Jr3VOe6/5Xg1Lbv2LNPJCz6x
         Qer1eInjBEGARLXzmb5k6QWOd5n1R+gVrgl3K2g4vjocj2jpUxY8KDfFWMXTymUxxVLQ
         ii4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787647929; x=1788252729;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SeFWWXdSP58uLbYYiN12WkJAIPfpSpNXceEQnAekcAE=;
        b=LD0S67fhQjh4vaBQo+yGfECNK7fs71VpDrcOF+R1iUyum1iaI2bv1y7NwkCqcb8S9q
         jt8n5x/dCa6RcwLf9assGd5ppmGCvP4fR0Ze3ZKJASnPimEU0wtZxtPEQOD+B7+cle6I
         vNjrEyHsH2SVCJ0zN8xAtAqIi9Rs8Vx4T942R4y75/V53HwoCgS2yJq0OSrV1JacmBAZ
         rZMulKeleBTIh9YUj45SfPz0QMxdjIhPSBkDoxFdeGSVWf2HWv5Y0fj3aEWQ2uSaQkfT
         ZIVYdJuWZAB4rfY2kmpAyrCAfqYVdjFBL8G6Z7v7rK7oWxKjYF+tR5/3Aw8/Pq28ZmAh
         UwOQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqhu9jS58G0eo3IoU5WLNLgclA17gX53CC8WmviSvnt1Mhr+sE+BDCO3SurAU7OGnPNnT2B2yLwuSc=@vger.kernel.org
X-Gm-Message-State: AFuF++lAgU3QMG1dJt1RamwV/PRmwjMK5vTOPbgHqO5CXGsMZLyXaNlE
	BuSMiis1Oqdu9JvA3YAOMEAuKFMFuK3k/JOIenqEmczDh2yvTq4VMg5e
X-Gm-Gg: AR+sD13T2l+ZWx5I1y6pi1OxvzI6KLO+mnRd1P9SP2Zspm0Fq75vrUkd2rNazm6PlEw
	tGJBVeuIg2l2MCwS5QZIw084MbVP2PjZzZACeUvHJ9Bd9BbUjqwjKrgTajR1VrYTgcnmxRa9zkR
	R1BnvY7NY78IG8XvwmiXTdrUk85txf69dH9nZ0tuufB3IwpfKou8HjsHhT+AKKi4VgtbC0SaBGg
	qcLv/y83TLIX9nQNrrX0HtsaaqzUXA4tusqOnBweLdJ9/GioKyMOK5dbgSlJn9n7JkTXFgSePzk
	X2YLwSVKKctGaUXD57UyBdRuzkzfoYGRu/aYzaM2naMuU3b7Vvggg66JZGj2l2u9D+qD74AaCOS
	RCS+5n2SvI/4aR5GQuQMN7exPcGhdrlpi8agw4bWaeGxQgm7Xz+TnTZMrE2PEoA/j3SW7dONJKq
	Ye1BKjThu3Ahxezj4NdsCoO4yORwayMwUV35XrChExNQpNOfo7mSr+lnsVc+oR8neeC3l771b2s
	cQ9aec=
X-Received: by 2002:a17:902:e552:b0:2d1:1f73:3667 with SMTP id d9443c01a7336-2d64ae3b141mr490183535ad.1.1787647929346;
        Tue, 25 Aug 2026 01:52:09 -0700 (PDT)
Received: from shrey-Mi.local ([106.51.251.74])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f90c0a59sm42032202eec.9.2026.08.25.01.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 01:52:08 -0700 (PDT)
From: Yash Suthar <yashsuthar983@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	andriy.shevchenko@intel.com,
	grondon@gmail.com,
	linusw@kernel.org,
	hexlabsecurity@proton.me,
	sakari.ailus@linux.intel.com,
	srinivas.pandruvada@linux.intel.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yash Suthar <yashsuthar983@gmail.com>
Subject: [PATCH v3 0/3] iio: accel: bmc150: DMA-safe buffers and use iio_push_to_buffers_with_ts()
Date: Tue, 25 Aug 2026 14:21:53 +0530
Message-ID: <20260825085156.212042-1-yashsuthar983@gmail.com>
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
is not DMA-safe. Move them into struct bmc150_accel_data after the aligned
scan buffer. Because all buffers are serialized by data->mutex, placing
them after scan ensures DMA safety without needing separate alignment.

Finally, replace the deprecated iio_push_to_buffers_with_timestamp() with
iio_push_to_buffers_with_ts() so the push sites pass an explicit buffer
size.

This supersedes the earlier standalone patches:
Link: https://lore.kernel.org/linux-iio/20260808220236.421832-1-yashsuthar983@gmail.com/
Link: https://lore.kernel.org/linux-iio/20260809111303.496393-1-yashsuthar983@gmail.com/

Link to v1: https://lore.kernel.org/all/20260814101845.301769-1-yashsuthar983@gmail.com/
Link to v2: https://lore.kernel.org/linux-iio/20260815175728.99541-1-yashsuthar983@gmail.com/

Changes in v3:
- patch 1: hold mutex for both the read and push to guarantee DMA safety
- patch 1: drop unused AXIS_MAX and use sizeof(data->scan.channels)
- patch 2: remove redundant __aligned(IIO_DMA_MINALIGN) from fifo_buff 
  and regval, as the mutex serializes access
- patch 2: fix comma typo in commit message

Changes in v2:
- patch 1: restore early error check flow
- patch 2: keep fifo_buff declaration in one line

Yash Suthar (3):
  iio: accel: bmc150: use aligned scan buffer for both trigger and fifo
  iio: accel: bmc150: use DMA-safe buffers for regmap bulk reads
  iio: accel: bmc150: use iio_push_to_buffers_with_ts()

 drivers/iio/accel/bmc150-accel-core.c | 28 +++++++++++++--------------
 drivers/iio/accel/bmc150-accel.h      | 19 +++++++++---------
 2 files changed, 23 insertions(+), 24 deletions(-)

-- 
2.43.0
