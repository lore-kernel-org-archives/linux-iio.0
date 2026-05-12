Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A183E1736
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 13:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778592081; cv=none; b=SBbZHc4ixmdAtpxoDPZqMMYD+Llhp1WEp8JasHbEWAAAsCWPmsneqqwmcfzU7hga+EZ6ow799A+PKCjyx1KCDjZB28Y2WDnFuQ94AN4PEvUAhMRf7YM3LaY6X8fibiZ9Frv8lRhWWdF5dXXhr8nzsb+luvHc7Spycv+p3oGcPgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778592081; c=relaxed/simple;
	bh=sEiYG2uut8eryJgiVxXirz97HD1qb4i40If2RpVaDvI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+gC1YowxlhABSZVndi04G5/G2X8ZdF/nue+vJ49kZA9ak89EOoOXWSnE5/e6lFeK0C9DHRATdxslb/PaAxC6NID34NaCRTzvPYsvpGrsZPBXE5hEuw4gukMzj96S9D9PYn/MgKrNYLGoYizvPwiBcNI38f638ANtaqDRVUFIfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HW4WXrgQ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HW4WXrgQ"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43fe608cb92so3506059f8f.2
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 06:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778592078; x=1779196878; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H0iUBbHJXRnojwm2dbHMn4bUhVf32dcx1R5+1C6RZQw=;
        b=HW4WXrgQJv/8u5VL/s2qAKveBKj0j9M6F11QIaxwdjh55mQx1OtuJ1fUm6YBNXWLVh
         5xqZC2rN4vmzO3PV8WnKxVaB22uWj5NdIf2JYcINvJsgMXselYnS/zEa+EtVHMhS7vHo
         KQ1P7mE3H+WwzWWPcyqwavohBt7J18tnCMLhwdY4rB2fntrqXz2m98Ngk6t5bVmsDVot
         o//rWQG2SP+xzPUa227lCd8SPg/0nvy+GW26o3fBlPdT3+CiKkG3fGCNQYCg2loWLjho
         j97JjqSlXGaXoaQZM+nxBlwTjHFsdaDZ6neTqJf72oXcJTibYrsk9PlOFfaNh9c+Fq4J
         6JjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778592078; x=1779196878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H0iUBbHJXRnojwm2dbHMn4bUhVf32dcx1R5+1C6RZQw=;
        b=kPfD9vKZ9jiNPMTc4wS0pRaVAlcohcvSL+KRCniV9xCvrTdAefwphLUVceSCnuK9Zr
         CG2xuBpISZf6+3KTa1f+slh6CFv2Bxlj1rSi4whp0HBfFQBiWWO9UJ4owbr3+32anxBk
         IS5QD3qvvd2W49DVzzjCkkh1zwo6aFMe2bdMCBw3cgdQVzKwD3K2YI70zv4PNXVeENB6
         0A5DYSMHT1zl8D7xOK7pPTCoy+1Hl+2NBerQc0htPZ+4bOS1zZUys5RiufjtxCvDLn0n
         RrHeBOev4e0KWrWTYdHoVi1RA/lbpY8ryi2NMExgP9zxT9S7puHBWYw28htPy8NDHle2
         NqPg==
X-Forwarded-Encrypted: i=1; AFNElJ+V+6g+u9QataCtKgTReP+V8eAtEPb1ngbZW3KrJZCRZJKkO4ekx1Fu5WLeJO8qO6CIkDESg1Vvu7c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/l1UYFIB5LzLfeYkS28ye3O8/wx6EtA4b2330wiIDxezVVWPZ
	lt2yhXo3tK/x/3hMGRfZrWvsL8yCgNWe4iePjNxXLYGLV9e30CcZfVhE
