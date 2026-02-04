Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD903D9052
	for <linux-iio@vger.kernel.org>; Wed,  4 Feb 2026 10:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770200896; cv=none; b=nmXBERyx9Cc/lDoKqUvQ6oe7pkybEFVarLlIIl62L5wOfnX+bCLdB+lJpUKGPx+leRz1xd+CEIzreNydIu0ZDW7DeSrHt9U6515QjU/RJNB1zsTUMmALRd4GBHDtl+X+UBMdwEqP9iWh98wEO2EdF+Ld5wuhlDsglXTeisR6qaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770200896; c=relaxed/simple;
	bh=JolnKv0qFTOR+o7MUsErJAFOJkrET4c/BlgelBkXp+E=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+T3NWW8fuS6l/NGGK9xooxGvhkzK343h90/fjOfB+7q3aYMzlAn8VW6/ejczSHkCVUcYkryvHj17Yc2kQZ568NtHmV5QpdeDVDcbAVQA/a9ciOsLqSyioVVGzBrqd4Oj9v8de8XWbOsnVlzonxl2ZdfLjP6ZAR9LtACrkeUmvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TsY8mwjV; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsY8mwjV"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-483100e97d8so3586565e9.2
        for <linux-iio@vger.kernel.org>; Wed, 04 Feb 2026 02:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770200895; x=1770805695; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JYjG7SQO8WEcZbtf5VFi69+C3kGp/XbrFnd6F1SB62M=;
        b=TsY8mwjVOlERyLMY4xZcL4FpfW2PC0FXYp2YORrLpKNQAFvrDqA9Pv48o6hL9jCRxG
         ZMXuemwqTxc+RH7GIPsI3WFUfRWKAb6SpGf4EY4O1n6o/cEcG5vTdJnTNtPw7mgxUWb6
         3HClgwFLhovEYkHr+EvQObn1U8ZFSjrZwruTVQmOZbkkkDg8h9bN9oybHLzY0iUeYa2n
         Jaly9/P13T98296deoooscmmE6uIKWGYmLYjGQuICWESIgdVTERmh7WcTeKZDlp4Qigz
         ITF8HT5YhFaBbGIYR7sDw1gEYKigBErj2ITge1JKv7mCxpIsALT8PkQ4PIDnDJf314Pz
         TnVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770200895; x=1770805695;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JYjG7SQO8WEcZbtf5VFi69+C3kGp/XbrFnd6F1SB62M=;
        b=UECip3WLf2Fq4zRGoQb5x3C91bB5nlaFWS+yDgmeHK8c4ZsOKmJoofgEygViQBKqRL
         b82jP/DJoQdjQvoEknWGw//1WwpWcN0ApnWvPg6p5gqiwMo5I3nhXXQXi64wj5INDS/g
         eC0NHQnjZXBgFaY6vVffseD7KnosWWExzyHSpF4LnZha0jzzEdIKTdO1Wq/+V/fhuozX
         jIloBIKp6lEmJLMNN84MB8kiQp6EEknPnd8iCQAGMFQfJkIzIdVw/dUtmQEfWiDYNcFa
         W/fxBdZpa9Z1J9rNlE4PFFzBxteSDC97RHdC/HR4D5wd8vRKuXjwJzMNmh1ju89Xi7Hb
         7UWw==
X-Forwarded-Encrypted: i=1; AJvYcCWaIWlN+7QVKHAZDQltPmOEFTdifKn+YF4pJjW1xcNCnppH9uM3ZgyOUET8Swxf6nXXwMl7xKJBhYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsJYF/8HcaXCnfEBhMW2TEJNxRlyCd2zdQNGYo7oHUcjHKvNr3
	wlCMZjVSNSXTHqVCvgl2lCiTg+gqEd7okPlqksNzV9ZMotkmUuF/HjaX
