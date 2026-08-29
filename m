Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407F12C3245
	for <linux-iio@vger.kernel.org>; Sat, 29 Aug 2026 18:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788027004; cv=none; b=q6vJZU16PQL4O5+ZSUimKJLYTeVUZlGruDkZmOv3pv5B6Wgo2yp6ybS3oWhYd7rCOTu2qeBzwOeUl+y9jzGhSBd4QRO4gYB2Ois7faCxDjzlnder6T/dQbmYnZLgA7igpcEbTdN8ASpwoRKPChz/xR6mSjAiApWxypY06epCCoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788027004; c=relaxed/simple;
	bh=vVU0OpClUIp4f1XeMs9HBap3ZS/7JuhoLDquig3Yxwo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XQ0QNj7hD/Z9exzW69+fnf008XDpfU7v8XwbZT8PBwAqNZZOCQWqJIHs1xn4XiiILFOMY3A21JosgpsDnt0jWbFUXRs+eLy0R6Y4P8H5newD49A1JQZH7GlodP9WgphvIsqL/NT5vaZl9QnTGT4Xo7Pthf4oJ8qiGVUcivyLsL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xgk6TesK; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xgk6TesK"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-482f9309813so1258607f8f.1
        for <linux-iio@vger.kernel.org>; Sat, 29 Aug 2026 11:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788027001; x=1788631801; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2iPoRSblvqH1fQl98XO+rNc9dHksM216Rwuk/S3Z3OA=;
        b=Xgk6TesKfwz0MGd0ZB/kfwgg0y+gXFP6gX13VcMMk+w2+o3sBZmrq0/zq70sw0Nnjf
         vkmBPsllUrG7LL5JqJtqWThYpPOLrOQ23UhvP4cRnLz7tJ6gJzl57L/sDJNrUezMzTRL
         Uuf6BNwbwihV21NffAKEQSyUd/CttAZJ+FPo17vU7eEqOI+zlpt2yBAo0WOUqsHdNw8i
         IKxnyYehgGSoHratszRrz5DfIYqGI9OugipnNayNpvKjPGC7c9VJkmgJ+yNLcfCE4OyR
         ld+SEm2RkcFBylIyy7R90aYLT3psctU0+MR0P6/CvVWmNX+X2OxKnlyCakD9Ba4AZYdH
         jgZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788027001; x=1788631801;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2iPoRSblvqH1fQl98XO+rNc9dHksM216Rwuk/S3Z3OA=;
        b=a6GqUgG54hEC3uOGwL67J1RUGaWYZ2XNr9Ki79N7tp2Ncc4ihosswrG7FdvJKkG3F3
         MBfImDVv1C8SPXuYDLSgLRx8q5hceuSKuRgLkfus9M6RuE/7zXXKopS0HYE/Lb0B6BHn
         +k+bRB1hIVKSovcAoQGHK7TVVBWU2HLL+woochsXXZ4M2ABzHhZ8RWT4WmeCZmuEPqQB
         whfJDcM4pSVmnyKmVU+taklc1afAbvCsE1RhPhMvJ1YIo4ARzj+4iWRH1wrWYYMeSjHZ
         pfQ8AX4IQeU98iOTjDD7KCvG8ii9hU9ZyQcRmULhAU4fedV0j8orS9i1ZR3nFC9ni9gv
         64KQ==
X-Forwarded-Encrypted: i=1; AKwUvBzbGKXigC4NYsc5EhcbDt3RIulTSXcmCb7cfr7yMygfZofGEcH/R6XfpfMzGn0tMFGoREop6gAxXZc=@vger.kernel.org
X-Gm-Message-State: AFuF++nr9zCxYKrar1ABLB45+iaymP/azUBY+t94UZjezjcltdfNS14C
	d7f+zSLcaAprVeiUlQ43zzQ27u5hRj8bVsFHr0ia3ROzIG9CSPW63V1j
