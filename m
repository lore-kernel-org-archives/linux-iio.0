Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDAC26ED3E
	for <linux-iio@vger.kernel.org>; Thu, 13 Aug 2026 02:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786588688; cv=none; b=oewVEBs5rii5cznyUTnH5XEFuEKj4a5ocaY3b2fF1jfN9F6ilD7X/QwVyQGIdsQ3bm3q6dy5UJHW6xc6MixzmHP/w5wDa6rvfLCuVfxjtfQvVm6UdYj+oEwK4W3wujWYbMsHqk2VB/dqVZ3jw/URP4s9q1oAvblr4M66ppPGmDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786588688; c=relaxed/simple;
	bh=zs7pdiSpbSplYyqgCA5Lq8Pmo57kXuFbPXJQooB5OiY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pGqdRVmHW5OfatwdB5Y5QROiJoBgyLdsvueqgRxlP2sigqMEm4x8VI52rPnu2JfImHJivtx6MG1BrXD1vcj0SwwLTJBYD0VRgjn3kZmVvISdmzjMkZQ01i1QbG8VzNOOWd+dW9ZuIB7zlXN9Q6qtrjHe8PgDA6MIlq4mO9FzOYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7YVzOzd; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7YVzOzd"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cbb8b54fcf8so1524624a12.0
        for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 19:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786588686; x=1787193486; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k6ZNlQuUr6EHPk3SgGGoGxYcXJS5G15cJiEQQRspIzs=;
        b=T7YVzOzd3vx675luWTO8VWk0jaGvXC+f28NSl+H75XzQMU6ytuhJhWq11XqwrlSgMU
         uL/IWKy01czjK1CZcQIjuJ4WP4N7mjZpS5ntCePfjf4HYAP3RcrLfG2b81aXiw7r/HnM
         IeJzg/cQ/Vzj0yWeyFZyI5lifiCXRlSqahojZOzPeyHxGoFckLWXjuiCuURaZGWbKiat
         qecT+o51evzPA8NVfz3ujz45uyiq6PRF/3KWu2Uol4DNVIdaeG4NLTEzEXiaiJ2MSSkV
         ADH3qrQ/sd597TOt6HQayAW9+kJbdlvS50Mf/1UULJFUQ3Azo8DMu+vzA1OwI4/jm/KK
         rayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786588686; x=1787193486;
        h=in-reply-to:content-disposition:content-type:mime-version
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=k6ZNlQuUr6EHPk3SgGGoGxYcXJS5G15cJiEQQRspIzs=;
        b=PXIE6NIZ/Pla6Oo+1/GFBpGQ+6D/P1J6opDLCRTmSESzKtRINLWdcquLqGKuZI8O+s
         Fw2DznE8+lUEdKMvjY+g7eyJhcgAqOkKLKp8Bak4dX7BacIGpWveCKObK6XZOj97pPYf
         +g8ApVArfIxMBlKpM8a9Z4gpRmgFJwDaXQV9+FRGmxHLDykELp+2VS5DrZgAJmyV++OB
         ye5arU5zjZLuPRgAr+XvsMavuUkLgY1rp/7wamSDSw3azq9WlCtCpWwizh9SF7UvKUTz
         hmv3XYuQTAM5OMzAZjBbzin3IWWaT7L2Ss757guY8pveyDsVHYScMtBQZrB2DtB1lOuV
         RSQw==
X-Forwarded-Encrypted: i=1; AHgh+RoK7d9ZhLkuDm9Jxm4BD5++JWtNUFAc4bF2vMHZ+Aho5k1XcUueKob1KbT83RgZH+qxlbYLiKF5O64=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq3oiNJc+0Is/Cx4l669Rf3PRMun+pvmJVeS6t/crBASq1A49v
	NIwojJbKF0CKoorRKTRsTWUqD1Mp5QnKkU9ytQKREPHhd1PogkToDSeZ
