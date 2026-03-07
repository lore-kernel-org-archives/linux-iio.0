Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7547926D4F7
	for <linux-iio@vger.kernel.org>; Sat,  7 Mar 2026 21:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772918288; cv=none; b=SwFO6U4OrTlqiKuUquyeXBRLtAGGhAIe9i85mqgzaxO9KgMBdBjDy2uW0+Uf0i9o5QklLKd491RLphJ1MtlRwzOLU4ZTJNiOogTMTD1QiHplIf+j9iDa0+uWePxIKY3UyX1sTOtpi/avbQ84xQNTHSyufMA8RGeARw/oliQ03Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772918288; c=relaxed/simple;
	bh=MhbrdTi9gVFuh6N/nDA7yix7KlLsu2/Qx2LlBF0gga4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PnJcY+fsMvafanmBVsZDSpQXUYonL2pjyED4CajYm89uzf9IFyaNUdRR4i2lRUJ9LTS0eU5J0yPtbdi5iD8msJgEG+4H+KO+/wlicIPdg8YkyFD5Q4rSUkwIHoAMr6GQfBROGPavetKUuoAH9gtlrEIe8+JAc1F9FKbAV6SgCV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+zv5dQR; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+zv5dQR"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-5ffb61b0babso2530312137.3
        for <linux-iio@vger.kernel.org>; Sat, 07 Mar 2026 13:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772918286; x=1773523086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OLKpt64yKdOOJysGkN8Ulwp3Owm7MfQ5+nKTzRfPKRU=;
        b=J+zv5dQReoWKXE0mrja8W/CMPYYSCCi7q3GmBX8aE/SRTJIKoPAUhUWCaLsSDubIgz
         YEVy0yAT2XLezNaYFgrmYapg9Qdo0dQgKoXfYH/KqiVzL4mVOPDsGgwVvtaFDAqqNtB0
         Ea1P+SO42G+UuWYuIt/kB4J7vt4zARbFQfOBnCcxFiGTJhwyG/rYqNWu/290nFj1SDB6
         gnEsEZLKwEBw8lpglWkZjN0hCT9L5K7wnirPlOBbifiqL3ezTVkzF8JoyT4LTmWmoTyM
         6yNolm5fxlG9JwrryUVnvFJ9VVNzDgQsDU+awHEuDhUBpNkTzlJpNMfTLoVujZX9q5Hw
         2RNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772918286; x=1773523086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OLKpt64yKdOOJysGkN8Ulwp3Owm7MfQ5+nKTzRfPKRU=;
        b=LJtkCWuOcfRP7ucFvhVUoC2ujmZKQmOEIj+oSGqefNApzzpA7tovs/6iS82JS0aKVm
         CU9bLupMXX8J0D/RnS0o2qgS7l9eyFR2n4fpIjb9yZEfx8TmWoNThOKdqoZnkDjY0w4c
         7C6CYBm6rEkmPKSgRbB4l1V5z3BK1h6nzDYUtTbaNugJTBhnmqQJ8qgk0m6gyWCR2qjn
         gqqfUrEzqQMfYo0HO14GIH4jGyLIxcBLXf01imulRt4p5aHYboscxNWcIzbl3vMXnRe3
         PAysmVpRrB5unR/fH1AJZ84UdU8vpA64ime+5u+i0urNelxbISkQ+OMJl5E0a66DMgc3
         rekw==
X-Forwarded-Encrypted: i=1; AJvYcCWxNpLoyFI3KujIL4Zuqna+3yEO2ySjXXbWVdRmRnPNhXSQ4x0wk/4W24vgOKYhB20F5hXy2IhRIjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsFa8TcEzb1nK59MkJ5+GUgOqASnZutbZNJ9Jvbyisc0lvOSQT
	WKzoFL3CGUrbcvSbqODIUY9xBnJZvUNRUQ3C1SurdNWq3NQ44JSNJWsU
X-Gm-Gg: ATEYQzy+hi4dZmZz+l2r3CvygVl3nffQTYTw+JM/iUPGqq4k3puMwpv5ob1ukWncVXO
	E4H+L2bSkIMu+GzE5vD1Og/onRXHjegA3sm7YD+kEQ46zaOgjZ8zNoDnN1MGMjesjdEtmNYiv56
	mlhY1aDOOaZMuSH5FXGWcRRNNe/gdE/vWSxKtrGTDCVBG1gExWeGTj3WQ7Udm1/s0cYtD7XDjDQ
	HHqjpAQqlV6u6ZRPjO6OXSyRc12+5lgVK3Ja06OuCRZ6Q/etl1xxPXVBE6rfW1FOUHxyO0/IbtN
	I7mrT7HlKFtqAFYIE5RQnV797gKZpeZH+hFx5AWIGObj47Ep+GlbV2HkmAZ/E+unyF4/cZo3oF8
	y1kFa0LBqHiQB9X2vWxdbjU1GtVzDcgrol9FAtxWimoc5O4lgJ4+LGyfvPzAsqFMpLMLCOBk+0n
	n9KAcxDP9wsbFQJhv3Nmbo1n27uHfQfIA=
