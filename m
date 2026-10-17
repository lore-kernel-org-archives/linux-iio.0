Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07D8345EB0;
	Sat, 17 Oct 2026 18:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792262833; cv=none; b=ocRjpMDD6I85/hCg9f4itM7Pfw1S7SkpOqm76JW7sl04QPxqgLpCUe8bDBgsbLeU4cHHeoMWLmTcka001GGXMZ5euMH4pJ/DM5nAFd11UN/dVhRzIC+a9OsCft+csHLm0frR3Hti57VL/NRBF6yxaREiqZXFqLnTeb+wi5aPsPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792262833; c=relaxed/simple;
	bh=87oqsfBHVVsxZCaoGGkSeSOKMcNv2pQTppzPbV1NvP8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OQWUMuNZ7rkudmHq5LDhNcTrUh7eySTs6KZBqdnn4teRFMNsptrldtptync6ysHwnTcwn6bwV/6OUhp+DjvuxdKK2RyPDyye0ZTjWpl6N4A4/BXYhGyO/b6/p2jdNuUFNJ8XqEU00x2hvAO34zV5w5G022yLnTNS7xXVpEmFpmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndRCpubm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndRCpubm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62441F000C4;
	Sat, 17 Oct 2026 18:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792262832;
	bh=sYvlStSz66uv+NV8wsfZqePA2CSRPfCcdD359Kbd6oU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ndRCpubmDwY7H7OeTREabElrmk2+OL324MtiNyqRcLiCB2llsNOgKpOD4uVAw3XtC
	 99REncwgqPu73VeafVIml/s7JRqiumle97o88D6EV8O/5LGY6FTw7hZd9I3jygGM9B
	 jP1ZadMwdLo4wUrtBWSOqrgI9LhZZv0TM9COv9lUhN79PAjsU0SZw0W1EHCheb05Ux
	 NsX2XBvg9cw15eBqrV80GOYSyl9YKjz8TDXX74qvwKx9iWBbYu1bvA7CjlK7+ZDrUO
	 IwnfNiuzjm7PoKvl+osTaouDMA1uhOGXTjcRdpOPA/8wDKYi0+W8NkLV4BGpkLQH3U
	 D54y1WHTkTRVw==
Date: Sat, 17 Oct 2026 19:47:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux@analog.com>, <nuno.sa@analog.com>,
 <dlechner@baylibre.com>, <andy@kernel.org>, <Michael.Hennerich@analog.com>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <corbet@lwn.net>, <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v5 06/15] iio: adc: ad4134: Protect conventional device
 access from debug accesses
Message-ID: <20261017194707.48f6f242@jic23-hlaptop>
In-Reply-To: <b05978468abb537f7fe5b1d0ed2753df9a69decb.1792200021.git.marcelo.schmitt@analog.com>
References: <cover.1792200021.git.marcelo.schmitt@analog.com>
	<b05978468abb537f7fe5b1d0ed2753df9a69decb.1792200021.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Oct 2026 22:58:05 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Require debug access to acquire device synchronization locks before
> allowing any transfer from the debug interface so to avoid disrupting
> operations issued from usual (non-debug) interfaces.

These needs more.  What sort of disruption are we talking?

A deliberate write to change state that breaks normal operation
is a debug mess up that we don't guard against, but if a read
is enough to break things, or there is an inherent disruption
of other operations by using the bus at all then state that.

What isn't regmap locking covering?  

If this is all about the mux stuff and backend usage,
then move it to nearer that in the series and refer to that.

Jonathan

> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> New patch in v5.
> 
> I'm not sure about this one and have no strong opinion about it.
> Providing it according to suggestion from Nuno.
> https://lore.kernel.org/linux-iio/179199692826.658576.4841754843069240356.b4-review@b4/
> From previous discussions I guess this patch might not be welcome.
> https://lore.kernel.org/linux-iio/20250421142359.11fb483f@jic23-huawei/
> In that case, completely fine with it being dropped.
> 
>  drivers/iio/adc/ad4134.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
> index dc4d801490db..42a1272c2894 100644
> --- a/drivers/iio/adc/ad4134.c
> +++ b/drivers/iio/adc/ad4134.c
> @@ -302,6 +302,12 @@ static int ad4134_debugfs_reg_access(struct iio_dev *indio_dev,
>  {
>  	struct ad4134_state *st = iio_priv(indio_dev);
>  
> +	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> +	if (IIO_DEV_ACQUIRE_FAILED(claim))
> +		return -EBUSY;
> +
> +	guard(mutex)(&st->sync_lock);
> +
>  	if (readval)
>  		return regmap_read(st->regmap, reg, readval);
>  

