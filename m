Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795226155;
	b=t3PmcR9FutbE4jmhDte+Q0Bd34l55UaP9ghaLaSzRpUKgsx5UDBWlfNYGgRCruQYjoec
	 oDd8p5lbDuNwzn/G74qtw2Vr2vgmGQ0F3G4fy2HgtSse1L1Nxnp24ulwwKMpG0Kuu79oF
	 KGhvtfTmalK+Hl80ITFRHp2uf+5dbSnkEj0V2v0F87Ru2CxVAQgy0/6Xy5Th+DWnYcreG
	 csB1djO0AV8e3m/kKp1aARPCtkVOAGXwEKD+giCIrPv4sm5QKZ4ln4dup5qekAjqcJ+eo
	 y7+Got3T6hIuosueVS/pooHQQwLEEhxAKHEM45ODjNUV20r8SVgodQbUIZXfG0P9DyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795226155;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=r11ans6/yVi8ftZwezvBf7Gi5MF80z86LIKhFZsaBSQ=;
	b=adlzo7esYxZBG/3c4rqkcPfy+5blJhOGRktnrjIXZ9iIRjfpLjZ/++Xqer+Pnb1LHEyD
	 olyBY6nbxr0LG05SIo3uLF2byQagewfrri4/xeFNToztVqqReQoBJFcTuKVjv/CpksLw/
	 eAhJVg9QTuAFFNhRoAAIIzZmbjvQP2koQjX95is9rt63U2QWRhQHyIC14thpv7F2ipCla
	 9f2vAlZpho/VLrLqqaJeTLDeUO6LXpkmYEzefE06if+VUzXATHV8rE05wRm6uaF0xZYjG
	 sbrjT/VsByW6AlaG8eMelKo7pw93Q0Y359iGYEPqY1iajhX7nHitfbHfTWbwus8xwRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ESkxQSCo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65582606A6AF;
	Sat, 21 Nov 2026 01:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ESkxQSCo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E7C1F000C0;
	Sat, 21 Nov 2026 01:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795226154;
	bh=r11ans6/yVi8ftZwezvBf7Gi5MF80z86LIKhFZsaBSQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ESkxQSCoUPF9q7SWD6Wza+agxp7u0m1UreoSgnf0RP/Evt+CLpYElOHDXEz0BRf2V
	 3ZTgLLFFqzzcGx8NUaeuByZFaE5bDonGUmKp2qqlPYvivBHeHP/3OvujSdGJE3joaD
	 KqWFef2gna0VSwA2guDehz3eJekvf/sZRYeZBSeSvR3QvhGUYZCj5LfigoB/tgMtj0
	 xkpGry9+ZeoUN7G9iCiJhdKeRy6Eds7qQOs4vwFPez/OFjaFq8a/LiuuupwbA8egEZ
	 tpG4KrUA/a1RNg+/H1LjpR+BZmd7nhLsTgZAS7MXx4DYKt0gztTHmQpmyEPo6FwTBL
	 TaRAMdZiAl9bg==
Date: Sat, 21 Nov 2026 01:55:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: YuanZhe Liu <25031212351@stu.xidian.edu.cn>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>
Cc: Andy Shevchenko <andy@kernel.org>, David Lechner
 <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bin Yu <byu@xidian.edu.cn>, Cheng Wen
 <wencheng@xidian.edu.cn>
Subject: Re: [PATCH v2] iio: buffer: kfifo: reject lengths exceeding the
 kmalloc limit
Message-ID: <20261121015549.4b6148b3@jic23-hlaptop>
In-Reply-To: <20261120164403.5691-1-25031212351@stu.xidian.edu.cn>
References: <awBz8LVSYVBFOANe@ashevche-desk.local>
	<20261120164403.5691-1-25031212351@stu.xidian.edu.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 21 Nov 2026 00:44:03 +0800
YuanZhe Liu <25031212351@stu.xidian.edu.cn> wrote:

> __iio_allocate_kfifo() only rejects lengths that would overflow an
> unsigned int after kfifo rounds them up to the next power of two, but
> the byte size handed to __kfifo_alloc() can still be beyond what
> kmalloc() can serve.
> 
> The kfifo buffer is allocated with kmalloc(), which is limited to
> KMALLOC_MAX_SIZE.  A larger request has an allocation order above
> MAX_PAGE_ORDER, so the page allocator's order sanity check fires and
> enabling the buffer ends with a WARNING instead of a clean error.
> 
> The buffer length is set through buffer/length, which accepts any value
> up to UINT_MAX.  With the voltage and timestamp scan channels enabled,
> a length of 262349 makes the rounded up size exceed KMALLOC_MAX_SIZE
> and triggers the warning on buffer/enable.
> 
> Reject lengths whose rounded up size does not fit into KMALLOC_MAX_SIZE
> so that enabling the buffer fails with -EINVAL.  This bound is stricter
> than the unsigned int overflow check it replaces, because
> KMALLOC_MAX_SIZE is far below UINT_MAX, so that check is removed.

There is a lot here, when it could just say

__kfifo_alloc() uses kmalloc to allocate the FIFO. Tighten the limit
of __iio_allocate_kfifo() to match.  This results in -EINVAL being
returned on oversized requests rather than XXXX.


Note I can't tell from this description what that ABI change is
as you don't include that information which is neeeded.

However that's an implementation detail of KFIFOs sneaking
across the boundary.  Given the allocation call fails anyway, why
do we care about short cutting it?

> 
> Co-developed-by: Bin Yu <byu@xidian.edu.cn>
> Signed-off-by: Bin Yu <byu@xidian.edu.cn>
> Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
> ---
> v2:
> - Drop the unsigned int overflow check.  It is subsumed by the new
>   KMALLOC_MAX_SIZE bound: a length that would overflow the kfifo
>   element counter exceeds KMALLOC_MAX_SIZE as well (Andy Shevchenko).
Two process things.

1) Slow down.  Even for a small patch like this, a few days for
first round of reviews.

2) Don't send new versions in replies to old ones.  Generally means
   your emails are hidden away and can occasionally trip up tooling.
   I'm not aware of any area of the kernel that takes things like
   this.  Seems to be a pattern the LLMs have learnt from other
   projects.

> ---
>  drivers/iio/buffer/kfifo_buf.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/buffer/kfifo_buf.c b/drivers/iio/buffer/kfifo_buf.c
> index b67ea6468226..65906dfffc04 100644
> --- a/drivers/iio/buffer/kfifo_buf.c
> +++ b/drivers/iio/buffer/kfifo_buf.c
> @@ -29,10 +29,14 @@ static inline int __iio_allocate_kfifo(struct iio_kfifo *buf,
>  		return -EINVAL;
>  
>  	/*
> -	 * Make sure we don't overflow an unsigned int after kfifo rounds up to
> -	 * the next power of 2.
> +	 * The kfifo memory is allocated with kmalloc(), which cannot serve
> +	 * more than KMALLOC_MAX_SIZE.  A larger request needs an allocation
> +	 * order above MAX_PAGE_ORDER and is refused by the page allocator
> +	 * with a warning.  KMALLOC_MAX_SIZE is far below UINT_MAX, so this
> +	 * also keeps the element count rounded up by kfifo within an
> +	 * unsigned int.
>  	 */
> -	if (roundup_pow_of_two(length) > UINT_MAX / bytes_per_datum)
> +	if (roundup_pow_of_two(length) > KMALLOC_MAX_SIZE / bytes_per_datum)
>  		return -EINVAL;
>  
>  	return __kfifo_alloc((struct __kfifo *)&buf->kf, length,

