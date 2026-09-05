Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60312DEA61;
	Sat,  5 Sep 2026 01:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788572552; cv=none; b=LkmE0ZAgAsCnEn9MXC9xbRfOZqSkZMAEcGMUcUUzKoV+SsDc6k/pa0WF2PwgTZmt9nkptlNm2B2CXT7Sl32yud7vgTxr+v3mW/gNXyu2JCjwVRsfuZsfuwuEOlF4GRP9qWeX6fBQ4aQfOKuzdA6qTmEYLQZSrP1TyLrKKRDh6+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788572552; c=relaxed/simple;
	bh=N8YkD6Wp7Lk6TGB7lq6v2Ub/Clxfsbb9vMlCMDLBEkU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BuNe4z+vIEigO5zKWPpJ1Ea4IB1gcOg1KZdBaT0ZUMZtR7C3LwI1EqqvAORIgPjUOTRDEe8AxLGBZCCwilJJvavSdrrbhRNaYIQ+qVoEOvaIxSIWFaJACgN0Dr/yxdd0HYVo7B0RyLovJqHx0aPwIXOGT5ScYleBwk6WqgdoAso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VefCHUmW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VefCHUmW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60DF1F00A3D;
	Sat,  5 Sep 2026 01:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788572551;
	bh=MfsEVPw7kIKne+Ntx/TjFc2LVvyDbkTQDSPDWVMF1PE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VefCHUmWj0dUhkhii1npy3JB2vKsFWxXmJDzOuvD1cZrimqUveNwHN5iLd3qCIQyB
	 u0xM2l3QXa01Dzc87D/0Lb2nSx6IWrpDw3udZw+SSxPw9QkmbcKVbZYocelvwFFj/H
	 8aQbLrELvUQ+TsBQS4SRw3lzekvOPl7T9kzEQPJxQi4ROUnAzep8Cla2YNoT/TJJGv
	 +mYx62DsMh5huYYtGuKuQdo61QzbRUNyrP10QHIN0Cthe5krL3fk6NEKcIkLaYMRmi
	 E4VuJWii4CdRz7lsqQGYopR3hwOFpE49dLXV0t5H1mzZUfuKOboMyBLNzfpbQDSp5H
	 JhrfehV7z3KPQ==
Date: Sat, 5 Sep 2026 02:42:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Hans de Goede <hansg@kernel.org>
Cc: Vladyslav Ivashchenko <cactucatu4eckuu@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: axp288: Add TS bias override for Haier HV103H
Message-ID: <20260905024225.468a2959@jic23-huawei>
In-Reply-To: <bdd9e2c0-ce13-422b-90ff-0311cc251b15@kernel.org>
References: <20260904133155.51290-1-cactucatu4eckuu@gmail.com>
	<bdd9e2c0-ce13-422b-90ff-0311cc251b15@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 4 Sep 2026 21:48:21 +0200
Hans de Goede <hansg@kernel.org> wrote:

> Hi,
> 
> On 4-Sep-26 3:31 PM, Vladyslav Ivashchenko wrote:
> > The Haier HV103H firmware configures the AXP288 TS pin bias
> > current to 60 uA. This causes the battery temperature reading to
> > cross the charging temperature threshold under load, incorrectly
> > stopping battery charging.
> > 
> > Setting the TS bias current to 80 uA fixes the temperature
> > measurement and prevents charging from being incorrectly disabled.
> > 
> > Add a DMI quirk to use the 80 uA TS bias current on the Haier
> > HV103H.
> > 
> > Signed-off-by: Vladyslav Ivashchenko <cactucatu4eckuu@gmail.com>  
> 
> Thanks, patch looks good to me:
> 
> Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
> 
> Regards,
> 
> Hans
> 

Fixes tag appropriate?  There was the original dance of keeping the firmware
version, then this table was added to fix that up.  Anyhow, I'm thinking yes
and tag should be:


Fixes: 9bcf15f75cac ("iio: adc: axp288: Fix TS-pin handling")

But bit awkward as anyone trying to just back port to that better have
been paying attention and picked up the following, so lets have that as well with comment
Fixes: 048058399f19 ("iio: adc: axp288: Override TS pin bias current for some models") # Add necessary infrastructure

With those two, applied to the fixes-togreg branch of iio.git

Shout if you think this should be done differently.
> 
> > ---
> >  drivers/iio/adc/axp288_adc.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/iio/adc/axp288_adc.c b/drivers/iio/adc/axp288_adc.c
> > index c8283279c47..c98863d612a 100644
> > --- a/drivers/iio/adc/axp288_adc.c
> > +++ b/drivers/iio/adc/axp288_adc.c
> > @@ -207,6 +207,14 @@ static const struct dmi_system_id axp288_adc_ts_bias_override[] = {
> >  		},
> >  		.driver_data = (void *)(uintptr_t)AXP288_ADC_TS_BIAS_80UA,
> >  	},
> > +	{
> > +		/* Haier HV103H */
> > +		.matches = {
> > +		  DMI_MATCH(DMI_SYS_VENDOR, "Haier"),
> > +		  DMI_MATCH(DMI_PRODUCT_NAME, "HV103H"),
> > +		},
> > +		.driver_data = (void *)(uintptr_t)AXP288_ADC_TS_BIAS_80UA,
> > +	},
> >  	{ }
> >  };
> >    
> 

