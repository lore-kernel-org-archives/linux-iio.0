Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE502C0261;
	Sat, 21 Mar 2026 20:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774126463; cv=none; b=HTf/Ko1xJMRFb/4U52+IqmxGA6X+Gw4wB5Wa98rlkbmiJYtAceA65ULUiTE0XDjhPzMC1eKmw0Fgic6qMeTnRk3t7QU9QJuEoYCTUcY/itXxWLRvyQkEXZfaaaK5rccCdBj2POheu1rv+P9SjsqWr7gXRGn4Wd5FssBph6f0UdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774126463; c=relaxed/simple;
	bh=wOVU6uKEGEje9sy9F2SRVTrkrMX+pH0DxozJ1WRZNUA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oVYx6D7wOMl4dAEwHVtsHNnylDYVYUWeTD+4dodfGZ3aY4uZPMPNEON7dLaQTEVnoiO67fa+J7yamKv3LogiIU1dPkuO/Odqkal9XNYw+tGvrs5/0xU2oZuTG7FLWOdu5AqY1Z40BXw1P9cE1NB6D9H8d8rnTZvk0dwzoR4d6Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQeUP52H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQeUP52H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28EB4C19421;
	Sat, 21 Mar 2026 20:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774126463;
	bh=wOVU6uKEGEje9sy9F2SRVTrkrMX+pH0DxozJ1WRZNUA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TQeUP52HErU4s3xSt0+o0DbPfbhRaeLsoWtjD6tFgjip6qKbUY+ebQTzL6ScIrkNK
	 Lx3cdpSCn8mR1BqVDylTTxHt7levTz93ew7RzibAaoYxrTh14b4K74M4P0B2rSP3OK
	 BsDZZZJgf9edHtriNKQE9Ql/W6iycuuklP8n7gBHdeMK7r/68ljCElmPhhWUSCeA6j
	 yYSJb/ovDZLzYYnZs8/umt3fTukwlRX5b46qXUJjfVWN94ncaZ1JIf8UT274xJqTR9
	 pUhIslfuYRcnCIb+2TEmewTt3/nW14DLZiTThSpgFHZEFjjUQHjI24SKc9O4EOkiDt
	 ohmwzObAxiqQw==
Date: Sat, 21 Mar 2026 20:54:14 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Matt Ranostay
 <mranostay@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: ti-adc161s626: use DMA-safe memory for
 spi_read()
Message-ID: <20260321205414.2c51e1a6@jic23-huawei>
In-Reply-To: <2c5083b4-0291-43a0-808f-25d3decdfb5a@baylibre.com>
References: <20260314-iio-adc-ti-adc161s626-fix-scan-buf-v1-0-56243b11e87b@baylibre.com>
	<20260314-iio-adc-ti-adc161s626-fix-scan-buf-v1-2-56243b11e87b@baylibre.com>
	<20260316183117.4dde7386@jic23-huawei>
	<abhfulXY1PbCow-Z@ashevche-desk.local>
	<2c5083b4-0291-43a0-808f-25d3decdfb5a@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 21 Mar 2026 14:40:35 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 3/16/26 2:53 PM, Andy Shevchenko wrote:
> > On Mon, Mar 16, 2026 at 06:31:17PM +0000, Jonathan Cameron wrote:  
> >> On Sat, 14 Mar 2026 18:13:32 -0500
> >> David Lechner <dlechner@baylibre.com> wrote:  
> > 
> > ...
> >   
> >>>  	u8 shift;
> >>> +	u8 buf[3] __aligned(IIO_DMA_MINALIGN);  
> >> On this. There is new generic infrastructure for marking these.
> >> https://elixir.bootlin.com/linux/v7.0-rc3/source/include/linux/dma-mapping.h#L720
> >> https://lore.kernel.org/all/01ea88055ded4d70cac70ba557680fd5fa7d9ff5.1767601130.git.mst@redhat.com/
> >>
> >> Would look like
> >> 	__dma_from_device_group_begin();
> >> 	u8 buf[3];
> >> 	__dma_from_device_group_end();
> >>
> >> Do you think we should adopt them rather than doing our own thing?
> >> Slowly though I don't want the noise of a mass conversion.
> >>
> >> As normal, advantage of standard infrastructure is cutting down
> >> in subsystem specific magic.
> >>
> >> I 'think' result is the same (though it also forces the trailing padding if anything
> >> comes after this and needs it).  
> > 
> > As I read it it will be an equivalent to
> > 
> > 	u8 shift; __aligned(IIO_DMA_MINALIGN);
> > 	u8 buf[3] __aligned(IIO_DMA_MINALIGN);
> > 
> >   
> 
> It will be:
> 
> 	u8 shift;
> 	__u8 __cacheline_group_begin__[0] __aligned(ARCH_DMA_MINALIGN);
> 	u8 buf[3];
> 	__u8 __cacheline_group_end__[0] __aligned(ARCH_DMA_MINALIGN);
> 
> Note that ARCH_DMA_MINALIGN is not always the same as IIO_DMA_MINALIGN.
> IIO_DMA_MINALIGN has a minimum of 8 bytes to account for timestamp
> alignment.

Good point. All the sensible arches have min 8 anyway but who knows..

> 
> I wonder if this would add an extra ARCH_DMA_MINALIGN bytes to
> the struct. Or if the compiler is smart enough to see that it has
> 0 size on the last array and have a special case for that.
> 
My gut feeling is that it will be fine.  If you have a [0] element in
a flex array (the old way of doing it that recently got ripped out of
the kernel) then the sizeof() the structure never included anything for
that.  I don't see why aligning it should matter.

> And even if the 0 is handled, if someone added a new field after this,
> I expect the struct would grow by ARCH_DMA_MINALIGN rather than sizeof(field)
> bytes.

Yes, the structure always has to be a multiple of the item with
the largest alignment so anything after that forcing align will bloat
by whole ARCH_DMA_MINALIGN.


> 

