Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483A434DCD2
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 09:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779009031; cv=none; b=XjoXsmbElPEGXxWVfB6luZ/6hQzeInnBgAVpR/voTfkQ0zageIMY2oaYVe8l0N41zi/Cos/Wpp5Wl1CO3eky5iJrAPiiXpG7NJ4b00sSwsoC8dNGgLIusTS8eO8Nhfuwx7dvcg6UejF5WyXGHBLOAV5jiOe2+iTs6Hb66PjIxAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779009031; c=relaxed/simple;
	bh=giZbbwb+KGFykexkY9wTcBPAz1X8drfgDFb3/DVXeog=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVBuVuuh/l2KtQHwYx5ap8z4W+aOm7tYh3YWF/HgWdfhcyBZ+YrSqRM53nHWa73tScbKiQEZzmi7wM6/pyNJBW6S9AlLRzw5FetGui5NmnDj8bB4F/eFswqh6XooH0Th1D5Nt5zwwzak1IOk1mHKbczs9EanSAP1n/ytbjWF2u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YdF2IBdZ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdF2IBdZ"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso6693555e9.0
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 02:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779009029; x=1779613829; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LhmWRu1kAEOhlZEB2pEFFWdT70xT8IhgyYEkSNuFaIY=;
        b=YdF2IBdZWg4rU9t4PVQ3oK64oST4DZ1z8hpjIhzYOwgy7Z2EbiOag+hBR71qYb2cNh
         X0j9CMdfBXxbiMQE3T+XQQC6PIPnUXLUllM4DMf9XlBQLovZ0j59PQTdCihxGjp2hMJd
         vGtciWWyfHVhanqF0lZI5wAaoP1jOuV9EssKgn6OQnFNzmXann2K1dUIrSWDb3CZg+8g
         b9cboyitGC/EfmFUTwVegrP4O8CkrJkW9V+1fJWEhy/hFpngEG8LHWp5IQaQ6CARmEaZ
         Ypg0/1FhecElngFM0ZSuUFqHFlLixvAPcxGDPqB/HjxnM8YcZHA7n15I8r5F10Kyc1/e
         5URg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779009029; x=1779613829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LhmWRu1kAEOhlZEB2pEFFWdT70xT8IhgyYEkSNuFaIY=;
        b=WWr/fujZDU8GvPJRsgtHVdigDDTD0gYFv3VKt2fs8vIDMatJi/hrmXqg7Zsuo84yOV
         wddcoMVV2hpaEKlMIc1pEO1A1pGk5cK2vEQ43oOd9yvrt1vTL4awbSn8FMy3w4JQeMB5
         1DnaUZd13u3t9RA0oP103ovyCaFWu/2KA7fb089yMtG2jJXgNz5fF1zMrYywxf6aLMIW
         8Verib7OJe/ay0fbem7yEOHKn7ck63iG9thSpQ5ArB5CyHali777dqAPP9qH1q5setUs
         rvZ6ZkvaUFf5FtBUyhG6p9JpHV+vdGIymMLldg74GX5xaLvxkxx0NQGAFlISJp4W8oxR
         wxvw==
X-Forwarded-Encrypted: i=1; AFNElJ/0ADHT/1Be4MawJbfvWKkrIRYobdyUV/VyMRhZ2Gmw0VnJ1jtwjRUF2DDo1LsBhIltGzxM7glMAvc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx6W8nquc8GidivqdOGMDDv91ydSPA2xpSMgUqqiOxqOJa9BnJ
	qwAjEKDwc+7rmYL8W+UruTPD4U0W+/gSpHrR4Tu/BCjdq2JBRCk1Sg31
X-Gm-Gg: Acq92OHk8u4lda1ZoFTtLbumv0QzFQpHTSVLeAIFvFYAjoIqjYcpXDS16UlZr3MfT4q
	CJnFANpQPyzlZjyYYGb5Vm6F6bPv7PbkwFQiF+fUL5QCwHcNBv7pnIZ2uXGYN/NKbQNvsH9PqKP
	ohNR8ylHX1Cbb9zO528ITnqL/WV91RKI78Y2rNdT2lG2aQauHeNE+STepNHAs1/TcYQC6cjCXue
	kACTH5NB40N1HQ0HqxTFgCzZ6MmbuACPriJCu7ba0YjegvDyhlo9IK+YOXZnhX7ow1l+szZxjN8
	Iiga/4ivj75DZt3GUDkSdlI+uOi+/GpzgO5sb05ifD2eKtb7kOYtBI0MwPGlJ2IOxGUFk6RWena
	1qz7Z3s3fP1hPE+lOXnDkHt7IFcS8kSSmMm7OAW3CuWwaFvy7SyoNfu0GWUnFI45wfAv3sdGki9
	f+kUUVvKMlstvv64HU72gxZnwX6iHR0sq+o4joTbyWdz4wcbno/0PHDsYTImNqdPHGbqn6jkYj3
	8LLK3URi/Te7RJ0mGPsjeFPfrUREf7Yz1HzyyqpjD2rO1kong==
