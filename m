Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F36439014
	for <linux-iio@vger.kernel.org>; Thu,  5 Feb 2026 16:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770310619; cv=pass; b=VadlAtwFUtzknx+fKOm8gevPoMeNF4f85vjnTUGXFPtVY92zv48tGGSKI9AxqIjROTehbeVwC+w/bDuCZivww9D+cNEiWw9GcQXX0qlD4aaNZ8cPi8HwJ+GZ55umxwOKBv9tsmTeO8iLzYThNtAxk47uIPze5zFtUGOFDUiGUVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770310619; c=relaxed/simple;
	bh=FubNU7Nwqx3hIcILlR6yYjmKrhWkkBVcmDPP+R5NhlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m+grVzcSICNxKOWkmW3UhqW2badDOrugbfabL2eQbUj6JnMYX4GYjkLT/Q86Xd7Qfye09JSf59KbWkPG+7piQ1HTGK/P6/Rxt4x34iXdPAIkWXZ6Kb9B+OvklDR0L1Aq9EoD63M5ZwUdCuKBUaC9tV4olS25umsaoeCVKzdpizQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXAqkjjl; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXAqkjjl"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b8837152db5so176102066b.0
        for <linux-iio@vger.kernel.org>; Thu, 05 Feb 2026 08:56:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770310617; cv=none;
        d=google.com; s=arc-20240605;
        b=DYkLPqBqqkyjxgkn9eF+Gt/VS2lcCiGZBnTAhSGOn+BrM1RtOJeJx63FnNQSq0ukjy
         7LbHGytDrd5zeoAEcqy1XqnXa7Ez8AQra8d9KxS1wydOy2afR2hySz1VMb020qvx6kBZ
         8bBNv2bqEfp5yQ0J8GI3egNQH82sSgDqyJkyCan2BW+iBxpGZYSJTiIWVXGuPwdGzm8e
         tGAt5HKajoph9br/L7AegWw+Azm0IqRB6gdXiMUTnW4YRrvAu4Y8IiTgA0UChv0n4EuB
         R6w8f4VDWP1lrSConok3KlML18ud3fkLLnlw56xKTrvo/Bar7EkJEPrJl86SEyjAsd3G
         KLdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/3sQQzeXOoaPPSSsU2vRBnHaln2TVQn2cJYpZhDkrFA=;
        fh=ldgSh2oxjaIqT7kjaj5Vv/IDsS58CoUvAu+MZy9lTMk=;
        b=XbI6Zm2zdiFpgmDRL9BAW8ADkVLC1JBkrx8LFyim1PFgZDNJS71er9JrEIAd/8ziZ3
         YV3/2jGLLH7WX9NwFrQD4pqH+0uxtPFRddVifGXWGiRLFNuxiawke70YLUeLHMCOysjB
         VyIL5M48YY2p11eXQK/oN1ABbCq4wKZ/uZ5suJlf2z+S1JX5KE0Oqq/236OZ1ZgIIJpb
         eHmhfgcxMoaqGi2EK/K61c5DaX1/xHpg36UXEodN/8PCQLcOgWatsBA/RPmAqri9HK9t
         BnDUFL2t5/GwVfDTDjRW3zbpxZJqlVPk7Ixc1gxMtcpggSwCfZnSJNvXjJe2KaYD7n8U
         AcBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770310617; x=1770915417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/3sQQzeXOoaPPSSsU2vRBnHaln2TVQn2cJYpZhDkrFA=;
        b=dXAqkjjlOQwDw2Y8mtbL5oqyX9d85WJRV6cvntFwEEIjq3w5ViBDDXYTy8WjZ3VnJM
         00nVfFmZIKJGMv404DDgkGmRBIc9SqzGEFzLI/Xt4iTSAuv7EwyRmiYBjQPWUhvpig0R
         9PBthrSamemMHlbqXnlMvK9XD5oLgoXeJqY/D/msQCinBd7UEvka3cMWzQrBcCB4Gml/
         1ALWeA8sBw+tdUfBx0aPYDJCYLa9P2lja93YR9BvRaYOEyxFlfm8RYkqGdbI1ZKWjYGD
         amd9L+2Lhw6JX05uCy77I1eV0e3R5UgYAXH4Qo9fJW/AStd4lXGrFjx/t/c9XEWzJBH0
         n4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770310617; x=1770915417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/3sQQzeXOoaPPSSsU2vRBnHaln2TVQn2cJYpZhDkrFA=;
        b=eLYWdkOQ1ZfHOZCPiFVSsCr/7PKZiLJIAThThxDJIyFfxOvil0SUHSlsSKzVGbcbkV
         dom8NcZROgktrpz2wyGyp3b+bkU5Hx2l1N0JkR2obAzjoukeCzYXxnp2OX4FM8t8JMr2
         RfN20hcLIp0NHQFwH3R6LKprP1jYUVOaL4K37doevX8+Hk89hdnCnyIxvqFhlIHZJT8h
         QMr1NAz5PfW9YtPsu8eodpEcrJ95qqb8oJ3GO9ht5ezeDUjs91DHNUcBeres+L+LOYV0
         kAWEkHFjwxFdBCH01lXV+otXwrs8DIrtkQAUymgoAgkHDFYYajM/zdG+u+jr3vMZFOGZ
         wnZw==
