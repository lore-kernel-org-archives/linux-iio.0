Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5433392C46
	for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 20:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783714001; cv=none; b=XCpBrc43kMy8TyZozPI9e0jMHcp9ja9UdP+CEXhC3qFrkv7iTst6o/Sl/itmcUm58gPkWjPTpBjq/4hk+Zc5X2/z6XdD9GPCVp0IKerPij4psfGJweFsNGX6McylnKQKeqLtVtraVwbCIPDSusc0+UAFgbUwQoqutZHS3EN/JTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783714001; c=relaxed/simple;
	bh=VTtJMkoIE7aY9ADQYgKgI9tia/pJhvsGnk0AWgm65VU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iu+9Mio6leZ3DKxH157s5e1AF2gyJ4dGtsM1Asg7iFfqgaUbFAAbZSXSyDNLYJRgjwfHX6bA9GFkkWMcXKF/yKxvW3Oc/VHv/wGHpUWhbr44ZjSyJagm+UehJ19gYcKAOShZ0PfW6MRE6nIWez1bKNBM4/+2z54zOhR8CJRag4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WD0uMvEp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WD0uMvEp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D097D1F01563
	for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 20:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783713998;
	bh=B9Kk8b2yeKJda2bcD7uscL9OAXJzdAoXShPD9wofJ1Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=WD0uMvEpmZ4hjD/0FYhelcJkG2V8mh5HWOkjkEDVb+ET9E29v/9HpaUWFL0KG8S1c
	 tWXnEMY+7mgl00OYFq4k+2h1AdtW0B6YwVQCN9m0kaupFYZbmSrKfdSR4HESs9vtJS
	 IH7B6PdHTJxE3PB5WY2YBFyoLvJu1AeOomuPwEQjCHP7UzLiezOyi66t3HYde6crCJ
	 XjWxgov+Ts4Ut1zJ/WpJJlRPASZGEDilLzeLl9Fcz/wROM5nagZves8f0FdBjBFhUF
	 lsUb5iPHK9+u2ZPCmxxX71TYTz6Y72MzwuaGciu7sIYOLVtLJzTYbKj7eHojZHoh/x
	 ndvoTXlgEuJ6w==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5b021916bd3so653187e87.3
        for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 13:06:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqwokN9ziqKxF9eukpdjsIP88MEqqLWOZUk8kAaKVmwKvueFp6KMct8trr7IIXNqzcerwE7r1g3zbo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/1+V4u6SijjabpodjiEELIuSbOFzSwARggYNvz4S0xtwzD7td
	N2mUHH0mm2UXQ/cB1SjO9UTMIzyLBwBxN/vAiM8EU4KKCq1cx+FZjds8xhQb/inml+0au2MA9M/
	84pxRgKQapqDH6+GK8ABVvCVM8lQvlRY=
X-Received: by 2002:ac2:5547:0:b0:5b0:f9d:f7b9 with SMTP id
 2adb3069b0e04-5b023564b81mr79634e87.2.1783713997465; Fri, 10 Jul 2026
 13:06:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709-ad7768-driver-v1-0-44e1194fd96a@analog.com> <20260709-ad7768-driver-v1-5-44e1194fd96a@analog.com>
In-Reply-To: <20260709-ad7768-driver-v1-5-44e1194fd96a@analog.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 10 Jul 2026 22:06:24 +0200
X-Gmail-Original-Message-ID: <CAD++jL=iqrJV=Qbe=O8iycMZZVmVbjzPG47Bf_SUVjUb+4AcxA@mail.gmail.com>
X-Gm-Features: AUfX_myotWGi2qG-MCbfVtZjA7xuips9ZVSbzGCI_OB1AcLKfs_3jsKmDONnS60
Message-ID: <CAD++jL=iqrJV=Qbe=O8iycMZZVmVbjzPG47Bf_SUVjUb+4AcxA@mail.gmail.com>
Subject: Re: [PATCH 5/6] gpio: ad7768: Add AD7768 GPIO auxiliary driver
To: Janani Sunil <janani.sunil@analog.com>, Michael Walle <mwalle@kernel.org>
Cc: =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Bartosz Golaszewski <brgl@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-doc@vger.kernel.org, jananisunil.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Janani,

thanks for your patch!

On Thu, Jul 9, 2026 at 10:51=E2=80=AFAM Janani Sunil <janani.sunil@analog.c=
om> wrote:

> The AD7768/AD7768-4 ADC exposes 5 general-purpose I/O pins that can be
> independently configured as inputs or outputs. Add an auxiliary bus drive=
r
> to expose these pins as a GPIO chip, registered by the parent IIO driver.
>
> The driver uses the parent's regmap for register access and delegates
> runtime power management to the parent device.
>
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>

(...)

When I look at these functions I see they are very close to something
the GPIO_REGMAP helpers should be able to do.

Bascically all that stops you from doing this is:

> +static int ad7768_gpio_direction_input(struct gpio_chip *chip,
> +                                      unsigned int offset)
> +{
> +       struct ad7768_gpio_state *st =3D gpiochip_get_data(chip);
> +
> +       PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(st->parent, pm);
> +       int ret =3D PM_RUNTIME_ACQUIRE_ERR(&pm);

These two things.

> +static int ad7768_gpio_get_direction(struct gpio_chip *chip,
> +                                    unsigned int offset)
> +{
> +       struct ad7768_gpio_state *st =3D gpiochip_get_data(chip);
> +       unsigned int val;
> +       int ret;
> +
> +       PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(st->parent, pm);
> +       ret =3D PM_RUNTIME_ACQUIRE_ERR(&pm);
> +       if (ret)
> +               return ret;

Here again, etc.

Can't we just add a

struct device *pm_dev; to struct gpio_regmap_config, pass
st->parent there at init, modify drivers/gpio/gpio-regmap.c adding:

static int gpio_regmap_pm(struct gpio_regmap *gpio)
{
    PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(gpio->pm_device, pm);
    ret =3D PM_RUNTIME_ACQUIRE_ERR(&pm);
    if (ret)
        return ret;
    return 0;
}

And call this in each of the standard callbacks so gpio-regmap.c
can handle PM as well for free? The above can be an ifdef stub if
runtime PM is not enabled.

Yours,
Linus Walleij
