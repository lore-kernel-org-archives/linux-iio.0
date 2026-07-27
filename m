Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D233539D3EC
	for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 15:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785166096; cv=none; b=PV8Od69woyWe+ljY1zK1GtQBRkZZ6CQkggB8Jdss45LwyMLVKb48Bmz4jg/ksjV7jz5iEI5vUG2FzcifkPocgikVFevPJ47YEbzq8V0oFQV92jEn1vdF6ThnhaejZTRHInvVMj1bK1Hn6L6O/SQnUjvRkHpPtd7NehU4AgEJ8fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785166096; c=relaxed/simple;
	bh=vtEm4JI6cjFLLzN4umB1w++w6VHuV6TmavJBIOK9aoM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ou/weYQIv2dGBsCZ5rcvLuzhAM9zHb32jtQgsEJLS99NBl2OgINj7nRYHfEDhNY7OqpzMxsSr/cE1tTP8rfzr8XIhJl1Hf+NIld0Ru2niZV+PtFKuUKDH2muAofIXHgm0OOt7zSRVANGEFDqAyOrewDA9xwJomWDZuboXZGf4bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCpYu+Fn; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCpYu+Fn"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47640541585so1797055f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 08:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785166093; x=1785770893; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z6nWJwpGrsa+oinARzLimkZHubU2TI+0Gk5gRgKi39k=;
        b=fCpYu+Fn3Jm9c1OgvG7CiuFsbkswj/M9qKT2dbof9VMdQxy1qUPKIlMty3HPUEqmTo
         6PS8tvp14rk7vwtGBDZYOBOiAwvw8W9O3eYt2+LUnU9fDO9SwDidUlpJJ4QVyzxTw7kO
         1FQSjWXM1e2LdtyNttrY1IiYIiYN05wXnDYqCkvftuy/y5bAB8/s8IvLF6V3lmkzosdL
         rCn1+osKvmbk4MO/oejunsGTsF2OtioWSHIvmM/zFPktoBz9lBVHbGXoElLbi8eZlBh9
         WK0Hl07HQ8hvSVY1AtIO/dtMJHBB6WP2UrMvDHXG3Z6MJc4WT7LMG0xk55Iq/K9XtIhl
         ox2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785166093; x=1785770893;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z6nWJwpGrsa+oinARzLimkZHubU2TI+0Gk5gRgKi39k=;
        b=AqhIXdunmQoEW75e+h12T96+vPxpFpg4dKnD4PlXGLxdVcimJFk9aVCi6h8359IcVg
         P3S7Q2HUejr4y3BLvFNNNUio2+2NYgqWprQi+omzB982VIiI2iBAcFpTjaclm3qyhNLw
         Sd1nzqWG3h7TSV0+rl0WZ3bNF5r76DXw/35kKxm/rt9itqtqapILHBwg9WJZKc2f7MOf
         BXBuTz9MsrhXttYAIDQtvJmjZetSRKMSGk0k6GrCwwVdXEB8pR7L7wgb+1aH1kq2VHLM
         WyGWzOsX0ScXZQkoEvLaMpDbOM3mlgX2ajX3Vos3jYNsTmNMShjRTu+VXtyVVMwSxusj
         K2Dw==
X-Forwarded-Encrypted: i=1; AHgh+RoP1vEuU2yDRQdQUPQP1VMaYJgj003LGLkB7p3eIy90SSLDD93LUls02qFKYSC8c9SuZnkbqzEU6O8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1F4EZAhq1jnVVIeZyC/RJAc8PRXQYvmr3pr3N1w++qkCNY5BS
	V2QpGbrrytShqeiEAHG6ArVvG6sB6+daZpAU8TohOG+bAiETKmf3GNII
