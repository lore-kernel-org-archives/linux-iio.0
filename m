Return-Path: <Milo.Kim@ti.com>
From: "Kim, Milo" <Milo.Kim@ti.com>
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        "jic23@cam.ac.uk" <jic23@cam.ac.uk>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
Subject: RE: [PATCH 1/3] iio: add iio_read_channel_offset() consumer api
Date: Thu, 16 Aug 2012 07:49:13 +0000
Message-ID: <A874F61F95741C4A9BA573A70FE3998F41EEFDA0@DQHE02.ent.ti.com>
References: <A874F61F95741C4A9BA573A70FE3998F41EEFD6E@DQHE02.ent.ti.com>
 <alpine.DEB.2.01.1208160940380.3550@pmeerw.net>
In-Reply-To: <alpine.DEB.2.01.1208160940380.3550@pmeerw.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

> >  int iio_read_channel_scale(struct iio_channel *chan, int *val,
> >  			   int *val2);
> >
> > +/**
> > + * iio_read_channel_offset() - read offset from a given channel
> > + * @channel:		The channel being queried.
>=20
> the parameter is 'chan', not 'channel'
>=20

Oops, this is copy-and-paste disaster.
The description of iio_read_channel_scale() also needs correction.
Thanks for catching this !

After getting other feedbacks, separate patch will be submitted.

Best Regards,
Milo
