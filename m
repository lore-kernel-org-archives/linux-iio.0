Return-Path: <SRS0=KI7b=IW=huawei.com=jonathan.cameron@kernel.org>
Date: Mon, 4 Jun 2018 13:38:27 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Sean =?ISO-8859-1?Q?Nyekj=E6r?= <sean.nyekjaer@prevas.dk>
CC: Jonathan Cameron <jic23@kernel.org>, <pmeerw@pmeerw.net>,
	<linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: ti-ads8688: use the auto sequence feature
Message-ID: <20180604133827.000073fa@huawei.com>
In-Reply-To: <307d7ecc-b45f-7841-32f7-694da69fe37d@prevas.dk>
References: <20180530211821.8496-1-sean.nyekjaer@prevas.dk>
	<20180603162835.59676a01@archlinux>
	<307d7ecc-b45f-7841-32f7-694da69fe37d@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
List-ID: <linux-iio@vger.kernel.org>

On Mon, 4 Jun 2018 07:21:13 +0200
Sean Nyekj=E6r <sean.nyekjaer@prevas.dk> wrote:

> On 2018-06-03 17:28, Jonathan Cameron wrote:
> > On Wed, 30 May 2018 23:18:21 +0200
> > Sean Nyekjaer <sean.nyekjaer@prevas.dk> wrote:
> >  =20
> >> The TI ADS8688 have a auto sequence feature that allows
> >> to continuesly reading new values from the chosen channels.
> >> Lets enable it and we will be able to sample at the double speed
> >> vs the old implementation
> >>
> >> Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk> =20
> >=20
> > hmm. Technically it's an ABI change as someone may be relying on the
> > ability to do sysfs reads whilst we are also using the chardev interfac=
e.
> > However, I doubt anyone is so lest see if anyone notices ;)
> >=20
> > One comment inline. Otherwise looks fine to me.
> >=20
> > With care, we could gotten the speed up without using autosequencing
> > but that doesn't really matter as that isn't what we were doing previou=
sly.
> >=20
> > Thanks,
> >=20
> > Jonathan
> >  =20
> >> --- =20
> Oh i din't know that we must always be able to read from sysfs, with=20
> this adc the auto sequencing will stop if a manual read is done :-(
We don't have to be able to always read from sysfs in general.  The potenti=
al
issue here is that we may have userspace code in the wild using this device
that will expect that to work (because it does before this patch).

Hence we are looking at potential usespace breakage.  However, rule 1 of
changing userspace visible kernel features - if no one notices it isn't
a regression ;)  So here we'll just go for it.  If anyone complains
we may need to do something 'clever' to fake sampling on demand.

> Maybe I could change it so the auto trigger mode will still be calling=20
> the channels manually? That way we will have the same amount of=20
> channels, but greater freedom to be able to do sysfs reads...

The fun would be dealing with channels that aren't enabled.  Either we slow
the device down by always sampling all of the channels or we have it fail
on any that aren't enabled.   This has always been an issue with trying
to support the two modes and is why lots of drivers don't do so (but typica=
lly
they never did so there is no chance of a regression!)


>=20
> >> +static int ads8688_update_scan_mode(struct iio_dev *indio_dev,
> >> +	const unsigned long *active_scan_mask)
> >> +{
> >> +	int scan_count;
> >> +
> >> +	scan_count =3D bitmap_weight(active_scan_mask, indio_dev->masklength=
); =20
> >=20
> > What is scan_count for? =20
> Woops, just some cp for debugging :-) Will remove it

Cool

Jonathan
>=20
> /Sean
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
