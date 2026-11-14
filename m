Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794659513;
	b=fPQCEAggv1hb+6cYQq0g3yIlOLG+CsXaNnbdLGICU0e2t4M81w5fL/J2NXj5OWQLJiuC
	 Weqyu9r65JT5juRX7BB/UdmfJYZAc/XRkFGgeDn7AstwLVPDuxANRq0my59rS2EiH+THN
	 5+whuwAH89wweTm6uqPsg68HJQnpVLf0IOCN3RKZcIWIkTPXOKSi6SHovIEFfrkmiAYDH
	 IWKpwBA1dylSGY8TNzEOkBx13uTSRXmg3gjoyYzGv6LiJu4gwrlUPtDeS7bB55q8M34OI
	 PhHibpgOAFq5GHvNRj/qXfRGtESFhQZLJJ42sM42QF2KsgLLE1MR24lyfUJAEiEtSjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794659513;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=FubQ7kDfuCTVnbQ3HELJBh3vpsV3nUuIUT4l+VZplWI=;
	b=EoM4YReMpwj5d41QSFwo+x4A635b7/cwO8fMBD3Wi4giuxHE93/se8IQHjxXKTIGmyi8
	 XjXCfdeEcumx/CbSp/HEwGZEqqn7rYRfXNEHprSChloeUVlJB6aCWnsk/CjGN3KghDzCS
	 9aNK8MgCavPuUnoBp9YXmZZ+BVh2iHttytRCp45gtUa6uHrf5pYpszAAojjA3KNpaOkVb
	 RjZQAD3V8BYP94E2a2Jstbro+A+PS58X/Q1lQL9qgnCRW2OUsgsYslJoTsSWOz9Hz3dy4
	 mgAYOJpsJlHWZ1sNVkZwaIVzNyRr9FfrunaP4qcTPbAaDwAOYbBa1iJDvYWw5VaHAvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bcZgr9T4;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441BC606A323
	for <linux-iio@vger.kernel.org>; Sat, 14 Nov 2026 12:31:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 441BC606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bcZgr9T4
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so16994855e9.0
        for <linux-iio@vger.kernel.org>; Sat, 14 Nov 2026 04:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794659512; x=1795264312; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FubQ7kDfuCTVnbQ3HELJBh3vpsV3nUuIUT4l+VZplWI=;
        b=bcZgr9T4ZJd08KKsJob2/GiH/qn2JuJwj3S12r1vDHGCuc3ejfLdQVEzL+zpM6FPhw
         F3siBl8+hgoB2NyjzbAopwh/FNXeghKMP/YtNDEMUTlDSVb6Be+ImA/ED6HCIC0MVeVY
         trO5BNGt7zpGHtpYuuLgHe0hpRAsYDvIWw3x5QcJN19uRpmN5eYbN8NvS9BeyOrtQl2y
         lot6lqafQ3Y0HK5tWSPt4xGiDCbETpAPVzaZobVmy3LkSL2cJzmalb0n8yGORTe+tC60
         M6p63tIo8SJVS/cJdapuBrxYybKfQZjpQ4ErrF7QFESt3BGanTyLssG2mDqFAtuj9vMT
         PjNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794659512; x=1795264312;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FubQ7kDfuCTVnbQ3HELJBh3vpsV3nUuIUT4l+VZplWI=;
        b=V8SQxY6YU3HcWNquXFxRcUHG2gF/V0T+2/nsU9aXizarzDaGMF6pPAgXps8NUbBKWm
         kBWTofnk37fSwwa0YtRX2ZP6NlmQ834VTHAYV0KcquP3luV1h0t/Cr4uLEkLKZf1NRAb
         LYLp7uMZpA9kW//wKuUVdxQqWbwTCaeWIAd4Ylo9VntWP6tUgZ4Q8UZ9lcW7R/u4qDz5
         Ic/2jFGC523DSnx9Yvmf3CCEWanbxKmDF0HTkKwe1gYtL3HgIyUp1xA4Ihg75c+/kwNh
         EBWCNJ/JX0Evp8eqWa2FetmBSFPHT7tLBJwYojxhex7oXylHK46jG7RIQ3VGMKMrX04I
         e5WA==
X-Forwarded-Encrypted: i=1; AL+hErFGDyntTgJ/yPNJ4gVDTWNYFQD0Ij23qHMfDXu8sdZNo0v5mjfJ7RkotcG11q/RfUgVmexXN95PxFg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8OPRozEcDGaCOCn8dr89mB+LBul1BTz/R6ol//UCXCo4E1KaC3
	dUgqbYPSoofq+JjA5u2Ke85vmIWDcCXEvFvZFOFpFpaVO0ldxGMXJqS6
X-Gm-Gg: AYBFou2myQB0cmiDZiwPzWzB7N9aSr3UOJXY5ZSmghjRLHfHMMPMvKlJQjnQsmhnFiU
	IbSltQ7ygDhZLx+w+ZPByE72731Q7ww6H8GRa2U5x54vK3W9b4lP8PpmUdcSllqfhXuYrsQ6tNn
	gWrCpvhQE43ITSeX/MvayLdW6ba8hLM++In9dDJG3EKySUjOkBBZ/UKyCLl8gR6Z0xGQwUaLKXZ
	9Wa3muJlCzrMAru33iFr7gLbohZkrFXWm/jXzYfjSq166ruQbkJTyn3FYYVemfrUS7zXUHhhZe7
	EW+mnee6gpBcSfiVN+cl++2l86ScD6m63KfkSxIsnka/CSxee6UtM8igTl3dTDaBU69Uxz9WdXb
	h8U0gFlNHCXuyOC5qE4s1bU7jODVVqkmyHxGf0qKHoNI2zzq4k5Q13rD8i++1jkXp3a0+o52GcU
	/ZpY9gpnZvEcNuhW/6bLL/VZuXSOloT7VAZoC5IDJuKBxvQr+T+r3zQy1pupglMCSKVwvM6nuz0
	zgfFe7SMNbsHzKzQhpiQJAAV13027EN10HE80fLwl+6zn87RVpgFnJQvjx6XfYIVfwrRuqjl8qC
	ASqWu/J6BKcp5hCRxZB9RySpwAmYKOcHg3MhuMN39V+cRZNSeVz0YMDjjETpSXihIQ==
