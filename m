Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CDA23D7CE
	for <linux-iio@vger.kernel.org>; Sun, 13 Sep 2026 01:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789263320; cv=none; b=MAqafWvaf/0T6JB2feUTzs5r1dnUquKvfLJy7QNiRx5FhXCCrYvIocz/67lUoe1Lhodc66Fg8WHYBB7dplG8uzNjkjsm2JGpcFf57RmfBh4Lri9hyGCZPODpeCkKD1fujTHDu2b8WvaMkuqxegDQ4RIpFfPVj/OnJGECbmLasYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789263320; c=relaxed/simple;
	bh=Db83873sN3SXgiHC0h9NYbSzB6Bu6ea93IS7nKpR7q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YbTXgdSty7DYvFHPmrgOf+xIitznAuYAyIilLOr6iRkU4NwPn81JswDQJy+Bl7APyl95bjatUcmwqbr0RhbjLePc2Jx4xfRZpbahjP/BQ0FlkWTO8lilI2/MdYQ0cn97lAqswv3Wr963B/9hk+4hxPkRuM/QV2fuKajSRQXj8RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pzd6slRG; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pzd6slRG"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-66c744a00edso1669112d50.2
        for <linux-iio@vger.kernel.org>; Sat, 12 Sep 2026 18:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789263318; x=1789868118; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SghHtqWEl3yUniEKr5HgjMzb/SeKVcYU3LbBYVGh0EA=;
        b=Pzd6slRGjYMOdywhbkAOA2dUKpt+LsZfNt/LS8TuKS9+Hup/Rye/UEJ+jOAyiWoX2H
         8udSO0XigokQZF6h/NcrAZNsaJ9eiIngAOCWVAyh+YWso6ydXmojKSqdilOuCyx1Q07k
         9lgN5UzkYnoNxkI9D5K+prWnp7PxC7vrKmOfXc8Tm1dOK02Kw61OdPDx7Zj5S3eIGVww
         CSFrsIk6NvBIjhYiIEnwPoZRbjG1h0IJy0menVwVcjWOSU9L1gluj4WnFwyQvophVPnx
         pTaSHX9z09dQTfXf/iKSCbVXBVqMTdPMRpe1c4V713JjIsxXFGxzKk7DSNVYSUziDIdB
         Qevg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789263318; x=1789868118;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SghHtqWEl3yUniEKr5HgjMzb/SeKVcYU3LbBYVGh0EA=;
        b=JhxiWevkfQFjYSpYBIvguwuB2CvN+jGJTo151utF8QqIlaIKTnklFjK7aDuDfqZUss
         C+n4OOZUrVNLdw4Owq4i0w7YZhW6Ap7RcDXua0TW1SzF4/LMc4pTcTVMmOmUP0O4RXny
         e3ZbrnPXffPuCx0/JxJaxW46xQLXor2oTRWBQq1NSoHn7FL3vF9ikcWnr+TEbNVwMclv
         pLhQHwLR0qFFsJF8oE06JxPyQ6s9SHiKq135zjCZIRfNzePjnKyKkpKGuM7wiqk+KA76
         XcYfmiEx0909cSmUEbhDiUOsugfuLNY68OvF2We7bFOMAvu+vmjsDqtk4hjADPiU8KJ2
         43vg==
X-Forwarded-Encrypted: i=1; AKwUvBxOtdpexvJKFR3AeYIK0R+9xLUFAPXbpqJEZHBmKkDZUEt/gDG/ooKzk+1R7OyrOLOlsLtEHlYHUJs=@vger.kernel.org
X-Gm-Message-State: AFuF++nQChzDbv4dHEi8dZTgWhbfSPPqbOqfpKJk12DCpksaNr1K+rcG
	JGvQWXb8o0d/DFUuzMEd7vqCtvSo2jZvPfDFkIhaWidI9yKfMIRSZTKw
X-Gm-Gg: AYBFou19PweDpBcg/w+Nkjr51yFmTRivUFYVwQnG438yxHTmzjCA6gPFF2P89O3QWiW
	EWTHUN+QKtNolFLKRKjBLAqzwMc7sW+kROzyWwoA5qTPAqKoavtzWfYj0u0imw4DIXQfJKRe/86
	HSAkYk1GQ3ffhoD92ZgJCUH4Blj3gvNjEeTOh5bFFwkJLQN403xzFk0Zad0zybxOJfp8JMms1Zh
	bnbn7A9GO5c6DSBtkHSziZjLWTGdvShuJgRY23CuLQYZ17BM0KB/744fAa1jcY5trhKcthPDel5
	mVo4wCh4U+7KoHDTwRWYDQHOp5pzHQ4XHBFtKOps+BstGBAyOMkbJJfQ7JM1P11LMFWLzB973Br
	rV3qLJ+pCom8b/Lxh/6YNgWtq6ZGNScV7cL+4ja1LGLzz6RLgpV0tr4E9dcvDOi+UiJ2x8FiUtu
	JeLiC9kaJmZ5aO3nzJ+vBCRG+4ILZD6E4RtKWQjVVvX9eBYjhWrtTfuA==
X-Received: by 2002:a05:690e:1518:b0:671:16e9:6a5 with SMTP id 956f58d0204a3-671245bc479mr2857955d50.26.1789263318274;
        Sat, 12 Sep 2026 18:35:18 -0700 (PDT)
Received: from gmail.com ([2600:1700:5431:250::3e])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67125df3180sm2857982d50.7.2026.09.12.18.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 18:35:17 -0700 (PDT)
Date: Sat, 12 Sep 2026 18:35:14 -0700
From: Chang Yu <marcus.yu.56@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Chang Yu <marcus.yu.56@gmail.com>, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shi Hao <i.shihao.999@gmail.com>,
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: light: add as7343
Message-ID: <aqX90oniPRdsu5jp@gmail.com>
References: <20260912013912.51887-1-marcus.yu.56@gmail.com>
 <20260912013912.51887-2-marcus.yu.56@gmail.com>
 <20260913015652.029475d2@jic23-hlaptop>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913015652.029475d2@jic23-hlaptop>

Hi Jonathan,

A quick comment inline.

On Sun, Sep 13, 2026 at 01:56:52AM +0100, Jonathan Cameron wrote:
> On Fri, 11 Sep 2026 18:39:11 -0700
> Chang Yu <marcus.yu.56@gmail.com> wrote:
> 
> > +    description:
> > +      The driver current for the external LED connected to the LDR pin.
> > +    minimum: 4000
> > +    maximum: 258000
> > +    multipleOf: 2000
> > +    default: 12000
> > +
> > +  sync-gpios:
> > +    description: |
> > +      Optional GPIO pin that can be used either as a synchronization input to
> > +      start/stop measurement or as an external start/stop signal for
> > +      synchronizing with the connected LED.
> 
> So the datasheet starts referring to using this for some level of sync
> but then only actually treats it as as a gpio (maybe I'm missing something).
> Any idea what that stuff about start/stop is talking about?
> 
> The only thing I can find about this is the device diagram in figure 13 that has the GPIO
> wired to the led driver and the automatic measurement engine.
> 
That's what I got from the datasheet as well. They don't describe how to
use the GPIO pin to perform synchronizations at all.

The adafruit arduino driver
(https://github.com/adafruit/Adafruit_AS7343/blob/main/Adafruit_AS7343.cpp)
is slightly more helpful - the GPIO in output mode signals when the
spectral measurement starts. Unfortunately no information about input
mode.

> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - vdd-supply
> > +
> > +additionalProperties: false
> 
> 
