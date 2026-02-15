Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B261A23A6;
	Sun, 15 Feb 2026 18:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771178750; cv=none; b=CmvmJg+i4jjcSbcwSS2DPMQgtz99vBZsIf2jtaeVXybJZe1Mf1QcnW3yqeZc4USuvV2aHfGlor1onyjRzKADPTfFOlw8+HDlqq1dMb1AD2gpCArDRYqhcbE9+spNlyOZHSVB0xO37ARZZ1n9jOJF7bto5Ec7twQG3Cdum4bBZb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771178750; c=relaxed/simple;
	bh=UwPvZM1OGMLhF1Kf4INnyrOV0mKU7bmSOvcwkciV/Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oln846WsPqmJtTgZQ2dGo1r6KztKRy6YI2e7z4z//iYh6kloj9zKVQbk/AiYjLiqsxYmR2ucBwLT/V70OgcmVdYm3Z3wNHbVOc63NvKZWCFPjKfrehmG0tIeDwdbQbtcgnuzTTb4KJcozMC3CbO4GQUdJM54vZKnNTBP/jyNL+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L408W5YE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L408W5YE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A01C4CEF7;
	Sun, 15 Feb 2026 18:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771178749;
	bh=UwPvZM1OGMLhF1Kf4INnyrOV0mKU7bmSOvcwkciV/Bk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L408W5YEVUh1LvNw0OxkWiePCpSGp2bHvUgd+25dYofw4c2Upti5B6PswYQKX7xuS
	 hE3Y7IZtvomzXWDGG7hLysCods2kBnTdikikjOWELIOI7lxUxhfEPY0V+9wQUWkw+B
	 SufxfZAxelHKOwi7iYkkyJ48NmEezGyhsumZc5zD8of0GVSk1JHtJLu9AgKVFfJZ4y
	 iTftUxyk61Bd+BHk07vtNaP67SUsgBocunUMb5UAG5q2xdHfEbrUUJz0/93RK5OSz5
	 dJtEiGUBfpcb9tHpVh9P8TaOn9Xojk+rBi6xcsH3WFyKG7cn5jkTi4oZVuz7xnJbfU
	 XHbbcA24ahM3Q==
Date: Sun, 15 Feb 2026 18:05:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Taha Ed-Dafili <0rayn.dev@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mentees@lists.linuxfoundation.org,
 me@brighamcampbell.com, skhan@linuxfoundation.org
Subject: Re: [PATCH v1 2/2] iio: dac: ad5504: use adi,output-range-volts for
 scale calculation
Message-ID: <20260215180538.36f536aa@jic23-huawei>
In-Reply-To: <aY40-0v9tbXC4tPY@smile.fi.intel.com>
References: <20260212181955.42724-1-0rayn.dev@gmail.com>
	<20260212181955.42724-3-0rayn.dev@gmail.com>
	<aY40-0v9tbXC4tPY@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Feb 2026 22:15:55 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Feb 12, 2026 at 07:19:55PM +0100, Taha Ed-Dafili wrote:
> > The driver previously used VCC to calculate the scale, but the datasheet
> > states the output range is fixed by the R_SEL pin (0-30V or 0-60V).
> > 
> > Update probe to read `adi,output-range-volts` for the scale. Default
> > to the 60V range if the property is missing, while keeping the VCC
> > regulator enable for power.  
> 
> ...
> 
> >  #include <linux/regulator/consumer.h>
> >  #include <linux/module.h>
> >  #include <linux/bitops.h>
> > +#include <linux/property.h>  
> 
> Add it before 'linux/s*.h' includes to make less ordering issues.
> Ideally one additional patch to sort the headers and one to replace
> "proxy" headers (following IWYU principle).
> 
> ...
> 
> > +	ret = device_property_read_u32(&spi->dev, "adi,output-range-volts", &val);  
> 
> You can pack this into 80 limit with help of
> 
> 	struct device *dev = &spi->dev;
> 
> being defined in the top of the function.
> 
> > +	if (ret)
> > +		val = 60;  
> 
> Also this seems an optional, so
> 
> 	val = 60;
> 	device_property_read_u32(dev, "adi,output-range-volts", &val);
> 
> would be enough.
> 
> ...
> 
> > +	if (val == 60)
> > +		st->vref_mv = 60000;  
> 
> 60 * MILLI;

val * MILLI
given it only takes the values 30 and 60 I think. If you want to protect
against other values, then check it explicitly rather than everything than
isn't 60 being assumed to be 30.

Thanks,

J


> 
> > +	else
> > +		st->vref_mv = 30000;  
> 
> 30 * MILLI;
> 
> Needs units.h.
> 

