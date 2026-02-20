Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B898231D390
	for <linux-iio@vger.kernel.org>; Fri, 20 Feb 2026 15:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771599718; cv=none; b=IQ+gfC8Q5hp61Ds1KV6FunMQ9Oc3LTCTxkpnfnFfVZbwEaMUP0TEqfmjJHVqXpwsHpGa+o/c6JsSI9byObI6Y1poeeNieYrKblj091nImMISGntzthV33xPW+gT+uPsWxz6zUbTOjISJepdwPCdtDLJd3cSm017hjGFqrMxFRgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771599718; c=relaxed/simple;
	bh=6Y12Uzch3TzdjfAK/OuxGN9j2WQ+8rN+3jjVGGTTMbY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IvxNA6P1JFIL7DHMq1uuU3qhinnUSM5CAJj9o6a23PkyEVGHC1llcg9Nx2RMKWB+MOmI6teXTW3HwhkhyHNQ1UGC7veXT9zm1Z9J63osvejchnLBlVMxIbX+nYjgBXGDg2smbSHHdc6b1+CWroksMIfeV8vfJMkXU9D9xVssnGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETRotp1r; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETRotp1r"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso16369115e9.1
        for <linux-iio@vger.kernel.org>; Fri, 20 Feb 2026 07:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771599715; x=1772204515; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=INSOaj9IdQ4dvKY2JaPNnX8iQyo3gEJxS22WbQ95Cgk=;
        b=ETRotp1raxBz708Y2aJUpjsRwGPA2Gx3cSEbWEbthsALjcQhUZ9F14riQ1Af0+GdYX
         1jWDXLqV92rNh316kGAVPF/ttqY8YWpt43j+HmrquFmZoFtfy31j7pB8b3TM2A49qqBS
         rYwXk2fi7o3+PDQzPIXiydr1huMHjLTCJkLOSttHf95jQVVglWALk5EYAh2vSS7i7K6v
         VC/jUgcGodM251OZN1SSKghLWImnuYp4RzqQ9nfn6lK9bDY7wxVJz7ldYKkS+XVRevOL
         ucz8WFbWVd75m3sK67KQ/ZP7d0sWXySkqsoDnbgQU/Cs7B62KYTF0iN/NTCngb1Thm9J
         1WZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771599715; x=1772204515;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=INSOaj9IdQ4dvKY2JaPNnX8iQyo3gEJxS22WbQ95Cgk=;
        b=Csl+Ve/OjaS60wjd+9bwdp9RI95T9vAF3E2/UFsp5Zm+FRjhUlncci+WLz0PI4jg0W
         m4YXKT7SAa6Xim6n67CODFqoBdRKyUUz3BXT77im9UBfnS4S6WjsVAwklnJugnVxTvZS
         w3UyQdM0uwaCAss2QPEHOOLNMDEV4pSH6xkCpsBAFRNycxMoy2uOCNG3j5xJov1de/yt
         H4BioLwCgPftSxnAKsYDmzHjONuYFcSLpMt9/n6Ye0DJGScgpvpsQnTa4sLR+mCE59YS
         7rlN0No8tQa0YMnk3DElu3Irj0bOqZVb1QN0WiWwdNrNWmE724/7GOYNmlatVunLmYw/
         KNaA==
X-Forwarded-Encrypted: i=1; AJvYcCWhNS4l4C1EL/RapkxNvyeMY/r8kcfTRcx/r6hZ3dft8Ti8LIs7o7LDoTzRPnnxUE23bfOXQh7fM4c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjx/NTwmpjf56IxGh8IBPjusJLdzJqpiDCdNvh6pi0m1s4HQjO
	GWujVzNswAPTAsX8zUttuuDc/WW68UX6c+17fvPcPvIgCq6B8HBkWN59
