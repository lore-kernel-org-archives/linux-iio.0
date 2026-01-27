Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F288304BCB
	for <linux-iio@vger.kernel.org>; Tue, 27 Jan 2026 10:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769509067; cv=none; b=QyoR0PEncUygfUo91MJdnVnV7AE1vQ1wuIFBKP74Z1t4Mi493oH/SzOSpupnHye5VrIXv/t7Kh/fmpCTWw32GLjk4WC7Tnfjlg2/1S/iwGZuH+CIhKp6HpS7DixgCGVoqeDbijg2XlQiiJ1wF2XGYpi48OXJ3nMeuHNnJLXR3iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769509067; c=relaxed/simple;
	bh=qWt3cUynPfSk5JuxRX7JgGEIHI65U7rCvJrsJFVxUqU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YGh5xS00Ag/2dWb6LxgLBgdkmAlqbifANiC8c952RVLyDKJBQgN16uBzv97CBFoWE2TBW7pQ+SG3VFXgwRXeFew0Fgv1lTpd9NyKXJudJtT9n+rphyX+Ywse25OmGWyiktkFj+dTmsDH4mQl5kjbIOT57qfIixCgFJi+FU5pF40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RRdmJNLU; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRdmJNLU"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47f5c2283b6so41229135e9.1
        for <linux-iio@vger.kernel.org>; Tue, 27 Jan 2026 02:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769509064; x=1770113864; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OXWOYo8vOi8BhdDTyZ7c1FfCiiZUfAcbSVo55I2nRwc=;
        b=RRdmJNLUzwgQvxMbce0nWuaNu+WhoVozti9GPkQDiP5JnSbn4CMgS8TFUjAbvZoPKJ
         FNVn+794uNjq+zvkvogHVnpJJBPoppeYniMTkvvHvLzoxwQWqP2I/m1+wX1hW2aCaUwm
         tunxG7DzBJ3aJTUvHMeWe2Xmp5diBl2G+YUcNXX3glb5+KY/a2NE+3Jga7CkM1oXK3nB
         BhfehUQ9qCSICVyQCikTGei5UZfvY70mJfnVDqKDMfFXqKB9V5Xaun4S7Cfr3cAtgRku
         YgmhyrNZOMBaPNXV7i9ugrPYa+k3w53IQHMnQY6q2085UoQFrtp5rPt5icnueNzAfmas
         8IyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769509064; x=1770113864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OXWOYo8vOi8BhdDTyZ7c1FfCiiZUfAcbSVo55I2nRwc=;
        b=QEy5pXP3mqT7Ta92RcjHBMYyysREq5/M6pkSq/O7QBqXW9kAD1qJ8cK36gyxZAS44w
         me0kv3vdwvhEU2+TCABFPVt9olBOgaemmHe6T4PQda9XXQhfqX0zObkY+6slPhQXEMt7
         33PL6uOPvGk675OYFkqRg4LfiRbrdL/QPlJEQ7+vpbdbf6Wqzv/P3DD7JfVUtF5jaYm3
         at45VGV0qKA7TnnL1Tcgc1i8rGhR/V3k5kejvgnmEPVGZpRBSbx2CQotShfYzfTkUYKJ
         Ea9jbueSskGob3KiL1tWGM1lTQZSy/17Knxdyoo3tIV0j73e87UJ7g2iWbY1v8wIEfcT
         XM1Q==
X-Forwarded-Encrypted: i=1; AJvYcCU4O2bvg3qhPBfd8xscYvz3J9vP05Su0bsbTng8GuCBF7KrVXm30cJw5bkqQxud4OSTsEHMZ3LfIbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSdrgKnOxCEmR4o6G44hzcmNpTHDCxCCQ9btY9umXgn6parmSf
	yoinv1s5C2tNmElClQFKVZNuR5akYRPPDCOF36CWLx6FtZBAmLLTOh0t
