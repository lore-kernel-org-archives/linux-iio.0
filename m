Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C18317144
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 10:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779014648; cv=none; b=txOnYtckZnS2sCwMc8EhFqDaaZ56PI1VcYrFwsA7OH2a7AbNcwdR0Y7V91utiSaSfLfII4BbAz6mTvD+rGNL4IMwvreST6O+GujYI49Q8ug1YSdRBHtxOBeHaBD8MjDb0N+g0sek/f+WJf4HsPRjKpWMXoR7pIqByDJbZKipADs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779014648; c=relaxed/simple;
	bh=tlZmveqPOI0YGsJN4bEukbZ+5Bgq+D8k9OvRT/i7aSQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VLbsSAuQrGEgQSGZF1muQMAaC55seaizUXtGGrz25IArs9Ad3viG9ZnkzKuQV/oC19iSmkh5bx6VrwdretgXwGvyXZ1lKjTm6fG7nUkDTdB2OO863lNWo81o9LQVFIkKuUh8oxLTWcvxdITU2+EniJeeNFIAlP3O1rHlNXqLM3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UfNZx+CV; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfNZx+CV"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so8574335e9.2
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 03:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779014645; x=1779619445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H5gIsWRNwchS9zsgu9M5QrXv9157pRu5lm3mw2NTNgU=;
        b=UfNZx+CVoYK6vURd1/JBOO0KIqwUo8bBUqBX/Ox4GcxWAa/7doVBjKKWUt3JmV4vKU
         T3+m4ynPzdF9kaT5Y42KsONbpy8zUABtjSrlwLSjwiu2ILhV2ZQVESyS6NSQlmDaCdpZ
         ZbTByK5fLoHrZprriNcsMaqLmWvEN0b/ZmUyLxURMxxRDYlIJdUknnCsx+SgOQAdoyhE
         clu9kwZG/t2BCJZqd7pqzjhtt2j9q60MZXTL62bPQJXVbqIYrmQYyrdCq09OV32NhiQP
         95X8VFOh/6BurJ7tiLSZ+EEpEqK4Q1oGnmFR+JakZUkdVMenmKUUgW7cCWI+v0qFrmbE
         LiqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779014645; x=1779619445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H5gIsWRNwchS9zsgu9M5QrXv9157pRu5lm3mw2NTNgU=;
        b=A3XHpNPcMyDYI3mTSMyjwiJ9C/Tgdq4U4hsPxMISP901dSwcDghu/B/ASkqhEIm2Qk
         UYNpXhfudduH+AVtu40weGbUWpGNebXShao2AGyk2YU1cgN6f0nJtSvZEiyzEtQR5/uZ
         57f9GrNZY38czJ0rh/N654/svJeKHeZcu1gUwpQ36AvcbRKOvH7EuTrIuC2+nY02xYwO
         3QSFFvE2nvIDM4hJ4eXd4xvkyqS9pxTQj0bLZuIM26i56kR5PajbstReCTaLSPKaQ+Kr
         L+aHavX4j7gw3ME5xVsEf5gZ8MWHb7HAE1JgYFQLkCU1xBpK9Wg2wsEgDYeGI7K/xtdg
         Guow==
X-Forwarded-Encrypted: i=1; AFNElJ+8/u8GSL2Ymh8ngTjnzn/KTFPh6zLiBpY1iX7Ja4ia1Z+TBq4qFZ4UwzkmIAB/3bgmXMDE6u4amSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YySyowSchYY3z7+OIcmgCyo4NnMY3f+pEvRBlPyyRQMi4HTTOfL
	4cRVvnnp99EH/Jk7lKZHFxRB2G9usgc4eKiwRkbSfLj1ZVeMjCpjz6Ef
