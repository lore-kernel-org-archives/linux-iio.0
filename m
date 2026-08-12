Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5076842586F
	for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 11:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786534821; cv=pass; b=GjZJUr832nzHUR4PGHrch3tL1JppT0ofu0xMcRByThL/CRF0URMYKTumcbeRCgbqB/MQTsoUHukeRTfJT8h3Cl9pPQXdT2fTHrpGrfYynpd+RJ6BJdpaRQsasmGLrFOZfFUIW7k1g5l0IXhi2/jnCzCb7qhzYWHtdG0YkUdaxac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786534821; c=relaxed/simple;
	bh=ftXlbDu309QmVeN7pDAevs+3sNd39BPkjEn8GSmSF/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aBZ/GTqAMyahoTTQI3dqHyuinjC34knrcS1m+RiP37Fz9gXV6MG5C36TZZRRhgi9umGnbFEpUjDtxRHiYkpbwn5LYlSFdpwyLstn4RqcuI5CFxClMcwn5z763KAqAoT16/fTlavdCgA0+KE8MDnlJ9X4z4MGEKULntJvAA5pvzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pa4A8UP9; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pa4A8UP9"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ceeee8c46bso2290815ad.2
        for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 04:40:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786534819; cv=none;
        d=google.com; s=arc-20260327;
        b=Sl76/SLCMePprpc0vXYUKAZvrgf09mEo8VW/HDQMYXvZEM0OJMTddfY1oIBr9vn9W8
         MAB3bwrZCARkQA4dw5OIQd0uLBYOumhW+XWO8ZVdtGrY6Kf6z3cj1rpRmPR4i27kK2Bp
         ZIBxTOsL3uFDcP75WJR9VjgwEMFyFMoOVrQ8jc25Zosow1V7uXiRseA83lGkcmWDQJ7d
         4CAlP/z9xx5vWSBxoBbshqWF445Lr/O/805xe8px/YZQb1gNGBz/dWiRfGq8z8UFV+54
         AUr6V1TX1SMWpJ2M4FfRaFFlvEbrXVJ4GC8gFDhj+ASU7mi7L/HGsx3pOHutYdNiUbKx
         zpxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=CcrVHQ+LHnpe+MEDWyjgCumfCG5lBDkuaO8drxyGg+c=;
        fh=W1zrOiCGJW4NhGBbQSX5Ibnej9qrzsPBxQJixKmS0V8=;
        b=YnOMPh2JDZmYzBg3ldl0TxMuNp/s/oVCC2nsZXd0SSE3i0ToAKqC5YIv+AW/4GTaKG
         0NsMFh2kbUX15paKfmRD0guY/FHMexdGpf3oxTM0p8mcpB7+3qrWam0Nw1XosWYE8RRn
         reDt4K/yz0kAyO4PJwCTAkToAccaxmxiOm6U1qB3yIPp2CFTX7Qoo7IQQrMoqcaC7Ib3
         /ZfaSdjmB8iqBOiqFWNvufbSvfWvogqkZR+LhlE25ItOWtA2fDt4dWuSMx6RVvhfLKXa
         zad5Q9mySopX+F2b/0g/01QQBdY8uy5SMxBqGvWKtFlwYFKR150+hDtBZIl4BBVbHeb0
         ySzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786534819; x=1787139619; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CcrVHQ+LHnpe+MEDWyjgCumfCG5lBDkuaO8drxyGg+c=;
        b=Pa4A8UP9qNuIQ2jmP26gB0LwnNZx6MElQYCVcDuws27d+1wlCRH4oBzar7h7QZNDp0
         EqrflI+w4tPZNkaSTeA6yJWLSDCcNv0dWTVqLM+983PhWl0XtluOmjDs1hUMOxhA6HB9
         AZJnBS9qYy/EnY1T4spltFfUeeyfJkyX6l8C8HaCNEZnC0uaflx7YWDyL+8wbGu7dJRv
         ccQrCGqOdxPacc6XrBRlQ2XthbK71BGV0gzJFyrVIfpLEqgNf25Z/40pxeztVzEbCaBq
         g/V5KSnNxvmv9zj5afTHjMTfjpoLOvE5YGHcDkGk5i+hSHvDUBni0yTRmzqxEt+YOVj+
         j2Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786534819; x=1787139619;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CcrVHQ+LHnpe+MEDWyjgCumfCG5lBDkuaO8drxyGg+c=;
        b=RoY/pfF0WGCn4uUkHk2sf0HSOOfGYOKD6zVy/wuwI83OAuIYeMCNwa7839E7XRePAS
         odKIIU5kY5LQ1mm5uRF0FAAIbsssAF50OAX1ePb92VWf/ftVxfaTSy/h4L+hqW13aTpn
         VB1WWSJaJB90YIOGl9I+DPtopKlUTXrmSl4PD4H5Q+bL2SnBNh0Vl9ZwP6OC6UpXoUs1
         XKLN0yeCjiCzM2GfzTpTfN5wmzkdgwa8juh5KB004WIfU6Vh8UBeVtPSkPvLm18pPiXp
         yjWm+PLX8w3Qg2mOT5GXDk+FP1uLWbCjODxm/V+MVXV69eSkAafcJh8+wc2aj62upY1v
         Q3uQ==
