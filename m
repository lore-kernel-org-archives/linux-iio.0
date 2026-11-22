Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795377176;
	b=VVpqbbyKK+aj8075b1272dtJha7d/Nq0hstDCawwYiLMspvJZKq5ZSv7VPhkWbQ5/KEx
	 Td0egKdKodPS2smvykM+TdqFO+VVuKPzxNX//POEVvq1qD3FVVy4fkLsY8XaFacaUh4qu
	 WFjJU+tCX4VwoJ69h8gcXom4Y+nS1BmTO+o7UnyP2v+vLch+y74aqzu1f/EU5zw07ZgJN
	 HgYM0gotGlYXFvR/Q/UXhxpjA1kIoRnekKhIEUqG0EhZMg4ICG2rD8islvWxRzGo9xegN
	 OejG9lH2u0luxWoyPs//ZRSi8QmyRL9nNZaR4fsoQcfZDOIXAPBkZ1kZADUyvEraYlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795377176;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=jB9LrMbhX//Yo0RRt1iibdPYWNJz5AcR3xAbcM9m9Vs=;
	b=dUZkNvYOWL9wjejO+7obIJUQolRB0L+GCmXDGJ7LHy0RXqaFz0d8BmeS3Gb4pdBBtyLd
	 QDHliIubKHpJsHMmPyIn/yBGHs4zxSS7suT79gyhPaLm1xs3W4H26CCuYHNRvepA/EpRR
	 /oqXwMhYTxbJo8YbIGnvR0eBiTfR7DU9efJmyya/51T5gbTmCfU90XwCdcc2Tg3eyOZFX
	 FsIS3jToHyhKWNJPv1MR2NduQpTU+keiMi5q+BBTbl3PtBnkFVGC9wTJxr6zsaMDtGHUq
	 maiNZo0gO2QSfc++Vi34TWk0ry/Ds4GDBexE5T+7zYiIb12haSQ1AuWFnCScPgmK7Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yj1OpBgN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E929A606A31A;
	Sun, 22 Nov 2026 19:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yj1OpBgN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A921F1F000C4;
	Sun, 22 Nov 2026 19:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795377175;
	bh=jB9LrMbhX//Yo0RRt1iibdPYWNJz5AcR3xAbcM9m9Vs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Yj1OpBgNsLEJbpywVeiPo15bArf2mleBqh8wvh9q2eIX7OHXj/XWcjHS4ZtqHX7HE
	 ImuHID8gbd6v8TcCcbAIzUFp4bexxnAiruntt8+PgXrbLdzvRUIxY2ePa3D4Lg8jHG
	 BSNb9O1Uk2NxUk8zMBOHzwmu/R84VzXosZZ69zyTguvTRKfKrV3CeSm2lGjDtQ/1kb
	 eGZX0Ga6piktzbYyNJkAQ+6FjTki7I9fReVBKmsG6MzQdRrG4LsG1cmNG+c8hHbwVs
	 UdsSghPPshOF+LQKp2MhyRK4i2fZr2+ffCPISQigOxMBpvgRLg1XJSPpCveaOg7c+H
	 xWifZl8MdvKkw==
Date: Sun, 22 Nov 2026 19:52:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-kernel@vger.kernel.org, Jonathan Cameron
 <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH] iio: adc: max1027: complete the EOC wait when using an
 external trigger
Message-ID: <20261122195249.13ee9686@jic23-hlaptop>
In-Reply-To: <874idfn30h.fsf@bootlin.com>
References: <20261115204551.2783884-1-jic23@kernel.org>
	<874idfn30h.fsf@bootlin.com>
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

On Tue, 17 Nov 2026 11:52:46 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Hi Jonathan,
>=20
> On 15/11/2026 at 20:45:51 GMT, Jonathan Cameron <jic23@kernel.org> wrote:
>=20
> > From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> >
> > When an external trigger is in use, max1027_trigger_handler() starts the
> > conversion and then waits in max1027_wait_eoc() for the end of conversi=
on
> > interrupt to complete(&st->complete). However max1027_handler() only
> > completes it when the buffer is disabled. With the buffer enabled it
> > instead polls the current trigger, which is the external trigger
> > that is still being handled, so the poll does nothing,
> > the wait times out and every sample fails with -ETIMEDOUT.
> >
> > Complete the wait when the buffer is enabled but the device's own
> > trigger is not in use, as the comment above the check already
> > describes.
> >
> > Fixes: 075d3280b4a1 ("iio: adc: max1027: Allow all kind of triggers to =
be used")
> > Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> >
> > ---
> >
> > The comment clearly states that we should just complete for
> > triggers other than the one provided by this device, but the
> > code doesn't do this. Ideal would be if someone has the part and
> > can test this. =20
>=20
> I no longer have an easy way to run that code, but looking at it 5 years
> later, I agree with your description of the problem as well as your
> solution.
>=20
> > LLM spotted the issue whilst doing some other cleanup and
> > prepared the patch.
> >
> > I think the reason this got past testing was that the code was
> > fixed to actually return an error on timeout whereas a bug
> > previously meant it always dropped through and carried on. =20
>=20
> Ah, right, intersting, I guess you talk about
> 2021ef060900 ("iio: adc: max1027: fix error code in max1027_wait_eoc()")
>=20
> > ---
> >  drivers/iio/adc/max1027.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
> > index d475cc91108d..65a0e85faca9 100644
> > --- a/drivers/iio/adc/max1027.c
> > +++ b/drivers/iio/adc/max1027.c
> > @@ -478,7 +478,7 @@ static irqreturn_t max1027_handler(int irq, void *p=
rivate)
> >  	 * with another device. The core will then call the relevant handler =
to
> >  	 * perform the data processing step.
> >  	 */
> > -	if (!iio_buffer_enabled(indio_dev))
> > +	if (!iio_buffer_enabled(indio_dev) || !iio_trigger_using_own(indio_de=
v))
> >  		complete(&st->complete);
> >  	else
> >  		iio_trigger_poll(st->trig); =20
>=20
> In case you want to make it closer to what other drivers do, you may
> invert the condition to simplify the reading:
>=20
> 	if (iio_buffer_enabled(indio_dev) && iio_trigger_using_own(indio_dev))
>   		iio_trigger_poll(st->trig);
>   	else
>   		complete(&st->complete);
That is indeed more natural so done what you suggest and applied.
We are fairly late in the cycle so I'm not going to rush this in.

Applied to the testing branch of iio.git, so targeting next merge window.

Thanks,

Jonathan

>=20
> Regardless of that change,
>=20
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
>=20
> Thanks,
> Miqu=C3=A8l

