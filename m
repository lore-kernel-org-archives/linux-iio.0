Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E841A39D3F6
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 13:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591785; cv=none; b=AroST0p9ebBG0JpK4wh77J734VQNdjXLSI8hHHETMYgDWG4C+K/vQ5U/A4OErRTUnOLp40cfS1qg2Pa+7fSvTpxBEu+/t8D/YMuijZAny6FhIWK2TENraD/ght5OB6NH7aC8AdZ4+ZWDTwdRWnm8fjZIrj2ZqsKjMWUXpXHaQAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591785; c=relaxed/simple;
	bh=0q6rLvOhV3GAh312vu5Sbu7h2QpsKqD9NtTiZ313GUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QLVnpujyK0JDrHukKShBVNeaEGSpiFbNDJtyUWDKuYEdXWG4O6BrYyXaaMuDL9ij9y2U/6ucZSg+I17SCKPo/N/5LnwT9hHddDUrLW14pxtV0vx2TqJ/g3QBcOrdZOkz+c9PT0SUd8kYMA50qi4HIdmmTX/qqh7Y5u9ipIgGTUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNtEcd3c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNtEcd3c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C401C2BD05
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 13:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778591784;
	bh=0q6rLvOhV3GAh312vu5Sbu7h2QpsKqD9NtTiZ313GUo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cNtEcd3c3u99l3Uk9FwEHf/Ja+DpVZAvASu80JACFrCNGxY8sdL0OA4uFgC9ZBe9M
	 UXYxRhOVdIKOOKI5IAdOYrPagwkTm8llWAp8zJgukXTLICI73ka5fEHpf1ZM0yBJXQ
	 PXe7QlgE50Uure3RiPqIuE759mUwIunM28XxZmXUH+u2sFe4pNPZE9+EYt6ToU+VpR
	 xzl0+t18CbGcTf3rF4m13pxxSpEI9Y2ZuU9rxvo8O6ec/wiSZAI5YPBBMxUIcW/7Bj
	 6AUHH0r1ivIa9AsEM/EmtrPOuZP6uQzEPu/q7mJmS+DAPIkywZIqW6dDqWHmzZjQ49
	 M+4LfxGiPKWvw==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a8d648466bso2599603e87.3
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 06:16:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9v+3lE900pGQhpv3/n1i1SoojU0WhjDEShwF6do9VgJzD70TDsx+kjmUJPClXYj2vx+PVFGc05kRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKTCK1heI9QNZ/yXcEaCYlxv3VHixUgeBDNMpoVu7s+Wybd5rV
	8plkG0TU+CcJFLyZWLIPZCrTLtkBwSCXy7OKjTWrFcg5KPm+3yCmup0enu3zUJJ26+LiAD4IaYO
	LdveY5W3cfu7dn0cAMxo9haZgtkfBsCA=
X-Received: by 2002:a05:6512:401f:b0:5a8:a201:f27f with SMTP id
 2adb3069b0e04-5a8e31e9ae4mr934576e87.34.1778591782863; Tue, 12 May 2026
 06:16:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1778582187.git.u.kleine-koenig@baylibre.com> <35a46c1014a1452b0c191a588bee8a09ddea964e.1778582187.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <35a46c1014a1452b0c191a588bee8a09ddea964e.1778582187.git.u.kleine-koenig@baylibre.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 12 May 2026 15:16:11 +0200
X-Gmail-Original-Message-ID: <CAD++jLmKqdjqCRrP7oPFLUD2=jeZ7p8F8BeC4oq9FK92riZbvA@mail.gmail.com>
X-Gm-Features: AVHnY4L5oxgy02ks0GtY4XCao1COVsV2LlMOWkqfZyLtbCWH-UAvvM00eg2TUGY
Message-ID: <CAD++jLmKqdjqCRrP7oPFLUD2=jeZ7p8F8BeC4oq9FK92riZbvA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] iio: Initialize i2c_device_id arrays using member names
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Marcelo Schmitt <marcelo.schmitt@analog.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>, 
	Ramona Gradinariu <ramona.gradinariu@analog.com>, Ariana Lazar <ariana.lazar@microchip.com>, 
	Alex Lanzano <lanzano.alex@gmail.com>, 
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Remi Buisson <remi.buisson@tdk.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Christian Eggers <ceggers@arri.de>, 
	Tomasz Duszynski <tduszyns@gmail.com>, Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
	Andreas Klinger <ak@it-klinger.de>, Waqar Hameed <waqar.hameed@axis.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Gustavo Vaz <gustavo.vaz@usp.br>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Dixit Parmar <dixitparmar19@gmail.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Guenter Roeck <linux@roeck-us.net>, 
	Chuang Zhu <git@chuang.cz>, Kyle Hsieh <kylehsieh1995@gmail.com>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, Sander Vanheule <sander@svanheule.net>, 
	Romain Gantois <romain.gantois@bootlin.com>, David Jander <david@protonic.nl>, 
	Kurt Borja <kuurtb@gmail.com>, Tomas Borquez <tomasborquez13@gmail.com>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, chuguangqing <chuguangqing@inspur.com>, 
	Shi Hao <i.shihao.999@gmail.com>, Erikas Bitovtas <xerikasxx@gmail.com>, 
	Marcus Folkesson <marcus.folkesson@gmail.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 2:51=E2=80=AFPM Uwe Kleine-K=C3=B6nig (The Capable =
Hub)
<u.kleine-koenig@baylibre.com> wrote:

> While being less compact, using named initializers allows to more easily
> see which members of the structs are assigned which value without having
> to lookup the declaration of the struct. And it's also more robust
> against changes to the struct definition.
>
> The mentioned robustness is relevant for a planned change to struct
> i2c_device_id that replaces .driver_data by an anonymous union.
>
> This patch doesn't modify the compiled arrays, only their representation
> in source form benefits. The former was confirmed with x86 and arm64
> builds.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>

It's clearly the right thing to do.
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
