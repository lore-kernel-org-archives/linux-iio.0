Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8246534D4E6
	for <linux-iio@vger.kernel.org>; Wed, 28 Jan 2026 09:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769594128; cv=none; b=sV4EPdOAkOELxTfNsWBFzbIoSDZoGHtxRXScuIrBJGGNxojmWvrnxDqrp9JhnqVR3zu9qT9bIGVB2tL0isjrVkT7LbffxEH2BwnrARyA1WWPSfJdduJRVNXsiHth7OYYYpKLV96yoxbGeRuaVNBiCz3iLcX+jGGQUiPG+BdH1Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769594128; c=relaxed/simple;
	bh=N38H9ofcuvHeRPFG3cxDjpN7XrxCmZhZt/Nxt5wFxoc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJ/jRWHncq/Hpfh9mLxnDx/YBLvUrFglaq9r3uuscAMzkFAZByCSzIA/DROethpOBnKi9PibCMC2/YDG5LuZIh+blq6OLNFPDdx5b2zhM7sRb1P/FZNCFO44+gVyvLWjERORNpb7D1d6kBFnn+IhB6M11Llx1kS/LYj6/2IIrTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+40Dj57; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+40Dj57"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43284ed32a0so3939271f8f.3
        for <linux-iio@vger.kernel.org>; Wed, 28 Jan 2026 01:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769594125; x=1770198925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=07mXvpuK72uwHoPVD3hAEymdnjxb4apNqwq3bNoPLnc=;
        b=E+40Dj57BAuTTgGFTC+IeSTB93lTJ2wfkVWqUG8JrlH99kiGKZdVLb2N5/jHTfDiP5
         5zuAjb+gs/fFvbWkRWj2GtUkapcqsz/CZsVXA0lmJ4Ud8R+mBuf8BztJ+Jr1uiQMQCx+
         fNfNtiY8rgdjS7ZaAsXX4ZPeuKrYe4jkuVzo2zITdCBb3k1YLz9vO6GYsAnCIk/MD9Ng
         YxyAqmccsycwKKHMovBGb40wr1iqCjkTJVIsh6BTWokghhW25U8+9U/0UYIL6lAYY0la
         XeX9k6y19ykCSksZxfEkDccDV5rT+lU+Wh662r0RYnBS65wDhgHDRq6SvOkHupguGBTW
         iV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769594125; x=1770198925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=07mXvpuK72uwHoPVD3hAEymdnjxb4apNqwq3bNoPLnc=;
        b=N0VhuZpKTZPFJMF5BiFtUfNu0FCPReADGcFmXQhytr/vJgRx4kfT3yk4RoAV7/FWin
         F/HBeWMCPTCOpwWF7B8HBC/b4NLGA1DiOXEY16XRqVSW/K/CqwgJJfdsABaUz+kkcXN2
         hZC0AVh+hziT4uLtXQUzw/Cq+G4NE8puk8UnBIxjnvS7xMUnthH+9ITfZB0jWxUSOyKx
         zTHO29pB2ziek31uYIcOWZ8XPhWSuGyqskMCKQfoscbDd3u0eb59nmbHRL1iRSZf3amp
         nlPfUMW+aWDoIgachuWTufj84zau3kwIwsDe4/MPdtq6Zd4SlqlY8c3QOMDVZC87B7OP
         UmTA==
X-Forwarded-Encrypted: i=1; AJvYcCUH2EsbEaXDGZQRXuv7KGSDjuD8xxAiZ+DhedvfK8760IzOPF7/NC2kCPiL/wqqriWkRi2VFxsqv5A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy25XyCyeijPRUm7ZRFaqNQKggoV925VWxEQTGxCDz1b8PzWM35
	GjV9fRgI//mQE/yUCb9219xZUSOwsOARqJeF2y8B4muwIW4KGhSL+aMf
