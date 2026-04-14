Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5639B39A7E1
	for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 10:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776160877; cv=none; b=Vzh9dzOGShE6RUxiMMUYhGqqt0VYT2axnAFyLqyiRL32c29q1j99b1duD51J+Uhn1SRdXGxUofULmM7AT1BhytoTqhm2FjwcDiTvf9Ix/MJzj5sY94oJtZpGg2G67u1ySt9/7WIvyVUEOi8vn2S3KrFvfIluwvg424nkmkR6B08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776160877; c=relaxed/simple;
	bh=TWATlZzi4X3A/WHpzDDEDpfZXW5I0qaXm1jnhT2bBQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AU0B96nAb5Wppztd6BptKqEbgkMPwPkidKGRcGw/gHotDTTIF7HvvGIwZKM8IdF5CW1WInI2LzT/4ErlynlukW8KhR+OoAVraYG+d+N3DTdO4yvNQNvWGnyijDWkn2gdSG6TknDQofoOJmFRsBf/WO33XrsqQYk9RqD5cAGev3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EhO4uBYu; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhO4uBYu"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488ba6366a7so66834815e9.0
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 03:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776160875; x=1776765675; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vod8BXIWHFvHjyIgPVqzoMi7Ge1BDJsuhw5OvwgKjQg=;
        b=EhO4uBYu+sWRH/xBkWXX/XsfNnslnF1rhdVuIElmAKeKsHDrjqY0jVfcJW9YeWDIga
         PbVvd4lY9lnKuHKbCwAnbl04JseOCIwlByJUGLu32IbiNrk9n47mpbA08MC1+nCKbIgx
         IxqCBYfLypNtzfshT7eYxMtyrRUwjgPU6NwoCgjjik2Rm+JvXPzHHdpJMHX1jkYwnXuq
         VuUbSL7c3NBeNuwhd+fBolCvYQOyd3NgZcyQCqmKWEMwTCxw4h8rBD1ju+LxetC64Rqd
         h/wIdAqRC3v0QvR+QNt7NEzX/99JMUaEHQMEgYUAhfqAtTAaa2r2GJ1phpIEjgwU5C2J
         NSsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776160875; x=1776765675;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vod8BXIWHFvHjyIgPVqzoMi7Ge1BDJsuhw5OvwgKjQg=;
        b=cGEmSTTPw8xMqWMltkkZLt9F7bZ2YxbnfLUfHv/Hj94qrb+Vg/D70Q8U220pKgQlz0
         J6WT26rVF5PRQK68JHZswCdSZ4ntefJQTRyLCur+1oOT7+mgoXgcEbE/RLStHlTmYrb/
         eZCvhBNwdudfqxEzskpbsNdoh9FfefiAieSZ12IXfTKYgUucyOBZcFkWCZYKZSArLWEL
         mlM3vPmTEWkI9SeKx2BSheNAo3g9hgNuKoSTZPf+gkrBx/yoBG9xzQmd5OMhlWVlMvKb
         Px85FjkolAj7q53JybM6C4Tv4NpXdnJDU1JrS12Wg6KpR9EnBtvrasQcklctBM8ZLGYz
         uynQ==
X-Forwarded-Encrypted: i=1; AFNElJ/oNhxYzZofYzOrhhUNX308Vrnk59x6U+NM4hCk/S0hlJr2nTUZZoL6nVNw9oNDy6OLIFVThUes02Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3CVX5DefMocTfER0tku6rPhK230B86qfEiq8XrYgseTiB05cb
	e75dRLQfeEgKAdhgtLRythpYMqRDR9cbR49ndvhhUwnmX2TNGwaokUKA
