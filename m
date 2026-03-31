Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9011A146A66
	for <linux-iio@vger.kernel.org>; Tue, 31 Mar 2026 07:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774940531; cv=pass; b=KhTIh0jtk1DYSCNUNvL4UMz9WhL3ZprWDkGHtZhWvG2fAnLEb9GvzlvnWUGws97IbenZBs9BNNE+RUplnvDdEw33RL0e3WNxpGXHIjWDArIasCyqeS6QoCHQ5Kxx6nwuhodGjlXI0u7ABcAf5HQhEIMbHq7zydpZ1w1Rgp6VnnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774940531; c=relaxed/simple;
	bh=H+MKgFVUuVj/Slgq8wTZCJVhrpFtx3ZioB3YwLeq53w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lj972orLdCFzvyzTXBLYsbYSoosRXw//IkCZxWbXOfoIHktR4iFDoKSjQYoYDJsn8snZOiIL8Sc1VYsXQxOvwIUNK24PMBlddHuiVztxJ/2sRcB2ogdyiwGYQTKKOOD9imf5muF4/QH54YsgWjU6/IaGBVwb7D1i8ZhoiyKOJ8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RzakkqDD; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzakkqDD"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b9bfcbaa81eso30262266b.1
        for <linux-iio@vger.kernel.org>; Tue, 31 Mar 2026 00:02:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774940527; cv=none;
        d=google.com; s=arc-20240605;
        b=MONLSE4tGdPG8btUDcmBoYgnVeCr7Mca41h+YHraoDHc9hmsKUbhDpBOu9h24uxniO
         6ifN1c4UwzxrbL2yHreb/eJ4LHAO1/4wACFXJ3SFWcIoKZenzGHj7gqLiDn2ECIzkyST
         8V1TCRUftqtznkwZRKH/gU6IbbwFyA/bOuMWVehT2IrkAFzUr4ciK+1fGJR5z5zBZRb4
         YG4934HHIYpeIBX8FhXdyQ/+R5Fo06cdqPo6Yx4R8x+8jC+8sckQs5j8XafQ+GCdwtgb
         6ey6R8aDYbso04GshvpZqRFwg9yj+6fuj5NlZmINzj9hUVIoFxAlKKKexauymCf5aOLS
         1hfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H+MKgFVUuVj/Slgq8wTZCJVhrpFtx3ZioB3YwLeq53w=;
        fh=g5d5xb9HwfiJOj7xJ6ThemNl9/PIMCZ5oub5iKV9azI=;
        b=Q+JjWIl9IDm68jkIkTIRcmyAAJsGNWXiv+HS+v6WHevxOtuW0KGVIGBhTMgFSjpH+o
         HeaaONj1f8YwXBHnTsmZ6o/avHVesKMdvLH3zLWbPGjZeLsPhAIXkrtnTjXGa6nYiqIQ
         NqFbUOT5UznJBefIJUNOd8BrktLSXnk5+e6LXzTl+Bxa3DLsE6qj8/unsmvD963/5Hdx
         4eryy28+Kf8cRqqHJeqlT56EzOjq3PN7OTh0vbKKk+AjRWoTlLYcEFtnKTR8XcZniXP3
         RYLzX17Z5XCv81xFjdic1Ry0bU2Ma//XH3LFrcjFcsw4bYnP99LR+CkJEL24abm+5Al+
         YPhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774940527; x=1775545327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+MKgFVUuVj/Slgq8wTZCJVhrpFtx3ZioB3YwLeq53w=;
        b=RzakkqDDSQ4iJh5+ErpgOuSH2brb1qP1/XOTH29fv7a38A0O894JynChyYVWFin32v
         gURLeAcrNiBwK/V8CJJCalIvmXbwEwoL37eG59ZBRwafyG66HpEfK27O2VtOJnNQjl6B
         jKQqwEtuQeFgw/lCk90C8JqkE1vFf/XDxovf31/CG1fb0QNQ6Y0IlqnEtwGoiBcmMOPx
         VGDxrcH6WNoI2svTmSY7pnnT6V0/zbNwDaQ9r8DSNhjHSOTEx/fPkGV/pQItP2DXNB/B
         t9jR4G02A2MEEY5JMSCK669CUw0yxcSft9J1nJ2Y7UlPdF1S8hic5zCu4i3YL2GgIvgB
         ov3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774940527; x=1775545327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H+MKgFVUuVj/Slgq8wTZCJVhrpFtx3ZioB3YwLeq53w=;
        b=cmv7mRGS02wLzoqVjVymO7+raVWgl1S5GRUttCnhFxD47zJfX+zsUHawwSL5f92Bd6
         JSQAz0ar0qu3HsSc95dOBFRjoOzJZOaM+AK/9S2oBryCBfoi6+RSaVEh/7Ks5GGtWje3
         cdJG+d9647aSCiLquB+giVuTzpwyevv/pcJoZllSQdtyWpxcJ7GA/JYe3TjZqhUi37+u
         ousMLmaEEZ7lIaIhpU1JgrcApXSCSwWxTLa39izWhQVM7XB713YPqaVn/nKHud3B8DYd
         F6xcJWiNUJbDH0R+LUHR1D9IgMLgTViuVzSc2u47MOHg0q/90w6eimEuqAT2OYOX4jZu
         Yewg==
