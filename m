Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:32890 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750825AbeAUOf1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 Jan 2018 09:35:27 -0500
Received: by mail-io0-f196.google.com with SMTP id n7so6828529iob.0
        for <linux-iio@vger.kernel.org>; Sun, 21 Jan 2018 06:35:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180121124502.6b9f104f@archlinux>
References: <20180113175756.25600-1-lorenzo.bianconi@redhat.com>
 <20180114111924.0287b791@archlinux> <CAJ0CqmVt8+mErQnEO8itJABr_KyDvCh0EJe2BGrrfuH8M36GKA@mail.gmail.com>
 <20180121124502.6b9f104f@archlinux>
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date: Sun, 21 Jan 2018 15:35:25 +0100
Message-ID: <CAJ0CqmVfAVyO6DnRUnveMBasvC1gdvJjCduua4BPWdf-PUXRiw@mail.gmail.com>
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: add hw timestamp support
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> On Sun, 14 Jan 2018 12:51:57 +0100
> Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:
>
>> > On Sat, 13 Jan 2018 18:57:56 +0100
>> > Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:
>> >
>> >> Introduce hw timestamp support instead of compute sample timestamps
>> >> according to interrupt rate and configured watermark. LSM6DSx based
>> >> devices are able to queue in hw FIFO the time reference of data
>> >> sampling
>> >>
>> >> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
>> >
>> > I am curious, how good is the clock?  Do you see significant jumps when
>> > the timer reset happens and you rebase on the cpu timestamp?
>>
>> At the moment I do not have an answer to that question but I can carry
>> out some tests :)
>>
>> >
>> > The patch looks good to me, but I'd like to let it sit on the list
>> > a little longer given its more or less a new feature to IIO.
>> >
>>
>> Sure, fine for me
> Long enough.  Applied to the togreg branch of iio.git and pushed out
> as testing for the autobuilders to play with it.
>

-ETIMEDOUT :-)

Regards,
Lorenzo

