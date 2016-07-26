Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:55474 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754393AbcGZQE5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 26 Jul 2016 12:04:57 -0400
Date: Tue, 26 Jul 2016 09:04:10 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>,
	linux-kernel@vger.kernel.org, jdelvare@suse.com, jic23@kernel.org,
	knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	maxime.ripard@free-electrons.com, wens@csie.org,
	lee.jones@linaro.org, linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	thomas.petazzoni@free-electrons.com,
	antoine.tenart@free-electrons.com
Subject: Re: [PATCH v3 1/4] hwmon: iio_hwmon: delay probing with late_initcall
Message-ID: <20160726160410.GE30628@roeck-us.net>
References: <1469519027-11387-1-git-send-email-quentin.schulz@free-electrons.com>
 <5277864.qlyRKbC1Zy@ws-stein>
 <ed5c1761-bdc7-df9c-96c8-998e83c49c4c@free-electrons.com>
 <2324970.FJcTUYNoO2@ws-stein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2324970.FJcTUYNoO2@ws-stein>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Jul 26, 2016 at 12:00:33PM +0200, Alexander Stein wrote:
> On Tuesday 26 July 2016 11:33:59, Quentin Schulz wrote:
> > On 26/07/2016 11:05, Alexander Stein wrote:
> > > On Tuesday 26 July 2016 10:24:48, Quentin Schulz wrote:
> > >> On 26/07/2016 10:21, Alexander Stein wrote:
> > >>> On Tuesday 26 July 2016 09:43:44, Quentin Schulz wrote:
> > >>>> iio_channel_get_all returns -ENODEV when it cannot find either phandles
> > >>>> and
> > >>>> properties in the Device Tree or channels whose consumer_dev_name
> > >>>> matches
> > >>>> iio_hwmon in iio_map_list. The iio_map_list is filled in by iio drivers
> > >>>> which might be probed after iio_hwmon.
> > >>> 
> > >>> Would it work if iio_channel_get_all returning ENODEV is used for
> > >>> returning
> > >>> EPROBE_DEFER in iio_channel_get_all? Using late initcalls for
> > >>> driver/device
> > >>> dependencies seems not right for me at this place.
> > >> 
> > >> Then what if the iio_channel_get_all is called outside of the probe of a
> > >> driver? We'll have to change the error code, things we are apparently
> > >> trying to avoid (see v2 patches' discussions).
> > > 
> > > Maybe I didn't express my idea enough. I don't want to change the behavior
> > > of iio_channel_get_all at all. Just the result evaluation of
> > > iio_channel_get_all in iio_hwmon_probe. I have something link the patch
> > > below in mind.
> > > 
> > > Best regards,
> > > Alexander
> > > ---
> > > diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
> > > index b550ba5..e32d150 100644
> > > --- a/drivers/hwmon/iio_hwmon.c
> > > +++ b/drivers/hwmon/iio_hwmon.c
> > > @@ -73,8 +73,12 @@ static int iio_hwmon_probe(struct platform_device
> > > *pdev)
> > > 
> > >                 name = dev->of_node->name;
> > >         
> > >         channels = iio_channel_get_all(dev);
> > > 
> > > -       if (IS_ERR(channels))
> > > -               return PTR_ERR(channels);
> > > +       if (IS_ERR(channels)) {
> > > +               if (PTR_ERR(channels) == -ENODEV)
> > > +                       return -EPROBE_DEFER;
> > > +               else
> > > +                       return PTR_ERR(channels);
> > > +       }
> > > 
> > >         st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
> > >         if (st == NULL) {
> > 
> > Indeed, I misunderstood what you told me.
> > 
> > Actually, the patch you proposed is part of my v1
> > (https://lkml.org/lkml/2016/6/28/203) and v2
> > (https://lkml.org/lkml/2016/7/15/215).
> > Jonathan and Guenter didn't really like the idea of changing the -ENODEV
> > in -EPROBE_DEFER.
> 
> Thanks for the links.
> 
> > What I thought you were proposing was to change the -ENODEV return code
> > inside iio_channel_get_all. This cannot be an option since the function
> > might be called outside of a probe (it is not yet, but might be in the
> > future?).
> 
> AFAICS this is a helper function not knowing about device probing itself. And 
> it should stay at that.
> 
> > Of what I understood, two possibilities are then possible (proposed
> > either by Guenter or Jonathan): either rework the iio framework to
> > register iio map array earlier or to use late_initcall instead of init
> > for the driver consuming the iio channels.
> 
> Interestingly using this problem would not arise due to module dependencies. 
> But using late_initcall would mean this needs to be done on any driver using 
> iio channels? I would rather keep those consumers simple.
> 
Me too, but that would imply a solution in iio. The change you propose above
isn't exactly simple either, and would also be needed in each consumer driver.

Just for the record, I dislike the late_initcall solution as well, but I prefer
it over blindly converting ENODEV to EPROBE_DEFER.

Guenter
