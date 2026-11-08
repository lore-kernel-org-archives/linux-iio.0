Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794169047;
	b=G9q3ToFEagVx1fDVxSQ5k3faoFDHSLxuWpOk3xyFyNNhGceuHpe8YMtRaZnaPzwV0uO8
	 RaMjm+L0+Ri2bAafC0ySdrTI287oHrGN7aDqbQskq2Lcr/Bkvcsy9du8wR2lQqWz5c7Dn
	 i6k/L4bgpnVNr/iauqCWdQTz+cYJqDxBN7gxl5d6r2Q7FrDg0Xy4dN/Y3spSoHmdylwlN
	 DGvMsJAsrYdor564WXLhubHwiwqPHfdgduLxI6iu8ZA5D3aq9k/meXmxhmodJ4J9wC+xG
	 B8vlxsunCQ0+0XdXtBBrYPSx9dLIxHjdFrmDjMIY4/52gcshD7nJNg+zzy4XCA9z1ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794169047;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=6V+jSZb6mGqAzM+vviaKHJs1LRkhqKiI/bwUZE9dkw8=;
	b=h6GEs0xf3tSgQ1EtNCi5f8/UZ5yjggYjKG4CVGF7VGvfDuddGhjK3RFr3/XPUMH19vwu
	 e3L5GDnA8PucXL8shBWYt287zNuzYXN4KMHMwA/fNKr0QiWH8cFz+kcryF/u6CkH0tl/j
	 70YNlCe0FmHStWTohe6TZ8JYlLzSBRcGvN1N53Qpr/zHVPrwIHLsU6x8Kny817sg8Jaly
	 MJGaNqgUkoVutx7vmTQeQV/myhemyWoTxj4czsrr9zJhz/deAJ+yydock55Q+H70XUJmA
	 FkUavt7JZC2LeompwMPJ/IJVJqtowMLExB+EMJeJXLqBWxHPp5ieFTJEskqDM4j8Ngw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SFOBHsAv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2ED606A31C
	for <linux-iio@vger.kernel.org>; Sun,  8 Nov 2026 20:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SFOBHsAv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910671F008A1;
	Sun,  8 Nov 2026 20:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794169046;
	bh=6V+jSZb6mGqAzM+vviaKHJs1LRkhqKiI/bwUZE9dkw8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SFOBHsAv1hmUkkgOtYFILm2ZiBWuIKLgpgKBlEiQLXVm1m2rojv2ZdF1Stwkb9LWC
	 mtwvXPLD/SlIrOTKMwcpXwvRNhZ0KpU94SxnRPFQYSqoo5wL2laXiYf8R75DA62BO5
	 MS40znfwVPhTD6eLWnUFr7G3VSYwzC8oEG6KTVrWr8k/ACi63jFYTM63vcjUXT5fVy
	 aBCQOnRyBPuOGtavhovph3Kw44p9meLLYD17xdEDhtXXJdiuwcQOjpmFsdVib6qZGw
	 jY51X3iHv0+am1rU66A1lKIYzP+hbfY+qZvAS7bhw6j37FPUQJnIUR1ilsjK61/8N2
	 1IPB/2jh4sQZQ==
Date: Sun, 8 Nov 2026 20:17:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <crofts@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 32/39] iio: adc: ad7887: use
 iio_push_to_buffers_with_ts()
Message-ID: <20261108201718.6a3367e2@jic23-hlaptop>
In-Reply-To: <20261027124629.00000fee@kernel.org>
References: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
	<20261026-iio-v1-32-8b136778eedf@oss.qualcomm.com>
	<auB7zg8H8bMGchzw@ashevche-desk.local>
	<20261027124629.00000fee@kernel.org>
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

On Tue, 27 Oct 2026 12:46:29 +0100
Joshua Crofts <crofts@kernel.org> wrote:

> On Tue, 27 Oct 2026 12:24:14 +0200
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> 
> > On Mon, Oct 26, 2026 at 04:05:50PM -0700, Jonathan Cameron wrote:  
> > > Replace the deprecated iio_push_to_buffers_with_timestamp() with
> > > iio_push_to_buffers_with_ts(), passing the size of the pushed buffer,
> > > which is a structure within the iio_priv() data.
> > > 
> > > Replace the data buffer with one declared via
> > > IIO_DECLARE_DMA_BUFFER_WITH_TS(), for 2 __be16 channels.
> > > 
> > > Use be16_to_cpu() to replace the opencoded equivalent.    
> > 
> > ...
> >   
> > > Otherwise I might just rip out the pdata path in the near future.
> > > This patch being an example of how it is causing maintenance burden.    
> > 
> > I don't see users in the kernel, I think we may just drop it for good.
> > If anybody wants that, they can use software nodes in the future, no
> > revert will even be considered.
> > 
> > ...
> >   
> > > -	return (st->data[(ch * 2)] << 8) | st->data[(ch * 2) + 1];
> > > +	return be16_to_cpu(st->data[ch]);    
> > 
> > Add asm/byteorder.h into include block. And yes, the include block is a mess
> > in this driver.
Done.
> >   
> 
> I will probably do a series removing kernel.h from a subset of drivers
> in IIO again (it's really painful though).
> 

That one can be a long term project. It's nice to have as cuts down
on wrong choices in new drivers (via cut and paste), but it is
isolated to each individual driver so the blast radius of bad
includes isn't huge!

Jonathan


