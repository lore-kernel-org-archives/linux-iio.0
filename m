Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8924541B36D;
	Wed, 25 Mar 2026 19:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774468043; cv=none; b=P8Nlbv3s7yzYjUnegwCKaEyictaIaD7rWN3+f6A2BqdTdhiYBAqfcf/CMi0YLpViB5VE7wKI2QK8hOb5F3hhmtK4nMeDVxynGn9uazC8XfKxTsDRQDRPMUlMuLr5kdXb53RAq271WwewpUmFwmsiwvop5Z22wCinS/wQm0OIGx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774468043; c=relaxed/simple;
	bh=gLgsNR8sUVL3i9V1ikGpb/C8xG/LBQID40MPKfULo4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kJFlcHEW8OJFWxixQT9Tn0isa5OLKI/Ym/bmZBe60lYaCPu0cnM55p32TazT27Ggw/mrZBoDCZ3iOkjs6IRs9/Z9kbgGI/LRmvEG4tZ0qa1TCl3ZAHmq3ji95/V0yNZQhJKf6cq9xc4g9vh5GiT07wBvDPfDKxsDCkiU+Qq9BuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtFVVlDg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtFVVlDg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D460C4CEF7;
	Wed, 25 Mar 2026 19:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774468043;
	bh=gLgsNR8sUVL3i9V1ikGpb/C8xG/LBQID40MPKfULo4Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PtFVVlDgpuBIPRU4wISmKzpJdUlvEThbyvvjFMxq5I8Ji1kTVRj1x0iBWV43YuF9k
	 XDl4MNeGoNWAVsWIbncPAp0T4oMTZX4vkXVMjYM0qts8ogZ/lfjkvEbsyQd+69oo7V
	 8UnBKYKkNqrvYKhvPO4uROD2xbOhxVRQlKm02S2+yihLlZXiMJb8pzfRNcYcLeJwsd
	 pH/k1rm1PpzTLOAGSmj5KU9ZxcSx0baidZrwDsDrB7MO+D/wYwARKa7lbYzCezpSJd
	 L4E0h5aI1a9C1YzWfOwqSmoL/AO2LuD3eLSqk3QBzOAamjSxIcSclByZu/oqRZtUuU
	 GtUTDq5qo2lpQ==
Date: Wed, 25 Mar 2026 19:47:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Sirat <email@sirat.me>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v7 2/2] iio: proximity: add driver for ST VL53L1X ToF
 sensor
Message-ID: <20260325194713.6e986590@jic23-huawei>
In-Reply-To: <CANn+LW+tLc2sQwfknieUi1pCat0+HQWrCFN0WTJ4rC_7_qFGpQ@mail.gmail.com>
References: <20260325063254.18062-1-email@sirat.me>
	<20260325063254.18062-3-email@sirat.me>
	<20260325144719.00005a92@huawei.com>
	<CANn+LW+tLc2sQwfknieUi1pCat0+HQWrCFN0WTJ4rC_7_qFGpQ@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 25 Mar 2026 22:33:22 +0600
Sirat <email@sirat.me> wrote:

