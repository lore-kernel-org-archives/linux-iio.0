Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793048695;
	b=PoWA9gI6KIMtOPOuW6fxMNIGDc2CRYGjicz7rxlSomTZIlhJ3bhaD6UbfAoAoNbSftaf
	 zlk3f5OGU2z4FNMnN/7pJ7sFUyY6evRmSJsskw8KCwXKks+V+YVCuzPv/hhnAgYS3x0q7
	 ru/R4MyP9SSSuQhEpdh++WKhZzVSIDj4mB5ukpwx1eYRi1qHMl5QUYeko3XHfQt4s86kj
	 dHMswncnTkF5H+kpmvc2tZ84P10BcWOa2MMxgFKw5ZINpVU0jIvHFE9ZJldVcNCPPR8QB
	 0kATqGR4aDXe6N5eFm/bLbe9fmeQ6GMLw7YyDUAlM834hBp9NM0NYokvfXH+jvhEVZA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793048695;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=tux21EfDtTpBbBq1R3ksg3nQktcfpPRSG5HUXyWHhJw=;
	b=1p3x5niZo6BSwRv7xBHLVQaazCLM5CzRgNaiApV6xOnFLiL+jnmutq95nADDJXUHfo1m
	 qegTEwJjcMJAlJIaAJn8eNAd3bNCBYQxhk+gkjdVv5WNT4I+iVuFC4ZBFUXefD0NUOtFB
	 cHQFjFRiqcHqKoYD1J9EGtYmikr6Zu0fZIjq88UDNPApRo+8g4yppmsY2a10sXenwgFCk
	 Ng+yAM+LS/WEt/Mcji+IyBM9DROhf41HROXCGio7pFSNhcQOZTR43CZnDFOe84hl17OWt
	 cNuxtVE5t/dscFbdKjTPbP4RWKW6UPjte9cNjk6RpkfJRe8LuVxv01EKtKWOvIo/kAg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="REzh/iK8";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA713606A31A
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 21:04:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA713606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=REzh/iK8
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so22381485e9.3
        for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 14:04:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793048693; cv=none;
        d=google.com; s=arc-20260327;
        b=YxBCE0HjjbGzwvtuGRjSqUJPpOjkjHIpuCEkZgZ45sJTTvYqud/P+xIJvY6unQ2yOe
         zlI+IM8q31NdoU3RLVlebOhmbxzOc/URMGM7Vse4LyZtBkDlUlhu2KH0g/fEOl7ynzD1
         LKEN0qgl+t625jjvjnDKMuQjEuTslAaoMSR5fvS55zrx7FtWemFx5zKRrDuzeKQMzxc6
         JjDSGrHM48UbOc6g60HvdzGDAV7J4ZdEn0F8p1u2QBor5UMRH/cNjXGCyUJFFQptVPbu
         TZM7gYFQYeFJq7TWXLmqHcGJm0jSd/F+iUyAi00lFcLAXSD50IJUZHTbTnDEhDxVJYra
         vkig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tux21EfDtTpBbBq1R3ksg3nQktcfpPRSG5HUXyWHhJw=;
        fh=OxV3+E4n1lddEWDkzEVKblvVp68e8MylAhfH8OX1fOs=;
        b=bEdQG0DuZSzrzF2KcDzQUPF6wI/CKjAJp7IMu+FH6ZRv6nA75E5Tk4tawjOIkvfwod
         TwFUmvUspm8Nb+VvoDNe/LRadqdNKpUCCPwagsxl208jDtEDs3Z0/2abJlRoRRfTn3fB
         5lpuvT4KABIa/fLKYTJhUtHchreWfUTH+fFGI4ye2GcC87tdef6MGu33IdmV/+Fjiefd
         1o/J9hgHtJd3wDE22XEBGrJylgLbwr+GOFZwEhI7Du+VZC0zlgtEzZMn6ckfH1PxxW2W
         q40AqZP6URjkoqY1FLQQ9JFlnBWDIhA3qxtybD1Tip1cJA7ENnySz5CLxrKfaaeBHf6K
         FXCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793048693; x=1793653493; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tux21EfDtTpBbBq1R3ksg3nQktcfpPRSG5HUXyWHhJw=;
        b=REzh/iK8/mR9cU2vVYp1mtiiXemFRDWkRiF4g+U+E9FeH9kEHfpk8xm+cEY7SIc7o8
         VW7PKfpYVJ2L1W6cUDxzIrqW81kWWt3AcYPTjWB3wMTvOuTuv7YwHI8/fLOu98Rs6zKP
         iOdyQzX++/3k+4HhBOiQnd7mtfO+Gwt2SldmFEzEHfB6gZYxXicHlowbS4zTZxiHZlRd
         xmj/0p7A1SCa1n0NEUjKp7fm0YXmMEZvN3WXFYPvV9x4BdoIxb8thryjuUhjzw7cNcYT
         3bIw91POCvvsyzwGg/ukMJLQYA9hX3jrFUTCnaThLfm03jm1fjillXWuKZ0YPE+Jw2Yb
         BSkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793048693; x=1793653493;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tux21EfDtTpBbBq1R3ksg3nQktcfpPRSG5HUXyWHhJw=;
        b=1MWyYzJpGJtXTakmwwhZmGetlzJJg5rloOBtJbyCPsxIOXrhuabZdc0BQanzttod4H
         1/aUorX+INlMWNsRh1Eg4drOw3W8eRwi3bD9txT/p5qtUEWCYUsTVgRBewaz4eMR3nWs
         ZSFygv+MX+9RgB8Dj2j1GLkhtAYm/iVnh5xe1/MYjxPeXz1o0gtfCZeTy0/UKaZJYBwz
         D+hE7uNRkTjdLzapxsn5AdwAXBTUPQceaeExi6r/j3R34Oje3FQYAxC5Q/MdzENmhdBe
         c9XAx9S6kknetdr9Gk7I6cQWD7QLcSc5ALIa5n4vWWyqWeXmDC25vGcv1QZnvISginqb
         8i7A==
