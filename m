Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511363ACA75
	for <linux-iio@vger.kernel.org>; Wed, 21 Jan 2026 09:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768988458; cv=none; b=chljbgVLAUVqJBGhF0n9T/Z9jgsNb/biz7PTWdP+gVyzam1hrSTrATuz2QojYm3ajWLjC7iThmwjxtyYkMWy20jkM9pn67Ht42y3szVY3WIu27XNeSMY2SwkVBGo1IInUjudQdPXBeqSjr8jQpvh1K06EkihqRwwEuWnoD4t7Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768988458; c=relaxed/simple;
	bh=1RwtR2YF6mIX/88P7C8QJKHXMWvNiJJrLpdcEtimbug=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s6pyfHhnG7aiQgJDJnazbDDuABxaDLtu7PmZKDobcmAqeqMqZ7JR+xF1jEvousk7uKiSFYZQP4uNYaPJIEuZITki6iXoNhLCD+jIXgGWiMZ0a9TYLLdS+OOWB/T5Tn4iUrfggjzJDdISXKfzg5H7fsnMf2ecSZ8vrhRjKY9T+RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IqWiqvl/; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqWiqvl/"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-432d2c7a8b9so5406158f8f.2
        for <linux-iio@vger.kernel.org>; Wed, 21 Jan 2026 01:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768988454; x=1769593254; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1RwtR2YF6mIX/88P7C8QJKHXMWvNiJJrLpdcEtimbug=;
        b=IqWiqvl/nnGg72ScZhYiYYR04ZrrgDQFopxD7KutFWfHt1IlPJSTYZXcohsN5OcAkG
         FwAcCHBzwIOeYkeXxlm/iH86Jg8ZoGgcge0rYUrfHn7CSBUT8TfinVkCNOOplxm3W96r
         2k1IY2ZNTWw0hSOFetiJOPtkoIBKZWuWCF/ySEPpvVIov1qYu8qTsqw+NqTMr98JBEsS
         J9XbF2hhmgHdUL3C3Rt8dOKRsrFNPNh0x2XJHXvK7TCZcgGZKgMupUdlU57aMOr/RDOp
         RQ22BmvqY3ex3GUHQt1sNCzuTbM/OjIF6GFsAfLCAAoOrNak9/l7ZNPWQguBY/8crm36
         ym1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768988454; x=1769593254;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1RwtR2YF6mIX/88P7C8QJKHXMWvNiJJrLpdcEtimbug=;
        b=hyc9Y4uoSpgEB+AJS6Ek+BuEbErP69d80GDjBdZsQ7GGXxcu9YmX4fyNXwQ8iFEc3D
         2LMBSwxG6A9BeqCeVp9/KspUq38gxZhmveetUkKmz6DHDzQhVgRbws/Z8Uc4KnhHMDKs
         4pPBo1z9HMUxPPMJ7ZWvFaZhV93EDeWaNNxs7udAqxj0dCO+xxqdg9suoEhKW6fDWP9M
         bGDETJsPq9Mko8vP7ggApAddlbPFh0piZozEvln88BJSTWeSPw3NJsCx5SO3Wbkgh2LE
         LV6pd0mKhQoyq7KNsjb5ZMC9uhmr/eBDDJTwFkwa5pp76sDDL0RZvCZaTMQO64UB7Ohf
         +aQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjqzbup06YVVSzHkHRB2HsZhDDIiRxMK75gkgdlftAJQow6OAZEmhcdKTsU0U4JzZ/vNuA7RLs+kQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze+Jg7PopMhqECxzcm+kO3JyLLReC4Fto7qkNau2+uB2Xqg1Fh
	K8+8zTXJvmoU37WeRwDx+mOG1R9QDrMjxoFkdvy9aJUGKBGaWr416D6y
X-Gm-Gg: AZuq6aIqQbGBMdw83Mv/N/LyTWc5DzrNPPicu/UeNpwm4WE6pCVq6MRoqPs5wolHOsn
	2FIAMHIdEdDY5eHeUjBL/TBpz1gYi2EMol8osERjKrGLC+7CkwkHMKC/ds/cncEkELqIWVGSGa4
	J+x4nOmiQUZN9R/JV8M53dI1UQGTJFGaHk9zNQOC0EcfNyqp9nwU8SI1bNT1dC5XvF8Tj0fxf8/
	KLdoyOxaPIIpsollNVwKdCzf0dgaqhjBnC0zsYImXOWPLNhSJEYW2l0NQD8KwB0U0u/n1PC+hfr
	MY+/mKKcTf118xXw6OK54Vh6B/pG/tJ5FjPtYoKhEV31PVX+UXd7W6F9Csb3/sBjgf7OIW/Z7qg
	FE3tkNg/1dtUDtCtvWRnhAolRGbn11wucSiXXvWnwT1Iie/91RKEp+WI+0vNC7epQBVDBZLdbpu
	3Im7xmjN+wfXbr0fqEfxU=