X-Gm-Gg: AR+sD12+/NpkK3FeRwvwsk5tTgmiMERpmvFSUehl5QH8b7njN5G3valgorc8ClI70qC
	mqc1wUxFfXEovlYIsayEFCShy+CQllsdUAehf9+cOf7nrDlyGD5uP31PBHNdBG5rkH763REJ1rR
	8UNtV49WqlnKzO1PgtqSSgJSVNuM7RDpFmyzSNeWiGouooUz20fr4Yjj6V2/mHZiW/FmRMt1chs
	hwPzhaqlHLigpHzFHbiS9cLoIfkVHzSlhsIyW5+/UWSJQXGJDJ7hiw1ktsAuat5fB7pbqbjasP/
	3TusQDQgOlecvp4+LBQz52/acK8RKoNAf90Pzn0xgrJ19EnN+/yQEUVbdzn9SBo55IWgeHBRtzO
	8yqy9N5oFiXOugbii8h9t4twTITiWalA7lWXptb9zQMGlpalmOhtvu1kKQJwa2/3DhP6+dnGLDA
	cz5SuNZPME8zo+hnkhzusyJz0hy4kIUnskvEPu1ifWMEqfhYDD/Q9QpA0BVthml+GczoXugs4Ti
	In60gAumi+2MvZupxQxj9WrTiEUZewyhbhaNmwJFdV7iOyKcZOSNIyZG7t9kUWK1SZPttBei9wu
	Sw1ayEyYViKmMv+71BZPpD8wafW/tKc/HKR2RrAZfDdzffCcKc29ysAKyfmELvzMBklT5imwMBc
	gePxPyyxSgS71c4Fr0p3I3vs=
X-Received: by 2002:a05:6000:1a86:b0:47f:97a4:f121 with SMTP id ffacd0b85a97d-47f9feb5316mr10638215f8f.30.1785166092801;
        Mon, 27 Jul 2026 08:28:12 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85b9a64dsm54329858f8f.1.2026.07.27.08.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 08:28:12 -0700 (PDT)
Date: Mon, 27 Jul 2026 17:28:12 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>,
 jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Giorgi
 Tchankvetadze <giorgi@tchankvetadze.com>
Subject: Re: [PATCH] iio: light: veml3328: remove redundant cast in
 read_avail
Message-ID: <20260727172812.00004210@gmail.com>
In-Reply-To: <90018da7-8d84-4bfd-b2e1-f832ca03f764@baylibre.com>
References: <20260727112726.211344-1-giorgitchankvetadze1997@gmail.com>
	<90018da7-8d84-4bfd-b2e1-f832ca03f764@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Jul 2026 08:15:59 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 7/27/26 6:27 AM, Giorgi Tchankvetadze wrote:
> > From: Giorgi Tchankvetadze <giorgi@tchankvetadze.com>
> > 
> > veml3328_scale_vals is declared as a const int array, so
> > veml3328_scale_vals[it_inx] already decays to const int *,
> > matching the type of *vals. The explicit (const int *) cast
> > is therefore redundant and can be dropped.
> > 
> > No functional change.
> > 
> > Signed-off-by: Giorgi Tchankvetadze <giorgi@tchankvetadze.com>
> > ---
> >  drivers/iio/light/veml3328.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/light/veml3328.c b/drivers/iio/light/veml3328.c
> > index 7ff1753925c4..a3c49beee93a 100644
> > --- a/drivers/iio/light/veml3328.c
> > +++ b/drivers/iio/light/veml3328.c
> > @@ -228,7 +228,7 @@ static int veml3328_read_avail(struct iio_dev *indio_dev,
> >  			return -EINVAL;
> >  
> >  		*length = 8;
> > -		*vals = (const int *)veml3328_scale_vals[it_inx];
> > +		*vals = veml3328_scale_vals[it_inx];
> >  		*type = IIO_VAL_INT_PLUS_MICRO;
> >  		return IIO_AVAIL_LIST;
> >  	}  
> 
> We'll see if there are other opinions (before sending a v2)...
> 
> Usually, we would declare the array like:
> 
> static const int veml3328_scale_vals[4][4][2] ...
> 
> in which case this cast would be needed.
> 

I don't really see a reason to do this... but up to Giorgi
to send a new patch or stick with the cast removal, I'm
indifferent.


-- 
Kind regards,
Joshua Crofts
