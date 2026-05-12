Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B745335676B
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 18:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609727; cv=none; b=fcIFmC1jy96hdOVH19Nt3aQ2zxkZ2R2Ukr16i5fx76lbG/DlBDqjWv5UlykHOv67q6q2TEY5jze9hJHFK1fGaGCG8sW11onHVmkUrlGXg8D1PkBQWPzcqeQpZWYA81dMOgYZhaYJAECovuDVZxrDfTRtu17hMCTsFmia8ZXBRz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609727; c=relaxed/simple;
	bh=63ez6bpn0ee3Y9/Yx0MNF9bW3sCplxPbJxRgRV1/aGI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6nMkZ8SC4AMeHonlvxaNNxTC/S7M3aHVIsszbuHeSP20/bUzqlVJW+h6XAUkFBitdpl0gQEgT1uPrk7Gqq9bset0lqZmv0uOcWe+dKUcq3jgOBMBR1dnTmq1jf7z+empeGcr+PczE6xq3/bhBhjJ3tgYH2/BUazerbP2sX/LX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U3PWQ3M0; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3PWQ3M0"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-44b330c5cc6so4250433f8f.1
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 11:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778609724; x=1779214524; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1PlXVJGMds0w8If8yiULPSHXGhEffCD4GRx6tHPD/s0=;
        b=U3PWQ3M02G1EHCwCnLlZzjPkSDIN6enBMApl3yI3oZhYEr3OxB1bB2Myw/0pdFSREp
         QvXEs9A/dOoSBK1wFkHSzQf82kLPXYepAMG6Z0nPTtG/xo+zG2v09lEsPlN9V7KyBR9l
         1LDAh52WmK2BzaUv7a8uhQluNSATg3bHJOXem6Kweda0q95TjUlR7Sva75Bl7osG7SAJ
         yu0ALGh0bruMBMVcnoTDJiVAll+HVA66EIZJlBXvFzF89xoCesWxBBTseZ1rjXNoLsdV
         wAvMT9ULrn0GzRcupzzxAkbQ93/r5Ko2WfzRZgbZNK2YhmOsCueIdun+/60AkaxxOify
         A19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778609724; x=1779214524;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1PlXVJGMds0w8If8yiULPSHXGhEffCD4GRx6tHPD/s0=;
        b=Tr8qT1oyuyezJz+Q+6sSNslGPTmbUPIQ/ziZyFRJdGD4szVGONZMZL6LtJvlgV4oQq
         ednTFj7K+lFGaahhT2Br0gvx/ggZn0d3oH6BTJpQrsQy1n5J7s6gS8tEja2yiYfnO8fL
         qogXbxQd7nzPIYU4K3UXh1cdBHWPepGekryF4L+HmfGqbcpFv9pGx75DYG7dPYId6zzX
         rX/0qKsN3WKwr+gsjVnhTTm3uPFGTiNiO7jcH9ZQF0g7Wnq5Er3vURTM8ekN+hlRjkUv
         aAM/ZeCMgNWnTcS2LLfA2c2KXCl034SReOzEl/kyWiI0gdzuV6CFMuUKIcrvmBWNnZ/d
         4jLQ==
X-Forwarded-Encrypted: i=1; AFNElJ+SreRnBo5AMkSLgs4I4ecl6dlmWxFjVn6U/EEsrtyMPqIfocrSOgKPn8Z8xxCjib7G0uB/sL0qXQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YycZ2zqheL7YE7i4qEEe/634GKV3q8fV4uNbgn9PB0sNhqtGPb2
	XoZQJrUD7iUHMczTpt0mjT7+kXJY6ARK/ZxZyQ65WheVfS7M6r9IbstD
