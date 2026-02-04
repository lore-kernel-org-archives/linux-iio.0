Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E523B5304
	for <linux-iio@vger.kernel.org>; Wed,  4 Feb 2026 09:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770198181; cv=none; b=gwdUoJ5u4kT0HwR0g1I7byeJrZ6NUleBcH66bcLhISF4gZ20iecOnJQY6xi3ciD1bl9D4ajsGHVl0DhX1UD0VxXxpPwwy6hMTq/Ys7C0jHzrjCMue+uF/lQ5fomPh3Fv+21QB1I59sZea5vKsgV5uK5mz5wDVA1y664MZMaZtWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770198181; c=relaxed/simple;
	bh=hGwBf1cUBZVW0moEL2wbt4+Dz7qCO/Yl0iuemeryZME=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXv1uZM5yc3+Heb6p37Bu4urJ9I+nPvFuBz0c/awarxDHQmU0yrLZ9KWkKZMhQUWDcslkAROp6K5SUV+PW9w4Smo99LUY/J71fAYMtmbvsse1nY6jytBWS39uzEF7PQng6Sj5qv1Ue36Fvl/7Vi1lgtzID4Jq4GIx4/0LJTaKvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gsUc+u/v; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsUc+u/v"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-435a11957f6so5126086f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 04 Feb 2026 01:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770198180; x=1770802980; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s6noyEhcNwk/Aw3tl3/LJ2DrKHWXMyz7JjWPgqeEx4o=;
        b=gsUc+u/vtiNTkp9t7nP06pMtgtzz7q3dAWjPNuYNpbCLA8FFkTuoXlqh9pjxp1m9i0
         pd/DyxUr26ND8EoErfFGCkKN2mY0ynopnX9tluDGUG5lg5T3Eiz4SSypA3qaJbXL0BMF
         4A+dLTGDN3P76vBUv7eVmI/vjjtiOkt+ClOzuivj6kGHEIPVrwXLZDVbf+ieXcyInZP9
         1SoHCMa5ca75AHg8ypzP/rsAfuf72NrSGTHGlYTl5QsfxRgCBD6bWSem91LkVLnqyO0I
         ou/tZNwPejpq/koqlhmpHiAqfZ8Je94dR+xzHF/Yq7JyItPYVYB7sAu+5ANuZSNGEcmw
         bnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770198180; x=1770802980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s6noyEhcNwk/Aw3tl3/LJ2DrKHWXMyz7JjWPgqeEx4o=;
        b=eN/LwTIOPeo14u8g7NaO/aH8D65xK6f4TWjv0Bw3H7ZIOBQoS3yIiTleXk6j1W26Yn
         b8pSaHRFw7+LjgwNzdzabbndGd5IQAemvM5VdzZe7Zf5dgFufNQWi/Cy5EE2Meq64/vN
         PfHLRbnwSm7opCnPB2udGgNBgFiQ01JG8Jdmog8FDfKTOANbGX8gPA8BnwoYveL6KMQu
         cyRHomDiYBRaV67y6c+kN2td365Aq/gUsIkuehNuYdoGdRfwTtEHTYdylJFBigsg/1yu
         UcTVL6CYIs3R9nm9W6qCqJZmc3s7C+W/7MgwGADHKFcE9RpTPDAduaomw64UW66k3aG1
         82qg==
X-Forwarded-Encrypted: i=1; AJvYcCVh80tolYv0WHG45z3JMSsIyYv8vXN8PO4ClfnMmR0VW0EEg4cC7p640ddFONBpO26qiY6p44BK+qk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVE/P9fsPWs0AtVH2mEs3w17XZfdBR3ie9VJ9X5S+in+3t+X7f
	OcmouUVGrPlvYAvb+KAPO26cF5FJZNKlJrbvw5H12U0mURKkbUFmpGL2
