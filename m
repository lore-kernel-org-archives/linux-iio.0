Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E6936D506;
	Mon,  8 Jun 2026 18:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780941826; cv=none; b=GxdZz87AfHcanc0IYo87ThqfdhU9CfL4exCLJ/cKhFbDggI0+XC2V+8ZB44KsgGuxL9DNBj676hccKna/eRumXQ5aWjbilr1hhwzT2iqk4OS7CMJR4MKVA9VJBa+ViVt989AzbmipHAsD5VvonUXPc4QUGqinaVLiUeTosHc3HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780941826; c=relaxed/simple;
	bh=gnAsMFZZZxF2z+MD62lW/giOC+SNL7hsDRo0CSMhGkw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eK2kh5BHGfExjwZs76iIN3AUvAHGDtf6/+3QdYM7KtMIMx23By1fy6318um9ntM5Lw22yAjIV6kgXeG7UNf1T1p5MVv6yVrkugn+ulx+WlIgHSfAW1YvwLIv8WCAD+7Rj54soHCtsHvHBHvq3hIEzkmbYAO+vglzhbX0EZvlA+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/nVKrr7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/nVKrr7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF3A11F00893;
	Mon,  8 Jun 2026 18:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780941825;
	bh=sPIJN+8ipb8PNQpmrY9EexFbGy6ifSCbKaRGooyW0Ew=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=l/nVKrr7oajWR7+KDteJ8s8WjtUx7I3jwlAlQmX5mcGMGAJubqaJHuDb/C7CsFuXS
	 V1FcwSSuPUDbmXqKkhQlbgEgSicnGttBxZzp4UzCvVNxiWaCI6Xor4Of505e3qjB2Y
	 e1HA+H43mp7VczvydZ3SGOEtXqT7JF2ZQOewJdsNlSdpEkmINBszMNWcEmLaUEryfy
	 JSDc4XfOEcG9Q31DcphjAqdlvw7WnxZT1Ic7l5QY5/c3l5+2yHSEqX7nmyGNUmpNCW
	 wDfaTvU+BiFEsqm9M3KBD0Q6/YNfhHSbdhVudw7I/Ju7xf5wBWYh0+NrBC9jprLPDZ
	 n9gc1C6D/RI5Q==
Date: Mon, 8 Jun 2026 19:03:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jakub Szczudlo <jakubszczudlo40@gmail.com>, linux-iio@vger.kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 marcelo.schmitt@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, mike.looijmans@topic.nl, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, jorge.marques@analog.com,
 antoniu.miclaus@analog.com, mazziesaccount@gmail.com,
 jishnu.prakash@oss.qualcomm.com, duje@dujemihanovic.xyz, wens@kernel.org,
 sakari.ailus@linux.intel.com, linusw@kernel.org
Subject: Re: [PATCH 3/3] iio: adc: Add ti-ads1110 support to ti-ads1100
 driver
Message-ID: <20260608190336.2e90b297@jic23-huawei>
In-Reply-To: <CALoEA-xWB226gf01OdB5LBMRqrds=b2UN+DmXJdH1j6rq1c5-A@mail.gmail.com>
References: <20260607183542.368184-1-jakubszczudlo40@gmail.com>
	<20260607183542.368184-4-jakubszczudlo40@gmail.com>
	<CALoEA-xWB226gf01OdB5LBMRqrds=b2UN+DmXJdH1j6rq1c5-A@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Jun 2026 09:39:07 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> Hi Jakub,
> 
> various comments inline, some nitpicks and some more serious.
> 
> Josh
> 
> On Sun, 7 Jun 2026 at 20:38, Jakub Szczudlo <jakubszczudlo40@gmail.com> wrote:
> >
> > From: jszczudlo <jakubszczudlo40@gmail.com>
> >
> > add ADS1100 support  
> 
> Wrap the commit message to 72 characters per line, this is too
> short.
> 
> > make changing gain and datarate wait for new reading
> > fix unbalanced regulator disable when removing in singleshot mode  
> 
> Additionally, write the commit messages as regular sentences, not
> a list of changes.
> 
> >
> > Signed-off-by: jszczudlo <jakubszczudlo40@gmail.com>  
> 
> Ensure that your full name is in the Signed-off-by tag (this goes for all
> patches in this series).

A few follow ups to the good review you already have from Joshua.

> > @@ -85,6 +98,50 @@ static int ads1100_set_config_bits(struct ads1100_data *data, u8 mask, u8 value)
> >         return 0;
> >  };
> >
> > +static int ads11x0_get_voltage_microvolts(struct ads1100_data *data)
> > +{
> > +       if (data->has_reference_voltage)
> > +               return ADS1110_REFERENCE_VOLTAGE_MICROVOLT;
> > +       else
> > +               return regulator_get_voltage(data->reg_vdd);
> > +}
> > +
> > +static int ads11x0_get_voltage_milivolts(struct ads1100_data *data)
> > +{
> > +       return ads11x0_get_voltage_microvolts(data) / (MICRO / MILLI);
> > +}
> > +
> > +static bool ads11x0_new_data_ready(struct ads1100_data *data)
> > +{
> > +       int ret;
> > +       u8 buffer[3];
> > +
> > +       ret = i2c_master_recv(data->client, (char *)&buffer, sizeof(buffer));
> > +       if (ret < sizeof(buffer)) {  
> 
> Sashiko raises an issue here. sizeof returns a size_t, therefore the compiler
> will promote ret to a size_t, wrapping any potential negative error value to
> a large positive value, throwing away the error.
> 
> > +               dev_err(&data->client->dev, "I2C read fail: %d\n", ret);
> > +               return 0;
It gets thrown away here anyway which is also very wrong!  If an error occurs
it should be propagated. If it makes sense to ignore it, do that at the
caller and add a comment on why.
> > +       }
> > +
> > +       int return_val = FIELD_GET(ADS1100_CFG_ST_BSY, buffer[2]);

When there isn't a good reason to do otherwise we still flow oldstyle c
where local variable declarations come at the top of scope.
However

	return FIELD_GET();
should be fine.

> > +
> > +       return return_val;
> > +}


> >  static void ads1100_disable_continuous(void *data)
> > @@ -307,6 +383,7 @@ static int ads1100_probe(struct i2c_client *client)
> >         struct iio_dev *indio_dev;
> >         struct ads1100_data *data;
> >         struct device *dev = &client->dev;
> > +       const struct ads11x0_config *model;
> >         int ret;
> >
> >         indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> > @@ -334,10 +411,18 @@ static int ads1100_probe(struct i2c_client *client)
> >                 return dev_err_probe(dev, ret,
> >                                      "Failed to enable vdd regulator\n");
> >
> > -       ret = devm_add_action_or_reset(dev, ads1100_reg_disable, data->reg_vdd);
> > +       ret = devm_add_action_or_reset(dev, ads1100_reg_disable, data);
> >         if (ret)
> >                 return ret;
> >
> > +       model = device_get_match_data(dev);
> > +       if (!model)
> > +               return dev_err_probe(dev, ret,
> > +                               "Can't set device data\n");  
> 
> Hmm, if device_get_match_data fails, ret will still be 0 per previous
> devm_add_action_or_reset() call, therefore you're returning a "successful
> error". Additionally, the error message isn't aligned with the parenthesis.

Message also talks about 'setting' when it is 'getting' data from firmware.
So needs a rewrite.

Jonathan


