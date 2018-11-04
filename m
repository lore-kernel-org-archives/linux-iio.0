Return-Path: <SRS0=WtBq=NP=redhat.com=lbiancon@kernel.org>
MIME-Version: 1.0
References: <cover.1541341926.git.lorenzo.bianconi@redhat.com>
 <43cb13077ee4955fb7cb5c3e9c34e17d29e5fc68.1541341926.git.lorenzo.bianconi@redhat.com>
 <20181104175453.6764c957@archlinux>
In-Reply-To: <20181104175453.6764c957@archlinux>
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date: Sun, 4 Nov 2018 19:14:22 +0100
Message-ID: <CAJ0CqmWWDTx7JHU5KockQ_fRm5eibTQF3kF7Pq6jGzCmXSFUgg@mail.gmail.com>
Subject: Re: [PATCH 6/7] iio: imu: st_lsm6dsx: add hw FIFO support to i2c controller
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

>
> On Sun,  4 Nov 2018 15:39:05 +0100
> Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:
>
> > Introduce hw FIFO support to lsm6dsx sensorhub. Current implementation
> > use SLV0 for slave configuration and SLV{1,2,3} to read data and
> > push them into the hw FIFO
> So, the words 'Current Implementation' suggest you are already thinking
> of other implementations?  Perhaps a note here on why you chose this
> method, it's limitations etc and why you might want to change it in future?
> (I'm guessing when you potentially have 4 slave devices...)

ack, will do in v2

>
> A few comments inline.
>
> Jonathan
> >
> > Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
> > ---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  4 +
> >  .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 86 ++++++++++++++-----
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  |  5 ++
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c  | 76 ++++++++++++++++
> >  4 files changed, 150 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > index d20746eb3d2d..d1d8d07a0714 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > @@ -130,18 +130,22 @@ struct st_lsm6dsx_hw_ts_settings {
> >   * @master_en: master config register info (addr + mask).
> >   * @pullup_en: i2c controller pull-up register info (addr + mask).
> >   * @aux_sens: aux sensor register info (addr + mask).
> > + * @wr_once: write_once register info (addr + mask).
> >   * @shub_out: sensor hub first output register info.
> >   * @slv0_addr: slave0 address in secondary page.
> >   * @dw_slv0_addr: slave0 write register address in secondary page.
> > + * @batch_en: Enable/disable FIFO batching.
> >   */
> >  struct st_lsm6dsx_shub_settings {
> >       struct st_lsm6dsx_reg page_mux;
> >       struct st_lsm6dsx_reg master_en;
> >       struct st_lsm6dsx_reg pullup_en;
> >       struct st_lsm6dsx_reg aux_sens;
> > +     struct st_lsm6dsx_reg wr_once;
> >       u8 shub_out;
> >       u8 slv0_addr;
> >       u8 dw_slv0_addr;
> > +     u8 batch_en;
> >  };
> >
> >  enum st_lsm6dsx_ext_sensor_id {
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > index 96f7d56d3b6d..d4e4fe54219f 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > @@ -68,6 +68,9 @@ enum st_lsm6dsx_fifo_tag {
> >       ST_LSM6DSX_GYRO_TAG = 0x01,
> >       ST_LSM6DSX_ACC_TAG = 0x02,
> >       ST_LSM6DSX_TS_TAG = 0x04,
> > +     ST_LSM6DSX_EXT0_TAG = 0x0f,
> > +     ST_LSM6DSX_EXT1_TAG = 0x10,
> > +     ST_LSM6DSX_EXT2_TAG = 0x11,
> >  };
> >
> >  static const
> > @@ -453,6 +456,52 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
> >       return read_len;
> >  }
> >
> > +static int
> > +st_lsm6dsx_push_tagged_data(struct st_lsm6dsx_hw *hw, u8 tag,
> > +                         u8 *data, s64 ts)
> > +{
> > +     struct st_lsm6dsx_sensor *sensor;
> > +     struct iio_dev *iio_dev;
> > +
> > +     switch (tag) {
> > +     case ST_LSM6DSX_GYRO_TAG:
> > +             iio_dev = hw->iio_devs[ST_LSM6DSX_ID_GYRO];
> > +             sensor = iio_priv(iio_dev);
> > +             break;
> > +     case ST_LSM6DSX_ACC_TAG:
> > +             iio_dev = hw->iio_devs[ST_LSM6DSX_ID_ACC];
> > +             sensor = iio_priv(iio_dev);
> > +             break;
> > +     case ST_LSM6DSX_EXT0_TAG:
> > +             if (hw->enable_mask & BIT(ST_LSM6DSX_ID_EXT0))
> > +                     iio_dev = hw->iio_devs[ST_LSM6DSX_ID_EXT0];
> > +             else if (hw->enable_mask & BIT(ST_LSM6DSX_ID_EXT1))
> > +                     iio_dev = hw->iio_devs[ST_LSM6DSX_ID_EXT1];
> > +             else
> > +                     iio_dev = hw->iio_devs[ST_LSM6DSX_ID_EXT2];
>
> I would suggest this is non obvious enough to deserve some comments.
> I 'think' EXT0_TAG gets used for the first enabled additional channel?

EXT0_TAG will be used for the first enabled sensor, so if we enable
channel 2 and 3 (SLV2 and SLV3; first 'data' channel is 1 since 0 is
used just for configuration), we will receive data with TAG0 and TAG1
There is no relation between tags used and i2c slave channels IIRC

>
>
> > +             sensor = iio_priv(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
> Perhaps a comment that explains this is just to get the right timestamp
> or maybe better just have ts_ref as the local variable then it's
> more obvious.
>
> > +             break;
> > +     case ST_LSM6DSX_EXT1_TAG:
> > +             if (hw->enable_mask & BIT(ST_LSM6DSX_ID_EXT1))
> > +                     iio_dev = hw->iio_devs[ST_LSM6DSX_ID_EXT1];
> Under my assumption above about first come first served if 1 and 2
> are enabled but not 0, I think you will get the iio_dev for 1 for
> both of them...
>
> > +             else
> > +                     iio_dev = hw->iio_devs[ST_LSM6DSX_ID_EXT2];
> > +             sensor = iio_priv(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
> > +             break;
> > +     case ST_LSM6DSX_EXT2_TAG:
> > +             iio_dev = hw->iio_devs[ST_LSM6DSX_ID_EXT2];
> > +             sensor = iio_priv(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
> > +             break;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     iio_push_to_buffers_with_timestamp(iio_dev, data,
> > +                                        ts + sensor->ts_ref);
> > +
> > +     return 0;
> > +}
> > +
> >  /**
> >   * st_lsm6dsx_read_tagged_fifo() - LSM6DSO read FIFO routine
> >   * @hw: Pointer to instance of struct st_lsm6dsx_hw.
> > @@ -508,8 +557,7 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw *hw)
> >                              ST_LSM6DSX_SAMPLE_SIZE);
> >
> >                       tag = hw->buff[i] >> 3;
> > -                     switch (tag) {
> > -                     case ST_LSM6DSX_TS_TAG:
> > +                     if (tag == ST_LSM6DSX_TS_TAG) {
> >                               /*
> >                                * hw timestamp is 4B long and it is stored
> >                                * in FIFO according to this schema:
> > @@ -526,19 +574,9 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw *hw)
> >                               if (!reset_ts && ts >= 0xffff0000)
> >                                       reset_ts = true;
> >                               ts *= ST_LSM6DSX_TS_SENSITIVITY;
> > -                             break;
> > -                     case ST_LSM6DSX_GYRO_TAG:
> > -                             iio_push_to_buffers_with_timestamp(
> > -                                     hw->iio_devs[ST_LSM6DSX_ID_GYRO],
> > -                                     iio_buff, gyro_sensor->ts_ref + ts);
> > -                             break;
> > -                     case ST_LSM6DSX_ACC_TAG:
> > -                             iio_push_to_buffers_with_timestamp(
> > -                                     hw->iio_devs[ST_LSM6DSX_ID_ACC],
> > -                                     iio_buff, acc_sensor->ts_ref + ts);
> > -                             break;
> > -                     default:
> > -                             break;
>
> There would be a reasonable argument to be made in favour of doing this
> factoring out as a precursor patch so that we have less noise in this one.
>

ack, I will do in a separated patch

> > +                     } else {
> > +                             st_lsm6dsx_push_tagged_data(hw, tag, iio_buff,
> > +                                                         ts);
> >                       }
> >               }
> >       }
> > @@ -574,13 +612,19 @@ static int st_lsm6dsx_update_fifo(struct iio_dev *iio_dev, bool enable)
> >                       goto out;
> >       }
> >
> > -     err = st_lsm6dsx_sensor_set_enable(sensor, enable);
> > -     if (err < 0)
> > -             goto out;
> > +     if (sensor->id == ST_LSM6DSX_ID_EXT0 ||
> > +         sensor->id == ST_LSM6DSX_ID_EXT1 ||
> > +         sensor->id == ST_LSM6DSX_ID_EXT2) {
> > +             st_lsm6dsx_shub_set_enable(sensor, enable);
> Rather feels like this should ultimately be able to fail and should
> have error handling?

correct :) I will fix in v2

>
> > +     } else {
> > +             err = st_lsm6dsx_sensor_set_enable(sensor, enable);
> > +             if (err < 0)
> > +                     goto out;
> >
> > -     err = st_lsm6dsx_set_fifo_odr(sensor, enable);
> > -     if (err < 0)
> > -             goto out;
> > +             err = st_lsm6dsx_set_fifo_odr(sensor, enable);
> > +             if (err < 0)
> > +                     goto out;
> > +     }
> >
> >       err = st_lsm6dsx_update_decimators(hw);
> >       if (err < 0)
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > index 463859f287da..5ec94f211905 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > @@ -337,9 +337,14 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
> >                               .addr = 0x14,
> >                               .mask = GENMASK(1, 0),
> >                       },
> > +                     .wr_once = {
> > +                             .addr = 0x14,
> > +                             .mask = BIT(6),
> > +                     },
> >                       .shub_out = 0x02,
> >                       .slv0_addr = 0x15,
> >                       .dw_slv0_addr = 0x21,
> > +                     .batch_en = BIT(3),
> >               }
> >       },
> >  };
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> > index b37f9dbdad17..d723b4adeeda 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> > @@ -148,6 +148,26 @@ static int st_lsm6dsx_shub_write_reg(struct st_lsm6dsx_hw *hw, u8 addr,
> >       return err;
> >  }
> >
> > +static int
> > +st_lsm6dsx_shub_write_reg_with_mask(struct st_lsm6dsx_hw *hw, u8 addr,
> > +                                 u8 mask, u8 val)
> > +{
> > +     int err;
> > +
> > +     mutex_lock(&hw->page_lock);
> > +     err = st_lsm6dsx_set_page(hw, true);
> > +     if (err < 0)
> > +             goto out;
> > +
> > +     err = regmap_update_bits(hw->regmap, addr, mask, val);
> > +
> > +     st_lsm6dsx_set_page(hw, false);
>
> I wonder if long run we want to think about changing the driver
> to change page based only on what the coming read is?  Thus only
> change at transitions in which page we want.  I haven't even
> glanced at the balance of reads / writes to the two pages
> so this is pure conjecture.
>
> > +out:
> > +     mutex_unlock(&hw->page_lock);
> > +
> > +     return err;
> > +}
> > +
> >  static int st_lsm6dsx_shub_master_enable(struct st_lsm6dsx_sensor *sensor,
> >                                        bool enable)
> >  {
> > @@ -238,8 +258,21 @@ st_lsm6dsx_shub_write(struct st_lsm6dsx_sensor *sensor, u8 addr,
> >       int err, i;
> >
> >       hub_settings = &hw->settings->shub_settings;
> > +     if (hub_settings->wr_once.addr) {
> > +             unsigned int data;
> > +
> > +             data = ST_LSM6DSX_SHIFT_VAL(1, hub_settings->wr_once.mask);
> > +             err = st_lsm6dsx_shub_write_reg_with_mask(hw,
> > +                     hub_settings->wr_once.addr,
> > +                     hub_settings->wr_once.mask,
> > +                     data);
> > +             if (err < 0)
> > +                     return err;
> > +     }
> > +
> >       slv_addr = ST_LSM6DSX_SLV_ADDR(0, hub_settings->slv0_addr);
> >       config[0] = sensor->ext_info.addr << 1;
> > +
> Ahah! caught you in an unrelated white space change ;)  Meh. In a series this
> big there was sure to be one somewhere and it doesn't really matter that much.

:) will fix it in v2
Thx a lot for the fast review

Regards,
Lorenzo

>
> >       for (i = 0 ; i < len; i++) {
> >               config[1] = addr + i;
> >
> > @@ -319,11 +352,54 @@ st_lsm6dsx_shub_set_odr(struct st_lsm6dsx_sensor *sensor, u16 odr)
> >                                              val);
> >  }
> >
> > +/* use SLV{1,2,3} for FIFO read operations */
> > +static int
> > +st_lsm6dsx_shub_config_channels(struct st_lsm6dsx_sensor *sensor,
> > +                             bool enable)
> > +{
> > +     const struct st_lsm6dsx_shub_settings *hub_settings;
> > +     const struct st_lsm6dsx_ext_dev_settings *settings;
> > +     u8 config[9] = {}, enable_mask, slv_addr;
> > +     struct st_lsm6dsx_hw *hw = sensor->hw;
> > +     struct st_lsm6dsx_sensor *cur_sensor;
> > +     int i, j = 0;
> > +
> > +     hub_settings = &hw->settings->shub_settings;
> > +     if (enable)
> > +             enable_mask = hw->enable_mask | BIT(sensor->id);
> > +     else
> > +             enable_mask = hw->enable_mask & ~BIT(sensor->id);
> > +
> > +     for (i = ST_LSM6DSX_ID_EXT0; i <= ST_LSM6DSX_ID_EXT2; i++) {
> > +             if (!hw->iio_devs[i])
> > +                     continue;
> > +
> > +             cur_sensor = iio_priv(hw->iio_devs[i]);
> > +             if (!(enable_mask & BIT(cur_sensor->id)))
> > +                     continue;
> > +
> > +             settings = cur_sensor->ext_info.settings;
> > +             config[j] = (sensor->ext_info.addr << 1) | 1;
> > +             config[j + 1] = settings->out.addr;
> > +             config[j + 2] = (settings->out.len & ST_LS6DSX_READ_OP_MASK) |
> > +                             hub_settings->batch_en;
> > +             j += 3;
> > +     }
> > +
> > +     slv_addr = ST_LSM6DSX_SLV_ADDR(1, hub_settings->slv0_addr);
> > +     return st_lsm6dsx_shub_write_reg(hw, slv_addr, config,
> > +                                      sizeof(config));
> > +}
> > +
> >  int st_lsm6dsx_shub_set_enable(struct st_lsm6dsx_sensor *sensor, bool enable)
> >  {
> >       const struct st_lsm6dsx_ext_dev_settings *settings;
> >       int err;
> >
> > +     err = st_lsm6dsx_shub_config_channels(sensor, enable);
> > +     if (err < 0)
> > +             return err;
> > +
> >       settings = sensor->ext_info.settings;
> >       if (enable) {
> >               err = st_lsm6dsx_shub_set_odr(sensor, sensor->odr);
>
