Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F4335DA7F
	for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2026 08:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777021129; cv=none; b=qBuUTWoWZJSXL9lou3EJryS6itqzdly+IXZvo3clPn8voDBw25IUW31qCQs9pwl84ijc3fzvB5RJBLzIM87SEPfkcaqGXOKTbz20yyjI0JmGyZ+MiNU3TdPaBhgtONL7PP0l0Jd9FFBM+JE4rW10RXgnbTQz1lZH1p3JNkWk6IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777021129; c=relaxed/simple;
	bh=sZYJR4j7YT/ilJC6eLQiVd2XnfG0DbLHqN8CF7NpW3A=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNmGkYvHrpXiaXmk79LPcwoxw6u2MBWB1KyePOXZwFJrVv7m7d8nM5Dj3FG6nEBMLkWz/WCf3UvJSIv1WA+09bM6E4f6JTtzjcExMI0fDyHDmWLkWA8hMbzTmtG6pTZ2a4YUW9Rp3pb4NwAsc03iMYTAXiOJ/ERCiQ/kLh5PvYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yeea2HXe; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yeea2HXe"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43d70c30767so4929198f8f.0
        for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2026 01:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777021126; x=1777625926; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mHTpcysjvEEWS5SCY/OAqYlcWcxfCpMildoVnj/KeDo=;
        b=Yeea2HXegP/UjlYEAIZvXEpnx3WoMOoc6jJsGgClCRQD5HhoxQJnt84oCUONeQ0wj6
         e5g9EJTN7xfcjRZpaYToZbDyegjUVHs5yg04v2olEP1/Fs6Ztw2VkO5UfsBbwoiHNWHC
         AhPLxYLLN8AUudr1M9GTUU/h63fVABWhakuaHgEXeFK5pTzyUPbETcgiK1I1HKgEpTdR
         J+iNuiF8XTBrU5DXS2JfiIKaBRYJYa3SiJfqr0MvDqsmFKvSgaXWdB8CkA1M5F3L+NpW
         YehDWWMgJ1euPcU3pQVhWariDEi5fcYpxtGo+CSfQ/Uo5bA5rMIYaOX21Y2nT7IPtBFE
         3zKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777021126; x=1777625926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mHTpcysjvEEWS5SCY/OAqYlcWcxfCpMildoVnj/KeDo=;
        b=adiiR37L8hl4zSgpR/ILQrZTxmfub5YQaP2VkAkZpFEv/UEo5Y6fXyGDihCsuplOgp
         S7gbifg81N9naya5qK9JrYgBkcIfDoLeFwA1Vt4e7502xJjTPuzPWftpB+GR+RRD8CSl
         Z0kxeocbonHXTpgzRHN33WNWySp0f2S1Fcvi0AoXfZdawrLewee1xz1GNeFnASG0INXa
         qaWiwFmNVQ19cFeIxLcJBrlNjQ95B/ECdnX50e8zrLKaafdfe0JduKUjZdHeyHNYFUFK
         r+vRaDOzv6/DKNXuxMO+FOMbJClxlKJW+ljKPo1Kqiysqnr5kzXgi4WnrfyFWy1N7uld
         GSHQ==
X-Forwarded-Encrypted: i=1; AFNElJ/X8oepPA7mYHpKg3r7BAVR/KKP9fc43Rc83adujxuFEmrU8Y835N2tAT6wXuYHh8LQiFKTuJW4U2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgAzLt0e2EbCEbBVlaRLBW7jz0NVQ0+opx1b0TKEXlmWUg7vO2
	fVa3SqNGG9o4GIgGkq90o6qzqaV2K4EGHfPC+Vg7op/h7wEfkHul0XeS
X-Gm-Gg: AeBDieuwX9sqobS14XsVJqbOho03757fSTEUrpdfNmnTwI6JMR3y8Um5NFV0emi1y2p
	nvlje6xZt7lNL7wJKOFbz4mbgfht9p51mK/X/EKt/N5+jtlfHJICgoRcwxrdS7ayLhXXbRQeIFE
	KsQTk/O8vSWn5ibnJut9xS7ljx1A7HI50rPLymTDljdCvoPHgRuKRU+Kl66Qy0BHLLoSt5MD3WQ
	SJ1GHQ36EP71a16Rbd4s/wTzVIz771eMTRbhABqvaUSbRJJFWAFfeRZJHaCTw1z1iQJr0v9q6XO
	Xxj0xhbpW56UzRugcsHHlHH4dKEPj+gMUPLlPxqZJn2fK4HqcNiRlma1moWlAK9/EjfYs4Ns5sO
	pkOijsheyK5gnhI3qQwwxDOJdWNH5xHDqNj0KFu6g5RYxGxpUkEpjTGnLdw238fxq9Exii/3sJU
	cpW6uIJmzMjuOxkeL5RIYn/rDXuLs6pBUpzGsl1hdqoQOBKFkots3OvNC+i8wiyN22ipLWxaGBa
	JRhcMwsm9IKMUCaRq99nPsvMRFTrdP+9msIP8Dc42WERc+WLR2LgFsBJkrYUw==