X-Gm-Gg: AeBDieux4phM2dSR1kyT8iqK/lg3/nbO/Gz4qmI817yvPSHJoNYn9dXFfM5rRzafw/c
	5wBnoYm1T/Tfo44PMEopDC3XhBMXP3CKKjbbP3CasZMRoQcxsIIAEHy5yixRJ0tj0cNT076zUvm
	yxoM0vAV/WFuqJGtiKbCTLY9tA5CqhJICgvd9hgLniwq6v1t0uhHwFLlhPZ6NGdqBogvETpGJbs
	jZbZPpV6p4fX6E+o1dar26o69czH0lSvunvhKLBXmfhCCMKrJ+wPOjGiuhgbwMCX2qbyxqwaWP/
	db+va+hObjy7gYCg11bPcAw9pqX/H8KN5EBaQnJy7cuumrd2djOG5v5sEi+fR3Y9evt2iQpOX6i
	TWsn/5dpLQwHgr0Sll/bPhTOBQo4vXVdqWpQkIiD9iHQSFgFNsAtRG5/LzWI4ok0HAIkOzQf9ov
	5iRxd0RB9kBy4/sg==
X-Received: by 2002:a05:600c:6990:b0:488:a2ac:a34c with SMTP id 5b1f17b1804b1-488d67f5bf5mr239725405e9.12.1776160874458;
        Tue, 14 Apr 2026 03:01:14 -0700 (PDT)
Received: from nsa ([45.94.208.102])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ee019d9bsm38436665e9.14.2026.04.14.03.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 03:01:13 -0700 (PDT)
Date: Tue, 14 Apr 2026 11:02:02 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Andy Shevchenko <andy.shevchenko@gmail.com>, Alisa-Dariana Roman <alisadariana@gmail.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Alisa-Dariana Roman <alisa.roman@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/1] iio: adc: ad7191: Don't check for specific errors
 when parsing properties
Message-ID: <ad4QXydZlq5L-JS7@nsa>
References: <20260219143936.2276366-1-andriy.shevchenko@linux.intel.com>
 <c59c19d923d369eac2a0a46405e13e41836591c2.camel@gmail.com>
 <CAHp75VcpuxP=3cGuVrJoSuirQ3vPNR9LLWkf5CyaGcghJ2hzag@mail.gmail.com>
 <abkv_76b1cue1bGK@ashevche-desk.local>
 <20260412153040.0e6f2d7f@jic23-huawei>
 <ad4Dd2hlVdw16xgg@nsa>
 <ad4JXGgVLkwjLHwb@ashevche-desk.local>
 <ad4J_iWzGpwXsxFz@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad4J_iWzGpwXsxFz@ashevche-desk.local>

On Tue, Apr 14, 2026 at 12:33:50PM +0300, Andy Shevchenko wrote:
> On Tue, Apr 14, 2026 at 12:31:14PM +0300, Andy Shevchenko wrote:
> > On Tue, Apr 14, 2026 at 10:10:38AM +0100, Nuno Sá wrote:
> > > On Sun, Apr 12, 2026 at 03:30:40PM +0100, Jonathan Cameron wrote:
> > > > On Tue, 17 Mar 2026 12:42:07 +0200
> > > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> ...
> 
> > > > I left this one for a while to see if the discussion would continue but seems not.
> > > > I'm not sure it is always the case, but in this particular example I think the
> > > > resulting code is a little nicer to read so applied.
> > > > 
> > > > So for me, case by case basis for this sort of change.
> > > 
> > > Yeah, I missed this one! Anyways seems the way will be to explicitly
> > > use device_property_present() to check property presence. Still don't
> > > love the dual call thing so I might just stop checking for -EINVAL (was
> > > not doing it religiously anyways).
> > > 
> > > Maybe we could have a set of optional variants of the API like
> > > device_property_read_*_optional() kind of thing where we just return 0
> > > if the property is not present. But might also be too noisy...
> > 
> > I think that's what usually Sakari likes (tons of wrappers for each case :-).
> > I prefer be on the compromise side.
> 
> Ah, and note, now we have kernel-doc updated to point out that _present is
> recommended way of unambiguously checking for the property presence.
> 
> 70fa0c308aa2 ("device property: Document how to check for the property presence")

Yes, I did looked at it! That's why I said

"Anyways seems the way will be to explicitly use device_property_present()..."

- Nuno Sá

> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