X-Gm-Gg: Acq92OFz1K2IFs6+XknruKwybBJGNDzC5qHww+mlZm2FJCLy/zUk7eP3irFGPsy4h2Q
	DPZ9ODEhRDBx/vdDZzkvUIs3uWdagjV40VUCDLNgVYBdoz06oXJEkdUe7h4Th8oBYWupqkcCUA7
	a1wnph71D5dIdSIkbipQxKCn09jY9DlaUK+sJcns9yV/t5LZhmdZpeJXje8aUkA7UkO6P0n5NBG
	ELDYFPVRIkSNGPllT2SNMPTxEF8LDEV4ER8LQGkx1u3OeHE5Ltyvsf6AvHA9N1LU8jupkLR+7ff
	lOljeRYf0ZNubphxUaMvZ/v89a1/7VmwE8hAiqekw9+J4Hc0WlaY62kRHadwKtaIwf/3U8UMPkn
	tZnOIcfLLiwegOfUYUVolZqd2Fmh4EuXbRQjDR5/UnTO8UuEuQoFuRFIY9mr6LHUMU3SMIFX0kX
	BSz4fvRTXlHUHvEbR8D5dqJKmOxVILIjLo6cknd5bZXXtZSUlCHVeK2DTTxiXAsKAwsxJdSqTJf
	lBIhzE15If8uzrtFI02u26XQTv+2dKH7GZm2rXn0KbcliOcVg==
X-Received: by 2002:a05:600c:a412:b0:48a:525b:e148 with SMTP id 5b1f17b1804b1-48e6748a724mr188954735e9.4.1778592077610;
        Tue, 12 May 2026 06:21:17 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e9055ec3dsm43552285e9.0.2026.05.12.06.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 06:21:16 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Tue, 12 May 2026 14:21:14 +0100
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Jonathan Cameron <jic23@kernel.org>
Cc: 
	Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>, rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	David Laight <david.laight.linux@gmail.com>
Subject: Re: [PATCH v12 02/11] lib: kstrtox: add kstrtoudec64() and
 kstrtodec64()
Message-ID: <sj6cpjhakyfvv6rgox6cnhl2u2tgaecugcok6fw2l7zgku5wtc@aqx3ul72vgca>
References: <20260510-adf41513-iio-driver-v12-0-34af2ed2779f@analog.com>
 <20260510-adf41513-iio-driver-v12-2-34af2ed2779f@analog.com>
 <20260512123953.40d80bc9@jic23-huawei>
 <agMnWzMjW1LwCSyT@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agMnWzMjW1LwCSyT@ashevche-desk.local>

On 26/05/12 04:12PM, Andy Shevchenko wrote:
> On Tue, May 12, 2026 at 12:39:53PM +0100, Jonathan Cameron wrote:
> > On Sun, 10 May 2026 13:42:20 +0100
> > Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> > 
> > > Add helpers that parses decimal numbers into 64-bit number, i.e., decimal
> > > point numbers with pre-defined scale are parsed into a 64-bit value (fixed
> > > precision). After the decimal point, digits beyond the specified scale
> > > are ignored.
> > 
> > Whilst Rodrigo has already replied to say there will be another version
> > I'd like to request final feedback from those who were involved in the parser
> > discussions.  
> > 
> > They got very involved and I'm far from an expert in the right way to do
> > this stuff.  
> > 
> > I don't think David Laight was +CC so I've added that.
> > David, Andy - I think you two were most involved in that discussion:
> > Any objections to the end result? 
> 
> I already said a few times about the naming. I do not like the kstrto*()
> be semantically different on how they treat the input. Second point is
> to avoid code duplication, but this one is less of a concern since the
> new code is in the library close to the other potentially duplicate code
> piece and hence can be addressed later.

I suppose I reached into kstrtodec64() and kstrtoudec64() because it aligns
with your expectations for kstrto*() semantics, no? Those include:
 - overflow check;
 - extensive input validation;
 - optional '\n' in the end;
 - mandatory nul-termination.

am I missing anything?

> Having the test cases is a big benefit, and that part I like the most.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

-- 
Kind regards,

Rodrigo Alencar
