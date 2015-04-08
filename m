Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:32294 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754156AbbDHPrp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 8 Apr 2015 11:47:45 -0400
From: "Tirdea, Irina" <irina.tirdea@intel.com>
To: Hartmut Knaack <knaack.h@gmx.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Baluta, Daniel" <daniel.baluta@intel.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"Tirdea, Irina" <irina.tirdea@intel.com>
Subject: RE: [PATCH v3 3/3] iio: add driver for Freescale MMA9553
Date: Wed, 8 Apr 2015 15:47:40 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F19A4E15F@irsmsx105.ger.corp.intel.com>
References: <1422384114-23392-1-git-send-email-irina.tirdea@intel.com>
 <1422384114-23392-4-git-send-email-irina.tirdea@intel.com>
 <5520710D.7000003@gmx.de>
 <1F3AC3675D538145B1661F571FE1805F19A4D5C1@irsmsx105.ger.corp.intel.com>
In-Reply-To: <1F3AC3675D538145B1661F571FE1805F19A4D5C1@irsmsx105.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



> -----Original Message-----
> From: linux-iio-owner@vger.kernel.org [mailto:linux-iio-owner@vger.kernel.org] On Behalf Of Tirdea, Irina
> Sent: 06 April, 2015 17:33
> To: Hartmut Knaack; Jonathan Cameron; linux-iio@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; Baluta, Daniel; Lars-Peter Clausen; Peter Meerwald
> Subject: RE: [PATCH v3 3/3] iio: add driver for Freescale MMA9553
> 
> 
> 
> > -----Original Message-----
> > From: Hartmut Knaack [mailto:knaack.h@gmx.de]
> > Sent: 05 April, 2015 2:18
> > To: Tirdea, Irina; Jonathan Cameron; linux-iio@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org; Baluta, Daniel; Lars-Peter Clausen; Peter Meerwald
> > Subject: Re: [PATCH v3 3/3] iio: add driver for Freescale MMA9553
> >
> > Irina Tirdea schrieb am 27.01.2015 um 19:41:
> > > Add support for Freescale MMA9553L Intelligent Pedometer Platform.
> > >
> > > The following functionalities are supported:
> > >  - step counter (counts the number of steps using a HW register)
> > >  - step detector (generates an iio event at every step the user takes)
> > >  - activity recognition (rest, walking, jogging, running)
> > >  - speed
> > >  - calories
> > >  - distance
> > >
<snip>
> > > +static int mma9553_read_activity_stepcnt(struct mma9553_data *data,
> > > +					 u8 *activity, u16 *stepcnt)
> > > +{
> > > +	u32 status_stepcnt;
> > > +	u16 status;
> > > +	int ret;
> > > +
> > > +	ret = mma9551_read_status_words(data->client, MMA9551_APPID_PEDOMETER,
> > > +					MMA9553_REG_STATUS, sizeof(u32),
> > > +					(u16 *) &status_stepcnt);
> > > +	if (ret < 0) {
> > > +		dev_err(&data->client->dev,
> > > +			"error reading status and stepcnt\n");
> > > +		return ret;
> > > +	}
> > > +
> >
> > I think this could be done a bit simpler by using u16 buf[2] instead of
> > status_stepcnt (making status obsolete). That's what it would boil down
> > to:
> > 	*activity = mma9553_get_bits(buf[0], MMA9553_MASK_STATUS_ACTIVITY);
> > 	*stepcnt = buf[1];
> >
> That does look more simple. Will change it accordingly.
This does not only look more simple, it actually fixes an endianness bug on big endian hosts.
Thanks for the suggestion!

Irina
<snip>