X-Gm-Gg: AZuq6aKYhJAz25jz0salvyY2hyvep7oiowMv77SvnorhI33DRVLCmPOpWiOMdVRed5f
	/FpQsZMn1UIGWZ2Vm6VP5uJgBan8IN+EPRBSjt0kayxnckRr7+dSi7fK8gcEfQB2JvpXuWXANBG
	Tgk4xhaSf5XqxFaSQd/Bsaev+bkGVhzAuaGuBmsexKYsACc6yzQmtm0pZJEJqoB6qOZQUtwlzEv
	7kAGW9EML8vex7kE2AD49ekICTWBa5lSRiVP78PwK8s3IpK7Uk9/m7LxY6VIo07Vxt0bXYc+8JW
	7zzVFivQCiVoHUbcfnuZy1In6BhnSKF/rzQ7cq1NjAXpeqgKL2GohPY6ujnmxEz0UrlPSHTelAO
	jZJ9Iv/vX4pSAuk3+F8i4cQa7vixo/2Qpq7IFssAeMDlS9WVTDkGVFE62sfXSMUy27seIikIVkU
	IfMz0fRfdmDhUT/rUi5ZjcS3wBm9qILDE=
X-Received: by 2002:a05:600c:4e42:b0:483:76b2:cacf with SMTP id 5b1f17b1804b1-48398aee83amr147131735e9.32.1771599714711;
        Fri, 20 Feb 2026 07:01:54 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31d1b0esm78319555e9.11.2026.02.20.07.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 07:01:54 -0800 (PST)
Message-ID: <a6a2fc3ebb45fa4d7b379d552196d56eb13fa8d3.camel@gmail.com>
Subject: Re: [PATCH 2/3] iio: dac: ad5706r: Add support for AD5706R DAC
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Jonathan Cameron	 <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=	
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring	
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 <ukleinek@kernel.org>, 	linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org
Date: Fri, 20 Feb 2026 15:02:37 +0000
In-Reply-To: <aZg-vtenBU2rKKX_@smile.fi.intel.com>
References: <20260220-dev_ad5706r-v1-0-7253bbd74889@analog.com>
	 <20260220-dev_ad5706r-v1-2-7253bbd74889@analog.com>
	 <4fd329ed6416fd2f8e2a72adfa5a77f73107948b.camel@gmail.com>
	 <aZg-vtenBU2rKKX_@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-02-20 at 13:00 +0200, Andy Shevchenko wrote:
