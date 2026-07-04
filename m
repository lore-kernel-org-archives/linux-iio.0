Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A25D33B97D
	for <linux-iio@vger.kernel.org>; Sat,  4 Jul 2026 16:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783182779; cv=none; b=DXZUXBha7zKpXK7Gsz6TILZ/PczFJRtU7lqmcabgoHn5DoFwArio3W8R/0oOhk+jYYEidMogEygpKl9I+2yuTEqffSP+GPJ+Mf93XmWYq0nWFvy0JpgBNzewpowJRJBp97sSK8UNrNKxZSh16lejrJjPOaKhJyEyFN18DGYVU7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783182779; c=relaxed/simple;
	bh=4tmr1O353vSNTqg3JPl1/o9SzWS9KghYr4cMOTijy90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6YplyLaFzjr3q6mDNqeCzarDHGECwriyqNH2e9sjmjSvvRbzrZ0ZpozfGsgkDeLdjCN7GBM7Z8fMv0XxYzOw66V5KvUeKWu3IPTVGjMgxkfO0/6Dl/BklzNW/E4P6wohOfqWySfLFAsskPx1sXM0lccNpx0B5TybcGnv77P5so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I4CFr7Ew; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I4CFr7Ew"
Date: Sat, 4 Jul 2026 22:32:32 +0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783182774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tXhR3huF5EFvclvlq2E1gNCb4oDZJeczjrBzv4+4Oa0=;
	b=I4CFr7Ew2dSTEL+GMRtSg0KZvvXQQpsjUf/GNX0N4rrOVnA7K6YDbeOfg8IhlBJGG6fjRu
	jtmav8I3McK7rM0APitD37vqCNKgrNCjrHmGJygbTxkWJ2GCwe5qGKiojGfr83pv6B0+v9
	urIs4hJ+yDN6D0K5q1iCZVS/ShJBAic=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Siratul Islam <siratul.islam@linux.dev>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Stefan Popa <stefan.popa@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ciprian Hegbeli <ciprian.hegbeli@analog.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] iio: adc: add MAX40080 current-sense amplifier
 driver
Message-ID: <akkwWxCf10rfThMk@fedora>
References: <20260703102941.1141341-1-stefan.popa@analog.com>
 <20260703102941.1141341-3-stefan.popa@analog.com>
 <9878f042f424bfbd7fab24175298224b58e87779.camel@linux.dev>
 <akj3Ay8mwemRj-9U@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <akj3Ay8mwemRj-9U@ashevche-desk.local>
X-Migadu-Flow: FLOW_OUT

On 26/07/04 03:05PM, Andy Shevchenko wrote:
> On Sat, Jul 04, 2026 at 01:42:39AM +0600, Siratul Islam wrote:
> > On Fri, 2026-07-03 at 13:29 +0300, Stefan Popa wrote:
> 
> ...
> 
> > > +#define MAX40080_REG_CFG		0x00
> > > +#define  MAX40080_MODE_MSK		GENMASK(2, 0)
> > > +#define  MAX40080_PEC_EN_MSK		BIT(5)
> > > +#define  MAX40080_RANGE_MSK		BIT(6)
> > > +#define  MAX40080_FILTER_MSK		GENMASK(14, 12)
> > Should be one space after #define, like the first one.
> 
> I saw this but left uncommented as sometimes people use this style to
> distinguish bit field definitions from the register offsets. When one space is
> in use it might be not so easy to put the borders. I.o.w. I have no
> strong opinion on this style, but if you think we should be all the same for
> all IIO drivers here, I'm fine.
I looked at existing drivers and most of them had one space so I thought
it would be better to keep them consistent. But apparently, as David
also noted, this style is acceptable. So no problem for me.
> 
> 
...
> > > +/* CFG.mode field */
> > > +#define MAX40080_STDBY_MODE		0x00
> > > +#define MAX40080_SINGLE_MODE		0x02	/* one conversion per Quick Command */
> 
> ...
> 
> > This can fit in 1 line.
> > static int max40080_update_bits(struct max40080_state *st, u8 reg, u16 mask, u16 val)
> 
> 
> Here...
Keeping this function single line results in 86 cols, which is just a
little more than 80. So I thought splitting here was avoidable. But if
you think it's an acceptable split then so be it.
> 
> ...
> 
> > > +	ret = i2c_smbus_read_i2c_block_data(st->client, MAX40080_REG_IV,
> > > +					    sizeof(buf), buf);
> > This also fits in 1 line but it would go 92 cols, so not sure which one is preferred.
> 
> ...and here the wrap is done on logical border, so I think it's fine and reads
> well.
This one might be pushing too far so I had my doubts.
> 
> ...
> 
> > > +static int max40080_get_range(struct max40080_state *st, unsigned int *range)
> > > +{
> > > +	int tmp;
> > > +
> > > +	tmp = i2c_smbus_read_word_data(st->client, MAX40080_REG_CFG);
> > I think tmp can be initialized, since it is only assigned once.
> 
> I don't get this comment. You mean switching to ret?
> 
I meant tmp is assigned only once so the indirection here, i.e.
declaring and assigning in two steps doesn't buy us anything. Instead,
it could be initialized like "int tmp = i2c_smbus_read_word_data()."
> > > +	if (tmp < 0)
> > > +		return tmp;
> > > +
> > > +	*range = FIELD_GET(MAX40080_RANGE_MSK, tmp);
> > > +
> > > +	return 0;
> > > +}
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