X-Received: by 2002:a05:600c:8901:b0:48e:526e:1040 with SMTP id 5b1f17b1804b1-48fe63021f9mr136814135e9.23.1779009028470;
        Sun, 17 May 2026 02:10:28 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a19b1dsm27206239f8f.17.2026.05.17.02.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 02:10:26 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Sun, 17 May 2026 10:10:21 +0100
To: David Laight <david.laight.linux@gmail.com>, 
	Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>, 
	Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v12 02/11] lib: kstrtox: add kstrtoudec64() and
 kstrtodec64()
Message-ID: <uychuflukrllg3nfzzcuu4xmfi6f4trb7326yq2lg2nrbo6zpw@xjbatdimgaal>
References: <20260510-adf41513-iio-driver-v12-0-34af2ed2779f@analog.com>
 <20260510-adf41513-iio-driver-v12-2-34af2ed2779f@analog.com>
 <kwjoyikbygik4futknqpua2tlzokradms25n2dmfa5czyj2uts@4rdfl6zlul2q>
 <ex6p5qpgsfvm5wzalpwo7whcj4m4uxzscpzxvb5ihfu2prx3fj@7skhmz3cbshw>
 <20260515202142.5dc561e0@pumpkin>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515202142.5dc561e0@pumpkin>

On 26/05/15 08:21PM, David Laight wrote:
> On Fri, 15 May 2026 17:05:06 +0100
> Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:
> 
> > On 26/05/13 10:41AM, Rodrigo Alencar wrote:
> > > On 26/05/10 01:42PM, Rodrigo Alencar via B4 Relay wrote:  
> > > > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > > 
> > > > Add helpers that parses decimal numbers into 64-bit number, i.e., decimal
> > > > point numbers with pre-defined scale are parsed into a 64-bit value (fixed
> > > > precision). After the decimal point, digits beyond the specified scale
> > > > are ignored.  
> > > 
> > > Hi Andy,
> > > 
> > > I am starting over here, the other conversation is getting hard to follow.
> > > This is my new proposal...  
> > 
> > +cc David
> 
> I just wouldn't do it this way :-)
> 
> You end up with more code than you would get if you just converted the digits.

I am not sure about having more code, most of it is reused. The rest is input
validation and scaling.

...

> > > This function now becomes:
> > > 
> > > 	static int _kstrtoudec64(const char *s, unsigned int scale, u64 *res)
> > > 	{
> > > 		u64 _res = 0;
> > > 		unsigned int rv_int, rv_frac;
> > > 

integer part is parsed here:

> > > 		rv_int = _parse_integer(s, 10, &_res);
> > > 		if (rv_int & KSTRTOX_OVERFLOW)
> > > 			return -ERANGE;
> > > 		s += rv_int;
> > > 
> > > 		if (*s == '.')
> > > 			s++; /* skip decimal point */
> > > 

fractional part is parsed here:
(combined into the result so we can just skip the decimal point)

> > > 		rv_frac = _parse_integer_limit_init(s, 10, _res, &_res, scale);
> > > 		if (rv_frac & KSTRTOX_OVERFLOW)
> > > 			return -ERANGE;
> > > 		s += rv_frac;
> > > 

input validation on the presence of digits:
(similar to checking rv in _kstrtoull())

> > > 		if (!rv_int && !rv_frac && !isdigit(*s))
> > > 			return -EINVAL; /* no digits at all */
> > > 
> > > 		while (isdigit(*s)) /* truncate digits */
> > > 			s++;
> > > 

termination requirement:

> > > 		if (*s == '\n')
> > > 			s++;
> > > 		if (*s)
> > > 			return -EINVAL;
> > > 

result is scaled according to (scale - rv_frac):

> > > 		if (_res && (scale > (19 + rv_frac) || /* log10(2^64) = 19.26 */
> > > 		    check_mul_overflow(_res, int_pow(10, scale - rv_frac), &_res)))
> > > 			return -ERANGE;
> > > 
> > > 		*res = _res;
> > > 		return 0;
> > > 	}
> > > 

That above looks straightforward to me and the tests in the next patch are thorough.

...

> > I have a v13 ready with this. I'll give it a go soon...
> > 
> 

-- 
Kind regards,

Rodrigo Alencar
