Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9CB2AE7A;
	Fri,  3 Jul 2026 00:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783038907; cv=none; b=Gmr3ecWsTFYhQqHCTlQcDRPPhjqbVPn2v5TpTSwVFxj7VPYD/cCky/joDzsAUrD9AvUrpV+Ql6CWbsmAsK0hmt2kWBUETx/RT6sCvd5t01YvGOmBxCgiE21OPSUN8CL97Mxbw+8LAGjFb1jjo44WWhA7k+gtUpIEJKMGWW9pMtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783038907; c=relaxed/simple;
	bh=vr37YRdwBiP9/KjLNKRUwKA6k0WG3P4sA1UBAg6v+u0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dLagZOHVG3tyf5O4k7bAbiXUBh7HcmIOZLQpBnqZQikuy1sjlbuONdXLcVJChSw6UFrYogbu4hCsQNSRVhGI8+NyF2Ti/e7awrpvms8sCT0jP46fyOdq0JcWY69hza0GB3jovAslKcb697jJG6FKzNzSFEOI8TA5Fu99L5cJidY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4aIvRTU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4aIvRTU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A22621F000E9;
	Fri,  3 Jul 2026 00:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783038906;
	bh=+kJ1L7mnsC+1kx38OTy1fsH5IcXwWb+RODD1evJbDwE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=H4aIvRTUYeM8cAGYxEZCa4gla4Te36mO1e9OLxXQ3HwBwpgce+zdj5Sp7g0Buuz57
	 srjjrU+jmHvuN9oTe0miHXAaOZZqmDtk15OCqpY05YRK2HTeH03kMXbeXQXEOuSLVD
	 Y3m0gbIKUaNpwDXIU1dgd2TXrn2tB8ggMYNclgAZjq/7MItg20wPK8Rh/q65zb1hJR
	 XIdUsPXAlu6tW7tbrNMCzMfY8YQ64N4G6VH7gMLtAvFjHwgIRUWM6vEEWEWWjZfC0F
	 jnug/zo1JVJVzz3hw3mo7HFICRwvEz4h8SJsfOMkLrfp/q+igIEtPnoPm2ZBLLKXhX
	 i+1cEv2RSGuAQ==
Date: Fri, 3 Jul 2026 01:35:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Prashant Rahul <prashantrahul23@gmail.com>, linux-iio@vger.kernel.org,
 Shuah Khan <shuahkhan@gmail.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Petr Mladek
 <pmladek@suse.com>, Oleg Nesterov <oleg@redhat.com>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] iio: adc: ti-adc084s021: use dev_err_probe for
 probe time error
Message-ID: <20260703013451.75cacf98@jic23-huawei>
In-Reply-To: <99507afa-6986-44f7-98c1-257c52a5dcd4@baylibre.com>
References: <20260616130612.73122-1-prashantrahul23@gmail.com>
	<20260618231543.413771-1-prashantrahul23@gmail.com>
	<20260618231543.413771-3-prashantrahul23@gmail.com>
	<99507afa-6986-44f7-98c1-257c52a5dcd4@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Jun 2026 09:49:19 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 6/18/26 6:14 PM, Prashant Rahul wrote:
> > This simplifies error handling and ensures consistent error reporting.
> > 
> > Signed-off-by: Prashant Rahul <prashantrahul23@gmail.com>
> > ---
> >  drivers/iio/adc/ti-adc084s021.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ti-adc084s021.c b/drivers/iio/adc/ti-adc084s021.c
> > index a100f770fa1c..9c7ee09955ca 100644
> > --- a/drivers/iio/adc/ti-adc084s021.c
> > +++ b/drivers/iio/adc/ti-adc084s021.c
> > @@ -230,8 +230,7 @@ static int adc084s021_probe(struct spi_device *spi)
> >  					    adc084s021_buffer_trigger_handler,
> >  					    &adc084s021_buffer_setup_ops);
> >  	if (ret) {
> > -		dev_err(&spi->dev, "Failed to setup triggered buffer\n");
> > -		return ret;
> > +		return dev_err_probe(&spi->dev, ret, "Failed to setup triggered buffer\n");
> >  	}  
> 
> 
> Can drop the braces here
> 
Dropped whilst applying.  I'm a bit in two minds on whether we should print
anything on this one given the incredibly low chance of anyone having
a bug that double registers the buffer - still better as dev_err_probe()
then dev_err() so applied.
> >  
> >  	return devm_iio_device_register(&spi->dev, indio_dev);  
> 

