Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795F4431E7B;
	Wed,  1 Jul 2026 19:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934438; cv=none; b=SMPpnDX1zOXAKwXILRdTG4OVhRJ3mgY8OUMZ73Xd7wRapQzA49PlvfIj6I5OicYMpPiZFsDxIXyn1H7x1OG6PpkNOek0rDVAFUyycN+QOL4FZkVHoDUHzJBe1mjxTilxxU14RuOaQj2lXSRUZJp7GTvVquthVKvMUILNQ5SwhQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934438; c=relaxed/simple;
	bh=/ZuOhUuLF3sjNbzDN84/QFRI3xhT+xOHHtLORD4mefM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gnwIqZYPaJxXlRNkhdiVI5T6s7RqPZ/1sU6DTznk5bRYul6Kptn7ioqcKxeR6osz2FJY0eNc7P63OtWELu3ccgG+YgQKJ8vdk3yIhLJZFz/c2o1iGHwMmnGBobHwEJ2hCuQ/dQUVg0gKwJg7gS2qnAYCGm54L0YmlTSe5iyDD9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3Zq0kgT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3Zq0kgT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8CF1F000E9;
	Wed,  1 Jul 2026 19:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782934437;
	bh=yHMfXiG/L3xuXIf7K+Ie9kNhmGsqangsEQs5gurc5D8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=X3Zq0kgTPGfdyM7YJlNYK96ZUAwMieLRnCn7TP2fKT/VKyQpNfrNdPrN8QcAPcHi/
	 M7wglboiveagSPSUnEuzWZMGllheTf72xk3XBPlyEAh0NPxFt6PylnMAMguT/ajH+2
	 WX7iHNI78nK1AdDgSD2IQKznN11JDl5jW5Fc5S1PLrlck/NhKfnqPqkWvXrvx2yZcw
	 hi6RXDQ0HK3hKfL79KLepVQLp3zQTio8qzkI++mE2cdgVoumzEoRWJ0oiAVjCZ2dk1
	 uQz6PX6c48YG66W1IRYcV2IdcCyBttvL+0S0utVxGUgDGaIfc4R/O7z07qziMP637s
	 9p0dLx4iMWBOQ==
Date: Wed, 1 Jul 2026 20:33:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
Cc: "Shardul Deshpande" <iamsharduld@gmail.com>, "David Lechner"
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: light: veml6075: fix UV index reported at half
 value
Message-ID: <20260701203352.161f3fa3@jic23-huawei>
In-Reply-To: <DJJPU0OYEXMQ.EUU9J2PW7BKA@gmail.com>
References: <20260626110400.68885-1-iamsharduld@gmail.com>
	<20260627085313.7507-1-iamsharduld@gmail.com>
	<DJJPU0OYEXMQ.EUU9J2PW7BKA@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 27 Jun 2026 11:14:39 +0200
"Javier Carrasco" <javier.carrasco.cruz@gmail.com> wrote:

> On Sat Jun 27, 2026 at 10:53 AM CEST, Shardul Deshpande wrote:
> > veml6075_get_uvi_micro() normalises the UV index for the configured
> > integration time. The raw UVA/UVB counts scale linearly with the
> > integration time, so the responsivity-weighted sum must be divided by the
> > integration-time scale factor relative to the 50 ms base case (which is
> > returned undivided).
> >
> > Per the VEML6075 datasheet the UV_IT field selects the integration time
> > as 50, 100, 200, 400 and 800 ms for field values 0..4, i.e.
> > (50 << int_index) ms: each step doubles the integration time and hence
> > the accumulated counts. The correct scale factor relative to the 50 ms
> > base is therefore 2^int_index == (1 << int_index). (See also the Vishay
> > application note "Designing the VEML6075 Into an Application" for the
> > UV-index responsivity calculation that these constants implement.)
> >
> > The code instead divided by (2 << int_index) == 2^(int_index + 1), i.e.
> > twice the correct value, so the reported UV index was half of the true
> > value for every integration time except 50 ms. As the driver powers up
> > with VEML6075_IT_100_MS, the UV index was reported at half value out of
> > the box.
> >
> > Divide by (1 << int_index) instead. int_index is already bounded to 0..4
> > by veml6075_read_int_time_index(), and (1 << 0) == 1 reproduces the
> > undivided 50 ms case, so the per-integration-time switch collapses to a
> > single expression.
> >
> > Fixes: 3b82f43238ae ("iio: light: add VEML6075 UVA and UVB light sensor driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Shardul Deshpande <iamsharduld@gmail.com>
> > ---
> > Changes in v2:
> > - Collapse the per-integration-time switch into a single divide now that
> >   all cases share the same expression -- int_index is bounded to 0..4 by
> >   veml6075_read_int_time_index() and (1 << 0) reproduces the 50 ms case.
> >   (Javier Carrasco)
> > - Add VEML6075 datasheet (UV_IT integration-time table) and application-
> >   note references for the integration-time scaling in the changelog.
> >
> > Link to v1:
> > https://lore.kernel.org/linux-iio/20260626110400.68885-1-iamsharduld@gmail.com/
> >
> >  drivers/iio/light/veml6075.c | 18 +++++++-----------
> >  1 file changed, 7 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/iio/light/veml6075.c b/drivers/iio/light/veml6075.c
> > index 59187244a..d0ec06eeb 100644
> > --- a/drivers/iio/light/veml6075.c
> > +++ b/drivers/iio/light/veml6075.c
> > @@ -237,17 +237,13 @@ static int veml6075_get_uvi_micro(struct veml6075_data *data, int uva_comp,
> >  	if (int_index < 0)
> >  		return int_index;
> >
> > -	switch (int_index) {
> > -	case VEML6075_IT_50_MS:
> > -		return uvia_micro + uvib_micro;
> > -	case VEML6075_IT_100_MS:
> > -	case VEML6075_IT_200_MS:
> > -	case VEML6075_IT_400_MS:
> > -	case VEML6075_IT_800_MS:
> > -		return (uvia_micro + uvib_micro) / (2 << int_index);
> > -	default:
> > -		return -EINVAL;
> > -	}
> > +	/*
> > +	 * The raw counts scale linearly with the integration time, which
> > +	 * doubles at each step (50, 100, 200, 400, 800 ms == 50 << int_index
> > +	 * ms; int_index is bounded to 0..4 above). Normalise to the 50 ms
> > +	 * base by dividing by 2^int_index; (1 << 0) == 1 leaves 50 ms as-is.
> > +	 */
> > +	return (uvia_micro + uvib_micro) / (1 << int_index);
> >  }
> >
> >  static int veml6075_read_uvi(struct veml6075_data *data, int *val, int *val2)  
> 
> Hello Shardul, thank your for your patch.
> 
> Please give potential reviewers more time to take a look at your
> patches. It's been less than 24 hours between v1 and v2, and that
> reduces the amount of people who could review and potentially improve
> your patches.
> 
> In my opinion, the comment you added is way too verbose, and it includes
> information that is well known within the driver like the possible
> values for the integration time. Once it is fixed, it is clear that it
> is normalised to 50 ms because it is index 0. To be honest, I would even
> drop the comment completely.
> 
The actual change in behaviour looks fine to me, so just the amendments Javier
suggests for v3.

Thanks,

Jonathan

> Best regards,
> Javier

