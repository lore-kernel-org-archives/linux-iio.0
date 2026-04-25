Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE7D303C83
	for <linux-iio@vger.kernel.org>; Sat, 25 Apr 2026 21:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777153476; cv=none; b=TZzj7euXDC0bHgiXTG4IddTs4aURbxxzP/0pPKAY6rvJAyu1Egcm1MvGwFNhFGFcIybEnMMH/4FAT4LUokBHcr+GkuFvCGiLodIvn6Lnm/ygABUswp83pzUftmZqm6XzSEkiBh96iAQHi16Ol7bjWc0v4b5HqE5XnDWBzhUFmgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777153476; c=relaxed/simple;
	bh=vtdsiym4Y2IGQQwewhHUQFHiy2pQQPMwFhKuEcdkJpI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CshiXHLJCX74740Q0Rh5CnA08olJ6r1G+q2YRHwxXCd6NXbrr+N7PRtHGDRskRaasuWmnArKUTlad0wVomStQfpW1t7gOU6nCAbcanTg1GCN+8iwKchNaPOLA3Fy1Tvy11B2M1x3N0WjcNIbjMntxhO+Ju16X8Xa0IT72T/PRfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8y9lmKj; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8y9lmKj"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so74809955e9.2
        for <linux-iio@vger.kernel.org>; Sat, 25 Apr 2026 14:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777153474; x=1777758274; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O/ED0Y4PmfOedW8XVTz2ekjmiBfYIa5o8q7WIKYBzL4=;
        b=T8y9lmKj7LncWlHTqeJXg1T6vERQHQfDn1q2MCzw+L3ukIndOYFCwz8BItQZAJoZfE
         zqzueV5Ytssqa6LM+UCfJdJRievS+p9s5ZZmHt2I92JjL1HNPehoW/09LXk9RUam0v+w
         LR7U7cOjIdjGSqxSdpVfFQlyY19Hrgn1zIdiFFBDeTE0vWVm+HY1qPTOCjhDXasFb37d
         jLdiASJszW7ldqJhc8y4Jm17I5n3E4OUWpnty+K1CZ28XUjj5UkYaZf0tvPFpCzDxZC5
         0T9Ic9mRgjqe8gQv+AugVBifWGrw+a+UVfQPspY2irIyCDPoAbn7kSNTJjRfpspLJ1fr
         V1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777153474; x=1777758274;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O/ED0Y4PmfOedW8XVTz2ekjmiBfYIa5o8q7WIKYBzL4=;
        b=NRpRoA3pNnbt6wC1M/mn6zLX6tyMxNx8oE1KEFL+/AiEZEFfm6p27qprUlLWw/0MPo
         f55Wxgroep1wrHsp8j8y2JbY8A0KFezIMo31R4BgmFdk4N98fimkJxInGDAvrF4si8j7
         boXQvP9v0dm9XMC7doVmDwu4Ll6bExPpVeu/w+yTKBj9L1KhM0QusOac55w9GA6L1dRQ
         CkMc3ANt4s/M3CkkpUUkCqFhdLF29m8Jet/mTb78OoqNtNMkpnWdPga8MEyGwbieFtNO
         hFZ5JgGDr94BwdZTieD3aDErOVvlgXnKxkQkoSgxOaGXHQ2179KPhQcNy8dR4COkZA7C
         1PIA==
X-Forwarded-Encrypted: i=1; AFNElJ9X6il18IfvhFxX0buhGsC1qSRv8MSbWX7TzS6ekdXfeEeWvI4CZiUkcR7WBqOCF1eYmJS3+wkgYQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOAs6VEwOVUawmhOWGUxNH+O83fkF6M7VeFsJUZ0XpMSmH1sKM
	ABjMQDTDoj9FN+73xSYOey4anaIWcdXZ4JMjp3Fd8vk6NDL8IozIYYjQ
X-Gm-Gg: AeBDiesWOFNnTi84ncPM+oAOLD9m+kdpqT/cf8BluKITUnmfzNy05QxlPcZEje1WdOn
	hYXTNrqL+/CWvaiouhPgUHhrtGUS+Vxk5TfOzxuX2uIWw1O9I9kP2NwfEemXAk7q84vYF8Hz/J8
	0W+KVCu9XUD/zs6Q5oBBImLeoyAo7w9XDgPHZGePt0n4IMYONDwlOd/j0Y66O8WHEDCb40vBPkw
	/RmnHysIb1T19oi8IapUh40mO+ItD35z2pv6Zct+gz+y/vlxB02/5fx4SqhtNnsnKZjzDvWgDhy
	QzBNnmIoL3GUCNRxtiPV+5yYyz2Hf6AZqZ21SJMaUBxhTo1jNx+D4DZYvZIcx9AzVuSBbQnDfBf
	DN4qJSOZ6t2xjh9GehFqwTddrcfgusrrkNDuIjF0ptBZbJfJPFyd8sV5Tq6TnBWqm573E5QKKKT
	PrqcEZxooCCTMTv7Snt3NkJ8SD6mhZjc3n3qH4WzTHb8JGJs+3IUOaKLNnbc1iGjqB2/0nj9sf4
	XfSB61HNQ9JTjsfT99dsgmF1go7r1xNPJn1lSxOPF4w05bTZ/Q6TSEKcfr73w==
X-Received: by 2002:a05:600c:5295:b0:486:f634:ef1 with SMTP id 5b1f17b1804b1-488fb77d0fdmr526610895e9.17.1777153473832;
        Sat, 25 Apr 2026 14:44:33 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc10777csm770862455e9.8.2026.04.25.14.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 14:44:33 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Sat, 25 Apr 2026 22:44:28 +0100
To: Alexey Dobriyan <adobriyan@gmail.com>, 
	Rodrigo Alencar <rodrigo.alencar@analog.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v10 02/11] lib: kstrtox: add kstrtoudec64() and
 kstrtodec64()
Message-ID: <7ytjm7q4noyhofptadss6r5f6ibrvntdtafntj6yjuaegnvjzc@j3lrtcj2lje3>
References: <4b7b42fb-e3db-4218-9deb-ad609e07bfb0@p183>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b7b42fb-e3db-4218-9deb-ad609e07bfb0@p183>

On 26/04/25 09:57PM, Alexey Dobriyan wrote:
> Rodrigo Alencar wrote:
> 
> > kstrtoudec64
> > kstrtodec64
> 
> The only comment I have is to maybe sneak in "fixed point" into names
> somehow. Or change to kstrtou64_scaled() because return type is not real
> fixed point type.
> 
> 	A.lexey

I understand that a decimal number is inherently a fixed precision number
with pre-defined scale. The "64" in "dec64" tells that we are storing it in
a 64-bit variable.

kstrtou64_scaled() does not tell me anything about a decimal point handling,
or that the base 10 is taken for granted. Maybe a typedef on u64/s64 to udec64
or dec64 can make things clearer?
I suppose the documentation header of the function would be enough for that.
As it is clear, the function intent is not to return a "fixed point type",
but its scaled representation in u64/s64.

-- 
Kind regards,

Rodrigo Alencar
