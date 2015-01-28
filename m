Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:62765 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756824AbbA1UXa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 28 Jan 2015 15:23:30 -0500
Received: by mail-wi0-f174.google.com with SMTP id n3so14743993wiv.1
        for <linux-iio@vger.kernel.org>; Wed, 28 Jan 2015 12:23:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <54A97375.8090606@kernel.org>
References: <1419122556-8100-1-git-send-email-octavian.purdila@intel.com>
	<1419122556-8100-12-git-send-email-octavian.purdila@intel.com>
	<54A97375.8090606@kernel.org>
Date: Wed, 28 Jan 2015 21:26:05 +0200
Message-ID: <CAE1zot+7NPJGDcNFHnPofWZUt=_q9_q__N8BpXgo3G6fUbzjOQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] iio: bmc150: add support for hardware fifo
From: Octavian Purdila <octavian.purdila@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Jan 4, 2015 at 7:08 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 21/12/14 00:42, Octavian Purdila wrote:
>> Add a new watermark trigger and hardware fifo operations. When the
>> watermark trigger is activated the watermark level is set and the
>> hardware FIFO is activated.
>>
>> Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
> Mostly good, though I spot a demux in here that definitely shouldn't
> be there and connected access to indio_dev->buffer->scan_mask which is
> very dangerous as it may well not be the same as indio_dev->active_scan_mask
> (which is what controls which data is captured).
>
> This is also true of the original driver trigger handler and a number of
> other drivers.  Ooops, I've not been picking up on that in reviews recently
> by the look of it.
>
> If anyone is feeling bored a quick grep highlights the buggy drivers...
> If not I'll get to it, but isn't that critical as right now, no mainline
> driver is using the interface that will cause this issue.
>

Oh, ok, didn't know that we should use indio_dev->active_scan_mask
instead of indio_dev->buffer->scan_mask. I will take a closer look
after I am done reworking this patch set.

