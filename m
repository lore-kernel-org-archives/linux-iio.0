Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5DF3E49C4;
	Mon,  7 Sep 2026 02:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788747443; cv=none; b=sqnC/B2R1ytCbfQoJtBBMPqmVQoS1jzaxGqD/XRE2EQySpK4KV7Q3dcLXEcD91uHXm28hzK5EHh/4yY27aBhDmYGW9kbyqXA0rUbSOHP4uKVkfWW1NwoTkY8dJZ+s5adq/PB/9M9kzRqjy+8QqXA+r0N05ejDVtPYN1jXYbk55c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788747443; c=relaxed/simple;
	bh=exaEeGPciGH6tw64XAY805c1DkCweT+PgopTaTFXSqo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HwEYdGbjXA2sWl9GiBzD4zqn0SFLk39+3PW7OrUrYV5l208pD9mQO9jBT9ULBPsDuNJTsxegITYCgdhspV1xgryEZhVxSYDzLIRcds0YThieoVIFIb2SW0gJYvBiZJXk0qvBhj4Bq00z2NaOa1ekP1Hwn30Z40U0tgtGIVpMrbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8vSLj72; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8vSLj72"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D5261F00A3A;
	Mon,  7 Sep 2026 02:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788747441;
	bh=j/5E7ar9Qu1U4zuanyEAu2sMH4ZDvgtn0WBn4A7tQrg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=n8vSLj72dWOHQnbPTHf/ryJBe+xSb4TjwpqdJNETOYqLT9/O6dCmQw+NlK7hRegNT
	 CUvFmeq2wUuU7IN3i2b6v6Dw5+LpFyYpY4lnM5NU1gLhc1dZcHL4eLYSRzg7mfJuSL
	 5fzbg8Pi0kjdhqfX10DN5rnFYtigHyeoWmK2vjWA/rzkYyRlmKCHa6ZvyxKtirjQc0
	 Nk8e0rC5Dru0lBT0hkLdqK2CN/mghpDXFT8Lx1rQXE5YnWKBxmCaQOW5u7oWqF+T7X
	 ++W4J9x4X0uqhSds3eo98TVRktn4jhMEQd/vm5XbDffrgtQE35caizAT2lvLDrp+1T
	 jeRY03Dxa5nnw==
Date: Mon, 7 Sep 2026 03:17:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Varshini Rajendran <varshini.rajendran@microchip.com>
Cc: <ehristev@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
 <andy@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
 <alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
 <srini@kernel.org>, <marcelo.schmitt@analog.com>, <radu.sabau@analog.com>,
 <joshua.crofts1@gmail.com>, <jorge.marques@analog.com>,
 <Jonathan.Santos@analog.com>, <jishnu.prakash@oss.qualcomm.com>,
 <antoniu.miclaus@analog.com>, <duje@dujemihanovic.xyz>,
 <mazziesaccount@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 07/17] iio: adc: at91-sama5d2_adc: adapt the driver
 for sama7d65
Message-ID: <20260907031716.0e5ceb9a@jic23-huawei>
In-Reply-To: <20260815212113.65e60919@jic23-huawei>
References: <20260806074024.531259-1-varshini.rajendran@microchip.com>
	<20260806074024.531259-8-varshini.rajendran@microchip.com>
	<20260815212113.65e60919@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 15 Aug 2026 21:21:13 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Thu, 6 Aug 2026 13:10:14 +0530