X-Forwarded-Encrypted: i=1; AJvYcCVqOmjHYpFgav+tP/xSVwnonJ9jFJU3fYnuQxGbRwaAnqq1vO1epxose4IxjLzFGSoc9oytcA03MmM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2U/Rm1mZ+ig9xlO6zOBtoiHXvecYmNn0dDJE6l8iEb3kFqo87
	xqIFYGSW72ejtvSLENYqZP44+YEmS0AeJZLX1/WWCUznD1F5SgsXV/s89l5cfleAq7SKCBNXspl
	olNISiIK8Smi894bV7U0psTMhKG/X60I=
X-Gm-Gg: ATEYQzzhQ6QE9T4S//cWeS16303rvJjypLIeTDonXcadF+VpQtSUr46tXEALNmf4e/G
	itCBQseh9/NPdD5SsPf3IskjKL9WsvdlmYorxHkweffCv7m6IHBJ3lWYM5pzpc7tak888uESqQt
	j6fnomLb9KPaM22OLZw+TW0Cd4tadr2c1FatqEH9xR1U8AkqKe9jqimPorfE+AXrgUNOZlCE8X9
	lTpLflcPn4+1OJoSANfYzoCISwzb0h9Z9qTf2c5Ay7836O/nxsuc6JflfRBC81lCKPRTDLjslpl
	33wsBFuzyFopsZWdaLiz3Jffp1PfKMGVs2S1BWJBVV4wB1rKiEsM3/Cydh1nINdtU4xi4gOIETd
	TtCKBb2Y=
X-Received: by 2002:a17:907:3e07:b0:b9b:1dec:f618 with SMTP id
 a640c23a62f3a-b9b502bee3bmr964353566b.7.1774940526523; Tue, 31 Mar 2026
 00:02:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331012457.9324-1-carlosjr.jones@analog.com>
In-Reply-To: <20260331012457.9324-1-carlosjr.jones@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 31 Mar 2026 10:01:30 +0300
X-Gm-Features: AQROBzDz3nI074KsS0a-bN-vuA7hCA5lb4a9Fokb5cxs105vpO8whIO9EdY68Rc
Message-ID: <CAHp75VfkdmebYjBdOnkqrT87Sm9PR8OehYvPSwwxiY9zq9hfbw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] iio: adc: ltc2309: Add LTC2305 read delay and
 optimize chip_info
To: Carlos Jones Jr <carlosjr.jones@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Liam Beguin <liambeguin@gmail.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Jorge Marques <jorge.marques@analog.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 4:25=E2=80=AFAM Carlos Jones Jr
<carlosjr.jones@analog.com> wrote:
>
> This series adds missing read delay support for the LTC2305 and optimizes
> the chip_info structure for better memory safety and efficiency.
>
> The LTC2305 requires a 1.6=CE=BCs delay between I2C channel selection and
> data read operations - a timing requirement identified by the hardware
> designer that wasn't captured in the initial LTC2305 support
> (commit 8625d418d24b ("iio: adc: ltc2309: add support for ltc2305")).
>
> Additionally, the chip_info structure is enhanced with __counted_by_ptr()
> annotation for improved bounds checking and reorganized to minimize
> padding.

Now LGTM,
Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko
