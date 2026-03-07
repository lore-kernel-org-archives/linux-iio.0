Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075B8341076
	for <linux-iio@vger.kernel.org>; Sat,  7 Mar 2026 18:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772906680; cv=none; b=KbGcOfkAHjBZM5H8Tuz0h5DyQUPW1jBw+FKvs3DII++vzNW5arrqSE/EIT3tAuJSARzWI5gBWn74U9WAj6nx8T5opoW+SG7U9bEr7u4Fl7QRvPj5gEvzZatjFvmF7E2EbHaVuy9j4ENGyfrBBytmIw+UiW6249MrAnXJE+6quMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772906680; c=relaxed/simple;
	bh=PIWAY6q+ap1EOwu7fIbVwLp8hf3bGvW1uAse7EGNdcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bl58zNybfMnBCm3qY8veygHHs0yjQtfnlzm+P0TdEbWRIKoskNxxGDoDKMPkp+pSZzhzj/faYXcXOw7Ewc1Q6zZcdU0Be3eIrAkcmm6Z4y4lPjTNiHzW2tuiHlB/MQU5MYXCIhE54Dbujiyb3/thZqr5cmyynQGD+fvyRww1EFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iXoDenpx; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXoDenpx"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2be1b5fe11cso6605015eec.0
        for <linux-iio@vger.kernel.org>; Sat, 07 Mar 2026 10:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772906677; x=1773511477; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tEdYN3jRsyLYGUSSW785KXgJq2PqLPyTq0Ql+kXv6qQ=;
        b=iXoDenpxVoVaQbcM/AOdxdMgRYE039Pjeorv7bpY6xr/NcyzQOgsWYAYvTuTIDbPes
         N9MskFnJeYAeUOTgbWxfUEZ4IyFLRkWtvk7ic+3Ji3+Do2OoXj+xJDTep0r4nZcvs3t0
         HVPYLVgGY4HYggrvfe15PR3Fk+1zqKzJoVYF+oEDvJPwsiHVvno2Vrod2ff1q8tQkPEC
         FzEwDorj1VpCQfPAs+qslkfG7dqkMIVnaOOXMJ2VXkVQHkaddrfru1MToDlMn1BXVF6Q
         9UfwrkyV1VwTClh8lMC90LgqQJ4Aepd75oeVAPuYVbR52pXs+45hefhSq9/yCfFznXCs
         OLdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772906677; x=1773511477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tEdYN3jRsyLYGUSSW785KXgJq2PqLPyTq0Ql+kXv6qQ=;
        b=H2I5+i/DX03vDoJgR5UR719vO2qkO4bA0KVpNGuRiUGD/rX299GNQA7rUuO2SDBY7p
         gFa30Wd/nRyDNqxGcGtK0ylRxllln7yU2v2IkvbRLc5BxLNk4xaFk/eozOqT4BE27mUV
         sjOjf1C57tCmuByaDbxtHwe6xZiCJWLSLgS8TbLIsb/RiIiRFvgjjHowAJy4646H17vE
         ykQvz9e8ZcbeyxQhMHkiA0s+I2leeJ+ws+RUD6MHV1USCYI9+8gkg85iGw0GXXUQljDC
         Q/VtJb+ae4kbdnEBeS3lejXJGAJCdhZXBXsyI/LRziEZrwEI5PaFekHXWAc2HYu/5rpd
         SD1A==
X-Forwarded-Encrypted: i=1; AJvYcCWnl97NbphGXkWEjhy9yX9HAbhpKQV9TxJXt7dNY8z/xiFjPdD8ElYwSZx5Py1B/OApCR2lIydMWG4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+PXHqRxvP9EkMJUnr8IWsN/Cbh+cEUEpHeAvervLwwJ3jBPla
	WaIy2SYXu2r5KJ8W2Ct1ltGNeYpR/uElvwFrPbYThOlQznHFWbPBOah2
X-Gm-Gg: ATEYQzxREmS7Wp2K7QynQ7fTwLu0oABxEekCq+t8bzTwXGVN0W1I7hU4KQLb4ggLQOQ
	SEDaLGRLjr4c53c0h+G5oK8FDu9AsYOCDH9AEUImDesBffGG5fzfdb3cCM0XzTp5O298kSaepH6
	Gno6+2KOoY6BvCppxFnjxiwgmBI+bi1dvz0PGXBFnlqwolTzEHrQHE8ULmy6xKiEcZ3Mp3KosfP
	uSZs72knyLVUqKF7MUt30cxK5EaDQlJgmvmdh9CJ7DsuiNh94SibycXERbzRLToWyGoakC9962I
	eoieq5QMlVGE4l/pTlNlmaRbiSdbR0o2+MXyNbcPP6pW7eAnC5Qb65RUHID1qQJOuoTiD1tXVMY
	nCOx3c3cQCm42iFYjp86TLDJe/E1lqroUt4P4SAiyWOFzpb30VYuu64rJ75xW+rv0BSeyBu46En
	nRvsAtmCsc4BWIMKTcIbQshgdtegUeCiXN