X-Received: by 2002:a05:6000:18a8:b0:431:864:d48f with SMTP id ffacd0b85a97d-4356a04aa5cmr27712912f8f.27.1768988454347;
        Wed, 21 Jan 2026 01:40:54 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43597ae9f37sm5713590f8f.8.2026.01.21.01.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 01:40:54 -0800 (PST)
Message-ID: <5847ac7a68fbf805b86c0ab1f7743e686350ff05.camel@gmail.com>
Subject: Re: [PATCH 00/11] iio: adc: Improve include relevance for some ADCs.
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, Andy
 Shevchenko <andy@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=	
 <nuno.sa@analog.com>, Mike Looijmans <mike.looijmans@topic.nl>, Liam Beguin
	 <liambeguin@gmail.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Ibrahim
 Tilki <Ibrahim.Tilki@analog.com>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>,  Alisa-Dariana Roman
 <alisadariana@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Wed, 21 Jan 2026 09:41:37 +0000
In-Reply-To: <20260119212110.726941-1-jic23@kernel.org>
References: <20260119212110.726941-1-jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-01-19 at 21:20 +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> So this is a continuation of experimenting with IWYU to ensure that we
> follow what I consider best practice in driver by including all
> headers that are used (subject to some slightly fuzzy rules for some
> of them standard kernel headers).
>=20
> I was focusing on cases where kernel.h was included and moving from that
> to the more specific headers. That partly explains why there were so
> many headers to add. However, it is also clear that many standard
> headers (mutex.h for example) were missing from these drivers.
>=20
> There are a few notes and questions in the individual patch descriptions,
> typically where I have either decided to ignore a recommendation or
> conversely have broken things down more finely than IWYU was doing with
> my config files.
>=20
> All comments welcome.=C2=A0 Whilst I don't consider this particular high
> priority (much of it was done in a train where I couldn't access my
> email)m I would like to provide more examples in tree of what I consider
> to the right way to do things!
>=20
> Thanks,
>=20
> Jonathan
>=20
> Jonathan Cameron (11):
> =C2=A0 iio: adc: ltc2471: Improve include relevance
> =C2=A0 iio: adc: ltc2309: Improve include relevance
> =C2=A0 iio: adc: max1027: Reorder headers into alphabetical order
> =C2=A0 iio: adc: max1027: Improve include relevance
> =C2=A0 iio: adc: max11100: Improve include relevance
> =C2=A0 iio: adc: max11410: Improve relevance of includes
> =C2=A0 iio: adc: ad4130: Improve include relevance
> =C2=A0 iio: adc: ad7124: Improve include relevance
> =C2=A0 iio: adc: ad7124: Replace device.h with more specific includes
> =C2=A0 iio: adc: ad7192: Put headers in alphabetical order
> =C2=A0 iio: adc: ad7192: Improve include relevance
>=20
> =C2=A0drivers/iio/adc/ad4130.c=C2=A0=C2=A0 | 22 ++++++++++++++++++----
> =C2=A0drivers/iio/adc/ad7124.c=C2=A0=C2=A0 | 17 +++++++++++++----
> =C2=A0drivers/iio/adc/ad7192.c=C2=A0=C2=A0 | 32 +++++++++++++++++++------=
-------
> =C2=A0drivers/iio/adc/ltc2309.c=C2=A0 |=C2=A0 9 ++++++++-
> =C2=A0drivers/iio/adc/ltc2471.c=C2=A0 |=C2=A0 8 ++++++--
> =C2=A0drivers/iio/adc/max1027.c=C2=A0 | 18 ++++++++++++++++--
> =C2=A0drivers/iio/adc/max11100.c | 11 ++++++++---
> =C2=A0drivers/iio/adc/max11410.c | 22 ++++++++++++++++++++--
> =C2=A08 files changed, 108 insertions(+), 31 deletions(-)

Just one minor comment. LGTM

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
