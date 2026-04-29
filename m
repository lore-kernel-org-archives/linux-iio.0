Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4C432ED5C
	for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 14:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472493; cv=none; b=i7u2D2Tw5u8SWy1XZyFkC7xy0/kxPe10KlCPJdamX6rAI7NTdU6AtTa3oU7Sc6AJFQSmZ88zGeImaiaFLRMe74apvzL7YyqkAlg+89jsffZgz21pTg0AKmlWqGfOThRPixItMEJTWJ/MoJkfe+9JP9Mr8w6Y6MT95HwAUg31s78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472493; c=relaxed/simple;
	bh=wLATJYgThruTRJiMYN51uqyG4dHxqv2XfrVvvEFN4C4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jRb0rFfuAIBjSGYGYtzEgyGUse9Pt/4twBuu66CFgzo9YG3X5rwLo7W0xZTiE8BRUCRFzLgMm0/dz0/sF04Fyrc4ReX2MU+3sXthvGq/+g9gF1fAKQfPnm/EmP923W8pDdTqa31mQBDW/O5B2g7xyAMPmZ4FOVXqugwiBrt18CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCPJiSfQ; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCPJiSfQ"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-bb91b426e40so211217966b.0
        for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 07:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777472490; x=1778077290; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bvvwjpzGQh9OgZH/i2WXVM3wFERyUNrjBMs9i6LlItM=;
        b=TCPJiSfQ/JMygZ0CJgWseWZGnyB2KlZt/VkYicC9FNZ4ue6Sk+zATStkWZtV8rmM75
         HUjqPdypzfgltqK6PXAS5S7vwGH7Fnynck8Eack7lC31ceDbL6THSUh85jsXrMuuEjfz
         9Ctf6sgl2/ZVx5AaJH2biKc7azlZr1D8s7xW/xyN770S9k8Qh+dhTWM6PahwgaDb1jWP
         xmUqOP/mselaNl7lnpapSGN9G7sFtuswGpfx2ksD92T94l2mDmvEcRXX3irWHHJpRxE5
         t6XCTN9mUpMduiK8DirB8OXrUdK7/1cVfI/Ozu2WXnAUdBXC1G0QisEfCextmA67YjmU
         Rgzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777472490; x=1778077290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bvvwjpzGQh9OgZH/i2WXVM3wFERyUNrjBMs9i6LlItM=;
        b=eCoA2lyExhGVMjmfxkBsEZFeTrL6yMgC5Ir2yAYkZn4H9sVYeyU29m4qim76Gsy4ii
         QtP7/n9Xd6McP7lWjgtPgu+v1S8x7F9w5Z8V52i7i/mFChmyZ3UtHFJ0ps9RDrsTs2xB
         l4ZT3q3YxRR2Xo3/hvjrWScxTRaFQDjjbv4nAv7daq+cZ2xs4mJobrBCA7mZmRaDumZ9
         fdofa1P2/BGW2JmsqzzK6lbR1EMlH89BIdlM5e9eXe+MF6P7jCXBk7ZMiwEWuxbWyHdY
         dPDpk/rbE/ENwqUV1xR2sFFbQ2zPlWyea40pXKE9+k13jRKVG+u8NwqRXwWRNU33+LOW
         2jbQ==
X-Gm-Message-State: AOJu0YzU+vIKzL3bybSGcso7C7iIEoAwO54xgneg++WnQCB9f9lMk+m/
	ET2eIeGot63QuOneYz8TWlM32vaeXIblt2qK+1KUoilpj4oajtTWMF6x
