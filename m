Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727096AbeJUWXe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Oct 2018 18:23:34 -0400
Date: Sun, 21 Oct 2018 15:08:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Song Qiang <songqiang1304521@gmail.com>
Cc: Himanshu Jha <himanshujha199640@gmail.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com, preid@electromag.com.au,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] iio: magnetometer: Add driver support for PNI
 RM3100
Message-ID: <20181021150857.4f9c2244@archlinux>
In-Reply-To: <ce65b203-2a44-08e4-bdd0-f3c8df48e2f1@gmail.com>
References: <20181002143812.3661-1-songqiang1304521@gmail.com>
        <20181012073536.20339-1-songqiang1304521@gmail.com>
        <20181012073536.20339-4-songqiang1304521@gmail.com>
        <436097c6-b32b-42e4-e704-a15280e13cb0@gmail.com>
        <20181012125316.GA6480@himanshu-Vostro-3559>
        <ce65b203-2a44-08e4-bdd0-f3c8df48e2f1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 17 Oct 2018 16:00:02 +0800
Song Qiang <songqiang1304521@gmail.com> wrote:

> On 2018/10/12 =E4=B8=8B=E5=8D=888:53, Himanshu Jha wrote:
> > Hi Qiang,
> >
> > On Fri, Oct 12, 2018 at 04:36:01PM +0800, Song Qiang wrote: =20
> >>
> >> On 2018=E5=B9=B410=E6=9C=8812=E6=97=A5 15:35, Song Qiang wrote: =20
> >>> PNI RM3100 is a high resolution, large signal immunity magnetometer,
> >>> composed of 3 single sensors and a processing chip with a MagI2C
> >>> interface.
> >>> =20
> >> ... =20
> >>> +static irqreturn_t rm3100_trigger_handler(int irq, void *p)
> >>> +{
> >>> +	struct iio_poll_func *pf =3D p;
> >>> +	struct iio_dev *indio_dev =3D pf->indio_dev;
> >>> +	unsigned long scan_mask =3D *indio_dev->active_scan_mask;
> >>> +	unsigned int mask_len =3D indio_dev->masklength;
> >>> +	struct rm3100_data *data =3D iio_priv(indio_dev);
> >>> +	struct regmap *regmap =3D data->regmap;
> >>> +	int ret, i, bit;
> >>> +
> >>> +	mutex_lock(&data->lock);
> >>> +	switch (scan_mask) {
> >>> +	case BIT(0) | BIT(1) | BIT(2):
> >>> +		ret =3D regmap_bulk_read(regmap, RM3100_REG_MX2, data->buffer, 9);
> >>> +		mutex_unlock(&data->lock);
> >>> +		if (ret < 0)
> >>> +			goto done;
> >>> +	break;
> >>> +	case BIT(0) | BIT(1):
> >>> +		ret =3D regmap_bulk_read(regmap, RM3100_REG_MX2, data->buffer, 6);
> >>> +		mutex_unlock(&data->lock);
> >>> +		if (ret < 0)
> >>> +			goto done;
> >>> +	break;
> >>> +	case BIT(1) | BIT(2):
> >>> +		ret =3D regmap_bulk_read(regmap, RM3100_REG_MY2, data->buffer, 6);
> >>> +		mutex_unlock(&data->lock);
> >>> +		if (ret < 0)
> >>> +			goto done;
> >>> +	break; =20
> >> Hi Jonathan,
> >>
> >> I just noticed that these three breaks are not proper aligned. =20
> > Please send the new version of a patch as a *new* thread and don't
> > use `--in-reply-to` flag(if you're using) to chain into older versions
> > as whole thread of older discussion comes up and is often not required.
> >
> > The changelog gives enough info of what's new in the revised series.
> >
> > =20
> Hi Himanshu,
>=20
>=20
> Thanks for your advise.
>=20
> I did it because the following instruction tells me to, and I think it's=
=20
> also a very quick way of gathering
>=20
> all scattered messages. Both ways have their own advantages and=20
> disadvantages I think. :)
>=20
> <https://kernelnewbies.org/PatchPhilosophy> Section "Updating and=20
> resending patches".
That's a curious bit of advice.  There are certainly a lot of maintainers
who would not want that.  It never works with anything beyond trivial
and short patches (we have had patches going to v13 + and hundreds of
emails) - no email client handles that depth and complexity in
a coherent fashion. Replying to previous versions is one of those things
that makes sense until you hit the 'unusual cases' ;)

Oh well. I should probably propose a change to that Doc, but it make
take some time for me to get around to it.

Thanks,

Jonathan

>=20
>=20
> yours,
>=20
> Song Qiang
>=20
