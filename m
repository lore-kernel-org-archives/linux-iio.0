Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F389B377575
	for <linux-iio@vger.kernel.org>; Mon,  4 May 2026 12:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777898288; cv=pass; b=Q7WAA1d53Dkgb70pddhd0CC7QkG0IXvnwFDiy6716LKNKJSALNlgQISd3ktB8eFykyEfYJpnTy1Yka1fbCN3QjDeou+6YvqLSH3zmlOPnL2sBQJDgbeN9uiFcZTSrss1P54iUSCEd1YmSkzKQaskPifOo7RpogOK/l5zeJPqWlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777898288; c=relaxed/simple;
	bh=FfqqxcPTcirgaqci39qUR5yKEhO3JjMgLQYRf2/CQ/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ozOPuVWu73OHQX2zssmPt5pgDuIQKrYGFnt0089+UVMzjvcbCT4amORtl4/y1QkX+Gxdkn9EeAPdKuSEABVC9IL/XZHFFTO5E8Dbu0CEtx81yh5kVschpcY2PfWxcdnxIrIOZ7cnPX3JRVF5GP9XFPfB+rPZ0L5gPANV5mW1RrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AtKLrD31; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtKLrD31"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-65492d097acso3512385d50.3
        for <linux-iio@vger.kernel.org>; Mon, 04 May 2026 05:38:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777898286; cv=none;
        d=google.com; s=arc-20240605;
        b=IFs+UG/QFn9B/dX1cqxL/wftSX3Sdx4TGoLc6LruaH0AUcupdk6nJGxmL4K5EISgvX
         EkxSJuVJU43FOzsCM5GgaxNw/aHuAVqUq9NDYSIyJ+VBYSBPqLy+Xk6EZKll4sDUjiaB
         FN5EJK3xy3QtZ6bBO3mK8865e7Uv7mqXaO5drri9FgKiuhwgDJIanoc441Xf2tXWlSMo
         MO8+IjYuI2vQhF3snW17zkbNHoTRZbhVRH5+MmNySkeBshH6ynR8yNeYPe0VXDpwKU44
         RX8WO/LPKwy2j/z+qXLsfe5nZJ1BBqCqZXswM5LtnfDDaxi8mdR2nxblpR7PF6tOJWa7
         Orfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C0QLzfdsy/762jJnx6qDN465oqLLc9myxsCHCvlD1PA=;
        fh=uRsetCR8kf7C1Jr7oP2k+YJdb56Yj5DY/oCkv8tpkEM=;
        b=JzH4dkC45W9ZR3AL+bXjPhLKwU2tLd0J+WDgY+WjJDYHDzaCrwYvl1svSCSR1bnRyn
         4U06AvHoz16OtaRiH5DAsXqh248wK9sboxQkg9ORy6WcE2dbzZjr4mab6QqSEW1rXQbS
         8pTyOL3q+WZsQSSeROQExGAH9jqZz0B4VD5d+eBpauPwae7zgzPEguSaxzfDuPYkKUwp
         ION0p6hD7qUmQujrUGBp+s6058t+LTQFG+kiZrFLitL2eBL+unp/rWdfjzrjxPMQ+Y+4
         hpoujRfrqTfc4M4CTP3F75gDBRy3u48/K2ZPgibbX2CBaSj0scF3BoHcCAEhunpQvLji
         Nhvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777898286; x=1778503086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0QLzfdsy/762jJnx6qDN465oqLLc9myxsCHCvlD1PA=;
        b=AtKLrD31KGx4eu5ysY7086B5GrEHrBEMFls+/ou4YOvlr5xso9adk8C738PuG0dpgm
         gV8aRbcBU3M63o+kkyTpr3nYRzsejbVYaho0nMgDJxQbH44x8QNabfNB8oIOrMOeDQ8o
         q5SYHgJ3ZwL6kOFMX3IGxFc0GXB2ZpedGl2arwR/FN2DlTSazuNLWXF6JsmU82wGkduP
         +yhXcSWiMacVOqm7O1Upj5BuQRsV/CQ8iJhq5ECPsxogwsvTNZHts9HheGfJOXv1BQym
         b0VnEf+FwvXF6nkxUmRTO2ry9+80XbD4u+bSuS22KQ/lCW7NiLrK1SZLOIHs0jOxUuZa
         14Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777898286; x=1778503086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C0QLzfdsy/762jJnx6qDN465oqLLc9myxsCHCvlD1PA=;
        b=f+HdxvBKror+UfLez8Qmv5TLGcr3czpy/0VTJ5leqcNceLocHDQksSBT8JnER6fa18
         gvbD5SZOVHlXQrKkYqvfJFZ8/rVXGHId7AP1cu9JXoVdEwJe0ZL4uvpMi+tg1BiGpz40
         MWAiGkxUtmPpXs29ZOQ0QePxaR+7uw2KAe/i3j0CdFUr5uRvwIk6reut/Kz8CTxyGwaH
         wRhfaiYx7PlNXDkwT11qYzX1/sAvBXDU8C5Bs4tFkYyO5TljS8J37Bg5xHt4fPUP0473
         RtRg4KDUDyv3IMsrY2Q+r3Jk1GadBgF6d2Nc7WaclBQ6bTo6L/nMJl6ww67IsRYX1jKt
         yfIw==
