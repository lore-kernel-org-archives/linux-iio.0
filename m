Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5351336C9D0
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 19:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778614771; cv=none; b=gTHUBwZN1ymozTvZFVuGvc6igKSATDpIQdbaQT4NvWBzafMb439VS4zP0ppft37aVp/q+a5nhI6uWltLneV3Dzq95EGdVoxBSLWx4JWP+wpxnYhsI/X/kC6elxT2lXL8mH7mRsgpyBSnJ3W8SRwjC0vCJdVm6legnfbvTAe07Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778614771; c=relaxed/simple;
	bh=T+ZRIQYrbXkQ/sm2qmUSVp9AR5K0XHoSwQMgsySNrUo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n36290OiIKje7xsU4nQvRZGFPZPShj9HClHvsQDJHbJJ5x91dUH6eMqan5c9ikHhaZZgaQnKINiyRrM6JUWkkkvmgWH0WHOhsS0m/p63NI39/I+ZVKBer32RkfwHiHFQ0Pq3s2GuvbpN8kc07sX+O1NGuSqGNLJuF2OeWvYq6j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hB4e7fAR; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hB4e7fAR"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so100546755e9.2
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 12:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778614768; x=1779219568; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rv3Bnr19Yd7wGTXMGRn2NrXtfHL27Vg73vChMHhkHKc=;
        b=hB4e7fARLxI+BTR2PfWyLrxjhtywbqIKZ9jeriGaYQr0r8+369CoEIxFKtSkesc5C5
         vZUPcaBfl9NTjr8vZt9N6kE/r8rUxhhe7Ki4f8S6/JSnPVvOKkgqLb6PHrJ8yBgPBn1C
         n/NZhZETUJSwiFyp+OYHPg+w/4ScR9O14MY3d1XGfLe5d9Rfbtkj4rWLOuCzRuVq9zKZ
         tIL3lkRxkDKBt8b7e3XJDlapD8b5vN6chSVNt2v9hYH6b/6+6WelUDuh4JIJtoMVVqnS
         qzurqUNzAr6fEU065YkI0NlCPBUypfkGlYGLIwMta0xMnwWAWMZPs8wT27fC1vSaTpXJ
         FpEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778614768; x=1779219568;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rv3Bnr19Yd7wGTXMGRn2NrXtfHL27Vg73vChMHhkHKc=;
        b=fncCetOBv3GUXjxnfespo21rs2S1nW3IT8zqZP61AwJcXnIUCt06bHV2v3zF1RUSbO
         bsqE3Aavz+daZjY7szOVnOY+2tatZ3BJcXwhTJZOQw07CjgREciM2tYxwtA0BRf/dEfL
         2g0Qndyg3jtkq6ckNZckl/nJzp169SISxHt1cV23vBV6JKl0E5FwS/x3sZOUUIwFVWNy
         jmv59aNZurpPK2Giw9rKdYFvDLEXTdYgtt5cfCBldNSgk8oudNGp8Go+KEARFC/V4BUS
         s5BZqZ/SAD+GTpibMiIgahDf2FuePDJNX5fMDqMjKM3h+SR96yQ4iGuOBWnMhrGTIk03
         3tQw==
X-Forwarded-Encrypted: i=1; AFNElJ9I1jXQL+CeWUvORKE0a6fdJUryS/Pi4nedjCh4El6adFW/BYcpWj3A0H5pXGl4e+uoN5+FRCWEFd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJXX8AANeM2QY1aGQLymjT1apHwnNiWX0rX5J6wBPxtAFsjPGZ
	dD3F9ZtwG+15ZbH5bl/wI1gdwqkaZpvEWmZf8rJHcJpXPDzajrwRtz7g
X-Gm-Gg: Acq92OFoJlHbcilluqHFdMxjwpyMUTvRkdJH7IN+Twi26rFvaOSi/+XOHpmRlKW6IdZ
	R03Ct/lXCNKLFwG2cAr4vC3vZypkQ6TloAu3lBHRk2HSfPJMLMnDyP50hwqLTStbFnrzNypGpdx
	ymI/XpXDFhNWbuo9JWgM5dM8hWyqaRs8lAtJCjK6mlfOCG6Jc2P7uLWO9hT0iyTh51qoFEKB2Jl
	9sxgLdSFPST5pwg8LcvidOwDQddQ5e+sHwUMgkSDUjECDdUpoORQ0UorW0Guh2hJ6AtY9T8i39/
	xqv7NDy8ozmdpJDblR8LVISEVAk16wmVFJoOvMuMLzf05GLhsxGKkTBClT/oI+HjxCsHui9daW0
	fNWwKmdwJAYWa84wv7sVS0xf5JBG7pCLaO1mbaq3UcXELyMOQY9atnnQhCV9AEMwLwYc+JLEMdN
	xRCbGzewuDmJaTayS+0MfX/GLbPZu6a/+X5ysai10B29w/ZqCTrdL9Ek59QgLnMzXdgClFJFV+n
	/2LoKbJZCQVPEXVFKTWLL6AQa6tdVCQor7Qy7ogrPgmkqlJDA==
