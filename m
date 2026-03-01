Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD35430BA3;
	Sun,  1 Mar 2026 01:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328180; cv=none; b=Zq6QSXO2Z/gzTaJnOl/vbqcih01v1EZi3SoeddaL58q5gohMc43GfL0Unv1A1zzouy8mJxMaAlWxXD/49yKSGxRa18IVSrvyGSx4wyGprL13wvpovTtj/Ru5WfeNp7rvu7ET3ELseK8ic2KSc+d2JKGjXF9678N2AvEEtWZiL1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328180; c=relaxed/simple;
	bh=qu7LE4UfWqpF0NqzUyC4BLLU9TyzrMZOpBO5E98JP5I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qShjp2D825hWKzM/Gi/LmGPaLUANQZKfLKiNZK/Xy4kyV44jtstqdDp2nSF9Z1yczDVOG4vtTEHOWkAdwqmp58oD5oUnm6GOsAftUtKRuilbo976mCiiO+/ElhMgDzkUPSNw/F6iX1R3kjYWEkGnLe3Z8xp4KaGkOIq3XgixqoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iC1hxHRq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iC1hxHRq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F0E7C19421;
	Sun,  1 Mar 2026 01:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328180;
	bh=qu7LE4UfWqpF0NqzUyC4BLLU9TyzrMZOpBO5E98JP5I=;
	h=From:To:Cc:Subject:Date:From;
	b=iC1hxHRqjgDh5CjxT82D+JdP2TOJo/F+iXMERm1ssYZDtf67AfQl92oRK9I75xHeE
	 3VAsevdj4dCmnkD7FAjFDVkjlaPIftpxVQ92LecbjvAo8TU6MxtZ79q4kHfPkZ8+fx
	 o1sEiDCJ2lsWzCdzjDW3ixpHi1vqMP7YnlYaCm/JZyIWESco2mgXhA2+tWRGR60Hw2
	 wwLSoS6sLh0YHQ8iiSJtYcF5NVehNjX7pT4OzIew0IZurLA6KAvxrusi+ZV16pGyp+
	 1GK77XI1fu2ZB5jXDZUybzOCtP7Wn9pt294nXBoD4Zxe9ZAhpAS2z5mbvPvlB7c5gP
	 +vgyw+Ub3jHag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	flavra@baylibre.com
Cc: Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org
Subject: FAILED: Patch "iio: accel: adxl380: Avoid reading more entries than present in FIFO" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:22:57 -0500
Message-ID: <20260301012258.1679574-1-sashal@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From c1b14015224cfcccd5356333763f2f4f401bd810 Mon Sep 17 00:00:00 2001
From: Francesco Lavra <flavra@baylibre.com>
Date: Mon, 19 Jan 2026 11:23:16 +0100
Subject: [PATCH] iio: accel: adxl380: Avoid reading more entries than present
 in FIFO

The interrupt handler reads FIFO entries in batches of N samples, where N
is the number of scan elements that have been enabled. However, the sensor
fills the FIFO one sample at a time, even when more than one channel is
enabled. Therefore,the number of entries reported by the FIFO status
registers may not be a multiple of N; if this number is not a multiple, the
number of entries read from the FIFO may exceed the number of entries
actually present.

To fix the above issue, round down the number of FIFO entries read from the
status registers so that it is always a multiple of N.

Fixes: df36de13677a ("iio: accel: add ADXL380 driver")
Signed-off-by: Francesco Lavra <flavra@baylibre.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/adxl380.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/accel/adxl380.c b/drivers/iio/accel/adxl380.c
index ba550142866a3..a77c2323d1aa4 100644
--- a/drivers/iio/accel/adxl380.c
+++ b/drivers/iio/accel/adxl380.c
@@ -966,6 +966,7 @@ static irqreturn_t adxl380_irq_handler(int irq, void  *p)
 	if (ret)
 		return IRQ_HANDLED;
 
+	fifo_entries = rounddown(fifo_entries, st->fifo_set_size);
 	for (i = 0; i < fifo_entries; i += st->fifo_set_size) {
 		ret = regmap_noinc_read(st->regmap, ADXL380_FIFO_DATA,
 					&st->fifo_buf[i],
-- 
2.51.0




