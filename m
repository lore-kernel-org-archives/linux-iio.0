Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941D32F5A0E;
	Sun, 23 Aug 2026 18:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787510611; cv=none; b=UrT7myF8PjMWWtmIYBzy4/ht4nJS6YoZ9NAw7oglUSXRf3WXZvRvOYQSULTRXxjPAWSXqeYVag90Y673vxIJdzQLqNp9hhU++ShxVOaa2vENvGdZQxjtKbkxQA5x5RrXp72qBaoD1V8Gvj9wi2mnsiRiphX74MSgcJGGuFs+4Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787510611; c=relaxed/simple;
	bh=F/0IxxTubYrnRSlv4gfPerrQlzABasMCwPTfocAF4Vg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QQUYXrELUdq5NfdMl9gbwD4bQ+8yLI39/Z8LTuW3dQS/oCok5vFupT18DHVwpTS9nvUkX9aU8bkVmgIaYLRVN6tPiYveYBnG/Oe89P2Uh41oOVA2hEzl15iJ2oqOrZttbzqJpByP+K1Vj8okXeKWqpKOkQKOFYoEtQBEs91dDs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvuX9MLP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvuX9MLP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C98E1F000E9;
	Sun, 23 Aug 2026 18:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787510610;
	bh=YqI22uGvdfnR/Qu5d8p67OCqfiR7qjGSt3BD5ak2LUc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YvuX9MLPBkuFoReuwOJVGjgqyaQNz5njfJ+QjCbsdSRyLKg5niFN3Oix4XRRMwMud
	 kvjrCSah0+1XnoQW4Cy6yPnPa8tTYbZDVLnp271YTYv+h3khAzI1fdPZ8jofB0MiU2
	 bgwmal0Tlm7usweyOy6njK4lFJ0EMlOUPRAKC8jXuQ59siWXsUBGwk/OTiMU22EuoE
	 RZRrX/yjCJAPUNdKv1/SSr5LA7UgWS0o7+EV/WgAfV5kkppR69FS5dwR+ZjnXFjuRx
	 1Yy7XTKoUnSu6I+80WMJLtLizWt3f+LdCKMlzgqMut7gDZ74dpAAVlgHzItHITjzKt
	 K6ti2mm9CkCLQ==
Date: Sun, 23 Aug 2026 19:43:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org, linux@analog.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] iio: accel: adxl367: add support for INT2
 interrupt pin
Message-ID: <20260823194324.3f805ed6@jic23-huawei>
In-Reply-To: <8283770e-4c42-4d7c-adf7-7597288c9712@baylibre.com>
References: <20260821180753.4633-1-antoniu.miclaus@analog.com>
	<20260821180753.4633-5-antoniu.miclaus@analog.com>
	<8283770e-4c42-4d7c-adf7-7597288c9712@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit



...

> > +static int adxl367_set_int_map_reg(struct adxl367_state *st, int irq)
> > +{
> > +	int ret;
> > +
> > +	ret = fwnode_irq_get_byname(dev_fwnode(st->dev), "INT1");
> > +	if (ret == -EPROBE_DEFER)
> > +		return ret;

There is only one return value that means the value wasn't there, -ENODATA

For other values we'd ideally return the error.  Bit ugly but something like

	if (ret < 0) {
		if (ret != -ENODATA)
			return ret;
	} else {
		st->int_map_reg = ADXL367_REG_INT1_MAP;
		return ret;
	}



> > +	if (ret > 0) {
> > +		st->int_map_reg = ADXL367_REG_INT1_MAP;
> > +		return ret;
> > +	}
> > +
> > +	ret = fwnode_irq_get_byname(dev_fwnode(st->dev), "INT2");
> > +	if (ret == -EPROBE_DEFER)
> > +		return ret;
> > +	if (ret > 0) {
> > +		st->int_map_reg = ADXL367_REG_INT2_MAP;
> > +		return ret;
> > +	}
> > +
> > +	/* No interrupt-names: default to INT1 for backwards compatibility. */
> > +	st->int_map_reg = ADXL367_REG_INT1_MAP;
> > +	return irq;  
> 
> I guess this works, but it seems like trial and error rather than being
> purposeful. 
> 
> Could probably do something like this too:
> 
> 	if (device_property_present("interrupt-names")) {
> 		ret = device_property_match_string(st->dev, "interrupt-names",
> 						   "INT2");
> 		if (ret < 0)
> 			return ret;
If we get -ENODATA this exits - but that just means we didn't find the property
(the docs aren't great for these functions - could do with improving if anyone
has time!)

> 
> 		/* If INT2 is at index 0, use it, otherwise use INT1. */

As you suggest below, an explicit INT1 match would be better.  Also why do we care about
the index being 0. We just need to provide irq to map_reg for an irq.

> 		st->int_map_reg = ret ? ADXL367_REG_INT2_MAP : ADXL367_REG_INT1_MAP;
> 	} else {
> 		/* No interrupt-names: default to INT1 for backwards compatibility. */
> 		st->int_map_reg = ADXL367_REG_INT1_MAP;
> 	}
> 
> 
> 	ret = fwnode_irq_get_byname(dev_fwnode(st->dev),
> 				    st->int_map_reg == ADXL367_REG_INT1_MAP ?
> 				    "INT1" : "INT2");
> 
> 
> (Could use device_property_match_property_string() instead if we want to
> return error on invalid values instead of assuming INT1.)

Whilst I see your point about trying and failing being a bit ugly that is
how we normally handle optional irqs and I think the code flow ends up
simpler than trying to be more clever. 

I wouldn't mind a helper that lets us find any random irq from a set of
provided names providing us the index and the irq number				
	const char *irq_names[] = { "INT1", "INT2 };
	int index = 0;
	
	ret = fwnode_irq_get_byname_from_array(dev_fwnode(st->dev),
					       irq_names, ARRAY_SIZE(irq_names),
					       &index);
	if (ret < 0) {
		if (ret == -ENODATA) {
			/* Default to INT1 for backwards compat */
			st->int_map_reg = ADXL367_REG_INT1_MAP;
			return irq;
		}
		return ret;
	}

	st->int_map_reg = index ? ADXL367_REG_INT2_MAP : ADXL367_REG_INT1_MAP;

	return ret;				


I haven't checked but such a helper should I think be pretty useful across
a range of IIO drivers and probably beyond.

Obviously that pushes the style of code choice into the helper though so
the above discussion on what is the better choice continues..

Jonathan.
> 
> > +}
> > +
> >  int adxl367_probe(struct device *dev, const struct adxl367_ops *ops,
> >  		  void *context, struct regmap *regmap, int irq)
> >  {
> > @@ -1479,6 +1508,11 @@ int adxl367_probe(struct device *dev, const struct adxl367_ops *ops,
> >  	if (ret)
> >  		return ret;
> >  
> > +	ret = adxl367_set_int_map_reg(st, irq);
> > +	if (ret < 0)
> > +		return dev_err_probe(st->dev, ret, "Failed to get interrupt\n");
> > +	irq = ret;
> > +
> >  	ret = devm_request_threaded_irq(st->dev, irq, NULL,
> >  					adxl367_irq_handler, IRQF_ONESHOT,
> >  					indio_dev->name, indio_dev);  
> 

