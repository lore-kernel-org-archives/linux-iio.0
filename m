Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795307744;
	b=o0a5lgQHn4+SjTR6Tmo3uyrKEVG+bw1N9Z77JRe2Jn2j2uazDgYMDAWh/ulcP3+BXa9V
	 VEOubo/7JVwcrDFuxCOR3bKO/XpjsftLnzEDFrPL8mvuAExOqgz5Dkw5ZVurHjsoNGbak
	 wBzy9w+CHQ2uAVi0yQV1kJEGZe9zUX2VEVJnVZOctce+OQZVXOTDPvVkE/PbGHMCbdHsH
	 NRBjHdzQnhKHmznxqTml/GTE77pG0ff4OO/O9/Jd/+RZsnP0uU+Mz+e1+vyx25E81m2so
	 6d21G10dzue68c2jdHhiH+oHOZChjF2EYDmf9ea5yJ2Qydm1+8qrL7qm+r4Ks9N+lqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795307744;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=jtAjgziYdUhr7vDQBpT+TJFCTW2PvS+KD8IFmwBianU=;
	b=0z7Drocbz3V2bCnps3Q6KebVWlmNKSav+WquRWlYdQ6NleJZwvqcrm9Kr/h8KRCC/wGI
	 bCMxmCfFe6RZSbQbtIVj7/u5ECvXoys2n2Jv/7LjS5Fivy8cAjInLBZusoZZNjWjZXWM2
	 VwlumO09nrgcuHoxAid3wutABlZ+d69bRyh+75pZHlKttGgSAiUcF1RrkZ4jRKe+RZgyp
	 Q2DyXsvFUgBPmYCvoMp42CPjld46gYKQEkYu3BFjF8CQUqMF0Vf4VQQIMH0AMyE+md73z
	 qnZid9a8StOdIABupONIX9eCToIDI+9sX23vn8WcFXGhB0isSwJ2JlwHcxt/94RWrSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eVfe2U79;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A8D606A320;
	Sun, 22 Nov 2026 00:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eVfe2U79
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA4B01F000C6;
	Sun, 22 Nov 2026 00:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795307743;
	bh=jtAjgziYdUhr7vDQBpT+TJFCTW2PvS+KD8IFmwBianU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eVfe2U79DfO3RWYCqibAB4BOER1736ttWE1b6iEoNB5RwCg7MNhcMMrjO+FWd+9EQ
	 SVx4x7JaDAopVR6h1FSyVESw6Y58wdkdW8nuwnGWpqNHgPuqtyAdDnzH800uCXoPQl
	 2WS2/vj8P4CkI90hhETGnq79zZlu7GCaSKwCmhjF6usDR3Db77hh+FnMWYblY+tAU/
	 aePfEIAkM+ezvfUAJ0HSk1DqLlZrw6J9y9tjgf4wHtzDp3BdzrwXdSuxbILyIFQNuA
	 KCW9q+iTVchpIOcl8f+2EzrMa0hBJvd41oSDYqEaHLEMinftBjIlcTidhXVHjm10KY
	 5ojyO9Hj/WKJA==
Date: Sun, 22 Nov 2026 00:35:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Mudit Sharma <muditsharma.info@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Matti Vaittinen <mazziesaccount@gmail.com>,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: light: bh1745: fix 16-bit register accesses
Message-ID: <20261122003538.507b6800@jic23-hlaptop>
In-Reply-To: <20261118104534.159876-1-kapoorarnav43@gmail.com>
References: <20261118104534.159876-1-kapoorarnav43@gmail.com>
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

On Wed, 18 Nov 2026 16:15:32 +0530
Arnav Kapoor <kapoorarnav43@gmail.com> wrote:

> The 16-bit colour data and threshold registers are little-endian
> LSB/MSB pairs, but the driver accesses them through regmap_bulk_read()
> and regmap_bulk_write() with an int or u16 buffer and no byte-order
> conversion:
> 
> - bh1745_read_raw() reads 2 bytes into an uninitialised int, so the
>   upper 16 bits returned to user space are stack contents.
> - bh1745_read_thresh() reads 2 bytes straight into *val, which the IIO
>   core leaves uninitialised, with the same result for the event
>   threshold attributes.
> - bh1745_write_thresh() writes the first 2 bytes of an int, which are
>   the upper (zero) bytes on big-endian.
> - bh1745_trigger_handler() pushes the raw register bytes, which are
>   little-endian, in a u16 to a buffer whose scan type is IIO_CPU, so
>   user space gets the samples byte-swapped on big-endian.

Why not flip the channel type endian marking to IIO_LE and push them out
as that?  Normally I'd think this was risk reduction but either the userspace
code is well behaved in which case all fine. Or it isn't and we are on
a little endian platform. No problem.  Or finally it isn't and we are
on a big endian platform. In this case bytes flipped anyway :(

So I think we take no more risk in moving to standard IIO approach
of doing as little as possible in the buffered path and leaving
it to userspace.  So I think we should flip the channel type, change then
entry type in scan and push the thing little endian.

The rest looks great and your fix is correct, just a tiny bit
away from what I'd prefer.  One other whilst you are here
thing inline.

Jonathan



> 
> Use an __le16 buffer for all of them and convert with le16_to_cpu() /
> cpu_to_le16().
> 
> Fixes: eab35358aae7 ("iio: light: ROHM BH1745 colour sensor")
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
  
> @@ -741,18 +753,18 @@ static irqreturn_t bh1745_trigger_handler(int interrupt, void *p)
>  		u16 chans[4];
>  		aligned_s64 timestamp;
>  	} scan = { };
> -	u16 value;
> +	__le16 value;
>  	int ret;
>  	int i;
>  	int j = 0;
>  
>  	iio_for_each_active_channel(indio_dev, i) {
>  		ret = regmap_bulk_read(data->regmap, BH1745_RED_LSB + 2 * i,
> -				       &value, 2);
> +				       &value, sizeof(value));

Can just do the bulk read directly into &scan.chans[j++].

>  		if (ret)
>  			goto err;
>  
> -		scan.chans[j++] = value;
> +		scan.chans[j++] = le16_to_cpu(value);
>  	}
>  
>  	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
> 
> base-commit: 51b83d4cb0f5c1342868c7aa1edbf0c4867477aa

