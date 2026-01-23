Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A00E298CC4;
	Fri, 23 Jan 2026 08:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769157493; cv=none; b=JpozcUSZBhvxtmpLBUsDETuk9J94tPBZZhhQniTY1QkLWgXlFJqvfTZ2XRTKV/ymG5LaqFDK63gIgX2WSY4kZlKwCN4Zluv8bDGHSv43ymZZJ3hbj96ezcKHN6llDR/0acbSzvx9juKPQCVK7fiIf5LCgmFa2y/P6f+A+YXZ5kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769157493; c=relaxed/simple;
	bh=fPyuoratl6HbCeT0tWDU3yk4cFwDHGaQelGp502qtZM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cW9jIYx2LcPh0ar/f6aIj37SO9dsVGvY7gMcbY6dE1nRHfeYw8zyQ/kmDCPq4UZym2/ReadpqKIMa01QajNzIVrrggCLb0aQdSoC4ecZmTw+1lrOhXe3BR/u41RHROlQBp2yLaYby+IHdgVp2xRguAOTNyEiUhX/NxKZh4bEmw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pERvvdy6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pERvvdy6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A917FC4CEF1;
	Fri, 23 Jan 2026 08:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769157492;
	bh=fPyuoratl6HbCeT0tWDU3yk4cFwDHGaQelGp502qtZM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pERvvdy6v1345EvqYczVQg/d98b972mDQpoo960/PYwCMTJ9KYHz/nLH4Vmj2EMrg
	 fFrSnUPrNzfXLrawIk8yE+cbMW9KFAhtr/QZq9c335MbZ9A2LPZlvmHW+K0w7YTMb7
	 0UwOVDV2R0ZsV5/rmhdgMHnYfxT4ukLRqeWo7TcDnGjDAsd6C9wDjuSJGBkXW0hjFJ
	 3FzRawzpxDDr9QKyk/bzqFUnI4n10HqULw9nRfXlf8oJTbM1ufxNV7n0aP6CxprPNb
	 V2etYd0qW3taG4rOakRcE7rqTqWQGsEfs51lqpivgQWweAfto8hOI5FCMYsw+nYq3H
	 LwTXKd2qcshYA==
Date: Fri, 23 Jan 2026 08:38:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Alexandru Ardelean
 <alexandru.ardelean@analog.com>
Subject: Re: [PATCH 4/7] iio: amplifiers: ad8366: Update device support
Message-ID: <20260123083804.2b586649@jic23-huawei>
In-Reply-To: <20260123083318.53bce905@jic23-huawei>
References: <20260119-iio-ad8366-update-v1-0-8044e23e964a@analog.com>
	<20260119-iio-ad8366-update-v1-4-8044e23e964a@analog.com>
	<20260123083318.53bce905@jic23-huawei>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Jan 2026 08:33:18 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 19 Jan 2026 14:36:58 +0000
> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> 
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > 
> > This patch adds support for following digital step attenuators:
> > 
> >  * HMC271A: 1dB LSB 5-Bit Digital Attenuator SMT, 0.7 - 3.7 GHz
> >  * ADRF5720: 0.5 dB LSB, 6-Bit, Digital Attenuator, 9 kHz to 40 GHz
> >  * ADRF5730: 0.5 dB LSB, 6-Bit, Digital Attenuator, 100 MHz to 40 GHz
> >  * ADRF5731: 2 dB LSB, 4-Bit, Digital Attenuator, 100 MHz to 40 GHz
> >  * HMC1018A: 1.0 dB LSB GaAs MMIC 5-BIT DIGITAL ATTENUATOR, 0.1 - 30 GHz
> >  * HMC1019A: 0.5 dB LSB GaAs MMIC 5-BIT DIGITAL ATTENUATOR, 0.1 - 30 GHz
> > 
> > Additionally, copyright notice was updated with current year.
> > 
> > Co-developed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > Co-developed-by: Michael Hennerich <michael.hennerich@analog.com>
> > Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>  
> 
> I don't want to delay this series if possible (needs to be ready early next
> week to meet the merge window cut off) so the stuff below can be in a follow
> up series if you prefer.  It is fairly simple so if you want to do it before
> these new parts are added, even better.

Actually. I changed my mind.  For some reason I thought this was several
versions in and I'd failed to note this earlier!

As a new series, please add this stuff as part of the early cleanup before
adding new devices.

