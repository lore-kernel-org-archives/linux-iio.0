Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4032D97A6
	for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 17:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782666835; cv=none; b=s3dzT3b+KuK+cVWWj8JKlRvHTuWoz/2fNfu7f/QIes7tfQNu4PwCyxI/O82xIge2UdYHYsC57wDC4tYyFozLHuNPnrxIppDX/YqMGEQC68Ciy69UsVs4FD6xeV4HSaDG3GkwacCO0isdP9Uw/oAT/I68xh/dywlOCbpwaPoP2dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782666835; c=relaxed/simple;
	bh=kBrCFlkQB2Fwi5kxRZcJtwJ2NN36YlUGN/+bRnndk8M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kgfOB2j0yZAolLm6mHFnZp574yV2tqX/iT9GHU2vOkAi+aHsIkJauYU/zc4spsJmoRS/XwfqM2o17mAd0fqW1bYOte2POQHykqfLEpe/xDkXgYWb28BFzSU357WD2G1utXLdPxIySjh7l5oNa/uvcMIuoXwjldRzxxevMKJKdxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cSbUCuEG; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSbUCuEG"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4926ee9e8d9so10252095e9.0
        for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 10:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782666832; x=1783271632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DvMolz84u/CbpdbNk+f/k43XZGQjIqU3Ys7Lwiebayg=;
        b=cSbUCuEG+XtTa7Y0WQgSFxLXGJwQL7LOqyuPnaGLgRdqTF4ionNGM0fkrRdQTm6n2a
         xu2jcpIN27oHVjK6dPl2CCbFkCv+tq+U308EdoWWUB3yZgJtq8uqsd6Tmf+K6WemG49v
         ByYkqutFYQeeGndSHBZDLPc2oGR+6JEQKr4jZ8uVL5GmoSE0XCQj7cjmLQx66SKf9zBJ
         bZUuET/sENT1BmFIU0huHVztZQl+fh2kyC+z7F52ztqwBYhsyStvIkIHiEsOWHe4IoQB
         lwr3XMDPJ+HoPopax5aZiX3lFIq9aFudeU9fJ8zs/F1xK+/JZfZhTzeO7zKVJ7M36Zuu
         CKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782666832; x=1783271632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DvMolz84u/CbpdbNk+f/k43XZGQjIqU3Ys7Lwiebayg=;
        b=pjJ8cH7nGKxScGXhGemwVt8x7Em+iDAU4dl84jQEEd4QOhI62xaP3uV6vhjaeG6dte
         RFrhpUaqlTCd0zqckPUTn1fOhdcy/n6rkhLpBP9+kcPUiBCGUitrvj9QxSQOgDKz6HsH
         I1KYI1Xb7wFhrwK+daXSI4gksmAJ2klKa0Z3JMyg/sVeL+pDvd0pHIpBXW/m+wZPJ5GG
         UKabaux4S9TbgVFMJq1AwRqL4cCPkYaJDpmvZ+75cetJ+VNGsFMdWtic+1smSeY5H3E7
         71EKlFFvGmC/AIhpXSrqWBi5PGkgik0rNBxLQZ+7zP+bdi/Zg81YKf+W+Vo2KPzXt+KW
         yRyw==
X-Forwarded-Encrypted: i=1; AHgh+RpBbLSC0qpfvA0r6R5XplF5xde0DTpmj2F4kiUqUcvs2cusMGUoKQCoFIpuCzcGHs9M6lxqiJxXO+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqBgTR6bUcfAqSDoEfYuFaEoKMKzuOu/npVYFJ8bTO0QPgFZ/R
	OjVpSVQQus249wYWbteIxWAC2XOERLNzOC3FlIGwdQJo2NuAzzrVLc9casuTNg==
X-Gm-Gg: AfdE7ckX8vuvKp+3+5Xi9q6gqZUAH8N0VkfWsM9/VP0QX9k4AGYI0ttb4iC8n2J6W8F
	WQens22UGECUY+QNekdHDnXEWqze/0Q3NQ+oBlKDPV132GgJ7bl4o9HWdNuU2/v5PTMW+id4IXp
	6QSlC0fvaP8jZYbBaabiniRl4Ayy6O3k6q1vk20HyyWV5Fua1ymeCjUdHRDyaH9oTc/mH6Mf+Zj
	qlsjWyrj9F7LoYJwSK7/0zlBW+UkvSf6fTJ1tKSmCt9LN6joPD84OvGcKZGx6glElCdCX4LdNNd
	bFOTLtVoqpLpAylcReoir0e3Ccl/RQEpbDEUY6cpKMHPOAemFZLLIpBUpcpLjI+ImBO75iPWRFd
	7QrkL1Syn5UrqTUIe/bRuKhNwvKF/uFfy/pf/pvtbApIDr94Ar3NwAgrrVzrUxNfv/F0jbe9f0p
	0vzDj4sHXp88azZpiYgvzjOyumyEKd3vCdqtnL2KLsMQRMAheHRQhFtrnRu/nNfwhxsfnKJe294
	aMNIjrzaxt/okRHQwmARACJibr5eo78PDBmzblIty7ZS/dWLj2dqaoa/YDwxdJTNnfukwnuGl5Y
	Ut7JPA==
X-Received: by 2002:a05:6000:71e:b0:472:8043:f00b with SMTP id ffacd0b85a97d-4728043f1d4mr5023483f8f.14.1782666832292;
        Sun, 28 Jun 2026 10:13:52 -0700 (PDT)
Received: from systembl0wer ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-473563c2df7sm4145748f8f.24.2026.06.28.10.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 10:13:52 -0700 (PDT)
Date: Sun, 28 Jun 2026 19:13:50 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Moksh Panicker <mokshpanicker.7@gmail.com>
Cc: jic23@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
 dlechner@baylibre.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH v2 0/2] iio: adc: ad7779: Remove dead code and redundant
 error message
Message-ID: <20260628191350.583470a7@systembl0wer>
In-Reply-To: <20260628145734.77191-1-mokshpanicker.7@gmail.com>
References: <20260628145734.77191-1-mokshpanicker.7@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Jun 2026 14:57:32 +0000
Moksh Panicker <mokshpanicker.7@gmail.com> wrote:

> These two patches address review feedback from Joshua Crofts on the
> ad7779 driver:
> 
> 1. Remove an unused completion field that was initialized but never 
> waited on or signaled anywhere in the driver.
> 
> 2. Remove a redundant dev_err_probe() wrapper around devm_request_irq(), 
> which already calls dev_err_probe() internally.
> 
> Moksh Panicker (2):
>   iio: adc: ad7779: Remove unused completion field
>   iio: adc: ad7779: Remove redundant dev_err_probe() after
>     devm_request_irq()
> 
>  drivers/iio/adc/ad7779.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 

You forgot to pull my Reviewed-by tags, no need to resend:

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards

CJD
