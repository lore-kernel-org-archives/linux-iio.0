Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794167537;
	b=E8LExl1qxmKDXU6mSCTAjyNvtQn6ByXB4xdb5BQxoNmyOCWJ4K39pj8nEGbaxU8817O+
	 Ka6/GE1P07RjiSCR8taNVW9SKBkIRk5PO0e9d3+7JgzHwBhKvL90lCmWRjL/XZQn5w6VB
	 TGuzyJnnDuLZHS+CQGreUtISP0oEJBmP8Hi/AhIZE+L/wyv6nX1WcywVISaUMBI4USTck
	 SasxiJyZeZd+N0gyRBIX4+HFvFkQ/zlFxAiooO72hk8Douf0JzcjvOy27xpqHZq+aUSoh
	 WyDcOo+9tq2gmkDGz/aN+j+sNhQycXkUwZYbr1bSuakLjIQhY9DJKVMD6RmOO5j69Gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794167537;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=GgHKeuMXIr7h7giifAmuiivrib6WaMbioy4A3SnSoOA=;
	b=PXYkw7lNz1PC1d6cbqnLNHzcEmAQLkg/O1sV2wGmjPKp7Lmp57uZKFjLhBuL7YOOwzcl
	 T3MyyLMP/bGgE9fQgcldnjxanJiR39IqcNosDSLQOZvMss00q7hH9yv0jzr9mgWgc0Cop
	 wFMWiBBFECS2OPhekEjpg1L3St2O34Xf5QYlbBoM1BBiKkIM7YS56zwPzkK0WsIXJWtWJ
	 uCSqjNSSytuPOl54ytaVouXYRrAisI904bxQRaTRSgfMMKvOz/N5Do/Vt40IOkKwZbb/k
	 /0qulFRzCTSxp8+hUCg9KXiKWchLiev+SMAQcSQEn0zMAAVDWZMfYk5ULqqnh+c4gQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ju+iO+oq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1B7606A31C
	for <linux-iio@vger.kernel.org>; Sun,  8 Nov 2026 19:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ju+iO+oq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 452DD1F0089F;
	Sun,  8 Nov 2026 19:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794167537;
	bh=GgHKeuMXIr7h7giifAmuiivrib6WaMbioy4A3SnSoOA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ju+iO+oqvFUHt4tMboRK/NDsK7us3NE2v/0VnfV9jSdzAG82ZzBi3zkolgDBvB3C9
	 kNTye0p2uGudwP8wEWGlSfWTCwa7AXElQvYHqXrGzPmuzmdLeHfzzTiRfEeFRKRY3h
	 XrgMZb07YhpkhNHMmL+B1jGy/AupoJqvZj2czHn5zgOukZguCy3sv+RQLFtFmzcCjC
	 WK6HL3Ne8QxxeiRErimWiXm9YS6CoBtNyAXyVVVZ8+XEfKE7wt6e1KuVZgiBtRH8Yg
	 kc7TNxAVSpDYhtnb4V7S0Hfxq+5jO8y7WGNE9EsWn6lAeCvlt79Z/khd9no4lJHKc5
	 UNh4WLlaaavew==
Date: Sun, 8 Nov 2026 19:52:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH 18/39] iio: health: afe4404: use
 iio_push_to_buffers_with_ts()
Message-ID: <20261108195210.6c9da0c3@jic23-hlaptop>
In-Reply-To: <auBga-hNhlTOSwAG@ashevche-desk.local>
References: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
	<20261026-iio-v1-18-8b136778eedf@oss.qualcomm.com>
	<auBga-hNhlTOSwAG@ashevche-desk.local>
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

On Tue, 27 Oct 2026 10:27:23 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Oct 26, 2026 at 04:05:36PM -0700, Jonathan Cameron wrote:
> > Replace the deprecated iio_push_to_buffers_with_timestamp() with
> > iio_push_to_buffers_with_ts(), passing the size of the pushed buffer.
> > 
> > The pushed buffer is never a direct DMA transfer target, so move it
> > from the per-device state to the stack. Use
> > IIO_DECLARE_BUFFER_WITH_TS() since the timestamp offset depends on the
> > number of enabled channels, and zero initialize it.  
> 
> ...
> 
> > static irqreturn_t afe4404_trigger_handler(int irq, void *private)  
> 
> >  	struct iio_dev *indio_dev = pf->indio_dev;
> >  	struct afe4404_data *afe = iio_priv(indio_dev);
> >  	int ret, bit, i = 0;
> > +	IIO_DECLARE_BUFFER_WITH_TS(s32, scan, 10) = { };  
> 
> Move it one line up.
> 
> ...
> 
> >  	iio_for_each_active_channel(indio_dev, bit) {
> >  		ret = regmap_read(afe->regmap, afe4404_channel_values[bit],
> > -				  &afe->buffer[i++]);
> > +				  &scan[i++]);  
> 
> Also possible to have now
> 
> 	struct regmap *map = afe->regmap;
> 	...
> 		ret = regmap_read(map, afe4404_channel_values[bit], &scan[i++]);
> 
> (which will have the same amount of LoC).
> 
> >  		if (ret)
> >  			goto err;
> >  	}  
> 
> ...
> 
> > -	iio_push_to_buffers_with_timestamp(indio_dev, afe->buffer,
> > -					   pf->timestamp);
> > +	iio_push_to_buffers_with_ts(indio_dev, scan, sizeof(scan),
> > +				    pf->timestamp);  
> 
> One line?
> 
All tweaks made and applied.

J