X-Received: by 2002:a05:7301:4188:b0:2be:e4b:60bc with SMTP id 5a478bee46e88-2be4dfee268mr2231460eec.9.1772906677079;
        Sat, 07 Mar 2026 10:04:37 -0800 (PST)
Received: from google.com ([2601:647:5e00:4acd:6ebb:c69c:ad7e:23c9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f948324sm4383540eec.17.2026.03.07.10.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 10:04:36 -0800 (PST)
Date: Sat, 7 Mar 2026 18:04:33 +0000
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 5/6] iio: adc: ti-ads7950: switch to using
 devm_regulator_get_enable_read_voltage()
Message-ID: <aaxoIWL7NIa-2VkU@google.com>
References: <20260305-ti-ads7950-facelift-v3-0-a23fdd1a079e@gmail.com>
 <20260305-ti-ads7950-facelift-v3-5-a23fdd1a079e@gmail.com>
 <20260307114947.0b946dfb@jic23-huawei>
 <27ffa24d-a388-46eb-8df7-04624cd32ea1@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27ffa24d-a388-46eb-8df7-04624cd32ea1@baylibre.com>

On Sat, Mar 07, 2026 at 11:43:32AM -0600, David Lechner wrote:
> On 3/7/26 5:49 AM, Jonathan Cameron wrote:
> > On Thu, 05 Mar 2026 11:21:56 -0800
> > Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > 
> >> The regulator is enabled for the entire time the driver is bound to the
> >> device, and we only need to access it to fetch voltage, which can be
> >> done at probe time.
> >>
> >> Switch to using devm_regulator_get_enable_read_voltage() which
> >> simplifies probing and unbinding code.
> >>
> >> Suggested-by: David Lechner <dlechner@baylibre.com>
> >> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Hi.
> > 
> > I think this broke the ACPI case (where regulator isn't available).

Oh, you're right.

> > 
> > Jonathan
> > 
> >> ---
> >>  drivers/iio/adc/ti-ads7950.c | 45 +++++++++++---------------------------------
> >>  1 file changed, 11 insertions(+), 34 deletions(-)
> >>
> >> diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
> >> index 273c35e03185..847e83baa876 100644
> >> --- a/drivers/iio/adc/ti-ads7950.c
> >> +++ b/drivers/iio/adc/ti-ads7950.c
> >> @@ -341,19 +341,9 @@ static int ti_ads7950_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
> >>  	return st->single_rx;
> >>  }
> >>  
> >> -static int ti_ads7950_get_range(struct ti_ads7950_state *st)
> >> +static unsigned int ti_ads7950_get_range(struct ti_ads7950_state *st)
> >>  {
> >> -	int vref;
> >> -
> >> -	if (st->vref_mv) {
> >> -		vref = st->vref_mv;
> >> -	} else {
> >> -		vref = regulator_get_voltage(st->reg);
> >> -		if (vref < 0)
> >> -			return vref;
> >> -
> >> -		vref /= 1000;
> >> -	}
> >> +	unsigned int vref = st->vref_mv;
> >>  
> >>  	if (st->cmd_settings_bitmask & TI_ADS7950_CR_RANGE_5V)
> >>  		vref *= 2;
> >> @@ -382,11 +372,7 @@ static int ti_ads7950_read_raw(struct iio_dev *indio_dev,
> >>  
> >>  		return IIO_VAL_INT;
> >>  	case IIO_CHAN_INFO_SCALE:
> >> -		ret = ti_ads7950_get_range(st);
> >> -		if (ret < 0)
> >> -			return ret;
> >> -
> >> -		*val = ret;
> >> +		*val = ti_ads7950_get_range(st);
> >>  		*val2 = (1 << chan->scan_type.realbits) - 1;
> >>  
> >>  		return IIO_VAL_FRACTIONAL;
> >> @@ -580,30 +566,24 @@ static int ti_ads7950_probe(struct spi_device *spi)
> >>  	spi_message_init_with_transfers(&st->scan_single_msg,
> >>  					st->scan_single_xfer, 3);
> >>  
> >> +	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "vref");
> >> +	if (ret < 0)
> > 
> > I think you need to check for -ENODEV and if you see than then
> > see if the acpi route below applies.  Otherwise on ACPI this will fail
> > and we'll fail the probe.
> > 
> 
> Or do something like:
> 
> 	if (ACPI_COMPANION(&spi->dev)) {
> 		ret = devm_regulator_get_enable(&spi->dev, "vref");
> 		if (ret)
> 			return dev_err_probe(&spi->dev, ret,
> 					     "Failed to get regulator \"vref\"\n");
> 
>  		st->vref_mv = TI_ADS7950_VA_MV_ACPI_DEFAULT;

We know that concept of regulators is not exposed on ACPI systems, and
we'd get a dummy here, so maybe just store st->vref_mv and not bother
with acquiring and enabling the dummy regulator?

Thanks.

-- 
Dmitry
