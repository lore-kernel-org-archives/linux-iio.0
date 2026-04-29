Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E453D3FB7E8;
	Wed, 29 Apr 2026 13:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777468058; cv=none; b=Y4tWL7IqgNobk4Rs5jYYIJsZMdiy6I3Y2MOFbEXS/Hd9Jd8e9G2TtPCMBG9qCIivroZihMXauE8/BRKccXY8TMdNtF5okjOp3wMQfYwhVAZ1pU7ck9imP8Iuie4iLFxTaid0/UPodiTXvlqZ3GNyaJWkGDIrdUWnZYE5mvQO20U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777468058; c=relaxed/simple;
	bh=7Mc0VNRZ1CCHsXaSFdFIyxqQMqScXwRjdBvOyAElbig=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DJk2M6do4ux0mno7ljFk74vzQrpTCC8cVRqXhKyWNWwEKCEdnn+p1naanQ0hj8V6rBg6+OjRJp4KVrE4BWjF9zF8Tx/2SiZrt8POpzKnxF4BxXvvt55BNTPcFtM6DPsfuArLYVGPWJKuH9kEvOV9Bgj5y3FzxQEQ49Z0NJKBB9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2DfcT6Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2DfcT6Q"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A26C0C2BCC4;
	Wed, 29 Apr 2026 13:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777468057;
	bh=7Mc0VNRZ1CCHsXaSFdFIyxqQMqScXwRjdBvOyAElbig=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=A2DfcT6QDnOZxeP4IOOFtTPp9dW6rKyPeNBrIIy98brs5OpLeRN8kkS4NtPHiMF+k
	 XDBujp0J93Ln4Xkkep9j2glCWSkNcUUleGC7SOuCVfnj5CkqdG8x7VsqdRxY9cTp0p
	 /g5y2f7GIo94sXboMdstyJRU6rmGLgHo2QrjgBgkqZmJc1nZjyjyhZ57QsWefyxmHs
	 abSN69zmPs80Ws9AYRIius9XG9Oj045spSc3NX3hUqz5LXSOIVGHXTqwgZkZR1b6bg
	 tIwJXRuBlsTB832b4afErY76svdrqGi9ShekdroAo/YiRK/r677ngAY047BFO3eyYy
	 ILSQJloO3gvcg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98114FF8867;
	Wed, 29 Apr 2026 13:07:37 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Wed, 29 Apr 2026 14:07:32 +0100
Subject: [PATCH v4 02/13] iio: dac: ad5686: fix input raw value check
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-ad5686-fixes-v4-2-bb8f1cbd68e1@analog.com>
References: <20260429-ad5686-fixes-v4-0-bb8f1cbd68e1@analog.com>
In-Reply-To: <20260429-ad5686-fixes-v4-0-bb8f1cbd68e1@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777468056; l=1063;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=vDIfN7HwJer2abOZhavJmea2PyXmNcae90gQrhX9MT8=;
 b=HgZk4TEcba2cXSLR98o44JR0MM2hVQBajd6/SvZsOD1dNrrtM1BzsOEdpkEOmh1BS8rYA3i7b
 CDOffrKxWYCBXVqoDz6N91tVnvUFpkHtyfqJ+xXysdkXE/tpGqkfkvq
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


