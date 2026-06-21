Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EDA2DF13B;
	Sun, 21 Jun 2026 16:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782060360; cv=none; b=cLVdzqcVT4lFYrvgxbaVRiOK/IwlF/+WqC27CIv4kPbIgl878oaJ6HYh982SW4sTwOr8xEqu+c1yzGziO8Iyrqt4T14ZRqS05fZgH4MdU5K1PGvKe9PRwdeoXyrQZjTY25Vg5Bw2w86tRsCn/xcqmdv+xj0lDzfIPOaWf++iBv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782060360; c=relaxed/simple;
	bh=ig1C5CFRa6WD9cJ4FcL+fqph3cfZrvWTvPWloh/GBkU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W/vO+jsitZr/oHCykuR/+mF9BlWpemyO1gwMHOb+w3l7HXLF8RoVlc3ET/zy/rFPHsSUXTEzJ2GTz4XnEjs+Dvts5bjnrQyU00bIoM+pjQT3XuxHyXnCrsRyos9ZAnhwtdgTVnV/Iq0Q/nCWzJvEi+seGXWWPi7ujv9bi77DAMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cIaXEtv4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cIaXEtv4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF991F000E9;
	Sun, 21 Jun 2026 16:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782060357;
	bh=INqJV2eeVyYiOXo7lhs3DqfTsBONgM9yvlTbiG1xwmY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cIaXEtv4zmpwWPQTTx0tzZhWOtyzoq4LYwDCB0EA6eBjTtoI31edjo5+gwtGif39O
	 prOKMpCLG0GyyPfKEhJ8WPFjl+Nto9qxFVzEoc8mdV6raqFW8bX5FPpGrZ0umAHGsn
	 jgGzILQAoo96RuOSLIi0lu/UKIPorYxyYk23nPcAfIMYEHsIC/NpJNA39pX7wS2CcX
	 /ypyNdFPAhbW8FMkAsicQSch7dZHflblWM/yGy9N9Yi1FRqrO0/iItSONmCCPLTOe/
	 0f2IxWiqjyDbDecvu/zrGgwVoOZDjkA6TqU8BQNBUFuw//xsGklX8MHe1iY5i4buSG
	 ZLFZkj6jqOjQw==
Date: Sun, 21 Jun 2026 17:45:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Kim Seer Paller <kimseer.paller@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux@analog.com,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v2 4/4] iio: dac: ad3530r: Add support for
 AD3532R/AD3532
Message-ID: <20260621174548.5eca5db6@jic23-huawei>
In-Reply-To: <ai_OeEegWavHcNF1@ashevche-desk.local>
References: <20260615-iio-ad3532r-support-v2-0-84a0af8b83fa@analog.com>
	<20260615-iio-ad3532r-support-v2-4-84a0af8b83fa@analog.com>
	<ai_OeEegWavHcNF1@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jun 2026 13:05:44 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Jun 15, 2026 at 02:20:18PM +0800, Kim Seer Paller wrote:
> > The AD3532R/AD3532 is a 16-channel, 16-bit voltage output DAC with a
> > dual-bank register architecture (bank 0 at 0x1000 for channels 0-7,
> > bank 1 at 0x3000 for channels 8-15). It shares similar functionality
> > with AD3530R (channel configuration, LDAC triggering, powerdown control),
> > the main difference being the register address map due to the dual-bank
> > architecture, handled by table-driven helpers.
> > 
> > Add AD3532R-specific register definitions, channel specs, per-bank
> > register arrays, a dedicated ad3532r_set_dac_powerdown(), and per-chip
> > regmap_config to limit debugfs-exposed register space to each variant's
> > actual address range.  
> 
> ...
> 
> 
> >  	help
> > -	  Say yes here to build support for Analog Devices AD3530R, AD3531R
> > -	  Digital to Analog Converter.
> > +	  Say yes here to build support for Analog Devices AD3530/AD3530R,
> > +	  AD3531/AD3531R, and AD3532/AD3532R Digital to Analog Converters.  
> 
> This just shows how unscalable the above text is. That's why we usually
> recommend to make the list explicit and separated.
> 
> 	  Say yes here to build support for the following Analog Devices
> 	  Digital to Analog Converters:
> 	  - AD3530/AD3530R (8-channel)
> 	  - AD3531/AD3531R (4-channel)
> 	  - AD3532/AD3532R (16-channel)
> 
> (and looking into the C-file change, perhaps add here as well distinctive
>  information, such as number of channels, in the parentheses).
> 
> >  	  To compile this driver as a module, choose M here: the
> >  	  module will be called ad3530r.  
> 
> ...
> 
> > +#define AD3532R_INTERFACE_CONFIG_A_0		0x1000
> > +#define AD3532R_INTERFACE_CONFIG_A_1		0x3000
> > +#define AD3532R_OUTPUT_OPERATING_MODE_0		0x1020
> > +#define AD3532R_OUTPUT_OPERATING_MODE_1		0x1021
> > +#define AD3532R_OUTPUT_OPERATING_MODE_2		0x3020
> > +#define AD3532R_OUTPUT_OPERATING_MODE_3		0x3021
> > +#define AD3532R_OUTPUT_CONTROL_0		0x102A
> > +#define AD3532R_OUTPUT_CONTROL_1		0x302A
> > +#define AD3532R_REFERENCE_CONTROL_0		0x103C
> > +#define AD3532R_REFERENCE_CONTROL_1		0x303C
> > +#define AD3532R_SW_LDAC_TRIG_0			0x10E5
> > +#define AD3532R_SW_LDAC_TRIG_1			0x30E5
> > +#define AD3532R_INPUT_CH_0			0x10EB
> > +#define AD3532R_INPUT_CH_1			0x30EB
> > +#define AD3532R_MAX_REG_ADDR			0x30F9  
Whilst we are here, Sashiko thinks there is an off by one on that value
as it's the lower of the two registers that make up channel 15.
https://sashiko.dev/#/patchset/20260615-iio-ad3532r-support-v2-0-84a0af8b83fa%40analog.com
It also suggests an existing bug that it would be good to look into.

> 
> Hmm... I dunno if it's better to sort by values (so the "bank" 0 goes together
> followed by "bank" 1). Jonathan, what's your preference here? Nuno, David?
That is how people will typically check them vs the datasheet so I
agree with numeric order.  Maybe with a comment at the top about there
effectively being two banks. Many of the registers are effectively copies
for the new channels but not all of them, so a macro approach would
probably be even more confusing.

Jonathan
