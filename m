Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF96539A074
	for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 08:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777277939; cv=none; b=GliENTBaG+TFapQ849/A9A/WgMyK4mXkWSZ1TQ0wxZTZrPHnJXuzXERzq7BP9LtTBfqHjMgUmBGG+sk46OfyXnpS6QnCf5i7pcd73wNRebmYyknJr1cXljtiYe55NYllAyA7utp9ZRTlPPivFFr3TZ+ojAYrh7fsII4/d4uQzEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777277939; c=relaxed/simple;
	bh=T0sbXkSjL1mT5QotmfhxZTftm4nSnzjJ+BmkUXi3jYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNrH1oSftD0Y4AYzGThriHdpZge5jiqp0xA7x1k8uysRJq/MN6wEOhJPOPYvtW7wnSlnZSEe6vNnRvDmVKByr+7uIkFESdAKZ7yH/4YVSIt4vIrYQ5BmHux6onNC+uXT7llPRuWKZvGXqsNAkric+0YD9LwtfloTROE+ePiDRLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mhQ+YYml; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhQ+YYml"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso106031915e9.2
        for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 01:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777277936; x=1777882736; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OcwOCXeAR5ogbgmVs39szOKmOHLVy+rS144H43uqveA=;
        b=mhQ+YYml93ZVTCjxI1uucOH/Q/JEWfIyzEfAK9SoM3l713JAMYMqrjtD2Wah9K9aqk
         64tgJDHUXdhJSMDe0lSXfCxPfLj0SdM7FYnh+Q8wiARAe+C1OLzM7z9NgBAM1eyFcxX7
         3y+bqf/ULxjLt5Fgu7qGBmXzTO3k5PnEj5kgAlN8TGBDMvru4YERXVYBhbmNcYWhTei4
         kjXssmusBdUubaNtUTRPSQdItnrgsJr2rJif7Li6ciRXM0JCXBu/Sh0KrQw/bw8oeqm9
         s08bsn8UrhegIqcbBv8fweGBhqfPQO5n5lysQxD9ucp4GNLha/q5ui3jwF1+6YcW3oup
         7EKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777277936; x=1777882736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OcwOCXeAR5ogbgmVs39szOKmOHLVy+rS144H43uqveA=;
        b=UPlmHly5FckP3EeXvm+OSnP766r8JdTuhsc7aYA4hiAQMZ+CHXZTDZu2nAqfY0HkAq
         QLCIk5unFxzyUnZXs249+8guCIixT9CtJUBJfAjQ8Tc7LSKAykH4nc/MCNikXWqdySP4
         0qiyfDoEH4Zi46FnKvU7gRybSCuret0Gu6xUKlen0iPkxjERQxpH7mQXIT6/EtGrKfGC
         poMe8ffy4AqPpUFptpksWp6l4Ksos95S7icHMWgYdBA6DcrZWz3OZDkrHBVATvszOC7O
         2Aj4ByNHyFYSqPlyDT0F6VFPmS508BnQfKbH67ZxaOgr5AoNkxSxWThjabsr5gAn//IX
         Z68g==
X-Forwarded-Encrypted: i=1; AFNElJ+kqyyj/aZgVae0BMGNsRYY5MWIg+MRHLfgp2eqoOMoQeOuTEbk3iYa89JTfEyTnJbs0RtuBVBYiDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YycG4v636UlvKyeir3mKwvqLYzFDAVoDRNN0qlLxWYwjxpE1RSd
	9J6GTe+TL5unbLXODEWYrSN++730poRXxVpdpY1RabtscPMve3M08xXB
X-Gm-Gg: AeBDiesKfy4O6CR4wjq/TE6rj/yp8llzs8YIOS5hNOEvamy2mR51Zpg08FBxASLUiz0
	EcJ2OLb0jHIfHcbYNbC3LbgR6UYpeeK0HaHLEy7hzErgqb4DVjzrTPLr2KwGExXEwIlr903qCpi
	ENMqPlTbg0suF13pYEgJd+ZbtCNCntN/oHaheR+Yv/gE1Oh3tEsaJqwBRRQx4qXv3RbVlHb8l4S
	hVNPpjavNgpJxIa36gnM+OadW0kwSDmUahPYuJk2INk2JzGDUYFRESP8cRCbBwW28NQuLbWpqJ7
	Xk2j+NSmWYkQnPRDDaGUKD2w2z5GqIIK1H+qnJ2kAv2soukvLJEckGLkcQTh5BbLFu7Q9q6f9xc
	J5qt0DicD+bLFdeu3SCvNy9CPkZEzjLM9nZmQRhdwEXLwiq/YD0hq/29srVv+Q52RYP/DH88Zdf
	EK+3fVekyKo25i3057mOTE4oInZ3bQrg==
X-Received: by 2002:a05:600c:5246:b0:487:219e:42d with SMTP id 5b1f17b1804b1-488fb750a1dmr588591455e9.11.1777277935677;
        Mon, 27 Apr 2026 01:18:55 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc1cfbf2sm814399735e9.15.2026.04.27.01.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 01:18:55 -0700 (PDT)
Date: Mon, 27 Apr 2026 11:18:51 +0300
From: Dan Carpenter <error27@gmail.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	gregkh@linuxfoundation.org, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: adt7316: Add error handling to
 adt7316_spi_probe()
Message-ID: <ae8b6wdyNR-G-i1m@stanley.mountain>
References: <20260426205039.125818-1-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260426205039.125818-1-m32285159@gmail.com>

On Sun, Apr 26, 2026 at 03:50:38PM -0500, Maxwell Doose wrote:
> Currently, the return values of the adt7316_spi_write() calls in
> adt7316_spi_probe() are unchecked. Add error handling to return early
> and pass on the error code if we receive an error from
> adt7316_spi_write().
> 
> While at it, move all three adt7316_spi_write() calls inside a for loop
> to condense the logic.
> 
> Signed-off-by: Maxwell Doose <m32285159@gmail.com>
> ---

A lot of the time, functions can't fail or if they do it means
you need to buy a new computer and there is nothing the
operating system can do to help you.  spi_write() feels like
one of those things.

Plus we wouldn't add new checks like this unless they had been
tested.

regards,
dan carpenter