X-Gm-Gg: AYBFou2xXlFau81sjRSh+Mx0yMB5QuwprwWy2fd+ODwgRGBlp8dO6BCOY3SSP8Bj0Ku
	pSU5QpJXJ9QjAu9rxHaIN+s4BCaAUWYsBBDvnn/PXSFCo92ZYvi3RZr/4ABEYevhWJlbWc1UGoL
	4IpXC/PMjwkTDrQ1oLH6r4b8lVUWU103cnSfN1MheAFfqtoGMq0yuqHPwVnxQhBroXC83GrDYQ5
	wn9lWboVyDlhr705m8sM3M5RZON5MPzL3H7apZpADm5WA9phzs6b5FUMlwofBVUy5Mgk1IvWDbL
	jct87PFQoFCTC4AgArXEJhK3/+LTyRXOJNkMPDSQ+gO8GCEEJAKXNbY/QEJKqttxBc2rXTDrXnt
	EcG1WjMsfDEJi1UEs01YfbcHS8oskCO2mXoSGMhriwzkIYrxbHQEY5r1RUkx94aPKX6os0UufSM
	auI7Uvz7dDiIxEWDy+vULCBlHCBTFrdWrNEkV5CzTA1E2+vVI/n2Vkrm2o2TezNhN5kiaJWRvPN
	2nM5XhQgljBJLSTafGVUGwwQSVnXeAAeulNeqWZayIaUHLsz5RIvNLKvCUB3SaPkCA+CCJ8WTt2
	sGqEgez9wqwn27z2JTpLgzxr3Uro2fooxoTEZ9uQPZKqVimXD/P8KZr0+mCfh7fW++rmwKo17lH
	lbvHesjngE/OD1ChvThU5
X-Received: by 2002:a05:6000:2510:b0:483:ca4a:6b9d with SMTP id ffacd0b85a97d-483ca4a6d9cmr8743130f8f.20.1788027001191;
        Sat, 29 Aug 2026 11:10:01 -0700 (PDT)
Received: from systembl0wer ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbb32ce2sm12442751f8f.33.2026.08.29.11.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 11:10:01 -0700 (PDT)
Date: Sat, 29 Aug 2026 20:09:59 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Crt Mori
 <cmo@melexis.com>, Puranjay Mohan <puranjay@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/11] iio: temperature: tsys01: make headers conform
 to IWYU
Message-ID: <20260829200959.09e58aac@systembl0wer>
In-Reply-To: <178802625991.2637008.10673317877221890998.b4-review@b4>
References: <20260829-kernel-header-removal-v2-0-c67739d5dedf@gmail.com>
	<20260829-kernel-header-removal-v2-9-c67739d5dedf@gmail.com>
	<178802625991.2637008.10673317877221890998.b4-review@b4>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 29 Aug 2026 18:57:39 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> > Remove the catch-all kernel.h header, add missing headers and remove  
> 
> Seems some fixups in wrong patch as tmp117 stuff in here.
> 
> Sashiko shouted about that.

Yeah, must've been half asleep when I was squashing commits.

> 
> > unused headers.
> > 
> > Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> >
> > diff --git a/drivers/iio/temperature/tmp117.c b/drivers/iio/temperature/tmp117.c
> > index 25bc98e64e48..96252627613f 100644
> > --- a/drivers/iio/temperature/tmp117.c
> > +++ b/drivers/iio/temperature/tmp117.c
> > @@ -12,13 +12,12 @@
> >  #include <linux/array_size.h>
> >  #include <linux/bitops.h>
> >  #include <linux/delay.h>
> > -#include <linux/dev_printk.h>
> > +#include <linux/device.h>
> >  #include <linux/err.h>
> >  #include <linux/i2c.h>
> >  #include <linux/limits.h>
> >  #include <linux/minmax.h>
> >  #include <linux/module.h>
> > -#include <linux/property.h>
> >  #include <linux/regulator/consumer.h>
> >  #include <linux/types.h>
> >  
> > diff --git a/drivers/iio/temperature/tsys01.c b/drivers/iio/temperature/tsys01.c
> > index 14de67ee8be7..3c1f5b6ac156 100644
> > --- a/drivers/iio/temperature/tsys01.c
> > +++ b/drivers/iio/temperature/tsys01.c
> > @@ -8,12 +8,14 @@
> >   *  http://www.meas-spec.com/downloads/TSYS01_Digital_Temperature_Sensor.pdf
> >   */
> >  
> > -#include <linux/device.h>  
> 
>  | sashiko.dev <sashiko@sashiko.dev>:
>  |
>  | [Severity: Low]
>  | Does removing <linux/device.h> contradict the Include What You Use principles
>  | mentioned in the commit message?
>  |
>  | Looking at tsys01_probe(), it directly dereferences struct device and struct
>  | device_driver:
>  |
>  | tsys01_probe() {
>  |     ...
>  |     indio_dev->name = dev->driver->name;
> 
> Looks valid to me.
> 
>  |     ...
>  | }
> 
> Jonathan
> 

Yep, all Sashiko issues addressed in my series locally, but I'll let this
sit for a while before resending.

-- 
Kind regards,
Joshua Crofts
