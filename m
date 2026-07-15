Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EED4611CF
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 15:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784128152; cv=none; b=hjQ0yvhLWPEgQVwefMNfLtHwQzJhz593JSBaAtTkapkpgrbC4sfRkJCSAOKuPs67Q2ESN4f/9GRCpGg5T33F47eB39Lvsv02qDEJwhy+v2ggMZiEYRtsDdtebK6I1wmSt86igkAM+2YuKQVfjavqhbLmFWwVTFRZeF/992BkqEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784128152; c=relaxed/simple;
	bh=bL2hacoZzQ5gLT+Rwai/yPI8d5f2HDFACrjOHZ623pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kebc7gSjKq6EZRDIszFOHhGSNhwsBPUXrK99toSbN8bPxaue6lsFpP19CAiN3PGZNauzneLwJR2CH/5WRydkGKumi48qLB5ZsvVyyqmYebQwFmLhviYFUxngsUcq2clweRPajiImnedKUFTpLNm/GYlODaDFkcHWafi7W8GmWCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AX930QXr; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AX930QXr"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-472326ca506so4580971f8f.2
        for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 08:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784128149; x=1784732949; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6bVztOB3O4YAwA3M395fM/99xxJfLRhYZpgM8cgrPo0=;
        b=AX930QXrqQfo0JnMQFDlkkR5fNSRSWGIiPjgZg2CBk1PFDTaIyGFheqB1vi4Ty6Ytt
         tgA+8UFh6UIMssskoSbu63upYlc0q25McS38NJ0BR3PqlvTbSMIj7EEZUpBv2/vvCnxA
         riDjvy4BqTul27Aue8cdH6Ng+Bpt2pkHrLlgxtELx3WZnWbCzbgvWVqDYldIDSDcDYt+
         a8bU5fwCs/H/S3QlG6W/MsaG0C1Y/1JABeqzpMKxJ+xcxLEFGF10+ntVPssb+eJg0s0j
         3R0xuk0pUW1EG/QLVUFoC9+U6H3oeCWFXQNqYpQ2L7CFOZgHK7MX7ih7g1ObzWlNhn9e
         T9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784128149; x=1784732949;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6bVztOB3O4YAwA3M395fM/99xxJfLRhYZpgM8cgrPo0=;
        b=VsrKoYYXRmuqc8IUa+5o0BuEUw60HNu6A7eksLA6A8tw4H+eqgXKhU12soSgS9lCdZ
         bYltyw1L6PAIOWqhwCCn0dHNitYplBTepPElS7jtIRUrkGkGWQeK8xn8aqUtswxF5gQ2
         Mf9PPjldqSf2XZIRVMwcqOCWIwfcNBcnvr33Lq91m6YIPrGBG8hZL0+pXsqoy7yhPTUZ
         VHTeZEM2leM0f0U43cdXVdLCLB2UU4J92k80bNegOE5BqeqXSBfMiye/uAXVSPt9EIx4
         ETVhAmhBOaufwSooCgQal++pexBvI8bpxRZDCtR3URTTTMBRszSeLwz2E0PGq68cBRjJ
         3t4A==
X-Forwarded-Encrypted: i=1; AHgh+RogskZKPd81SOelAsffpahg/DzgAgU/kLCkkZyuZQLD/3YytUYx95CxNC2BqFaaQRJLNKYFdli0Iw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOXQ0hTtS9+tkUA9KakqVV59kGGAyUxUtAcZA3ZOu0Ue1UD/2E
	Jmrr8lhkjHodUAw6TO8VZlrPsGAGqPsx6jemaLGoXIQBoPEW1nWBMuUW
