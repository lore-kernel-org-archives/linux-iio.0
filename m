Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B5E41C309
	for <linux-iio@vger.kernel.org>; Wed,  6 May 2026 14:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778079445; cv=pass; b=Leb+JeWCz8D22DfUvhlM4WdVc81MzJEJBkm8W7NZukcNqvcj5NmEotC/XYvQUue+xm30DlrWTLpNYNQyP4X5G5pZUl8u9OWSzcp+07ygpFF/JdQLosDcu6SH6qH5NNX7begexfWrYoZ7cfcYBzAx9iGQcg33ZFcJX2j90uO/R9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778079445; c=relaxed/simple;
	bh=BDfIMl5ACteH5DlTRdj/IGJ8iblOdk4SQmc1jAz7je8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vsr9D/DVfNQYiipJiJrPVaUVw+k6rwoFbRquDwkykSeOF4GZm+KyO1xwaLJDJtPHmEI9Zl9qJRgu4f8pw4HwzawygYtyLzMFggh00FBsboI7TzwqGk41aoIpCayoSFhzpUD2FOWwc7HDNAidgxvHQMTRssIvAoVqdolqOLHk/5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zape7eLt; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zape7eLt"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so63401005e9.0
        for <linux-iio@vger.kernel.org>; Wed, 06 May 2026 07:57:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778079443; cv=none;
        d=google.com; s=arc-20240605;
        b=hh4Iq01U5tizDJ94UWMB8KjVCZIQHCton6MhY/FRqO+C2w/o5rhS7E+yg6Hgy/l7jQ
         O7wnhm841ll22lm3Sm1Cofry+jBi5yN4vk6cXEhq/t4gOUXj3JaHytKZACnYmN5rZon+
         faBxAQLAEeZVfuVN1kLylwCP0HqXVgT1hsguccwVPJy48mLc6AqD/byqBmShZ9WJBBYx
         2L0ksxaM7O/gtcIznt2Ka6o3EdCnTawxwf83JrWXPGKGLkcOJO1856DQEEvaKu8Klj0D
         6KVbdLYOHJ7E8BNA8I4dZGaosb7vvgUvIRZVu0wU0KKqnr0jsxB9rsYT9scD3/otxPj4
         NEGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=M+4UMDFw3U/9MJ6ZFh9Cf8kh0a+EJoP/gxr4LLooKws=;
        fh=9NNfcx3Ce3k8CeHKVJhXkCprqik6PzBghu1yNDv0YVk=;
        b=MzpvtRlGyD8MSTh+KEZ/UnOY+32Wg7UuT3pFSRykZtVq3gMX8TO6jCSxdlFZrnx1tf
         FY7G4O1SCiLVYoP6KVpkviidWRxuBlMX9QHbo3VxuJ85JFLhuNq+QJHDzoHOuGOYOblv
         WMTGJPqcrh4ZoFn7WaZKiSP1y3kbREzS1enI+aDEECGi0TSkz+DAwE3kgHH7e5nM0WP3
         b9Wo2RwkXuq9QGFdjLrLJYjBg3SIa+NsRKdm8OLjU7X/sYXhGaKZ5R8cdoeAno+olNYX
         FRooNEQE4zaBFn3iWJovl6PmVcMzX4QDSsER9qqknzsuypJZ1lMpN0HEExkc2kSUHSZI
         JfKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778079443; x=1778684243; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M+4UMDFw3U/9MJ6ZFh9Cf8kh0a+EJoP/gxr4LLooKws=;
        b=Zape7eLtpx8vugQD8BXuoJUc5PE315XMTg+OgMZmlK4hXHl+tLPHwewL9wvCxiy2d1
         XwKGDwz986L3otyfjm6o2NIvgKuq9iFGxOBxtyVI2hPi3Sx8dkeI3b+O2+sXWhxuTL0s
         fWX7NZVrYWgbr+MtVSKh0HyBgmZZaxb9G9Ic1jpo+COKfaP6smt5yGCxejp3bpqLRHoQ
         6J1URxUxXj3MBB5SUwRVzIl+zfFF0XF8iEArT2Mo6Iv0GNvscPqFnXRKEc5sSLLutqqy
         09EKdDePyQd3lRTSrwVdxboR69a/heOqelrZUnV9m00SIG0hIPC9ktn8zKex1Ljl89DF
         Fyaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778079443; x=1778684243;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+4UMDFw3U/9MJ6ZFh9Cf8kh0a+EJoP/gxr4LLooKws=;
        b=DaLJ+sUkvifPNPteNoyE4iICxTUDwrUTFT05GBZTxM0bfWNFos2lQGTd2N4xPhxTvR
         5slJun7jW97xgljIA/sY9cCf4CSDSehVgx/R1+pbN8xAeFjKEX4FPP8PhXgV/1pSenph
         Q4oZVlZvcrE5iNlKNgaj5TXCLceYAvOck3/0hZP005ElHvkwkbJ2bEB+ESD2RVlNVJOc
         zGYWEVzvIpwmu4DFyCGB+bYPoimlQuZ19YNM6gBJghkal/6qRhCvDtQ7ENjMHozn3HK7
         6pkjy1/RRvJXPEh3t9QVelaRbUG3g9gkI9VNxSnP6BlGvTDnZrGqlR09WcszQdv61Vkj
         JUuQ==
