Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794702410;
	b=pB5dJF6ESOKn7xutwaxdqNSI4NQItGC6DwX99Jt7AW2YudLGEUgpEo4ja8H31WYcyDVW
	 BPm8nU17vvu3GrLTAeQEWhf+E5dR6Hhj4kj0lhpyQm4pHoJzW9j+dyboGZVEBpvsScle6
	 DykxpolS866AR7YoOagKXtuO7Ec3/8CmmQzRS68fF087fxQqKJEUh1YbAIm3T76Qeqx8a
	 GYHq+rjVr2CFBH+P/KqOc+oeXwNOsla/asq9fVX/AvK9Oj0aLhQpYfsIfAV6zFb9E7beJ
	 5a0QHB9ws3j1TxsbwFLUn2w5XcGqLgl9iFcTEh4cci97y49tq3Q2NHIWzaSSPmUcnVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794702410;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=cs0WxjrarI6YjAKYtYssZQ5u95Q9CNeR1rZ225OtZSY=;
	b=ypqO6b+iUb5vuvwoFhVldfsGtaiBIdMdjIu85TeRqoebTUFyTNmqBWnbkSD6Fs7+E6UO
	 ouk7UmVNz48qt2z1xNcU9SOW4C6rGhjkA5GdFcZjMcmGOUHZtZJy3ehFQIdYVMZdz7xBw
	 Bq20ppj+zihz5JFWKQ1vwyEeg+/DpJJwKjn22+xuhIxuoBS+4zEwGmBxb+2HHjEWAhBbf
	 4qn6jii2X1Pf0z+lDzxq187JP8JapsbDzNkAwVcUZ+VzIiTKnA1VK738w2yDMxW3IUD4H
	 guK/iFV5J+P1PACjwyC2fWXJsdkmIxyhtKJ69/kHuWL4tJ2u2REbq/sUdi6XtvQx9jQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RBGcEl1u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7511D606A329;
	Sun, 15 Nov 2026 00:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RBGcEl1u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1EEA1F000C4;
	Sun, 15 Nov 2026 00:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794702410;
	bh=cs0WxjrarI6YjAKYtYssZQ5u95Q9CNeR1rZ225OtZSY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RBGcEl1ujDKrnUKfjiMIwYiwtsCpOrc4NLLonz0o4BpusAJqyfdmmPPLwBwCnmfhZ
	 ormZ2C154qiXLnkzVJA6/9ytPGLixjzCGS2u3qKoqmBZTgVZHPdTbTkPU26Wrqq7CU
	 l83dGwLzzhdcBlKNIuXOxG8Ic2EyOSYnBnDzWFe3oh2zCMqPbZGgAr+Loe0hUmGmau
	 JD3BK4HGW/lz7c2MSSUDosfsxEqTObO+sgmmuGCVus0Q0TFo+xGolq/RDw9uVQoSEy
	 8m7bTqnxqrEQ1nhzu/oYS8NwLqexFOsQFWBV7XGw4KrUU6lyuDklmKcaklmrcwkMEp
	 j7v/DzH8vHACA==
Date: Sun, 15 Nov 2026 00:26:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable <stable@kernel.org>, Jean-Baptiste
 Maneyrol <jean-baptiste.maneyrol@tdk.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 12/15] iio: imu: inv_mpu6050: don't disable the IRQ
 under lock
Message-ID: <20261115002642.7f7f378b@jic23-hlaptop>
In-Reply-To: <20261101021422.0c9e0815@jic23-hlaptop>
References: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
	<20261027-llm-char-misc-iio-v1-12-0d818334f6c7@linuxfoundation.org>
	<20261101021422.0c9e0815@jic23-hlaptop>
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

On Sun, 1 Nov 2026 02:14:22 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 27 Oct 2026 17:19:16 +0100
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>=20
> > From: Josef Bacik <josef@toxicpanda.com>
> >=20
> > If the chip is a wake-up source, inv_mpu_suspend() calls disable_irq() =
with
> > st->lock held.  disable_irq() waits for the threaded handler, and
> > inv_mpu6050_interrupt_handle() takes st->lock to read the interrupt
> > status.  If the chip raises an interrupt while the system is being
> > suspended, the handler waits for the lock, the suspend callback waits f=
or
> > the handler, and the suspend hangs.
> >=20
> > Disable the interrupt once the lock has been dropped.
> >=20
> > Fixes: 305914d01807 ("iio: imu: inv_mpu6050: add WoM suspend wakeup wit=
h low-power mode")
> > Cc: stable <stable@kernel.org>
> > Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com> =20
>=20
> This seems correct to me, but waiting on Jean-Baptiste for
> view from someone more familiar with the driver (and maybe
> able to give it a sanity check test!)

Ah well.  I guess Jean-Baptiste missed this or is snowed under.
Either way I'm confident enough that you are right (and the very
low chance of regression given the change) so applied to the fixes-togreg
branch of iio.git.

Thanks,

Jonathan

>=20
> > Cc: David Lechner <dlechner@baylibre.com>
> > Cc: "Nuno S=C3=A1" <nuno.sa@analog.com>
> > Cc: Andy Shevchenko <andy@kernel.org>
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 19 +++++++++++++++++--
> >  1 file changed, 17 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/i=
mu/inv_mpu6050/inv_mpu_core.c
> > index 38c3f3b398d4..0ae9d497ccfd 100644
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> > @@ -2166,7 +2166,7 @@ static int inv_mpu_resume(struct device *dev)
> >  	return result;
> >  }
> > =20
> > -static int inv_mpu_suspend(struct device *dev)
> > +static int __inv_mpu_suspend(struct device *dev, bool *disable)
> >  {
> >  	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> >  	struct inv_mpu6050_state *st =3D iio_priv(indio_dev);
> > @@ -2212,7 +2212,7 @@ static int inv_mpu_suspend(struct device *dev)
> >  		if (result)
> >  			return result;
> >  		enable_irq_wake(st->irq);
> > -		disable_irq(st->irq);
> > +		*disable =3D true;
> >  	} else {
> >  		result =3D inv_mpu6050_set_power_itg(st, false);
> >  		if (result)
> > @@ -2223,6 +2223,21 @@ static int inv_mpu_suspend(struct device *dev)
> >  	return 0;
> >  }
> > =20
> > +static int inv_mpu_suspend(struct device *dev)
> > +{
> > +	struct inv_mpu6050_state *st =3D iio_priv(dev_get_drvdata(dev));
> > +	bool disable =3D false;
> > +	int result;
> > +
> > +	result =3D __inv_mpu_suspend(dev, &disable);
> > +
> > +	/* Not under st->lock: this waits for the handler, which takes it */
> > +	if (disable)
> > +		disable_irq(st->irq);
> > +
> > +	return result;
> > +}
> > +
> >  static int inv_mpu_runtime_suspend(struct device *dev)
> >  {
> >  	struct inv_mpu6050_state *st =3D iio_priv(dev_get_drvdata(dev));
> >  =20
>=20
>=20

