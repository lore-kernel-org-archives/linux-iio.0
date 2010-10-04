Return-Path: <shubhrajyoti@ti.com>
From: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Drivers
	<Drivers@analog.com>, "jic23@cam.ac.uk" <jic23@cam.ac.uk>,
        "greg@kroah.com"
	<greg@kroah.com>
Date: Mon, 4 Oct 2010 15:12:56 +0530
Subject: RE: [PATCH 1/2] staging: iio: adc: Enable driver support for ad799x
 AD converters
Message-ID: <0680EC522D0CC943BC586913CF3768C003FF3B29FF@dbde02.ent.ti.com>
References: <1285944112-25769-1-git-send-email-michael.hennerich@analog.com>
 <0680EC522D0CC943BC586913CF3768C003FF3B288D@dbde02.ent.ti.com>
 <544AC56F16B56944AEC3BD4E3D5917712F0DB8A7A6@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D5917712F0DB8A7A6@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

> > +
> > +     return 0;
> > +error_cleanup_ring:
> > +     ad799x_ring_cleanup(st->indio_dev);
> > +error_free_device:
> > +     if (!regdone)
>
> Where is regdone populated if it is always 1 we may remove the check.

Regdone is only set in case iio_device_register() succeeds.


> > +             iio_free_device(st->indio_dev);

Yes that's fine.
I missed it.
