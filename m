Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C249285C4A;
	Sat, 14 Feb 2026 14:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771080462; cv=none; b=vEQQ/OCC2ksoDdHriLr1oO56xyK9uLl3vr4Nf8BGJ3Gse7QsHEh71GDPS94g/K1gipG9kbuVEwlbKKEK/AcBvJzsNrJ4EeB6Mjsxws2u6+P1E44qLp4GVhkbOiV8boR59hwvkS3q5zEnl+jkDmEbxNCSYC2cPdl6qgRcWHJeq9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771080462; c=relaxed/simple;
	bh=Pv2QAS9hr7X5nS1x4xzWvayvLcOMsTA6lFWQcoISNp8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mhv7rB6QsDg6X5py11vyjNqNiI7CWeOA8GgoLdul6GV+XK7OvBX9XN0GpLcTR92xVwCGNUNsseYOoZWOaI1sNQKKSiFfUvEE9/pZue2TjcTFChn0Hi/x+g0hb6GEQHqMbBRccQ4fiAlopEpd7h7wvNWwh21FlekYY8w+8HjVsck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qvgT4UYt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qvgT4UYt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7CAAC16AAE;
	Sat, 14 Feb 2026 14:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771080462;
	bh=Pv2QAS9hr7X5nS1x4xzWvayvLcOMsTA6lFWQcoISNp8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qvgT4UYtCUnEhVWCWKMdderNNEuaHcpBt35JH3eUO29lUFnyQQs9Es9YTGr4foUzc
	 nuyH3fW5Vk3sYNY9/XBIjDnwkO7nbxRE2oUKlWzyTcyeBYmlECXn8JMYA94skuhb1Z
	 DTDOmqxTe1mwprU0sBqn0pVd71dSLzOlwGzopUHjMpjoSeekBusu0jex5YWpw5uo7U
	 KHFVWk+9TlWjtL/XvGBU6qMT2dy50xu+cA3yF7TG/UjNxEnR41vLMC9BvBCxHxRhZZ
	 N+59fyXGgnkiFruI2psc2VBByIlZWQ3S6lCiThNElDHgY379g5FX7FieH2pjXD00Pb
	 Scu9m3TBGDbDA==
Date: Sat, 14 Feb 2026 14:47:33 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <jonath4nns@gmail.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michael.Hennerich@analog.com,
 lars@metafoo.de, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org
Subject: Re: [PATCH 1/3] iio: adc: ad7768-1: fix one-shot mode data
 acquisition
Message-ID: <20260214144733.5a6534de@jic23-huawei>
In-Reply-To: <aYpT1zES5la/8TTb@JSANTO12-L01.ad.analog.com>
References: <cover.1769889074.git.Jonathan.Santos@analog.com>
	<c4af45393ec299d0fbf853fa8ec224f475e5901e.1769889074.git.Jonathan.Santos@analog.com>
	<20260207164851.51874c46@jic23-huawei>
	<aYpT1zES5la/8TTb@JSANTO12-L01.ad.analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Feb 2026 18:38:31 -0300
Jonathan Santos <jonath4nns@gmail.com> wrote:

> On 02/07, Jonathan Cameron wrote:
> > On Sat, 31 Jan 2026 22:35:20 -0300
> > Jonathan Santos <Jonathan.Santos@analog.com> wrote:
> >   
> > > According to the datasheet, one-shot mode requires a SYNC_IN pulse to
> > > trigger a new sample conversion. In the current implementation, No sync
> > > pulse was sent after switching to one-shot mode and reinit_completion()
> > > was called before mode switching, creating a race condition where spurious
> > > interrupts during mode change could trigger completion prematurely.
> > > 
> > > Fix by sending a sync pulse after configuring one-shot mode and moving
> > > reinit_completion() after the pulse to ensure it only waits for the
> > > actual conversion completion.  
> > That smells like a race...
> > 
> > What stops us taking a long break between ending that sync pulse and
> > the reinit_completition() such that we have initialized if before the
> > complete()?
> >   
> 
> Yes, you are right, we have a race here. The inital problem was having 
> the ad7768_set_mode() before the reinit_completion() because, almost 
> everytime, a new conversion is done before setting the one-shot mode, 
> so the complete() happens before the expected trigger (that never
> happened because ad7768_send_sync_pulse() was not present).
> 
> > You always have to do it before what ever ultimately makes the complete()
> > happen. Have you seen an sign of the spurious interrupts or is that
> > more a conjecture of what might happen? 
> >   
> 
> Agreed, I can put reinit_completion() before sending the sync pulse to
> avoid this situation. But maybe it is better just to remove the one-shot
> mode as discussed in the patch 2/3. What do you think?
I don't have a strong view either way as the trade offs of
using continuous type modes for oneshot and not tend to be rather driver
and usecase specific.  So I'll leave that decision to the driver author
and anyone else who cares about a particular part.

Fix wise you probably want the minor change of adding the reinit before
the pulse as that gives us something small to backport, even if you then
rip the code out again.

Thanks,

Jonathan

> 
> > Jonathan
> >   
> > > 
> > > Fixes: a5f8c7da3dbe ("iio: adc: Add AD7768-1 ADC basic support")
> > > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > > ---
> > >  drivers/iio/adc/ad7768-1.c | 9 +++++++--
> > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> > > index fcd8aea7152e..8d39b71703ae 100644
> > > --- a/drivers/iio/adc/ad7768-1.c
> > > +++ b/drivers/iio/adc/ad7768-1.c
> > > @@ -463,12 +463,17 @@ static int ad7768_scan_direct(struct iio_dev *indio_dev)
> > >  	struct ad7768_state *st = iio_priv(indio_dev);
> > >  	int readval, ret;
> > >  
> > > -	reinit_completion(&st->completion);
> > > -
> > >  	ret = ad7768_set_mode(st, AD7768_ONE_SHOT);
> > >  	if (ret < 0)
> > >  		return ret;
> > >  
> > > +	/* One-shot mode requires a SYNC pulse to generate a new sample */
> > > +	ret = ad7768_send_sync_pulse(st);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	reinit_completion(&st->completion);
> > > +
> > >  	ret = wait_for_completion_timeout(&st->completion,
> > >  					  msecs_to_jiffies(1000));
> > >  	if (!ret)  

