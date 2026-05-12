Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471B23D9697
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 17:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778606783; cv=none; b=e2X7XpGAO05lb2hDpzkjOC2ttjBs02VFIaWV2IhV4bJj/1xweQC6aVr2JEPrGDu1E3uQAeChuO+nM0nFPg4wK3GTW0ctFcAjVrzf1siBOx1xeR+3RpJb3fl4B7rNZ7iAw4gUAmxSMyTjvyLlB21PULxLNU3zHznciLDAfeB3J58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778606783; c=relaxed/simple;
	bh=GH4ZvXtK3C8jRIe/KpqWaX2kA5XQXR1LOJFoNrOPCZ0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=reA+lJQj+9W25/PcQmSF9k1qT8B2j3jM9yEPXkce84r3MYHFFi6uJnthqxFC83viQsuFg227ezZMCti/ShpgMISVqTbnBie22B8qrT1jzwmQX+AaBHvfRcs4c1smtTNx1YzyFss3zBPATMLFXo5EvErOPpZS89sD034ExofLgGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5wlrUP3; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5wlrUP3"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-67b6da5a618so8253522a12.2
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 10:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778606780; x=1779211580; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=es0fhfjsZJa+c9pGkN+xW7Ugn5fzPzkcUIdpFAi88WM=;
        b=l5wlrUP3gLlOeTCY105b3pu05JHAoTfN2uPsPj/PCrLj+7wFnkZ4tg6oeEQsgsOU1d
         Q4MaXtFuVnudW7qQVWdUEH5XQz7lb9VgWR2JKPl5FRu0RuxyvgcADbQOVKKxOzLqd6wi
         kXEgauDJLSmOEigfwB//m7GJpFeIjw6H7YiZnCxqpkqRP6cPz2iSocpstUPKsYWwUVoF
         IWb2jq/UvSo8KJ4LIK0UlVbpy7exlY1j8OMB1FZpgLYFaOjl0D9yElrGN9aeM4ilwt4f
         vOIpBgEmW6jfdD2+yX/O0HDi3OwUohp3afPSJG5XJkQbSEzcr1q2RtyLE0JSCu8gl302
         Wiqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778606780; x=1779211580;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=es0fhfjsZJa+c9pGkN+xW7Ugn5fzPzkcUIdpFAi88WM=;
        b=RvIoWR2vYXtqBkX76p2wfNj53vc7gRspHGhSHl7wfqlcYJOrQWCa5kct1RHdZi86y+
         ASR2uNwvKGWcB8a1kEXWkOgj+FBqu/sposPlX3vxl4mz66P0OkhGSg+lpf3xjIbnv6wk
         RuqWL+CCR5ANfYDSSM9aigzBuxqs5Tqv7Oq/TYueePO3JlKbYGDqqAsLRY39S9rHxuo8
         OLR9KRkz/j5nTA5fJAR/toNe01t/mBTQ454JY5ExuNF7nK/YTwxqi+HNA280daFRsmt5
         mlD1GJ00Ka8n7GvyEp5jQ2PMswzV1nS7H3WKCxIBjT1uxumPqcw0uGwy24ax4tjd39pj
         lzHg==
X-Forwarded-Encrypted: i=1; AFNElJ9ByjAUbLSahOy96bzXz38OyeabAAKaGVnFSl92WhKDellY1yAFJ4XVAe8hsPfZx2dbTwgQjJhcghc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJfzTllPFS6EA3mZ4Lvmckxgr9io7U1LHpHqhdqeAom4isL0p8
	HG66LrKG5hD7FQjDYysfwqgDnZFa9mPrlAc0KDs6zuujqAonq7iNjY+U
X-Gm-Gg: Acq92OFJCI5dcwvKW6YBKi0BSsEEJTnqtOxQT3J6jFUwVO4Th20mnq8fPZmCQ8iYQxG
	WxaWxrN65TMdS1jPO2G3rAg1uPNOETWbI6HCgBNbIKeWGKPZKnMyzUQvfb5E0RdDrEhsT/YAgZC
	5kkd1IuNCm3UftDX0PImeyL/uv4czu7cZW887moLBdjnhdCrXcpdVf7x0Klq5AnGcEy8PyrVKif
	0c4p/s8GwnyNCkhiZCJhbG7G6Lk7r+NozXHFMkTufFaeF8J9nSq2sJkmRMiaSP35NoslwWvf5PA
	xhdsg7r31ogSFwILluSE0IfwrmLUed8/ik3XTnU0taxHC+TxahLK/F/i/ovraxpCWwKMt/qIlmD
	4uuGQAAk00kFVGmZ6DLOXrL58o0VfFMaBJC+CVKf+GTMbWdylEFT5m6Jbjs67p6Jd9aTmK6IjyI
	0Rp4agACKP5OEES525zXyNn9wWO9whl6Dg/58uwIFGi5g60SC6UaLs8JBCjDN6hzl8vaU8eoTYA
	11BXhHS91rA8r5QC+1tHh5ydLOdpk9Foxe8vVNVTHGnc9VyIw==
