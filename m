Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795193063;
	b=FhjRAK5YmCgQkoeAvrcQFrcHkkIneTd+PuVsIHItjm/6wgpcEM0fm//ITpEfG9bW9A8b
	 ExXRO2aRx9UzenUa0Ll/ZDAy9HvdX/M5z704Z3avkM0Qoabk8wFzhORNoFoLduX2L6/Qo
	 QIE+I/a80t3FmhfQuornLzVNHdidbJeLB8I3uRBjV0WfX7dD16WgoOt8oUKDZ61xUyZ+A
	 y1Y8h/+U3FoK2kC0a5kpUPtFacOFQ85a3yZZHERyjqbwMTmi0HeVfp3rtVDf4o7sonp6H
	 PaSfFc6s1/RlI8j2Unwz8XOxlGIYG3dVYIdRjNcaNmLnR49fH4ksHWANxy4jtyD4fqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795193063;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=FuLu2+fMG1j9rQrc9nXEfPdssX85+2pyJ3lybGhChTU=;
	b=voycZw6DxVDGGHNaxemljm5XXCD5y9jxzS9DSIKUS4ADal3OoufA/uDQuSq+jzZUpdcx
	 ouohVC39rgenKV6ZNYNtBkAMxuP0gP5EGcM0zG13Wyap/e7+Ns6HJUG1/RmXbV7/cs0Ha
	 nrxnlpW3NvLHK5Xfn9Y1/WsMWQ82dw7/66iQTfc+MlYNv0MbO2JKqHEztNsg4TYiGmIYt
	 k07dSMcth5NXX89DFLSLItK1iwnnVSb0n0Het/G8zvChIf86kfrpIVhToXV6hJPFRGs0w
	 z84VpFzq9LViB9dwhVcgY1BVPZ9CwkPbjJYUadkPsOq0iaPmaunffCWPI064XA4tqYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD75C606A604;
	Fri, 20 Nov 2026 16:44:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD75C606A604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=FuLu2+fMG1j9rQrc9nXEfPdssX85+2pyJ3
	lybGhChTU=; b=D878DwE4R7woQcKC1tVUj9Lv4kx0Ker9GcGZ/0kgW9l96GvdwA
	p05UB+lzVD/WqG1Tyqn+eEA+LqfSY78ANMR7lcueDsqQCUJ57Vk7AJV9mbk5Rtix
	40AAYudisjlZGWnI37K6OY9pfwsMq9j+H0sRDEnviaTShXECf7nXgFjdA=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.41])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkB2vwTUeABrJ6_0AQ--.6051S2;
	Sat, 21 Nov 2026 00:44:05 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH v2] iio: buffer: kfifo: reject lengths exceeding the kmalloc limit
Date: Sat, 21 Nov 2026 00:44:03 +0800
Message-Id: <20261120164403.5691-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <awBz8LVSYVBFOANe@ashevche-desk.local>
References: <awBz8LVSYVBFOANe@ashevche-desk.local>
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
X-CM-TRANSID:BLQMCkB2vwTUeABrJ6_0AQ--.6051S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXFWfZF1DKrWxuFyDCFyrXrb_yoW5GFykpr
	W3K3WjyrZrXFnrKw1UAw43ta4rXws3Xas8GayfX345Zr45Xan5ua4qkrWrZr18Ar1F93W7
	tF9xKFWrWr1UAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15Mc
	Ij6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l
	c7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r1l42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUs1xRUUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUDD2sAYlgUOwABs3

__iio_allocate_kfifo() only rejects lengths that would overflow an
unsigned int after kfifo rounds them up to the next power of two, but
the byte size handed to __kfifo_alloc() can still be beyond what
kmalloc() can serve.

The kfifo buffer is allocated with kmalloc(), which is limited to
KMALLOC_MAX_SIZE.  A larger request has an allocation order above
MAX_PAGE_ORDER, so the page allocator's order sanity check fires and
enabling the buffer ends with a WARNING instead of a clean error.

The buffer length is set through buffer/length, which accepts any value
up to UINT_MAX.  With the voltage and timestamp scan channels enabled,
a length of 262349 makes the rounded up size exceed KMALLOC_MAX_SIZE
and triggers the warning on buffer/enable.

Reject lengths whose rounded up size does not fit into KMALLOC_MAX_SIZE
so that enabling the buffer fails with -EINVAL.  This bound is stricter
than the unsigned int overflow check it replaces, because
KMALLOC_MAX_SIZE is far below UINT_MAX, so that check is removed.

Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
v2:
- Drop the unsigned int overflow check.  It is subsumed by the new
  KMALLOC_MAX_SIZE bound: a length that would overflow the kfifo
  element counter exceeds KMALLOC_MAX_SIZE as well (Andy Shevchenko).
---
 drivers/iio/buffer/kfifo_buf.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/buffer/kfifo_buf.c b/drivers/iio/buffer/kfifo_buf.c
index b67ea6468226..65906dfffc04 100644
--- a/drivers/iio/buffer/kfifo_buf.c
+++ b/drivers/iio/buffer/kfifo_buf.c
@@ -29,10 +29,14 @@ static inline int __iio_allocate_kfifo(struct iio_kfifo *buf,
 		return -EINVAL;
 
 	/*
-	 * Make sure we don't overflow an unsigned int after kfifo rounds up to
-	 * the next power of 2.
+	 * The kfifo memory is allocated with kmalloc(), which cannot serve
+	 * more than KMALLOC_MAX_SIZE.  A larger request needs an allocation
+	 * order above MAX_PAGE_ORDER and is refused by the page allocator
+	 * with a warning.  KMALLOC_MAX_SIZE is far below UINT_MAX, so this
+	 * also keeps the element count rounded up by kfifo within an
+	 * unsigned int.
 	 */
-	if (roundup_pow_of_two(length) > UINT_MAX / bytes_per_datum)
+	if (roundup_pow_of_two(length) > KMALLOC_MAX_SIZE / bytes_per_datum)
 		return -EINVAL;
 
 	return __kfifo_alloc((struct __kfifo *)&buf->kf, length,
-- 
2.34.1

