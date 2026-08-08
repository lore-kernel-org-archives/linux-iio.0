Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CAB38552C;
	Sat,  8 Aug 2026 16:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786208307; cv=none; b=CtVlRfmlK8O+U5n0BO1x3YBWH6V2ASx0fX5eRjg4EvOt7Khv6HaMMuEnSEh8U+wrf/IYtqaMPrMzqcaLShWPCaWJmfXME9w43i92Xdmr0AUfWl9Wpnh+2OQaGYKQXdI+DtahUXFuYQkMhzwwurICvhbumE5bLRHNHUWbyuCf3iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786208307; c=relaxed/simple;
	bh=NDE6IipBlhsaT+g1D3mNgxPcwiegRU0ZDshwteRu3w4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eFmYfNNxz5KDH7UEubuGRcz1CAmkzm0/2rF9X7Nyjb5UyqaKApFLD8IcLGe2j89jfHIF1kR8atjm8HoerARP6qOjM24G+843egnU1Wu7lMc04RK5R3CcBERGDof2UolsqDNEW6D67VYvPqgWMWHWCrdrebdNXYjhM/bTE2oVCdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqodsUIB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqodsUIB"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0C9FC2BCFA;
	Sat,  8 Aug 2026 16:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786208306;
	bh=NDE6IipBlhsaT+g1D3mNgxPcwiegRU0ZDshwteRu3w4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cqodsUIBHI1J9piCwhb1GZKrnpEsoGLDYCtUhbd+1ljjcuw5ly24W2EBQ1GNTT/8g
	 IrL13eQ8bC6A0BJID1qhrwNO3YLF35JMtzSZBjSt32s/4a9hhViboDaLSsQgTnZ9Xa
	 pwQt8XC+52pvsurJ5CdZCzRchciito6PeX03aTuXewglfTJ9rGH2rEiGsDTCb/JhB6
	 Auo3+ihTDnuzXnMtoJq0ua3K7Tbgd7j1vxIYLurOPhrJoGs5D57dbLTCaLXHFGXitU
	 rl7odWFkQ7K7d1P3dA57BfUX6/j6ADgGLMDj4K7rkrKpWy+d3VJWRwKSYPAl4gbPa9
	 203NQ8kuJt4BA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CFDC5AD55;
	Sat,  8 Aug 2026 16:58:26 +0000 (UTC)
From: Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>
Date: Sat, 08 Aug 2026 22:28:15 +0530
Subject: [PATCH v5 3/4] iio: accel: mma8452: Use IIO cleanup helpers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260808-15-apr-pm-iio-mma8452-v4-temp-v5-3-d177e93ce3f8@gmail.com>
References: <20260808-15-apr-pm-iio-mma8452-v4-temp-v5-0-d177e93ce3f8@gmail.com>
In-Reply-To: <20260808-15-apr-pm-iio-mma8452-v4-temp-v5-0-d177e93ce3f8@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sanjay Chitroda <sanjayembeddedse@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786208304; l=1940;
 i=sanjayembeddedse@gmail.com; s=20260702; h=from:subject:message-id;
 bh=87TYvL0o2QU4xXLjLnpehxWEOumXzmAP5MZuj4hGTOY=;
 b=mW8z+UiW10SlOQe+VbolRQzbz2M+/KCjMLiGOfkD9sAYekBNdfEsrHbjhZorpf03YO5MCVkn1
 0C8AZxvW9hMB4+YgA/ohAFvSFHQL0OovKRkz3qFSthLEj0P0S3nhLq4
X-Developer-Key: i=sanjayembeddedse@gmail.com; a=ed25519;
 pk=PcneEFtkmY+Ldl+KmOTpB/Q/HDsqko6Fb0/Z/5cuycI=
X-Endpoint-Received: by B4 Relay for sanjayembeddedse@gmail.com/20260702
 with auth_id=848
X-Original-From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Reply-To: sanjayembeddedse@gmail.com

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Use IIO_DEV_ACQUIRE_DIRECT_MODE() helper to automatically release
direct mode.

Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/iio/accel/mma8452.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index af0cc5970f3b..c78b1b742b08 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -495,14 +495,14 @@ static int mma8452_read_raw(struct iio_dev *indio_dev,
 	int i, ret;
 
 	switch (mask) {
-	case IIO_CHAN_INFO_RAW:
-		if (!iio_device_claim_direct(indio_dev))
+	case IIO_CHAN_INFO_RAW: {
+		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+		if (IIO_DEV_ACQUIRE_FAILED(claim))
 			return -EBUSY;
 
 		mutex_lock(&data->lock);
 		ret = mma8452_read(data, buffer);
 		mutex_unlock(&data->lock);
-		iio_device_release_direct(indio_dev);
 		if (ret < 0)
 			return ret;
 
@@ -511,6 +511,7 @@ static int mma8452_read_raw(struct iio_dev *indio_dev,
 			chan->scan_type.realbits - 1);
 
 		return IIO_VAL_INT;
+	}
 	case IIO_CHAN_INFO_SCALE:
 		i = data->data_cfg & MMA8452_DATA_CFG_FS_MASK;
 		*val = data->chip_info->mma_scales[i][0];
@@ -777,14 +778,11 @@ static int mma8452_write_raw(struct iio_dev *indio_dev,
 			     struct iio_chan_spec const *chan,
 			     int val, int val2, long mask)
 {
-	int ret;
-
-	if (!iio_device_claim_direct(indio_dev))
+	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+	if (IIO_DEV_ACQUIRE_FAILED(claim))
 		return -EBUSY;
 
-	ret = __mma8452_write_raw(indio_dev, chan, val, val2, mask);
-	iio_device_release_direct(indio_dev);
-	return ret;
+	return __mma8452_write_raw(indio_dev, chan, val, val2, mask);
 }
 
 static int mma8452_get_event_regs(struct mma8452_data *data,

-- 
2.34.1


