Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3400235F5F0;
	Sat, 28 Feb 2026 19:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772306454; cv=none; b=ax+aFYAwlU1g8YYyhbYvjUWCHyzFT4u+9NIYpwCqJ/Gr10rUPqp3rUtvNEfIX42Of98UdpPpiDbZ0oPp4KV+9PgRieFV/IrOE3ULSsAGhCIKiH/QetdYV2w3pFwH9Fn2rYwhYklbJfGLXmKAlGc9nDAqa2AkI9MsF3g+LvsMvXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772306454; c=relaxed/simple;
	bh=qKrgQoVGQBwwlDdVV253JexottJ81p5o/9Wbt/5uuh4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DA4VKTSwAi3sElPN/QDmjZpHNVXTWBvcIdQNSk/38cJ+3M+F5kUVR1D7dkwtWEtb/gE5QU+7bPJHobggphi1IWi6H9H8ieJth744jkBTqPcA1JzhZ3VF1+mbviRZ7KosDJrdggPYRQs5emLm4B6BfTvUR4cRBNo8XezCLM3GoXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PE+UHO36; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PE+UHO36"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31B6CC116D0;
	Sat, 28 Feb 2026 19:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772306453;
	bh=qKrgQoVGQBwwlDdVV253JexottJ81p5o/9Wbt/5uuh4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PE+UHO36SNa+jvmT/WKPchv7fgLOl5vjjhnRIr+Mdx/IsNZeXI2AvN9Gw4duH91T2
	 n/WAu5gvM0YEVf/x/Y/RAco2rkb4L5XWau2TbcWBD+rj3ct25s0k3DhuKSXjSSl8hA
	 XmLNwMyLeFgFltJvDTzM2dfZBJl9VZbYprRex7//Hb3aEy6MABjl5JVSDHoYukOd4E
	 4MqfL2C0Z0xGcgX+JzyqxcY88CAZgJq+YKpO7ccehF4Myp6n4/dsKLfr5fKhSrmSHt
	 zVNSF9lDPxIcwAaUF2x1ib6EK9CeYo9bzA9J3+otxgNP0JRIEfuTX3FUqdixIb6F9d
	 kgj5XOE29Hn/A==
Date: Sat, 28 Feb 2026 19:20:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, lars@metafoo.de,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, jonath4nns@gmail.com
Subject: Re: [PATCH v2 4/4] iio: adc: ad7768-1: add support for SPI offload
Message-ID: <20260228192044.42d3a51b@jic23-huawei>
In-Reply-To: <aZxaMPWtxwCvmtdd@smile.fi.intel.com>
References: <cover.1771362939.git.Jonathan.Santos@analog.com>
	<79e1004bd9e618f9376a9ed40389510066b91d1c.1771362939.git.Jonathan.Santos@analog.com>
	<aZxaMPWtxwCvmtdd@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Feb 2026 15:46:24 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Feb 23, 2026 at 08:59:53AM -0300, Jonathan Santos wrote:
> > The AD7768-1 family supports sampling rates up to 1 MSPS, which exceeds
> > the capabilities of conventional triggered buffer operations due to SPI
> > transaction overhead and interrupt latency.
> > 
> > Add SPI offload support to enable hardware-accelerated data acquisition
> > that bypasses software SPI transactions using continuous data streaming.  
> 
> ...
> 
> > +static int ad7768_spi_offload_probe(struct iio_dev *indio_dev,
> > +				    struct ad7768_state *st)
> > +{
> > +	struct device *dev = &st->spi->dev;
> > +	struct spi_offload_trigger_info trigger_info = {
> > +		.fwnode = dev_fwnode(dev),
> > +		.ops = &ad7768_offload_trigger_ops,
> > +		.priv = st,
> > +	};
> > +	struct dma_chan *rx_dma;
> > +	int ret;
> > +
> > +	ret = devm_spi_offload_trigger_register(dev, &trigger_info);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret,  "failed to register offload trigger\n");  
> 
> Double space...
> (do not resend just for addressing this)
Tidied up.

Series applied to the togreg branch of iio.git and for now pushed out as testing

Thanks!
Jonathan

> 
> > +	st->offload_trigger = devm_spi_offload_trigger_get(dev, st->offload,
> > +							   SPI_OFFLOAD_TRIGGER_DATA_READY);
> > +	if (IS_ERR(st->offload_trigger))
> > +		return dev_err_probe(dev, PTR_ERR(st->offload_trigger),
> > +				     "failed to get offload trigger\n");
> > +
> > +	rx_dma = devm_spi_offload_rx_stream_request_dma_chan(dev, st->offload);
> > +	if (IS_ERR(rx_dma))
> > +		return dev_err_probe(dev, PTR_ERR(rx_dma), "failed to get offload RX DMA\n");
> > +
> > +	ret = devm_iio_dmaengine_buffer_setup_with_handle(dev, indio_dev, rx_dma,
> > +							  IIO_BUFFER_DIRECTION_IN);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "failed to setup offload RX DMA\n");
> > +
> > +	indio_dev->setup_ops = &ad7768_offload_buffer_ops;
> > +
> > +	return 0;
> > +}  
> 

