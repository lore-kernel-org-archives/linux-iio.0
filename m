Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:36276 "EHLO pmeerw.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753016AbcILFcd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 12 Sep 2016 01:32:33 -0400
Date: Mon, 12 Sep 2016 07:32:31 +0200 (CEST)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Hans de Goede <hdegoede@redhat.com>
cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: accel: Add driver for the mCube MC3230 3-axis
 accelerometer
In-Reply-To: <95a718cc-24c0-dfe9-6745-e3d933ba384b@redhat.com>
Message-ID: <alpine.DEB.2.02.1609112319380.18800@pmeerw.net>
References: <20160911162907.22449-1-hdegoede@redhat.com> <alpine.DEB.2.02.1609111942500.28464@pmeerw.net> <95a718cc-24c0-dfe9-6745-e3d933ba384b@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> > > +static const struct iio_chan_spec mc3230_channels[] = {
> > > +	MC3230_CHANNEL(MC3230_REG_XOUT, X),
> > > +	MC3230_CHANNEL(MC3230_REG_YOUT, Y),
> > > +	MC3230_CHANNEL(MC3230_REG_ZOUT, Z),
> > > +};
> > > +
> > > +struct mc3230_data {
> > > +	struct i2c_client *client;
> > > +};

probably don't need mc3230_data (or the client pointer within), not worth 
changing as likely stuff will be added in the future

> > > +static int mc3230_set_opcon(struct mc3230_data *data, int opcon)
> > > +{
> > > +	int ret;
> > > +	struct i2c_client *client = data->client;
> > > +
> > 
> > guess we want locking here
> 
> This register only gets touched by this function, and this
> function only gets called:
> 
> -pre iio_device_register
> -post iio_device_unregister
> -on suspend/resume

> So I do not see what it could race with.

I didn't check where set_opcon() is actually called, seems safe

I think there is a theoretic race in _remove() as _unregister() retval is 
not checked, no need to change

p.

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