X-Gm-Gg: AZuq6aIeZI/RYg8C/irCZgiS2qovwLdgGgLHpuwSC6kWlM+wXEA9u7RWkp0N/CEW8y3
	gwG7JN0LmLpmiDSQ9S53WTdBug8sS/qlPHmLcu9a2XnxWeFlXfJsAWdzB4AB2mfi5QlEaOLSmOh
	k1qgcbWtQq2sR+vObr8TxNZ5YnA7hbvu4QCWIhe5RH08q0U8W8CxqpyszWOFOudG9YjLnFdQcMC
	Rq+sEN22yeZ34jeJwCxtgCMnc1IKbOSi5rg3HpE2LA30Ou3CqwBEGDSyZYo7wzWsxHWSyFn+ayn
	reQTaWYM9mPgX1sThqD83mAow7c/R6MalxF0BArWOIQQVLyh9oCKuFu9A3W1NnM03izDCTLTWGs
	H/rWdZ/KUOe28bxgUBMnFf+dCGs36MbpxO+cr/oSXLAAAEF4yR5SnkVqO2BfoPsW9xgJYUsLs1b
	SzXLzwqz4pacf2ON86JmcFFIF4vqMBa9Dwgqe8gey/gJ24ZoI4SpNGdGJUx9yiquyxMGCeXiNyU
	SrN
X-Received: by 2002:a05:600c:458a:b0:477:5b0a:e616 with SMTP id 5b1f17b1804b1-48069c16459mr13715265e9.5.1769509063554;
        Tue, 27 Jan 2026 02:17:43 -0800 (PST)
