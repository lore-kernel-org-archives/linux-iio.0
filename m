Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5CC3F1AD6
	for <linux-iio@vger.kernel.org>; Tue,  2 Jun 2026 16:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780416558; cv=pass; b=dN7nr35G6Hj9pnnJF7O0vHty+3fwmIkjOkGgVgbHEB8qVChB6q/QFR77dvvAa0vxoXYZ/mWJQc8u1Uwzf4DrKp7T4M3/GtO7WQ00GguRBhGVIVUDDIzlug6dQboaozBwQZbs34UITiaRraNwVrF8BqKd8OKF/UsusRuuKaz25gw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780416558; c=relaxed/simple;
	bh=J3xux7U45mrKPD+xhI8+4/CSw9k4F7LVnA51gaKB+9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A2M+yFawWrhCMa95XWwngkH61kwwa4tKbvnxL6WqA/+t8aL0Sr6ecWomvS26s21PXCkxgE9lBd7BlDr6QOItGxjpZtbXu7S64V5lVNejkS32WwtfnxEQduSpxiJwvUzCGebVHVd3IGOuNIdAzMemDo4prhC1bWMfc6PrMsa0OWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itfaJ+Rn; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itfaJ+Rn"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-68ced97b6eeso3841258a12.0
        for <linux-iio@vger.kernel.org>; Tue, 02 Jun 2026 09:09:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780416555; cv=none;
        d=google.com; s=arc-20240605;
        b=NekIzQMn9s7L2wdlxF/esq+m6FUJohYAyxczoz1xpKT0JxNb8ltphPvo46WK+DBgJ3
         4LPn3rxUgGDimt6uYOpAYpPMTBIFM1zcOnTGQfbhmB20yF9U54hD85vcGBFhvZYpFnMd
         KKx2OTGZdtjghK+jkyavA0ikkUwLWqMZ7taGedJsoBJm7VOBZRMubmN94JvMqNdhKsJa
         NRdHiiPIUk9PpKlzmf/k74faCQPHpYDdK5VtG31xMbJAfGPVzvJj6a6+Y2i3UaNyEZJQ
         bQhi4MuizScqInQ9azxPwtVE2n/qjYItH7Kdju1F04IWysJYdHe0Ofi2I+FOwU9xPRil
         aWqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J3xux7U45mrKPD+xhI8+4/CSw9k4F7LVnA51gaKB+9s=;
        fh=uvedAP7THLGH82cCeyBsm7yAjHv4t5xmFRMuapVqwQI=;
        b=R2Au3lbBI5AhdCSN3+SII0g0DnQeYHcV+Q9O1XtD0/Bm7NToAj95+lUaLl+BX6CSdl
         jxGOZAYlRLkOrJGAL43Tm8gEtbYV/akTR1zSnu2rNp719iAjZzU+JkLJGlbizzN0vdQh
         ICb3d5wpiI9AFNrz3ejM6bBJYfXJuJmanGm5umh60qV8nEcWNfL2yw9LMgcvGRWZkJo2
         VTxjQMW5pe54d7MJBoC766esHb+wfh6jrkAFAoOrC2aGd7e3rLCZz1i1edAdzmRW871R
         w63mJ/SuS4iAtnxB8vGjndUcKdS3AHSLIKCu59QT02DPOlRDk1Ih7e6Ehk/ydr0vcKwm
         ZbrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780416555; x=1781021355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J3xux7U45mrKPD+xhI8+4/CSw9k4F7LVnA51gaKB+9s=;
        b=itfaJ+Rn1Y++1nCRjqW96fzKVbrQq6TZj5h0eK3r97ete/LE5zHfAY2PK2BYAhMbBR
         0gkbh0WtBeAw64n9iSr3y/sUVVSyJiTSNyx1Lnxvk0jx7QS/tiA+6FkwfWXRSUHslZwQ
         DujEHqKnPKHHSIMEnn81Se5/Zx8uw+qCwKFzSu/5leYrpYIY0/aHVaNh+1Pd9pj8BH/4
         7kuEi2bKhZMK4zvG/x1TeQ8X6YhP9yPudl6KkoKlkIq4mOb1rPQk0BdDcLmP5kZqut59
         kG7jT+FDkVm2H9q7fk5Ac9JxD8NgIwnKI1MPK7p5Unp7eXyT/I01wTE+0l7UGskE8DjW
         huNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780416555; x=1781021355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J3xux7U45mrKPD+xhI8+4/CSw9k4F7LVnA51gaKB+9s=;
        b=Kj2wNxR+uODgwrUQCMFPBOB2fF6VNQIgzUbSwcXhBTCKboBdM3x57zti4/0a5kTj7f
         QTBTjyQN0tF5eLtQBR2/0IWvwHbsEkLi8OTZBpXuXTi2Ht9e3v06NXKBoaBpU6gVuDrx
         gPUgQ+mU8YiqJjSk0hM4oYsKoo1gksQJT7nHHwIifSzjC78Ifx8jaG63YAajLs42mwHU
         ySWgXbcqqN0JfRWPr/5DmIj0ir0bOIhCcWCAZhQ0c2Oo0Lg4o4ewb+N7BzkjOtPuHeOj
         FGYA6T/Fp0pxFCqOO1uFaXcDaO9INYxnjUGRAZu1sbfX9jp2HmMZxDhpxt0Xyc0dMSXi
         YQaQ==