> On Wed, Mar 25, 2026 at 8:47=E2=80=AFPM Jonathan Cameron
> <jonathan.cameron@huawei.com> wrote:
> >
> > On Wed, 25 Mar 2026 12:32:23 +0600
> > Siratul Islam <email@sirat.me> wrote:
> > =20
> > > Add support for the STMicroelectronics VL53L1X Time-of-Flight
> > > ranging sensor with I2C interface.
> > >
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > > Signed-off-by: Siratul Islam <email@sirat.me> =20
> >
> > Hi Siratul,
> >
> > I used this as a bit of an experiment as you'd +CC lkml and took a close
> > read of the feedback google's AI bot produced.
> > https://sashiko.dev/#/patchset/20260325063254.18062-1-email%40sirat.me
> >
> > Be very careful when considering the output. There are some things
> > in here that are not true, or we don't generally defend against (like t=
he
> > interrupt type related comments).
> >
> > The iio_trigger_get() is (I think) a more general problem so ignore that
> > for your driver - will just be a tiny memory leak and stop the
> > module being easily unloaded.  I'll take a look at that one on a more g=
eneral
> > basis.
> >
> > The regmap one is where these bots excel in that they sometimes go deep=
er
> > in analysis than a typical person focused on one driver.
> >
> > The stuff on using standard devm_ wasn't from the bot and I think will =
make
> > things rather simpler.
> >
> > Thanks,
> >
> > Jonathan
> >
> > =20
> > > ---
> > >  MAINTAINERS                         |   1 +
> > >  drivers/iio/proximity/Kconfig       |  15 +
> > >  drivers/iio/proximity/Makefile      |   1 +
> > >  drivers/iio/proximity/vl53l1x-i2c.c | 795 ++++++++++++++++++++++++++=
++
> > >  4 files changed, 812 insertions(+)
> > >  create mode 100644 drivers/iio/proximity/vl53l1x-i2c.c
> > > =20
> > =20
> > > diff --git a/drivers/iio/proximity/vl53l1x-i2c.c b/drivers/iio/proxim=
ity/vl53l1x-i2c.c
> > > new file mode 100644
> > > index 000000000000..085bff04f5d9
> > > --- /dev/null
> > > +++ b/drivers/iio/proximity/vl53l1x-i2c.c =20
> ...
> > > +
> > > +static int vl53l1x_probe(struct i2c_client *client)
> > > +{
> > > +     struct device *dev =3D &client->dev;
> > > +     struct vl53l1x_data *data;
> > > +     struct iio_dev *indio_dev;
> > > +     int ret;
> > > +
> > > +     if (!i2c_check_functionality(client->adapter,
> > > +                                  I2C_FUNC_SMBUS_READ_I2C_BLOCK |
> > > +                                  I2C_FUNC_SMBUS_BYTE_DATA)) =20
> > Sashiko had an interesting comment on this...
> > https://sashiko.dev/#/patchset/20260325063254.18062-1-email%40sirat.me
> > (note in general be careful with this tools feedback, it has a signific=
ant
> > false positive rate!)
> >
> > "Does this check needlessly reject pure I2C adapters?
> > The driver configures regmap with reg_bits =3D 16, which forces regmap =
to use
> > raw I2C transfers requiring I2C_FUNC_I2C. Checking for SMBUS_READ_I2C_B=
LOCK
> > might prevent the driver from loading on pure I2C adapters that can per=
fectly
> > support the device via regmap."
> >
> > By by reading the comment is actually wrong, however... It did made me =
look.
> > With regbits =3D=3D 16 & valbits =3D=3D 8
> > The regmap code checks for I2C_FUNC_SMBUS_I2C_BLOCK
> > (and if not present fails).
> >
> > So the I2C_FUNC_SMBUS_BYTE_DATA seems unused and
> > a broader check on both read and write versions of I2C_BLOCK seems
> > appropriate.
> >
> > However, not a lot of point in checking it at all given regmap does
> > so for us. So I'd drop this check.
> >
> > If anyone is bored, we should probably take a look to see if there
> > are other redundant (or wrong) calls for this.
> >
> > There is another point about trigger references that might be
> > correct (but not unique to this driver so ignore it).  That warrants
> > some investigation - I'll take a look in near future.
> > =20
> I will drop the check altogether here then.
> ...
> > > +     /*
> > > +      * XSHUT held low puts the chip in hardware standby. All regist=
er
> > > +      * state is lost on de-assert so this is functionally a reset.
> > > +      */
> > > +     data->xshut_reset =3D devm_reset_control_get_optional_exclusive=
(dev, NULL); =20
> >
> > If you can switch to devm_regulator_get_enabled() this can I think be
> >         ret =3D devm_reset_control_get_optional_exclusive_deasserted()
> > removing the need to register the action to power off.
> >
> > If you do that remember we still need the sleep after this call.
> > =20
> So I will move the sleep after
> devm_reset_control_get_optional_exclusive_deasserted() then.
> >
> > =20
> Thanks for the detailed review, Jonathan!
>=20
> A quick question. Since these are some small  fixes, mostly removals,
> and the patch has seen quite some revisions, does the 1 week wait rule
> still apply here? I am still getting used to this mailing workflow
> coming from the PR workflow of Github and it will help me in the
> future.

Find to send now. Particularly given my recent email saying
cut off for this cycle is lunch time tomorrow (due to my travel).

If not for the dt-binding which is a little more complex change, I might
otherwise have just taken this version and tweaked it whilst applying.

Thanks

Jonathan



>=20
> Thanks
> Sirat