> Thanks,
>
> Jonathan
>
>> Regards,
>>
>> Lorenzo
>>
>> > Jonathan
>> >> ---
>> >>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h        |  29 +++--
>> >>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 161 ++++++++++++++++---------
>> >>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c   | 104 +++++++++++++++-
>> >>  3 files changed, 224 insertions(+), 70 deletions(-)
>> >>
>> >> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
>> >> index 8fdd723afa05..a3cc7cd97026 100644
>> >> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
>> >> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
>> >> @@ -27,7 +27,7 @@ enum st_lsm6dsx_hw_id {
>> >>       ST_LSM6DSX_MAX_ID,
>> >>  };
>> >>
>> >> -#define ST_LSM6DSX_BUFF_SIZE         256
>> >> +#define ST_LSM6DSX_BUFF_SIZE         400
>> >>  #define ST_LSM6DSX_CHAN_SIZE         2
>> >>  #define ST_LSM6DSX_SAMPLE_SIZE               6
>> >>  #define ST_LSM6DSX_MAX_WORD_LEN              ((32 / ST_LSM6DSX_SAMPLE_SIZE) * \
>> >> @@ -57,6 +57,20 @@ struct st_lsm6dsx_fifo_ops {
>> >>       u8 th_wl;
>> >>  };
>> >>
>> >> +/**
>> >> + * struct st_lsm6dsx_hw_ts_settings - ST IMU hw timer settings
>> >> + * @timer_en: Hw timer enable register info (addr + mask).
>> >> + * @hr_timer: Hw timer resolution register info (addr + mask).
>> >> + * @fifo_en: Hw timer FIFO enable register info (addr + mask).
>> >> + * @decimator: Hw timer FIFO decimator register info (addr + mask).
>> >> + */
>> >> +struct st_lsm6dsx_hw_ts_settings {
>> >> +     struct st_lsm6dsx_reg timer_en;
>> >> +     struct st_lsm6dsx_reg hr_timer;
>> >> +     struct st_lsm6dsx_reg fifo_en;
>> >> +     struct st_lsm6dsx_reg decimator;
>> >> +};
>> >> +
>> >>  /**
>> >>   * struct st_lsm6dsx_settings - ST IMU sensor settings
>> >>   * @wai: Sensor WhoAmI default value.
>> >> @@ -64,6 +78,7 @@ struct st_lsm6dsx_fifo_ops {
>> >>   * @id: List of hw id supported by the driver configuration.
>> >>   * @decimator: List of decimator register info (addr + mask).
>> >>   * @fifo_ops: Sensor hw FIFO parameters.
>> >> + * @ts_settings: Hw timer related settings.
>> >>   */
>> >>  struct st_lsm6dsx_settings {
>> >>       u8 wai;
>> >> @@ -71,6 +86,7 @@ struct st_lsm6dsx_settings {
>> >>       enum st_lsm6dsx_hw_id id[ST_LSM6DSX_MAX_ID];
>> >>       struct st_lsm6dsx_reg decimator[ST_LSM6DSX_MAX_ID];
>> >>       struct st_lsm6dsx_fifo_ops fifo_ops;
>> >> +     struct st_lsm6dsx_hw_ts_settings ts_settings;
>> >>  };
>> >>
>> >>  enum st_lsm6dsx_sensor_id {
>> >> @@ -94,8 +110,7 @@ enum st_lsm6dsx_fifo_mode {
>> >>   * @watermark: Sensor watermark level.
>> >>   * @sip: Number of samples in a given pattern.
>> >>   * @decimator: FIFO decimation factor.
>> >> - * @delta_ts: Delta time between two consecutive interrupts.
>> >> - * @ts: Latest timestamp from the interrupt handler.
>> >> + * @ts_ref: Sensor timestamp reference for hw one.
>> >>   */
>> >>  struct st_lsm6dsx_sensor {
>> >>       char name[32];
>> >> @@ -108,9 +123,7 @@ struct st_lsm6dsx_sensor {
>> >>       u16 watermark;
>> >>       u8 sip;
>> >>       u8 decimator;
>> >> -
>> >> -     s64 delta_ts;
>> >> -     s64 ts;
>> >> +     s64 ts_ref;
>> >>  };
>> >>
>> >>  /**
>> >> @@ -122,7 +135,8 @@ struct st_lsm6dsx_sensor {
>> >>   * @conf_lock: Mutex to prevent concurrent FIFO configuration update.
>> >>   * @fifo_mode: FIFO operating mode supported by the device.
>> >>   * @enable_mask: Enabled sensor bitmask.
>> >> - * @sip: Total number of samples (acc/gyro) in a given pattern.
>> >> + * @ts_sip: Total number of timestamp samples in a given pattern.
>> >> + * @sip: Total number of samples (acc/gyro/ts) in a given pattern.
>> >>   * @buff: Device read buffer.
>> >>   * @iio_devs: Pointers to acc/gyro iio_dev instances.
>> >>   * @settings: Pointer to the specific sensor settings in use.
>> >> @@ -137,6 +151,7 @@ struct st_lsm6dsx_hw {
>> >>
>> >>       enum st_lsm6dsx_fifo_mode fifo_mode;
>> >>       u8 enable_mask;
>> >> +     u8 ts_sip;
>> >>       u8 sip;
>> >>
>> >>       u8 *buff;
>> >> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
>> >> index 1d6aa9b1a4cf..1045e025e92b 100644
>> >> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
>> >> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
>> >> @@ -46,9 +46,13 @@
>> >>  #define ST_LSM6DSX_FIFO_ODR_MASK             GENMASK(6, 3)
>> >>  #define ST_LSM6DSX_FIFO_EMPTY_MASK           BIT(12)
>> >>  #define ST_LSM6DSX_REG_FIFO_OUTL_ADDR                0x3e
>> >> +#define ST_LSM6DSX_REG_TS_RESET_ADDR         0x42
>> >>
>> >>  #define ST_LSM6DSX_MAX_FIFO_ODR_VAL          0x08
>> >>
>> >> +#define ST_LSM6DSX_TS_SENSITIVITY            25000UL /* 25us */
>> >> +#define ST_LSM6DSX_TS_RESET_VAL                      0xaa
>> >> +
>> >>  struct st_lsm6dsx_decimator_entry {
>> >>       u8 decimator;
>> >>       u8 val;
>> >> @@ -98,9 +102,10 @@ static void st_lsm6dsx_get_max_min_odr(struct st_lsm6dsx_hw *hw,
>> >>
>> >>  static int st_lsm6dsx_update_decimators(struct st_lsm6dsx_hw *hw)
>> >>  {
>> >> +     u16 max_odr, min_odr, sip = 0, ts_sip = 0;
>> >> +     const struct st_lsm6dsx_reg *ts_dec_reg;
>> >>       struct st_lsm6dsx_sensor *sensor;
>> >> -     u16 max_odr, min_odr, sip = 0;
>> >> -     int err, i;
>> >> +     int err = 0, i;
>> >>       u8 data;
>> >>
>> >>       st_lsm6dsx_get_max_min_odr(hw, &max_odr, &min_odr);
>> >> @@ -119,6 +124,7 @@ static int st_lsm6dsx_update_decimators(struct st_lsm6dsx_hw *hw)
>> >>                       sensor->decimator = 0;
>> >>                       data = 0;
>> >>               }
>> >> +             ts_sip = max_t(u16, ts_sip, sensor->sip);
>> >>
>> >>               dec_reg = &hw->settings->decimator[sensor->id];
>> >>               if (dec_reg->addr) {
>> >> @@ -131,9 +137,23 @@ static int st_lsm6dsx_update_decimators(struct st_lsm6dsx_hw *hw)
>> >>               }
>> >>               sip += sensor->sip;
>> >>       }
>> >> -     hw->sip = sip;
>> >> +     hw->sip = sip + ts_sip;
>> >> +     hw->ts_sip = ts_sip;
>> >>
>> >> -     return 0;
>> >> +     /*
>> >> +      * update hw ts decimator if necessary. Decimator for hw timestamp
>> >> +      * is always 1 or 0 in order to have a ts sample for each data
>> >> +      * sample in FIFO
>> >> +      */
>> >> +     ts_dec_reg = &hw->settings->ts_settings.decimator;
>> >> +     if (ts_dec_reg->addr) {
>> >> +             int val, ts_dec = !!hw->ts_sip;
>> >> +
>> >> +             val = ST_LSM6DSX_SHIFT_VAL(ts_dec, ts_dec_reg->mask);
>> >> +             err = regmap_update_bits(hw->regmap, ts_dec_reg->addr,
>> >> +                                      ts_dec_reg->mask, val);
>> >> +     }
>> >> +     return err;
>> >>  }
>> >>
>> >>  int st_lsm6dsx_set_fifo_mode(struct st_lsm6dsx_hw *hw,
>> >> @@ -208,6 +228,28 @@ int st_lsm6dsx_update_watermark(struct st_lsm6dsx_sensor *sensor, u16 watermark)
>> >>                                &wdata, sizeof(wdata));
>> >>  }
>> >>
>> >> +static int st_lsm6dsx_reset_hw_ts(struct st_lsm6dsx_hw *hw)
>> >> +{
>> >> +     struct st_lsm6dsx_sensor *sensor;
>> >> +     int i, err;
>> >> +
>> >> +     /* reset hw ts counter */
>> >> +     err = regmap_write(hw->regmap, ST_LSM6DSX_REG_TS_RESET_ADDR,
>> >> +                        ST_LSM6DSX_TS_RESET_VAL);
>> >> +     if (err < 0)
>> >> +             return err;
>> >> +
>> >> +     for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
>> >> +             sensor = iio_priv(hw->iio_devs[i]);
>> >> +             /*
>> >> +              * store enable buffer timestamp as reference for
>> >> +              * hw timestamp
>> >> +              */
>> >> +             sensor->ts_ref = iio_get_time_ns(hw->iio_devs[i]);
>> >> +     }
>> >> +     return 0;
>> >> +}
>> >> +
>> >>  /*
>> >>   * Set max bulk read to ST_LSM6DSX_MAX_WORD_LEN in order to avoid
>> >>   * a kmalloc for each bus access
>> >> @@ -231,6 +273,8 @@ static inline int st_lsm6dsx_read_block(struct st_lsm6dsx_hw *hw, u8 *data,
>> >>       return 0;
>> >>  }
>> >>
>> >> +#define ST_LSM6DSX_IIO_BUFF_SIZE     (ALIGN(ST_LSM6DSX_SAMPLE_SIZE, \
>> >> +                                            sizeof(s64)) + sizeof(s64))
>> >>  /**
>> >>   * st_lsm6dsx_read_fifo() - LSM6DS3-LSM6DS3H-LSM6DSL-LSM6DSM read FIFO routine
>> >>   * @hw: Pointer to instance of struct st_lsm6dsx_hw.
>> >> @@ -243,11 +287,13 @@ static int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
>> >>  {
>> >>       u16 fifo_len, pattern_len = hw->sip * ST_LSM6DSX_SAMPLE_SIZE;
>> >>       u16 fifo_diff_mask = hw->settings->fifo_ops.fifo_diff.mask;
>> >> -     int err, acc_sip, gyro_sip, read_len, samples, offset;
>> >> +     int err, acc_sip, gyro_sip, ts_sip, read_len, offset;
>> >>       struct st_lsm6dsx_sensor *acc_sensor, *gyro_sensor;
>> >> -     s64 acc_ts, acc_delta_ts, gyro_ts, gyro_delta_ts;
>> >> -     u8 iio_buff[ALIGN(ST_LSM6DSX_SAMPLE_SIZE, sizeof(s64)) + sizeof(s64)];
>> >> +     u8 gyro_buff[ST_LSM6DSX_IIO_BUFF_SIZE];
>> >> +     u8 acc_buff[ST_LSM6DSX_IIO_BUFF_SIZE];
>> >> +     bool reset_ts = false;
>> >>       __le16 fifo_status;
>> >> +     s64 ts = 0;
>> >>
>> >>       err = regmap_bulk_read(hw->regmap,
>> >>                              hw->settings->fifo_ops.fifo_diff.addr,
>> >> @@ -260,23 +306,10 @@ static int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
>> >>
>> >>       fifo_len = (le16_to_cpu(fifo_status) & fifo_diff_mask) *
>> >>                  ST_LSM6DSX_CHAN_SIZE;
>> >> -     samples = fifo_len / ST_LSM6DSX_SAMPLE_SIZE;
>> >>       fifo_len = (fifo_len / pattern_len) * pattern_len;
>> >>
>> >> -     /*
>> >> -      * compute delta timestamp between two consecutive samples
>> >> -      * in order to estimate queueing time of data generated
>> >> -      * by the sensor
>> >> -      */
>> >>       acc_sensor = iio_priv(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
>> >> -     acc_ts = acc_sensor->ts - acc_sensor->delta_ts;
>> >> -     acc_delta_ts = div_s64(acc_sensor->delta_ts * acc_sensor->decimator,
>> >> -                            samples);
>> >> -
>> >>       gyro_sensor = iio_priv(hw->iio_devs[ST_LSM6DSX_ID_GYRO]);
>> >> -     gyro_ts = gyro_sensor->ts - gyro_sensor->delta_ts;
>> >> -     gyro_delta_ts = div_s64(gyro_sensor->delta_ts * gyro_sensor->decimator,
>> >> -                             samples);
>> >>
>> >>       for (read_len = 0; read_len < fifo_len; read_len += pattern_len) {
>> >>               err = st_lsm6dsx_read_block(hw, hw->buff, pattern_len);
>> >> @@ -287,7 +320,7 @@ static int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
>> >>                * Data are written to the FIFO with a specific pattern
>> >>                * depending on the configured ODRs. The first sequence of data
>> >>                * stored in FIFO contains the data of all enabled sensors
>> >> -              * (e.g. Gx, Gy, Gz, Ax, Ay, Az), then data are repeated
>> >> +              * (e.g. Gx, Gy, Gz, Ax, Ay, Az, Ts), then data are repeated
>> >>                * depending on the value of the decimation factor set for each
>> >>                * sensor.
>> >>                *
>> >> @@ -296,35 +329,65 @@ static int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
>> >>                *   - gyroscope ODR = 208Hz, accelerometer ODR = 104Hz
>> >>                * Since the gyroscope ODR is twice the accelerometer one, the
>> >>                * following pattern is repeated every 9 samples:
>> >> -              *   - Gx, Gy, Gz, Ax, Ay, Az, Gx, Gy, Gz
>> >> +              *   - Gx, Gy, Gz, Ax, Ay, Az, Ts, Gx, Gy, Gz, Ts, Gx, ..
>> >>                */
>> >>               gyro_sip = gyro_sensor->sip;
>> >>               acc_sip = acc_sensor->sip;
>> >> +             ts_sip = hw->ts_sip;
>> >>               offset = 0;
>> >>
>> >>               while (acc_sip > 0 || gyro_sip > 0) {
>> >> -                     if (gyro_sip-- > 0) {
>> >> -                             memcpy(iio_buff, &hw->buff[offset],
>> >> +                     if (gyro_sip > 0) {
>> >> +                             memcpy(gyro_buff, &hw->buff[offset],
>> >>                                      ST_LSM6DSX_SAMPLE_SIZE);
>> >> -                             iio_push_to_buffers_with_timestamp(
>> >> -                                     hw->iio_devs[ST_LSM6DSX_ID_GYRO],
>> >> -                                     iio_buff, gyro_ts);
>> >>                               offset += ST_LSM6DSX_SAMPLE_SIZE;
>> >> -                             gyro_ts += gyro_delta_ts;
>> >>                       }
>> >> -
>> >> -                     if (acc_sip-- > 0) {
>> >> -                             memcpy(iio_buff, &hw->buff[offset],
>> >> +                     if (acc_sip > 0) {
>> >> +                             memcpy(acc_buff, &hw->buff[offset],
>> >>                                      ST_LSM6DSX_SAMPLE_SIZE);
>> >> -                             iio_push_to_buffers_with_timestamp(
>> >> -                                     hw->iio_devs[ST_LSM6DSX_ID_ACC],
>> >> -                                     iio_buff, acc_ts);
>> >>                               offset += ST_LSM6DSX_SAMPLE_SIZE;
>> >> -                             acc_ts += acc_delta_ts;
>> >>                       }
>> >> +
>> >> +                     if (ts_sip-- > 0) {
>> >> +                             u8 data[ST_LSM6DSX_SAMPLE_SIZE];
>> >> +
>> >> +                             memcpy(data, &hw->buff[offset], sizeof(data));
>> >> +                             /*
>> >> +                              * hw timestamp is 3B long and it is stored
>> >> +                              * in FIFO using 6B as 4th FIFO data set
>> >> +                              * according to this schema:
>> >> +                              * B0 = ts[15:8], B1 = ts[23:16], B3 = ts[7:0]
>> >> +                              */
>> >> +                             ts = data[1] << 16 | data[0] << 8 | data[3];
>> >> +                             /*
>> >> +                              * check if hw timestamp engine is going to
>> >> +                              * reset (the sensor generates an interrupt
>> >> +                              * to signal the hw timestamp will reset in
>> >> +                              * 1.638s)
>> >> +                              */
>> >> +                             if (!reset_ts && ts >= 0xff0000)
>> >> +                                     reset_ts = true;
>> >> +                             ts *= ST_LSM6DSX_TS_SENSITIVITY;
>> >> +
>> >> +                             offset += ST_LSM6DSX_SAMPLE_SIZE;
>> >> +                     }
>> >> +
>> >> +                     if (gyro_sip-- > 0)
>> >> +                             iio_push_to_buffers_with_timestamp(
>> >> +                                     hw->iio_devs[ST_LSM6DSX_ID_GYRO],
>> >> +                                     gyro_buff, gyro_sensor->ts_ref + ts);
>> >> +                     if (acc_sip-- > 0)
>> >> +                             iio_push_to_buffers_with_timestamp(
>> >> +                                     hw->iio_devs[ST_LSM6DSX_ID_ACC],
>> >> +                                     acc_buff, acc_sensor->ts_ref + ts);
>> >>               }
>> >>       }
>> >>
>> >> +     if (unlikely(reset_ts)) {
>> >> +             err = st_lsm6dsx_reset_hw_ts(hw);
>> >> +             if (err < 0)
>> >> +                     return err;
>> >> +     }
>> >>       return read_len;
>> >>  }
>> >>
>> >> @@ -379,15 +442,12 @@ static int st_lsm6dsx_update_fifo(struct iio_dev *iio_dev, bool enable)
>> >>               goto out;
>> >>
>> >>       if (hw->enable_mask) {
>> >> -             err = st_lsm6dsx_set_fifo_mode(hw, ST_LSM6DSX_FIFO_CONT);
>> >> +             /* reset hw ts counter */
>> >> +             err = st_lsm6dsx_reset_hw_ts(hw);
>> >>               if (err < 0)
>> >>                       goto out;
>> >>
>> >> -             /*
>> >> -              * store enable buffer timestamp as reference to compute
>> >> -              * first delta timestamp
>> >> -              */
>> >> -             sensor->ts = iio_get_time_ns(iio_dev);
>> >> +             err = st_lsm6dsx_set_fifo_mode(hw, ST_LSM6DSX_FIFO_CONT);
>> >>       }
>> >>
>> >>  out:
>> >> @@ -399,25 +459,8 @@ static int st_lsm6dsx_update_fifo(struct iio_dev *iio_dev, bool enable)
>> >>  static irqreturn_t st_lsm6dsx_handler_irq(int irq, void *private)
>> >>  {
>> >>       struct st_lsm6dsx_hw *hw = private;
>> >> -     struct st_lsm6dsx_sensor *sensor;
>> >> -     int i;
>> >> -
>> >> -     if (!hw->sip)
>> >> -             return IRQ_NONE;
>> >> -
>> >> -     for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
>> >> -             sensor = iio_priv(hw->iio_devs[i]);
>> >> -
>> >> -             if (sensor->sip > 0) {
>> >> -                     s64 timestamp;
>> >> -
>> >> -                     timestamp = iio_get_time_ns(hw->iio_devs[i]);
>> >> -                     sensor->delta_ts = timestamp - sensor->ts;
>> >> -                     sensor->ts = timestamp;
>> >> -             }
>> >> -     }
>> >>
>> >> -     return IRQ_WAKE_THREAD;
>> >> +     return hw->sip > 0 ? IRQ_WAKE_THREAD : IRQ_NONE;
>> >>  }
>> >>
>> >>  static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
>> >> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
>> >> index c2fa3239b9c6..8656d72ef4ee 100644
>> >> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
>> >> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
>> >> @@ -181,6 +181,24 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>> >>                       },
>> >>                       .th_wl = 3, /* 1LSB = 2B */
>> >>               },
>> >> +             .ts_settings = {
>> >> +                     .timer_en = {
>> >> +                             .addr = 0x58,
>> >> +                             .mask = BIT(7),
>> >> +                     },
>> >> +                     .hr_timer = {
>> >> +                             .addr = 0x5c,
>> >> +                             .mask = BIT(4),
>> >> +                     },
>> >> +                     .fifo_en = {
>> >> +                             .addr = 0x07,
>> >> +                             .mask = BIT(7),
>> >> +                     },
>> >> +                     .decimator = {
>> >> +                             .addr = 0x09,
>> >> +                             .mask = GENMASK(5, 3),
>> >> +                     },
>> >> +             },
>> >>       },
>> >>       {
>> >>               .wai = 0x69,
>> >> @@ -209,6 +227,24 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>> >>                       },
>> >>                       .th_wl = 3, /* 1LSB = 2B */
>> >>               },
>> >> +             .ts_settings = {
>> >> +                     .timer_en = {
>> >> +                             .addr = 0x58,
>> >> +                             .mask = BIT(7),
>> >> +                     },
>> >> +                     .hr_timer = {
>> >> +                             .addr = 0x5c,
>> >> +                             .mask = BIT(4),
>> >> +                     },
>> >> +                     .fifo_en = {
>> >> +                             .addr = 0x07,
>> >> +                             .mask = BIT(7),
>> >> +                     },
>> >> +                     .decimator = {
>> >> +                             .addr = 0x09,
>> >> +                             .mask = GENMASK(5, 3),
>> >> +                     },
>> >> +             },
>> >>       },
>> >>       {
>> >>               .wai = 0x6a,
>> >> @@ -238,6 +274,24 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>> >>                       },
>> >>                       .th_wl = 3, /* 1LSB = 2B */
>> >>               },
>> >> +             .ts_settings = {
>> >> +                     .timer_en = {
>> >> +                             .addr = 0x19,
>> >> +                             .mask = BIT(5),
>> >> +                     },
>> >> +                     .hr_timer = {
>> >> +                             .addr = 0x5c,
>> >> +                             .mask = BIT(4),
>> >> +                     },
>> >> +                     .fifo_en = {
>> >> +                             .addr = 0x07,
>> >> +                             .mask = BIT(7),
>> >> +                     },
>> >> +                     .decimator = {
>> >> +                             .addr = 0x09,
>> >> +                             .mask = GENMASK(5, 3),
>> >> +                     },
>> >> +             },
>> >>       },
>> >>  };
>> >>
>> >> @@ -630,6 +684,44 @@ static int st_lsm6dsx_get_drdy_reg(struct st_lsm6dsx_hw *hw, u8 *drdy_reg)
>> >>       return err;
>> >>  }
>> >>
>> >> +static int st_lsm6dsx_init_hw_timer(struct st_lsm6dsx_hw *hw)
>> >> +{
>> >> +     const struct st_lsm6dsx_hw_ts_settings *ts_settings;
>> >> +     int err, val;
>> >> +
>> >> +     ts_settings = &hw->settings->ts_settings;
>> >> +     /* enable hw timestamp generation if necessary */
>> >> +     if (ts_settings->timer_en.addr) {
>> >> +             val = ST_LSM6DSX_SHIFT_VAL(1, ts_settings->timer_en.mask);
>> >> +             err = regmap_update_bits(hw->regmap,
>> >> +                                      ts_settings->timer_en.addr,
>> >> +                                      ts_settings->timer_en.mask, val);
>> >> +             if (err < 0)
>> >> +                     return err;
>> >> +     }
>> >> +
>> >> +     /* enable high resolution for hw ts timer if necessary */
>> >> +     if (ts_settings->hr_timer.addr) {
>> >> +             val = ST_LSM6DSX_SHIFT_VAL(1, ts_settings->hr_timer.mask);
>> >> +             err = regmap_update_bits(hw->regmap,
>> >> +                                      ts_settings->hr_timer.addr,
>> >> +                                      ts_settings->hr_timer.mask, val);
>> >> +             if (err < 0)
>> >> +                     return err;
>> >> +     }
>> >> +
>> >> +     /* enable ts queueing in FIFO if necessary */
>> >> +     if (ts_settings->fifo_en.addr) {
>> >> +             val = ST_LSM6DSX_SHIFT_VAL(1, ts_settings->fifo_en.mask);
>> >> +             err = regmap_update_bits(hw->regmap,
>> >> +                                      ts_settings->fifo_en.addr,
>> >> +                                      ts_settings->fifo_en.mask, val);
>> >> +             if (err < 0)
>> >> +                     return err;
>> >> +     }
>> >> +     return 0;
>> >> +}
>> >> +
>> >>  static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
>> >>  {
>> >>       u8 drdy_int_reg;
>> >> @@ -654,10 +746,14 @@ static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
>> >>       if (err < 0)
>> >>               return err;
>> >>
>> >> -     return regmap_update_bits(hw->regmap, drdy_int_reg,
>> >> -                               ST_LSM6DSX_REG_FIFO_FTH_IRQ_MASK,
>> >> -                               FIELD_PREP(ST_LSM6DSX_REG_FIFO_FTH_IRQ_MASK,
>> >> -                                          1));
>> >> +     err = regmap_update_bits(hw->regmap, drdy_int_reg,
>> >> +                              ST_LSM6DSX_REG_FIFO_FTH_IRQ_MASK,
>> >> +                              FIELD_PREP(ST_LSM6DSX_REG_FIFO_FTH_IRQ_MASK,
>> >> +                                         1));
>> >> +     if (err < 0)
>> >> +             return err;
>> >> +
>> >> +     return st_lsm6dsx_init_hw_timer(hw);
>> >>  }
>> >>
>> >>  static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
>> >
>
