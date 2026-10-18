Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8B139EF3F;
	Sun, 18 Oct 2026 18:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792346585; cv=none; b=YxFOmb49nvgRrzUwZb/JtFyj/OK1HktW8WWb2rNRLAFXkyjc8dwF8x0/IVOjzVORWJVZktnsDz5mJKXABDsc4QB7Z9bti6xfw+WP8shgw710nZp4Uyzz0+vnH61qLdorDl0jD9tbZMyeU8pHW2hY3/WWrI9WQKHD9CJJFl0wbZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792346585; c=relaxed/simple;
	bh=eehOXyMVrVm4iDvRrfcuY9w0098006H5ox3F9F6TRMg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K10acAJpTHQY3x6f0vCrfBrRKppKZ0F+3gru09tzvuU6NDm3zM3O1HpBAC1V/LeC2qmZPBAD23uD8zHa+PkD5ZdwRBpxeFv3hQbq4eX8XKcyWhR8K4c9rKkhL3hNqrrrFWk1D34Q+wrBTgy+susThVWkxNA7QsOgXDZw2gFDLp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3AZRMwe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3AZRMwe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94CEA1F000C4;
	Sun, 18 Oct 2026 18:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792346584;
	bh=uxEMCbmJtXDM0C3prE30skAO6GSMi1K3kxl0v8hnH4E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=H3AZRMwewUyEXdWCBRDFMiZ5+Y3blIOlBgjbQO+Arvv/JL/a02lZbHk8jIzeRyhks
	 rvClfGEBSqKm+0AHLGUYLa+DTr+XpBR1ApQQFV0cDVQuXMsl3/an6eLpideMiNWLT8
	 UhN2C12SckeyGWVrOh6wDxpYx4ya5UEADO6JPBoJwr6RRDoH1pUaEjbczpBRAaVIbZ
	 7Rl42WeqEW3uSmyVjV3Zd2Oukb2KPYRUUgjNs7uAOxrftdrPth3GslmZZf44H9kQWT
	 ATN4FcOmQkUzvLP1jgf1cxY+B7oMyuN7CIGfkRzbYgeHY/J00TJ20M0iwE2CXet7xl
	 MlNRym4+FFQjQ==
Date: Sun, 18 Oct 2026 19:02:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matt Ranostay <matt@ranostay.sg>
Cc: Nikhil Gautam <nikhilgtr@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org
Subject: Re: [PATCH 1/1] iio: atlas-ezo: Fix humidity channel read support
Message-ID: <20261018190259.30f85279@jic23-hlaptop>
In-Reply-To: <XRg2Dn6qienpjl0S8WbVJ4nwMKQ5nppuPTJ6HVuSwZRjdn4lggdxaeY5vtQk6j5ihd3lJ_j58o3ypATqaNo1h1eqMdoLcPd6HBuh23ZvJIo=@ranostay.sg>
References: <20261012114553.3327-1-nikhilgtr@gmail.com>
	<20261012114553.3327-2-nikhilgtr@gmail.com>
	<as1G0yGQ5wKhd-dh@ashevche-desk.local>
	<ab328578-08a6-455d-a9bf-411aeb561c8c@gmail.com>
	<20261018003129.533effef@jic23-hlaptop>
	<XRg2Dn6qienpjl0S8WbVJ4nwMKQ5nppuPTJ6HVuSwZRjdn4lggdxaeY5vtQk6j5ihd3lJ_j58o3ypATqaNo1h1eqMdoLcPd6HBuh23ZvJIo=@ranostay.sg>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 18 Oct 2026 02:28:01 +0000
Matt Ranostay <matt@ranostay.sg> wrote:

> On Sunday, October 18th, 2026 at 07:31, Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Tue, 13 Oct 2026 22:15:23 +0530
> > Nikhil Gautam <nikhilgtr@gmail.com> wrote:
> >   
> > > Hi Joshua, Andy,
> > >
> > > Thanks for the review and feedback.
> > >
> > > I checked the Git history and found that the channel type check was
> > > already present
> > > in commit dc3ebfc ("iio: chemical: atlas-ezo-sensor: add humidity sensor
> > > support").
> > > It was not removed when humidity sensor support was introduced, and
> > > I couldn't find any commit message explaining the original intent of the
> > > check.
> > >
> > > Regarding the potential I2C read issue reported by Sashiko,
> > > I'll investigate it and address it in a separate patch series.
> > >
> > > I'll also omit the cover letter for future single-patch submissions.  
> > 
> > Matt normally gets back reasonably quickly so +CC but I'll
> > assume this is just one of those last minute editing errors and
> > apply the fix in the meantime.  
> 
> Yeah this was probably an oversight on my part. Since the humidity sensor support came later, and don't think I actually ever had this EVO sensor.
> So the patch LGTM.
> 
> Reviewed-by: Matt Ranostay <matt@ranostay.sg>
Thanks and tag added.

J
> 
> > 
> > So applied to the fxies-togreg branch of iio.git and marked for stable.
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> > >
> > > Thanks,
> > > Nikhil
> > >
> > > On 13-10-2026 02:15 am, Andy Shevchenko wrote:  
> > > > On Mon, Oct 12, 2026 at 05:15:53PM +0530, Nikhil Gautam wrote:  
> > > >> The atlas_ezo_read_raw() function rejects channels that are not of
> > > >> type IIO_CONCENTRATION, preventing the relative humidity channel
> > > >> from reading raw and scale values.
> > > >>
> > > >> Remove the early channel type check to allow both concentration
> > > >> and relative humidity channels to reach the mask-specific handling.  
> > > > Have you checked the Git history on this change? Anything interesting there?
> > > >  
> > >  
> > 
> >   

