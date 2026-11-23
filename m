Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795416839;
	b=Lir2TobMCHVwEdUzwQH1KL8C6kgVieDiTx0152weY2ta8wKOgjU+JV/JfIxmngGEtcd1
	 BJBLlS1aMQFCz3aD9mtflu4qOE3D/jeYw8tcSGjuOhSnXnQWOyErNYtFallYlwW4EFfQU
	 l+IvU3JAY0T7J4kjIXZ/emPqEp0/Wzt9q94PSGShOo0XbQoQKWbKMmhtWMbV3h9oKFM+O
	 nihaNPwIgKOCmoqkU9jzXKhG3V5RVO2rUZzAUV96cbNn5Tc9dRSsyMCNt588GnlR6OhQU
	 4oit5ajrhqi0Ka62smMyW9wUn9lmZXt1qrMvfTBN6JdBHo1aGbCpd9Ws5ujwj7OSXPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795416839;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=XT0ue0W0cWby7ZUYVFIEwVyr7HiQ21d2sOlr1W1WelU=;
	b=4RgkWoBRsm8Z45ErqjUcfh6WUWeUdKMfrqnruupgQm5xyoNWQS1KZiWT3QwsN5U7fF1z
	 nuc5+sWnmdWmXM+T847Y5lkK0uB2Xcz9PXwa8FMNjt1iKhq+K6JD2R6hOy5qH3kN1GX/5
	 7loQGpGrd/qcWY37yC3v3qVpfeXFjZ1jvIqtyQsy3/Z4H+sEyfgR5r9I7DPVrUG/WHeSh
	 8ucD5qhbbP9A6q55TXC1pARQvkyCmDesvvo0xfPdxEPmHTBpHY7QfYAKezxigE1SGP4B4
	 yPl6FqxPvUgt1SFUwUHso5MvF/HlfJ07ve3o41vImBp6VJ2B4uA8u4a3ISDJXw+2wJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39D1606A31A;
	Mon, 23 Nov 2026 06:53:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D39D1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=XT0ue0W0cWby7ZUYVFIEwVyr7HiQ21d2sO
	lr1W1WelU=; b=vgswTjRWLJqQsuSZAXBCB9tnvSI3/su5RD5cBAuR3TTjaWXBFL
	OX7hI2p7qJ+sx2jceJUQnYr5YizbB8u3U3Or2hF7pRO1f5+Zj9zoYuUj3JKjKEey
	LyErABkRaQz4ekOUQVNotuycngvr2eiJucPgnmTxEGNqwoLe3wHIqQkOw=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.70])
	by hzbj-edu-front-4.icoremail.net (Coremail) with UTF8SMTPA id BrQMCkBmhfv44gNruDkaAg--.65412S2;
	Mon, 23 Nov 2026 14:53:45 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: Re: [PATCH v2] iio: buffer: kfifo: reject lengths exceeding the kmalloc limit
Date: Mon, 23 Nov 2026 14:53:43 +0800
Message-Id: <20261123065343.3013-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261121015549.4b6148b3@jic23-hlaptop>
References: <20261121015549.4b6148b3@jic23-hlaptop>
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
X-CM-TRANSID:BrQMCkBmhfv44gNruDkaAg--.65412S2
X-Coremail-Antispam: 1UD129KBjvJXoW7trW8Xr18Jr4UXr1DCFWrAFb_yoW8Jw1fpF
	ZxKwsYyrn5Kr1IgFn7Aw47JFyFkan5u345JF4UWw1Yv39xKr4a9FyrKFZ0qFyxCrn3tayU
	tFWYvFy3GFWkZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9vb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r
	18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lc7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r47MxAIw28IcxkI7VAKI48JMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUY1mh3UUUUU==
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUFD2sDBVgdigAEso

Hi Jonathan,

Thanks for the review, and point taken on both process items.

> However that's an implementation detail of KFIFOs sneaking across the
> boundary.  Given the allocation call fails anyway, why do we care about
> short cutting it?

The allocation does fail, but not quietly: the request reaches the page
allocator with an order above MAX_PAGE_ORDER, so alloc_order_allowed()
emits a WARN_ON_ONCE_GFP() with a stack trace (once per boot) before
returning NULL.  A write to buffer/length followed by a write to
buffer/enable therefore produces a kernel warning for what is only a bad
user-supplied value.  The check turns that into a plain -EINVAL; short
cutting the failed allocation is not the goal.

You are right about the changelog.  The ABI change is that buffer/enable
now returns -EINVAL instead of -ENOMEM, and it needs to be stated.  I'll
use the short form you suggested and trim the code comment so it no
longer explains page allocator internals.

On the placement: the check lives in IIO because that is where the length
is validated and where a useful error can be returned.  If you would
rather have lib/kfifo enforce this for every kfifo user instead, I can
move it there - just let me know.

The next version will go out as a new thread, with a few days left for
further comments.

Thanks,
YuanZhe