> 
> They will make further additions to this driver simpler and easier to review.
> > ---
> >  drivers/iio/amplifiers/Kconfig  |  6 +++
> >  drivers/iio/amplifiers/ad8366.c | 86 ++++++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 91 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/amplifiers/Kconfig b/drivers/iio/amplifiers/Kconfig
> > index a8a604863eed..39d280d4d437 100644
> > --- a/drivers/iio/amplifiers/Kconfig
> > +++ b/drivers/iio/amplifiers/Kconfig
> > @@ -18,7 +18,13 @@ config AD8366
> >  	    AD8366 Dual-Digital Variable Gain Amplifier (VGA)
> >  	    ADA4961 BiCMOS RF Digital Gain Amplifier (DGA)
> >  	    ADL5240 Digitally controlled variable gain amplifier (VGA)
> > +	    ADRF5720: 0.5 dB LSB, 6-Bit, Silicon Digital Attenuator
> > +	    ADRF5730: 0.5 dB LSB, 6-Bit, Silicon Digital Attenuator
> > +	    ADRF5731: 2 dB LSB, 4-Bit, Silicon Digital Attenuator
> > +	    HMC271A: 1dB LSB 5-Bit Digital Attenuator SMT
> >  	    HMC792A 0.25 dB LSB GaAs MMIC 6-Bit Digital Attenuator
> > +	    HMC1018A: 1.0 dB LSB GaAs MMIC 5-BIT Digital Attenuator
> > +	    HMC1019A: 0.5 dB LSB GaAs MMIC 5-BIT Digital Attenuator
> >  	    HMC1119 0.25 dB LSB, 7-Bit, Silicon Digital Attenuator
> >  
> >  	  To compile this driver as a module, choose M here: the
> > diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
> > index 63bb9f0179eb..160a8ab0c2ee 100644
> > --- a/drivers/iio/amplifiers/ad8366.c
> > +++ b/drivers/iio/amplifiers/ad8366.c
> > @@ -5,10 +5,16 @@
> >   *   AD8366 Dual-Digital Variable Gain Amplifier (VGA)
> >   *   ADA4961 BiCMOS RF Digital Gain Amplifier (DGA)
> >   *   ADL5240 Digitally controlled variable gain amplifier (VGA)
> > + *   ADRF5720: 0.5 dB LSB, 6-Bit, Silicon Digital Attenuator, 9 kHz to 40 GHz
> > + *   ADRF5730: 0.5 dB LSB, 6-Bit, Silicon Digital Attenuator, 100 MHz to 40 GHz
> > + *   ADRF5731: 2 dB LSB, 4-Bit, Silicon Digital Attenuator, 100 MHz to 40 GHz
> > + *   HMC271A: 1dB LSB 5-Bit Digital Attenuator SMT, 0.7 - 3.7 GHz
> >   *   HMC792A 0.25 dB LSB GaAs MMIC 6-Bit Digital Attenuator
> > + *   HMC1018A: 1.0 dB LSB GaAs MMIC 5-BIT DIGITAL ATTENUATOR, 0.1 - 30 GHz
> > + *   HMC1019A: 0.5 dB LSB GaAs MMIC 5-BIT DIGITAL ATTENUATOR, 0.1 - 30 GHz
> >   *   HMC1119 0.25 dB LSB, 7-Bit, Silicon Digital Attenuator
> >   *
> > - * Copyright 2012-2019 Analog Devices Inc.
> > + * Copyright 2012-2026 Analog Devices Inc.
> >   */
> >  
> >  #include <linux/device.h>
> > @@ -29,7 +35,13 @@ enum ad8366_type {
> >  	ID_AD8366,
> >  	ID_ADA4961,
> >  	ID_ADL5240,
> > +	ID_ADRF5720,
> > +	ID_ADRF5730,
> > +	ID_ADRF5731,
> > +	ID_HMC271,
> >  	ID_HMC792,
> > +	ID_HMC1018,
> > +	ID_HMC1019,
> >  	ID_HMC1119,
> >  };
> >  
> > @@ -67,10 +79,34 @@ static const struct ad8366_info ad8366_infos[] = {  
> 
> Refactor step 2: Split this up into individual structures and drop
> the enum.  The presence of that enum is encouraging us to use
> code to cover diffferences in parts where simple data in here would
> be cleaner.
> 
> 
> >  		.gain_min = -11500,
> >  		.gain_max = 20000,
> >  	},
> > +	[ID_ADRF5720] = {  
> 
> Refactor step 1:  Add everything in the switch statements based
> on ID as data in here.  Looks like the channel arrays, a flag
> for gpio presence and a few more constants like the ones already here.
> 
> 
> > +		.gain_min = -31500,
> > +		.gain_max = 0,
> > +	},
> > +	[ID_ADRF5730] = {
> > +		.gain_min = -31500,
> > +		.gain_max = 0,
> > +	},
> > +	[ID_ADRF5731] = {
> > +		.gain_min = -30000,
> > +		.gain_max = 0,
> > +	},
> > +	[ID_HMC271] = {
> > +		.gain_min = -31000,
> > +		.gain_max = 0,
> > +	},
> >  	[ID_HMC792] = {
> >  		.gain_min = -15750,
> >  		.gain_max = 0,
> >  	},
> > +	[ID_HMC1018] = {
> > +		.gain_min = -31000,
> > +		.gain_max = 0,
> > +	},
> > +	[ID_HMC1019] = {
> > +		.gain_min = -15500,
> > +		.gain_max = 0,
> > +	},
> >  	[ID_HMC1119] = {
> >  		.gain_min = -31750,
> >  		.gain_max = 0,
> > @@ -95,9 +131,17 @@ static int ad8366_write(struct iio_dev *indio_dev,
> >  		st->data[0] = ch_a & 0x1F;
> >  		break;
> >  	case ID_ADL5240:
> > +	case ID_ADRF5720:
> > +	case ID_ADRF5730:
> > +	case ID_ADRF5731:
> >  		st->data[0] = (ch_a & 0x3F);
> >  		break;
> > +	case ID_HMC271:
> > +		st->data[0] = bitrev8(ch_a & 0x1F) >> 3;
> > +		break;
> >  	case ID_HMC792:
> > +	case ID_HMC1018:
> > +	case ID_HMC1019:
> >  	case ID_HMC1119:
> >  		st->data[0] = ch_a;
> >  		break;
> > @@ -135,9 +179,23 @@ static int ad8366_read_raw(struct iio_dev *indio_dev,
> >  		case ID_ADL5240:
> >  			gain = 20000 - 31500 + code * 500;
> >  			break;
> > +		case ID_ADRF5720:
> > +		case ID_ADRF5730:
> > +			gain = -1 * code * 500;
> > +			break;
> > +		case ID_ADRF5731:
> > +			gain = -1 * code * 500;
> > +			break;
> >  		case ID_HMC792:
> >  			gain = -1 * code * 500;
> >  			break;
> > +		case ID_HMC271:
> > +		case ID_HMC1018:
> > +			gain = -31000 + code * 1000;
> > +			break;
> > +		case ID_HMC1019:
> > +			gain = -15500 + code * 500;
> > +			break;
> >  		case ID_HMC1119:
> >  			gain = -1 * code * 250;
> >  			break;
> > @@ -187,9 +245,23 @@ static int ad8366_write_raw(struct iio_dev *indio_dev,
> >  	case ID_ADL5240:
> >  		code = ((gain - 500 - 20000) / 500) & 0x3F;
> >  		break;
> > +	case ID_ADRF5720:
> > +	case ID_ADRF5730:
> > +		code = (abs(gain) / 500) & 0x3F;
> > +		break;
> > +	case ID_ADRF5731:
> > +		code = (abs(gain) / 500) & 0x3C;
> > +		break;
> >  	case ID_HMC792:
> >  		code = (abs(gain) / 500) & 0x3F;
> >  		break;
> > +	case ID_HMC271:
> > +	case ID_HMC1018:
> > +		code = ((gain - 1000) / 1000) & 0x1F;
> > +		break;
> > +	case ID_HMC1019:
> > +		code = ((gain - 500) / 500) & 0x1F;
> > +		break;
> >  	case ID_HMC1119:
> >  		code = (abs(gain) / 250) & 0x7F;
> >  		break;
> > @@ -275,8 +347,14 @@ static int ad8366_probe(struct spi_device *spi)
> >  		break;
> >  	case ID_ADA4961:
> >  	case ID_ADL5240:
> > +	case ID_HMC271:
> >  	case ID_HMC792:
> >  	case ID_HMC1119:
> > +	case ID_ADRF5720:
> > +	case ID_ADRF5730:
> > +	case ID_ADRF5731:
> > +	case ID_HMC1018:
> > +	case ID_HMC1019:
> >  		st->reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset", GPIOD_OUT_HIGH);
> >  		if (IS_ERR(st->reset_gpio)) {
> >  			ret = PTR_ERR(st->reset_gpio);
> > @@ -335,8 +413,14 @@ static void ad8366_remove(struct spi_device *spi)
> >  static const struct spi_device_id ad8366_id[] = {
> >  	{"ad8366",  ID_AD8366},
> >  	{"ada4961", ID_ADA4961},
> > +	{"adrf5720", ID_ADRF5720},
> > +	{"adrf5730", ID_ADRF5730},
> > +	{"adrf5731", ID_ADRF5731},
> >  	{"adl5240", ID_ADL5240},
> > +	{"hmc271a", ID_HMC271},
> >  	{"hmc792a", ID_HMC792},
> > +	{"hmc1018a", ID_HMC1018},
> > +	{"hmc1019a", ID_HMC1019},
> >  	{"hmc1119", ID_HMC1119},
> >  	{ }
> >  };
> >   
> 