X-Gm-Gg: AZuq6aJ3HriEpeQ92aCH+5LcHR3/F6hqTr/aiEQDa9wxM0z2MUThFBB4g1Kgf89a0/r
	TT48Wt2hGV9JqIiq2UDTViaYallXYjf4WBJjl8wZoXoyTtKh/PIVkkDBzvqCFH+61vPPmXbNOO9
	5vCnVhPLfTjXap94QZXhWF14/xnJt4cKop7GBVe5X7ayARr2bWp5s1i25FzEeihIF2H9gR2BzWd
	NMZKFpEARrWeg7kTYyLoFZA208MyTOD+9Ld1aotrKFf1EmHodospRSrQ4z7Tkek/MyTZpKYfyo5
	SE9GA/wLTi+d91MBEaA4DQro8cqR6QNe+8L4MynURQ2l0pC/bX0hcIkXAIUZS9EX+s9WNRID6yz
	Ip4CYovGuW1u9/kvsUDJrKTZ9xLyEoPzOdHm/Qe9zN49Z8BXoAsnbwXQbdMRc6qkVhSepsz33em
	nf/WD1egT4WSg2CJ/yaKnFF4UrKyEQx3yVHRovPam8W+K+su67PqLX/4wlyRicYDUZRLu1fsxIm
	AzZ26XCkO2eUoQ=
X-Received: by 2002:a05:600c:35cb:b0:45c:4470:271c with SMTP id 5b1f17b1804b1-4830e968e72mr35786535e9.18.1770200894603;
        Wed, 04 Feb 2026 02:28:14 -0800 (PST)
Received: from RDEALENC-L01.ad.analog.com ([24.206.116.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830ec5cc24sm25090045e9.3.2026.02.04.02.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 02:28:13 -0800 (PST)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Wed, 4 Feb 2026 10:28:05 +0000
To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v6 2/8] iio: core: add fixed point parsing with 64-bit
 parts
Message-ID: <hrhgmum6zdww7etc6ztchivfqecaaqeeul2bbagzyongkxpaeh@q7x4popwel6d>
References: <20260130-adf41513-iio-driver-v6-0-cf46239026bc@analog.com>
 <20260130-adf41513-iio-driver-v6-2-cf46239026bc@analog.com>
 <aYKkv3dq9Vkm3s_3@smile.fi.intel.com>
 <7tiv33i65unu5ypk7puj3buzybykyhv2qbwp54bhcem5t4rawq@dpfedqmmxbhx>
 <aYMYJppigidPeLH4@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYMYJppigidPeLH4@smile.fi.intel.com>

On 26/02/04 11:57AM, Andy Shevchenko wrote:
> On Wed, Feb 04, 2026 at 09:42:55AM +0000, Rodrigo Alencar wrote:
> > On 26/02/04 03:45AM, Andy Shevchenko wrote:
> > > On Fri, Jan 30, 2026 at 10:06:43AM +0000, Rodrigo Alencar via B4 Relay wrote:
> 
> ...
> 
> > > > +static ssize_t iio_safe_strntou64(const char *str, const char **endp,
> > > > +				  u64 *result, size_t max_chars)
> > > > +{
> > > > +	u64 digit, acc = 0;
> > > > +	ssize_t idx = 0;
> > > > +
> > > > +	while (isdigit(str[idx]) && idx < max_chars) {
> > > > +		digit = str[idx] - '0';
> > > > +		if (unlikely(acc & (~0ull << 60))) {
> > > > +			if (check_mul_overflow(acc, 10, &acc) ||
> > > > +			    check_add_overflow(acc, digit, &acc))
> > > > +				return -ERANGE;
> > > > +		} else {
> > > > +			acc = acc * 10 + digit;
> > > > +		}
> > > > +		idx++;
> > > > +	}
> > > > +
> > > > +	*endp = str + idx;
> > > > +	*result = acc;
> > > > +	return idx;
> > > > +}
> > > 
> > > There is a development in the parse_integer in the lib/. I reviewed that series
> > > and hopefully it will go in. With that done, we better reuse the lib/ function.
> > > 
> > > https://lore.kernel.org/linux-hardening/20260202115451.290173-1-dmantipov@yandex.ru/
> > 
> > In this patch, I see that it updates the overflow check, but I am not
> > seeing that function being exposed to other kernel modules.
> 
> Can the IIO be compiled as a module? If so, then we would need to export that
> function. (Note, we may export only for the exact module(s) in question, so
> nobody else will be able to use it. See EXPORT_SYMBOL_FOR_MODULES() macro.)

Yes, one can have an industrialio.ko.
Then, would it be fine to use:

EXPORT_SYMBOL_FOR_MODULES(_parse_integer_limit, "industrialio");

in lib/kstrtox.c; and:

#include "../../lib/kstrtox.h"

in drivers/iio/industrialio-core.c

that does not look pretty.

-- 
Kind regards,

Rodrigo Alencar