X-Received: by 2002:a05:600c:3110:b0:4bb:5df4:685b with SMTP id 5b1f17b1804b1-4bb5df46970mr75245315e9.23.1794659511598;
        Sat, 14 Nov 2026 04:31:51 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e28d0b2sm186313145e9.7.2026.11.14.04.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 04:31:51 -0800 (PST)
Date: Sat, 14 Nov 2026 12:31:50 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Di Wu <diwux@google.com>,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 bleung@chromium.org, groeck@chromium.org, tzungbi@kernel.org,
 linux-iio@vger.kernel.org, chrome-platform@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: cros_ec: use sysfs_emit() in show callbacks
Message-ID: <20261114123150.7eff74ea@pumpkin>
In-Reply-To: <20261114021554.2165a2bf@jic23-hlaptop>
References: <20261111072608.3490763-1-diwux@google.com>
	<avR-KT-6e77EexZn@ashevche-desk.local>
	<20261112020439.37b0da70@jic23-hlaptop>
	<20261112220218.1adae5e5@pumpkin>
	<20261113013646.4c2f8456@jic23-hlaptop>
	<20261113092305.00ec8be5@pumpkin>
	<20261114021554.2165a2bf@jic23-hlaptop>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Nov 2026 02:15:54 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 13 Nov 2026 09:23:05 +0000
> David Laight <david.laight.linux@gmail.com> wrote:
> 
> > On Fri, 13 Nov 2026 01:36:46 +0000
> > Jonathan Cameron <jic23@kernel.org> wrote:
> >   
> > > On Thu, 12 Nov 2026 22:02:18 +0000
> > > David Laight <david.laight.linux@gmail.com> wrote:
> > >     
> > > > On Thu, 12 Nov 2026 02:04:39 +0000
> > > > Jonathan Cameron <jic23@kernel.org> wrote:
> > > >       
> > > > > On Wed, 11 Nov 2026 16:39:37 +0200
> > > > > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > > > >         
> > > > > > On Wed, Nov 11, 2026 at 07:26:08AM +0000, Di Wu wrote:          
> > > > > > > Replace sprintf() and snprintf() with sysfs_emit() in the sysfs show
> > > > > > > and ext_info read callbacks. sysfs_emit() is aware of the sysfs buffer
> > > > > > > PAGE_SIZE limit and is the preferred helper for show callbacks.            
> > > > > > 
> > > > > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > > > > > 
> > > > > > ...
> > > > > >           
> > > > > > > -	return sprintf(buf, "%d.%06u\n",
> > > > > > > -		       latency / 1000,
> > > > > > > -		       (latency % 1000) * 1000);
> > > > > > > +	return sysfs_emit(buf, "%d.%06u\n",
> > > > > > > +			  latency / 1000,
> > > > > > > +			  (latency % 1000) * 1000);            
> > > > > > 
> > > > > > As David said, since you touched these lines, make the less amount of them
> > > > > > while at it.
> > > > > > 
> > > > > > (But no need to resend, usually Jonathan is kind to tweak this small thing.)
> > > > > >           
> > > > > Done and applied.
> > > > > 
> > > > >         
> > > > 
> > > > I just looked at that line again.
> > > > Why is it multiplying the remainder by 1000?
> > > > It could be:
> > > > 	return sysfs_emit(buf, "%d.%03u000\n", latency / 1000, latency % 1000);
> > > > if the 6 digits after the decimal point are required.      
> > > 
> > > Good point, I guess unrelated change that we could have on top.    
> > 
> > Indeed.
> >   
> > > Those trailing zeros shouldn't matter.    
> > 
> > There is a matching oddity in the set function (just above).
> > It calls iio_str_to_fixpoint(buf, 1000000, &integer, &fract)
> > then does latency = integer * 1000 + fract/1000.
> > Just replace the 100000 by 1000 and you don't need the divide.
> > 
> > iio_str_to_fixpoint() will ignore are extra fractional digits.
> > 
> > Although I'm not at all sure its handling of negative value is correct.
> > It converts -1.5 to -1/5 and -0.5 to 0/-5.
> > I can't see how that is useful since i*10+f for both gives -5.
> > 
> > I'd have though that either the fractional part should always be positive
> > so -1.4 would need converting to -2/6 or it would have the same sign as
> > the integer part and -1.4 would be converted to -1/-4.  
> 
> That is rather odd use of the output of iio_str_to_fixpoint()
> which admittedly is a bit unusual because of the need to handle there
> being no where to put that negative when the integer is 0.
> 
> Can get away with it here though as latencies aren't negative so.
> The code doesn't seem to actually check that though which might
> be a nice useability improvement rather than setting it to something odd.

I did wonder if it is ever used for negative values.

I'd have thought that fixed point maths would always want a positive fraction,
so needs (eg) val/1000 and val%1000 to truncate to -infinity whereas C divides
truncate towards zero.

It is possible that the function should just convert 1.234 to 1234
and 1.2 to 1200 (assuming 1000 for the input parameter).

Clearly not really relevant here - apart from not erroring negatives.

David

> 
> Jonathan
> 
> 
> 
> 
> 
> > 
> > David
> >   
> > >     
> > > > 
> > > > David      
> > >     
> >   
> 

