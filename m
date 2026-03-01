Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999CE273D77;
	Sun,  1 Mar 2026 01:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329965; cv=none; b=NtWBmhWR+uKK9vhikMYgkVHYuGCWYS56Oq4rbTRITCcvJX+Yglhj/Yf6ej1oNTz52YKmMoasQbZfbLgsRCFuVuvYp56VRMGIDxQisr0uKsmciWXMSbnn8C7eZruwvOsXfIw1cbVk9SWpYnWJsUH9AgaJ9guCGYT7n8jDvmZUTxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329965; c=relaxed/simple;
	bh=Zy0+j/a4oQ4elNvwGwcDcZFtBnfiS3PlWx8hJnVNULk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SOy6N31gMlpGWkE5OTNySkc4+DZ73uYam0yyouLyNZDP3Hg3VD2ubGeL79D2cD9LKX2z47GXUd+xXyTE01/XexApC3ksvOY2pT1lmcSHrRZsEbOy7vok19ovzfvFz/S3fEf1Tl1r0YqfDS7S4yjuKUy7XKCvvQnp4+10D+5r8NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFWlzt4d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFWlzt4d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7D0C19421;
	Sun,  1 Mar 2026 01:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329965;
	bh=Zy0+j/a4oQ4elNvwGwcDcZFtBnfiS3PlWx8hJnVNULk=;
	h=From:To:Cc:Subject:Date:From;
	b=YFWlzt4d5K7NOR+eDz/lakrx+LLBlVtE/m6ANLWxKXn8RBz4/HqhoNXvw7LewfjwI
	 YkniGjJ5ZP0TLAtEaPcxQ1/cKMBSqOTWZO4v/IIZeY+zj2p2qusdK8W63J+j6wgT4c
	 PgYHZR2RrhI/yA/L0qrZmr/mlk4t5J930nXkg0pkfSj/xO93InzeUFeJjopecNtr04
	 QveqG2E8jZYVSyAs4vjG7pDJtEQVLd7gqvWJTA071PYOqRETPyxboq5IBcP3vVQ8v6
	 NCd2MuuLSuCOQOd46oFNxUqo6oZ5QeqjM31lMhnaNlP5vWICb21RY2J8WCsGuZ9GA8
	 Gog7AOO0k0BXg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	antoniu.miclaus@analog.com
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org
Subject: FAILED: Patch "iio: gyro: itg3200: Fix unchecked return value in read_raw" failed to apply to 5.15-stable tree
Date: Sat, 28 Feb 2026 20:52:43 -0500
Message-ID: <20260301015243.1719320-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From b79b24f578cdb2d657db23e5fafe82c7e6a36b72 Mon Sep 17 00:00:00 2001
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
Date: Thu, 29 Jan 2026 17:01:45 +0200
Subject: [PATCH] iio: gyro: itg3200: Fix unchecked return value in read_raw

The return value from itg3200_read_reg_s16() is stored in ret but
never checked. The function unconditionally returns IIO_VAL_INT,
ignoring potential I2C read failures. This causes garbage data to
be returned to userspace when the read fails, with no error reported.

Add proper error checking to propagate the failure to callers.

Fixes: 9dbf091da080 ("iio: gyro: Add itg3200")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/gyro/itg3200_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/gyro/itg3200_core.c b/drivers/iio/gyro/itg3200_core.c
index cd8a2dae56cd9..bfe95ec1abda9 100644
--- a/drivers/iio/gyro/itg3200_core.c
+++ b/drivers/iio/gyro/itg3200_core.c
@@ -93,6 +93,8 @@ static int itg3200_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_RAW:
 		reg = (u8)chan->address;
 		ret = itg3200_read_reg_s16(indio_dev, reg, val);
+		if (ret)
+			return ret;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		*val = 0;
-- 
2.51.0




