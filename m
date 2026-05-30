Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F1B317145;
	Sat, 30 May 2026 15:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780154625; cv=none; b=N9rwIs2fKUy5c7BLSwnflZQca77PVXtLJk6bKzsCTEkja1ABtvghIkWzqkw/+XaPmT4oa4xGgdXo9PRfq70BK8+FyuuuwDQOSDg92s0EPjcirgswdGNn4axXPeIyxAxGG59gZ7gG6j75AaHXYBUXRJN84vwJOgYJG/kyTpyHr3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780154625; c=relaxed/simple;
	bh=vJypQl+N477WZZcDFzJ3gdUWCBpHjL0/kx8u+mX6b2U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s5L4MCo6looKLXiJFyBs6XY1EB4lYLdmPdW3bFVnCDgb//Fd1vflAfE8jnhuDwBfHrLXmvrvpooiNm8kFSe8bms3VS1riu4XNYOnZf6rbqb4bVmxFXaz8jREUM/T2zvO7FnNTytJ/UXTyulINv+/skgZZwBDRZC6agfFYbEhdSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/CnrPuO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/CnrPuO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 398E91F00893;
	Sat, 30 May 2026 15:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780154623;
	bh=JWjqWr03chW3qqN70vtQVkeU6J3pZkEEKdIcer4o+ak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=h/CnrPuOUtWpz0m6t3pWy4XkA7Op6Am/IeTkIc/U3erbXsWfMYJE6f1WLOmgktFIb
	 t6rExKjdjQX8LYk+Cvy7rAjEtwNLURrIYjn2bfnfDnkQzohPS47AEZSrJmmPEhFpj2
	 ORMGCA88q+S5HKWXbds5/ND4Xf5RAVcg8bcwzVPQK2RBjhEqwnesdNq3lztOT5D1pm
	 epFP0Qa5FJarTQTBhAfTrZI8JVHLrD5XI7Dpl7yrzPrfyO7gW1tZYA0ZreQI8v+QGn
	 3n2HJzGelHZlxywNJ2V7RhJs+5XwfARe/dCOaURJJdnock7YP/u9ZgpPH45HE4cNrO
	 wMvy4PFRMhT9g==
Date: Sat, 30 May 2026 16:23:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: SeungJu Cheon <suunj1331@gmail.com>
Cc: linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, apokusinski01@gmail.com, me@brighamcampbell.com,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH 2/4] iio: pressure: mpl3115: clean up interrupt handling
 and locking
Message-ID: <20260530162335.048cfec4@jic23-huawei>
In-Reply-To: <20260530113938.171540-3-suunj1331@gmail.com>
References: <20260530113938.171540-1-suunj1331@gmail.com>
	<20260530113938.171540-3-suunj1331@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 30 May 2026 20:39:36 +0900
SeungJu Cheon <suunj1331@gmail.com> wrote:

> Return IRQ_NONE instead of IRQ_HANDLED when reading
> INT_SOURCE fails.

As in previous, wrap to 75 chars for commit messges.

>=20
> On shared interrupt lines, returning IRQ_HANDLED after a
> failed register read may prevent other handlers from being
> invoked.

=46rom what I recall that is simply not true.  Given interrupts might occur
at same moment, the shared interrupt code calls all handlers as it can't
tell if how many interrupt sources have signalled an interrupt.

Look more closely at what isn't invoked (hint it's about when things
go wrong!)

Also, doesn't look to me like this driver supports sharing of the interrupt
anyway.


>=20
> Switch the trigger handler from explicit mutex_lock/unlock
> to scoped_guard() for consistency with the locking style
> used elsewhere in the driver.

I'm a little dubious about the value of scoped_guard() for such simple
cases but I guess it is harmless.  As Andy called out though, different
type of change, different patch.

Hmm. Actually do it by pushing the lock down into the function called
instead and there you can use a guard(). Has the added advantage of making
the exact scope of the locking visible next to the calls in it.
So put it in mpl3115_fill_trig_buffer().

>=20
> Move mpl3115_config_interrupt() above the interrupt handler
> in preparation for the FIFO support added in a subsequent
> patch.

Separate patch as moving and doing other things just makes for harder
to review code.

>=20
> No functional change intended.

