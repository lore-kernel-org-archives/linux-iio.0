Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2F5347BBD;
	Wed, 12 Aug 2026 03:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786506611; cv=none; b=jXsmY13D1RYl3B9U/lNYn4tJlfsib1oOymI3Twffkftgzz1i6vhusHhvsmxGLuZDgvcMt1bOPAv0qdk+pKo50uZSKQJ4HnCBjSopUUb3paziCI9H2lPdGuki/sCHJrjPYnj4AAtphabbQ3IIYDV2dZcoej2joRWJEXlehaH4A5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786506611; c=relaxed/simple;
	bh=VNEqSHVyHdJrX4ruPAg7amIoBxLm24V32Zs24U8eBk4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nb/YkkjLo61Iy02hePRsb7cdFQFjOO5ZPO9jiUTQlnW9wKtLy8Cr0JH+W6LfHTyu7nvZxTZ/Qf9H8BxSkdjvZdx7yAJ6oQ1hcNNNZiaRYmI8fe/x31KfuwYKCuK4NMP3IzBIZM3vlk4njUSgH5hQadQHNGZJbiWkVchX8VOWMwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWmZNSLk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWmZNSLk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B761F000E9;
	Wed, 12 Aug 2026 03:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786506609;
	bh=4Tc67FqDG8Gt0cExiqTRy+gAYS4+tfc01V1afvYeQLU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZWmZNSLkcqfGci9xY67BsY+8xEfNfXVcGNBNtXlczOQQzQ6FHCIC3Ebc71KKqyEqZ
	 IJ5eMGldoJSNSvgywtaoIZqOyQ6SORFe33EPQUKMtb45rV5PBc72wcZufFTGV/5AZA
	 2zSxEAPSrzh3nbrhWieJIi7KG6U25FTcNMI0LVjcJw/VBvrT0Z+hTjoexy+ps9E+Hb
	 Xllt28I4cBxkZE7Dnzoq2l4KWVyA7NnbHLut7/oYoZWJn4wexDx4biae6rONMTakzp
	 FBF0pak+v9bhMd8ct4SmzJmbMI1aX5wWwR2Rw7XU/6JUYnbroUHlBYqOoVUtnUh58+
	 iL1WJJEvmvVWQ==
Date: Wed, 12 Aug 2026 04:50:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Tsz Shan Chan <tsz.chan.dev@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tsz Shan Chan <tchan@jacques.com.au>
Subject: Re: [PATCH 2/2] iio: light: vcnl4000: add shared IRQ support
Message-ID: <20260812044941.6f28cfb7@jic23-huawei>
In-Reply-To: <anrwMci5d2VW56-X@ashevche-desk.local>
References: <20260811-vcnl4000-v1-0-50e7fb657692@jacques.com.au>
	<20260811-vcnl4000-v1-2-50e7fb657692@jacques.com.au>
	<anrwMci5d2VW56-X@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Aug 2026 12:49:37 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Aug 11, 2026 at 05:07:25PM +1000, Tsz Shan Chan wrote:
> > Use the IRQ trigger type set by firmware instead, and fall back to
> > IRQF_TRIGGER_FALLING if no trigger type is specified to maintain current
> > behaviour.
> > 
> > Support IRQF_TRIGGER_FALLING and IRQF_TRIGGER_LOW, which match the open
> > drain active low interrupt output. Reject unsupported trigger types.  
> 
> Can you elaborate with the reference to datasheet if the HW support this
> type of IRQ? In such a case, how does HW know which type to trigger?
> 
> > Request the interrupt with IRQF_SHARED, and return IRQ_NONE in the irq
> > handler when there is no interrupt pending.  
> 
> ...
A couple of follow ups to add a few more things to what Any called out.

> 
> >  	ret = i2c_smbus_read_word_data(data->client, data->chip_spec->int_reg);
> > -	if (ret < 0)
> > -		return IRQ_HANDLED;
> > +	if (ret <= 0)  
> 
> I haven't seen mention of this change in the commit message. Is it related
> somehow to the trigger type? How?

I'd definitely prefer to see the error case separately handled from the
no known interrupts.  That no interrupt check should probably also
only be the ones we have support for, so something like:

	if (ret < 0)
		return IRQ_NONE;

	if (!(ret & (VCNL4040_PS_IF_CLOSE | VCNL4040_PS_IF_AWAY |
		     VCNL4040_ALS_FALLING | VCNL4040_ALS_RISING)))
		return IRQ_NONE;

or something along those lines.
	

> 
> > +		return IRQ_NONE;  
> 
> ...
> 
> >  	ret = i2c_smbus_read_byte_data(data->client, VCNL4010_ISR);
> > -	if (ret < 0)
> > -		goto end;
> > +	if (ret <= 0)
> > +		return IRQ_NONE;  
> 
> Ditto.

snap :)

> 
> >  	isr = ret;  
> 
> ...
> 
> >  	if (client->irq && data->chip_spec->irq_thread) {
> > +		u32 irq_type = irq_get_trigger_type(client->irq);
> > +
> > +		switch (irq_type) {
> > +		case IRQF_TRIGGER_FALLING:  
> 
> Hmm... Do you have a case with edge sharing interrupts IRL? I think it's
> a brain damage setup if it exists.

Would indeed be unusual to put it lightly!

> 
> > +		case IRQF_TRIGGER_LOW:
> > +			break;
> > +		case IRQF_TRIGGER_NONE:
> > +			irq_type = IRQF_TRIGGER_FALLING;  
> 
> Ditto.
> 
> > +			break;
> > +		default:
> > +			return dev_err_probe(dev, -EINVAL,
> > +					"unsupported irq trigger type %x\n",
> > +					irq_type);  
> 
> Broken indentation.
> 
> > +		}
> >  		ret = devm_request_threaded_irq(dev, client->irq, NULL,
> >  						data->chip_spec->irq_thread,
> > -						IRQF_TRIGGER_FALLING |
> > -						IRQF_ONESHOT,  
> 
> > +						IRQF_ONESHOT | IRQF_SHARED |  
> 
> Also assign these above in a separate line, so this will be just irq_flags (and
> name it irq_flags as IRQF_ stands for).
> 
> > +						irq_type,
> >  						"vcnl4000_irq",
> >  						indio_dev);  
> 

