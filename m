Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726003AbeIBNdL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 2 Sep 2018 09:33:11 -0400
Date: Sun, 2 Sep 2018 10:18:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Afonso Bordado <afonsobordado@az8.co>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/4] iio: gyro: add support for fxas21002c
Message-ID: <20180902101800.4165005f@archlinux>
In-Reply-To: <d6c71f8699a0ee8eb09417381e301246b864e69e.camel@az8.co>
References: <20180825211910.22929-1-afonsobordado@az8.co>
        <20180827180805.7d4b9f4e@archlinux>
        <d6c71f8699a0ee8eb09417381e301246b864e69e.camel@az8.co>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 29 Aug 2018 07:43:48 +0100
Afonso Bordado <afonsobordado@az8.co> wrote:

> On Mon, 2018-08-27 at 18:08 +0100, Jonathan Cameron wrote:
> > On Sat, 25 Aug 2018 22:19:07 +0100
> > Afonso Bordado <afonsobordado@az8.co> wrote:
> >   
> > > FXAS21002C is a 3 axis gyroscope with integrated temperature sensor
> > > 
> > > Signed-off-by: Afonso Bordado <afonsobordado@az8.co>  
> > 
> > Hi,
> > 
> > Driver is pretty clean so only a few minor comments inline.
> > If we were late in a cycle I'd probably just have taken it and fixed
> > up
> > but as we have lots of time and I'm inherently lazy I'll let you do a
> > v2 :)
> > 
> > Good job, thanks!
> > 
> > Jonathan  
> 
> Great!
> 
> 
> > > +
> > > +static const struct regmap_access_table fxas21002c_volatile_table
> > > = {
> > > +	.yes_ranges = fxas21002c_volatile_ranges,
> > > +	.n_yes_ranges = ARRAY_SIZE(fxas21002c_volatile_ranges),
> > > +};
> > > +
> > > +const struct regmap_config fxas21002c_regmap_config = {
> > > +	.reg_bits = 8,
> > > +	.val_bits = 8,
> > > +
> > > +	.max_register = FXAS21002C_REG_CTRL_REG3,
> > > +	// We don't specify a .rd_table because everything is readable  
> > 
> > /* ... */
> > 
> > Please run checkpatch as IIRC it complains about this.  
> 
> I've replaced all instances of C99 comments with ANSI comments.
> However, has Joe Perches mentioned. Checkpatch did not warn me about
> this.
> 
Yup, thanks to Joe for clarifying this I had missed the change.
> 
> > > +
> > > +static int fxas21002c_remove(struct i2c_client *client)
> > > +{
> > > +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> > > +	struct fxas21002c_data *data = iio_priv(indio_dev);
> > > +
> > > +	iio_device_unregister(indio_dev);
> > > +
> > > +	fxas21002c_set_operating_mode(data, FXAS21002C_OM_STANDBY);  
> > 
> > You could have used the devm_add_action to allow the managed cleanup
> > to handle
> > this and hence gotten rid of the remove function.
> > 
> > (minor suggestion and somewhat a matter of personal taste).  
> 
> I didn't know this existed! Changed in v2.

Nor me until someone used it in a driver a few months back ;)
One of the advantages of doing a lot of review is that you get to see
any new stuff other people use.

Jonathan