X-Forwarded-Encrypted: i=1; AHgh+RogggRl/ugzQu4kxDUw9xYFMCyMjMf10ciLsBkwjOLsqoaT5qW/NquU2S54Dvp9GTNPSAB498zkSrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV3zAhQ42TSMEg5gnfDm+1WNmahQTsFZJEwxkuFRBh6r/IDz55
	1z3pdsn/Jv8++8m0JfGjUbwvC8V/fpX/yfgFmtxJNWDLraGvsiQH3+wNd29GpQ5X0vJHzMRJxxu
	1x8q3HOMGt+ozYkED/IttYqLdBsvQdvE=
X-Gm-Gg: AR+sD12s/FJ0qdhsDl6HK+3ySkl0TZimyfqiS1awW0cR+olpmTh2H25hVxABIAG9q5b
	KY7Qxnd1XlAcFtDGDgKIvuEscz+tNA0AoaZ0fh51NWwQzFjyJBF8u/D52WnXymbbi0U3U87X8VU
	kL1WlnxcHZ4V8M3i4p4ErbzFXIdTL+BBRIrjIVf6wHpXYCHvEXRu4jsIXJFXnG3JfP0j5Od3gx/
	O2GsnvTfu6LQPOq8LfFwqphrqtUL/14tBa626+K+4j3SLihOdhU7QkbLbjuoBW6j84ovAJ026+/
	LtIMCWPtTGSETDPYnQccvEjenh10FUUmVfdRH/keZJg=
X-Received: by 2002:a17:903:144f:b0:2ca:de3:15eb with SMTP id
 d9443c01a7336-2d3450cc3dfmr41499755ad.0.1786534819286; Wed, 12 Aug 2026
 04:40:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260808090026.34187-1-adinata.softwareengineer@gmail.com>
 <20260808090026.34187-2-adinata.softwareengineer@gmail.com>
 <20260810010943.014d8db1@jic23-huawei> <CAG442=sRDMfdVZB5GY+f6Wud7Vx8xR3ORN0GWVRVV8NKLVX29Q@mail.gmail.com>
 <20260812060414.427f7616@jic23-huawei>
In-Reply-To: <20260812060414.427f7616@jic23-huawei>
From: Adinata Tan <adinatatan99@gmail.com>
Date: Wed, 12 Aug 2026 19:40:05 +0800
X-Gm-Features: AUfX_mwG3enKJGDzl_Xy8u7pCaWHXuNDuSePxAeXbnQrdn91TqUXsI2XjDgFjtA
Message-ID: <CAG442=sn1YnDGdVvfnj6ZaeLknN46EqhAdkYBBp-6AnrrnDGCg@mail.gmail.com>
Subject: Re: [PATCH 1/5] iio: humidity: hts221: report available values via read_avail()
To: Jonathan Cameron <jic23@kernel.org>
Cc: lorenzo@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev, adinata.softwareengineer@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Jonathan,
Thanks for the input. In this case, we can proceed with the current
implementation?

> > For this humidity case in particular, would it be better to keep the legacy
> > implementation while adding the new read_avail()?
>
> To me it seems vanishingly unlikely there is any code out there jumping
> through the hoops to read the wrong ABI element to figure out a possible
> value to write to in_humidityrelative_oversampling_ratio
>
> So I think this is in the category of ABI that we can change as long
> as no one notices.  For IIO I will also generally take ABI fixes on
> basis we actually want to know if anyone is using the broken ABI
> (and they very rarely are!)