X-Gm-Gg: AfdE7cmoKaT+hAfLNYOs8cb2sNd9GeOqL/6o+Xqp2Wuma6wY/BHXHBrmdCayodTdMWu
	Ozt1x89f2KrNUAwbsX1MCX+2FMU33TYb4pbe+87Yat46pHFgggW2+0a+Pkv6zsaEkRFmyoVrKLo
	+U/QBxRICxjdO45eWcfZUIJoRKRS1gHhIZ84EXRHwA1WrXSkUFkxC2c46zp/GqsU6hEWBb8Sbt6
	uspH5GcXEtqHgQZ/1b/gCCFd+zil8xX8lpGGRfl8Itvd6vEhDGulbSYF3oQmnMhblMc+rTTFF1P
	conJGhx2pHyN7V3Z6Xqs2RMozLtdwHmfpxUOdwRM/SE+KJ2ziYWlxv5NrV+RQLpg5tLztNHrXhP
	ZwbcAHNU0+hT3EhS+1IY8hJJQKuwrjz7PWmfMN2l2zUjv3/gYoZYUueUAP2YhwJrUnNYq2qCZne
	qqZnyYrq9AYm2T7Le4NeKp5JpLwck=
X-Received: by 2002:a05:600c:4e49:b0:490:e5c1:b8b9 with SMTP id 5b1f17b1804b1-4953905c584mr78564075e9.0.1784128149136;
        Wed, 15 Jul 2026 08:09:09 -0700 (PDT)
Received: from NSA-L02.ad.analog.com ([137.71.226.102])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464caeffsm15895004f8f.36.2026.07.15.08.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 08:09:08 -0700 (PDT)
Date: Wed, 15 Jul 2026 17:09:06 +0200
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Stefan Popa <stefan.popa@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
	Nuno Sa <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Siratul Islam <siratul.islam@linux.dev>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Ciprian Hegbeli <ciprian.hegbeli@analog.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: adc: add MAX40080 current-sense amplifier
 driver
Message-ID: <gowx5duel4pfytvbtkaxln3zza27uazb4dfedpckesilyfmpgt@ripmeuwrjuup>
References: <20260715063652.368501-1-stefan.popa@analog.com>
 <20260715063652.368501-3-stefan.popa@analog.com>
 <aldGAbF4AN8X5CRY@ashevche-desk.local>
 <4r6grtnbddwtaflsak37y4hlofgiudksd3orxamry6eyhnueky@mg75uai5aeu2>
 <aleSCUZhZmhceTqV@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aleSCUZhZmhceTqV@ashevche-desk.local>

On Wed, Jul 15, 2026 at 04:58:33PM +0300, Andy Shevchenko wrote:
> On Wed, Jul 15, 2026 at 03:41:45PM +0200, Nuno Sá wrote:
> > On Wed, Jul 15, 2026 at 11:34:09AM +0300, Andy Shevchenko wrote:
> > > On Wed, Jul 15, 2026 at 09:36:17AM +0300, Stefan Popa wrote:
> 
> ...
> 
> > > > +MAXIM MAX40080 CURRENT SENSE AMPLIFIER DRIVER
> > > > +M:	Ciprian Hegbeli <ciprian.hegbeli@analog.com>
> > > > +M:	Stefan Popa <stefan.popa@analog.com>
> > > > +L:	linux-iio@vger.kernel.org
> > > > +S:	Supported
> > > > +W:	https://ez.analog.com/linux-software-drivers
> > > > +F:	Documentation/devicetree/bindings/iio/adc/maxim,max40080.yaml
> > > > +F:	drivers/iio/adc/max40080.c
> > > 
> > > David usually asks this to be split between patches to avoid "orphaned" files
> > > from the MAINTAINERS perspective.
> > 
> > I think checkpatch also complains if you do it like the above.
> 
> Yep, but DT people say that this is checkpatch's particular problem. They have
> their own "maintainer" database via the special field in each of the binding
> schemas. Since that discussion with DT people, I'm not going to fight for this
> kind of changes, it may be just an IIO level one (if we want this).

Hmm was not aware of the above. No strong feelings about that.

- Nuno Sá

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
