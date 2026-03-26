Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EEF3DBD4D
	for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2026 11:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774525426; cv=none; b=fu172RFF/Kkkv3KhjOlLQV7yqetrCeTrB6uZVlAFzMhi0AyJdg0yoKsaq60nfDISWVGeyjREaHB2kDryaKUFoSsbYUMxcDkZkOtcFXqMEAMHDUrjehRGbXqtcg3tV9Z/A4fQi7Qcxj4Jb4kZEGIDs/d52+lxVpj3rmoTud+UY/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774525426; c=relaxed/simple;
	bh=11hgpESymyjqhZPXRA7VZwkuwicIUr3pHRbps8B5WAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cD0Inz1D9TcHmbPGcOGY9LLCvR+d+Vk0ZRCyia62jwDSW6IyYp+wp1JKc/eFs3GsRKx+6JkMUB8oND4pdYVMPzNRMFOcOD9P89scnqKDt3SyZLP7dJBNqA6aS9zYbMmjsmHKi3Zp/zs49YJiGrEJRmv8R1r8Q7wWYEgzo3rB0Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAkr8uqf; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAkr8uqf"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-356337f058aso520496a91.2
        for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2026 04:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774525419; x=1775130219; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bnq/8BwPD0wwLGZ1QjNcMHqb4oOz2BuHMQ6VR6S5qso=;
        b=BAkr8uqfOAYlJa3vKXEy/TzDWU1eGGg74yfni0O4US4ociCF11BLwhzn4og2Gc1X7L
         iNLULgZwFanK2v1Wm/Jpac4dj04QhewkvdOdmEkg+gi45jcrLpyoqxoXcaCFy4L532SB
         JutaKX0+xyxxr2lV3EGhIul/K/SB8w8hY8U7aug3bzQByKTF8Jjk7WONX34RGuAZB6C+
         /6dJaCdxkRRwFLwczT5EjjbeXCtDl7cSEzE/FvsIwvgQWusoh/+HMfXmCiq/9fjdPG1g
         S35vr/bfN5qJfnEQptl4lu9qOpJpHVHfxnWP9bRRDeTxg8OAX/fh2xQx/Fqqz/9I+9IP
         /VeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774525419; x=1775130219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bnq/8BwPD0wwLGZ1QjNcMHqb4oOz2BuHMQ6VR6S5qso=;
        b=dUqwo+ZRmJ0BMbyDdZX+dPcc44wI6+98/Xff2gfq+Ka4qV4LYOJOQ7EOohcck0Pk/P
         jqlXL664o85Vq/YSoUh4XPKzARQHhdS66kYPGHzR7kaIMrE0yk+YueW7gKM5qtjO85ZG
         vp7Kwac/idRLa6TLq5koO0jiHL9Oz8nhVIBSNrtSU2Tgafokrr/sMm9UQ3+56silqvhz
         QtbafmvJdAb9DzqgntNEt8Xq180yiVVxJD8VMDEkdjRB2KDKxJ9Rfii+akCoP5EULUAa
         EwQgBoNbF7qQEG8TwG9H0m7uz//aoka+OuamFkJ3S+Ws5ldqc7O/G7NW6A6w6tbT5+oK
         tBzA==
X-Forwarded-Encrypted: i=1; AJvYcCUeNp70NLPLHEkDxN6L4D0058pUkKLBiIfVevHTopUdNwBIfpkHh/SNzP5MP8QZt9lVkhT7TO9cl3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTxEqZd7kdOPtY1+cE0EGmmPFtXiJwtiFpGS9C8iHBlM4zok+i
	kxBi807Kj4Z4/Jw1YG4J+tqbZbySaz8RXEvY9AeLeug1wwWlKmoIj4t5
X-Gm-Gg: ATEYQzw8tTddnlt/Q4FUXqSykBGxmTD/7MGUO5iOErKyS9I9k6/yI9p01JcIJx83kLJ
	NgVMr9Qorcr8RU44whBGLdpgzYxHxpQ3JnmUVIpja8vltv1IDEsgyHfpN6yRii3PN1c4owbqBqj
	5qxfgxUPPGkBNsuM2l1UEdsBWXalnZt0KVer1lTaXfzwIml4SSl0pfukmB00bjMxMMd46wo9wiL
	gbhwNkm9BHnz8B467HkyRxuoNsaVsxgjxbOW4lxEfFYOD5OfA9rZped479VE6grjYXQh8VnM71J
	yVSLf/kJcIgQWRxAsqqyCEsqZcdiRGAP8qCYasCIzuQ9RlH4sgdoLrVBK0THeBudt5fZXl2dJDQ
	J4pdlHQXy0LAF4/dc+Arf72E0yTGKk1tMIH4YdusOABeevBT0I5sVTP3Oe2oH2UL8BsspsCI0gd
	G+UNSf2f+9kwNv/LO1g1+ocy4KlVaIEJY+Qg==
X-Received: by 2002:a17:90a:e705:b0:35a:329:73c6 with SMTP id 98e67ed59e1d1-35c0dc80d99mr6775595a91.3.1774525419136;
        Thu, 26 Mar 2026 04:43:39 -0700 (PDT)
Received: from fedora ([2401:4900:1f33:d48d:51e:27a3:56cf:6a9b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c1e1a64absm674053a91.2.2026.03.26.04.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 04:43:38 -0700 (PDT)
Date: Thu, 26 Mar 2026 17:13:27 +0530
From: ShiHao <i.shihao.999@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: andy@kernel.org, dlechner@baylibre.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, mazziesaccount@gmail.com,
	nuno.sa@analog.com, andriy.shevchenko@intel.com,
	i.shihao.999@gmail.com
Subject: Re: [PATCH v5 00/14] iio: fix spelling mistakes in comments
Message-ID: <acUb33haPmRWnz1g@fedora>
References: <20260316090023.14691-1-i.shihao.999@gmail.com>
 <abgbKZro-i2o3Opq@ashevche-desk.local>
 <20260321193217.3fa11fdc@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260321193217.3fa11fdc@jic23-huawei>

On Sat, Mar 21, 2026 at 07:32:17PM +0000, Jonathan Cameron wrote:
 
> Oddly of this whole set only patch 10 applied with out having to fall back
> to the slightly fuzzier logic patch uses compared to git am
> 
> I'm not sure what caused it but Shi Hao, see if you can save
> these patches an apply them with git am. Then figure out why not?
> If that works try b4 am  to pull them down and figure out what is going
> wrong.
> 
> Applying by hand takes a while as I've not scripted it, so I'm keen
> whatever went wrong here doesn't reoccur!
> 
> The resulting patches look fine to me on my tree.

Hello Jonathan,

Well sorry for the inconvenience, I checked them and the problem is
coming because i ran scripts/cleanfile and scripts/cleanpatch on 
generated patches which is causing the error "corrupt patch at line n"
when using git am, otherwise git am is working fine with no errors.
Thanks for pointing it out i will make sure to be aware of this from
now on. Also please let me know if i need to send another version.

Best regards,
Shihao
