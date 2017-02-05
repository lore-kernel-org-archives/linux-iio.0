Return-Path: <SRS0=Ml5y=ZS=gmail.com=tduszyns@kernel.org>
Date: Sun, 5 Feb 2017 17:06:47 +0100
From: Tomasz Duszynski <tduszyns@gmail.com>
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Tomasz Duszynski <tduszyns@gmail.com>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
	lars@metafoo.de
Subject: Re: [PATCH 1/4] iio: chemical: add particle number concentration
 channel type
Message-ID: <20170205160646.GA2191@Arch.lan>
References: <20170205150100.10685-1-tduszyns@gmail.com>
 <alpine.DEB.2.02.1702051620230.21159@pmeerw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1702051620230.21159@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Feb 05, 2017 at 04:21:27PM +0100, Peter Meerwald-Stadler wrote:
>
> > This patch adds channel type for expressing particle number
> > concentration.
>
> numberconcentration sound a bit strange to be, more like a number
> theoretic concept
>
> how about particlecontentration? or numberparticles?
>
Agree it may sound a bit strange but in fact it is a formal physical quantity
with SI unit. Perhaps I can leave it as is to stay consistent with
science world?
> > Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-iio | 7 +++++++
> >  drivers/iio/industrialio-core.c         | 1 +
> >  include/uapi/linux/iio/types.h          | 1 +
> >  3 files changed, 9 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> > index 530809ccfacf..481771e585ee 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > @@ -1608,3 +1608,10 @@ Description:
> >  		provides an absolute positional reference (e.g. a pulse once per
> >  		revolution) which may be used to home positional systems as
> >  		required.
> > +
> > +What:		/sys/bus/iio/devices/iio:deviceX/in_numberconcentration_input
> > +KernelVersion: 	4.12
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Reading of particulates number in a volume of a mixture.
> > +		Unit is in 1/m3.
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > index d18ded45bedd..451e3bb8d623 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -85,6 +85,7 @@ static const char * const iio_chan_type_name_spec[] = {
> >  	[IIO_COUNT] = "count",
> >  	[IIO_INDEX] = "index",
> >  	[IIO_GRAVITY]  = "gravity",
> > +	[IIO_NUMBERCONCENTRATION] = "numberconcentration",
> >  };
> >
> >  static const char * const iio_modifier_names[] = {
> > diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> > index ffafd6c25a48..52696e251c4d 100644
> > --- a/include/uapi/linux/iio/types.h
> > +++ b/include/uapi/linux/iio/types.h
> > @@ -43,6 +43,7 @@ enum iio_chan_type {
> >  	IIO_COUNT,
> >  	IIO_INDEX,
> >  	IIO_GRAVITY,
> > +	IIO_NUMBERCONCENTRATION,
> >  };
> >
> >  enum iio_modifier {
> >
>
> --
>
> Peter Meerwald-Stadler
> +43-664-2444418 (mobile)
