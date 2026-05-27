Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6011A9B46;
	Wed, 27 May 2026 17:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779902120; cv=none; b=tLRj1T3O64+cCzPHvrEbAEGFC/gHJRDvw5ikeO7eTmQa35FBCvUyjqK/E/O97LOTX1zGwtwuJvp4LJbenCy0TpoOc+wQX34YPXKjtlHpkdEyE+XphTKVNDLWtiOdwRNpIpvlK19RUC2SOkmkKw1qwX/7V7L7sQxOsatvHB9kb8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779902120; c=relaxed/simple;
	bh=SmDNA8dr+LPplP/TJFhgcQitZA4HJd51EQzAoICqZeg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zgd57Xx09sA/LdXRLW7aEoZVYSKnebnmd1W3TTrUwQc+0BbpSWR6JtLdpyWavPYEfVLQo9m0KdR0/jhk79C/gHtI6k3jdHg50WZ3tvU41rm7jRLz+egjv4ny+FjZoV9wdnnfmiTPqkcvU79GfGiypVupZqjkiig83z9+GoKjc3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMKqIRyk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMKqIRyk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8CA41F000E9;
	Wed, 27 May 2026 17:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779902119;
	bh=1vCnoQRkEtD+XrZqBoThCSrmIulbUWdIz6ZA2Rdpc3Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dMKqIRyk4IH+XLbTeM8W1vRdtzK662aRclEhonH4z8WpCrzpuAJYAHT8kX+8pEX5J
	 THDtjETzwOl6B/Kyye8ANB+bXxJOYZWd02Wr179fdvgUxsxIL/2DcksKzcdceuZ4W1
	 4dyKh+wkDHvFO8wCAQ6MMyqV0bZexEMoPt5XO6Vrcvyv53Ep9LLFZcsLUfH7Sw63IW
	 +pDg+tCBRuQRUlkfF4BFkBfla5S57Z9M4gxik56b6qj1hlyUQpFslg/Cq7Vlaojnvr
	 ceqLl52qngeBt35eWfFqa6sIVJyLg9NRd/YotqjSnFFSjqp5Py9gZqJ1KAtdT5zrxP
	 Vk85xgIksr8vQ==
Date: Wed, 27 May 2026 18:15:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Gabriel Rondon <grondon@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, sozdayvek@gmail.com
Subject: Re: [PATCH v3] iio: accel: bmc150: use guard(mutex) for mutex
 handling
Message-ID: <20260527181513.6990a9b9@jic23-huawei>
In-Reply-To: <CAKqfh0E4XB75cN1gu_9k+aEUUXT1nVo=MLVshk-P1dk_K+HuOw@mail.gmail.com>
References: <20260525110130.61284-1-grondon@gmail.com>
	<CAKqfh0E4XB75cN1gu_9k+aEUUXT1nVo=MLVshk-P1dk_K+HuOw@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 25 May 2026 15:34:52 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> Hi Gabriel, comments inline.
>=20
> On Mon, May 25, 2026 at 6:01=E2=80=AFAM Gabriel Rondon <grondon@gmail.com=
> wrote:
> >
> > Replace manual mutex_lock()/mutex_unlock() pairs with guard(mutex)
> > and scoped_guard() from cleanup.h. This simplifies error paths by
> > removing the need for explicit unlock calls before returning.
> >
> > Most converted functions hold the lock for their entire body, so
> > guard(mutex) applies directly. bmc150_accel_trigger_handler() only
> > holds the lock around a single register read, so scoped_guard() is
> > used there to keep the lock scope unchanged.
> >
> > Signed-off-by: Gabriel Rondon <grondon@gmail.com>
> > Reviewed-by: Stepan Ionichev <sozdayvek@gmail.com>
I'm not going to apply this quite yet because one of the bugs sashiko
pointed out needs fixing more urgently than this patch.
https://sashiko.dev/#/patchset/20260525110130.61284-1-grondon%40gmail.com

static irqreturn_t bmc150_accel_trigger_handler(int irq, void *p)
{
	struct iio_poll_func *pf =3D p;
	struct iio_dev *indio_dev =3D pf->indio_dev;
	struct bmc150_accel_data *data =3D iio_priv(indio_dev);
	int ret;

	mutex_lock(&data->mutex);
	ret =3D regmap_bulk_read(data->regmap, BMC150_ACCEL_REG_XOUT_L,
			       data->buffer, AXIS_MAX * 2);
	mutex_unlock(&data->mutex);
	if (ret < 0)
		goto err_read;

	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
//Buffer isn't aligned to an s64
					   pf->timestamp);
err_read:
	iio_trigger_notify_done(indio_dev->trig);

	return IRQ_HANDLED;
}

The timestamp may end up as an unaligned s64 write which on some
architectures will fail. =20

I'm not sure why the driver isn't using data->scan for this path
It seems much more logical as a target and is already appropriately
aligned for this call - it should actually be aligned with
__aligned(IIO_DMA_MINALIGN) and moved to the end of the structure
because this driver supports SPI transfers and we are still not
assuming a regmap_bulk_read() won't use the buffer directly for DMA.

The other comment sashiko made that I think might be valid is the
one about:

static int bmc150_accel_write_event_config(struct iio_dev *indio_dev,
					   const struct iio_chan_spec *chan,
					   enum iio_event_type type,
					   enum iio_event_direction dir,
					   bool state)
{
	struct bmc150_accel_data *data =3D iio_priv(indio_dev);
	int ret;

	if (state =3D=3D data->ev_enable_state)
//check not under lock so two racing threads can pass it.
		return 0;

	mutex_lock(&data->mutex);

	ret =3D bmc150_accel_set_interrupt(data, BMC150_ACCEL_INT_ANY_MOTION,
//and increment the counter burried in this call, but on the disable
//path we may see only one decrement.

					 state);
	if (ret < 0) {
		mutex_unlock(&data->mutex);
		return ret;
	}

	data->ev_enable_state =3D state;
	mutex_unlock(&data->mutex);

	return 0;
}