X-Gm-Gg: AR+sD121hRofbDEAwSGYg76kzUgNmt4SzkpWDZa+YmZovVTy/pzg1LV3SDsF9QaZb70
	hHnUXeQEkXYTn4lU+WhRCEFotDAoJVWisty+vr931Qo+Goll73knqsGSt9idHCjDtzFCKBDpB5j
	21bolgDhema9fb0QNAUpeEr4FrIlNe75Yj46MyBixK7VX2QZAy5GDubvKNYAMPvbWlJ8Cy9ct/A
	cpj1XEtofZeVsVf8XI87zR+0z4hEa41c17duDnW7jkS9xfJ9HvDMCwH6j2Ddpy0w/8le1E3rpZt
	mfr3oyGE+zsgx2kXO8KOtBMKE58eso66MtTdRz9ZNdgmKrkAnJKRBiB49F8m9fsOgnev6p2A+AT
	yBuYFEFjEtbuQzcvijRG5dvwq1qRGDHhKGK+SrliRTPdFQedn8KckXMRlgXGZEG4Ma8pHRgVhYf
	1mW3NbJzF7ZasqoiNn/sikWB4hvcMGxQCcyefB2ZFsk1T0QrQxU7rCi2yS6sW9ZA==
X-Received: by 2002:a05:6a20:728c:b0:3c1:fbf:1e2e with SMTP id adf61e73a8af0-3cc550e3a2fmr3383789637.10.1786588686042;
        Wed, 12 Aug 2026 19:38:06 -0700 (PDT)
Received: from localhost ([115.70.157.242])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31ebcb69fbbsm1971018eec.11.2026.08.12.19.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 19:38:05 -0700 (PDT)
Date: Thu, 13 Aug 2026 12:37:57 +1000
From: Tsz Shan Chan <tsz.chan.dev@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Tsz Shan Chan <tchan@jacques.com.au>
Subject: Re: [PATCH 2/2] iio: light: vcnl4000: add shared IRQ support
Message-ID: <an0jTpda_06HUZcw@fedora-1>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anrwMci5d2VW56-X@ashevche-desk.local>
 <20260812044941.6f28cfb7@jic23-huawei>

On Wed, Aug 12, 2026 at 04:50:02AM +0100, Jonathan Cameron wrote:
> On Tue, 11 Aug 2026 12:49:37 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> 
> > On Tue, Aug 11, 2026 at 05:07:25PM +1000, Tsz Shan Chan wrote:
> > > Use the IRQ trigger type set by firmware instead, and fall back to
> > > IRQF_TRIGGER_FALLING if no trigger type is specified to maintain current
> > > behaviour.
> > > 
> > > Support IRQF_TRIGGER_FALLING and IRQF_TRIGGER_LOW, which match the open
> > > drain active low interrupt output. Reject unsupported trigger types.  
> > 
> > Can you elaborate with the reference to datasheet if the HW support this
> > type of IRQ? In such a case, how does HW know which type to trigger?

In the vcnl4010/vcnl4020 datasheet:
- Page 5 (Application circuit Notes): The interrupt pin is an open drain
  output.

In the vcnl4040/vcnl4200 datasheet:
- Page 7 (Fig. 11 - Hardware Pin Connection Diagram) shows INT pin
  connected to V_Pull_up with an 8.2k resistor
- Page 13 (Interruption Section): the level of INT pin (pin 6/8) is pulled
  low once an interrupt event has been triggered.

This confirms that the interrupt line is an open drain active low
output, so both IRQF_TRIGGER_LOW and IRQF_TRIGGER_FALLING (on a
dedicated unshared INT line) are both valid parent trigger type.
The sensor doesn't know about the parent trigger type and simply
pulls the INT line down when an event happens.

