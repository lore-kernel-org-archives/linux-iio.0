Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288F240FDBE;
	Wed, 29 Apr 2026 17:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777484335; cv=none; b=GyBE/UiV8h8ZohaKXz6HU4jrxVvw1yhQHA6dNuYTjuJuC0D0CLf3OhqidxMbPovGURGEo2B2TVk8P7M/98xxN3SFfvCQuk1mbvTjB5bc8HoldcPSQvr9iAJDuNWdztvXdUOhWc/DWnIgm8vQCyk0If/qYLUfXpK2BbdKfEOTT8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777484335; c=relaxed/simple;
	bh=B/mm4JF73BiFQFUkcYH4L91V2TfU1N3CVC2WPUJGKZE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JKnE/WK+6pgdVWZzKE7R3iHD2v8zxr7umYcNjG/Rp0a20tcBJlSPE8LcPKRaK1DuwqpWQqHcVjFe5zjwnmfnMDfLdSKygYpdLTjthcXaZqYGJHxjCVJBUDNE0P/nJ+J+11WMoCWfrTntOSDMUXFBQnhrgbMgPTf/QQ2FpmgB2xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3SQktN2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3SQktN2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC35C19425;
	Wed, 29 Apr 2026 17:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777484334;
	bh=B/mm4JF73BiFQFUkcYH4L91V2TfU1N3CVC2WPUJGKZE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U3SQktN2x4R+caQkXFC8kFo8O74O09mCNOHsOpdlsGfqy6KNb7dfa+za4JItKQvfH
	 kJ9bO2qxL77fh9z55EF5ZMn6TjghYjCR1PnGI+TI4yDETfbw88yMZJLdp688seRSWK
	 ESIxI4iZ7jwttOPuzhO7FdmHZtnrkae3/To9stAgu+aaf0pbZDXaTRi7kteitrq4Kj
	 tr6yryiDp0FoX610oC5Bz5fnX9Xmlyeh0neoZXbNCEdgkgzypRw8TUCtzcp+ymdTVS
	 KbkRn9xDETd1fPxv8nxJyxHxU2hTEksLjJggQjWMkxSo1gv80/da0bLJAhVww6AZYt
	 PV5O5z46FMvQg==
Date: Wed, 29 Apr 2026 18:38:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stefan Popa <stefan.popa@analog.com>,
 Jonathan Cameron <jic23@cam.ac.uk>, Greg Kroah-Hartman <gregkh@suse.de>,
 Michael Auchter <michael.auchter@ni.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rodrigo
 Alencar <rdealencar@gmail.com>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 05/13] iio: dac: ad5686: fix overlapping DMA buffers
 in I2C read
Message-ID: <20260429183844.1744098a@jic23-huawei>
In-Reply-To: <afIQjU2TGrZ6P-3w@ashevche-desk.local>
References: <20260429-ad5686-fixes-v4-0-bb8f1cbd68e1@analog.com>
	<20260429-ad5686-fixes-v4-5-bb8f1cbd68e1@analog.com>
	<afIQjU2TGrZ6P-3w@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Apr 2026 17:07:09 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Apr 29, 2026 at 02:07:35PM +0100, Rodrigo Alencar via B4 Relay wrote:
> > 
> > The TX and RX buffers in ad5686_i2c_read() both reference data[0], causing
> > byte d8[1] to be shared between the TX buffer and the RX buffer. I2C
> > controller drivers that map all message buffers for DMA before initiating
> > the hardware transaction will map overlapping memory ranges with
> > conflicting DMA directions (DMA_TO_DEVICE and DMA_FROM_DEVICE). This issue
> > was reported by sashiko.  
> 
> Not sure how this patch helps with that. The minimum granularity for DMA is
> a cache line size. Do we have data[0] and data[1] be cache line separated?
> 
> It might be I miss something obvious, but this topic is always confusing
> to me (DMA alignment).
> 

I thought I understood :( From a real hardware point of view the cache flushes
that occur for non coherent DMA should be safe with tx and rx overlap but
'maybe' there is a framework problem if they buffer is simultaneously marked
in both directions or indeed there might be spi controller drivers that
can't cope with this.

Flush wise need to flush the tx and rx at start to ensure the tx data
is written back and any copies of rx in the CPU caches are clean.
Then after DMA need to flush rx again to ensure an prefetched cachelines
(which will be clean because of earlier flush) are dropped and new
reads come from the device. These will all happen on a cacheline but
shouldn't matter if it's the same one as the post DMA flushes are just
to drop clean lines and it's clean either way.
+CC Mark for whether this corner has come up in SPI before.

Short question is can we pass same buffer for rx and tx on an spi transfer?

https://lore.kernel.org/all/20260429-ad5686-fixes-v4-5-bb8f1cbd68e1@analog.com/
Is the patch, based on a bug report from an LLM.

hmm. In the docs for struct spi_transfer we have a not entirely confident
sounding comment on this.

	/*
	 * It's okay if tx_buf == rx_buf (right?).
	 * For MicroWire, one buffer must be NULL.
	 * Buffers must work with dma_*map_single() calls.
	 */

We don't care about MicroWire here, but the other two lines matter.

This particular case is even weirder as I think they are offset and overlapping
but if it works for them equal I'd assume that's fine too.

Jonathan
