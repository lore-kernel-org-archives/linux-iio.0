Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD0732ED3A;
	Fri, 25 Sep 2026 02:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790303318; cv=none; b=abmP6LBLj9qkKfMELLZXHPwY4YUvDEsS35OCAkveHU+FAreMqDMiB8lXuTWwzwIDMiMTlz76lnfRDn3zykxb9KnskZb/UNo62tWVdzKYe9Iwl1tL6QEkCg2ZU7V6+RTZCR8TIhYdQQp/6ouH2pO+vmIz77lGdKQ+AVYkuB5C6Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790303318; c=relaxed/simple;
	bh=z4Q9Up30GPThJgGmkONs/sU9OzCm7u+4BRBNcNRjapI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P9LgwhdP+EoTXXYfn3ylhIbYGkVoJ7b4DuMdSerCwxDOzsdMNU78dCZAUyfg8gBgvfAk4rRlnTn7DHE/r63uzVqQoAwtYdv3dvhzIOBugqJH5XQxehOc2Xpq/MvrbaP1/HUldzh6hLt41vfzwIwhcR/4e6/p7Kq1xzXDUYk3jWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KyHXYh0H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyHXYh0H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC661F000FF;
	Fri, 25 Sep 2026 02:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790303317;
	bh=5v6MISeHpe/4mcQWjNeXTIoK1j5tdhtNL1a+WNkKcVA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KyHXYh0HjdRAhI2c8amvu8OK9kSSzq3wdaQ9klJYqpPl3cBxDfRw47svldz+6Vxbm
	 x8jrGSHm0B3LScpQ6yxQEdcEGpmmVRjCLQfbREoIrhz2B+YMSUXSV7HhsmtBlNXYIb
	 cwplPoWBNquP5vp3/N8zoOfL4UGEY3kI4BFi+21p8rEHTwrexix8d237yim4QbI8R3
	 I8n8H2WUk2kDlOckrvkFbfZ8LiXEko4koVWZtkbBon/ETTP7OtgXu+ITz1W2ukGWYN
	 Wnu75Irj+QQWX6zZAlXm4ROhGCB2EWz+PLjSRiH+f17WLc1bK4N2EjcEK+bf5IKpiP
	 mZCoriVpWt74w==
Date: Fri, 25 Sep 2026 03:28:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v9 3/5] iio: magnetometer: ak8975: use temporary
 variable for struct device
Message-ID: <20260925032834.16498c58@jic23-hlaptop>
In-Reply-To: <20260925032112.1cf46d80@jic23-hlaptop>
References: <20260920-ak8975-cleanup-v9-0-1b0f00ec19ef@gmail.com>
	<20260920-ak8975-cleanup-v9-3-1b0f00ec19ef@gmail.com>
	<20260925032112.1cf46d80@jic23-hlaptop>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 25 Sep 2026 03:21:12 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sun, 20 Sep 2026 20:05:25 +0200
> Joshua Crofts <joshua.crofts1@gmail.com> wrote:
>=20
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >=20
> > Use temporary variable for struct device to make code neater.
> >=20
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com> =20
> A couple of places in here where I'd also switch to dev_err_probe().
>=20
> Jonathan
diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/a=
k8975.c
index 66f105d8e42d..0e0eba116d52 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -613,38 +613,28 @@ static int ak8975_setup(struct ak8975_data *data)
=20
        /* Write the fused rom access mode. */
        ret =3D ak8975_set_mode(data, FUSE_ROM);
