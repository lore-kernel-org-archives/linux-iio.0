Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:59481 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751290AbdKCSqI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 3 Nov 2017 14:46:08 -0400
Message-ID: <1509734767.7135.67.camel@linux.intel.com>
Subject: Re: [PATCH v1] iio: magnetometer: ak8975: Remove wrong ACPI ID
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Date: Fri, 03 Nov 2017 11:46:07 -0700
In-Reply-To: <1509732895.10233.209.camel@linux.intel.com>
References: <20171103175640.33403-1-andriy.shevchenko@linux.intel.com>
         <1509732504.10233.205.camel@linux.intel.com>
         <1509732895.10233.209.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 2017-11-03 at 20:14 +0200, Andy Shevchenko wrote:
> On Fri, 2017-11-03 at 20:08 +0200, Andy Shevchenko wrote:
> > On Fri, 2017-11-03 at 19:56 +0200, Andy Shevchenko wrote:
> > > The ID is added to proper sensor by the commit 6ed5ac50a3e0
> > > ("iio: imu: inv_mpu6050: ACPI enumeration").
> > > 
> > > Remove it from wrong place, otherwise user will get:
> > > 
> > >  ak8975 i2c-INVN6500:00: mounting matrix not found: using
> > > identity...
> > >  ak8975 i2c-INVN6500:00: Unexpected device
> > > 
> > 
> > After applying I have got
> > 
> >  inv-mpu6050-i2c i2c-INVN6500:00: mounting matrix not found: using
> > identity...
> > 
> > ...
> > 
> >  i2c i2c-4: Added multiplexed i2c bus 14
> >  ak8975 14-000c: mounting matrix not found: using identity...
> > 
> > 
> > Nevertheless, I didn't try before with both drivers enabled. It
> > might
> > be
> > that my fix is not needed.
> > 
> > Shrinivas, can you comment on this?
> 
> DSDT looks promising:
> 
> Device (SENS) {
>     Name (_HID, "INVN6500" /* InvenSense MPU-6500 Six Axis Gyroscope
> and
> Accelerometer */)
> ...
> 
>     Name (CNF0, Package (0x04) {        
>         Package (0x04) { "MPU6500", ... },   
>         Package (0x04) { "MPU6500", ... },
>         Package (0x04) { "AK8963", ... },
> 
> Thus it is properly enumerated IIUC.
> 
> I think the patch at the end is correct.
The AK8963 is using INVN6500. The reason is that this INVN 6500 has
another master mode where a secondary sensor can be connected to it as
an i2c slave.
So Windows config uses this mode and hence added in the same package.

But Linux INVN driver is not capable of this master mode. We use
something called "bypass" mode. In this the second sensor will also be
directly connected to host i2c. We have another driver handling this
sensor (ak8975), so we have to add this id.

Thanks,
Srinivas 

> 
> > 
> > 
> > > Fixes: 6ed5ac50a3e0 ("iio: imu: inv_mpu6050: ACPI enumeration").
> > > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com
> > > >
> > > ---
> > >  drivers/iio/magnetometer/ak8975.c | 1 -
> > >  1 file changed, 1 deletion(-)
> > > 
> > > diff --git a/drivers/iio/magnetometer/ak8975.c
> > > b/drivers/iio/magnetometer/ak8975.c
> > > index 42a827a66512..f29a00729fa0 100644
> > > --- a/drivers/iio/magnetometer/ak8975.c
> > > +++ b/drivers/iio/magnetometer/ak8975.c
> > > @@ -787,7 +787,6 @@ static const struct iio_info ak8975_info = {
> > >  static const struct acpi_device_id ak_acpi_match[] = {
> > >  	{"AK8975", AK8975},
> > >  	{"AK8963", AK8963},
> > > -	{"INVN6500", AK8963},
> > >  	{"AK009911", AK09911},
> > >  	{"AK09911", AK09911},
> > >  	{"AK09912", AK09912},
> > 
> > 
> 
> 