X-Gm-Gg: AeBDievOEjb+nO6cM6XC0SjXaksXaOlds63j4+0S6i1rrIzc3L1AZ27UVxczjkzvMHU
	BCz8QGcxT0XdcS7RB7VkjOHpuvip6rGYqTsna5MqKOJ6JzcBwRS153XVfdEQOe0gBxfA+MT9sCY
	nzL8vGjBKdKCiyeJlSWwsKKj9ePubLvzaM7h9ilKhE0B09eJRDE4TL5+ZfQUZJdbDWLYbFAXkHK
	r3yWDPvTmsnj4GfjxI1kJcpkgAW8zWmHKC/htwXx3O9rRyiT1661C9mYctfEd45mbA586jMFL/7
	krpFkyGCiIc2uQzqTgawgrJh7rdVbyd7qaBqL0cIUYBxQVDA3cGQv9lUmDcw1nz5Yt/ZXEfH7mC
	Pb56+2uJQUXoj/3mE4Y6ubNW5n9Bk6nxRe6n2fD5wSZqGRSNr2lIZ1MXixFCvaB8v721uSjxzdk
	ndI+pkx6PG9c149DlOp+Kp3tj6SxCFMxcOfvKeGW0c2TrofLVmL+p+9GSieQW04xRYG0o491Ea8
	G0qmoMi1NnAGYJ94zIqBO3oLibytUdu5YgysUXXmgCPriNJrygbQZ/nj1E/
X-Received: by 2002:a17:907:a704:b0:ba4:afcc:4a9 with SMTP id a640c23a62f3a-bb93f03cfd8mr241316666b.45.1777472489416;
        Wed, 29 Apr 2026 07:21:29 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb985439698sm102974766b.32.2026.04.29.07.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 07:21:28 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Wed, 29 Apr 2026 15:21:26 +0100
To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	rodrigo.alencar@analog.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Popa <stefan.popa@analog.com>, Jonathan Cameron <jic23@cam.ac.uk>, 
	Greg Kroah-Hartman <gregkh@suse.de>, Michael Auchter <michael.auchter@ni.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v4 04/13] iio: dac: ad5686: fix powerdown control on
 dual-channel devices
Message-ID: <ns74pq67pkrbaouj2vw6366pmukqmgdkyo5axe27ghgjekwjpt@dkbmhzurwkgr>
References: <20260429-ad5686-fixes-v4-0-bb8f1cbd68e1@analog.com>
 <20260429-ad5686-fixes-v4-4-bb8f1cbd68e1@analog.com>
 <afIPmf90zHsPkhX5@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afIPmf90zHsPkhX5@ashevche-desk.local>

On 26/04/29 05:03PM, Andy Shevchenko wrote:
> On Wed, Apr 29, 2026 at 02:07:34PM +0100, Rodrigo Alencar via B4 Relay wrote:
> 
> > Fix powerdown control by using a proper bit shift for the powerdown mask
> > values. During initialization, powerdown bits are initialized so that
> > unused bits are set to 1 and the correct bit shift is used. Dual-channel
> > devices use one-hot encoding in the address and that reflects on the
> > position of the powerdown bits, which are not channel-index based
> > for that case. Quad-channel devices also use one-hot encoding for the
> > channel address but the result of log2(address) coincides with the channel
> > index value. The issue was introduced when first adding support for
> > dual-channel devices, which overlooked powerdown control differences.
> 
> ...
> 
> > +	/* Initialize masks to all ones provided the max shift (last channel) */
> > +	shift = ad5686_pd_mask_shift(&st->chip_info->channels[st->chip_info->num_channels - 1]);
> > +	st->pwr_down_mask = GENMASK(shift + 1, 0);
> > +	st->pwr_down_mode = GENMASK(shift + 1, 0);
> 
> Why do we care about upper bits being cleared? Can we simply use here

With this weird dual-channel use case, the shift of the second channel is
6 and unused bits in-between needs to be one (probably because the dual
channel hardware is the same as the quad-channel (but using the first and
the last channel) and it will consume more power if those are zero). Then
for this case we need the masks initialized to 0b00111100 in the end, so
we can have those "ghost" channels disabled.

> 	st->pwr_down_mask = GENMASK($MAX_CHAN * 2 + 1, 0);
> 	// or even ~0, U32_MAX, et cetera
> 	st->pwr_down_mask = ~0;
> 
> 	st->pwr_down_mode = ...same...

setting it all to ones, breaks the single-channel case, because of the
weird logic in ad5686_write_dac_powerdown(), I get to tidy this up only
when introducing the control_sync() function.

-- 
Kind regards,

Rodrigo Alencar
