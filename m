Received: from sg-2-3.ptr.blmpb.com (sg-2-3.ptr.blmpb.com [71.18.227.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D74B1F09A5
	for <linux-iio@vger.kernel.org>; Sat,  8 Aug 2026 22:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.18.227.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786228371; cv=none; b=Q3GubDCxx+TO8x+fcQMFbeNK24AQbKWuAqzM7WfivL3vp6ii93624O4RnZiMG6CmzLlbwZvdJVCZaOXUAVJUklPTi6+cq97RP20Rz5briZfIkkL41tKGj2bMLpR9Ok6TR/kniDszv2jr2F1rVrDous5NeMoVoTMwNnujZMrrEw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786228371; c=relaxed/simple;
	bh=nc5DPVw4jcyXLKvfSpa8kU0mNWLfdlTs263oOiPP68s=;
	h=Subject:Message-Id:Content-Type:To:From:Mime-Version:Cc:Date; b=KYz/CGvjhkAMireBRYVIgSfdNQQsD/oo3Ji7tdOxxUdjnveJ3RIYCCz4iye/CHv4Koqzf3sR5v0yfTbyDOrxJo2pdL+tU5CpvoeH6aAbGVk9hYi5Jmwg0/aZU57qsbf8gTQwnGM2nFm4aC7r/7BvoXu5MfRixSdYLBKTQ3WoI50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc; spf=pass smtp.mailfrom=cherr.cc; dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b=AvWoUFN4; arc=none smtp.client-ip=71.18.227.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b="AvWoUFN4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1786228362; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=fz9A3WehZXe25/IP43AHGuGTXuBYJEnSgrJ0apvlm2s=;
 b=AvWoUFN4AWw9Uj9lbQyTfIKwATfksW2tI0SVq55Us1I6847oyzg6bFPQHtjEB2w1rrxSaa
 KUmaNdYinEPrz9S7GI0QLpkvR2z51jaDUTahtOPL8Ehm2wlT5ebSU/hglzThEKRt5wY4pF
 2YDm7Y9egO9pJ4mmYIwVFfdFWI8ZgX7NfxlrXxKJ+NR1PzNcqeXL6ZZTBQS1MPuIcxIZAo
 SEG9ljde6fzpX/cTioF0M5LrsLZ2en4BpV6rKMMWSJcRCfOJd+WCWfBp5TcB5F+3llDmyf
 oe0odH8BV16WXR4Au0KrkjUNIC6/5GWaC6CpmPvdm1HPnMu90lTuiWYdVyhYSg==
Subject: [PATCH] iio: accel: adxl367: clamp FIFO sample count
Message-Id: <20260809-adxl367-fifo-clamp-v1-1-6eb35eaebcde@cherr.cc>
Content-Type: text/plain; charset=UTF-8
X-B4-Tracking: v=1; b=H4sIAISud2oC/x3MSQqAMAxA0atI1gbSinW4irgoNdGAEy2IIN7d4 vIt/n8gcVRO0BcPRL406bFnmLKAsPh9ZtQpGyxZRy116Kd7rVyDonJgWP12Yk1ijSGmSlrI4Rl Z9P6nw/i+H1GE69JkAAAA
X-Change-Id: 20260809-adxl367-fifo-clamp-50f2110e03f8
X-Original-From: Shengzhuo Wei <me@cherr.cc>
To: "Marcelo Schmitt" <marcelo.schmitt@analog.com>, 
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
	"Michael Hennerich" <Michael.Hennerich@analog.com>, 
	"Jonathan Cameron" <jic23@kernel.org>, 
	"David Lechner" <dlechner@baylibre.com>, 
	"Andy Shevchenko" <andy@kernel.org>, 
	"Cosmin Tanislav" <demonsingur@gmail.com>
From: "Shengzhuo Wei" <me@cherr.cc>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Received: from [192.168.9.107] ([111.42.148.100]) by smtp.feishu.cn with ESMTPS; Sun, 09 Aug 2026 06:32:40 +0800
X-Lms-Return-Path: <lba+26a77ae89+f2d477+vger.kernel.org+me@cherr.cc>
Cc: <linux@analog.com>, <linux-iio@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, "Jonathan Cameron" <jic23@kernel.org>, 
	<stable@vger.kernel.org>, "Shengzhuo Wei" <me@cherr.cc>
Date: Sun, 09 Aug 2026 06:32:37 +0800
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

The FIFO entry count is a 10-bit device-reported value and can therefore
be as large as 1023. fifo_buf[], however, only has room for
ADXL367_FIFO_SIZE (512) entries.

After rounding the count down to a multiple of fifo_set_size,
adxl367_push_fifo_data() uses it directly as the length of a bulk FIFO
read. If the reported count exceeds ADXL367_FIFO_SIZE, this can
overflow fifo_buf.

Clamp the reported entry count to the size of fifo_buf before rounding
it down.

Fixes: cbab791c5e2a ("iio: accel: add ADXL367 driver")
Cc: stable@vger.kernel.org
Assisted-by: GLM:5.2
Signed-off-by: Shengzhuo Wei <me@cherr.cc>
---
 drivers/iio/accel/adxl367.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
index 8c3de11a10a37d228f8758b688156e3ee958c4e9..c82f6c8e5a0d8f4a66ea6c97b78c3838f6138502 100644
--- a/drivers/iio/accel/adxl367.c
+++ b/drivers/iio/accel/adxl367.c
@@ -787,6 +787,7 @@ static bool adxl367_push_fifo_data(struct iio_dev *indio_dev, u8 status,
 	if (!FIELD_GET(ADXL367_STATUS_FIFO_FULL_MASK, status))
 		return false;
 
+	fifo_entries = min(fifo_entries, ADXL367_FIFO_SIZE);
 	fifo_entries -= fifo_entries % st->fifo_set_size;
 
 	ret = st->ops->read_fifo(st->context, st->fifo_buf, fifo_entries);

---
base-commit: 848acc8ffe1b7cd5f1bf427b93069becfebc2c9d
change-id: 20260809-adxl367-fifo-clamp-50f2110e03f8

Best regards,
-- 
Shengzhuo Wei <me@cherr.cc>