X-Gm-Gg: Acq92OH2RdruzoR9TKhFDmRM37W4IICXfukjfz9a//EM0pJOR6QLLNrzaaq87On71cw
	1gmEpsuPdp4rs3A+/oiKa0w0FmNFrvzEfMU3keTprwoYn5B5v4keEc+n6nM0sHY+LB52J2bLxdz
	FzgaPUt1HjY/j8AmPZ9O8XMleLdsCLpeZIlVoQTHeKaIdyAi1ip7vTfm3A/w46g0PHl2kr5L3Da
	xfbzokqR1PRoCq1KIXix7gzaZ8+JI31DsMWO1BwxbCDAz1Xia14KzSsFEwXU1aeoGTPN1ce3sNe
	eMsDkB87ntZTPuc+qdMZHiU4FB2KUtpVHxRwnMmdwQnR4aVQT+gCs+meNNOMpOkej0YteYFL9ak
	HycqZgCtULfeXbq/FGnPLbGpd4FtHJa/mbL4TEnKB4FXbxn67nAb2DMwFAcL/1HFJir8UfNjgiQ
	mD84E4G6K341xyhh+cuLuLgqWT/JByVuSt/qdjxSWmoJvR+tA/NfiOd5QFcZxc11bDLG8VkEv2a
	6QAy3stLRVJ2Lwb9iP1l9PZAEOKFB0K0eCWCgQma92zxSTTaQ==
X-Received: by 2002:a05:6000:2082:b0:43d:7a97:78af with SMTP id ffacd0b85a97d-4515da963d1mr45637709f8f.42.1778609723889;
        Tue, 12 May 2026 11:15:23 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-454913049ecsm33448626f8f.19.2026.05.12.11.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 11:15:23 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Tue, 12 May 2026 19:15:17 +0100
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, 
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
Message-ID: <bc7mqfgll34vyaxdtvfssgypkhyx233wd4hxfzu32rddxnolaq@rd6c3z6yu6aq>
References: <sj6cpjhakyfvv6rgox6cnhl2u2tgaecugcok6fw2l7zgku5wtc@aqx3ul72vgca>
 <agMvlS3-0wvGmBwh@ashevche-desk.local>
 <dxjg2sdyxb7ieb4abmeyyye7qok6cczrxabpsjyjhcbehwoec3@sbbqoo4wmzre>
 <agM8pWrM6j_XksvN@ashevche-desk.local>
 <ur6brs3yjzyb4mtelabmcglxjltddqvjxtgl3lkdkmbjlkmnsq@bwd6rz7gided>
 <CAHp75VeoH3yVfp8NWjKfc_df0VRLkyf_SK4e==-wJOEodVjW_A@mail.gmail.com>
 <q4rmlkgecvztnvjg7b7wtqyvhdy7uxgaouvhae2mlsxaasasbf@dfakp4m5l5sl>
 <agNfqiZpGZAM-x_H@ashevche-desk.local>
 <ru2h3ip7qf6j54dlrij54nwp45uyq6m2e6zspt6v6eynpsagqq@eo5v3yparuhh>
 <agNnfWZa9_NyLoWq@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <agNnfWZa9_NyLoWq@ashevche-desk.local>

On 26/05/12 08:46PM, Andy Shevchenko wrote:
> On Tue, May 12, 2026 at 06:26:12PM +0100, Rodrigo Alencar wrote:
> > On 26/05/12 08:13PM, Andy Shevchenko wrote:
> > > On Tue, May 12, 2026 at 05:35:59PM +0100, Rodrigo Alencar wrote:
> > > > On 26/05/12 06:21PM, Andy Shevchenko wrote:
> > > > > On Tue, May 12, 2026 at 6:11 PM Rodrigo Alencar
> > > > > <455.rodrigo.alencar@gmail.com> wrote:
> > > > > > On 26/05/12 05:43PM, Andy Shevchenko wrote:
> > > > > > > On Tue, May 12, 2026 at 03:12:24PM +0100, Rodrigo Alencar wrote:
> > > > > > > > On 26/05/12 04:48PM, Andy Shevchenko wrote:
> > > > > > > > > On Tue, May 12, 2026 at 02:21:14PM +0100, Rodrigo Alencar wrote:
> > > > > > > > > > On 26/05/12 04:12PM, Andy Shevchenko wrote:
> > > > > > > > > > > On Tue, May 12, 2026 at 12:39:53PM +0100, Jonathan Cameron wrote:
> > > > > > > > > > > > On Sun, 10 May 2026 13:42:20 +0100
> > > > > > > > > > > > Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > > Add helpers that parses decimal numbers into 64-bit number, i.e., decimal
> > > > > > > > > > > > > point numbers with pre-defined scale are parsed into a 64-bit value (fixed
> > > > > > > > > > > > > precision). After the decimal point, digits beyond the specified scale
> > > > > > > > > > > > > are ignored.

