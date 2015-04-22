Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:55454 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932616AbbDVLhT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 22 Apr 2015 07:37:19 -0400
From: "Tirdea, Irina" <irina.tirdea@intel.com>
To: 'Jonathan Cameron' <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Hartmut Knaack" <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"Peter Meerwald" <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
Subject: RE: [PATCH 1/3] iio: core: Introduce IIO_CHAN_INFO_CALIBREPETITIONS
Date: Wed, 22 Apr 2015 11:33:46 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F19A5B355@irsmsx105.ger.corp.intel.com>
References: <1429267830-13681-1-git-send-email-irina.tirdea@intel.com>
 <1429267830-13681-2-git-send-email-irina.tirdea@intel.com>
 <55328A92.9020807@kernel.org>
In-Reply-To: <55328A92.9020807@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Jonathan Cameron [mailto:jic23@kernel.org]
> Sent: 18 April, 2015 19:47
> To: Tirdea, Irina; linux-iio@vger.kernel.org; devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; Hartmut Knaack; Lars-Peter Clausen; Peter Meerwald; Rob Herring; Pawel Moll; Mark Rutland; Ian
> Campbell; Kumar Gala
> Subject: Re: [PATCH 1/3] iio: core: Introduce IIO_CHAN_INFO_CALIBREPETITIONS
> 
> On 17/04/15 11:50, Irina Tirdea wrote:
> > Some magnetometers can perform a number of repetitions in HW
> > for each measurement to increase accuracy. One example is
> > Bosch BMC150:
> > http://ae-bst.resource.bosch.com/media/products/dokumente/bmc150/BST-BMC150-DS000-04.pdf.
> >
> > Introduce an interface to set the number of repetitions
> > for these devices.
> >
> > Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-iio | 10 ++++++++++
> >  drivers/iio/industrialio-core.c         |  1 +
> >  include/linux/iio/iio.h                 |  1 +
> >  3 files changed, 12 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> > index 866b4ec..74c1444 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > @@ -1375,3 +1375,13 @@ Description:
> >  		The emissivity ratio of the surface in the field of view of the
> >  		contactless temperature sensor.  Emissivity varies from 0 to 1,
> >  		with 1 being the emissivity of a black body.
> > +
> > +What:		/sys/bus/iio/devices/iio:deviceX/in_magn_x_calibrepetitions
> > +What:		/sys/bus/iio/devices/iio:deviceX/in_magn_y_calibrepetitions
> > +What:		/sys/bus/iio/devices/iio:deviceX/in_magn_z_calibrepetitions
> > +KernelVersion:	4.2
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Hardware applied number of repetitions for acquiring one
> > +		data point. The HW will do <type>[_name]_calibrepetitions
> > +		measurements and return the average value as output data.
> This is an interesting way of naming what is often referred to as oversampling.
> I'd like to get some other opinions on naming before we go with the ABI for this..
> 
> We do have one driver in staging exporting oversampling_ratio which is probably
> the same thing, but that ABI was never standardized so I have no problem with
> ignoring that one case.  A couple of other drivers provide oversampling control
> via platform data.   We must make sure we give a sensible default for this.
> 
I didn't know about the oversampling_ratio. I used "repetitions" because Bosch calls them so
in the datasheet.
However, I think oversampling_ratio is a better name since it suggests a
connection with sampling. I will change it to oversampling_ratio in v2 and then
wait for more opinions on this.

> There is also the interesting question of whether sampling_frequency applies
> before or after this...  I'd argue after, but again would like more opinions
> before we dictate that.  However, whatever we choose should definitely be
> documented here!
> 
The HW sees the sampling_frequency as the frequency the user sees, so it does not take into
account the oversampling_ratio: each value resulted after oversampling_ratio repetitions is
considered one sample for the sampling_frequency. However, I am not sure how other
devices handle this so more opinions on this would be useful.

Looking more into the oversampling ratio from BMC150, seems there are some
sampling limitations I missed the first time: when setting a certain value for x/y/z repetitions,
not all sampling rates are available.  I am going to fix this in v2 by not allowing invalid
sampling rates once a certain value for oversampling_ratio is set.

Thanks,
Irina

> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > index 7c98bc1..9e0da7f 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -129,6 +129,7 @@ static const char * const iio_chan_info_postfix[] = {
> >  	[IIO_CHAN_INFO_DEBOUNCE_COUNT] = "debounce_count",
> >  	[IIO_CHAN_INFO_DEBOUNCE_TIME] = "debounce_time",
> >  	[IIO_CHAN_INFO_CALIBEMISSIVITY] = "calibemissivity",
> > +	[IIO_CHAN_INFO_CALIBREPETITIONS] = "calibrepetitions",
> >  };
> >
> >  /**
> > diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> > index b1e46ae..07fbfb2 100644
> > --- a/include/linux/iio/iio.h
> > +++ b/include/linux/iio/iio.h
> > @@ -44,6 +44,7 @@ enum iio_chan_info_enum {
> >  	IIO_CHAN_INFO_DEBOUNCE_COUNT,
> >  	IIO_CHAN_INFO_DEBOUNCE_TIME,
> >  	IIO_CHAN_INFO_CALIBEMISSIVITY,
> > +	IIO_CHAN_INFO_CALIBREPETITIONS,
> >  };
> >
> >  enum iio_shared_by {
> >

