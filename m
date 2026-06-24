Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEB03016F5;
	Wed, 24 Jun 2026 17:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782323592; cv=none; b=svhva8MR81MALHy8bM94fSxxo9SGBbbks+jg7k9hiRJwSbnV+LPzmbWmfLzUfHOHQU3Mu3HDnsQ1dxRXQBRKZ90OFK26vMCaFCVMqsWtt7IGy9mNbg/WSAzphfSaWEyzR8P/BUr2RKpgNWjn0PvrSdQXRBvCgxLkqKq8JR7uinA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782323592; c=relaxed/simple;
	bh=pikPUZngc86QtE3Tzxh67uRGuu2ebtEWzG9VZmYBMgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OSdvvkfcDUEDqAnfntdAuj2xEI7b1pmwHqejiO4/9xLSSFx/hilCwbPcAOKZS/nIB9v+XRmMB/jLpYZjgj8cx12WXCoau0Y4ykWKFD8SFZB3PwrRXfIhQKZYd8ADjHKocNx4VBL10TcjKpH/fSrDQurpJmvpGfj+7CmpdKIBwJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kAjS7Drz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kAjS7Drz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F0D1F00A3A;
	Wed, 24 Jun 2026 17:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782323590;
	bh=pikPUZngc86QtE3Tzxh67uRGuu2ebtEWzG9VZmYBMgQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kAjS7DrzIZKDC48YdQ+Vga+nsxrFecPZFsyszJkl9KsoEkw7UttkHtzLYLSIHjkF8
	 nfK8rZ1svTXQswVz+ue6wDf3CuFAGTVNrlsVALIZ9e0lmHnxKBGjGgKAUOa7+gvnc6
	 hr2xRdX7t5QZQXZFaEHTznroj3R4iLOzpMy/y4tiUI2uH4ysVc8Nlpjn+s9YhUPrpM
	 U/XfpO1yibpYqMe2tCCDdU6eLEnQtgGd98506x1qNMnzhr/seAEun56UuOtyWdT4H7
	 BVLthcgZYsUtzXEyJFMGn1/uS8r2Z57a+qPAVPRnrfwFvoPPqY6iqv3Udf4xQf2QVb
	 GQn/KavhxPQ0w==
Date: Wed, 24 Jun 2026 18:52:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: "Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= (The Capable Hub)"
 <u.kleine-koenig@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Puranjay Mohan
 <puranjay@kernel.org>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>, Ramona Gradinariu
 <ramona.gradinariu@analog.com>, Esteban Blanc <eblanc@baylibre.com>, Sergiu
 Cuciurean <sergiu.cuciurean@analog.com>, Dragos Bogdan
 <dragos.bogdan@analog.com>, Alisa-Dariana Roman <alisa.roman@analog.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>, Renato Lui Geh
 <renatogeh@gmail.com>, Ramona Bolboaca <ramona.bolboaca@analog.com>, Kim
 Seer Paller <kimseer.paller@analog.com>, Marilene Andrade Garcia
 <marilene.agarcia@gmail.com>, Marius Cristea
 <marius.cristea@microchip.com>, Marcus Folkesson
 <marcus.folkesson@gmail.com>, Kent Gustavsson <kent@minoris.se>, Kurt Borja
 <kuurtb@gmail.com>, Leonard =?UTF-8?B?R8O2aHJz?= <l.goehrs@pengutronix.de>,
 kernel@pengutronix.de, Rodrigo Alencar <rodrigo.alencar@analog.com>,
 Gustavo Silva <gustavograzs@gmail.com>, Alexis Czezar Torreno
 <alexisczezar.torreno@analog.com>, Janani Sunil <janani.sunil@analog.com>,
 Anshul Dalal <anshulusr@gmail.com>, Ricardo Ribalda <ribalda@kernel.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Alex Lanzano
 <lanzano.alex@gmail.com>, Jagath Jog J <jagathjog1996@gmail.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Remi Buisson
 <remi.buisson@tdk.com>, Herve Codina <herve.codina@bootlin.com>, Petre
 Rodan <petre.rodan@subdimension.ro>, Andreas Klinger <ak@it-klinger.de>,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>, Andrew Ijano
 <andrew.ijano@gmail.com>, Giorgi Tchankvetadze
 <giorgitchankvetadze1997@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Md Shofiqul Islam <shofiqtest@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Stepan Ionichev <sozdayvek@gmail.com>, Sam
 Daly <sam@samdaly.ie>, Dixit Parmar <dixitparmar19@gmail.com>, Colin Ian
 King <colin.i.king@gmail.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Oleksij Rempel <o.rempel@pengutronix.de>, David
 Jander <david@protonic.nl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Bartosz Golaszewski <brgl@kernel.org>, Gabriel Rondon <grondon@gmail.com>,
 David Marinovic <david.marinovic@pupin.rs>, Lukas Schmid
 <lukas.schmid@netcube.li>, Shi Hao <i.shihao.999@gmail.com>, Rahman
 =?UTF-8?B?TWFobXV0b3ZpxIc=?= <mahmutovicrahman5@gmail.com>,
 linux@analog.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 11/13] iio: Initialize spi_device_id arrays using
 member names
Message-ID: <20260624185244.140b8368@jic23-huawei>
In-Reply-To: <CAD++jLkRbaPMichpGGQnX5yasRHmY05=95qaOAvH9buHgTKa4Q@mail.gmail.com>
References: <cover.1781883685.git.u.kleine-koenig@baylibre.com>
	<137deb1b7bcdd195c2b8555e8020870729728b78.1781883685.git.u.kleine-koenig@baylibre.com>
	<CAD++jLkRbaPMichpGGQnX5yasRHmY05=95qaOAvH9buHgTKa4Q@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Jun 2026 22:19:50 +0200
Linus Walleij <linusw@kernel.org> wrote:

> On Fri, Jun 19, 2026 at 5:55=E2=80=AFPM Uwe Kleine-K=C3=B6nig (The Capabl=
e Hub)
> <u.kleine-koenig@baylibre.com> wrote:
>=20
> > While being less compact, using named initializers allows to more easily
> > see which members of the structs are assigned which value without having
> > to lookup the declaration of the struct. And it's also more robust
> > against changes to the struct definition.
> >
> > The mentioned robustness is relevant for a planned change to struct
> > spi_device_id that replaces .driver_data by an anonymous union.
> >
> > This patch doesn't modify the compiled arrays, only their representation
> > in source form benefits. The former was confirmed with x86 and arm64
> > builds.
> >
> > Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig=
@baylibre.com> =20
>=20
> Acked-by: Linus Walleij <linusw@kernel.org>
>=20
> Yours,
> Linus Walleij

Applied. Thanks!

J