-       if (ret < 0) {
-               dev_err(dev, "Error in setting fuse access mode\n");
-               return ret;
-       }
+       if (ret < 0)
+               return dev_err_probe(dev, ret, "Error in setting fuse acces=
s mode\n");
=20
        /* Get asa data and store in the device data. */
        ret =3D i2c_smbus_read_i2c_block_data_or_emulated(client,
                                                        data->def->ctrl_reg=
s[ASA_BASE],
                                                        sizeof(data->asa),
                                                        data->asa);
-       if (ret < 0) {
-               dev_err(dev, "Not able to read asa data\n");
-               return ret;
-       }
-       if (ret !=3D sizeof(data->asa)) {
-               dev_err(dev, "Error reading asa data\n");
-               return -EIO;
-       }
+       if (ret < 0)
+               return dev_err_probe(dev, ret, "Not able to read asa data\n=
");
+       if (ret !=3D sizeof(data->asa))
+               return dev_err_probe(dev, ret, "Error reading asa data\n");
=20
        /* After reading fuse ROM data set power-down mode */
        ret =3D ak8975_set_mode(data, POWER_DOWN);
-       if (ret < 0) {
-               dev_err(dev, "Error in setting power-down mode\n");
-               return ret;
-       }
+       if (ret < 0)
+               return dev_err_probe(dev, ret, "Error in setting power-down=
 mode\n");
=20
        if (data->eoc_gpiod || client->irq > 0) {
                ret =3D ak8975_setup_irq(data);
-               if (ret < 0) {
-                       dev_err(dev, "Error setting data ready interrupt\n"=
);
-                       return ret;
-               }
+               if (ret < 0)
+                       return dev_err_probe(dev, ret, "Error setting data =
ready interrupt\n");
        }
=20
        data->raw_to_gauss[0] =3D data->def->raw_to_gauss(data->asa[0]);
>=20
> > ---
> >  drivers/iio/magnetometer/ak8975.c | 65 +++++++++++++++++++------------=
--------
> >  1 file changed, 32 insertions(+), 33 deletions(-)
> >=20
> > diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetomet=
er/ak8975.c
> > index 59a7bb83a731..42f6892f4efd 100644
> > --- a/drivers/iio/magnetometer/ak8975.c
> > +++ b/drivers/iio/magnetometer/ak8975.c =20
>=20
> > @@ -580,6 +579,7 @@ static irqreturn_t ak8975_irq_handler(int irq, void=
 *data)
> >  static int ak8975_setup_irq(struct ak8975_data *data)
> >  {
> >  	struct i2c_client *client =3D data->client;
> > +	struct device *dev =3D &client->dev;
> >  	int irq;
> >  	int ret;
> > =20
> > @@ -590,9 +590,8 @@ static int ak8975_setup_irq(struct ak8975_data *dat=
a)
> >  	else
> >  		irq =3D gpiod_to_irq(data->eoc_gpiod);
> > =20
> > -	ret =3D devm_request_irq(&client->dev, irq, ak8975_irq_handler,
> > -			       IRQF_TRIGGER_RISING,
> > -			       dev_name(&client->dev), data);
> > +	ret =3D devm_request_irq(dev, irq, ak8975_irq_handler, IRQF_TRIGGER_R=
ISING,
> > +			       dev_name(dev), data);
> >  	if (ret)
> >  		return ret;
> > =20
> > @@ -608,12 +607,13 @@ static int ak8975_setup_irq(struct ak8975_data *d=
ata)
> >  static int ak8975_setup(struct ak8975_data *data)
> >  {
> >  	struct i2c_client *client =3D data->client;
> > +	struct device *dev =3D &client->dev;
> >  	int ret;
> > =20
> >  	/* Write the fused rom access mode. */
> >  	ret =3D ak8975_set_mode(data, FUSE_ROM);
> >  	if (ret < 0) {
> > -		dev_err(&client->dev, "Error in setting fuse access mode\n");
> > +		dev_err(dev, "Error in setting fuse access mode\n");
> >  		return ret;
> >  	}
> > =20
> > @@ -623,26 +623,25 @@ static int ak8975_setup(struct ak8975_data *data)
> >  							sizeof(data->asa),
> >  							data->asa);
> >  	if (ret < 0) {
> > -		dev_err(&client->dev, "Not able to read asa data\n"); =20
>=20
> _setup is only called from probe, so the prints in here can all
> be return dev_err_probe();
>=20
> > +		dev_err(dev, "Not able to read asa data\n");
> >  		return ret;
> >  	}
> >  	if (ret !=3D sizeof(data->asa)) {
> > -		dev_err(&client->dev, "Error reading asa data\n");
> > +		dev_err(dev, "Error reading asa data\n");
> >  		return -EIO;
> >  	}
> > =20
> >  	/* After reading fuse ROM data set power-down mode */
> >  	ret =3D ak8975_set_mode(data, POWER_DOWN);
> >  	if (ret < 0) {
> > -		dev_err(&client->dev, "Error in setting power-down mode\n");
> > +		dev_err(dev, "Error in setting power-down mode\n");
> >  		return ret;
> >  	}
> > =20
> >  	if (data->eoc_gpiod || client->irq > 0) {
> >  		ret =3D ak8975_setup_irq(data);
> >  		if (ret < 0) {
> > -			dev_err(&client->dev,
> > -				"Error setting data ready interrupt\n");
> > +			dev_err(dev, "Error setting data ready interrupt\n");
> >  			return ret;
> >  		}
> >  	} =20
>=20
>=20
>=20