X-Forwarded-Encrypted: i=1; AFNElJ8IZc0PpPJo31yN9Kmv8AuWYIZf7KajUjwAyaQAKHh915PM5+tGuRXrKDcE+EHAPQkpSA7NTYK6C1w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+o6GLrqllDNE4HdGKCqD3+VDJ7Bu9Nu+9pJ5MfiMOcglFFeaA
	PVRSDyZCAaGLLn/Bn1++ZL+XoKZx56RyqRdJ8OhfSGTVtjLjkKux6VWLOFoW4uFzqscGIEkrLoL
	07Y41rDydJRZYPKHorGggCRrImohWPCE=
X-Gm-Gg: Acq92OHiB9TATPTqPipS8kKig0o6aPAe522WYaoXpN2/utJkHVvjHaB1Mqh7nwny1u5
	k3JaEbzi5/Z0ZWrYq+nJPxV3SmDaGuEgsbpQkgsVEqR9tBO4Ce/Ja7//Z7Etz/f7NJ/C6hmOdSn
	nhKn9kF4Mf7Fs0L86nuuA64kr/FR5sHPpFm6dKR42MzkljC7Gt7As9qJ5sClFWEvxfZBlbg+UT/
	zinkWJ6/URTbBRpcYoXN2/Es9VQF8JXNgavxHH5X6IxgvndBdygG2V+7Hu8/2bQMwOqap/cSN09
	XjkYVcCv3kjlAfNutdVfPYgf+ELquEZo8k5hxOFrWexZCKH/UPm3A3e/Fnzp9FuZix3eI2PVTCE
	3VKUzWlnBwirGKQ6tMf2GejQRCtnKURmkLU6JP9JXGVIgHjh/P9AxhVK/ncvm/NXR082SDt5h73
	DrSKUHvph1vFO1kw==
X-Received: by 2002:a17:906:f582:b0:bed:83ee:922a with SMTP id
 a640c23a62f3a-bf05f7e05eemr13716266b.16.1780416555037; Tue, 02 Jun 2026
 09:09:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602153926.1540911-1-sam.moelius@trailofbits.com>
In-Reply-To: <20260602153926.1540911-1-sam.moelius@trailofbits.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 2 Jun 2026 19:08:38 +0300
X-Gm-Features: AVHnY4Kq9VlFF4x6sJZe_WxcJEjDUNdWfKrg84e_11y2V749HUGLz1NtAWfpzxk
Message-ID: <CAHp75Ve-niGYTZ4CMtSHYMjJwaxij0DCoQQb2A-0Cmm7FHEu9Q@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ad7380: select REGMAP
To: Sam Moelius <sam.moelius@trailofbits.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Marcelo Schmitt <marcelo.schmitt@analog.com>, 
	Jonathan Santos <Jonathan.Santos@analog.com>, Jorge Marques <jorge.marques@analog.com>, 
	Antoniu Miclaus <antoniu.miclaus@analog.com>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>, 
	=?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
	Stefan Popa <stefan.popa@analog.com>, Julien Stephan <jstephan@baylibre.com>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, Samuel Moelius <samuel.moelius@trailofbits.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 6:39=E2=80=AFPM Sam Moelius <sam.moelius@trailofbits=
.com> wrote:
>
> From: Samuel Moelius <samuel.moelius@trailofbits.com>
>
> The AD7380 driver uses generic regmap types and APIs. However, its Kconfi=
g entry does not select REGMAP.
>
> As a result, AD7380 can be enabled from an allnoconfig-derived config wit=
h SPI_MASTER=3Dy while REGMAP remains unset, causing ad7380.o to fail to bu=
ild.

Seems like not wrapped on ~72 characters.

> Fixes: b095217c104b ("iio: adc: ad7380: new driver for AD7380 ADCs")

>

No blank line(s) in tag block.

> Signed-off-by: Samuel Moelius <samuel.moelius@trailofbits.com>
> ---

Config change wise LGTM.

--=20
With Best Regards,
Andy Shevchenko