> Jonathan
>> ---
>>  drivers/iio/accel/bmc150-accel.c | 194 ++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 190 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
>> index 14509be..0aa3126 100644
>> --- a/drivers/iio/accel/bmc150-accel.c
>> +++ b/drivers/iio/accel/bmc150-accel.c
>> @@ -67,7 +67,9 @@
>>  #define BMC150_ACCEL_INT_MAP_0_BIT_SLOPE     BIT(2)
>>
>>  #define BMC150_ACCEL_REG_INT_MAP_1           0x1A
>> -#define BMC150_ACCEL_INT_MAP_1_BIT_DATA      BIT(0)
>> +#define BMC150_ACCEL_INT_MAP_1_BIT_DATA              BIT(0)
>> +#define BMC150_ACCEL_INT_MAP_1_BIT_FWM               BIT(1)
>> +#define BMC150_ACCEL_INT_MAP_1_BIT_FFULL     BIT(2)
>>
>>  #define BMC150_ACCEL_REG_INT_RST_LATCH               0x21
>>  #define BMC150_ACCEL_INT_MODE_LATCH_RESET    0x80
>> @@ -80,7 +82,9 @@
>>  #define BMC150_ACCEL_INT_EN_BIT_SLP_Z                BIT(2)
>>
>>  #define BMC150_ACCEL_REG_INT_EN_1            0x17
>> -#define BMC150_ACCEL_INT_EN_BIT_DATA_EN      BIT(4)
>> +#define BMC150_ACCEL_INT_EN_BIT_DATA_EN              BIT(4)
>> +#define BMC150_ACCEL_INT_EN_BIT_FFULL_EN     BIT(5)
>> +#define BMC150_ACCEL_INT_EN_BIT_FWM_EN               BIT(6)
>>
>>  #define BMC150_ACCEL_REG_INT_OUT_CTRL                0x20
>>  #define BMC150_ACCEL_INT_OUT_CTRL_INT1_LVL   BIT(0)
>> @@ -119,6 +123,12 @@
>>  #define BMC150_ACCEL_AXIS_TO_REG(axis)       (BMC150_ACCEL_REG_XOUT_L + (axis * 2))
>>  #define BMC150_AUTO_SUSPEND_DELAY_MS         2000
>>
>> +#define BMC150_ACCEL_REG_FIFO_STATUS         0x0E
>> +#define BMC150_ACCEL_REG_FIFO_CONFIG0                0x30
>> +#define BMC150_ACCEL_REG_FIFO_CONFIG1                0x3E
>> +#define BMC150_ACCEL_REG_FIFO_DATA           0x3F
>> +#define BMC150_ACCEL_FIFO_LENGTH             32
>> +
>>  enum bmc150_accel_axis {
>>       AXIS_X,
>>       AXIS_Y,
>> @@ -161,6 +171,7 @@ struct bmc150_accel_trigger {
>>       struct bmc150_accel_data *data;
>>       struct iio_trigger *indio_trig;
>>       bool enabled;
>> +     int (*setup)(struct bmc150_accel_trigger *t, bool state);
>>  };
>>
>>  struct bmc150_accel_event {
>> @@ -180,8 +191,8 @@ struct bmc150_accel_event {
>>       };
>>  };
>>
>> -#define BMC150_ACCEL_INTERRUPTS              2
>> -#define BMC150_ACCEL_TRIGGERS                2
>> +#define BMC150_ACCEL_INTERRUPTS              3
>> +#define BMC150_ACCEL_TRIGGERS                3
>>  #define BMC150_ACCEL_EVENTS          1
>>
>>  struct bmc150_accel_data {
>> @@ -191,6 +202,7 @@ struct bmc150_accel_data {
>>       struct bmc150_accel_trigger triggers[BMC150_ACCEL_TRIGGERS];
>>       struct bmc150_accel_event events[BMC150_ACCEL_EVENTS];
>>       struct mutex mutex;
>> +     u8 fifo_mode, watermark;
>>       s16 buffer[8];
>>       u8 bw_bits;
>>       u32 range;
>> @@ -484,6 +496,12 @@ bmc150_accel_interrupts[BMC150_ACCEL_INTERRUPTS] = {
>>                       BMC150_ACCEL_INT_EN_BIT_SLP_Y |
>>                       BMC150_ACCEL_INT_EN_BIT_SLP_Z
>>       },
>> +     { /* fifo watermark interrupt */
>> +             .map_reg = BMC150_ACCEL_REG_INT_MAP_1,
>> +             .map_bitmask = BMC150_ACCEL_INT_MAP_1_BIT_FWM,
>> +             .en_reg = BMC150_ACCEL_REG_INT_EN_1,
>> +             .en_bitmask = BMC150_ACCEL_INT_EN_BIT_FWM_EN,
>> +     },
>>  };
>>
>>  static void bmc150_accel_interrupts_setup(struct iio_dev *indio_dev,
>> @@ -1020,6 +1038,8 @@ static const struct iio_info bmc150_accel_info = {
>>       .driver_module          = THIS_MODULE,
>>  };
>>
>> +static int bmc150_accel_fifo_flush(struct iio_dev *indio_dev);
>> +
>>  static irqreturn_t bmc150_accel_trigger_handler(int irq, void *p)
>>  {
>>       struct iio_poll_func *pf = p;
>> @@ -1027,6 +1047,12 @@ static irqreturn_t bmc150_accel_trigger_handler(int irq, void *p)
>>       struct bmc150_accel_data *data = iio_priv(indio_dev);
>>       int bit, ret, i = 0;
>>
>> +     if (data->fifo_mode) {
>> +             bmc150_accel_fifo_flush(indio_dev);
> When you flush here, you want to get the best possible timestamp as close
> to the interrupt as possible.  Perhaps even in the top half interrupt
> handler - then pass it through to here...

Yes, we already take the timestamp in the IRQ handler
(bmc150_accel_data_rdy_trig_poll).

>> +
>> +     if (!data->timestamp)
>> +             data->timestamp = iio_get_time_ns();
> As this is on the flush rather than an interrupt these are going
> to be of dubious benefit... There isn't an obvious way of doing better though
> unless we do have an interrupt.  In that case you want to grab them as
> early as possible (typically even in the interrupt top half) and pass it
> down to where you want to use it.

Actually flush gets called from two places: from the watermark trigger
and in this case we take the timestamp in the IRQ handler, and when we
do a read or poll and there is not enough data available in the
buffer.

For this later case we will have an error of up to a maximum of a one
sample period since flush was called in between one of the sampling
periods - the watermark interrupt makes sure we don't stall forever.
That is not that bad.

Also, the later case should be an exception if the application sets
the right watermark level and uses the right timeout. Otherwise it
will not use power optimally which is the whole point of the hw fifo.

>> +
>> +     tstamp = data->timestamp - count * sample_freq;
>> +
>> +     for (i = 0; i < count; i++) {
>> +             u16 sample[8];
>> +             int j, bit;
>> +
>> +             j = 0;
>> +             for_each_set_bit(bit, indio_dev->buffer->scan_mask,
>> +                              indio_dev->masklength) {
>> +                     memcpy(&sample[j++], &buffer[i * 3 + bit], 2);
>> +             }
>
> A local demux rather than using the main iio one. Given you clearly read the
> lot anyway is there any reason not to just pass it all on and let the IIO
> demux handling the demux on the way to the kfifo?
>

Hmm, isn't the demux part only used when we have client buffers?  The
demux part is not used at all in my tests, due to
indio_dev->active_scan_mask being equal to buffer->scan_mask.

> There should be no access to the buffer scan_mask by drivers.
>
> They should only see the indio_dev->active_scan_mask (they may well not
> be the same due to client devices).
>

Right, after taking a closer look at the demux part I finally
understand it. I will fix it in the next version.

>> +
>> +             iio_push_to_buffers_with_timestamp(indio_dev, sample, tstamp);
>> +
>> +             tstamp += sample_freq;
>> +     }
>> +
>> +     data->timestamp = 0;
>> +
>> +     return 0;
>> +}
>> +
>> +static int bmc150_accel_fifo_mode_set(struct bmc150_accel_data *data)
>> +{
>> +     u8 reg = BMC150_ACCEL_REG_FIFO_CONFIG1;
>> +     int ret;
>> +
>> +     ret = i2c_smbus_read_byte_data(data->client, reg);
>> +
>> +     /* writting the fifo config discards FIFO data - avoid it if possible */
> Strikes me that caching the values of some registers would be a good idea
> - probably by using regmap to handle it.   Still a job for another day.
>I will keep this in mind.

Good point, I'll add this to my todo list.

>> +     if (ret == data->fifo_mode)
>> +             return 0;
>> +
>> +     ret = i2c_smbus_write_byte_data(data->client, reg, data->fifo_mode);
>> +     if (ret < 0) {
>> +             dev_err(&data->client->dev, "Error writing reg_fifo_config1\n");
>> +             return ret;
>> +     }
>> +
>> +     if (!data->fifo_mode)
>> +             return 0;
>> +
>> +     /* we can set the the watermark value only after FIFO is enabled */
>> +     ret = i2c_smbus_write_byte_data(data->client,
>> +                                     BMC150_ACCEL_REG_FIFO_CONFIG0,
>> +                                     data->watermark);
>> +
>> +     if (ret < 0)
>> +             dev_err(&data->client->dev, "Error writing reg_fifo_config0\n");
>> +
>> +     return ret;
>> +}
>> +
>> +static int bmc150_accel_fifo_setup(struct bmc150_accel_trigger *t, bool state)
>> +{
>> +     if (state)
> a #define for the magic 0x40 perhaps?
>> +             t->data->fifo_mode = 0x40;
>> +     else
>> +             t->data->fifo_mode = 0;
>> +
>> +     return bmc150_accel_fifo_mode_set(t->data);
>> +}
>> +
>> +const struct iio_hwfifo bmc150_accel_hwfifo = {
>> +     .length = BMC150_ACCEL_FIFO_LENGTH,
>> +     .set_watermark = bmc150_accel_set_watermark,
>> +     .flush = bmc150_accel_fifo_flush,
>> +};
>> +
>>  static int bmc150_accel_probe(struct i2c_client *client,
>>                             const struct i2c_device_id *id)
>>  {
>> @@ -1387,6 +1567,8 @@ static int bmc150_accel_probe(struct i2c_client *client,
>>                               "Failed: iio triggered buffer setup\n");
>>                       goto err_trigger_unregister;
>>               }
>> +
>> +             indio_dev->hwfifo = &bmc150_accel_hwfifo;
>>       }
>>
>>       ret = iio_device_register(indio_dev);
>> @@ -1458,6 +1640,7 @@ static int bmc150_accel_resume(struct device *dev)
>>       mutex_lock(&data->mutex);
>>       if (atomic_read(&data->active_intr))
>>               bmc150_accel_set_mode(data, BMC150_ACCEL_SLEEP_MODE_NORMAL, 0);
>> +     bmc150_accel_fifo_mode_set(data);
>>       mutex_unlock(&data->mutex);
>>
>>       return 0;
>> @@ -1487,6 +1670,9 @@ static int bmc150_accel_runtime_resume(struct device *dev)
>>       ret = bmc150_accel_set_mode(data, BMC150_ACCEL_SLEEP_MODE_NORMAL, 0);
>>       if (ret < 0)
>>               return ret;
>> +     ret = bmc150_accel_fifo_mode_set(data);
>> +     if (ret < 0)
>> +             return ret;
>>
>>       sleep_val = bmc150_accel_get_startup_times(data);
>>       if (sleep_val < 20)
>>
>
