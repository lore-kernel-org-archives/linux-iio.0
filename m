Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D42136683E
	for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 09:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771926989; cv=none; b=pAHO53EwWWlIGtWoo3oGhDXknGOqO6a/qIeGP/QVcW0nVpU5vtK7ECI4jRw5Li9mY/0YxpwoaMN8lYxoHBjc4g6ERyYFRUrxlBnRAZo6T32AssRVA8KGgb1at7igkp2mA+rgNmFpgkD8I4cYxHA48TSCoiJaY2YgL0xgd1qLxrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771926989; c=relaxed/simple;
	bh=GNn7ZqG2KuyGC9029ockPC6Jxh9/GffHuzyNc5I/GWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BAO38fHVpZd8B0lD3agEc21uiWg6e9YYpgKW1r6zP4VO4zpaTD8lCv0PILapCb0YKBaRaEjitDNAMw0VxyiqW+MZSCP61Xc8doOf6u++IbF/v9M4D3Hp3vyXITe2/vr/LNXG1WTnW+xSHpdc+xFaX/APAg26Er7gW2Rg+cGUdZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iEM43yAH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEM43yAH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23CAC116D0
	for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 09:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771926988;
	bh=GNn7ZqG2KuyGC9029ockPC6Jxh9/GffHuzyNc5I/GWA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iEM43yAHs245N6oMF+kbIpQ4KkSxtsmmOxrK7RqvPA2B0S5rIzIg+GsXpAVjylW3J
	 /pCAaGCj+CBvhbPayx4BidF6+bgws/iS/hV2zE1vX07fdeCRbE4ddoo/yqmNnV9kQ9
	 DFF9+Xj/3P1JTNosUa3ovOzwU6WwiiOYNdI+q1KuCsqB60n4La2mvmWU+iBZA2PKyI
	 w3rA1B4mM6fzV8H1t5Mq67TpWgcEa1HsJjBLMRq/Fkw2zQgzDmI9DmOKzbz+C6J8ly
	 Y8GTt1laSKETX0uttZ9GVnuwT76OphggYNlhkVBWZLiSE4fJ+EHH8OvGbxKusLkbLw
	 mxsHgdNxlYUmQ==
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7985ce90542so2953797b3.0
        for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 01:56:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWM/v9xSbJ5mB8vX9tS0wnGeL/nnQPRzijAeC29WBlFWO9RfEzzzfXU4CBG9T8HNQ9g0W9RWd7WIhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXQcgZ3u8G78fxOX6SZmpwHLAVHooLT//HoyJU7oPXeeFN0PK4
	vVoCUBzo8FacddFagmt15DbNcLIatPXOTQ4sA8bOD/j6r+LfPSaHbyYW99w+nMDi5Pyi/Jl5JSp
	ianr9saR7QI3z95nE405u9pXG+pM/2yo=
X-Received: by 2002:a05:690c:4b85:b0:797:ddf2:7cbf with SMTP id
 00721157ae682-79829181eb0mr92284997b3.66.1771926988319; Tue, 24 Feb 2026
 01:56:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224023511.274038-1-ethantidmore06@gmail.com> <20260224023511.274038-3-ethantidmore06@gmail.com>
In-Reply-To: <20260224023511.274038-3-ethantidmore06@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 24 Feb 2026 10:56:16 +0100
X-Gmail-Original-Message-ID: <CAD++jLkkQ+PA2a7cZNptuAwxo-UchdmH=0nvaqq2Z4ogACx4ag@mail.gmail.com>
X-Gm-Features: AaiRm53aY4HT7hmp6mmhRdQZyOLycu-Z2Xy9W5CIrNqDc8VZO3lnzNQJd_d6OhM
Message-ID: <CAD++jLkkQ+PA2a7cZNptuAwxo-UchdmH=0nvaqq2Z4ogACx4ag@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] iio: gyro: mpu3050: Fix irq resource leak
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 3:35=E2=80=AFAM Ethan Tidmore <ethantidmore06@gmail=
.com> wrote:

> The interrupt handler is setup but only a few lines down if
> iio_trigger_register() fails the function returns without properly
> releasing the handler:
>
>         ret =3D request_threaded_irq(irq,
>                                    mpu3050_irq_handler,
>                                    mpu3050_irq_thread,
>                                    irq_trig,
>                                    mpu3050->trig->name,
>                                    mpu3050->trig);
>
> ...
>
>         ret =3D iio_trigger_register(mpu3050->trig);
>         if (ret)
>                 return ret;
>
>         indio_dev->trig =3D iio_trigger_get(mpu3050->trig);
>
>         return 0;
> }
>
> Add cleanup goto to resolve resource leak.
>
> Detected by Smatch:
> drivers/iio/gyro/mpu3050-core.c:1128 mpu3050_trigger_probe() warn:
> 'irq' from request_threaded_irq() not released on lines: 1124.
>
> Fixes: 3904b28efb2c7 ("iio: gyro: Add driver for the MPU-3050 gyroscope")
> Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
