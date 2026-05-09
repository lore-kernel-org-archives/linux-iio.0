Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C513624B8
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 14:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778335763; cv=pass; b=E1HqHeJOX5N5AbFUsPaMtjyPfNKjGaCUyIY0w9Xjz0qgfFNWN86dnGYtyWZl9VCiPrDljLHxM0oCzBxvQyG0Y4eH5PKqQjI7wwKjJozfKhsyGuGAi9APLkODkRwVpQhus/NtKQgUxmQVh8PO+Axe9bI3s9jZLPsEI8TL2bbT59Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778335763; c=relaxed/simple;
	bh=CSX3MGFSC+bFTsmH360wzlSq99mNh1uFyupaTqE/WUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dckbRRQvvSHHP1DWZvDZo9Eq/qpchn448C63XV5/D3vg2RgcyaoF+tGhQFF6D4iWSHrxevGUPJEOvhE7uFL6yWiPNR//Q0o/+K2VNfA4T45JP2NJMDkL4DYwVx4Qp403cipN1CwOhyCzTvZws4vs+ivZ4zgdWHGYCrwSLG1OS8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=qqV78xNu; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="qqV78xNu"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-bc1f0830f44so726778866b.0
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 07:09:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778335758; cv=none;
        d=google.com; s=arc-20240605;
        b=Kb+6BPokDYakklVTdZf7avg7rXJ3gOi97mBs3yTHwJZ4k9MaikMruyr5zojOD/4o5Z
         yyvCsjcIafhyXGYHfHRxuAgqm46vhhE4OrkVOtEiU2nGoXdbkNbka6esgseAfOwPrnUZ
         bozRH8paDqzWAw7QBTJ6OaY0sU5OIB44LgtNhE8s9tKH9bEetIzIUbDiiaym2gsWLyAY
         nuLxikTfKav5QiSiUF68U7I5TbRg4wTLlqRUtrixb72W5YlHxP23Birj/G83NJW5Gkk0
         bFTGkbHoTcOlEq94Cn11wRnVkLP+0PLmYF2m0+Ttl5UVuATymN9HVmkKU0BF7S3uzS0Y
         7ywA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=W/49pzHhpm5otGs5tOxr4XckSFxbaWtW2tPnseYELmc=;
        fh=RDHUH0DrmlwK6h4cxBv+JcvOG0hxld1qM4QohkSRBCc=;
        b=LHnnQUcqOC13Fpk70FoBpXtQFeNaDezfoQVgScJPZmUcqhi+X4J6FwBKQOlvnMJuUh
         p1GTtwrmOftIRiAFYjn1eWamYJhu5hXIJ4BJ8Rz48LUYNNhRJv9qSwYYpxf+ZgXOoICU
         xBYxtibWL60XCy/Mk5i/TedH91Vffp94bO6OL1nwyKKOUcDjiJCtyF07Xr7EojnWIkdf
         YTcBIzjwZKZR9ipE6vH07lJhRNt4JXaGeNa3yefvXozlMh66XwnxYaiD+ceaNcM1oUyf
         AV9atSJ0LugIU8J5XnNO8Lvd/xlewxgUNzUMN61nA+B/y67tuJOpOuCXA5gHC16wLnip
         NQ+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1778335758; x=1778940558; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W/49pzHhpm5otGs5tOxr4XckSFxbaWtW2tPnseYELmc=;
        b=qqV78xNuq30eYJY77Wc9+f4p6fLwuvYgbj9Z/XYcI6LMII+3D4VJE/ln4KgMMGBF8i
         io3ANw539ugiN9TQnz+5CUuShziTXyyFS5sEIXrH4SfciN6dbSJQtdj4WSXnyX9DQnVy
         5/+4ehFjUeu4PrdYXRxk2+A7BBq2IkMDqLYQlXpjgCtJ/2ZZ6h5X5TwIaFqVmYtAiZdz
         e3FCasWZDNC5/pWIFd9NRuBXWA97Jdrv+vrHuzx4lJuraHTebbfUD3u0hfU6RzqmY/Ck
         4HNGKcxFjCEH+qfVQn08nxqBQQlFOciIm86uczYMaxVJiSAv01xDy9BkdJG39MXaJ8Ng
         4Vkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778335758; x=1778940558;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/49pzHhpm5otGs5tOxr4XckSFxbaWtW2tPnseYELmc=;
        b=mo4c9AsZ1ewx53o26lj3nvW7/yU4mjb2t7tIQ94nMY2FhuXfqNlA7K5O8396XziQEv
         NyowqE8IRsB1K19uGa22fUunlMUkckUtz4w9YHP15L7R4/3y3UM8/xZqZIMMEXuEpvhc
         jvyFYfU5XjN3R+cBdBcfNVV20aWjS12LJJ36EcLcs0IQT9zkCYZ0vu4U/NvkC4mMSaHK
         wueQDRKHEgzELk4egtshTNeqO7SqpvxgCVuJkyNG0KZo2q3EzAxNzoEr0AN5+j70sLqE
         xpbyhnUG25ZMrvju1jugyUGkFlh9iu0degPDdhp+HyuxYLBkuiuAsnb9IpPCCB7y6tDS
         rZtQ==
X-Forwarded-Encrypted: i=1; AFNElJ9dLvR5bWhdMHNWv29MxMPFD9fYq3wRX1chuuEndmwHmWqDl1XEtv5SiAOSmn3CpM5Yr8DEZgGvpk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFi1Z7WlRnDaDTzZO+6qKtLBi4RG3CYdd2AT4XxYvCcFFoA2+o
	uFnwSgDN1GjlClqH5+7njZ9SZYHEJmddtgnwTFWkxR0wOgWn4xL6nOmytuc6eg4AkH+wRPlecLN
	YdByBtyuuFjiPgDWuUrjPiESHDUAf36T2ckpDSVHKag==
X-Gm-Gg: Acq92OGj1IUo101XEagnDSNcuzyjKRuo0QLsKFTyM2wnIMZ/klKy1Tin9SkldbuXPI9
	d9v7go5Q53I5QISreyGxvHTWe7MlPqlMCBZudeZjNVOqcUWSFDBodncalMAjMJ0oGHnt6qjZadR
	zlzj78HSOF9Tgi+vf+ReU6e0zIC15kfrQtMmBgkrxFs93z+pVWEUBzguOjMcIW9CSd2EqJbGyiT
	zWWFWhFJ2GMCZ8YijSXr5LEUsHZJpMNvsJQr4YBiNJngMMCs+w4nTUe2LvEjGiLVxNqYhHbCQ72
	+KC3Udw=
X-Received: by 2002:a17:906:4792:b0:bc6:bb4b:1726 with SMTP id
 a640c23a62f3a-bc85d6b8d73mr644135266b.22.1778335757995; Sat, 09 May 2026
 07:09:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429224401.11818-1-marcelomlage@usp.br> <afLyk-kNyZkr_drR@ashevche-desk.local>
 <20260505172214.6f0025d3@jic23-huawei>
In-Reply-To: <20260505172214.6f0025d3@jic23-huawei>
From: Marcelo Machado Lage <marcelomlage@usp.br>
Date: Sat, 9 May 2026 11:09:06 -0300
X-Gm-Features: AVHnY4IrAP4HSXUoLwQWtf-C32p2BxrsMI3OLjmRANLwyfjgBFOab41TXgre33Q
Message-ID: <CAO=vGZoizk4wLU7oRET-HxDOe52_82OXyyL1G1r4dzLhJYKv6A@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] iio: adc: mcp3422: apply bit manipulation macros
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, andy@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 May 2026 at 13:22, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Thu, 30 Apr 2026 09:11:31 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
>
> > On Wed, Apr 29, 2026 at 07:43:59PM -0300, Marcelo Machado Lage wrote:
> > > This patch set rewrites several open-coded bit manipulation parts of
> > > the MCP3421/2/3/4/5/6/7/8 driver code using bits.h and bitfield.h
> > > macros.
> >
> > Both LGTM now
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> >
> Nice.  Applied to the testing branch of iio.git.

Thanks for the reviews! We're happy to see our patch applied!

> FWIW Sashiko had a field day on 'whilst I was here' things in this driver:
> https://sashiko.dev/#/patchset/20260429224401.11818-1-marcelomlage%40usp.br
>
> Note that the DMA one is wrong. Some of the others might or might not be correct.
> Maybe some stuff to look at if you want to do more work on this driver, though
> you'll probably need to work out some way of testing fixes for the more complex
> ones.

Thanks for pointing out Sashiko's thoughts on this patch.
Unfortunately, we do not have access to the device for testing complex fixes,
but we'll definitely study its suggestions for next contributions.

Best regards,
Marcelo
