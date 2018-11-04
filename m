Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it1-f177.google.com ([209.85.166.177]:50285 "EHLO
        mail-it1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728835AbeKEEM0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 4 Nov 2018 23:12:26 -0500
Received: by mail-it1-f177.google.com with SMTP id k206-v6so9825421ite.0
        for <linux-iio@vger.kernel.org>; Sun, 04 Nov 2018 10:56:26 -0800 (PST)
MIME-Version: 1.0
References: <cover.1541341926.git.lorenzo.bianconi@redhat.com>
 <43cb13077ee4955fb7cb5c3e9c34e17d29e5fc68.1541341926.git.lorenzo.bianconi@redhat.com>
 <20181104175453.6764c957@archlinux> <CAJ0CqmWWDTx7JHU5KockQ_fRm5eibTQF3kF7Pq6jGzCmXSFUgg@mail.gmail.com>
 <20181104183144.2f603e07@archlinux>
In-Reply-To: <20181104183144.2f603e07@archlinux>
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date: Sun, 4 Nov 2018 19:56:14 +0100
Message-ID: <CAJ0CqmXRB0aQ74hXKhbYKxcN7b3=9zuVhU0of=JEhrefJxSh1A@mail.gmail.com>
Subject: Re: [PATCH 6/7] iio: imu: st_lsm6dsx: add hw FIFO support to i2c controller
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Nov 4, 2018 at 7:31 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sun, 4 Nov 2018 19:14:22 +0100
> Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:
>
> > >
> > > On Sun,  4 Nov 2018 15:39:05 +0100
> > > Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:
> > >
> > > > Introduce hw FIFO support to lsm6dsx sensorhub. Current implementation
> > > > use SLV0 for slave configuration and SLV{1,2,3} to read data and
> > > > push them into the hw FIFO
> > > So, the words 'Current Implementation' suggest you are already thinking
> > > of other implementations?  Perhaps a note here on why you chose this
> > > method, it's limitations etc and why you might want to change it in future?
> > > (I'm guessing when you potentially have 4 slave devices...)
> >
> > ack, will do in v2
> >
> Great.
> > > > +static int
> > > > +st_lsm6dsx_push_tagged_data(struct st_lsm6dsx_hw *hw, u8 tag,
> > > > +                         u8 *data, s64 ts)
> > > > +{
> > > > +     struct st_lsm6dsx_sensor *sensor;
> > > > +     struct iio_dev *iio_dev;
> > > > +
> > > > +     switch (tag) {
> > > > +     case ST_LSM6DSX_GYRO_TAG:
> > > > +             iio_dev = hw->iio_devs[ST_LSM6DSX_ID_GYRO];
> > > > +             sensor = iio_priv(iio_dev);
> > > > +             break;
> > > > +     case ST_LSM6DSX_ACC_TAG:
> > > > +             iio_dev = hw->iio_devs[ST_LSM6DSX_ID_ACC];
> > > > +             sensor = iio_priv(iio_dev);
> > > > +             break;
> > > > +     case ST_LSM6DSX_EXT0_TAG:
> > > > +             if (hw->enable_mask & BIT(ST_LSM6DSX_ID_EXT0))
> > > > +                     iio_dev = hw->iio_devs[ST_LSM6DSX_ID_EXT0];
> > > > +             else if (hw->enable_mask & BIT(ST_LSM6DSX_ID_EXT1))
> > > > +                     iio_dev = hw->iio_devs[ST_LSM6DSX_ID_EXT1];
> > > > +             else
> > > > +                     iio_dev = hw->iio_devs[ST_LSM6DSX_ID_EXT2];
> > >
> > > I would suggest this is non obvious enough to deserve some comments.
> > > I 'think' EXT0_TAG gets used for the first enabled additional channel?
> >
> > EXT0_TAG will be used for the first enabled sensor, so if we enable
> > channel 2 and 3 (SLV2 and SLV3; first 'data' channel is 1 since 0 is
> > used just for configuration), we will receive data with TAG0 and TAG1
> > There is no relation between tags used and i2c slave channels IIRC
>
> Great, add that comment to v2.
>
> >
> > >
> > >
> > > > +             sensor = iio_priv(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
> > > Perhaps a comment that explains this is just to get the right timestamp
> > > or maybe better just have ts_ref as the local variable then it's
> > > more obvious.
> > >
> > > > +             break;
> > > > +     case ST_LSM6DSX_EXT1_TAG:
> > > > +             if (hw->enable_mask & BIT(ST_LSM6DSX_ID_EXT1))
> > > > +                     iio_dev = hw->iio_devs[ST_LSM6DSX_ID_EXT1];
> > > Under my assumption above about first come first served if 1 and 2
> > > are enabled but not 0, I think you will get the iio_dev for 1 for
> > > both of them...
> I 'think' my query still holds here..

correct :) I will fix in v2

> > >
> > > > +             else
> > > > +                     iio_dev = hw->iio_devs[ST_LSM6DSX_ID_EXT2];
> > > > +             sensor = iio_priv(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
> > > > +             break;
> ...
> > > > @@ -574,13 +612,19 @@ static int st_lsm6dsx_update_fifo(struct iio_dev *iio_dev, bool enable)
> > > >                       goto out;
> > > >       }
> > > >
> > > > -     err = st_lsm6dsx_sensor_set_enable(sensor, enable);
> > > > -     if (err < 0)
> > > > -             goto out;
> > > > +     if (sensor->id == ST_LSM6DSX_ID_EXT0 ||
> > > > +         sensor->id == ST_LSM6DSX_ID_EXT1 ||
> > > > +         sensor->id == ST_LSM6DSX_ID_EXT2) {
> > > > +             st_lsm6dsx_shub_set_enable(sensor, enable);
> > > Rather feels like this should ultimately be able to fail and should
> > > have error handling?
> >
> > correct :) I will fix in v2
> >
> > >
> > > > +     } else {
> > > > +             err = st_lsm6dsx_sensor_set_enable(sensor, enable);
> > > > +             if (err < 0)
> > > > +                     goto out;
> ...
> > > > +out:
> > > > +     mutex_unlock(&hw->page_lock);
> > > > +
> > > > +     return err;
> > > > +}
> > > > +
> > > >  static int st_lsm6dsx_shub_master_enable(struct st_lsm6dsx_sensor *sensor,
> > > >                                        bool enable)
> > > >  {
> > > > @@ -238,8 +258,21 @@ st_lsm6dsx_shub_write(struct st_lsm6dsx_sensor *sensor, u8 addr,
> > > >       int err, i;
> > > >
> > > >       hub_settings = &hw->settings->shub_settings;
> > > > +     if (hub_settings->wr_once.addr) {
> > > > +             unsigned int data;
> > > > +
> > > > +             data = ST_LSM6DSX_SHIFT_VAL(1, hub_settings->wr_once.mask);
> > > > +             err = st_lsm6dsx_shub_write_reg_with_mask(hw,
> > > > +                     hub_settings->wr_once.addr,
> > > > +                     hub_settings->wr_once.mask,
> > > > +                     data);
> > > > +             if (err < 0)
> > > > +                     return err;
> > > > +     }
> > > > +
> > > >       slv_addr = ST_LSM6DSX_SLV_ADDR(0, hub_settings->slv0_addr);
> > > >       config[0] = sensor->ext_info.addr << 1;
> > > > +
> > > Ahah! caught you in an unrelated white space change ;)  Meh. In a series this
> > > big there was sure to be one somewhere and it doesn't really matter that much.
> >
> > :) will fix it in v2
> > Thx a lot for the fast review
> You are welcome.  A rare thing from me, but I just happened to be catching up
> today.
>
> >
> > Regards,
> > Lorenzo
> >
