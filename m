Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A635035975;
	Sun, 15 Feb 2026 18:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771179151; cv=none; b=siPE8ptqwHzdaGKArqW5jHPAaFujMzH/ig/GB2+Dk6YnGKrdgBwNZaEP17SZyqKK2Q1e4IicAnd26NbgxjwTW4gH3T8fhRGBZ5ZpLZTMzEf3O/CDwtJnTz49yDTy5+SIYVe/awEwlrr4iJMMvUU79Do7xJtq8NN05gRqrAJNO1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771179151; c=relaxed/simple;
	bh=zmiNXmzWN/PVE/va2BG0NIjLIo/OUd/gr8QZ0ueow9g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=usatJ1X7suu7dZXDQNdTUmujXPpLwL93/XTQX9H6Nv2rqjb46jKHepLgBkmkAtxQREgPAhCXPIV3UGbqpV6pa1s1E2LoCY7n63Z1dQKv9yhD52aZQMlk8XHrAg5qJryFhhhrT0X7xsBt4ZGnT2H8HIHbZu5w8lgG0B6d9V+JEVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qTWMb6VD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qTWMb6VD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69597C4CEF7;
	Sun, 15 Feb 2026 18:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771179151;
	bh=zmiNXmzWN/PVE/va2BG0NIjLIo/OUd/gr8QZ0ueow9g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qTWMb6VD7ORxfaiLvBaOgBH5DN7sQIGNvU8jzMAASQtXloLjd9mnuTDf1kCOBHmhu
	 ONIoDy8purSnumeC1WDOJfFNbPJ1HXlH4PF6z0tsvM66r4drKu51rbJolqtR/z65T5
	 JZf9cAHlxZL00IPxHgRnH2PVj5P1mlp5TE0+oxPORTWuagge23BE9ZIFTelVnp77Hy
	 EVYfsyVuqom5yA43Dczr2Zt8vCFBeo8211KTI2ojJefFtzO0YZvESNb1bpX2Z/NH+Z
	 SsG8spSHwr011jEMw8jiOCRTvgcMHFqUbIoCiIzMTZjO3+LVlk+AUyOXbAoXLnI37T
	 b16SON99y8Deg==
Date: Sun, 15 Feb 2026 18:12:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jorge Marques <gastmaier@gmail.com>
Cc: Ethan Tidmore <ethantidmore06@gmail.com>, jorge.marques@analog.com,
 lars@metafoo.de, Michael.Hennerich@analog.com, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, Dan
 Carpenter <error27@gmail.com>
Subject: Re: [PATCH] iio: adc: ad4062: Add missing IS_ERR() check
Message-ID: <20260215181220.64090f58@jic23-huawei>
In-Reply-To: <jy7aadqr7zblpoh2qvdelzjiqqjl5zpofckbuhhfeer3pjvcbb@ee47xydwo36f>
References: <20260214005332.29608-1-ethantidmore06@gmail.com>
	<jy7aadqr7zblpoh2qvdelzjiqqjl5zpofckbuhhfeer3pjvcbb@ee47xydwo36f>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Feb 2026 15:36:35 +0100
Jorge Marques <gastmaier@gmail.com> wrote:

> On Fri, Feb 13, 2026 at 06:53:32PM -0600, Ethan Tidmore wrote:
> > In the function ad4062_sizeof_storagebits() iio_get_current_scan_type()
> > is called which can return an error pointer and is not checked for it.
> > Also the function ad4062_sizeof_storagebits() returns type size_t but,
> > is only used once and the variable assigned from it is type u8.
> > 
> > Add check for error pointer in ad4062_sizeof_storagebits() and change
> > return type to int so the error code can be properly propagated and then
> > checked.
> >   
> 
> Hi Ethan,
> 
> Thank you for adding the check.
> 
> Reviewed-by: Jorge Marques <jorge.marques@analog.com>
> 
> For risk assessment of the bug:
> 
>   static int ad4062_get_current_scan_type(const struct iio_dev *indio_dev,
>   					const struct iio_chan_spec *chan)
>   {
>   	struct ad4062_state *st = iio_priv(indio_dev);
>   
>   	return st->mode == AD4062_BURST_AVERAGING_MODE ?
>   			   AD4062_SCAN_TYPE_BURST_AVG :
>   			   AD4062_SCAN_TYPE_SAMPLE;
>   }
> 
>   There is no path where the method returns an error.
> 
> It definitely makes sense to add the inexpensive check, since the
> *_get_current_scan_type could be patched with an error case (e.g., added
> support to other devices) and the lack of check could slip through (due
> to previously marked as false positive).
> 
Given it's a false positive I'll merge this the slow way.
I considered dropping the fixes tag, but then various bots will complain
if we keep the closes etc so I left it.  I haven't tagged it for stable
however as we probably don't care strongly either way on whether this one
gets backported.

So applied to the testing branch of iio.git which I'll rebase on rc1 once
available.

Thanks,

Jonathan

> Thanks,
> Jorge
> 
> > Fixes: 23cc92280302d ("iio: adc: ad4062: Add IIO Trigger support")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <error27@gmail.com>
> > Closes: https://lore.kernel.org/r/202512280539.AholFF7m-lkp@intel.com/
> > Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
> > ---
> >  drivers/iio/adc/ad4062.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ad4062.c b/drivers/iio/adc/ad4062.c
> > index dd4ad32aa6f5..c864de3b46ba 100644
> > --- a/drivers/iio/adc/ad4062.c
> > +++ b/drivers/iio/adc/ad4062.c
> > @@ -1199,11 +1199,14 @@ static int ad4062_write_event_value(struct iio_dev *indio_dev,
> >   * The AD4062 in burst averaging mode increases realbits from 16-bits to
> >   * 20-bits, increasing the storagebits from 16-bits to 32-bits.
> >   */
> > -static inline size_t ad4062_sizeof_storagebits(struct ad4062_state *st)
> > +static inline int ad4062_sizeof_storagebits(struct ad4062_state *st)
> >  {
> >  	const struct iio_scan_type *scan_type =
> >  		iio_get_current_scan_type(st->indio_dev, st->chip->channels);
> >  
> > +	if (IS_ERR(scan_type))
> > +		return PTR_ERR(scan_type);
> > +
> >  	return BITS_TO_BYTES(scan_type->storagebits);
> >  }
> >  
> > @@ -1233,7 +1236,12 @@ static int pm_ad4062_triggered_buffer_postenable(struct ad4062_state *st)
> >  	if (ret)
> >  		return ret;
> >  
> > -	st->conv_sizeof = ad4062_sizeof_storagebits(st);
> > +	ret = ad4062_sizeof_storagebits(st);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	st->conv_sizeof = ret;
> > +
> >  	st->conv_addr = ad4062_get_conv_addr(st, st->conv_sizeof);
> >  	/* CONV_READ requires read to trigger first sample. */
> >  	struct i3c_xfer xfer_sample[2] = {
> > -- 
> > 2.53.0
> >o   

