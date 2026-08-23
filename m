Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272FB35A3A4;
	Sun, 23 Aug 2026 22:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787523765; cv=none; b=CCaBGUSVF3T9UM+jEdnlZ5jaQXbxQbNwFQVW3oF3z2Sh1bi78xS4sTXos174qRRUN237k/kjHgDKQB+ZRfmx81lhlXukNAXaKj2obAShaTgpcaP0Cx2TdUpgE02WhQ29Q43BG279m//fWjAkqO4ESHrszQSjAKoEZTQBkGkw0Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787523765; c=relaxed/simple;
	bh=fXtMZZS5C3FxEqBpm1v5pNN4tz94jC7X2QLsSeRFRl0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D3J50+XEAq1l4eNzZpCLbt8CKI8IOHDJsBBICBe6tsurpxYlHcltGTx7KH8dpNMwMUEcwubagtPv6ir8fVs5UlzvPoJV9V6f4CrvsjzrQ67+4LVW5g2BrtTT68GxICVD6Z+JY81linAGPbsM4t1q9+KMP73OXydEGkaGaEyEfWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NdCqXwG+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NdCqXwG+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C5221F000E9;
	Sun, 23 Aug 2026 22:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787523764;
	bh=1NLfpzSAWsL05lqO2Ypn4+jUSXF2B9cxcj84lkL4/Oo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NdCqXwG+mfGene56BOP6uK08pOyN4+wGd9KG3uj+v81mqBk2CllKTuqHJe2fta85e
	 SrEFGHqpHBd1hQeq6XT176PYhsv77Ijwmrx/7UXccdPxFItU629BykmEDNxpp0LiE6
	 AE7ndx2uS2hmkyX9LslUJdWoQh2TpPYyCLmk4rf54BPFV9WaiU6AG4FBpS41EJuto6
	 UxtVpgFO12rSaA/CGT5vQJ5ycKJMlnxc/l7J59LW+Wt+YIg5Hrka4Z46tCpYolsIga
	 EhGqHWo5HX8SBZCcXtnLIQZ/yDllFDwuIM2lWEvKI3DLMcHplknDMcJ6HRRLdAufyS
	 mWBt1TumdKeZw==
Date: Sun, 23 Aug 2026 23:22:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: kr494167@gmail.com
Cc: azpijr@gmail.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: apds9999: register standby action after
 enabling device
Message-ID: <20260823232240.7d80fc85@jic23-huawei>
In-Reply-To: <20260726205030.4ca33bb8@jic23-huawei>
References: <20260724025802.13499-1-kr494167@gmail.com>
	<20260726205030.4ca33bb8@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Jul 2026 20:50:30 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 24 Jul 2026 08:28:02 +0530
> kr494167@gmail.com wrote:
> 
> > From: Surendra Singh Chouhan <kr494167@gmail.com>
> > 
> > apds9999_init() called devm_add_action_or_reset() at the start
> > of the function, before register configuration and before enabling the
> > device via APDS9999_MAIN_CTRL_LS_EN.
> > 
> > If register initialization failed during apds9999_init() (e.g. SMBus
> > write failures on LS_MEAS_RATE or LS_GAIN), devm_add_action_or_reset()
> > immediately triggered apds9999_standby(), writing to the control
> > register on a device that failed initialization and was never enabled.
> > 
> > Fix this by registering devm_add_action_or_reset() only after
> > APDS9999_MAIN_CTRL_LS_EN is successfully written to the control
> > register.
> > 
> > Fixes: 5f9363e52300 ("iio: light: add support for APDS9999 sensor")  
> 
> Given the side effect of this is write that is harmless, I don't
> think the fixes tag is justified. 
> 
> Having said that this is a logical improvement.
> 
> I would like Jose to have taken a look though before I consider picking
> it up so let us leave it on list for now.
> 
Seems they are busy or missed this.  So let me gamble...

Applied to the testing branch of iio.git which I will be rebasing on rc1
once available. Note that in the meantime I am happy to rebase so late
comments or tags are fine.

thanks

Jonathan

> Thanks,
> 
> Jonathan
> 
> > Signed-off-by: Surendra Singh Chouhan <kr494167@gmail.com>
> > ---
> >  drivers/iio/light/apds9999.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/iio/light/apds9999.c b/drivers/iio/light/apds9999.c
> > index 43fa9992c9c2..62620c4a2fbc 100644
> > --- a/drivers/iio/light/apds9999.c
> > +++ b/drivers/iio/light/apds9999.c
> > @@ -100,10 +100,6 @@ static int apds9999_init(struct apds9999_data *data)
> >  	u8 regval;
> >  	int ret;
> >  
> > -	ret = devm_add_action_or_reset(dev, apds9999_standby, client);
> > -	if (ret)
> > -		return ret;
> > -
> >  	guard(mutex)(&data->lock);
> >  
> >  	regval = FIELD_PREP(APDS9999_LS_RES_MASK, APDS9999_RES_18BIT) |
> > @@ -121,8 +117,12 @@ static int apds9999_init(struct apds9999_data *data)
> >  		return ret;
> >  	data->als_gain_idx = APDS9999_GAIN_3X;
> >  
> > -	return i2c_smbus_write_byte_data(client, APDS9999_REG_MAIN_CTRL,
> > -					 APDS9999_MAIN_CTRL_LS_EN);
> > +	ret = i2c_smbus_write_byte_data(client, APDS9999_REG_MAIN_CTRL,
> > +					APDS9999_MAIN_CTRL_LS_EN);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return devm_add_action_or_reset(dev, apds9999_standby, client);
> >  }
> >  
> >  static int apds9999_read_channel(struct apds9999_data *data, u8 reg,  
> 
> 