X-Gm-Gg: AZuq6aIn1T0Abi5e2dAm78RWxOLupZXcH4kjvvWCgsPdX9wMvoDj501I/CQHHdyDtaV
	lpE13gyLrP9st+GayaO3Urp94rB/3PNiX9soCn0AoMUduj5RhYp1b2B1zF8T9jmLfeD7RKs6aSa
	qZSTL1zvavVbd0LwhKaLG2J8LB/SM2PG4Mv24veqLGogLo9WDjvZNudvOvR/rKnhFtrFMPZJffw
	FveuEeuPBNt8XySEo5QYmvPpjbIBarr5+i0FnTzbN0d8CBii2lxAqQ2vI9hMDZ+i1bYMvO70gUn
	QlVUlrOs5lhkV7xAJXZhPd73ju7WDXBFzI5+Aa5SBC8BxeGg109/1wqL80A3tWa4olrOyzwWo9B
	SowceE7WCS1lp2NWzIM6deyJft+ExBVZHVmxedfoPg8l6GWYCKQocR6mW6vfRy+52WjuUwDx57o
	DznIj/uro6FdrlARNuu/+kDAGyg/HOf3fK2R6cWmFaXFG/CNRAkkgkF2mX0AB5zdFZavfv9DnxN
	R/XTto1CuTKtJA=
X-Received: by 2002:a5d:64e7:0:b0:435:b732:771b with SMTP id ffacd0b85a97d-435dd05abf9mr6442125f8f.20.1769594124549;
        Wed, 28 Jan 2026 01:55:24 -0800 (PST)
Received: from RDEALENC-L01.ad.analog.com ([24.206.116.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e131cfc9sm5493661f8f.21.2026.01.28.01.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 01:55:23 -0800 (PST)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Wed, 28 Jan 2026 09:55:16 +0000
To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 4/6] iio: amplifiers: ad8366: add device tree support
Message-ID: <b6pzhwmfranyhuetv65movfqzubvbjasl6ruxiym2ehuch2hov@r56lgzgf4us5>
References: <20260126-iio-ad8366-update-v2-0-c9a4d31aeb01@analog.com>
 <20260126-iio-ad8366-update-v2-4-c9a4d31aeb01@analog.com>
 <aXksSjsyNn6if3eQ@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXksSjsyNn6if3eQ@smile.fi.intel.com>

On 26/01/27 11:21PM, Andy Shevchenko wrote:
> On Mon, Jan 26, 2026 at 01:51:05PM +0000, Rodrigo Alencar via B4 Relay wrote:
> 
> > Add device-tree support by dropping the enum ID in favor of extended
> > chip info table, containing:
> > - gain_step, indicating with sign the start of the code range;
> > - num_channels, to indicate the number IIO channels;
> > - pack_code() function to describe how SPI buffer is populated;
> > 
> > With this, switch cases on the device type were dropped:
> > - probe() function adjusted accordingly;
> > - Simplified read_raw() and write_raw() callbacks;
> 
> > - mutex_lock()/mutex_unlock() replaced for guard(mutex)() to allow
> >   moving to early returns;
> 
> Shouldn't this be in a separate change? I dunno. Let Jonathan to decide.
> 

As read_raw() and write_raw() were refactored, I thought it would not be
a problem. I can drop the change... as it is not a function with many
complicated returns.

> 
> > +static size_t ad8366_pack_code(struct ad8366_state *st)
> > +{
> > +	u8 ch_a = bitrev8(st->ch[0] & 0x3F);
> > +	u8 ch_b = bitrev8(st->ch[1] & 0x3F);
> 
> GENMASK() in both cases? But I don't see why ch_a needs this at all,
> isn't the 2 LSBs are not used anyway?

Yes, I can adjust with:

u8 ch_a = bitrev8(st->ch[0]) >> 2;
u8 ch_b = bitrev8(st->ch[1]) >> 2;

st->data[0] = ch_b >> 2;
st->data[1] = (ch_b << 6) | ch_a;

so no need for masking both.

> Also missed header inclusion for this? And also perhaps sorting headers first
> to see what's there and what needs to be updated (ideally another patch to move
> to IWYU principle).

linux/bitrev.h is there, but indeed header includes are not sorted.
I will create a separate patch for that.

> 
> > +	st->data[0] = ch_b >> 4;
> > +	st->data[1] = (ch_b << 4) | (ch_a >> 2);
> > +	return 2;
> > +}

-- 
Kind regards,

Rodrigo Alencar