X-Received: by 2002:a05:6402:1f86:b0:670:ef2a:217e with SMTP id 4fb4d7f45d1cf-67f6f91cd8emr8443896a12.0.1778606779530;
        Tue, 12 May 2026 10:26:19 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67ef0e0d132sm5340609a12.20.2026.05.12.10.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 10:26:18 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Tue, 12 May 2026 18:26:12 +0100
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
Message-ID: <ru2h3ip7qf6j54dlrij54nwp45uyq6m2e6zspt6v6eynpsagqq@eo5v3yparuhh>
References: <20260512123953.40d80bc9@jic23-huawei>
 <agMnWzMjW1LwCSyT@ashevche-desk.local>
 <sj6cpjhakyfvv6rgox6cnhl2u2tgaecugcok6fw2l7zgku5wtc@aqx3ul72vgca>
 <agMvlS3-0wvGmBwh@ashevche-desk.local>
 <dxjg2sdyxb7ieb4abmeyyye7qok6cczrxabpsjyjhcbehwoec3@sbbqoo4wmzre>
 <agM8pWrM6j_XksvN@ashevche-desk.local>
 <ur6brs3yjzyb4mtelabmcglxjltddqvjxtgl3lkdkmbjlkmnsq@bwd6rz7gided>
 <CAHp75VeoH3yVfp8NWjKfc_df0VRLkyf_SK4e==-wJOEodVjW_A@mail.gmail.com>
 <q4rmlkgecvztnvjg7b7wtqyvhdy7uxgaouvhae2mlsxaasasbf@dfakp4m5l5sl>
 <agNfqiZpGZAM-x_H@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <agNfqiZpGZAM-x_H@ashevche-desk.local>

