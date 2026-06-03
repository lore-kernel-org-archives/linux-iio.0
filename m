Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996F6384CF2
	for <linux-iio@vger.kernel.org>; Wed,  3 Jun 2026 10:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780482436; cv=none; b=eSkzLGvrOlVm60TRHBuiwSyKM5yK2QSzOufkOmHtF9ZVAHn+PXwS+bvz9Hc/e2dvlmHyJ+1FQwSgEug02SbApGQEbj58hj9gesoYPI9E3Ff2P7CLjRD8t0e+ApU1Eff6GRJXHdl11gJL6KETjCXE4XVcEkQWh2V2Gdu4FOz1YAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780482436; c=relaxed/simple;
	bh=Ark9em2HE+VudWaYABBUGSqA5V6yzvpN+95Dp7fRXKA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S82HN7h/u9Yose9eq5mo7IYH6r9KLGszIOwzp3c+GhVmWdBigI++ziBeZqJrTdHPlGz+CtvH8s91JWhAsamoSfnNQw8++6WGk8GQRMoqwj9ii6GPikRVUJBez0MGg7BvHZGaE3lEJ4xhehBIbR4AuaHzt+hKpCGKsPmGRZST4M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHA6gZNN; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHA6gZNN"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-beb7f26ed62so440467166b.0
        for <linux-iio@vger.kernel.org>; Wed, 03 Jun 2026 03:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780482434; x=1781087234; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H+8/3rc9t6wT4lr8p2D3TwP0o4yczLstnY4MzI08CwE=;
        b=CHA6gZNN8ODXOaN2r642vRk7BH81kSPVTL1m0AWIn2AeYvT0cIXJooZ3HF+BdFIzOP
         nimFmTxoHG7q5b4+pIaJ1u2JNmlmRUP0tIeg+KOjnSSkc/LTy9NL5DlUEUa+tm5j7Srj
         +cuavPNRl4mbw/SSA+uDRWM/oa8rArc2zP8f5/iimugTA3aAE1hAEOW/JMzNzu97T5ud
         0lkC3KZ9I7ri/o5Uztl3kZS92WSUOqHSKfvNx/LAIf/+tvdG+hFf3Sbt/MReIjk/d7YR
         AxD5IdPfTEdcuR5Cn720jnxrFASk4BqaOHcklSgFBSCfnf99an7WnnSJtg0EF7BYbBtn
         j+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780482434; x=1781087234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H+8/3rc9t6wT4lr8p2D3TwP0o4yczLstnY4MzI08CwE=;
        b=lV4/reKoXPwatfeArM+b7vkqC/ywzOloHsgIiRahUoEoQS6Ckbrrlu/EUdlxWb35IH
         PZhfpuabmiFIjcPSa+QEnKigItc163MjnrzNa9vtadwph1r+nM9LDQAh+ik+ioZoXFjd
         SPnkuYRmRYezWGTlQIOkOF61Vte5iBHReu3X7VZmJeDEX9sUMffYdqaBkYNBMMd8FDm9
         GYyb5XAFi8FCoLtbh82CloFRxez0Vwf3h0rIspWfdlCglvN1wvOJTKXO3MT1pmBMSqx3
         tLx28spWOMCwK1flEkv/P7HuKf+YDY24an6zl34JCaGmeeyp3K24UqNruZCZmfeIwuL4
         SS+Q==
X-Forwarded-Encrypted: i=1; AFNElJ8iQbr3ZSNhKeZJVWzRbtjLpz1vyta10V/6a1YOFlUW+2BSOz1IEhI+GLcasAN/uvGBXiQI+sbp5OQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOQ4Yvla5gz+vyEf+sG080kMGADLVQtVs78dBapT4hWkI8uDQp
	b7sY20bnQz66ev/+z7TVzlYTnPBl9ogTdDkxGTRlxy1Duj2zTzJPRKS+
X-Gm-Gg: Acq92OGxUtAgxGT8dqoX7IJvKeUyKoa+UtMosX0pe1fj74Sv1VX+pkh8xx2n0xCJ9E5
	AQKqTo+gmat3X4nMcVfnLePGfzFbdfP1/zkEViLrosT+nJU86RZCcY1rzKBt0XfqZE2LrOMCQ8b
	u1QO9gFaKhnBpQ66vHl+BfOUKdOp3+abVOqOjjdDhZQoYzH/o96E8lHB6idVL+wVRMfKkQ50u2x
	BHN0JXzoXwiO7fK20sKnpQLIWVl9Pd9DgW0Gg+3ERMhV5wFSO6cLEo7kzJop2KrrSFxfUQhWDn9
	bQ6RivhVPGPlsSUP3DIUC5w+lUto8rjRfP8SFS/zuxlcKGp8AhNEeVbn4um8hJKsrIxeGjUOxJ+
	S1GjNA9+dPVkIHeUY9HH6f9UXVFzBWpx0S/3smfp7krxP3ClUjRUXIFNpcjXrjXgWEpmMWE82AZ
	ek6VVXr7Qmwl8Fx8eKoSXPmkA59xtF97Y+9ZAGkvoCujvNxSV+U03qWB+uFUc8zEyTDb2TfX7pd
	QB69YjEMEw8N2iyfi5gMDB6wwQHKL3/RkqaAyOMU1OcXIOuXw==
X-Received: by 2002:a17:907:3890:b0:bd8:f7f6:92a6 with SMTP id a640c23a62f3a-bf0b32b8a7bmr154755466b.23.1780482433765;
        Wed, 03 Jun 2026 03:27:13 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf0559f1464sm130550366b.55.2026.06.03.03.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 03:27:13 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Wed, 3 Jun 2026 11:27:11 +0100
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v15 02/12] lib: kstrtox: add local
 _parse_integer_limit_init() helper
Message-ID: <r54csg73lsafo6rff7gew2eardfag3zmwjbm4jl54pjbqf6w7y@axnfog5wpney>
References: <20260531-adf41513-iio-driver-v15-0-da09adf1c0dd@analog.com>
 <20260531-adf41513-iio-driver-v15-2-da09adf1c0dd@analog.com>
 <ah8yR3Os8NDNll27@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah8yR3Os8NDNll27@ashevche-desk.local>

On 26/06/02 10:43PM, Andy Shevchenko wrote:
> On Sun, May 31, 2026 at 09:30:45AM +0100, Rodrigo Alencar via B4 Relay wrote:
> 
> > Add parsing helper that accepts an initial value for the accumulated
> > result when parsing an 64-bit integer. It reuses current implementation
> > for _parse_integer_limit(), which now consumes the new function with
> > init = 0. The diff algorithm would have the documentation header and
> > prototype of _parse_integer_limit() moved around so it is adjusted
> > according to guidelines.
> 
> ...
> 
> > +static unsigned int _parse_integer_limit_init(const char *s, unsigned int base,
> > +					      unsigned long long init,
> 
> Why not name it res...

"res" is short for result and this is an init value. I suppose the compiler
can optmize towards that kinda of efficiency. I thought of "p" itself to
carry the init value, and the function would just accumulate, but that would
change expectations on the function behavior.
 
> > +					      unsigned long long *p,
> > +					      size_t max_chars)
> >  {
> >  	unsigned long long res;
> 
> ...and drop this one...
> 
> >  	unsigned int rv;
> >  
> > -	res = 0;
> > +	res = init;
> 
> ...and this one?
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

-- 
Kind regards,

Rodrigo Alencar
