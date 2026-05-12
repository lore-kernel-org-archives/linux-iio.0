Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577413A9871
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 14:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778595155; cv=none; b=FIjDoXh6ddbrUnPX5HuNhqAU7fxxcowuiL4cygtP2n1I/Fiu1yxXXIHwsBxV7mnkVwgt4k7uY+GaabF4IU8dKiPbL+mGd+iGXzHJXssati6uogTObwmghewOphtmNeJdr7nTdxi6svQj1cNebkYd0fRSvP/vpthgQl5fvJy+ZKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778595155; c=relaxed/simple;
	bh=Q41Oo0zRbrO8B/Db3XFSemV5+e5K2mKQ+CxGfpoCaKE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RSY1ESkabmNwvTxLbufM9Um+0385PplUKigGDM6cTMUzX/wBhlXyBsqrkrP0R6eXsn9YWg4zxhq4aXJLOkfIEFPNKXpSx4TF7yqkBmK+V1vejatqq08mOriQuB7LRxvpDwqnR8Ud0YGI18eJTPj04sU+2NdxEnnd8CPmfzOVdWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfG3zEAH; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfG3zEAH"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-bce386d5b85so438184466b.1
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 07:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778595152; x=1779199952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RF50yWKLYOkstrjwnDzYRTiCpEdjsFZwr52Zl8yZOCY=;
        b=FfG3zEAHF8hTgHUZVrUnXltviGM4Q4osSwBDz4eUGoQFcxOlS4i1fY0pLIF+XllPfw
         ryY8NkT6dsFCSA/yav4VJBnENgdXI6UezVUaFFv2qZsOpGwpaFxXf5aPaRDkLx3AM5yF
         5WSiWQ5QYO/uO62OIESAQUTHQOxXcv4ddYxuuNFUIPu1jFzLie08qmXe4WHx3FxY2f9z
         kp64eDFvn82rZse8tRx371LxTB5JfNxWBcEvyLbUDoJI8ShoUbkdqulhKssITfNeysiK
         j2beEOAvkSKjBXCWsdahP4A1WJncIRopykNISGwkwLYd5X9sTjGXON2aJgupcKqMXcZ+
         PXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778595152; x=1779199952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RF50yWKLYOkstrjwnDzYRTiCpEdjsFZwr52Zl8yZOCY=;
        b=ddU+oBDx06wxnosFUFLQ23vzAk1GXkmVKhtdRt1Ywk7quEpj8W/Cxih3f84UsVXFK8
         m5BRFXs92QuhzATBgo8Z+e/sXcD26RcPhGV/3uktDe6N5GHo3/ujAYifR98r4a/ng3wJ
         nj8EjtWsFU2fVNwMagZbEpnhd5u1DldZCCryl4ujRNrBxyfu7JLXZnq2Vq+xDh7+U6aP
         8KxrFAmFSejI3Bs0zOTvmdp0B0py9CY8hPgzJBNCnGK7hnf+6yEQbHKrEV07fkEG8Ab7
         x7IdCyQ/j2BPdwqxeYM47NV7l814SDHrNMBWZVI2v0bT6RnGUjzZJkNWs1lELRrnkNMN
         WemA==
X-Forwarded-Encrypted: i=1; AFNElJ/UNEoGxrswyaCwGj6vTxJqqY9NE2A4Nx03uswuVcJFZiS3/hzhBAqVYoTCGc7xqM80in0iXtecuPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxS7hnPVTAcGm7V01S4yk4xFlVi/Bbch5g85W7irJwmP3yFiRR
	lcL3c5ctD99JlB8gFFo9F4GScp2DiHjDqBO7E2jNNsQYOLZTC6c4VafW
X-Gm-Gg: Acq92OGiOR8E0xRUTbmnowBksQvGGrySiNbcnpfAAfWD8Srdi+UCfJ+ikuuUwWsFqbt
	n+VOQ1cunKvUxkrlbzfT/lI2Iwi7W9dmb1n7Yjjhga11Ac/qFjNPjRFmpMu5EdKPK3udLRDeqnb
	H7wyHkulfbmamkccMvizeEZX1MkW+285aedUdsG5ZYh4LB41sKgDng6iZpLKJ9w9F3QpgN0j+Jg
	31UWl7l9LeBo8xfuqepPQ3XOL1gXz5Zpl4lgs7Um20IZWBVEnme2jFwRnvqiSbbbR8WZCOwwMYp
	SznjGljIwhp4K+2RWBFYaU6n+oagZ1zMMnwNXh0E7kHh5lcT5kCKXHBlvFnbfvjYi6sKWlYpjf4
	HIr8rAv5Svx4CiMjyD3HMYly0KwqPpN20qt+dzEk2rTj30kW3NgD01l4sgjV98koSN3W2Bf8gIj
	W+DN6Fn/n70/hAfKJCI12P99REgqVBWl+YDPWXDWkcbHj/RNBKi4Nd9bl+2fTV4IoGTSGrEaEX/
	FchP44c9/1IVDvZC6JlnJn4q2GR+BhozW1gcn/b5nfB51GY6S6FHqoBU84/
