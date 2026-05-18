Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300E03246F4;
	Mon, 18 May 2026 07:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779088445; cv=none; b=HRzR/cjHBJWcWbAsVVHXnSxKFoOVdl0naLJFWpB7ypeQYqsPpcOw94mKymKbnQHSakux1o6wzLCo1BohpYacwwMT4Gvua1GjAWSRmffRPAtEgmRjm0attQJkogfXUfNgjmgGlADZVJSfleADBXVMyRUb63tN1ti3FMkGghiIa2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779088445; c=relaxed/simple;
	bh=ZOxV4keHvXgezOAYRpyFmFQVRj+tHNaeFDaH8XizSnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K2QtdxWzwLRdXCX7b9kRVmp67BzquMigXqHDNm3ZDTS6G3etNXLrDRTkNGp0VkisTSx1lSqDF6n4vLhg5ZgFqQ0HZomXYQWzHQ+xYJ7ucBkk9P3hL9SoKAFfGkhfj2KIwApHbglSOn3scGTfQW/85Hq5nDsQ7LB465CM9fkcAX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bVD8wm0H; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bVD8wm0H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779088444; x=1810624444;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZOxV4keHvXgezOAYRpyFmFQVRj+tHNaeFDaH8XizSnQ=;
  b=bVD8wm0HEVbOF0B8n8vyGMBrneMtmrJFbUjxqI0qG1TTI6Gp97A5zZJB
   HWmR9mbe6gl/4NetZFzU1A5SHwrBZyVplwyJpAyd6+ksa6NwEf3zO6kB6
   bVnNqOTe+xc08CTj5LqJ20yWa9Bhmla6kHlkM6XULTwMkVgUroOC3WBHE
   qqUYzt6SHecl1DRMQybbsmwk6W2Cwzkt08Vdq6w1vvTR2XVr1PvRIf+91
   jTJoTXRk+1B7aVGfYT864+2+hH2dyo+4tVbLL+l3tDh1uR2Qrwg1dB0uJ
   WAhZ5aF7El5cMZW57WPBVQp9qCguYZ/v02L88ZIIJd2cRzu9Az3TNJr3v
   g==;
X-CSE-ConnectionGUID: rFRPzKdoRHadbbxFTfNvGg==
X-CSE-MsgGUID: EUajPXbNRsi7jBvc6kNhlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="90243373"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="90243373"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 00:14:03 -0700
X-CSE-ConnectionGUID: UX9GrQ0bQd+HvJy6zHTtyw==
X-CSE-MsgGUID: anB5KqqfS1ahBmS7b2qjqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="262862267"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 18 May 2026 00:13:52 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 571A195; Mon, 18 May 2026 09:13:51 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v0 1/1] iio: Convert IIO_CHAN_SOFT_TIMESTAMP() to be compound literal
Date: Mon, 18 May 2026 09:13:29 +0200
Message-ID: <20260518071349.469748-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently IIO_CHAN_SOFT_TIMESTAMP() can only be used to fill the static
data.  In some cases it would be convenient to use it as right value in
the assignment operation. But it can't be done as is, because compiler
has no clue about the data layout. Converting it to be a compound literal
allows the above mentioned usage.

While at it, tidy up the indentation.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v0: to be incorporated into David's series

 include/linux/iio/iio.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 96b05c86c325..711c00f67371 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -353,15 +353,15 @@ static inline bool iio_channel_has_available(const struct iio_chan_spec *chan,
 		(chan->info_mask_shared_by_all_available & BIT(type));
 }
 
-#define IIO_CHAN_SOFT_TIMESTAMP(_si) {					\
+#define IIO_CHAN_SOFT_TIMESTAMP(_si) (struct iio_chan_spec) {		\
 	.type = IIO_TIMESTAMP,						\
 	.channel = -1,							\
 	.scan_index = _si,						\
 	.scan_type = {							\
 		.sign = 's',						\
-		.realbits = 64,					\
+		.realbits = 64,						\
 		.storagebits = 64,					\
-		},							\
+	},								\
 }
 
 s64 iio_get_time_ns(const struct iio_dev *indio_dev);
-- 
2.50.1