Good to fix that one before this guard() patch - will need an extra unlock
obviously, then follow up with a 3rd patch that is similar to this but
with the guard() a few lines earlier

> > ---
> > Changes since v2:
> >  - bmc150_accel_get_fifo_state(): normalize fifo_mode to 0/1 in the
> >    sysfs output (data->fifo_mode ? 1 : 0). v2 dropped the bool
> >    intermediate and printed the raw mode value, which would emit the
> >    FIFO mode bit (0x40) as 64 instead of 0/1. The original 0/1 output
> >    is preserved. Reported by Jonathan Cameron.
> >  - Collected Reviewed-by from Stepan Ionichev.
> >
> > Changes since v1:
> >  - Drop the verbose list of converted functions from the commit message.
> >  - bmc150_accel_get_temp(): keep the original declaration order; no
> >    unrelated line movement.
> >  - bmc150_accel_get_axis(): convert to guard(mutex) as well, the only
> >    code outside the old lock scope was a trivial error check.
> >  - bmc150_accel_trigger_handler(): use scoped_guard() so that no manual
> >    mutex_lock()/mutex_unlock() pairs are left behind.
> >  - bmc150_accel_get_fifo_watermark() / bmc150_accel_get_fifo_state():
> >    drop the intermediate variable and return directly.
> >
> >  drivers/iio/accel/bmc150-accel-core.c | 68 ++++++++-------------------
> >  1 file changed, 20 insertions(+), 48 deletions(-)
> > =20
> [snip]
> > @@ -624,25 +622,21 @@ static int bmc150_accel_get_axis(struct bmc150_ac=
cel_data *data,
> >         int axis =3D chan->scan_index;
> >         __le16 raw_val;
> >
> > -       mutex_lock(&data->mutex);
> > +       guard(mutex)(&data->mutex);
> >         ret =3D bmc150_accel_set_power_state(data, true);
> > =20
>=20
> Just a heads up, Jonathan or Andy may ask you to add a blank line in
> between the guard()() and the function call below.
Yup. I might have tweaked that whilst applying.=20
>=20
> >
> > -       if (ret < 0) {
> > -               mutex_unlock(&data->mutex);
> > +       if (ret < 0)
> >                 return ret;
> > -       }
> >
> >         ret =3D regmap_bulk_read(data->regmap, BMC150_ACCEL_AXIS_TO_REG=
(axis),
> >                                &raw_val, sizeof(raw_val));
> >         if (ret < 0) {
> >                 dev_err(dev, "Error reading axis %d\n", axis);
> >                 bmc150_accel_set_power_state(data, false);
> > -               mutex_unlock(&data->mutex);
> >                 return ret;
> >         }
> >         *val =3D sign_extend32(le16_to_cpu(raw_val) >> chan->scan_type.=
shift,
> >                              chan->scan_type.realbits - 1);
> >         ret =3D bmc150_accel_set_power_state(data, false);
> > -       mutex_unlock(&data->mutex);
> >         if (ret < 0)
> >                 return ret;
> > =20
> [snip]
> > @@ -1187,10 +1168,9 @@ static irqreturn_t bmc150_accel_trigger_handler(=
int irq, void *p)
> >         struct bmc150_accel_data *data =3D iio_priv(indio_dev);
> >         int ret;
> >
> > -       mutex_lock(&data->mutex);
> > -       ret =3D regmap_bulk_read(data->regmap, BMC150_ACCEL_REG_XOUT_L,
> > -                              data->buffer, AXIS_MAX * 2);
> > -       mutex_unlock(&data->mutex);
> > +       scoped_guard(mutex, &data->mutex)
> > +               ret =3D regmap_bulk_read(data->regmap, BMC150_ACCEL_REG=
_XOUT_L,
> > +                                      data->buffer, AXIS_MAX * 2);
> >         if (ret < 0)
> >                 goto err_read;
> > =20
>=20
> Another heads up, you may be asked to refactor the critical section
> into a helper or do guard()() with {}. So, something like (and not
> compiled! Also, don't use this directly, the mail client I'm using to
> send this converts tabs to spaces!):
>=20

Whilst I don't  much like scoped_guard() for readability reasons, the
one time I'm normally ok with it is for single calls like this.
The helper isn't going to add much, unlike when we have a bunch of calls
under the lock.

It's a bit marginal as it sort of violates the no guard + goto rules
so maybe a helper is a better idea as you suggest.

> {
>         guard(mutex)(&data->mutex);
>         ret =3D regmap_bulk_read(data->regmap, BMC150_ACCEL_REG_XOUT_L,
>                                                data->buffer, AXIS_MAX * 2=
);
> }
>=20
> or:
>=20
> static int bmc150_accel_trigger_handler_helper(struct bmc150_accel_data *=
data)
> {
>         guard(mutex)(&data->mutex);
>         return regmap_bulk_read(data->regmap, BMC150_ACCEL_REG_XOUT_L,
>                                                  data->buffer, AXIS_MAX *=
 2);
> }
>=20
> Obviously, the patch as-is seems correct to me, so
>=20
> Reviewed-by: Maxwell Doose <m32285159@gmail.com>
>=20
> best regards,
> max

