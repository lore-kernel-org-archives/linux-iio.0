Return-Path: <SRS0=QBqV=Q3=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F15C43381
	for <linux-iio@archiver.kernel.org>; Wed, 20 Feb 2019 17:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 763D321841
	for <linux-iio@archiver.kernel.org>; Wed, 20 Feb 2019 17:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550682443;
	bh=sKhWG9EkWR49ic96tEWiBYu83jwg/rSVB/a6wREgEu4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=yAwVDVvg9kqz5eiDnk3LAHQrk0s3y9D/dneSl2vh0+FL1zQoCzxkfjWTY5oELgf3d
	 hedXvS1CJSli4l27DH97QTVNar84LNC7MrmBsXgtuFaNpRqKQB1no/HLRgZOeTnSdE
	 PXwtNQzBEjP/4FgfHvDNOTS5vPph97geiRBaA9nc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbfBTRHX (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 20 Feb 2019 12:07:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:48296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbfBTRHW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 20 Feb 2019 12:07:22 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC87E2146E;
        Wed, 20 Feb 2019 17:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550682441;
        bh=sKhWG9EkWR49ic96tEWiBYu83jwg/rSVB/a6wREgEu4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FCHJZQ0VfGh3LywE44N4bWeYxbz7eLwFLtLxLHcQIJIl1uwMsFH/T5rKToixcZaiE
         36mgLeayZTiejj5XfIuuLy0k9NxThmb8vjjXKWhxV+TSD0G5eUPaiFHefGeMMFGD3c
         wTBXwqCELfqFfUxmW67M4FgA9DiYTy+1kcxVg9OQ=
Date:   Wed, 20 Feb 2019 17:07:16 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v1] iio: Allow to read mount matrix from ACPI
Message-ID: <20190220170716.08f65c28@archlinux>
In-Reply-To: <20190220164140.GC9224@smile.fi.intel.com>
References: <20190220152052.31901-1-andriy.shevchenko@linux.intel.com>
        <20190220160239.79f2566c@archlinux>
        <20190220164140.GC9224@smile.fi.intel.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 20 Feb 2019 18:41:40 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Wed, Feb 20, 2019 at 04:02:39PM +0000, Jonathan Cameron wrote:
> > On Wed, 20 Feb 2019 18:20:52 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >   
> > > Currently mount matrix is allowed in Device Tree, though there is
> > > no technical issue to extend it to support ACPI.
> > > 
> > > Convert the function to use device_property_read_string_array() and
> > > thus allow to read mount matrix from ACPI if available.
> > > 
> > > At the same time drop the "of" prefix from its name and
> > > convert current users.
> > > 
> > > No functional change intended.
> > > 
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>  
> > 
> > Hi Andy,
> > 
> > I sort of agree that there is no obvious reason to limit it to
> > DT. One corner that is unfortunate is that we have ACPI DSDT with
> > _OFT providing the same thing.  Neither is 'standard' as such.  
> 
> He-h, that _OFT should be parsed on per device basis. I'm tired of firmware
> writers that are (abusing / not using  in a clever way) ACPI features.

Agreed, it would be nice if they didn't make stuff up when ever they
felt like it.  Particularly tedious when the day job regularly involves
asking our firmware team to do it right rather than paper over it.
Guess there are advantages to working for a big company who do all
the parts ;)

> 
> > Also, could we have an example of what the DSDT would look like
> > to provide this for a device?  I'm too lazy to figure it out for
> > myself given you probably already know off the top of your head ;)  
> 
> Sure.
> 
> Since it's an array of strings it would be as simple as
> 
> 
> Name (_DSD, Package ()
> {
> 	ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> 	Package ()
> 	{
> 		Package () { "mount-matrix", Package() {
> 			"1", "0", "0",
> 			"0", "0.866", "0.5",
> 			"0", "-0.5", "0.866"
> 		} }
> 	}
> })
> 
> Should I send a version with extended commit message?
> 
> P.S. This is basically the example of any property that can be provided
>      via ACPI. Just add / replace name and value(s).

That would be great.  I hadn't realised there was a catch all UUID for this.
Why on earth is that in a random separate document rather than the ACPI
specification itself *sigh*.

Jonathan

