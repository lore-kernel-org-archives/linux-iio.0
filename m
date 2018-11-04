Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731376AbeKEDhj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 4 Nov 2018 22:37:39 -0500
Date: Sun, 4 Nov 2018 18:21:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 5/7] iio: imu: st_lsm6dsx: add i2c embedded controller
 support
Message-ID: <20181104182143.364efce5@archlinux>
In-Reply-To: <CAJ0CqmWxHpoz+a-ZuKnnuyDXqF8G7BE3aOfaorD-uT2QX+Tirg@mail.gmail.com>
References: <cover.1541341926.git.lorenzo.bianconi@redhat.com>
        <2fa8688ae1ebc85f29b65c2439d9b7e298f305ae.1541341926.git.lorenzo.bianconi@redhat.com>
        <20181104174228.7d0f6ad8@archlinux>
        <CAJ0CqmWxHpoz+a-ZuKnnuyDXqF8G7BE3aOfaorD-uT2QX+Tirg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 4 Nov 2018 19:00:39 +0100
Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:

> >
> > On Sun,  4 Nov 2018 15:39:04 +0100
> > Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:
> >  
> > > i2c controller embedded in lsm6dx series can connect up to four
> > > slave devices using accelerometer sensor as trigger for i2c
> > > read/write operations.
> > > Introduce sensor hub support for lsm6dso sensor. Add register map
> > > for lis2mdl magnetometer sensor
> > >
> > > Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>  
> >
> > I'd completely forgotten how this driver did the multiple device registration
> > so this had me completely confused initially ;)
> >
> > Perhaps just state here that the result is an entirely separate apparent device
> > and what it's functionality is at this point in the patch set?
> >  
> 
> ack, will do in v2
> 
> > A few minor comments inline.  This looks like it is coming together quite
> > nicely to me.
> >  
> 
> Thx :). I will address your comments in v2, just one question inline.
> Regards,
> 
> Lorenzo
> 
> > Jonathan
...
> > > +
> > > +static ssize_t st_lsm6dsx_shub_scale_avail(struct device *dev,
> > > +                                        struct device_attribute *attr,
> > > +                                        char *buf)
> > > +{
> > > +     struct st_lsm6dsx_sensor *sensor = iio_priv(dev_get_drvdata(dev));
> > > +     const struct st_lsm6dsx_ext_dev_settings *settings;
> > > +     int i, len = 0;
> > > +
> > > +     settings = sensor->ext_info.settings;
> > > +     for (i = 0; i < ST_LSM6DSX_FS_LIST_SIZE; i++) {
> > > +             u16 val = settings->fs_table.fs_avl[i].gain;
> > > +
> > > +             if (val > 0)
> > > +                     len += scnprintf(buf + len, PAGE_SIZE - len, "0.%06u ",
> > > +                                      val);
> > > +     }
> > > +     buf[len - 1] = '\n';
> > > +
> > > +     return len;
> > > +}
> > > +
> > > +static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(st_lsm6dsx_shub_sampling_freq_avail);
> > > +static IIO_DEVICE_ATTR(in_ext_scale_available, 0444,
> > > +                    st_lsm6dsx_shub_scale_avail, NULL, 0);
> > > +static struct attribute *st_lsm6dsx_ext_attributes[] = {
> > > +     &iio_dev_attr_sampling_frequency_available.dev_attr.attr,
> > > +     &iio_dev_attr_in_ext_scale_available.dev_attr.attr,  
> >
> > What's this abi element?
> >  
> 
> what do you mean here? I did not get you sorry :)
> 
Seems to be creating a sysfs file called
in_ext_scale_available which I don't think is documented anywhere?

Intent was probably in_scale_available?  Or maybe in_magn_scale_available?