X-Received: by 2002:a05:600c:b96:b0:48a:5339:a46 with SMTP id 5b1f17b1804b1-48a53390f6cmr232014255e9.9.1777021126073;
        Fri, 24 Apr 2026 01:58:46 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc1c773fsm655407835e9.12.2026.04.24.01.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 01:58:45 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Fri, 24 Apr 2026 09:58:39 +0100
To: Jonathan Cameron <jic23@kernel.org>, 
	Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Auchter <michael.auchter@ni.com>, linux-hardening@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 20/22] iio: dac: ad5686: implement new sync() op for the
 spi bus
Message-ID: <umhebqm7nwcg6h5y77egrh7nirtpjpin5t42oxifo5em4jmsyj@gavxnwsadyuh>
References: <20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com>
 <20260422-ad5313r-iio-support-v1-20-ed7dca001d1b@analog.com>
 <20260423191833.0de9fb8c@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423191833.0de9fb8c@jic23-huawei>

On 26/04/23 07:18PM, Jonathan Cameron wrote:
> On Wed, 22 Apr 2026 15:45:54 +0100
> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> 
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > 
> > Use of local SPI bus data to manage a collection of SPI transfers and
> > flush them to the SPI platform driver with the sync() operation. This
> > allows for faster handling of multiple channel DAC writes, avoiding kernel
> > overhead per spi_sync() call, which will be helpful when enabling
> > triggered buffer support.
> > 
> > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> Interesting approach to potentially optimise for SPI.  Do you have
> perf numbers or similar to support it being worth the effort?

Short answer is no, I can try to produce some benchmarks, but I am not sure it
is needed. The implementation here prepares the ground for triggered buffer support,
which adds the capability of implementing a control loop in userspace that updates
all the enabled channels at once. That will happen in a trigger handler, then we want
that to be as fast as possible, so it can be prepared for the next trigger event.
It is not really about calling a function once rather than multiple times, but the
problem happens when the device is sharing the spi bus with other devices and how busy the
system is in general, so there may be context switches in the spi platform driver with
one or two mutex acquire/release operations, which may add bigger delays between
transfers, which depends on what the other devices are doing. I suppose that devices with
high channel count like 8 or 16 can benefit with this.

> Otherwise a few minor comments inline.

...

> > @@ -84,8 +107,18 @@ static int ad5686_spi_read(struct ad5686_state *st, u8 addr)
> >  				      AD5686_ADDR(addr));
> >  	st->data[1].d32 = cpu_to_be32(AD5686_CMD(AD5686_CMD_NOOP));
> >  
> > -	ret = spi_sync_transfer(spi, t, ARRAY_SIZE(t));
> > -	if (ret < 0)
> > +	xfer[0].tx_buf = &st->data[0].d8[1];
> > +	xfer[0].len = 3;
> > +	xfer[0].cs_change = 1;
> > +	xfer[1].tx_buf = &st->data[1].d8[1];
> > +	xfer[1].rx_buf = &st->data[2].d8[1];
> > +	xfer[1].len = 3;
> > +	xfer[1].cs_change = 0;
> > +
> > +	spi_message_init_with_transfers(&bus_data->msg, xfer, 2);
> 
> Why not carry on using spi_sync_transfer() here?
> We'll end up with an spi message the stack but I suspect that's
> not a significant performance cost.

True, it would be around 200 extra bytes in the stack, and read operations
would not happen concurrently with writes, so why not reuse resources
(message and transfer structs) that is now available in the bus data?
To me, it allows for consistency in this implementation. 

> > +
> > +	ret = spi_sync(spi, &bus_data->msg);
> > +	if (ret)
> >  		return ret;
> >  
> >  	return be32_to_cpu(st->data[2].d32);

-- 
Kind regards,

Rodrigo Alencar
