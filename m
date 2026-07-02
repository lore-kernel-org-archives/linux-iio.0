Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8885433E87;
	Thu,  2 Jul 2026 17:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783011699; cv=none; b=FWpPrIe46noIXo2VC5m65eGItdFC5aGEum3eDEITmwF4QK5Z4v6FksQdW4CgwOyTbL+mKhvmzY3QkR+jzoKD0sCzZgIFrD6Idd0uhF+RM/MM5t0ZuNjiAatSD+JosFtFUoXc3wo3Z/PxjJb4Gcppy8l0nEvW+sengSjW0A1PUVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783011699; c=relaxed/simple;
	bh=zTjH7UVJ/iiSWZ30Jr2zZjR2BQBx+mFN62ppwi2SXkg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HHpa2H1O5mBxma6NFcDxBxqmIGEdy0Xvd93fB8dqs6uUFp4vSzgamGc12NqKdPMWUEYKT+wz3mxjpi3uTOSdkNRQFHct9oZSlMbyLLRcJ2DpbbZSZTw+xkmGqb60BY7gwod026Xxd9EwbgyPdwTV6OUlK4uJwvWcMm266JYeck0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTyh+Joh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTyh+Joh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB6C1F000E9;
	Thu,  2 Jul 2026 17:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783011698;
	bh=txB6rFAO5hvHisQFbOVEdL4ZA/qN8xCMPszo8yhkcmM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UTyh+Johv/M0BUFnWpJXp/7CCp5y3rvdqmq/x0Ps+LkAOaNBBjoBzpW6kk+EuVJ/x
	 OGQb8pFpYcXbgaH84bma9bOqddEV1AGg8tVxyM4CZzVR4eZERDdS6l2aMW0hSqOSRG
	 eG1sUJIsZDw64A4l1J0tXC00M6/xTN2CgbombhxOEMY3co/gMhHwbomucXbytJsBGw
	 NMiFzkkb6teIYMUsb/G8nuaXhrMHHK+P+DNMq8MS4CnFrXB6HZlGwYS1i/2/tw1lxn
	 qf4JRqJnkxjp9cNS1IGiRsl4o1PECH5C6uZknXnzGwMWLkrWH/GTIln4UlULF/PG4D
	 yRNQIkoOu/PdQ==
Date: Thu, 2 Jul 2026 18:01:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Moksh Panicker <mokshpanicker.7@gmail.com>, nuno.sa@analog.com,
 Michael.Hennerich@analog.com, dlechner@baylibre.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org
Subject: Re: [PATCH v3 1/2] iio: adc: ad7779: Remove unused completion field
Message-ID: <20260702180132.06fc6565@jic23-huawei>
In-Reply-To: <20260702135428.000005dc@gmail.com>
References: <20260702114649.9758-1-mokshpanicker.7@gmail.com>
	<20260702114649.9758-2-mokshpanicker.7@gmail.com>
	<20260702135428.000005dc@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 Jul 2026 13:54:28 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Thu,  2 Jul 2026 11:46:48 +0000
> Moksh Panicker <mokshpanicker.7@gmail.com> wrote:
> 
> > struct ad7779_state contains a completion field that is initialized
> > in ad7779_setup_without_backend() but never waited on or signaled
> > anywhere in the driver. Remove the dead code.
> > 
> > Suggested-by: Joshua Crofts <joshua.crofts1@gmail.com>
> > Signed-off-by: Moksh Panicker <mokshpanicker.7@gmail.com>
> > ---
> >  drivers/iio/adc/ad7779.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ad7779.c b/drivers/iio/adc/ad7779.c
> > index 695cc79e78da..c1a99b4c1256 100644
> > --- a/drivers/iio/adc/ad7779.c
> > +++ b/drivers/iio/adc/ad7779.c
> > @@ -143,7 +143,6 @@ struct ad7779_state {
> >  	const struct ad7779_chip_info *chip_info;
> >  	struct clk *mclk;
> >  	struct iio_trigger *trig;
> > -	struct completion completion;
> >  	unsigned int sampling_freq;
> >  	enum ad7779_filter filter_enabled;
> >  	struct iio_backend *back;
> > @@ -852,7 +851,6 @@ static int ad7779_setup_without_backend(struct ad7779_state *st, struct iio_dev
> >  
> >  	indio_dev->trig = iio_trigger_get(st->trig);
> >  
> > -	init_completion(&st->completion);
> >    
> 
> Remove the blank line here as well.
Fixed up and applied.

> 
> >  	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> >  					      &iio_pollfunc_store_time,  
> 
> 
> 