> > 
> > > Request the interrupt with IRQF_SHARED, and return IRQ_NONE in the irq
> > > handler when there is no interrupt pending.  
> > 
> > ...
> A couple of follow ups to add a few more things to what Any called out.
> 
> > 
> > >  	ret = i2c_smbus_read_word_data(data->client, data->chip_spec->int_reg);
> > > -	if (ret < 0)
> > > -		return IRQ_HANDLED;
> > > +	if (ret <= 0)  
> > 
> > I haven't seen mention of this change in the commit message. Is it related
> > somehow to the trigger type? How?
> 
> I'd definitely prefer to see the error case separately handled from the
> no known interrupts.  That no interrupt check should probably also
> only be the ones we have support for, so something like:
> 
> 	if (ret < 0)
> 		return IRQ_NONE;
> 
> 	if (!(ret & (VCNL4040_PS_IF_CLOSE | VCNL4040_PS_IF_AWAY |
> 		     VCNL4040_ALS_FALLING | VCNL4040_ALS_RISING)))
> 		return IRQ_NONE;
> 
> or something along those lines.
> 	
> 
> > 
> > > +		return IRQ_NONE;  
> > 
> > ...
> > 
> > >  	ret = i2c_smbus_read_byte_data(data->client, VCNL4010_ISR);
> > > -	if (ret < 0)
> > > -		goto end;
> > > +	if (ret <= 0)
> > > +		return IRQ_NONE;  
> > 
> > Ditto.
> 
> snap :)

The (ret <= 0) checks for two cases:
1. ret < 0: I2C read error. Cannot confirm this device caused the
   interrupt, so returning IRQ_NONE is safer for a shared line
2. ret = 0: No interrupt flag was set. This means no interrupt pending
   so this device didn't cause the interrupt, so return IRQ_NONE.

Combining both into (ret <= 0) was confusing. I will split these checks,
use bitmake and update the commit message in v2.


> > >  	isr = ret;  
> > 
> > ...
> > 
> > >  	if (client->irq && data->chip_spec->irq_thread) {
> > > +		u32 irq_type = irq_get_trigger_type(client->irq);
> > > +
> > > +		switch (irq_type) {
> > > +		case IRQF_TRIGGER_FALLING:  
> > 
> > Hmm... Do you have a case with edge sharing interrupts IRL? I think it's
> > a brain damage setup if it exists.
> 
> Would indeed be unusual to put it lightly!
> 
> > 
> > > +		case IRQF_TRIGGER_LOW:
> > > +			break;
> > > +		case IRQF_TRIGGER_NONE:
> > > +			irq_type = IRQF_TRIGGER_FALLING;  
> > 
> > Ditto.

I agree that edge triggers should not be shared. My goal was to support
level triggers for shared interrupt line without silently changing the
trigger type for other setups that do not share irq line.

In my understanding, IRQF_SHARED does not force sharing, only enables
the capabilities. IRQF_TRIGGER_FALLING was kept for existing setups
using dedicated irq line. IRQF_TRIGGER_LOW was added so shared lines can
work reliably without missing interrupts.

Or would it be better to completely drop the trigger type check? Simply
pass IRQF_SHARED | IRQF_ONESHOT and let the kernel use whatever trigger
type the firmware configures.


> > 
> > > +			break;
> > > +		default:
> > > +			return dev_err_probe(dev, -EINVAL,
> > > +					"unsupported irq trigger type %x\n",
> > > +					irq_type);  
> > 
> > Broken indentation.
> > 
> > > +		}
> > >  		ret = devm_request_threaded_irq(dev, client->irq, NULL,
> > >  						data->chip_spec->irq_thread,
> > > -						IRQF_TRIGGER_FALLING |
> > > -						IRQF_ONESHOT,  
> > 
> > > +						IRQF_ONESHOT | IRQF_SHARED |  
> > 
> > Also assign these above in a separate line, so this will be just irq_flags (and
> > name it irq_flags as IRQF_ stands for).
> > 
> > > +						irq_type,
> > >  						"vcnl4000_irq",
> > >  						indio_dev);  
> > 

Will fix them in v2.

