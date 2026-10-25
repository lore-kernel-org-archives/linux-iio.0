Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792971771;
	b=diKEyBs3CmWwepxPS8BuxS3EaHVPFVsfRbBgYkemDJM0PqnkYaCC3BbZBeJDTHfN7ChT
	 kBRCO25DOuG8cj/8WygOZA5iB4I2jMQFIm4IrycpuMAjOTZUHCscz23qykr7DQlQTI/9F
	 W+ggFMGvpv0XFwruTJtuc6+/x889zbM2DMyzjIC6Ll7MU28x7pfOrp7sB/WD0qYV51YIn
	 XSvrUEwM5zXzvYJArmZ6x+WL6ufDXEISyvWG5gA3EWb57ZXnHbUV1SuITXfjEu8+M+Fma
	 482aCqvw2tTz6cBYaBKfcz471hveaxd6mzZ2lNtD0cNycRSxhs6C1l3LAh4fb6GYqJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792971771;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=mjEc846qK12NmucwoaUMxCDuJp2pVqdCBmGFmNcxzkc=;
	b=2X10MfC5Ql+s2TO1Ug5R5UVdhDm2FJUtUwWTjK57MKS1Gjv6+XOH8rFtXUGebrBQfKr6
	 D3gLN3jkdj9qWR3rn9kgZE9o0aeiH63VyUqQdA0JlKVINTLF637mFV3KS0CE55TX2JrqF
	 9a8T7zWtCUoHvcl8fjGIgZgGP87u89FH7DcQXolSUgulQLnaE5YPeWqibmfDOkWSHa4EZ
	 Ehy3T1s5+tVRpG27F7EP40I3TxhODlLwuEzsUW8Nu3AW/6tRTwPmQCymmi7kkXpeuK4Lm
	 qxAeiis9zfWDnPsBt+sBePf2Zn/RCqALBE32XBL7oI+wQhDTooXZV8j7fDhP6xlW0OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aqkr2esW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1663B606A31A;
	Sun, 25 Oct 2026 23:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aqkr2esW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F991F01825;
	Sun, 25 Oct 2026 23:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792971770;
	bh=mjEc846qK12NmucwoaUMxCDuJp2pVqdCBmGFmNcxzkc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aqkr2esWh8cv5AxNWaiYDWcX+C3yUzwLUx/ELGd8A7rvdIM1nqiIEcjZ8UGTHV3zj
	 vBFPuEEbc0S9YTcEjMtEcHyLSqtLumeNVJ8jvNPZH6fp99bihUdgH20Y7RSIe69gwH
	 bUFt++Ndd/wr3P7EPT7wJjJiE1xkng0ixJLVzAZ6aMAbZWO7TUVk2sNqKDFMl4AOw8
	 Hq7Q/sm9GmYqOgEBiEGy9m+CHJH0heDPSkbTtVTrcQlNh3gUqn590cDUx0hNtbyuNC
	 /Ma1xHmZfa09jumB1wQ1jtklXMcDIDJZPvJGMB9VWY5OAeRIA76dW4uPHxBFIGFSou
	 ID0MrmL9OFoEw==
Date: Sun, 25 Oct 2026 23:42:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Olivier Louvignes <olivier@mgcrea.io>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Paul
 Cercueil <paul@crapouillou.net>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org, Discussions about the Letux Kernel
 <letux-kernel@openphoenux.org>, Paul Boddie <paul@boddie.org.uk>, Andreas
 Kemnade <akemnade@kernel.org>
Subject: Re: [PATCH v2 2/2] iio: adc: Add a driver for the Ingenic X1600 ADC
Message-ID: <20261025234243.031acf32@jic23-hlaptop>
In-Reply-To: <3C468594-DAC6-4DD7-8394-4516F9D43917@goldelico.com>
References: <20261024041357.34346-1-olivier@mgcrea.io>
	<20261024041357.34346-2-olivier@mgcrea.io>
	<3C468594-DAC6-4DD7-8394-4516F9D43917@goldelico.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 24 Oct 2026 19:57:53 +0200
"H. Nikolaus Schaller" <hns@goldelico.com> wrote:

> Hi,
> 
> > Am 24.10.2026 um 06:13 schrieb Olivier Louvignes <olivier@mgcrea.io>:
> > 
> > The X1600's SAR ADC has four auxiliary channels, each with its own start
> > bit, interrupt flag and 12-bit result, and none of the touchscreen or
> > battery engines of the JZ47xx ADCs that ingenic-adc drives. Add a small  
> 
> I have checked a little and
> jz4780 has its unique SADC register set
> x1000  has no SADC (just a note for a clock reserved)
> x1600  has this register set for 4 channels
> x1830  shares the same register set
>        but has only 3 channels
> x2000  has a register set similar to the x1600
>        but has 5 channels
> x2600  has a completely different register model (and 16 channels)
> 
> So the x1600, x1830, x2000 only differ in number of channels and the bits
> in ADENA, ADCTRL, ADSTATE
> 
> > driver that exposes the four channels as voltages against the 3.3 V
> > reference.
> > 
> > There is no datasheet here: the register layout and the clock dividers
> > come from the X1600 driver of the vendor's 4.4 kernel.  
> 
> Or x2000... Since the x2000 is older, this IMHO should be an x2000 ADC
> driver where the x1600 is also compatible to.
> 
> But I am not sure what the policy is here. If the sequence of publication of
> some chips and derivatives should be used for the driver name and internal
> constants. Or if it can be based on which chip is lucky to find someone
> who writes a driver for that chip.

First supported part is normal choice - though here it seems like there
may be some low hanging fruit if Olivier is up for supporting the
similar parts from the start.  Even then he gets to choose naming
(often it is the one the author has to test with!)



> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index a802d8ee4dd9..7b5c3d3fcfdb 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -881,6 +881,16 @@ config INGENIC_ADC
> >  This driver can also be built as a module. If so, the module will be
> >  called ingenic_adc.
> > 
> > +config INGENIC_X1600_ADC
> > + tristate "Ingenic X1600 ADC driver"
> > + depends on MIPS || COMPILE_TEST
> > + help
> > +  Say yes here to build support for the SAR ADC of the Ingenic X1600
> > +  SoC and its four auxiliary channels.  
> 
> X1830 and X2000 should be mentioned here.
> 

If supported - hopefully Olivier doesn't mind doing that but
we normally wouldn't insist on it.

> > +static const struct iio_chan_spec x1600_adc_channels[] = {
> > + X1600_ADC_CHANNEL(0),
> > + X1600_ADC_CHANNEL(1),
> > + X1600_ADC_CHANNEL(2),
> > + X1600_ADC_CHANNEL(3),  
> 
> X21830 has no ADC_CHANNEL(3).
> X2000 has an ADC_CHANNEL(4).
> 

Depending on how likely buffered support (with timestamps) is
you can deal with that via a single array but changing
num_channels appropriately.

> > +};
> > +
> > +static void x1600_adc_power_down(void *data)
> > +{

> > + return devm_iio_device_register(dev, iio_dev);
> > +}
> > +
> > +static const struct of_device_id x1600_adc_of_match[] = {
> > + { .compatible = "ingenic,x1600-adc" },  
> 
> There should be some mechanism to make this driver compatible to x1830
> and x2000 as well and base the number of channels on this.

A chip_info type structure would work for this plus naming for
the various parts.

Jonathan
