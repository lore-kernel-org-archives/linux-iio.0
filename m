Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793499843;
	b=RZtk1kqyb+rBZbvSSQ+OkIOcTZrpOrPdDEuR8ctYBQnrXwt6OMfNUA+SvTtlZ3dwQySJ
	 ygbtjO/qaBknAktebus7Zx8dUGegfuWrv1/OHWE0U0hYrWlLCIRQMJipuDmaXIgiGDd27
	 t9IXEM+GmL+H39urGdeqNt/erV3H9tRisjMx0ja/HFYXlreZBRtU7HyuNOTYsTJSQb0gn
	 D/ru/a40irhY738B5O29eYwRYl/Z+EPfg9mPhiS4efQXYDFaY54+tL8WkMoYoNx6btPlJ
	 S/oyNv/44XmtPJl9FDPzuR5nVivI6BiqwoJ6YMmDN3Pt7WvUohDmwKXpUk+5UkHuO9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793499843;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=3mPJSSqIX7nT4RdPVdlxGSVjbXJ2qWmvv0f0cx0sQMI=;
	b=2uqeXHFSCcjTzUfZqYSzrAipPhfHfnSymNtfHSEjuQ3birH3t8k330EeLuzVHB5o1qSB
	 0yOhtzfn9ypvhd7Z7lMXqzGlwe5tMGcXJQyAivRZmQiUQ6+gondBDL/MUi/w82EwAzzp6
	 GtQ6dfp6yfYKHbAaGcJGB9XvVKnP84d74k1O4YfOkFoLiGKwpjlfgjaoUvYRM0/FCrx5s
	 hKngeX+KDoyE48uneDlI7F2/5q72YvDX/icoB9pfZPu4iQ/qg5uA+Phvquq+U0OwU4zkn
	 AN9YRsmUnygf6VqxM5aWC+8NvpT26cXfkQsGycjxMwEcwPvfFnbQhsCadMM4x7nW2Wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SVdZbX2B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E32606A324;
	Sun,  1 Nov 2026 02:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SVdZbX2B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC2F51F000C1;
	Sun,  1 Nov 2026 02:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793499842;
	bh=3mPJSSqIX7nT4RdPVdlxGSVjbXJ2qWmvv0f0cx0sQMI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SVdZbX2BBQK71c2ZMUiX8T/g/cWxCilzPLAy2yCiIPNmEOQwLtgCBY4rL9MIXrpvl
	 YzJ4rIN4u3n/8mLfH/OOvrZl7JE1REIOuGLh5ZdYfK+IENC+tdNguMjuA+EuIXD+9Z
	 gUofFjNzk12mZyiQKaTR/3tWifL24vFw4RA6RjALJf6na8ExaWGgJXodZ2kGykBWMf
	 SEZqWl34ZbTU9YNj7nCD4mHCf9R58jVT9xn1TVeuvvcGfABZZAYclxRY2wn7NWln+9
	 7Btl4Oz2YCijo0JF8Vq0ZNpd2O17EoeWVna6VQlySijXQ2XoKAwTal6B+BttwVsSPf
	 jb2uP/f8iC9kA==
Date: Sun, 1 Nov 2026 02:23:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Josef Bacik
 <josef@toxicpanda.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable <stable@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Renato Lui Geh <renatogeh@gmail.com>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Ramona
 Bolboaca <ramona.bolboaca@analog.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH 05/15] iio: adc: check the result of ad_sd_init()
Message-ID: <20261101022354.16173af0@jic23-hlaptop>
In-Reply-To: <auHC27EyvvR9TYKu@nsa>
References: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
	<20261027-llm-char-misc-iio-v1-5-0d818334f6c7@linuxfoundation.org>
	<auHC27EyvvR9TYKu@nsa>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 28 Oct 2026 09:40:03 +0000
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> On Tue, Oct 27, 2026 at 05:19:09PM +0100, Greg Kroah-Hartman wrote:
> > From: Josef Bacik <josef@toxicpanda.com>
> >=20
> > ad_sd_init() asks for the optional "rdy" GPIO and returns the error if
> > that fails, for instance -EPROBE_DEFER. The binding of the AD7780
> > describes such a GPIO.
> >=20
> > ad7780, ad7791, ad7793 and max11205 ignore the result. The function has
> > then returned before it set the driver data of the IIO device, which
> > devm_ad_sd_setup_buffer_and_trigger() dereferences a few lines further
> > down in these probe functions, and sigma_delta->rdy_gpiod holds an
> > ERR_PTR() which ad_sigma_delta_clear_pending_event() takes for a GPIO.
> >=20
> > Return the error, as the other users of the library do.
> >=20
> > Fixes: a87ef09b1fdf ("iio: adc: ad_sigma_delta: Add support for reading=
 irq status using a GPIO")
> > Cc: stable <stable@kernel.org>
> > Cc: "Nuno S=C3=A1" <nuno.sa@analog.com>
> > Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> > Cc: Renato Lui Geh <renatogeh@gmail.com>
> > Cc: David Lechner <dlechner@baylibre.com>
> > Cc: Andy Shevchenko <andy@kernel.org>
> > Cc: Ramona Bolboaca <ramona.bolboaca@analog.com>
> > Cc: "Uwe Kleine-K=C3=B6nig" <u.kleine-koenig@baylibre.com>
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > --- =20
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied to the fixes-togreg branch of iio.git

thanks,

J
