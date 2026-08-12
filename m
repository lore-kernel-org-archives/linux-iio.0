Received: from sg-2-4.ptr.blmpb.com (sg-2-4.ptr.blmpb.com [71.18.227.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86483955C0
	for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 07:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.18.227.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521563; cv=none; b=iRMPv/N7aS539+vZT7IVBZWFsN44bWQHFZ1oWuQdkniafNPFlmAEK70mPg1xPYov2vqILj7qQvcr9TemqS8U5ep1iNalt9fKjSf2KDfq1X1VFOmnBwVaW+WqOB1sFyPuv/l4rpaHRMNUJsPadAq6icVV2P69pT5ZAByv8n5RUP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521563; c=relaxed/simple;
	bh=75+FhvgZvHiJP4mRloJbM/2PVzFlJgOMPnn/g1sxz6c=;
	h=Subject:In-Reply-To:Mime-Version:Content-Type:To:Cc:From:
	 Message-Id:References:Date; b=JMSm5UK6q7IBCKoG8Oyr1Xn1IMGgLQpXvwWzgWlxFPHA+N3RKVCDLP3wegh5pNZ6VAebKAONK5/8oCyL8baE6vvwJsE6NE/OZd4Tu980DurzQNzewlDa1NAUtpMWXbAHR7ISxN5g6Q93dqx7XzYqGPzKHT4HrD5BlYiffgxueww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc; spf=pass smtp.mailfrom=cherr.cc; dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b=GPTePD3V; arc=none smtp.client-ip=71.18.227.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b="GPTePD3V"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1786521541; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=wI2Ad98c9KKRqH+lpOMl2Ygtab5lbfNg/qA/hfqkkEY=;
 b=GPTePD3VVSPKvwi0cwC6afKN0YdPSSvADFZAxGArQuDH4ccUpQNJ713qT4uTDU/3QxnvwQ
 wIdLo8ZemdCyE4F6vAvMy1Z/ii5bc4H3pLp+lSWeAzGPkTTruTs/TbxGAO/Lkeeqc+MpRI
 RGHW+KT2LqenzpJ3R09NLpuf6/ZuOhLJBHdgZ4IJYCq5wswBCDfhY4VS/eXlGroawWR8x1
 VUbVHVt8KMwzCINajwAVvc7JVo9DA+bMsrI2yKflZpLh93oE4v0MhYHc3GigeSeQwkTpKJ
 mT5Zs5g+A5zD/a49dQDOUv9xOajs1gw6aJKbeHiGg8ESyXJcjzwcGUJOreBXlg==
Subject: [PATCH v2 2/2] iio: accel: adxl367: reject out-of-range FIFO entry count
Received: from [192.168.9.107] ([111.42.148.52]) by smtp.feishu.cn with ESMTPS; Wed, 12 Aug 2026 15:58:58 +0800
In-Reply-To: <20260812-adxl-fifo-v2-0-86bea20faf1c@cherr.cc>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Shengzhuo Wei <me@cherr.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Ramona Gradinariu" <ramona.gradinariu@analog.com>, 
	"Antoniu Miclaus" <antoniu.miclaus@analog.com>, 
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
	"Michael Hennerich" <Michael.Hennerich@analog.com>, 
	"Jonathan Cameron" <jic23@kernel.org>, 
	"David Lechner" <dlechner@baylibre.com>, 
	"Andy Shevchenko" <andy@kernel.org>, 
	"Marcelo Schmitt" <marcelo.schmitt@analog.com>
Cc: <linux@analog.com>, <linux-iio@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, "Shengzhuo Wei" <me@cherr.cc>
From: "Shengzhuo Wei" <me@cherr.cc>
Message-Id: <20260812-adxl-fifo-v2-2-86bea20faf1c@cherr.cc>
References: <20260812-adxl-fifo-v2-0-86bea20faf1c@cherr.cc>
X-Lms-Return-Path: <lba+26a7c27c3+ed6bde+vger.kernel.org+me@cherr.cc>
Date: Wed, 12 Aug 2026 15:58:50 +0800
X-Mailer: b4 0.14.2

The FIFO entry count reported by the device can be as large as 1023
(the low byte plus the low two bits of the high byte), but fifo_buf[]
only has room for ADXL367_FIFO_SIZE (512) entries.
adxl367_push_fifo_data() passes the reported count straight to the FIFO
read, so a count above ADXL367_FIFO_SIZE overflows fifo_buf, a heap
out-of-bounds write of up to 1022 bytes into adjacent memory.

Rather than clamp the count and silently drop the excess, abort the
read: a count beyond the FIFO size means the device is returning
garbage, so the data cannot be trusted. The message is ratelimited
because a stuck device can raise the IRQ repeatedly.

Assisted-by: GLM:5.2
Signed-off-by: Shengzhuo Wei <me@cherr.cc>
---
 drivers/iio/accel/adxl367.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
index 8c3de11a10a37d228f8758b688156e3ee958c4e9..270d6feede2f60f4274dead7b3974cd04abb14a6 100644
--- a/drivers/iio/accel/adxl367.c
+++ b/drivers/iio/accel/adxl367.c
@@ -787,6 +787,14 @@ static bool adxl367_push_fifo_data(struct iio_dev *indio_dev, u8 status,
 	if (!FIELD_GET(ADXL367_STATUS_FIFO_FULL_MASK, status))
 		return false;
 
+	if (fifo_entries > ADXL367_FIFO_SIZE) {
+		dev_err_ratelimited(st->dev,
+				    "FIFO entry count %u exceeds FIFO size %lu\n",
+				    fifo_entries,
+				    (unsigned long)ADXL367_FIFO_SIZE);
+		return true;
+	}
+
 	fifo_entries -= fifo_entries % st->fifo_set_size;
 
 	ret = st->ops->read_fifo(st->context, st->fifo_buf, fifo_entries);

-- 
2.47.3