...

> > > > > > I think we are going in circles here and we could look at the code instead:
> > > > > > - integer parsing with _parse_integer()
> > > > > >         - overflow check and validation of the return value
> > > > > > - fractional parsing with _parse_integer_limit()
> > > > > >         - overflow check and validation of the return value
> > > > > 
> > > > > No, this is not fully true. That's what my whole point is about. The
> > > > > max_chars parameter limits the input check, then it skips an arbitrary
> > > > > number of digits and only *then* it checks for \n and \0. What will be
> > > > > the result of the
> > > > > 0.00000000000000000000000000000000423 in your case? Whatever scale you
> > > > > gave it will return 0 without checking on how many digits were
> > > > > supplied.
> > > > 
> > > > I suppose that is a valid input and 0 is the expected result there.
> > > > 
> > > > > All the same for 0.9999999999999999999999999999999000423. My
> > > > > point is that we should limit this by 19 digits.
> > > > 
> > > > why we need to limit by 19? Digits beyond the scale carry no value...
> > > 
> > > ...only if they are all 0:s.
> > 
> > I thought your concern was on input length.
> 
> One of, since I think you rose the topic of leading 0:s for integers and
> I agreed with that which makes sense to have mirrored in fractional part.
> 
> > > > just like leading zeros to the integer part (which is also accepted by
> > > > kstrtoull() when parsing with base 10). Not sure why this is invalid input.
> > > 
> > > See above. I agree on truncating trailing 0:s as it's done for leading ones
> > > in integer part, but if any of the digit behind 19th is not 0, it's an overflow
> > > condition (or bad input, depending how strict the rules are).
> > 
> > stating in the documentation that digits beyond the scale are ignored is not
> > enough?
> 
> It's in case we are not for kstrto*() family. My understanding that kstrto*()
> use strict rules on the input in overflow check.
> 
> > > > > On top of that, what about -0.9(19 times) ? the fraction should be u64
> > > > > in this case and it's fine. The sign applies to the combined value.
> > > > 
> > > > yes, range for signed values are verified later.
> > > 
> > > > > >         - extra scaling and truncation happening outside if needed.
> > > > > 
> > > > > Right, but the given input may be way too long and still needs more validation.
> > > > 
> > > > What is the problem with a long input of digits?
> > > > C compiler does not complain about this when parsing a float value,
> > > > python does not
> > > > complain about this when parsing floats or decimals either.
> > > 
> > > Because there is an exponent limit and for double it's something like 1e307
> > > IIRC, meaning, try 1024 digits to be sure.
> > > 
> > > Python most likely uses the library for big numbers, you can't compare it at all with this.
> > 
> > You would be fine if the truncation loop:
> > 
> > while (isdigit(*s)) /* truncate */
> > 	s++;
> > 
> > is bounded by (19-scale) iteration count? or it should keep iterating if those are zero?
> 
> Ideally both.
> 
> We don't care about the digits in the range of 19-scale and skip all 0:s after
> that.
> 
> 	/* truncate unrequired digits within type limit, i.e. 19 decimal digits */
> 	while (isdigit(*s) && "(s - pos_of_dot) is less than 19")
> 		s++;
> 	while (s == '0') /* truncate trailing 0:s, it's not a bad input nor overflow */
> 		s++;

We could have agreed on something like that since the beginning!
And I think that changing the logic to something like this would not change a
thing on the kind of inputs we expect, it will just complicate the code.
I suppose that kind of kstrto*() rules were never stated anywhere.

                           |> 20th digit 
Also, 0.00000000000000000001 still sounds like a valid decimal number to me, even
though it is going to be parsed as 0!

> 
> 	// Now if it's not \0 nor \n and
> 	//	a) still a digit consider either overflow or bad input,
> 	//	b) if not a digit, consider as bad input.
> 
> In a) I tend to be on par with the other k*() and consider that as overflow.
> 
> > is that the only concern? Again, the usage of _parse_integer_limit(s, 10, &_frac, scale)
> > avoids a 64-bit division when checking the rv.
> 
> I'm not against usage of _parse_integer_limit(), I'm for stricter rules on the input.
> With the above addressed, I have no more concerns.

Thanks! I will proceed with the requested adjustments.

...

-- 
Kind regards,

Rodrigo Alencar
