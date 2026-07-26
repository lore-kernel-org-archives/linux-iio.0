Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE7235C6B8;
	Sun, 26 Jul 2026 18:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785089917; cv=none; b=B7CHuYD64rWI5F4TvQEC/UBePYlvFjyyHlXHiOapLbWyLSymMxmiVIjRS+LdTD50KzJzFmenOnAH6/0NAzXJW5KSOriea1qEKZEchPOVwaiHBmAGIxhhGGrxI8wcPPIGKVTJc9fI1kpzmRKtTHNIxseCpI1eRZgxaGqj+YA8biY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785089917; c=relaxed/simple;
	bh=hS4vXEt2REFFV4CR73elSBd3YHj0n/4ooyCfMyyWy/g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bM27F5GmheJwzPE/wmKXm8rxPISvxO2SifXNaBGnPyyuw+as5Ih+X+GfEQsZfDy3QrXPYOif/vO6fAPUJuWisbMDELQGUO3pyJ83g02h17jPhNnzP+gHwv/2BAXTJHhq2VNG6/kDjJhij6hQaUajWk9fg19Fdhi1PaPZ6OdPMCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6nFur2Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6nFur2Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8567F1F000E9;
	Sun, 26 Jul 2026 18:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785089915;
	bh=qnOb8plgpvZSaUyBKqfLqxUcBwY3vZcTa0Qh/IwhO/A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=U6nFur2Ym5UOalMtI8nk00cxcH2NzYdvNhTEVK1SDFmc0nmbvIYn/TQc39RSAccjG
	 b6cbC/EwsedwWAzHiYT8OgwmqvA1cY5RT2C+r8lW7eF5aHp9Ch0kmBp6hyuq6XD8k5
	 /Z4jxil155mv2nTgujv917vDqxE8emjtm183KXqTi8DhQxt3RzUMpKYwjCaXuzsi+6
	 pHXLXAgX9/hSyOpSJwDabxF1bz+awSZfOEJJPdWLUytezjOEod0/kB/lw5f26Vg/AW
	 gMhj+i9lJGghV03zbK/aU1j0YcFsHNcIdyhcwICqzrZkfOJ8jlPlZfvATYEve9A3jw
	 Rlr2v989c8C+g==
Date: Sun, 26 Jul 2026 19:18:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Siratul Islam" <siratul.islam@linux.dev>
Cc: "Lukas" <lukas.metz@gmx.net>, "David Lechner" <dlechner@baylibre.com>,
 "Nuno =?UTF-8?B?U8Oh?=" <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: dac: dac8163: Add driver for DAC8163
Message-ID: <20260726191833.67dcfac2@jic23-huawei>
In-Reply-To: <6b3f1b6188afbb8ebf9576274894b5ed292eca92@linux.dev>
References: <20260708-dac8163-work-v2-0-3acd1bf20182@gmx.net>
	<20260708-dac8163-work-v2-2-3acd1bf20182@gmx.net>
	<e84c4e047e104cca9b88dda791997ceecba1204c.camel@linux.dev>
	<amYVZtbxu4fjhBkx@berta-MS-7693>
	<6b3f1b6188afbb8ebf9576274894b5ed292eca92@linux.dev>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Jul 2026 17:01:51 +0000
"Siratul Islam" <siratul.islam@linux.dev> wrote:

> July 26, 2026 at 8:10 PM, "Lukas" <lukas.metz@gmx.net mailto:lukas.metz@gmx.net?to=%22Lukas%22%20%3Clukas.metz%40gmx.net%3E > wrote:
> 
> 
> > 
> > On Wed, Jul 08, 2026 at 09:58:13PM +0600, Siratul Islam wrote:
> >   
> > > 
> > > +
> > >  + const struct reg_default reg_defaults[] = {
> > >  + {
> > >  + .reg = CMD_SET(CMD_WRITE_UPDATE, 0),
> > >  + .def = info->default_output_reg,
> > >  + },
> > >  + {
> > >  + .reg = CMD_SET(CMD_WRITE_UPDATE, 1),
> > >  + .def = info->default_output_reg,
> > >  + },
> > >  + };
> > >  +
> > >  + const struct regmap_config regmap_config = {
> > >  + .reg_bits = 8,
> > >  + .val_bits = 16,
> > >  +
> > >  + .max_register = CMD_REF << 3,
> > >  + .cache_type = REGCACHE_MAPLE,
> > >  +
> > >  + .volatile_reg = dac8163_reg_false,
> > >  +
> > >  + .reg_defaults = reg_defaults,
> > >  + .num_reg_defaults = ARRAY_SIZE(reg_defaults),
> > >  + };
> > >  Why are these defined inside probe? Should be defined outside the function.
> > >   
> > The default values after reset are different for the compatible devices
> > (0 for the dacxxx2 devices and mid-scale for the dacxxx3 devices).
> > So these are runtime dependent. The alternative would be to have two
> > regmap_configs for the two device types and add these to the chip_info.
> > Or do you have another suggestion?  
> You don't need two regmap_configs. The way I would do it is, move the "regmap_config" out of probe and name it something 
> like "dac8563_regmap_config". And in chip info struct, replace "default_output_reg" with "reg_defaults[]". 
> Then for each "dacxxxx_chip_info" define the appropriate "reg_defaults" configuration.
> 
> This way you can do
> 
> struct regmap_config regmap_config = dac8563_regmap_config;
> ...
> regmap_config.reg_defaults = info->reg_defaults;
> regmap_config.num_reg_defaults = ARRAY_SIZE(info->reg_defaults);
> 
> A bit of work, but it would ensure most of the work is done at compile time,
> and we avoid reconstructing these sructs everytime probe runs.

As this has come up, I'd favour just having two static const regmap_config structures
and picking between them.  Obviously I haven't checked but I'd guess that any
overhead of extra text data for those is not that different to the extra code of the current
approach.  Generally if you can make this sort of thing data rather than code it
is a net gain.

Jonathan

> 
> > 
> > Best regards
> > 
> > Lukas
> >  
> --
> Best regards,
> Sirat