X-Received: by 2002:a05:600c:4f93:b0:485:4eaf:eb53 with SMTP id 5b1f17b1804b1-48fc9a3c76amr3588085e9.19.1778614767606;
        Tue, 12 May 2026 12:39:27 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fc8d19974sm16882915e9.2.2026.05.12.12.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 12:39:26 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Tue, 12 May 2026 20:39:21 +0100
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
Message-ID: <hvwyrb7g3ar7hzesj32zoxzqvjmdtwybamy4zxepqdbu37qvog@xnmgqhfya34f>
References: <dxjg2sdyxb7ieb4abmeyyye7qok6cczrxabpsjyjhcbehwoec3@sbbqoo4wmzre>
 <agM8pWrM6j_XksvN@ashevche-desk.local>
 <ur6brs3yjzyb4mtelabmcglxjltddqvjxtgl3lkdkmbjlkmnsq@bwd6rz7gided>
 <CAHp75VeoH3yVfp8NWjKfc_df0VRLkyf_SK4e==-wJOEodVjW_A@mail.gmail.com>
 <q4rmlkgecvztnvjg7b7wtqyvhdy7uxgaouvhae2mlsxaasasbf@dfakp4m5l5sl>
 <agNfqiZpGZAM-x_H@ashevche-desk.local>
 <ru2h3ip7qf6j54dlrij54nwp45uyq6m2e6zspt6v6eynpsagqq@eo5v3yparuhh>
 <agNnfWZa9_NyLoWq@ashevche-desk.local>
 <bc7mqfgll34vyaxdtvfssgypkhyx233wd4hxfzu32rddxnolaq@rd6c3z6yu6aq>
 <agN6onIAwG1yn5p6@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <agN6onIAwG1yn5p6@ashevche-desk.local>

