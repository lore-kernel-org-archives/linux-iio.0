Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794561789;
	b=AJ4ClntSYh4I260YtN3PgNTgiF2QHXzkV0bGyoZRXPJGp4sLFUARjuNerbhTJ5FWn6KJ
	 ukk9IpsRGI3O7E/UmVJMe2Y8hminOWhGpEx3AbEq/zj30Lww7OZ1yr6SCLjbQ1H4ZNoUt
	 5tpnPoy/MtGcyxsEul9kl/b3uNz0DRbqK8sOxQEYiIjDD0txUXZPrfpnnNmJcFP65J/vn
	 10jmp5U2EKqyHfU4irztzdb6p2iFNxHX79l5s0TioPx/a5nEJ442AsoUImLfGwIs/tGNs
	 3y8D8o/+Edspl6YsLg9pK4z8Y/dEy1W4rQJxIYKcZH6xWJD/2erbDKU4kGtblI8N74g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794561789;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=L4U6uoKIPIkNv7imLu7Hv5jSI4mySZg6QE0cGj6iXh0=;
	b=coarYDqbQF5p/L6EPHjzK2iEc3gc1I6h6t0nl84/OcMTAtxXuN+C+CDcdl5zOEFmB4E1
	 ve/PCMzdjm62dxCsLRWwBvD0/Xh2lNbQVoeFhMVeSt7g1OK3VB2nrQ/rV2rvWl7HGiTEE
	 Sqv+LkMEcYSYF4PyX8JzkOGSNUBpQGfMfUj8TK1vSUuCruoHz/MKtUQAtZdwNSILB5sZl
	 jW9W9I0ywrfpLgaaz3C0IJJ4zmr7EB63lyc7AAYJtj7gze22fUammg+9Yzf0AICTWcjtR
	 pFwTFQ/7eYxtTTOCyWEeexaJ/MWKrpd0+yRubsIfbAtMF185qv99wvGvVD2N41AqfxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LP59ItsB;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90659606A327
	for <linux-iio@vger.kernel.org>; Fri, 13 Nov 2026 09:23:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90659606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LP59ItsB
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-490a0e72588so244427f8f.3
        for <linux-iio@vger.kernel.org>; Fri, 13 Nov 2026 01:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794561787; x=1795166587; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L4U6uoKIPIkNv7imLu7Hv5jSI4mySZg6QE0cGj6iXh0=;
        b=LP59ItsBjzPAPmAVpc9v5qfl4h2UfsCvzmw2kW9VSD8yXDKbNQ9n3stqsizVnnaE9E
         4B73SbKv4HsMlbRbNF8saT66sJDybIX2y37gQsarpEzTzCBHQLlJrZfpIIgg0EMBv8NQ
         NcnFrvkWg8QIR9wh9XIdRjKhOszDzKRjWbfBUP2NEf78xvgkDm5k00dk4PrX54gJRuUD
         tsuI6uCmNcaAZYtb/784LaIEg+Z5OE2IWrxiCcaT0bCmCs1IiZ4zNakOjxi2PA42+BQN
         HkK5y0rUrPf82itvRCMNgwsKuP3l6/S5MiHVO+cjaPHvhIJdu0dcyn4va0DLc/7OFsI/
         dNWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794561787; x=1795166587;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L4U6uoKIPIkNv7imLu7Hv5jSI4mySZg6QE0cGj6iXh0=;
        b=yc47RgF0YTSgLZ0Vb48sEPjcx9a67CYN7x9X4hkt6qu0KaOM6L3gMv7WzdzT1YhzgX
         vDTcBO5lRGrUy08ySXbuersQDKCIKcXB/mhQdQrlQIa2LS6DICvb9zEW8ZmNqeRVo06b
         DYkz0jpnuQDVxeJuZXQ0sp5bm1GpRCFgAF9BKAnJ7XEfnlzQ5/KM21ougq59a7lE7SAu
         lVi0jr1vAmXPutC2G2AWx62jYV23f2XHPWHSzRq9wF/31x4YKyrAcwDSMq+j/Z3IbQYv
         gCjwYWKZ8EsqRo82n3ii7KH6FWC4wv9wCFznQuuFL5zhSif3hI3E1jkojNgNCyHWY1AN
         wrAg==
X-Forwarded-Encrypted: i=1; AL+hErHAf1WxfqIhVCM2AUq0H1i9Uiq4QWgQ3Mglv7L3QaEZ15zDLOiaP+beE0wvEkFDCfz2EFCFTCzPd+Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z8W6zxb7QUPSqdJ4UqqhZ9f3Eyem7zw1hb+Fvp5RUaWHRxRE0Bc
	tfIr+75Z4ByK9nXxQFlD2I6Pn5chDre+EPGqEAkCHlbWmq9dpeHylVvU
