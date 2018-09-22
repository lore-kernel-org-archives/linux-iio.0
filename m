Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728187AbeIVViV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Sep 2018 17:38:21 -0400
Date: Sat, 22 Sep 2018 16:44:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Song Qiang <songqiang1304521@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com,
        andriy.shevchenko@linux.intel.com, matt.ranostay@konsulko.com,
        tglx@linutronix.de, ak@it-klinger.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/2] iio: proximity: Add driver support for ST's
 VL53L0X ToF ranging sensor.
Message-ID: <20180922164415.67a55cb2@archlinux>
In-Reply-To: <20180922152621.GA953@Eros>
References: <20180918082422.13050-1-songqiang1304521@gmail.com>
        <20180922154658.752f2fbf@archlinux>
        <20180922152621.GA953@Eros>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 22 Sep 2018 23:28:04 +0800
Song Qiang <songqiang1304521@gmail.com> wrote:

> On Sat, Sep 22, 2018 at 03:46:58PM +0100, Jonathan Cameron wrote:
> > On Tue, 18 Sep 2018 16:24:21 +0800
> > Song Qiang <songqiang1304521@gmail.com> wrote:
> >   
> > > This driver was originally written by ST in 2016 as a misc input device
> > > driver, and hasn't been maintained for a long time. I grabbed some code
> > > from it's API and reformed it into an iio proximity device driver.
> > > This version of driver uses i2c bus to talk to the sensor and
> > > polling for measuring completes, so no irq line is needed.
> > > It can be tested with reading from
> > > /sys/bus/iio/devices/iio:deviceX/in_distance_input
> > > 
> > > Signed-off-by: Song Qiang <songqiang1304521@gmail.com>  
> > There are a few bits and bobs in here, but as they are all minor and
> > one at least was me giving you wrong advise, I've fixed it up.
> > 
> > Please check I haven't made a mess of it! 
> > 
> > Applied with changes to the togreg branch of iio.git and pushed out
> > as testing (where it should be visible now) for the autobuilders to
> > play with it.
> > 
> > Thanks,
> > 
> > Jonathan  
> > > ---  
> 
> > > +	indio_dev->name = "vl53l0x";
> > > +	indio_dev->info = &vl53l0x_info;
> > > +	indio_dev->channels = vl53l0x_channels;
> > > +	indio_dev->num_channels = ARRAY_SIZE(vl53l0x_channels);
> > > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > > +
> > > +	return devm_iio_device_register(&client->dev, indio_dev);
> > > +}
> > > +
> > > +static const struct of_device_id st_vl53l0x_dt_match[] = {
> > > +	{ .compatible = "st,vl53l0x-i2c", },  
> > 
> > Ah, this suffers from the same thing that was picked up in a driver
> > you sent later in the week.  No need to have -i2c in the compatible
> > as this is clear from the bus type.
> > 
> > (I might just fix this up).
> >   
> 
> Hi Jonathan,
> 
> Sorry for the newbie mistakes you and Himanshu pointed out, I'm just
> writing them down on my little checklist!
> I just checked the code, found that this compatible string was not
> getting corrected in the DT binding doc file, sorry that you have
> to help correct my mistakes, thanks a lot!
Fixed up (and this was my mistake - we all make them - that's what review
is for!)

Thanks,

Jonathan
> 
> yours,
> Song Qiang
> 
> > > +	{ }
> > > +};
> > > +MODULE_DEVICE_TABLE(of, st_vl53l0x_dt_match);
> > > +
> > > +static struct i2c_driver vl53l0x_driver = {
> > > +	.driver = {
> > > +		.name = "vl53l0x-i2c",
> > > +		.of_match_table = st_vl53l0x_dt_match,
> > > +	},
> > > +	.probe_new = vl53l0x_probe,
> > > +};
> > > +module_i2c_driver(vl53l0x_driver);
> > > +
> > > +MODULE_AUTHOR("Song Qiang <songqiang1304521@gmail.com>");
> > > +MODULE_DESCRIPTION("ST vl53l0x ToF ranging sensor driver");
> > > +MODULE_LICENSE("GPL v2");  
> >   
