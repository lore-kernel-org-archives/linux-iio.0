Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795181031;
	b=ufZFjdnmx8CdSrZoJ+S0MhpYvMtVLp6De/Af2AuQr0I2szjz61MT0VjpP8W7KO9M06ko
	 J+grhfeaSllYTnA3lvPMXbim+JbtiDgizJBhLYC6Ex3UHHssFdfOTyDshzNeNWx6jjhQY
	 VAD3TQT2khleaUiYHll5nWCBySUF4I/1RlPrYCxHj0fiiUHL+T1uClHvRH6zgXPoDiKgx
	 C8acVCkf7rvowD+vP787GAuKu04m/VhhPullaCy7kCS51CwL+OCpSVh+g2fupmFZg5C7N
	 VfMTqhye4XHRs5kbpbbH/MZ96ImIOJaSSZao7JcVO5k6Qy4JmCE3dHDjqgZ/En+n3tA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795181031;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=bKJBUT4xEHvdpkj1filnp4E+Bb3QrjcLblSYgGD9hEQ=;
	b=ameSe83lAHGJcgTcebZbPB1pbP8AgWyQ30LkfLBwecAt7BV+8wOH4BfPn8aItpXTmwCp
	 ubfFuxBm6IMeKw1Q7mTd+3yzyDoGHsPDGLQ0P2XwvosKo+H/7mn3IjZ1OfUJklahubNqn
	 OwZ8PTisp6rFZ+W6UJcG2YKdvgJjYq9S9QQMwGEfMHR14AUO8iE9CzaSd4oFn2dYzfYw2
	 tQWfyYJw1ogjXOiQsoZ2yGxNlrZHtQWMYKBpjzfWMGD0kUBJXwmn0yn16rBLh4U9B0fC3
	 V0FaHdEBIfo4/OWr349WP11hgy42IQnO+/6ospPfscemTDclHBn3zxSx44/9MPjj7TQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94954606A332;
	Fri, 20 Nov 2026 13:23:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94954606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=bKJBUT4xEH
	vdpkj1filnp4E+Bb3QrjcLblSYgGD9hEQ=; b=ybo65L1F8k5GC3bMN23hFk4EQS
	x2MYDr0qso3Cszs03WhQv7llepTQ/LpkDCXZIpSdrNgx0nf2TRcmH0HaQAAu3JiO
	V6bhIXc5LUZVWja3hKtqEdd6wgNVfnlAnQPobRVyAYsQrEXoien5LgYiZs9j8kyq
	+xz1QJqmbYjBL9aCY=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.41])
	by hzbj-edu-front-3.icoremail.net (Coremail) with UTF8SMTPA id BbQMCkC2uv1fSQBr26DxAQ--.35878S2;
	Fri, 20 Nov 2026 21:21:36 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH] iio: buffer: kfifo: reject lengths exceeding the kmalloc limit
Date: Fri, 20 Nov 2026 21:21:29 +0800
Message-Id: <20261120132129.3110-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BbQMCkC2uv1fSQBr26DxAQ--.35878S2
X-Coremail-Antispam: 1UD129KBjvJXoW7urWUCFWDtw4kJFyUCw4xXrb_yoW8ur4DpF
	4akryIyrZrXFnrGw45Aa13Ja4rXws5XFyDWayaq345uws8ZF4DuF98KrWqvryjyr1FkF1f
	tF98tFW7Wry5A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvGb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r
	18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjxU2QzVUUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUDD2r-E0n0kQAAsh

__iio_allocate_kfifo() rejects lengths that would overflow an unsigned
int after kfifo rounds them up to the next power of two, but the byte
size handed to __kfifo_alloc() can still be beyond what kmalloc() can
serve.

The kfifo buffer is allocated with kmalloc(), which is limited to
KMALLOC_MAX_SIZE.  A larger request has an allocation order above
MAX_PAGE_ORDER, so the page allocator's order sanity check fires and
enabling the buffer ends with a WARNING instead of a clean error.

The buffer length is set through buffer/length, which accepts any value
up to UINT_MAX.  With the voltage and timestamp scan channels enabled,
a length of 262349 makes the rounded up size exceed KMALLOC_MAX_SIZE
and triggers the warning on buffer/enable.

Also reject lengths whose rounded up size does not fit into
KMALLOC_MAX_SIZE, so that enabling the buffer fails with -EINVAL.

Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/iio/buffer/kfifo_buf.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iio/buffer/kfifo_buf.c b/drivers/iio/buffer/kfifo_buf.c
index b67ea6468226..2069d7ca4409 100644
--- a/drivers/iio/buffer/kfifo_buf.c
+++ b/drivers/iio/buffer/kfifo_buf.c
@@ -35,6 +35,15 @@ static inline int __iio_allocate_kfifo(struct iio_kfifo *buf,
 	if (roundup_pow_of_two(length) > UINT_MAX / bytes_per_datum)
 		return -EINVAL;
 
+	/*
+	 * The kfifo memory is allocated with kmalloc(), so the size must also
+	 * fit into the largest allocation kmalloc() can serve.  Larger
+	 * requests need an order above MAX_PAGE_ORDER and are refused by the
+	 * page allocator with a warning.
+	 */
+	if (roundup_pow_of_two(length) > KMALLOC_MAX_SIZE / bytes_per_datum)
+		return -EINVAL;
+
 	return __kfifo_alloc((struct __kfifo *)&buf->kf, length,
 			     bytes_per_datum, GFP_KERNEL);
 }
-- 
2.34.1