> On Fri, Feb 20, 2026 at 10:48:59AM +0000, Nuno S=C3=A1 wrote:
> > On Fri, 2026-02-20 at 16:02 +0800, Alexis Czezar Torreno wrote:
>=20
> ...
>=20
> > > +static void ad5706r_debugs_init(struct iio_dev *indio_dev)
> > > +{
> > > +	struct dentry *d =3D iio_get_debugfs_dentry(indio_dev);
> >=20
> > It should have:
> >=20
> > if (!IS_ENABLED(CONFIG_DEBUGFS))
> > 	return
>=20
> But why? The debugfs is a stub when disabled, nobody should do that
> in the cases when the main purpose is not the debugfs code.

Because the compiler can then optimize away all of the above code...

- Nuno S=C3=A1

>=20
> > > +	debugfs_create_file_unsafe("streaming_addr", 0600, d,
> > > +				=C2=A0=C2=A0 indio_dev, &ad5706r_streaming_addr_fops);
> > > +	debugfs_create_file_unsafe("streaming_len", 0600, d,
> > > +				=C2=A0=C2=A0 indio_dev, &ad5706r_streaming_len_fops);
> > > +	debugfs_create_file_unsafe("streaming_data", 0600, d,
> > > +				=C2=A0=C2=A0 indio_dev, &ad5706r_streaming_data_fops);
> > > +	debugfs_create_file_unsafe("streaming_reg_access", 0600, d,
> > > +				=C2=A0=C2=A0 indio_dev, &ad5706r_streaming_reg_access_fops);
> > > +	debugfs_create_file_unsafe("spi_speed_hz_write", 0600, d,
> > > +				=C2=A0=C2=A0 indio_dev, &ad5706r_spi_speed_write_fops);
> > > +	debugfs_create_file_unsafe("spi_speed_hz_read", 0600, d,
> > > +				=C2=A0=C2=A0 indio_dev, &ad5706r_spi_speed_read_fops);
> > > +}
>=20
> ...
>=20
> > > +	/* Find which index has this register value */
> > > +	for (i =3D 0; i < ARRAY_SIZE(mux_out_sel_reg_values); i++) {
>=20
> 	for (size_t i...)
>=20
> > > +		if (mux_out_sel_reg_values[i] =3D=3D reg_byte) {
> > > +			st->mux_out_sel =3D i;
> > > +			return i;=C2=A0 /* Return index, not register value */
> > > +		}
> > > +	}
>=20
> ...
>=20
> > > +	return ret ? ret : len;
>=20
> Use Elvis operator
>=20
> 	return ret ?: len;
>=20
> ...
>=20
>=20
> > > +	{},
>=20
> IIO has a style for terminator entry, along with confusing trailing comma=
.
> If it's a sentinel, it must be one even at a compile time.
>=20
> > > +};
>=20
> ...
>=20
> > > +	st->debug_spi_speed_hz_write =3D 10000000;
> > > +	st->debug_spi_speed_hz_read =3D 10000000;
>=20
> units.h and other headers for your help
>=20
> 10 * HZ_PER_MHZ
>=20
> ...
>=20
> > > +	st->sampling_frequency =3D 1000000;
>=20
> In the similar way.
>=20
> ...
>=20
> > > +	st->reference_volts =3D 2500;
>=20
> 2.5kV?! I think you mistakenly put volts where should be _mV
>=20
> ...
>=20
> > > +	for (i =3D 0; i < 4; i++) {
>=20
> Magic 4.
>=20
> > > +		st->hw_active_edge[i] =3D HW_ACTIVE_EDGE_RISING_EDGE;
> > > +		st->range_sel[i] =3D RANGE_SEL_50;
> > > +		st->output_state[i] =3D OUTPUT_STATE_NORMAL_SW;
> > > +		st->ldac_trigger_chn[i] =3D LDAC_TRIGGER_CHN_HW_TRIGGER;
> > > +		st->toggle_trigger_chn[i] =3D TOGGLE_TRIGGER_CHN_HW_TRIGGER;
> > > +		st->dither_trigger_chn[i] =3D DITHER_TRIGGER_CHN_HW_TRIGGER;
> > > +		st->multi_dac_sel_ch[i] =3D MULTI_DAC_SEL_CH_EXCLUDE;
>=20
> Hmm... Perhaps memsetXX()? But original loop with the defined iterator wi=
ll be
> okay:
>=20
> 	for (unsigned int i =3D 0; i < $MAGIC_CONST; i++) {
>=20
> > > +	}
>=20
> ...
>=20
> > > +	st->resetb_gpio =3D devm_gpiod_get_optional(dev, "dac-resetb", GPIO=
D_OUT_LOW);
> > > +	if (IS_ERR(st->resetb_gpio)) {
> > > +		return dev_err_probe(dev, PTR_ERR(st->resetb_gpio),
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to get RESET_B GPIO\n");
> > > +	}
>=20
> > > +	st->shdn_gpio =3D devm_gpiod_get_optional(dev, "dac-shdn", GPIOD_OU=
T_HIGH);
> > > +	if (IS_ERR(st->shdn_gpio)) {
> > > +		return dev_err_probe(dev, PTR_ERR(st->shdn_gpio),
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to get SHDN GPIO\n");
> > > +	}
>=20
> The {} are not needed when the body is a single call.
>=20
> ...
>=20
> > > +static const struct of_device_id ad5706r_of_match[] =3D {
> > > +	{ .compatible =3D "adi,ad5706r" },
> > > +	{ },
>=20
> See above about terminator entry style.
>=20
> > > +};
