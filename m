Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8EB17745
	for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 20:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781900407; cv=none; b=QU0frliYU2ejhnU2ExX0jOTP3Co+o0sfLed9Tn9EnXjOUxgcFxekIBTy5zEzE/cTZcTHwk8ad8ALHDIbT5eyFSmxtG1XFVe81he7oJryv8l+CffO0F7AgPWSvyx1SEi8uVewHSs979tELIr/ordykWYGNd/rz6gWWqNrZNTJNQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781900407; c=relaxed/simple;
	bh=tJdSLfUZqkt/ondKhbI6Q+VPmUn/ssKFPEMHr7+GfuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W8bTUfboelpPKTtL72w3jzhPlX9XtHYhJPxhNTRU3lwCDHnMrwerTNRBWfA8+kpDh+pAIZZipYCPZMlBmXC4dwhfSa6vc9W9dWRh9K5VxjyN+jU8L+FtumkvqQ8UD/O8M9l9uX4CtuYw2pA5bf20LiNU4xORiAn/dWLgyszL2SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k40qUw8N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k40qUw8N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B1C1F000E9
	for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 20:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781900405;
	bh=tJdSLfUZqkt/ondKhbI6Q+VPmUn/ssKFPEMHr7+GfuI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=k40qUw8NHCFEmEYdOIHmLwpghEfuhPSRWNBZS4/+LSbMPBYFg2Bq/auAoEKhWbWHd
	 53n2sTraM4yUZReGDv3mz5RMMkjoY9G6Uk0m8+kGhABPq5+h8qPQFA9X54hD45IvfN
	 yefUo5ZgCNpjWybZK3Dw0f9COM8ohUAP6QK7MdzRXGQIzf8ZN1GsuBCmu6nEe2FsuU
	 81lYobbAkJasSAYeOBxOjs4nfdgnnrfoApyQgFKHXYOAbsERWVqare3AiqVg28CNGd
	 PzKimfYCoxM7eVOQcVzg01i+wEet1RmLhckD3JL5nV8L8ebLSCGjykT7IqrAFtF2Og
	 /JJfzCsSiuGVA==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aa2c25c632so2464465e87.1
        for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 13:20:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ97Pyf7F0d/bznqtvz6YbPw2wnLtNs1OP8GxL5laITcEcDC+KUsQeodldXqLcgUGxcFCu8hTB2mYSw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8XuXxtpv8ScCd0aN1amwHAwCAkzkDPlp7Nt0yJm687ioRNu+H
	EpF9RPwuRHjH/yveIzXXBsblTK1bjOtJ7O5HmFlopcacZT3u8GdAmk9UOAoSeeyHBEJhs4abyPZ
	PzWODcqVYozU97pARf8wp0i0x37htvSs=
X-Received: by 2002:a05:6512:6c7:b0:5ad:49da:61ce with SMTP id
 2adb3069b0e04-5ad562de63bmr2001488e87.43.1781900403685; Fri, 19 Jun 2026
 13:20:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1781883685.git.u.kleine-koenig@baylibre.com> <137deb1b7bcdd195c2b8555e8020870729728b78.1781883685.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <137deb1b7bcdd195c2b8555e8020870729728b78.1781883685.git.u.kleine-koenig@baylibre.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 19 Jun 2026 22:19:50 +0200
X-Gmail-Original-Message-ID: <CAD++jLkRbaPMichpGGQnX5yasRHmY05=95qaOAvH9buHgTKa4Q@mail.gmail.com>
X-Gm-Features: AVVi8CfVr11iCQW7AFxuozCaOSWQpMWs7KT0oEUYUwO6J0fGoyPyIe96ohjj4CM
Message-ID: <CAD++jLkRbaPMichpGGQnX5yasRHmY05=95qaOAvH9buHgTKa4Q@mail.gmail.com>
Subject: Re: [PATCH v1 11/13] iio: Initialize spi_device_id arrays using
 member names
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Marcelo Schmitt <marcelo.schmitt@analog.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>, 
	Ramona Gradinariu <ramona.gradinariu@analog.com>, Esteban Blanc <eblanc@baylibre.com>, 
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>, Dragos Bogdan <dragos.bogdan@analog.com>, 
	Alisa-Dariana Roman <alisa.roman@analog.com>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Renato Lui Geh <renatogeh@gmail.com>, Ramona Bolboaca <ramona.bolboaca@analog.com>, 
	Kim Seer Paller <kimseer.paller@analog.com>, 
	Marilene Andrade Garcia <marilene.agarcia@gmail.com>, Marius Cristea <marius.cristea@microchip.com>, 
	Marcus Folkesson <marcus.folkesson@gmail.com>, Kent Gustavsson <kent@minoris.se>, 
	Kurt Borja <kuurtb@gmail.com>, =?UTF-8?Q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>, 
	kernel@pengutronix.de, Rodrigo Alencar <rodrigo.alencar@analog.com>, 
	Gustavo Silva <gustavograzs@gmail.com>, 
	Alexis Czezar Torreno <alexisczezar.torreno@analog.com>, Janani Sunil <janani.sunil@analog.com>, 
	Anshul Dalal <anshulusr@gmail.com>, Ricardo Ribalda <ribalda@kernel.org>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Alex Lanzano <lanzano.alex@gmail.com>, 
	Jagath Jog J <jagathjog1996@gmail.com>, 
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Remi Buisson <remi.buisson@tdk.com>, 
	Herve Codina <herve.codina@bootlin.com>, Petre Rodan <petre.rodan@subdimension.ro>, 
	Andreas Klinger <ak@it-klinger.de>, Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>, 
	Andrew Ijano <andrew.ijano@gmail.com>, 
	Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Md Shofiqul Islam <shofiqtest@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Stepan Ionichev <sozdayvek@gmail.com>, Sam Daly <sam@samdaly.ie>, 
	Dixit Parmar <dixitparmar19@gmail.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Oleksij Rempel <o.rempel@pengutronix.de>, 
	David Jander <david@protonic.nl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Gabriel Rondon <grondon@gmail.com>, 
	David Marinovic <david.marinovic@pupin.rs>, Lukas Schmid <lukas.schmid@netcube.li>, 
	Shi Hao <i.shihao.999@gmail.com>, =?UTF-8?Q?Rahman_Mahmutovi=C4=87?= <mahmutovicrahman5@gmail.com>, 
	linux@analog.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 19, 2026 at 5:55=E2=80=AFPM Uwe Kleine-K=C3=B6nig (The Capable =
Hub)
<u.kleine-koenig@baylibre.com> wrote:

> While being less compact, using named initializers allows to more easily
> see which members of the structs are assigned which value without having
> to lookup the declaration of the struct. And it's also more robust
> against changes to the struct definition.
>
> The mentioned robustness is relevant for a planned change to struct
> spi_device_id that replaces .driver_data by an anonymous union.
>
> This patch doesn't modify the compiled arrays, only their representation
> in source form benefits. The former was confirmed with x86 and arm64
> builds.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>

Acked-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