X-Forwarded-Encrypted: i=1; AFNElJ+dlJJq7xKk/D4m+3gei3GuJKo4mc6Cf0aBbJIikeKMt4AdJWnkSDpj7tjoQncqotIhdqBD+aiGuxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZW/ZEGNSglJMo2bq0DTNXnMFgKHnD7ZdrLyfVmE6pfwaZBLry
	UEmzMvuUJ1sU5EkLpjt0bG0pM9PW3QeuAFT0a9w3tSXMKNreAXDHxmkVDPd0bm8AiQoewS4Ujil
	4eJp1YFQKqf0k+S+NvksV2+5srE7DxGc=
X-Gm-Gg: AeBDieuT681VS7AMKiMSTmB7dGABNcYT4GwTh+jQ2zQWAs4uBs2a8mYO0JfJhKdk53/
	a1Yj0ivLK8n3uPqs8+mTcQs3Qmq4c4Jzf1CosuCm79BfCumacz1ho8gR2tuyQFMnkaV0JpI3V0+
	brOBoq6s+Cu2SXuVvhwzZjHyG8UdEbKgwLYTUqlrs3K5DVWbbqBTOUQ9WXiBqNFKCKWlS2GSXds
	RH/yjNien0nhAI2xotQPIBg8X9ouxgZiiryrysju34vVsEA+oc3DLIh6OckIMNvC64EPnYtIi4e
	v/BfUMpgYKD6zSYthVEROyArqzE7RkB04MsabEcfhVAcEc2em2ZLwTbeG1YUj7fw0D2v0p6TmuH
	pRlqHv4BPEsq3zt2Jlrrismvd8iEiaoc030IG+ZzcgJ/+H/WJlQkae2PGPfIRXmRADvQUNPBEFP
	VQDcOSc+1OJhE4o855
X-Received: by 2002:a05:600c:a0d:b0:488:a824:fe04 with SMTP id
 5b1f17b1804b1-48e51f457dfmr65487005e9.26.1778079442621; Wed, 06 May 2026
 07:57:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506144359.16744-1-educg550@usp.br>
In-Reply-To: <20260506144359.16744-1-educg550@usp.br>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 6 May 2026 16:57:11 +0200
X-Gm-Features: AVHnY4Im2jBrijU8K8xqEUlSI_-zoIB3D08rq3zP30jyg1704ilVfjhpu8UAbQk
Message-ID: <CALoEA-xav-k064qsrNN8DumvggadWAPcV9HP82Uiem4VwgSs+w@mail.gmail.com>
Subject: Re: [PATCH] iio: frequency: adf4377: replace mutex_lock/unlock with
 guard and scoped_guard
To: Educg550 <educg550@usp.br>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, antoniu.miclaus@analog.com, 
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	Lucca Ciriac <luccaciriac@usp.br>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 May 2026 at 16:46, Educg550 <educg550@usp.br> wrote:
>
> From: Eduardo Guedes <educg550@usp.br>
>
> Replace manual mutex_lock()/mutex_unlock() calls with guard(mutex) and
> scoped_guard(mutex) from cleanup.h.
>
> Using guard(mutex) and scoped_guard(mutex) from cleanup.h allows the
> compiler to enforce lock release on every exit path, eliminating the
> error-prone manual lock/unlock pattern and the goto-based exit labels
> that existed in adf4377_get_freq() and adf4377_set_freq(). This reduces
> the chance of lock imbalance bugs.
>
> Signed-off-by: Eduardo Guedes <educg550@usp.br>
> Co-developed-by: Lucca Ciriac <luccaciriac@usp.br>
> Signed-off-by: Lucca Ciriac <luccaciriac@usp.br>

Codewise LGTM, but you mention scoped_guard()() in the commit message,
yet I don't see any uses of it in the patch (perhaps Jonathan can tweak that).

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards

CJD
