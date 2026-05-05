Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A504342DFE5;
	Tue,  5 May 2026 12:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777984509; cv=none; b=rc+S/XmAC2mDMZStHj6xGZR1c9gMVHlCwYddPjtVYsPINT9t+HUSi5+CPdbz9T3IAn6PW+ya7oakTyJb2RAuJ7ErRL+L0zEyReVGt9oT1RQpHaps9LB+JFngxLo+BuQiVejLYecWZQp5R21w+c61dm8JqX1np2hsFtT5TCe1UZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777984509; c=relaxed/simple;
	bh=7Mc0VNRZ1CCHsXaSFdFIyxqQMqScXwRjdBvOyAElbig=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pGNzji7BIQjktJF/DQ4HFffJoHJ1HM6moNJocyQ57cwLI2MyllKKZftz0Awft7/lhijKD9efCwP91HtSG5nRNXUTxkYQWNNefcOVQoWu4IiLqHav9hIIf8QjQeuofFpTM6JkLNTOZufh4JEBn86l1RPS0MCeP9+vTdjS2MK/Ie0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uEZ4ERtp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uEZ4ERtp"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6AC72C2BCC7;
	Tue,  5 May 2026 12:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777984509;
	bh=7Mc0VNRZ1CCHsXaSFdFIyxqQMqScXwRjdBvOyAElbig=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uEZ4ERtpg3RakOZy1INr8LTEL2T95YyOVDLH8P5IfoVnABOq69JOcm7S8A1M8O6mS
	 D8Sz679RRzdIzG6H32JJ0UI51Qr89qvLwNXBcIca6EEnVvIfcNh/ylIrBBNnBFK6TV
	 fB26H6WD3Xn9EXHCwhurSDv0haCQuF2QjPoXnLjhKHphGTI53hTxZ0zFu0wguuFnjU
	 SQto9/UDBQxXyoI6DpJe7dyrVBUo2a+nvzYFgvcu4DLbOHDdb2GmqPH9Y68aEeJQib
	 KVcCoRb6ZA2CyjmuEjS/QYmLrnDL9P/DmtTwdD5pjW/lulp2V0cc8FM7Lu6/qeMbqU
	 EQgZN670uAOiw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEE8CD3436;
	Tue,  5 May 2026 12:35:09 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 05 May 2026 13:35:03 +0100
Subject: [PATCH v6 02/12] iio: dac: ad5686: fix input raw value check
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-ad5686-fixes-v6-2-c2d5f7be32be@analog.com>
References: <20260505-ad5686-fixes-v6-0-c2d5f7be32be@analog.com>
In-Reply-To: <20260505-ad5686-fixes-v6-0-c2d5f7be32be@analog.com>
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Stefan Popa <stefan.popa@analog.com>, Jonathan Cameron <jic23@cam.ac.uk>, 
 Greg Kroah-Hartman <gregkh@suse.de>, 
 Michael Auchter <michael.auchter@ni.com>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777984508; l=1063;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=vDIfN7HwJer2abOZhavJmea2PyXmNcae90gQrhX9MT8=;
 b=GbPPBOuE8ZsTsB76EzvPTvkHlv8/PT/y7+VJ0OfLqGDiH655DAG/GTWnJxxnOOaMQO3NbC9TE
 y1Zos5DQp7zAiJHTx+SltBXATKs7zqe4HKPLcLXNhzUa5VlnwPKlxmD
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Fix range check for input raw value, which is off by one, i.e., for a
10-bit DAC the max valid value is 1023, but 1 << 10 equals 1024, which
passes the previous check, allowing an out-of-range write. The issue
exists since the ad5686 driver was first introduced.

Fixes: c2f37c8dcadc ("iio: dac: New driver for AD5686R, AD5685R, AD5684R Digital to analog converters")
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/dac/ad5686.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 1fc54c38b629..076fe8b8bd85 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -154,7 +154,7 @@ static int ad5686_write_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		if (val > (1 << chan->scan_type.realbits) || val < 0)
+		if (val >= (1 << chan->scan_type.realbits) || val < 0)
 			return -EINVAL;
 
 		mutex_lock(&st->lock);

-- 
2.43.0