X-Forwarded-Encrypted: i=1; AKwUvByw5JkEqmmDy/XXmz24SN1BEFowzg1MszKx/BqPXRTSUxXQ7CvuCiEPp0yIw2Mo7fc2iMi3OmeGrFg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKgQtgwN8FRgJn3s7WHV2bOXx/GW/L4K2tG0m4s/ZeLnS68xqJN
	8CVdJbElqV/Z432KWvfnFEozRsJ3sAKNhQFlFHuvzjlGkCmprq/ZlOcX3NJhW9NsJaFxJT8ix67
	FEP0fqnUa9rTI42rAivfUXzFh34VnbCk=
X-Gm-Gg: AYBFou023LMDnRvTGBZxGPN92QkPIPt085bnidPVNGhaucfSuqxsiQw9pk0K3Gi8co5
	9Bkh3053RNklsTNwxFvFrt4pzQcig6QOj34A9d/zu3hBKoabLUnriaNJ7Qj9SAwxNv3DeOGZ8cB
	HDfq0QGe/jTpn6MIZpXL/UsZLMVqGD0jfywR7OYWvfZBoi0tpOk/I7UDF3po08RP9buquzwftz1
	PN+oIhw3aGRC64KpIxywTtTDMMs6ZiBSsawXzDTFQ6ZWstdPl1caJk0KpyRY7/u1tvKplvKo0CB
	FMW2pU73aA8cd5Ra8qt+PYCo1k5SvYHSIRBiPf5TofauTa//99oC1zLO/E2kP7T4WDtCn/1fsJb
	11u1c/+bhijpE2ReEclHtVNX/VKhzN2oexm7DnazV3IA2qwY7UOFICb34rLd4wvtGMiRys1qFKc
	JrDIWRqJ0P6p/uusBAhjvezq5fYWXieh4CATx9hT4cLnA5hHdYOV3j+G3D
X-Received: by 2002:a05:600c:6098:b0:49f:ce78:356d with SMTP id
 5b1f17b1804b1-4a35acc431dmr140143975e9.30.1793048693009; Mon, 26 Oct 2026
 14:04:53 -0700 (PDT)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023175919.160103-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20261023214917.157d0c89@jic23-hlaptop>
In-Reply-To: <20261023214917.157d0c89@jic23-hlaptop>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Mon, 26 Oct 2026 21:04:26 +0000
X-Gm-Features: AclHuK8JBvSW5tWtnhuC7bZYHXlymQW5Rkl37e-ZQt82_GXFIHsS0rUkBFiPL4g
Message-ID: <CA+V-a8siO75k0ZKDoQ3zpyzzAX8KwWT9qHUGP1OZCXCU9sumFg@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] Add ADC driver support for RZ/V2H(P) and RZ/V2N SoCs
To: Jonathan Cameron <jic23@kernel.org>
Cc: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, 
	Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Prabhakar <prabhakar.csengg+renesas@gmail.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On Fri, Oct 23, 2026 at 9:49=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Fri, 23 Oct 2026 18:59:11 +0100
> Prabhakar <prabhakar.csengg@gmail.com> wrote:
>
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Hi all,
> >
> > This patch series aims to add ADC support for the RZ/V2H(P) and RZ/V2N
> > SoCs. The ADC IP on these SoCs is similar to the one found on the RZ/T2=
H
> > SoC but varies slightly in terms of available channels and configuratio=
n
> > options.
> >
> Applied to the testing branch of iio.git.
Thank you.

> Note I'll be rebasing that on rc1 once it is available.
> In the meantime, additional feedback is still welcome.
> (It's welcome after that but preferred as patches on top!)
>
Noted.

Cheers,
Prabhakar
