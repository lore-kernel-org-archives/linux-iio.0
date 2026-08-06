Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCD13E3C49
	for <linux-iio@vger.kernel.org>; Thu,  6 Aug 2026 21:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786051911; cv=none; b=Kx5pYTOkjO9QPwtdfz9EcT6SuAkGctvurfmJjo5/8nBJSzlSGICeNBkh0+82KtEhsPztacns87Y11QacpqTd4yk4q6a3o/C4LOoSEn258Hh6bf8DpkjzuY6GSDeM3jYwGJfCQT14YQkYkELtIfwcmjQF5Hrx9jlTC5GgPkYo6sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786051911; c=relaxed/simple;
	bh=MapO9+0UbYPsPznCJ1eGKO8xyWh4okMlTCl5ELK9AJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TV4hPtbEsEUU1yp0fiiU7VhcubNwblX2O6SJ3cUnlYiBMePxGFoHDaLaB7YxYjz11lNDK4Tod9DZpz01SyyT23rwakfyuoxlPkm0mXOLPimYdGbXdlCmARg96FTvMf4rRTfLJ42WuDpKTWNbakPgbCr1Yu03scpcSQzaQ5/RntQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgEnR8Xh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgEnR8Xh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E851F00ACF
	for <linux-iio@vger.kernel.org>; Thu,  6 Aug 2026 21:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786051910;
	bh=4nDRcpgpnHZsH8pHVeZMeunrKKlZ3F16xOccjHEdWAg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=BgEnR8Xhr0zKrK+OxVTnbkPrbTI24VscPCPRVjOjZ8NEE+aWT+mQtOTWiHuUSNupD
	 NOb0G1ZvhFVINJRvomuuNDAgufwIs+cb8liE2eQlIdfrgHICR/9eIw+DAoxqpK3b+Y
	 87EPZDoDUjnzW/epTUJklXJ8nU9c0oWKet8DOti+qZ7qSZVArGuJ3UdMTaukA9KFNi
	 0rIWOljc0tIqe8CWLV6cSWUdju/iEcfg+mhIiy/krpVQUDPobJuwUYBevfiDN1/xBT
	 /ffii+sKb+WABqQ8EKuQa4cTVKgQPEQgCFI+4YHTN4sYpneCsgrTUGS4Bz9S3wiH0S
	 ZOWT3XL1uDuzg==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-39c74722e27so18722341fa.0
        for <linux-iio@vger.kernel.org>; Thu, 06 Aug 2026 14:31:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rrq/qmLT57L63gxL8YFv+mkXTwOkFgISaFdSNQQI9OtK6BUz4TWvX+UTS8oyVFCB3a58iD0w1+aRWc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy98ILJxKWdn3H3VVfhuv5pe238y2VKnWLNIWxQsOOcKXVfhhPN
	GeMh4MQvlvWaXHaGQp9YFEZ3QSoD41a892vT4uyWag2UfTgQIHAF9Qgw0QsjfCbIGx4+9bW7MvC
	5vRavULzUpez+jMNEXcm7I1rnJDpRNzU=
X-Received: by 2002:a2e:a554:0:b0:39c:90e4:a8c5 with SMTP id
 38308e7fff4ca-39fd1351341mr9835461fa.1.1786051907625; Thu, 06 Aug 2026
 14:31:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806-ad7768-driver-v2-0-027ac5e2a641@analog.com> <20260806-ad7768-driver-v2-5-027ac5e2a641@analog.com>
In-Reply-To: <20260806-ad7768-driver-v2-5-027ac5e2a641@analog.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 6 Aug 2026 23:31:34 +0200
X-Gmail-Original-Message-ID: <CAD++jLkM26M1CwzQgR+xA1vgLzGsqm1x=1WAjOgJvF8+08ipQw@mail.gmail.com>
X-Gm-Features: AUfX_mwHF-6hdCsjgFVeW2oXcK7GLWvqB1cVEcRyYzuhLCjvW0a501F65R-LkWg
Message-ID: <CAD++jLkM26M1CwzQgR+xA1vgLzGsqm1x=1WAjOgJvF8+08ipQw@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] gpio: regmap: Add runtime PM and
 read_output_reg_set support
To: Janani Sunil <janani.sunil@analog.com>
Cc: =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Bartosz Golaszewski <brgl@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Michael Walle <mwalle@kernel.org>, linux@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org, 
	jananisunil.dev@gmail.com, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Janani,

thanks for your patch!

On Thu, Aug 6, 2026 at 5:42=E2=80=AFPM Janani Sunil <janani.sunil@analog.co=
m> wrote:

> The new pm_dev field in gpio_regmap_config allows a driver to supply a
> device for runtime PM. All operations call pm_runtime_resume_and_get()
> before accessing the regmap and pm_runtime_put_autosuspend() on return.
>
> The new read_output_reg_set flag when set, gpio_regmap_get() checks the
> pin direction first and reads from reg_set_base instead of reg_dat_base
> for output pins. Requires both reg_dat_base and reg_set_base to be
> configured.
>
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>

Do you have to do this in one big patch?

To me it seems like two unrelated changes that should be
two patches?

> +static int gpio_regmap_get_direction(struct gpio_chip *chip,
> +                                    unsigned int offset);

Can't you just move this function up in the file to
avoid the forward declaration?

> -      ret =3D gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
> +       if (gpio->read_output_reg_set) {
> +               ret =3D gpio_regmap_get_direction(chip, offset);
> +               if (ret < 0)
> +                       return ret;
> +
> +               if (ret =3D=3D GPIO_LINE_DIRECTION_OUT)
> +                       base =3D gpio_regmap_addr(gpio->reg_set_base);
> +       }

Add a comment above this new code explaining what is going on
otherwise this gets really hard to read and understand.

Other than that it looks good to me.

Yours,
Linus Walleij