> 
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> > > ---
> > >  drivers/iio/accel/kxsd9.c                  |  2 +-
> > >  drivers/iio/gyro/mpu3050-core.c            |  2 +-
> > >  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c |  2 +-
> > >  drivers/iio/industrialio-core.c            | 46 +++++++++-------------
> > >  drivers/iio/magnetometer/ak8974.c          |  2 +-
> > >  drivers/iio/magnetometer/ak8975.c          |  2 +-
> > >  include/linux/iio/iio.h                    |  4 +-
> > >  7 files changed, 25 insertions(+), 35 deletions(-)
> > > 
> > > diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
> > > index 0c0df4fce420..f73404ca715e 100644
> > > --- a/drivers/iio/accel/kxsd9.c
> > > +++ b/drivers/iio/accel/kxsd9.c
> > > @@ -420,7 +420,7 @@ int kxsd9_common_probe(struct device *dev,
> > >  	indio_dev->available_scan_masks = kxsd9_scan_masks;
> > >  
> > >  	/* Read the mounting matrix, if present */
> > > -	ret = of_iio_read_mount_matrix(dev,
> > > +	ret = iio_read_mount_matrix(dev,
> > >  				       "mount-matrix",
> > >  				       &st->orientation);
> > >  	if (ret)
> > > diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
> > > index 77fac81a3adc..0a7d0dde020e 100644
> > > --- a/drivers/iio/gyro/mpu3050-core.c
> > > +++ b/drivers/iio/gyro/mpu3050-core.c
> > > @@ -1149,7 +1149,7 @@ int mpu3050_common_probe(struct device *dev,
> > >  	mpu3050->divisor = 99;
> > >  
> > >  	/* Read the mounting matrix, if present */
> > > -	ret = of_iio_read_mount_matrix(dev, "mount-matrix",
> > > +	ret = iio_read_mount_matrix(dev, "mount-matrix",
> > >  				       &mpu3050->orientation);
> > >  	if (ret)
> > >  		return ret;
> > > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> > > index 1e428c196a82..e2c8e8ca324a 100644
> > > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> > > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> > > @@ -990,7 +990,7 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
> > >  
> > >  	pdata = dev_get_platdata(dev);
> > >  	if (!pdata) {
> > > -		result = of_iio_read_mount_matrix(dev, "mount-matrix",
> > > +		result = iio_read_mount_matrix(dev, "mount-matrix",
> > >  						  &st->orientation);
> > >  		if (result) {
> > >  			dev_err(dev, "Failed to retrieve mounting matrix %d\n",
> > > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > > index 4f5cd9f60870..3baede140d69 100644
> > > --- a/drivers/iio/industrialio-core.c
> > > +++ b/drivers/iio/industrialio-core.c
> > > @@ -19,6 +19,7 @@
> > >  #include <linux/device.h>
> > >  #include <linux/fs.h>
> > >  #include <linux/poll.h>
> > > +#include <linux/property.h>
> > >  #include <linux/sched.h>
> > >  #include <linux/wait.h>
> > >  #include <linux/cdev.h>
> > > @@ -525,8 +526,8 @@ ssize_t iio_show_mount_matrix(struct iio_dev *indio_dev, uintptr_t priv,
> > >  EXPORT_SYMBOL_GPL(iio_show_mount_matrix);
> > >  
> > >  /**
> > > - * of_iio_read_mount_matrix() - retrieve iio device mounting matrix from
> > > - *                              device-tree "mount-matrix" property
> > > + * iio_read_mount_matrix() - retrieve iio device mounting matrix from
> > > + *                           device "mount-matrix" property
> > >   * @dev:	device the mounting matrix property is assigned to
> > >   * @propname:	device specific mounting matrix property name
> > >   * @matrix:	where to store retrieved matrix
> > > @@ -536,40 +537,29 @@ EXPORT_SYMBOL_GPL(iio_show_mount_matrix);
> > >   *
> > >   * Return: 0 if success, or a negative error code on failure.
> > >   */
> > > -#ifdef CONFIG_OF
> > > -int of_iio_read_mount_matrix(const struct device *dev,
> > > -			     const char *propname,
> > > -			     struct iio_mount_matrix *matrix)
> > > +int iio_read_mount_matrix(struct device *dev, const char *propname,
> > > +			  struct iio_mount_matrix *matrix)
> > >  {
> > > -	if (dev->of_node) {
> > > -		int err = of_property_read_string_array(dev->of_node,
> > > -				propname, matrix->rotation,
> > > -				ARRAY_SIZE(iio_mount_idmatrix.rotation));
> > > +	size_t len = ARRAY_SIZE(iio_mount_idmatrix.rotation); 
> > > +	int err;
> > >  
> > > -		if (err == ARRAY_SIZE(iio_mount_idmatrix.rotation))
> > > -			return 0;
> > > +	err = device_property_read_string_array(dev, propname,
> > > +						matrix->rotation, len);
> > > +	if (err == len)
> > > +		return 0;
> > >  
> > > -		if (err >= 0)
> > > -			/* Invalid number of matrix entries. */
> > > -			return -EINVAL;
> > > +	if (err >= 0)
> > > +		/* Invalid number of matrix entries. */
> > > +		return -EINVAL;
> > >  
> > > -		if (err != -EINVAL)
> > > -			/* Invalid matrix declaration format. */
> > > -			return err;
> > > -	}
> > > +	if (err != -EINVAL)
> > > +		/* Invalid matrix declaration format. */
> > > +		return err;
> > >  
> > >  	/* Matrix was not declared at all: fallback to identity. */
> > >  	return iio_setup_mount_idmatrix(dev, matrix);
> > >  }
> > > -#else
> > > -int of_iio_read_mount_matrix(const struct device *dev,
> > > -			     const char *propname,
> > > -			     struct iio_mount_matrix *matrix)
> > > -{
> > > -	return iio_setup_mount_idmatrix(dev, matrix);
> > > -}
> > > -#endif
> > > -EXPORT_SYMBOL(of_iio_read_mount_matrix);
> > > +EXPORT_SYMBOL(iio_read_mount_matrix);
> > >  
> > >  static ssize_t __iio_format_value(char *buf, size_t len, unsigned int type,
> > >  				  int size, const int *vals)
> > > diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
> > > index 93be1f4c0f27..9bf21e5fe3fc 100644
> > > --- a/drivers/iio/magnetometer/ak8974.c
> > > +++ b/drivers/iio/magnetometer/ak8974.c
> > > @@ -733,7 +733,7 @@ static int ak8974_probe(struct i2c_client *i2c,
> > >  	ak8974->i2c = i2c;
> > >  	mutex_init(&ak8974->lock);
> > >  
> > > -	ret = of_iio_read_mount_matrix(&i2c->dev,
> > > +	ret = iio_read_mount_matrix(&i2c->dev,
> > >  				       "mount-matrix",
> > >  				       &ak8974->orientation);
> > >  	if (ret)
> > > diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> > > index d430b80808ef..dca20df1310e 100644
> > > --- a/drivers/iio/magnetometer/ak8975.c
> > > +++ b/drivers/iio/magnetometer/ak8975.c
> > > @@ -911,7 +911,7 @@ static int ak8975_probe(struct i2c_client *client,
> > >  	data->eoc_irq = 0;
> > >  
> > >  	if (!pdata) {
> > > -		err = of_iio_read_mount_matrix(&client->dev,
> > > +		err = iio_read_mount_matrix(&client->dev,
> > >  					       "mount-matrix",
> > >  					       &data->orientation);
> > >  		if (err)
> > > diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> > > index a74cb177dc6f..bb10c1bee301 100644
> > > --- a/include/linux/iio/iio.h
> > > +++ b/include/linux/iio/iio.h
> > > @@ -130,8 +130,8 @@ struct iio_mount_matrix {
> > >  
> > >  ssize_t iio_show_mount_matrix(struct iio_dev *indio_dev, uintptr_t priv,
> > >  			      const struct iio_chan_spec *chan, char *buf);
> > > -int of_iio_read_mount_matrix(const struct device *dev, const char *propname,
> > > -			     struct iio_mount_matrix *matrix);
> > > +int iio_read_mount_matrix(struct device *dev, const char *propname,
> > > +			  struct iio_mount_matrix *matrix);
> > >  
> > >  typedef const struct iio_mount_matrix *
> > >  	(iio_get_mount_matrix_t)(const struct iio_dev *indio_dev,  
> >   
> 