X-Gm-Gg: AZuq6aKf2RfMDHaSzbDyUMdq1sTERQyCBBoBQ9TLqAsjyI1NI9wR6P3E0TTHHu3c9lv
	R6e96ZQG0rhD24DTW19MFqFKvF9Fob5PQ4+KN2E7f/6rPskSwQlmcj82TlDefMPueqH0OdWHZnz
	LmhkEoFuDU7Mpd3nB83EE94zAsreGb/VhzxNGkZz36F35cKIqCNTgpJ3aVi0u4vXw02egX9gVu+
	ui47J2lmu6d2LhxtOLK4dx9IJmQnSEmm1DfYIkqF87Be+8OSnngZ+thFbR+Tm7aiTyXbkkrcYWE
	W21n668nsaV+/yQ+dM858PNywwmgOip3BnkrpyNUvNfjTN/BVU+qhFf4edyE2nKuaHmEx06/0EO
	Ll0LQ5XV9/4bqOVozdG/Q8MTi88AOZv0ySoj1aUG204tp/BliXq57D8TOrwlONo5ZCaWiTaXF9F
	PuGluKgstm8lx0ijzuOJIHGNYDr6rZwYtmYRwT+/ZF31tsLJHqRWYCL3Zl1R6V1N+8N+KH/R1hr
	2Gk
X-Received: by 2002:a05:6000:400b:b0:432:a9db:f9a2 with SMTP id ffacd0b85a97d-43618053ca8mr3252156f8f.41.1770198179457;
        Wed, 04 Feb 2026 01:42:59 -0800 (PST)
Received: from RDEALENC-L01.ad.analog.com ([24.206.116.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43618057f66sm4791738f8f.25.2026.02.04.01.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 01:42:58 -0800 (PST)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Wed, 4 Feb 2026 09:42:55 +0000
To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v6 2/8] iio: core: add fixed point parsing with 64-bit
 parts
Message-ID: <7tiv33i65unu5ypk7puj3buzybykyhv2qbwp54bhcem5t4rawq@dpfedqmmxbhx>
References: <20260130-adf41513-iio-driver-v6-0-cf46239026bc@analog.com>
 <20260130-adf41513-iio-driver-v6-2-cf46239026bc@analog.com>
 <aYKkv3dq9Vkm3s_3@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYKkv3dq9Vkm3s_3@smile.fi.intel.com>

On 26/02/04 03:45AM, Andy Shevchenko wrote:
> On Fri, Jan 30, 2026 at 10:06:43AM +0000, Rodrigo Alencar via B4 Relay wrote:
> 
> > Add iio_str_to_fixpoint64() function that leverages simple_strtoull()
> > to parse numbers from a string.
> > A helper function __iio_str_to_fixpoint64() replaces
> > __iio_str_to_fixpoint() implementation, extending its usage for
> > 64-bit fixed-point parsing.

...
> > +static ssize_t iio_safe_strntou64(const char *str, const char **endp,
> > +				  u64 *result, size_t max_chars)
> > +{
> > +	u64 digit, acc = 0;
> > +	ssize_t idx = 0;
> > +
> > +	while (isdigit(str[idx]) && idx < max_chars) {
> > +		digit = str[idx] - '0';
> > +		if (unlikely(acc & (~0ull << 60))) {
> > +			if (check_mul_overflow(acc, 10, &acc) ||
> > +			    check_add_overflow(acc, digit, &acc))
> > +				return -ERANGE;
> > +		} else {
> > +			acc = acc * 10 + digit;
> > +		}
> > +		idx++;
> > +	}
> > +
> > +	*endp = str + idx;
> > +	*result = acc;
> > +	return idx;
> > +}
> 
> There is a development in the parse_integer in the lib/. I reviewed that series
> and hopefully it will go in. With that done, we better reuse the lib/ function.
> 
> https://lore.kernel.org/linux-hardening/20260202115451.290173-1-dmantipov@yandex.ru/

In this patch, I see that it updates the overflow check, but I am not
seeing that function being exposed to other kernel modules.

-- 
Kind regards,

Rodrigo Alencar