X-Received: by 2002:a17:907:8992:b0:bd3:7c7c:b817 with SMTP id a640c23a62f3a-bd37c7cbcd3mr1081866b.1.1778595151498;
        Tue, 12 May 2026 07:12:31 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcfb7b17d1fsm344049566b.41.2026.05.12.07.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 07:12:30 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Tue, 12 May 2026 15:12:24 +0100
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
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
Message-ID: <dxjg2sdyxb7ieb4abmeyyye7qok6cczrxabpsjyjhcbehwoec3@sbbqoo4wmzre>
References: <20260510-adf41513-iio-driver-v12-0-34af2ed2779f@analog.com>
 <20260510-adf41513-iio-driver-v12-2-34af2ed2779f@analog.com>
 <20260512123953.40d80bc9@jic23-huawei>
 <agMnWzMjW1LwCSyT@ashevche-desk.local>
 <sj6cpjhakyfvv6rgox6cnhl2u2tgaecugcok6fw2l7zgku5wtc@aqx3ul72vgca>
 <agMvlS3-0wvGmBwh@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agMvlS3-0wvGmBwh@ashevche-desk.local>

On 26/05/12 04:48PM, Andy Shevchenko wrote:
> On Tue, May 12, 2026 at 02:21:14PM +0100, Rodrigo Alencar wrote:
> > On 26/05/12 04:12PM, Andy Shevchenko wrote:
> > > On Tue, May 12, 2026 at 12:39:53PM +0100, Jonathan Cameron wrote:
> > > > On Sun, 10 May 2026 13:42:20 +0100
> > > > Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> > > > 
> > > > > Add helpers that parses decimal numbers into 64-bit number, i.e., decimal
> > > > > point numbers with pre-defined scale are parsed into a 64-bit value (fixed
> > > > > precision). After the decimal point, digits beyond the specified scale
> > > > > are ignored.
> > > > 
> > > > Whilst Rodrigo has already replied to say there will be another version
> > > > I'd like to request final feedback from those who were involved in the parser
> > > > discussions.  
> > > > 
> > > > They got very involved and I'm far from an expert in the right way to do
> > > > this stuff.  
> > > > 
> > > > I don't think David Laight was +CC so I've added that.
> > > > David, Andy - I think you two were most involved in that discussion:
> > > > Any objections to the end result? 
> > > 
> > > I already said a few times about the naming. I do not like the kstrto*()
> > > be semantically different on how they treat the input. Second point is
> > > to avoid code duplication, but this one is less of a concern since the
> > > new code is in the library close to the other potentially duplicate code
> > > piece and hence can be addressed later.
> > 
> > I suppose I reached into kstrtodec64() and kstrtoudec64() because it aligns
> > with your expectations for kstrto*() semantics, no? Those include:
> >  - overflow check;
> >  - extensive input validation;
> >  - optional '\n' in the end;
> >  - mandatory nul-termination.
> > 
> > am I missing anything?
> 
> When we add scale we basically make that not true. Moreover the code in this
> patch makes scale == number_of_characters which I think a bit fragile, however
> it's about the fractional part when the amount of digits is equal to scale.

That is not really the case. It is being set as a limit, so it does check for
truncation and zero-padding.

> To make this work as expected we need to add an additional call like
> kstrtoull() (and perhaps drop that \n and NUL-terminator checks) and see
> if that overflows or not. Since it's a fractional part it must have less
> than 20 (decimal) digits there, so we check the rv (or how many digits
> were parsed successfully) and compare to 20. If it's more, we got too many
> decimal digits.

For overflow it checks the KSTRTOX_OVERFLOW flag and leverages check_mul_overflow()
and check_add_overflow() when combining fractional and integer parts. The amount
of characters is not really important there. The scale cannot be bigger than 19 and
that makes sure that int_pow() does not overflow. The code uses _parse_integer_limit()
due to the nature of input and to avoid 64-bit division, kstrtoull() at any point
(parsing integer or fractional parts) does not make much sense.

> 
> Maybe I'm missing these checks already performed?
> 
> > > Having the test cases is a big benefit, and that part I like the most.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

-- 
Kind regards,

Rodrigo Alencar