On 26/05/12 10:08PM, Andy Shevchenko wrote:
> On Tue, May 12, 2026 at 07:15:17PM +0100, Rodrigo Alencar wrote:
> > On 26/05/12 08:46PM, Andy Shevchenko wrote:
> > > On Tue, May 12, 2026 at 06:26:12PM +0100, Rodrigo Alencar wrote:
> > > > On 26/05/12 08:13PM, Andy Shevchenko wrote:
> > > > > On Tue, May 12, 2026 at 05:35:59PM +0100, Rodrigo Alencar wrote:
> > > > > > On 26/05/12 06:21PM, Andy Shevchenko wrote:
> > > > > > > On Tue, May 12, 2026 at 6:11 PM Rodrigo Alencar
> > > > > > > <455.rodrigo.alencar@gmail.com> wrote:
> > > > > > > > On 26/05/12 05:43PM, Andy Shevchenko wrote:
> > > > > > > > > On Tue, May 12, 2026 at 03:12:24PM +0100, Rodrigo Alencar wrote:
> > > > > > > > > > On 26/05/12 04:48PM, Andy Shevchenko wrote:
> > > > > > > > > > > On Tue, May 12, 2026 at 02:21:14PM +0100, Rodrigo Alencar wrote:
> > > > > > > > > > > > On 26/05/12 04:12PM, Andy Shevchenko wrote:
> > > > > > > > > > > > > On Tue, May 12, 2026 at 12:39:53PM +0100, Jonathan Cameron wrote:
> > > > > > > > > > > > > > On Sun, 10 May 2026 13:42:20 +0100
> > > > > > > > > > > > > > Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Add helpers that parses decimal numbers into 64-bit number, i.e., decimal
> > > > > > > > > > > > > > > point numbers with pre-defined scale are parsed into a 64-bit value (fixed
> > > > > > > > > > > > > > > precision). After the decimal point, digits beyond the specified scale
> > > > > > > > > > > > > > > are ignored.
> 
> ...
> 
> > > > > > > > I think we are going in circles here and we could look at the code instead:
> > > > > > > > - integer parsing with _parse_integer()
> > > > > > > >         - overflow check and validation of the return value
> > > > > > > > - fractional parsing with _parse_integer_limit()
> > > > > > > >         - overflow check and validation of the return value
> > > > > > > 
> > > > > > > No, this is not fully true. That's what my whole point is about. The
> > > > > > > max_chars parameter limits the input check, then it skips an arbitrary
> > > > > > > number of digits and only *then* it checks for \n and \0. What will be
> > > > > > > the result of the
> > > > > > > 0.00000000000000000000000000000000423 in your case? Whatever scale you
> > > > > > > gave it will return 0 without checking on how many digits were
> > > > > > > supplied.
> > > > > > 
> > > > > > I suppose that is a valid input and 0 is the expected result there.
> > > > > > 
> > > > > > > All the same for 0.9999999999999999999999999999999000423. My
> > > > > > > point is that we should limit this by 19 digits.
> > > > > > 
> > > > > > why we need to limit by 19? Digits beyond the scale carry no value...
> > > > > 
> > > > > ...only if they are all 0:s.
> > > > 
> > > > I thought your concern was on input length.
> > > 
> > > One of, since I think you rose the topic of leading 0:s for integers and
> > > I agreed with that which makes sense to have mirrored in fractional part.
> > > 
> > > > > > just like leading zeros to the integer part (which is also accepted by
> > > > > > kstrtoull() when parsing with base 10). Not sure why this is invalid input.
> > > > > 
> > > > > See above. I agree on truncating trailing 0:s as it's done for leading ones
> > > > > in integer part, but if any of the digit behind 19th is not 0, it's an overflow
> > > > > condition (or bad input, depending how strict the rules are).
> > > > 
> > > > stating in the documentation that digits beyond the scale are ignored is not
> > > > enough?
> > > 
> > > It's in case we are not for kstrto*() family. My understanding that kstrto*()
> > > use strict rules on the input in overflow check.
> > > 
> > > > > > > On top of that, what about -0.9(19 times) ? the fraction should be u64
> > > > > > > in this case and it's fine. The sign applies to the combined value.
> > > > > > 
> > > > > > yes, range for signed values are verified later.
> > > > > 
> > > > > > > >         - extra scaling and truncation happening outside if needed.
> > > > > > > 
> > > > > > > Right, but the given input may be way too long and still needs more validation.
> > > > > > 
> > > > > > What is the problem with a long input of digits?
> > > > > > C compiler does not complain about this when parsing a float value,
> > > > > > python does not
> > > > > > complain about this when parsing floats or decimals either.
> > > > > 
> > > > > Because there is an exponent limit and for double it's something like 1e307
> > > > > IIRC, meaning, try 1024 digits to be sure.
> > > > > 
> > > > > Python most likely uses the library for big numbers, you can't compare it at all with this.
> > > > 
> > > > You would be fine if the truncation loop:
> > > > 
> > > > while (isdigit(*s)) /* truncate */
> > > > 	s++;
> > > > 
> > > > is bounded by (19-scale) iteration count? or it should keep iterating if those are zero?
> > > 
> > > Ideally both.
> > > 
> > > We don't care about the digits in the range of 19-scale and skip all 0:s after
> > > that.
> > > 
> > > 	/* truncate unrequired digits within type limit, i.e. 19 decimal digits */
> > > 	while (isdigit(*s) && "(s - pos_of_dot) is less than 19")
> > > 		s++;
> > > 	while (s == '0') /* truncate trailing 0:s, it's not a bad input nor overflow */
> > > 		s++;
> > 
> > We could have agreed on something like that since the beginning!
> 
> Yes, but who knew that we go to have this agreement?
> 
> > And I think that changing the logic to something like this would not change a
> > thing on the kind of inputs we expect, it will just complicate the code.
> > I suppose that kind of kstrto*() rules were never stated anywhere.
> > 
> >                            |> 20th digit 
> > Also, 0.00000000000000000001 still sounds like a valid decimal number to me, even
> > though it is going to be parsed as 0!
> 
> Hmm... It would mean that testing for 19th/20th digits is not enough... :-(
> 
> > > 
> > > 	// Now if it's not \0 nor \n and
> > > 	//	a) still a digit consider either overflow or bad input,
> > > 	//	b) if not a digit, consider as bad input.
> > > 
> > > In a) I tend to be on par with the other k*() and consider that as overflow.
> > > 
> > > > is that the only concern? Again, the usage of _parse_integer_limit(s, 10, &_frac, scale)
> > > > avoids a 64-bit division when checking the rv.
> > > 
> > > I'm not against usage of _parse_integer_limit(), I'm for stricter rules on the input.
> > > With the above addressed, I have no more concerns.
> > 
> > Thanks! I will proceed with the requested adjustments.
> 
> But it seems it's not enough as you pointed out!
> 
> So the biggest fraction we may consume in 64-bit (unsigned) value is
> 0.18446744073709551615. If we go with one digit less, the whole value
> can be
> 
> In [3]: hex(9999999999999999999)
> Out[3]: '0x8ac7230489e7ffff'
> 
> So, I don't know how we are supposed to represent values between
> -0.9223372036854775808
> -0.9999999999999999999
> in a signed type as they have bit 63 set.
> 
> The easiest way out is to limit scale to 18 (but still accept 19th digit, and
> with check for overflow even 20th up to 0.18446744073709551615). This will need
> to run _parse_integer_limit() twice (with given scale and with 20).
> 
> Can you add the respective test cases and see what is currently going on with
> them?

I can add test cases, but for the signed case the situation is:

scale = 0
	max = 9223372036854775807, min = -9223372036854775808
scale = 1
	max = 922337203685477580.7, min = -922337203685477580.8
scale = 2
	max = 92233720368547758.07, min = -92233720368547758.08
...
scale = 18
	max = 9.223372036854775807, min = -9.223372036854775808
scake = 19
	max = 0.9223372036854775807, min = -0.9223372036854775808

anything outside those ranges will give you -ERANGE. Then it depends on the scale used.

I am not representing -0.9999999999999999999 as is. The desired scale will have this
truncated. It may be -0.9999 or -0.999999 or -0.9. And this is practical for a
reasonable scale value... for pico and femto precision you still get a decent range.

-- 
Kind regards,

Rodrigo Alencar