X-Received: by 2002:a05:6102:26d4:b0:5ff:c64d:2283 with SMTP id ada2fe7eead31-5ffe61cf0b4mr2755999137.30.1772918286319;
        Sat, 07 Mar 2026 13:18:06 -0800 (PST)
Received: from localhost ([2804:30c:966:7b00:fd18:61b8:43a7:4049])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ffe8bd6d6bsm5547413137.10.2026.03.07.13.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 13:18:05 -0800 (PST)
Date: Sat, 7 Mar 2026 18:18:41 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Bhargav Joshi <rougueprince47@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev, tomasborquez13@gmail.com
Subject: Re: [RFC PATCH] staging: iio: ad9832: modernize ABI and remove dds.h
 dependency
Message-ID: <aayWMaEzbBxjCU9r@debian-BULLSEYE-live-builder-AMD64>
References: <20260305210347.120446-1-rougueprince47@gmail.com>
 <aayTAmJ4x5_965Gg@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aayTAmJ4x5_965Gg@debian-BULLSEYE-live-builder-AMD64>

+CC: tomasborquez13@gmail.com
for the opportunity to comment about the proposed updates.

On 03/07, Marcelo Schmitt wrote:
> Hello Bhargav,
> 
> On 03/06, Bhargav Joshi wrote:
> > The AD9832 driver currently relies on legacy custom IIO macros defined
> > in dds.h. This triggers checkpatch.pl warnings (NON_OCTAL_PERMISSIONS)
> > and, more importantly, exposes a non-standard sysfs ABI (e.g.,
> > frequency0, frequency1, phase0-3) directly to user space.
> > 
> > This patch removes the custom macros and migrates the driver to standard
> > IIO API mechanisms:
> > - Standard attributes (frequency, phase) now use info_mask_separate.
> > - Non standard specific toggles (frequencysymbol, phasesymbol,
> >   pincontrol) have been migrated to an ext_info array.
> > - Remove dds.h header dependency.
> > - Pointless frequency_scale and phase_scale attributes are dropped as
> >   suggested by Jonathan in
> >   https://lore.kernel.org/linux-iio/20251231180939.422e9e62@jic23-huawei/
> > 
> > NOTE: This patch introduces an intentional ABI changes. The non-standard
> > attributes (out_altvoltage0_frequency0, etc.) have been removed. They
> > are replaced by standard attributes (out_altvoltage0_frequency and
> > out_altvoltage0_phase). Routing to correct register while writing is
> > handled by checking currently active frequencysymbol or phasesymbol.
> > 
> > Testing: This patch has been strictly compile-tested. I do not have
> > access to physical AD9832 hardware. I am submitting this as an RFC to
> > see if these changes are acceptable, and to ask if someone with physical
> > hardware could test thisg and provide a Tested-by tag.
> > 
> > Signed-off-by: Bhargav Joshi <rougueprince47@gmail.com>
> > ---
> > This patch is heavily inspired from discussions in following
> > thread.
> > https://lore.kernel.org/linux-iio/20251215190806.11003-1-tomasborquez13@gmail.com/
> 
> Thanks for making that clear. Still, a change log highlighting the main
> differences between yours and Tomas' patches would have been appreciated.
> 
> By the way, I'm assuming Tomas is fine with you caring on the driver update?
> 
> More comments inline.
> > 
> > Since this is an RFC please let me know if these changes are acceptable.
> > 
> >  drivers/staging/iio/frequency/ad9832.c | 135 +++++++++++++++----------
> >  1 file changed, 80 insertions(+), 55 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> > index b87ea1781b27..066a1b9ee8d5 100644
> > --- a/drivers/staging/iio/frequency/ad9832.c
> > +++ b/drivers/staging/iio/frequency/ad9832.c
> ...
> > -/*
> > - * see dds.h for further information
> > - */
> > +#define AD9832_EXT_INFO(_name, _ident) { \
> > +	.name = _name, \
> > +	.write = ad9832_write_ext_info, \
> Why no .read procedure? I think at least for the
> out_enable/out_altcurrent0_enable attribute we would want a read function.
> 
> > +	.private = _ident, \
> > +	.shared = IIO_SEPARATE, \
> > +}
> >  
> > -static IIO_DEV_ATTR_FREQ(0, 0, 0200, NULL, ad9832_write, AD9832_FREQ0HM);
> > -static IIO_DEV_ATTR_FREQ(0, 1, 0200, NULL, ad9832_write, AD9832_FREQ1HM);
> > -static IIO_DEV_ATTR_FREQSYMBOL(0, 0200, NULL, ad9832_write, AD9832_FREQ_SYM);
> > -static IIO_CONST_ATTR_FREQ_SCALE(0, "1"); /* 1Hz */
> > -
> > -static IIO_DEV_ATTR_PHASE(0, 0, 0200, NULL, ad9832_write, AD9832_PHASE0H);
> > -static IIO_DEV_ATTR_PHASE(0, 1, 0200, NULL, ad9832_write, AD9832_PHASE1H);
> > -static IIO_DEV_ATTR_PHASE(0, 2, 0200, NULL, ad9832_write, AD9832_PHASE2H);
> > -static IIO_DEV_ATTR_PHASE(0, 3, 0200, NULL, ad9832_write, AD9832_PHASE3H);
> > -static IIO_DEV_ATTR_PHASESYMBOL(0, 0200, NULL,
> > -				ad9832_write, AD9832_PHASE_SYM);
> > -static IIO_CONST_ATTR_PHASE_SCALE(0, "0.0015339808"); /* 2PI/2^12 rad*/
> > -
> > -static IIO_DEV_ATTR_PINCONTROL_EN(0, 0200, NULL,
> > -				ad9832_write, AD9832_PINCTRL_EN);
> > -static IIO_DEV_ATTR_OUT_ENABLE(0, 0200, NULL,
> > -				ad9832_write, AD9832_OUTPUT_EN);
> > -
> > -static struct attribute *ad9832_attributes[] = {
> > -	&iio_dev_attr_out_altvoltage0_frequency0.dev_attr.attr,
> > -	&iio_dev_attr_out_altvoltage0_frequency1.dev_attr.attr,
> > -	&iio_const_attr_out_altvoltage0_frequency_scale.dev_attr.attr,
> > -	&iio_dev_attr_out_altvoltage0_phase0.dev_attr.attr,
> > -	&iio_dev_attr_out_altvoltage0_phase1.dev_attr.attr,
> > -	&iio_dev_attr_out_altvoltage0_phase2.dev_attr.attr,
> > -	&iio_dev_attr_out_altvoltage0_phase3.dev_attr.attr,
> I'd try to split this patch into smaller ones.
> One for updating the frequency and phase channels.
> 
> > -	&iio_const_attr_out_altvoltage0_phase_scale.dev_attr.attr,
> One patch for dropping the _scale attributes.
> 
> > -	&iio_dev_attr_out_altvoltage0_pincontrol_en.dev_attr.attr,
> > -	&iio_dev_attr_out_altvoltage0_frequencysymbol.dev_attr.attr,
> > -	&iio_dev_attr_out_altvoltage0_phasesymbol.dev_attr.attr,
> > -	&iio_dev_attr_out_altvoltage0_out_enable.dev_attr.attr,
> > -	NULL,
> > +static const struct iio_chan_spec_ext_info ad9832_ext_info[] = {
> > +	AD9832_EXT_INFO("pincontrol_en", AD9832_PINCTRL_EN),
> Why did you drop the comment about making pincontrol_en a DT property?
> Nevertheless, pincontrol_en is another piece I'd put in a separate patch.
> 
> > +	AD9832_EXT_INFO("frequencysymbol", AD9832_FREQ_SYM),
> > +	AD9832_EXT_INFO("phasesymbol", AD9832_PHASE_SYM),
> Maybe I'm missing something but this doesn't seem to follow the suggested ABI.
> https://lore.kernel.org/linux-iio/20251221194358.3284acb4@jic23-huawei/
> Why did you chose this particular naming for the ABI?
> 
> > +	AD9832_EXT_INFO("out_enable", AD9832_OUTPUT_EN),
> I think it is okay to change the enable from device attribute to channel
> attribute in this case since it's staging and this device has only one channel.
> Though, I believe we should call it out_altcurrent0_enable, as proposed on
> Tomas' set. I'd also set this on a separate patch.
> 
> > +	{ }
> >  };
> >  
> > -static const struct attribute_group ad9832_attribute_group = {
> > -	.attrs = ad9832_attributes,
> > +static const struct iio_chan_spec ad9832_channels[] = {
> > +	{
> > +		.type = IIO_ALTVOLTAGE,
> Maybe I've missed something. Didn't the previous review reached the conclusion
> that the channels should be IIO_ALTCURRENT? The datasheet it documents IOUT as
> current output.
> 
> > +		.indexed = 1,
> > +		.channel = 0,
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_FREQUENCY) |
> > +				      BIT(IIO_CHAN_INFO_PHASE),
> > +		.ext_info = ad9832_ext_info,
> > +	},
> >  };
> >  
> >  static const struct iio_info ad9832_info = {
> > -	.attrs = &ad9832_attribute_group,
> > +	.write_raw = ad9832_write_raw,
> No .read_raw ?
> 
> >  };
