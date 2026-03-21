Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3D9BA34;
	Sat, 21 Mar 2026 20:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774124341; cv=none; b=mjh93Jozc1ipUhBjYjyixJFqCVETTb25Y+g3aiWJRIQNcV+Psu+yh5E/GEwjQkgZ/MSlXDr0ndsaYfbeh1tvNf+XXM64KmtYgjusEhlaC9I1Sf0N56YH1w7avW5+KuCUbezc3be64u/bB+GhGoHhtKz42Wlm54hL3fxBVLQobUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774124341; c=relaxed/simple;
	bh=TadUWsDTgmh1uCbBa2BytngGFrOIffkzJVkavg7VGk4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DcNLBL/S+9GAbCVersIXJDwuy6ixVzAyghDFYaQRq1MOIDSeFXXzf45+DfFq+hFe/xurQFf7CDTzZFHIdGPrrJtj6NCsE9Uj0EMXYT+4OW5BBRuJ/BWA9DTtV6bkadn2Nhu+YkfNCnC72+kvF7rDmiJoVFfttOHFcsnyTAFWti0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X07nnMaa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X07nnMaa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D5CC19421;
	Sat, 21 Mar 2026 20:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774124341;
	bh=TadUWsDTgmh1uCbBa2BytngGFrOIffkzJVkavg7VGk4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X07nnMaa7lsFFqp3EtOpPtSKY4VjxBpqx89IPqN1APPwURF28ydP7COhuoafYGqvr
	 bcKdUfsaCkgibwmO/lck9uW78zBRCCSsRGP8eKV65ZX6mzJ6xQgGJJq9UNRRFOHdY/
	 PalzPJFs0U+IphkPo+7hKOo3NaRoEeE8hi1kV8QuzHrqGg6rUyVfSVq2o6lIsvl3hy
	 mOngfHW7orrd5mQH1VgpUKyZr6tHoLZfLsTdzUFYLO/EyCYF4Caa1ce6q5N7PdshcN
	 lsPtEdGtj8/6P3R6Q2RCaAzsI9ioxaCsbbwPCfDYHVVZ+3R4pSsePB9Wq2UIe8kq9Z
	 qbWduME5wxu4w==
Date: Sat, 21 Mar 2026 20:18:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Matt Ranostay
 <mranostay@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: ti-adc161s626: use DMA-safe memory for
 spi_read()
Message-ID: <20260321201852.2a897fb4@jic23-huawei>
In-Reply-To: <abhfulXY1PbCow-Z@ashevche-desk.local>
References: <20260314-iio-adc-ti-adc161s626-fix-scan-buf-v1-0-56243b11e87b@baylibre.com>
	<20260314-iio-adc-ti-adc161s626-fix-scan-buf-v1-2-56243b11e87b@baylibre.com>
	<20260316183117.4dde7386@jic23-huawei>
	<abhfulXY1PbCow-Z@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Mar 2026 21:53:30 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Mar 16, 2026 at 06:31:17PM +0000, Jonathan Cameron wrote:
> > On Sat, 14 Mar 2026 18:13:32 -0500
> > David Lechner <dlechner@baylibre.com> wrote:  
> 
> ...
> 
> > >  	u8 shift;
> > > +	u8 buf[3] __aligned(IIO_DMA_MINALIGN);  
> > On this. There is new generic infrastructure for marking these.
> > https://elixir.bootlin.com/linux/v7.0-rc3/source/include/linux/dma-mapping.h#L720
> > https://lore.kernel.org/all/01ea88055ded4d70cac70ba557680fd5fa7d9ff5.1767601130.git.mst@redhat.com/
> > 
> > Would look like
> > 	__dma_from_device_group_begin();
> > 	u8 buf[3];
> > 	__dma_from_device_group_end();
> > 
> > Do you think we should adopt them rather than doing our own thing?
> > Slowly though I don't want the noise of a mass conversion.
> > 
> > As normal, advantage of standard infrastructure is cutting down
> > in subsystem specific magic.
> > 
> > I 'think' result is the same (though it also forces the trailing padding if anything
> > comes after this and needs it).  
> 
> As I read it it will be an equivalent to
> 
> 	u8 shift; __aligned(IIO_DMA_MINALIGN);
> 	u8 buf[3] __aligned(IIO_DMA_MINALIGN);
I think it ends up as
	u8 shift; //unmoved
	__u8 something[0] __aligned(IIO_DMA_MINALIGN);
	u8 buf[3];
	__u8 something_else[0] __aligned(IIO_DMA_MINALING);

Who doesn't like forcing alignment on 0 sized things.

I assume someone who is more familiar with the C spec than I am
established that works.


> 
> 