On 26/05/12 08:13PM, Andy Shevchenko wrote:
> On Tue, May 12, 2026 at 05:35:59PM +0100, Rodrigo Alencar wrote:
> > On 26/05/12 06:21PM, Andy Shevchenko wrote:
> > > On Tue, May 12, 2026 at 6:11 PM Rodrigo Alencar
> > > <455.rodrigo.alencar@gmail.com> wrote:
> > > > On 26/05/12 05:43PM, Andy Shevchenko wrote:
> > > > > On Tue, May 12, 2026 at 03:12:24PM +0100, Rodrigo Alencar wrote:
> > > > > > On 26/05/12 04:48PM, Andy Shevchenko wrote:
> > > > > > > On Tue, May 12, 2026 at 02:21:14PM +0100, Rodrigo Alencar wrote:
> > > > > > > > On 26/05/12 04:12PM, Andy Shevchenko wrote:
> > > > > > > > > On Tue, May 12, 2026 at 12:39:53PM +0100, Jonathan Cameron wrote:
> > > > > > > > > > On Sun, 10 May 2026 13:42:20 +0100
> > > > > > > > > > Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> > > > > > > > > >
> > > > > > > > > > > Add helpers that parses decimal numbers into 64-bit number, i.e., decimal
> > > > > > > > > > > point numbers with pre-defined scale are parsed into a 64-bit value (fixed
> > > > > > > > > > > precision). After the decimal point, digits beyond the specified scale
> > > > > > > > > > > are ignored.
> > > > > > > > > >
> > > > > > > > > > Whilst Rodrigo has already replied to say there will be another version
> > > > > > > > > > I'd like to request final feedback from those who were involved in the parser
> > > > > > > > > > discussions.
> > > > > > > > > >
> > > > > > > > > > They got very involved and I'm far from an expert in the right way to do
> > > > > > > > > > this stuff.
> > > > > > > > > >
> > > > > > > > > > I don't think David Laight was +CC so I've added that.
> > > > > > > > > > David, Andy - I think you two were most involved in that discussion:
> > > > > > > > > > Any objections to the end result?
> > > > > > > > >
> > > > > > > > > I already said a few times about the naming. I do not like the kstrto*()
> > > > > > > > > be semantically different on how they treat the input. Second point is
> > > > > > > > > to avoid code duplication, but this one is less of a concern since the
> > > > > > > > > new code is in the library close to the other potentially duplicate code
> > > > > > > > > piece and hence can be addressed later.
> > > > > > > >
> > > > > > > > I suppose I reached into kstrtodec64() and kstrtoudec64() because it aligns
> > > > > > > > with your expectations for kstrto*() semantics, no? Those include:
> > > > > > > >  - overflow check;
> > > > > > > >  - extensive input validation;
> > > > > > > >  - optional '\n' in the end;
> > > > > > > >  - mandatory nul-termination.
> > > > > > > >
> > > > > > > > am I missing anything?
> > > > > > >
> > > > > > > When we add scale we basically make that not true. Moreover the code in this
> > > > > > > patch makes scale == number_of_characters which I think a bit fragile, however
> > > > > > > it's about the fractional part when the amount of digits is equal to scale.
> > > > > >
> > > > > > That is not really the case. It is being set as a limit, so it does check for
> > > > > > truncation and zero-padding.
> > > > >
> > > > > I do not see it happens in _parse_integer_limit(). It doesn't try to parse more
> > > > > characters than it's requested in max_chars. It doesn't check if there are more
> > > > > character nor their converted values.
> > > > >
> > > > > > > To make this work as expected we need to add an additional call like
> > > > > > > kstrtoull() (and perhaps drop that \n and NUL-terminator checks) and see
> > > > > > > if that overflows or not. Since it's a fractional part it must have less
> > > > > > > than 20 (decimal) digits there, so we check the rv (or how many digits
> > > > > > > were parsed successfully) and compare to 20. If it's more, we got too many
> > > > > > > decimal digits.
> > > > > >
> > > > > > For overflow it checks the KSTRTOX_OVERFLOW flag and leverages check_mul_overflow()
> > > > > > and check_add_overflow() when combining fractional and integer parts. The amount
> > > > > > of characters is not really important there. The scale cannot be bigger than 19 and
> > > > > > that makes sure that int_pow() does not overflow. The code uses _parse_integer_limit()
> > > > > > due to the nature of input and to avoid 64-bit division, kstrtoull() at any point
> > > > > > (parsing integer or fractional parts) does not make much sense.
> > > > >
> > > > > Under 'like kstrotoull()' I meant something that repeats needed functionality.
> > > > > I believe it's parse_integer() (without limit).
> > > >
> > > > I think we are going in circles here and we could look at the code instead:
> > > > - integer parsing with _parse_integer()
> > > >         - overflow check and validation of the return value
> > > > - fractional parsing with _parse_integer_limit()
> > > >         - overflow check and validation of the return value
> > > 
> > > No, this is not fully true. That's what my whole point is about. The
> > > max_chars parameter limits the input check, then it skips an arbitrary
> > > number of digits and only *then* it checks for \n and \0. What will be
> > > the result of the
> > > 0.00000000000000000000000000000000423 in your case? Whatever scale you
> > > gave it will return 0 without checking on how many digits were
> > > supplied.
> > 
> > I suppose that is a valid input and 0 is the expected result there.
> > 
> > > All the same for 0.9999999999999999999999999999999000423. My
> > > point is that we should limit this by 19 digits.
> > 
> > why we need to limit by 19? Digits beyond the scale carry no value...
> 
> ...only if they are all 0:s.

I thought your concern was on input length.
 
> > just like leading zeros to the integer part (which is also accepted by
> > kstrtoull() when parsing with base 10). Not sure why this is invalid input.
> 
> See above. I agree on truncating trailing 0:s as it's done for leading ones
> in integer part, but if any of the digit behind 19th is not 0, it's an overflow
> condition (or bad input, depending how strict the rules are).

stating in the documentation that digits beyond the scale are ignored is not
enough?

> > > On top of that, what about -0.9(19 times) ? the fraction should be u64
> > > in this case and it's fine. The sign applies to the combined value.
> > 
> > yes, range for signed values are verified later.
> 
> > > >         - extra scaling and truncation happening outside if needed.
> > > 
> > > Right, but the given input may be way too long and still needs more validation.
> > 
> > What is the problem with a long input of digits?
> > C compiler does not complain about this when parsing a float value,
> > python does not
> > complain about this when parsing floats or decimals either.
> 
> Because there is an exponent limit and for double it's something like 1e307
> IIRC, meaning, try 1024 digits to be sure.
> 
> Python most likely uses the library for big numbers, you can't compare it at all with this.

You would be fine if the truncation loop:

while (isdigit(*s)) /* truncate */
	s++;

is bounded by (19-scale) iteration count? or it should keep iterating if those are zero?

is that the only concern? Again, the usage of _parse_integer_limit(s, 10, &_frac, scale)
avoids a 64-bit division when checking the rv.

> > > > - check for input termination
> > > > - combination of integer and fractional parts with check_mul_overflow() and check_add_overflow()
> > > >
> > > > > > > Maybe I'm missing these checks already performed?
> > > > > > >
> > > > > > > > > Having the test cases is a big benefit, and that part I like the most.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

-- 
Kind regards,

Rodrigo Alencar
