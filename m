Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7DD3B2FC8;
	Mon, 17 Aug 2026 20:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786998366; cv=none; b=lCi8eMtmwKGykOH9gD+GW2V2SvalBbmkbFlFgfiK26bud/Orbo6obgUiwH5pDZOj/fF6Crj5+2D7BF0c7ZKgxjHkU680OiV/Dpt/mtpHgOAklO8xiCoZiVjN8CAR+bQGsq5f/TVmUqFetRjUTHjtqIODB6CfG5R1B4ByvJuV+tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786998366; c=relaxed/simple;
	bh=KNN2xvRHFyGPok60d+EX+kMGyHtPX1crLjZQ3/njrUc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k0Q5voOD9Hq+zlPgKHR2Pr6bo77QwVDm5AezGA1CpHGgF31GAbtMHng6HxUiMDgOEucjptMHaHMQMiBzTemxXKCNQmxH7nFM6WeV9DTzgh79f7Al7kQBImSIVaXQSxPJss+dznBrxxr/jDZ+XOoSKY04hr6CXsMPtY51hVftRpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWz5G07t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWz5G07t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F6C1F000E9;
	Mon, 17 Aug 2026 20:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786998364;
	bh=bCTNO77ae4udygUkGPgxqjz79uc3oy+kaiRTXghlMfM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fWz5G07tIto6rK+qKLkNIEF2lSjH98G1TL0MNMos1VtgBTAM4vNQniil9SuPGAhVS
	 t3OEL+vKsOxELILmPUPd8NB5YPyzAoIB7IbtI7nQkAEpkBJnOBXbmQJeaVH1Hkl87q
	 Clu2lk1L0ezrdEm7hwCkH2sbmtdW4k+e52HcmWHNCOmObzBzKxRoDNz58dk83EhLHD
	 83WaJQBCriaMTQGlNDLNPmCOAsi7pOvU9Gb7EVByqodX6oDY67tOew+wY1M/Tr2KQb
	 wIaFHnem3FUGdNxj7+LkkiIpX0uiTTFzVsczgZRS7Gqldr11q8xzyfY5ULHQqGoeFm
	 meWn54NfykSFg==
Date: Mon, 17 Aug 2026 21:25:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Kurt Borja <kuurtb@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Linus
 Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 2/9] iio: adc: add the ti-ads1262 driver
Message-ID: <20260817212557.2d90d8f7@jic23-huawei>
In-Reply-To: <aoLEv_txdTE7SqS3@ashevche-desk.local>
References: <20260807-ads126x-v3-0-f89925d72792@gmail.com>
	<20260807-ads126x-v3-2-f89925d72792@gmail.com>
	<20260816223029.0da04d1e@jic23-huawei>
	<aoLEv_txdTE7SqS3@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Aug 2026 11:22:23 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sun, Aug 16, 2026 at 10:30:29PM +0100, Jonathan Cameron wrote:
> > On Fri, 07 Aug 2026 22:58:24 -0500
> > Kurt Borja <kuurtb@gmail.com> wrote:  
> 
> ...
> 
> > > +static const struct reg_default ads1262_reg_defaults[] = {
> > > +	{ ADS1262_INTERFACE_REG,
> > > +	  FIELD_PREP_CONST(ADS1262_INTERFACE_STATUS_MASK, true) |
> > > +	  FIELD_PREP_CONST(ADS1262_INTERFACE_CRC_MASK, true) },
> > > +	{ ADS1262_MODE0_REG,		0x00 },
> > > +	{ ADS1262_MODE1_REG,
> > > +	  FIELD_PREP_CONST(ADS1262_MODE1_FILTER_MASK, ADS1262_FILTER_FIR) },
> > > +	{ ADS1262_MODE2_REG,
> > > +	  FIELD_PREP_CONST(ADS1262_MODE2_DR_MASK, ADS1262_DR_20_SPS) },
> > > +	{ ADS1262_INPMUX_REG,
> > > +	  FIELD_PREP_CONST(ADS1262_INPMUX_MUXN_MASK, ADS1262_INPMUX_AIN1) },
> > > +	{ ADS1262_IDACMUX_REG,
> > > +	  FIELD_PREP_CONST(ADS1262_IDACMUX_MUX2_MASK, ADS1262_IDACMUX_NO_CONN) |
> > > +	  FIELD_PREP_CONST(ADS1262_IDACMUX_MUX1_MASK, ADS1262_IDACMUX_NO_CONN) },
> > > +	{ ADS1262_IDACMAG_REG,		0x00 },
> > > +	{ ADS1262_REFMUX_REG,		0x00 },
> > > +	{ ADS1262_TDACP_REG,		0x00 },
> > > +	{ ADS1262_TDACN_REG,		0x00 },
> > > +	{ ADS1262_GPIOCON_REG,		0x00 },
> > > +	{ ADS1262_GPIODIR_REG,		0x00 },
> > > +	{ ADS1262_ADC2CFG_REG,		0x00 },
> > > +	{ ADS1262_ADC2MUX_REG,
> > > +	  FIELD_PREP_CONST(ADS1262_ADC2MUX_MUXN2_MASK, ADS1262_INPMUX_AIN1) },
> > > +};  
> > I'm not particularly keen on this formatting from a readability point of view.
> > Maybe using named intializers would help:
> > 
> > static const struct reg_default ads1262_reg_defaults[] = {
> > 	{ 
> > 		.reg = ADS1262_INTERFACE_REG,
> > 		.def = FIELD_PREP_CONST(ADS1262_INTERFACE_STATUS_MASK, true) |
> > 		       FIELD_PREP_CONST(ADS1262_INTERFACE_CRC_MASK, true),  
> 
> And looking at this, this has not to be booleans! Please, use proper integers
> instead (I think 1 is what you wanted).

Gah - I didn't noticed that at all!

Good spot.

> 
> > //extra indent fine here for readability reasons if we end up with some long lines
> > 	},
> > 	{ .reg = ADS1262_MODE0_REG, .def = 0x00 },
> > etc or just maybe use the more open form of the first element for all of them.
> > burns a bunch of lines, but is easy to read.   
> 