> Varshini Rajendran <varshini.rajendran@microchip.com> wrote:
> 
> > Add support for sama7d65 ADC. The differences are highlighted with the
> > compatible. The calibration data layout is the main difference.
> > 
> > Update Kconfig help text to mention SAMA7 SoC family support.
> > 
> > Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>  
> 
> The Sashiko feedback on this one is interesting.
> 
> https://sashiko.dev/#/patchset/20260806074024.531259-1-varshini.rajendran%40microchip.com
> 
> The timestamp in the chan_spec array isn't the last one - the
> timestamp comes after it which is going to break in various
> unhelpful ways - as iio_push_to_buffers_with_timestamp() requires
> the timestamp to be the last scan index.
> 
> in at91_adc_trigger_handler_nodma() there is a comment saying
> that it can only be used with voltage channels. That's fine but
> if they aren't useful, why are the scan_index values not -1
> which is how we hide those interfaces for channels for which
> buffered capture is not supported.
> 
> Given you have the hardware set up, can you check if the
> scan_elements/*_en is there for the temp channel and
> that for cases where it is enabled, we get an error in the
> buffer preenable callback?
> 
> So I think it's a false positive but fair enough given the
> current user interfaces seems likely to be rather odd.
> 
> Please sanity check all this.
This is still open.  I'm going to mark the series as expecting
a new version in patchwork as it's been sitting a while without
activity and loose track of status after a week or two!

Jonathan
> 
> One other thing inline.
> 
> Jonathan
> 
> 
> > ---
> >  drivers/iio/adc/Kconfig            |  2 +-
> >  drivers/iio/adc/at91-sama5d2_adc.c | 30 ++++++++++++++++++++++++++++++
> >  2 files changed, 31 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index 3755a81c1efd..85b443853a08 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -647,7 +647,7 @@ config AT91_SAMA5D2_ADC
> >  	select IIO_TRIGGERED_BUFFER
> >  	help
> >  	  Say yes here to build support for Atmel SAMA5D2 ADC which is
> > -	  available on SAMA5D2 SoC family.
> > +	  available on SAMA5D2 and SAMA7 SoC families.
> >  
> >  	  To compile this driver as a module, choose M here: the module will be
> >  	  called at91-sama5d2_adc.
> > diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> > index 3e9feb824a66..c1e5139a058c 100644
> > --- a/drivers/iio/adc/at91-sama5d2_adc.c
> > +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> > @@ -528,6 +528,15 @@ static const struct at91_adc_temp_calib_layout sama7g5_temp_calib = {
> >  	.p1_scale = { .numerator = 1000, .denominator = 1 },
> >  };
> >  
> > +static const struct at91_adc_temp_calib_layout sama7d65_temp_calib = {
> > +	.tag_idx = 1,
> > +	.p1_idx = 3,
> > +	.p4_idx = 2,
> > +	.p6_idx = 5,
> > +	.min_len = 11,
> > +	.p1_scale = { .numerator = 1, .denominator = 1000 },
> > +};
> > +
> >  /* Temperature sensor calibration - Vtemp voltage sensitivity to temperature. */
> >  #define AT91_ADC_TS_VTEMP_DT		(2080U)
> >  
> > @@ -766,6 +775,24 @@ static const struct at91_adc_platform sama7g5_platform = {
> >  	.temp_calib_layout = &sama7g5_temp_calib,
> >  };
> >  
> > +static const struct at91_adc_platform sama7d65_platform = {
> > +	.layout = &sama7g5_layout,
> > +	.adc_channels = &at91_sama7g5_adc_channels,
> > +	.nr_channels = AT91_SAMA7G5_SINGLE_CHAN_CNT +
> > +		       AT91_SAMA7G5_DIFF_CHAN_CNT +
> > +		       AT91_SAMA7G5_TEMP_CHAN_CNT,
> > +	.max_channels = ARRAY_SIZE(at91_sama7g5_adc_channels),
> > +	.max_index = AT91_SAMA7G5_MAX_CHAN_IDX,
> > +	.hw_trig_cnt = AT91_SAMA7G5_HW_TRIG_CNT,
> > +	.osr_mask = GENMASK(18, 16),
> > +	.oversampling_avail = { 1, 4, 16, 64, 256 },
> > +	.oversampling_avail_no = 5,
> > +	.chan_realbits = 16,
> > +	.temp_sensor = true,
> > +	.temp_chan = AT91_SAMA7G5_ADC_TEMP_CHANNEL,  
> Is this ever used?
> 
> > +	.temp_calib_layout = &sama7d65_temp_calib,
> > +};
> > +
> >  static int at91_adc_chan_xlate(struct iio_dev *indio_dev, int chan)
> >  {
> >  	int i;
> > @@ -2632,6 +2659,9 @@ static const struct of_device_id at91_adc_dt_match[] = {
> >  	}, {
> >  		.compatible = "microchip,sama7g5-adc",
> >  		.data = &sama7g5_platform,
> > +	}, {
> > +		.compatible = "microchip,sama7d65-adc",
> > +		.data = &sama7d65_platform,
> >  	}, {
> >  		/* sentinel */
> >  	}  
> 
> 