X-Gm-Message-State: AOJu0YxnCRYfVA5vortWarfjkMSR5WcynVcjv/+c7FZr1uJIjBn8PXVV
	QuPPiHFHJUqACVe34QAHKOfKBoAHeoDscGZSGXuLl8WlYAiN1a+ra7jwZnULnRFZJjZje+w7Qep
	qiA+RUAV8iBK5L+rkj4Ywrn9uZZwfEzhu3alj
X-Gm-Gg: AeBDietLjK+EzwnuYl6OPieRWeH0ne6kb8fIm0u45r5ZmmJSzBFrNWWJt3fs976ZNBK
	ajeYMs3Q9tm6dYSDBOzPx9gr22KYpKSPWG6RYhTE+NY/izvfOLwO2Y68umxmJIo/PjKTznTtqoW
	O5DFGmyX47TCdR6YdKB4+G/pbC8KifaVvx2YleEM3h0D7GMD6AcIQbs6GToXEz8XHL7EfM9qNSv
	KXo2WspivOzOAqgxmfjlMjrhQJEkPLxpftS7Vvlrra7iH/Pd9lMnfX0tSLQiVaIenbVgyRT19On
	XW90KQB3CQQOfzRszjgFJXGKLg==
X-Received: by 2002:a05:690e:4185:b0:65c:31e7:befe with SMTP id
 956f58d0204a3-65c3d9d2800mr8774419d50.2.1777898286096; Mon, 04 May 2026
 05:38:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504092059.1536094-1-angusg778@gmail.com> <20260504092059.1536094-2-angusg778@gmail.com>
In-Reply-To: <20260504092059.1536094-2-angusg778@gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Mon, 4 May 2026 07:37:54 -0500
X-Gm-Features: AVHnY4Lg-0PUmoelN9gi__VRkfiIwUkZdhPRMm4chQjF0h3N1NHgT8Rji-PnYMQ
Message-ID: <CAKqfh0GstbGF5VS_4BCUAyu2rDoXMWpcDwMOsL06EYVrQ1B7RQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] staging: iio: ad9834: simplify -ENOMEM return in probe
To: Angus Gardner <angusg778@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de, 
	Michael.Hennerich@analog.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 4:22=E2=80=AFAM Angus Gardner <angusg778@gmail.com> =
wrote:
>
> devm_iio_device_alloc() failure returns -ENOMEM via a local variable
> unnecessarily. Return -ENOMEM directly instead.
>
> Signed-off-by: Angus Gardner <angusg778@gmail.com>
> ---
>  drivers/staging/iio/frequency/ad9834.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
[snip]

Looks good to me.
Reviewed-by: Maxwell Doose <m32285159@gmail.com>

best regards,
maxwell
