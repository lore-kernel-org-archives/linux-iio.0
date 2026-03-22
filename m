Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8911F35970F;
	Sun, 22 Mar 2026 13:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774187302; cv=none; b=ON2gwrf491+d3WVQ5rTt0hyLZP14rLp9YUbZp/azQIwoScpJoW3QrP9b785LJkOV5KJr3SfSjdWBLPwF+23gBVnztbnvz8YRRr6VRVYkJMEO//RokpIF9jomq5BTZsjo7mDUaIb3FJvWoDJDHZY3VQCbfq90CRGaRMotbIW9AIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774187302; c=relaxed/simple;
	bh=5ovdOlKNAikiE7mZk8iLh1vFom4FeHKpstIUYdf1vOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NSuhuGj3DGPINvlciWH449jFZcmxt5LQiqrk5mjmx8p8K77lZdflxGOccRL0u8Q9KlFbxAeR0JBSt7/HD8wbOssnrgcc3cSuhI8h5pBSyM4oe/hBDXCSoGprnuhv1Dryy1AwL0Z5onpIwUAfj3Cy0vAUBfVSn4BrHiGoOwby/o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.197])
	by APP-05 (Coremail) with SMTP id zQCowAAXrA8X879pnpYmCw--.21437S2;
	Sun, 22 Mar 2026 21:48:08 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: linux-iio@vger.kernel.org
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Gyeyoung Baek <gye976@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: chemical: mhz19b: bound receive buffer copy
Date: Sun, 22 Mar 2026 21:48:07 +0800
Message-ID: <20260322134807.16217-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260322031923.58031-1-pengpeng@iscas.ac.cn>
References: <20260322031923.58031-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAXrA8X879pnpYmCw--.21437S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jr47AF15CrWkWw1UZF1rtFb_yoWkXwc_C3
	W8Arn7ZrW5CFnrKan2vF1a9rySya9F9F1UW3WavasxGry2qFn7Zw4kZr43KrsxWF4I9Fnr
	Xw4DWr1Svry3CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbcAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_
	Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYCJmUUUUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

`mhz19b_receive_buf()` appends bytes to the fixed 9-byte command buffer
without first checking that the new chunk fits in the remaining space.
A single receive callback can therefore write past the end of `st->buf`
before the driver sees that the command is complete.

Drop overlong chunks and reset the partial command state before the
copy.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/iio/chemical/mhz19b.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/chemical/mhz19b.c b/drivers/iio/chemical/mhz19b.c
index 3c64154918b1..fbd7f14483b3 100644
--- a/drivers/iio/chemical/mhz19b.c
+++ b/drivers/iio/chemical/mhz19b.c
@@ -240,6 +240,12 @@ static size_t mhz19b_receive_buf(struct serdev_device *serdev,
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(&serdev->dev);
 	struct mhz19b_state *st = iio_priv(indio_dev);
+	size_t remaining = sizeof(st->buf) - st->buf_idx;
+
+	if (unlikely(len > remaining)) {
+		st->buf_idx = 0;
+		return len;
+	}
 
 	memcpy(st->buf + st->buf_idx, data, len);
 	st->buf_idx += len;
-- 
2.50.1 (Apple Git-155)