X-Forwarded-Encrypted: i=1; AJvYcCWMLo70rMxGsVxipEB1ApMH9a5r3YRqt/1bU4Pir9camgt3zrWH2dg/uLBuioumf4yAxqcqZbVDiXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoCA6NjwPW4yNxEYDM4fgrq/8PDP5/6ZF+lV+cTtbDps5xerD7
	79WGlqst9lWAu391PZeB7cKdBkvmNCSEbcQeWZf4+543xFgN1pmmMmeTuMSnpsGpA9FiizyINq5
	3I/R3Yl3HZZP2yqcGpiLFfM/Xwodfrfo=
X-Gm-Gg: AZuq6aLB9BGZ7d6jHYahrv/F5gMnAsjF+Iyn+ko/AfdXVwY5GitVs9gp157dIyegHj2
	YPcElHyabLodzs8cCxhcXi1IKlLFXBTPU7bc8D52MrB9+2JYyX33Hv+59Eo9NtqzAViRG1yZH81
	YYRFXHI2UrHMnEGzzg3QEK1inrBB+9C5Bu357Ctz43RXuHXPkklaKsD7XzCHxRXvkQMvDkdZXDi
	VSZqkEXyeP7i3CGnFK6VbL7DeBv3qO4JxNmK3UhabXMpIdLd8hvIL5fMQ48deQS/qkirnpC85gH
	Tx5n4/bzlMeHJfH/wsbFK1Zaos+supXKFFWiFcSiuF4xqvvkenO5WOpGMEm6NYUnU5x/1Ts=
X-Received: by 2002:a17:907:d0c:b0:b8d:d9a7:1b74 with SMTP id
 a640c23a62f3a-b8e9f373a93mr420024366b.65.1770310616891; Thu, 05 Feb 2026
 08:56:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205131234.3244467-1-harshit.m.mogalapalli@oracle.com>
 <20260205131234.3244467-8-harshit.m.mogalapalli@oracle.com>
 <aYTFUMe3jUO_bGCr@smile.fi.intel.com> <34bac81e-6a6c-4cf6-b370-beead4f705c1@oracle.com>
In-Reply-To: <34bac81e-6a6c-4cf6-b370-beead4f705c1@oracle.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 5 Feb 2026 18:56:20 +0200
X-Gm-Features: AZwV_Qi0HB7b0WeOF9-L3bHR_a1LclmNjzGpK8yNC1n2BCSBY2W5nybVUSREUUk
Message-ID: <CAHp75VfSYGoNUTqDb9WLYNYeChkB4mM+LEBpyRVnLOEKkr==WQ@mail.gmail.com>
Subject: Re: [PATCH v5 next 7/7] iio: sca3000: manage device registration with
 devm helper
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Antoniu Miclaus <antoniu.miclaus@analog.com>, 
	Andrew Ijano <andrew.ijano@gmail.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	David Lechner <dlechner@baylibe.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 6:51=E2=80=AFPM Harshit Mogalapalli
<harshit.m.mogalapalli@oracle.com> wrote:
> On 05/02/26 21:59, Andy Shevchenko wrote:
> > On Thu, Feb 05, 2026 at 05:12:13AM -0800, Harshit Mogalapalli wrote:

...

> >> -    struct iio_dev *indio_dev =3D spi_get_drvdata(spi);
> >
> > Do you still need spi_set_drvdata() or analogue in the ->probe()?
> >
>
> That's a great catch, I don't see spi_get_drvdata() anymore after this
> series, so yes I think we should get rid of this.
>
> Should I fold that into this patch in v6, as spi_get_drvdata() is also
> removed in this patch ?

Ideally it should be done in this patch, but let's wait for Jonathan.
He usually may tweak these small things when applying.

--=20
With Best Regards,
Andy Shevchenko