X-Gm-Gg: AYBFou0CXnquDXn8pH2jgHrN4+23IlHPAGodOAxREtsBhH6fykWu44Y1hsgOmXTuabn
	VltOMJVZXqCbscXlxdcRQZlC9JAj/gP+PIN3TxdiKqQ2JoWNr49DBN1joEF/Wm35tHCJVPEy19M
	P+ojUqma7pBlH0IByHN1azxEGRsCSX3tdbiGSnnm9flyO7C9An9Uzs1GIHIXqOUzrIRuhFJIQZr
	3pjYQbdYwY+ltb3EmLvK6b4QEz39Ikq0C4nCr21TlOx3yBnlhmCuyMJaAjytpNFycjjE/avkI0Z
	Qx7FD23CodBkyc73xTM/585X1TnViWck+wavvt5fNK6CrMzIjYowFzNfqTMCPeQ2fEeFrF0pIwj
	Xr8A18n1k1wnyyWF50j6tlmy2ZIJ+oGbqXsd/N5f8ilKnbGyWTaCcIetsjcD09u36PLRd1/bMjW
	uOItZmJasGTLp8/7xqsrkQ1DZpVVARTTST9sj5F/1s3mFs5r0zU0eS722JkD3C0ObPJcDpT41GS
	HMpk9+0t9DpI5dwJTg6WZbLN1ivNlKTlox4VWOwikp0pZ1Y6ZkDzdI+N3UZ73lKo6nfXbjBVGpD
	XIaCM1tWvKdXXn/o8bvObxPZVgZwNKZA5vqqTHpKTcM+vMnugHDUctSWVcoP967U+g==
X-Received: by 2002:a05:6000:4305:b0:48d:e61d:68da with SMTP id ffacd0b85a97d-49c712ac8cbmr4676987f8f.20.1794561786746;
        Fri, 13 Nov 2026 01:23:06 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c69406640sm3853502f8f.12.2026.11.13.01.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 01:23:06 -0800 (PST)
Date: Fri, 13 Nov 2026 09:23:05 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Di Wu <diwux@google.com>,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 bleung@chromium.org, groeck@chromium.org, tzungbi@kernel.org,
 linux-iio@vger.kernel.org, chrome-platform@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: cros_ec: use sysfs_emit() in show callbacks
Message-ID: <20261113092305.00ec8be5@pumpkin>
In-Reply-To: <20261113013646.4c2f8456@jic23-hlaptop>
References: <20261111072608.3490763-1-diwux@google.com>
	<avR-KT-6e77EexZn@ashevche-desk.local>
	<20261112020439.37b0da70@jic23-hlaptop>
	<20261112220218.1adae5e5@pumpkin>
	<20261113013646.4c2f8456@jic23-hlaptop>
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

On Fri, 13 Nov 2026 01:36:46 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Thu, 12 Nov 2026 22:02:18 +0000
> David Laight <david.laight.linux@gmail.com> wrote:
> 
> > On Thu, 12 Nov 2026 02:04:39 +0000
> > Jonathan Cameron <jic23@kernel.org> wrote:
> >   
> > > On Wed, 11 Nov 2026 16:39:37 +0200
> > > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > >     
> > > > On Wed, Nov 11, 2026 at 07:26:08AM +0000, Di Wu wrote:      
> > > > > Replace sprintf() and snprintf() with sysfs_emit() in the sysfs show
> > > > > and ext_info read callbacks. sysfs_emit() is aware of the sysfs buffer
> > > > > PAGE_SIZE limit and is the preferred helper for show callbacks.        
> > > > 
> > > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > > > 
> > > > ...
> > > >       
> > > > > -	return sprintf(buf, "%d.%06u\n",
> > > > > -		       latency / 1000,
> > > > > -		       (latency % 1000) * 1000);
> > > > > +	return sysfs_emit(buf, "%d.%06u\n",
> > > > > +			  latency / 1000,
> > > > > +			  (latency % 1000) * 1000);        
> > > > 
> > > > As David said, since you touched these lines, make the less amount of them
> > > > while at it.
> > > > 
> > > > (But no need to resend, usually Jonathan is kind to tweak this small thing.)
> > > >       
> > > Done and applied.
> > > 
> > >     
> > 
> > I just looked at that line again.
> > Why is it multiplying the remainder by 1000?
> > It could be:
> > 	return sysfs_emit(buf, "%d.%03u000\n", latency / 1000, latency % 1000);
> > if the 6 digits after the decimal point are required.  
> 
> Good point, I guess unrelated change that we could have on top.

Indeed.

> Those trailing zeros shouldn't matter.

There is a matching oddity in the set function (just above).
It calls iio_str_to_fixpoint(buf, 1000000, &integer, &fract)
then does latency = integer * 1000 + fract/1000.
Just replace the 100000 by 1000 and you don't need the divide.

iio_str_to_fixpoint() will ignore are extra fractional digits.

Although I'm not at all sure its handling of negative value is correct.
It converts -1.5 to -1/5 and -0.5 to 0/-5.
I can't see how that is useful since i*10+f for both gives -5.

I'd have though that either the fractional part should always be positive
so -1.4 would need converting to -2/6 or it would have the same sign as
the integer part and -1.4 would be converted to -1/-4.

David

> 
> > 
> > David  
> 