Received: from RDEALENC-L01.ad.analog.com ([24.206.116.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066bfb58esm53022425e9.8.2026.01.27.02.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 02:17:43 -0800 (PST)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Tue, 27 Jan 2026 10:17:33 +0000
To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Rodrigo Alencar <455.rodrigo.alencar@gmail.com>, Dmitry Antipov <dmantipov@yandex.ru>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Kees Cook <kees@kernel.org>, Petr Mladek <pmladek@suse.com>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v5 2/8] iio: core: add fixed point parsing with 64-bit
 parts
Message-ID: <bvdpwe7453udqml6rnrrgt64n3hpxcc77ygtpofuymqx56zhez@vko4me2vxotj>
References: <aXdUvRZ9NmP5Nh95@smile.fi.intel.com>
 <byitgzjli5gsq5v66topve7ip3inkk2udwhuihjdp6bknnkmos@tv226l7tek7s>
 <aXdtpkL5QUhhB_hh@smile.fi.intel.com>
 <ty6hptfh65k2rkqo6c6mg5z6vismuvyqsu3emvqarr2rbhpvcz@kn6tzjk5xi2o>
 <aXd_0uNVm8c_Fhwd@smile.fi.intel.com>
 <n2ms3esyxlegqibu4nluut3x4c4bkjxt5xrcd4gw35xxb2tipb@a2v73y25kroc>
 <shsikp7hinoxzj7pzxopvmvgpaak4dioekh4tyvns4kv6xp46f@z5vgnisqskco>
 <aXeRQ4AXmn1SxoNa@smile.fi.intel.com>
 <anhtxco52jz2ktmxlittsjuvfqybwrwgy76bjhni3j5dzx2rh2@hpzf3sfwe7hf>
 <aXhsu2DvG-5PLOEU@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXhsu2DvG-5PLOEU@smile.fi.intel.com>

On 26/01/27 09:43AM, Andy Shevchenko wrote:
> 
> Remove DT related people and ML and add others based on the links I posted
> below.
> 
> On Mon, Jan 26, 2026 at 04:55:13PM +0000, Rodrigo Alencar wrote:
> > On 26/01/26 06:07PM, Andy Shevchenko wrote:
> > > On Mon, Jan 26, 2026 at 03:30:44PM +0000, Rodrigo Alencar wrote:
> > > > On 26/01/26 03:20PM, Rodrigo Alencar wrote:
> > > > > On 26/01/26 04:53PM, Andy Shevchenko wrote:
> > > > > > On Mon, Jan 26, 2026 at 02:26:20PM +0000, Rodrigo Alencar wrote:
> 
> ...
> 
> > > > > > Why? Can you elaborate how checking amount of digits is different to
> > > > > > check_mul_overflow()?
> > > > > 
> > > > > consider U64_MAX = 18_446_744_073_709_551_615 as the limit:
> > > > > - 19_000_000_000_000_000_000 contains the same amount of digits but overflows.
> > > > > - 18_446_744_073_710_000_000 contains the same amount of digits but overflows.
> > > > > 
> > > > > to catch those cases, we need to check for the overflow, everytime we read a
> > > > > character and accumulate:
> > > > > 
> > > > > u64 acc;
> > > > > 
> > > > > while(isdigit(*str))
> > > > > 	if (check_mul_overflow(acc, 10, &acc) ||
> > > > > 	    check_add_overflow(acc, *str - '0', &acc))
> > > > > 		return -EOVERFLOW;
> > > > > 
> > > > > *res = acc;
> > > > > 
> > > > > acc can get weird results if not checked. 
> > > > 
> > > > Thinking about it again, that check could be done only in the last step
> > > > (20th for u64)
> > > 
> > > Does kstrto*() also perform only last check? I think they do for each
> > > iteration.
> > 
> > It does the following:
> > 
> > ...
> > 		if (unlikely(res & (~0ull << 60))) {
> > 			if (res > div_u64(ULLONG_MAX - val, base))
> > 				rv |= KSTRTOX_OVERFLOW;
> > 		}
> > ...
> > 
> > so overflow is checked when either one of the 4 MSbits are set.
> > 
> > for now, I am thinking of something like:
> > 
> > static ssize_t iio_safe_strtou64(const char *str, const char **endp,
> > 				 size_t max_chars, u64 *result)
> > {
> > 	u64 digit, acc = 0;
> > 	size_t idx = 0;
> > 
> > 	while (isdigit(*str) && idx < max_chars) {
> > 		digit = *str - '0';
> > 		if (unlikely(idx > 19)) {
> > 			if (check_mul_overflow(acc, 10, &acc) ||
> > 			    check_add_overflow(acc, digit, &acc))
> > 				return -EOVERFLOW;
> > 		} else {
> > 			acc = acc * 10 + digit;
> > 		}
> > 		str++;
> > 		idx++;
> > 	}
> > 
> > 	*endp = str;
> > 	*result = acc;
> > 	return idx;
> > }
> > 
> > which would help the truncation when parsing the fractional part
> > with max_chars, avoiding a div64_u64() to adjust precision:
> > 
> > ...
> > 	digit_count = iio_safe_strtou64(str, &end, SIZE_MAX, &i);
> > 	if (digit_count < 0)
> > 		return digit_count;
> > 
> > 	if (precision && *end == '.') {
> > 		str = end + 1;
> > 		digit_count = iio_safe_strtou64(str, &end, precision, &f);
> > 		if (digit_count < 0)
> > 			return digit_count;
> > 
> > 		if (digit_count < precision) /* scale up */
> > 			f *= int_pow(10, precision - digit_count);
> > 
> > 		while (isdigit(*end)) /* truncate */
> > 			end++;
> > 	}
> > ...
> > 
> > but I understand you would not like this approach, because it does not use
> > simple_strtoull() or kstrtoull(). Problem is simple_strtoull() is not
> > overflow-safe and kstrtoull() does not allow to track a pointer to end
> > of the string.
> > 
> > Given that the current implementation of iio_str_to_fixpoint() is not using
> > simple_strtoull() I am not seeing an issue with this approach.
> 
> I believe this is the goal, id est to get rid of the code duplication.
> The idea is not exactly in _using_ simple_strto*() or kstrto*(), but
> deriving the common parts that can be reused here.

Let's recap:
- The real goal here is the PLL driver implementation;
- Such driver requires 64-bit parsing because frequencies are big values
  with sub-Hz resolutions.
- IIO helpers currently does not support that, so I added the code in driver;
- Duplication and reuse of code argument is valid, so I moved the code to IIO
  core.
- Existing functions simple_strtoull() and kstrtoull() have their limitations.

About the current state of IIO core fixed-point parsing:
- Overflow-unsafe;
- Does not support 64-bit values;
- custom implementation, so does not reuse code;

> For simplicity, we
> may leave iio_str_to_fixpoint() alone for now (as you mentioned it
> doesn't share currently the code, so can be addressed later on)
> and try to provide a treewide available safe_strto*().

For simplicity, if possible, I still think the work here should be
bound to the IIO subsystem. I would like get other pepole's opinion here,
As you are increasing the scope of this patch, again.

The scope I would like to push for this work:
- Add 64-bit parsing support into IIO core;
- Add IIO kunit test for fixed point parsing;
- Get the code to be overflow-safe;

-- 
Kind regards,

Rodrigo Alencar
