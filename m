Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEC11A9B46
	for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 11:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780226176; cv=none; b=e0s/zS/e+5glsR6V9z8W24wUdo2UQxYZsGrbQhyO2+5lzRVoC2Co5C+3mW+vVBV30r/5ChJ6yabI8l0vZcx7+aXwKP9eniKEu9N7s+ysX5Ht4pjn07so02YYkx4kHInLecHDlUSbSufosB8CoeaDCA4p/C3/Cv1zYAt02wdfsZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780226176; c=relaxed/simple;
	bh=7gZcE04Mxl5ddqkLDcyLrA5wIhMZuAGM9OyV/H7EQxg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lA/6wIEod0L/PjeXZYhl7r6zNjjd8OHY2SQdKVQ/VSQIzD+JTmZGVWgvrVbEUmGwesy1rk5sEmlfQS0KAcOJxBkzaS6uQsYZXxWjwzHxRatIYoLDg+iVySCkggbyvIv0N8dboMMc5dT8hd/HC71R1L4tf5FGb+quivYd9bqSrBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3UAHn2a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3UAHn2a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 040691F00893;
	Sun, 31 May 2026 11:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780226174;
	bh=o7YLfnMISbCiaBD7bUkVRxZ3BvSpBs0mKIZbr6bEmzs=;
	h=From:To:Cc:Subject:Date;
	b=R3UAHn2a5rlVUnJFi0ZVoTeFIHQGcTQYVWBavZY6l/G4KEDXHVLBDmQ5tHZONhMGo
	 uTM1eNNU1OXeoe1Vk4jJ1eaVFkjD80ZQVI8BA+CbYC3GIUsozF+n++5W5UWPhk1Ibg
	 zJdnmelbVQdGCfFhNg/x8ARngDbV5Sqn9qYGjdzPYHZfNAOCvPRUYt922ZDxyUifAj
	 RyCGTq7iowID4JLkXlwrBbWsMLf5aLbFudu5Bg7CX91qAJ4moSWXE/o6FKUXxryKvy
	 8lZDryGNrKapG6/q1zCDTvhz8wVLqBPAnTT8kxR6CpoKugaTajGFb7FwUaFf4a+R8R
	 OnMy+irVA8fKw==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Jinseob Kim <kimjinseob88@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	"Reported-by: Sashiko" <sashiko-bot@kernel.org>
Subject: [PATCH] iio: buffer: Ensure bounce buffer used for unaligned case is zeroed.
Date: Sun, 31 May 2026 12:16:05 +0100
Message-ID: <20260531111605.2411980-1-jic23@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iio_push_to_buffers_with_ts_unaligned() leaks uninitialized heap memory
to userspace if the data passed in is not a multiple of 8 bytes and the
timestamp is enabled.  Use memset() to zero it after resizing.

Fixes: 95ec3fdf2b79 ("iio: core: Introduce iio_push_to_buffers_with_ts_unaligned()")
Reported-by: Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260529121005.1470-1-kimjinseob88%40gmail.com
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
Cc: Jinseob Kim <kimjinseob88@gmail.com>

This is untested as I don't have any devices that use this and long
ago dropped whatever hacks I used to test it originally.

Jinseob, could you please test this with your OSF driver - at least
make sure it doesn't stop the data coming out!
---
 drivers/iio/industrialio-buffer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 9d66510a1d49..d930e70e12ff 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -2466,6 +2466,7 @@ int iio_push_to_buffers_with_ts_unaligned(struct iio_dev *indio_dev,
 				   indio_dev->scan_bytes, GFP_KERNEL);
 		if (!bb)
 			return -ENOMEM;
+		memset(iio_dev_opaque->bounce_buffer, 0, indio_dev->scan_bytes);
 		iio_dev_opaque->bounce_buffer = bb;
 		iio_dev_opaque->bounce_buffer_size = indio_dev->scan_bytes;
 	}
-- 
2.54.0