X-Gm-Gg: Acq92OHEt5pqxZSX6tfLi6+nbEiuK757eBJ7NSVir4VDtEGU2YL7khZmASBWiE0rjBL
	6UiostvQZpDEZg4dpa0y5CCVf+wdFytNBqX7zb47ccTTaVbxfAzNrOUKP8Bl/vvc7irlpOnf+h3
	vgVCrLr76Fz7zVW5Dk1ca7FrixdlyXRFhdRMagcNc95FfTMl7+6Jc43StuiOKy1QSmWiHc03dHW
	s1SnnNCKgEBQXXzlO4jITpdrfebduKpU3sejKHt4/dpWNNQltMdMcsXrb/SvElpgF4V2TH/cney
	TpIplBkiNGTF7thf76slsLNWfNGoLacF4OieXp5DQM5CDnqhgYG8U3GnIej3hmQPF2un7yRclkV
	ms0BroTJIuJUoOdy8anAq4SgbEGDm6VbhvzUh8wqNhS61EMYL5snauZo33pjNRB9yuakY3hb745
	VJrqzINTRDWrQ2zT1BmWtzfeCZxWCG4qpELRNNz14v5VZHZ/BCTBkrJqbyKaeiVyYhBIoroAp8c
	P9/FXhjxR9PGpxWNQN13jDxaQwo6yl9CzhslfXrgmlMRG/8/Q==
X-Received: by 2002:a05:600c:848c:b0:48a:52d4:888c with SMTP id 5b1f17b1804b1-48fe60e5241mr161739305e9.3.1779014645237;
        Sun, 17 May 2026 03:44:05 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec3ac86sm28777006f8f.14.2026.05.17.03.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 03:44:04 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Sun, 17 May 2026 11:44:02 +0100
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
Subject: Re: [PATCH v13 06/12] iio: core: add decimal value formatting into
 64-bit value
Message-ID: <bhicqdxszledixf44h4ox6cdemuytyiotgha6ab7455vtmqatn@byvmhy5llaij>
References: <20260517-adf41513-iio-driver-v13-0-bb6e134a360f@analog.com>
 <20260517-adf41513-iio-driver-v13-6-bb6e134a360f@analog.com>
 <agmVYvWBmLI4A65m@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agmVYvWBmLI4A65m@ashevche-desk.local>

On 26/05/17 01:16PM, Andy Shevchenko wrote:
> On Sun, May 17, 2026 at 10:14:01AM +0100, Rodrigo Alencar via B4 Relay wrote:
> 
> > Create new format types for iio values (IIO_VAL_DECIMAL64_*), which
> > defines the representation of fixed decimal point values into a single
> > 64-bit number. This new format increases the range of represented values,
> > allowing for integer parts greater than 2^32, as bits are not "wasted"
> > in the fractional part, which can be seen in IIO_VAL_INT_PLUS_MICRO and
> > IIO_VAL_INT_PLUS_NANO. Helpers are created to compose and decompose 64-bit
> > decimals into integer values used in IIO formatting interfaces, which
> > creates consistency and avoid error-prone manual assignments when using
> > wordpart macros. When doing the parsing, kstrtodec64() is used with the
> > scale defined by the specific decimal format type.
> 
> ...
> 
> > +	{
> > +		int scale = type - IIO_VAL_DECIMAL64_BASE;
> 
> > +		int l = 0;
> 
> Perhaps make it global in the function? We have the same in
> IIO_VAL_INT_MULTIPLE case.
> 
> > +		s64 frac;
> > +
> > +		tmp2 = div64_s64_rem(iio_val_s64_from_s32s(vals),
> > +				     int_pow(10, scale), &frac);
> > +		if (tmp2 == 0 && frac < 0)
> > +			l += sysfs_emit_at(buf, offset, "-");
> > +
> > +		l += sysfs_emit_at(buf, offset + l, "%lld.%0*lld", tmp2, scale,
> > +				   abs(frac));
> > +		return l;
> > +	}
> 
> ...
> 
> >  #ifndef _IIO_TYPES_H_
> >  #define _IIO_TYPES_H_
> 
> Also needs types.h now... Which makes me think if the proposed macros are
> placed in the good enough location.

That is a good point. I left it there because they are related to IIO_VAL_INT_64
and IIO_VAL_DECIMAL64_*. I had them as macros initially, but they are not exactly
"types" indeed. 

> 
> (Note, iio/iio.h missing actually types.h, but includes it indirectly.)
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

-- 
Kind regards,

Rodrigo Alencar