Except for the one you call out above.

>=20
> Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
> ---
>  drivers/iio/pressure/mpl3115.c | 59 +++++++++++++++++-----------------
>  1 file changed, 29 insertions(+), 30 deletions(-)
>=20
> diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl311=
5.c
> index befb6d48efa9..52a3d0d59769 100644
> --- a/drivers/iio/pressure/mpl3115.c
> +++ b/drivers/iio/pressure/mpl3115.c
> @@ -308,9 +308,8 @@ static irqreturn_t mpl3115_trigger_handler(int irq, v=
oid *p)
>  	u8 buffer[16] __aligned(8) =3D { };
>  	int ret;
> =20
> -	mutex_lock(&data->lock);
> -	ret =3D mpl3115_fill_trig_buffer(indio_dev, buffer);
> -	mutex_unlock(&data->lock);
> +	scoped_guard(mutex, &data->lock)
> +		ret =3D mpl3115_fill_trig_buffer(indio_dev, buffer);
>  	if (ret)
>  		goto done;
> =20
> @@ -322,6 +321,32 @@ static irqreturn_t mpl3115_trigger_handler(int irq, =
void *p)
>  	return IRQ_HANDLED;
>  }
> =20
> +static int mpl3115_config_interrupt(struct mpl3115_data *data,
> +				    u8 ctrl_reg1, u8 ctrl_reg4)
> +{
> +	int ret;
> +
> +	ret =3D i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG1,
> +					ctrl_reg1);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG4,
> +					ctrl_reg4);
> +	if (ret < 0)
> +		goto reg1_cleanup;
> +
> +	data->ctrl_reg1 =3D ctrl_reg1;
> +	data->ctrl_reg4 =3D ctrl_reg4;
> +
> +	return 0;
> +
> +reg1_cleanup:
> +	i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG1,
> +				  data->ctrl_reg1);
> +	return ret;
> +}
> +
>  static const struct iio_event_spec mpl3115_temp_press_event[] =3D {
>  	{
>  		.type =3D IIO_EV_TYPE_THRESH,
> @@ -381,7 +406,7 @@ static irqreturn_t mpl3115_interrupt_handler(int irq,=
 void *private)
> =20
>  	ret =3D i2c_smbus_read_byte_data(data->client, MPL3115_INT_SOURCE);
>  	if (ret < 0)
> -		return IRQ_HANDLED;
> +		return IRQ_NONE;

So the fun of error handling in interrupt threads.  Arguably we have no idea
if it was our interrupt or not if this occurs - which I suspect is the moti=
vation
of the author in returning IRQ_HANDLED here (and IRQ_NONE when we did read =
but there
were no interrupts).

I think IRQ_NONE still makes more sense because if we do have an intermitte=
nt fault
and the state is such that the interrupt will retrigger, then it doesn't ma=
tter if we
flag one spurious interrupt.


> =20
>  	if (!(ret & (MPL3115_INT_SRC_TTH | MPL3115_INT_SRC_PTH |
>  		     MPL3115_INT_SRC_DRDY)))
> @@ -420,32 +445,6 @@ static irqreturn_t mpl3115_interrupt_handler(int irq=
, void *private)
>  	return IRQ_HANDLED;
>  }
> =20
> -static int mpl3115_config_interrupt(struct mpl3115_data *data,
> -				    u8 ctrl_reg1, u8 ctrl_reg4)
> -{
> -	int ret;
> -
> -	ret =3D i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG1,
> -					ctrl_reg1);
> -	if (ret < 0)
> -		return ret;
> -
> -	ret =3D i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG4,
> -					ctrl_reg4);
> -	if (ret < 0)
> -		goto reg1_cleanup;
> -
> -	data->ctrl_reg1 =3D ctrl_reg1;
> -	data->ctrl_reg4 =3D ctrl_reg4;
> -
> -	return 0;
> -
> -reg1_cleanup:
> -	i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG1,
> -				  data->ctrl_reg1);
> -	return ret;
> -}
> -
>  static int mpl3115_set_trigger_state(struct iio_trigger *trig, bool stat=
e)
>  {
>  	struct iio_dev *indio_dev =3D iio_trigger_get_drvdata(trig);

