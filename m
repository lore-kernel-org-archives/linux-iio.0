Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A300F37DEAD;
	Sun, 22 Mar 2026 03:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774149579; cv=none; b=BymPYcS9ptSacoT//lIYxAw8NfN2ozv16hzV4XjMLC/nMr2g8quSUuSTIHwTJTZT1YxeQCaZrp1Qmga/7lz7hQVvsx2EKiLtnkOMh7HNdKTGNXqQWIu4wuuZQsdxO+YkP7s3W7KSKzFQPjS6dZvWUXM7Dx/2Iy+q6KIdpe1yMKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774149579; c=relaxed/simple;
	bh=dRRHJP/o97UdiIWF7mfrp2KAzhmcDLpnzYSFg3fB5E0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bYJLTWDmCecvhm+3Fckzq/Gk51XHYsJB8C9BTzUmmRHb8246DlvCxbvGGgASRN46w3H3nUoh+6/fZD+04rixcKdKwgrRW6Iy4urvzBwHUfvkZbmp8/TlFdLgAXZwvPbH2sUI+xlI7g/UFlLR1o5M2wiKwFdK1+cmMykITNtRSI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.197])
	by APP-05 (Coremail) with SMTP id zQCowAAXpQi7X79p2k8eCw--.33030S2;
	Sun, 22 Mar 2026 11:19:24 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: linux-iio@vger.kernel.org
Cc: pengpeng@iscas.ac.cn,
	Gyeyoung Baek <gye976@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: chemical: mhz19b: bound receive buffer copy
Date: Sun, 22 Mar 2026 11:19:23 +0800
Message-ID: <20260322031923.58031-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAXpQi7X79p2k8eCw--.33030S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jr47AF15CrWkWw1UZF1rtFb_yoWDKrb_C3
	W8Arn7urW5GFnrKan2vF1a9ryaya9F9F17Wa1avFy3Gry2qFn7Zw1kZrsxKrsxuFWI9Fnr
	Xw4DWF1Svry3CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJV
	W0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUmjgxUUU
	UU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

`mhz19b_receive_buf()` appends bytes to the fixed 9-byte command buffer
without first checking that the new chunk fits in the remaining space.
A single receive callback can therefore write past the end of `st->buf`
before the driver sees that the command is complete.

Drop overlong chunks and reset the partial command state before the
copy.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/iio/chemical/mhz19b.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/chemical/mhz19b.c b/drivers/iio/chemical/mhz19b.c
index 3c64154918b1..a028216fa2a9 100644
--- a/drivers/iio/chemical/mhz19b.c
+++ b/drivers/iio/chemical/mhz19b.c
@@ -241,6 +241,11 @@ static size_t mhz19b_receive_buf(struct serdev_device *serdev,
 	struct iio_dev *indio_dev = dev_get_drvdata(&serdev->dev);
 	struct mhz19b_state *st = iio_priv(indio_dev);
 
+	if (len > sizeof(st->buf) - st->buf_idx) {
+		st->buf_idx = 0;
+		return len;
+	}
+
 	memcpy(st->buf + st->buf_idx, data, len);
 	st->buf_idx += len;
 
-- 
2.50.1 (Apple Git-155)

