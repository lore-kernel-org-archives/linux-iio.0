Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43995 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbbFUNqY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 21 Jun 2015 09:46:24 -0400
Message-ID: <5586C02E.9000707@kernel.org>
Date: Sun, 21 Jun 2015 14:46:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Octavian Purdila <octavian.purdila@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Laurentiu Palcu <laurentiu.palcu@intel.com>
Subject: Re: [PATCH 3/3] iio:accel:bmc150-accel: code style cleanup
References: <cover.1434404216.git.knaack.h@gmx.de>	<47a7945cfd22c443f3340e8ccda06d7cef1827ba.1434404216.git.knaack.h@gmx.de> <CAE1zotLygO2jgYE3GBip6MP5KrObzKPJ1jn6fy_f_+tjkz7+SQ@mail.gmail.com>
In-Reply-To: <CAE1zotLygO2jgYE3GBip6MP5KrObzKPJ1jn6fy_f_+tjkz7+SQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/06/15 11:33, Octavian Purdila wrote:
> On Tue, Jun 16, 2015 at 12:48 AM, Hartmut Knaack <knaack.h@gmx.de> wrote:
>> Apply the following coding style changes as indicated by checkpatch.pl in
>> strict mode:
>>   - Please don't use multiple blank lines
>>   - braces {} should be used on all arms of this statement (if/else)
>>   - Alignment should match open parenthesis
>>   - Please don't use multiple blank lines
>>   - Blank lines aren't necessary after an open brace '{'
>>   - Missing a blank line after declarations
>>   - No space is necessary after a cast
>>
>> Also wrap/consolidate error messages to fit 80 characters per line and
>> rework a comment.
>>
>> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
> 
> Reviewed-by: Octavian Purdila <octavian.purdila@intel.com>
Applied to the togreg branch of iio.git, initially pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan
> 
>> ---
>>  drivers/iio/accel/bmc150-accel.c | 91 +++++++++++++++++++++-------------------
>>  1 file changed, 49 insertions(+), 42 deletions(-)
>>
>> diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
>> index 36a9cd5..e84e2a1 100644
>> --- a/drivers/iio/accel/bmc150-accel.c
>> +++ b/drivers/iio/accel/bmc150-accel.c
>> @@ -241,7 +241,6 @@ static const struct {
>>                                        {500000, BMC150_ACCEL_SLEEP_500_MS},
>>                                        {1000000, BMC150_ACCEL_SLEEP_1_SEC} };
>>
>> -
>>  static int bmc150_accel_set_mode(struct bmc150_accel_data *data,
>>                                  enum bmc150_power_modes mode,
>>                                  int dur_us)
>> @@ -259,8 +258,9 @@ static int bmc150_accel_set_mode(struct bmc150_accel_data *data,
>>                                 dur_val =
>>                                 bmc150_accel_sleep_value_table[i].reg_value;
>>                 }
>> -       } else
>> +       } else {
>>                 dur_val = 0;
>> +       }
>>
>>         if (dur_val < 0)
>>                 return -EINVAL;
>> @@ -288,7 +288,7 @@ static int bmc150_accel_set_bw(struct bmc150_accel_data *data, int val,
>>
>>         for (i = 0; i < ARRAY_SIZE(bmc150_accel_samp_freq_table); ++i) {
>>                 if (bmc150_accel_samp_freq_table[i].val == val &&
>> -                               bmc150_accel_samp_freq_table[i].val2 == val2) {
>> +                   bmc150_accel_samp_freq_table[i].val2 == val2) {
>>                         ret = i2c_smbus_write_byte_data(
>>                                 data->client,
>>                                 BMC150_ACCEL_REG_PMU_BW,
>> @@ -351,8 +351,7 @@ static int bmc150_accel_chip_init(struct bmc150_accel_data *data)
>>
>>         ret = i2c_smbus_read_byte_data(data->client, BMC150_ACCEL_REG_CHIP_ID);
>>         if (ret < 0) {
>> -               dev_err(&data->client->dev,
>> -                       "Error: Reading chip id\n");
>> +               dev_err(&data->client->dev, "Error: Reading chip id\n");
>>                 return ret;
>>         }
>>
>> @@ -376,8 +375,7 @@ static int bmc150_accel_chip_init(struct bmc150_accel_data *data)
>>                                         BMC150_ACCEL_REG_PMU_RANGE,
>>                                         BMC150_ACCEL_DEF_RANGE_4G);
>>         if (ret < 0) {
>> -               dev_err(&data->client->dev,
>> -                                       "Error writing reg_pmu_range\n");
>> +               dev_err(&data->client->dev, "Error writing reg_pmu_range\n");
>>                 return ret;
>>         }
>>
>> @@ -437,12 +435,13 @@ static int bmc150_accel_set_power_state(struct bmc150_accel_data *data, bool on)
>>  {
>>         int ret;
>>
>> -       if (on)
>> +       if (on) {
>>                 ret = pm_runtime_get_sync(&data->client->dev);
>> -       else {
>> +       } else {
>>                 pm_runtime_mark_last_busy(&data->client->dev);
>>                 ret = pm_runtime_put_autosuspend(&data->client->dev);
>>         }
>> +
>>         if (ret < 0) {
>>                 dev_err(&data->client->dev,
>>                         "Failed: bmc150_accel_set_power_state for %d\n", on);
>> @@ -514,13 +513,13 @@ static int bmc150_accel_set_interrupt(struct bmc150_accel_data *data, int i,
>>         }
>>
>>         /*
>> -        * We will expect the enable and disable to do operation in
>> -        * in reverse order. This will happen here anyway as our
>> -        * resume operation uses sync mode runtime pm calls, the
>> -        * suspend operation will be delayed by autosuspend delay
>> -        * So the disable operation will still happen in reverse of
>> -        * enable operation. When runtime pm is disabled the mode
>> -        * is always on so sequence doesn't matter
>> +        * We will expect the enable and disable to do operation in reverse
>> +        * order. This will happen here anyway, as our resume operation uses
>> +        * sync mode runtime pm calls. The suspend operation will be delayed
>> +        * by autosuspend delay.
>> +        * So the disable operation will still happen in reverse order of
>> +        * enable operation. When runtime pm is disabled the mode is always on,
>> +        * so sequence doesn't matter.
>>          */
>>         ret = bmc150_accel_set_power_state(data, state);
>>         if (ret < 0)
>> @@ -574,7 +573,6 @@ out_fix_power_state:
>>         return ret;
>>  }
>>
>> -
>>  static int bmc150_accel_set_scale(struct bmc150_accel_data *data, int val)
>>  {
>>         int ret, i;
>> @@ -674,8 +672,9 @@ static int bmc150_accel_read_raw(struct iio_dev *indio_dev,
>>                 if (chan->type == IIO_TEMP) {
>>                         *val = BMC150_ACCEL_TEMP_CENTER_VAL;
>>                         return IIO_VAL_INT;
>> -               } else
>> +               } else {
>>                         return -EINVAL;
>> +               }
>>         case IIO_CHAN_INFO_SCALE:
>>                 *val = 0;
>>                 switch (chan->type) {
>> @@ -793,7 +792,6 @@ static int bmc150_accel_read_event_config(struct iio_dev *indio_dev,
>>                                           enum iio_event_type type,
>>                                           enum iio_event_direction dir)
>>  {
>> -
>>         struct bmc150_accel_data *data = iio_priv(indio_dev);
>>
>>         return data->ev_enable_state;
>> @@ -827,7 +825,7 @@ static int bmc150_accel_write_event_config(struct iio_dev *indio_dev,
>>  }
>>
>>  static int bmc150_accel_validate_trigger(struct iio_dev *indio_dev,
>> -                                  struct iio_trigger *trig)
>> +                                        struct iio_trigger *trig)
>>  {
>>         struct bmc150_accel_data *data = iio_priv(indio_dev);
>>         int i;
>> @@ -963,6 +961,7 @@ static int __bmc150_accel_fifo_flush(struct iio_dev *indio_dev,
>>         u16 buffer[BMC150_ACCEL_FIFO_LENGTH * 3];
>>         int64_t tstamp;
>>         uint64_t sample_period;
>> +
>>         ret = i2c_smbus_read_byte_data(data->client,
>>                                        BMC150_ACCEL_REG_FIFO_STATUS);
>>         if (ret < 0) {
>> @@ -1255,7 +1254,7 @@ static int bmc150_accel_trig_try_reen(struct iio_trigger *trig)
>>  }
>>
>>  static int bmc150_accel_trigger_set_state(struct iio_trigger *trig,
>> -                                                  bool state)
>> +                                         bool state)
>>  {
>>         struct bmc150_accel_trigger *t = iio_trigger_get_drvdata(trig);
>>         struct bmc150_accel_data *data = t->data;
>> @@ -1314,26 +1313,32 @@ static int bmc150_accel_handle_roc_event(struct iio_dev *indio_dev)
>>                 dir = IIO_EV_DIR_RISING;
>>
>>         if (ret & BMC150_ACCEL_ANY_MOTION_BIT_X)
>> -               iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_ACCEL,
>> -                                                       0,
>> -                                                       IIO_MOD_X,
>> -                                                       IIO_EV_TYPE_ROC,
>> -                                                       dir),
>> -                                                       data->timestamp);
>> +               iio_push_event(indio_dev,
>> +                              IIO_MOD_EVENT_CODE(IIO_ACCEL,
>> +                                                 0,
>> +                                                 IIO_MOD_X,
>> +                                                 IIO_EV_TYPE_ROC,
>> +                                                 dir),
>> +                              data->timestamp);
>> +
>>         if (ret & BMC150_ACCEL_ANY_MOTION_BIT_Y)
>> -               iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_ACCEL,
>> -                                                       0,
>> -                                                       IIO_MOD_Y,
>> -                                                       IIO_EV_TYPE_ROC,
>> -                                                       dir),
>> -                                                       data->timestamp);
>> +               iio_push_event(indio_dev,
>> +                              IIO_MOD_EVENT_CODE(IIO_ACCEL,
>> +                                                 0,
>> +                                                 IIO_MOD_Y,
>> +                                                 IIO_EV_TYPE_ROC,
>> +                                                 dir),
>> +                              data->timestamp);
>> +
>>         if (ret & BMC150_ACCEL_ANY_MOTION_BIT_Z)
>> -               iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_ACCEL,
>> -                                                       0,
>> -                                                       IIO_MOD_Z,
>> -                                                       IIO_EV_TYPE_ROC,
>> -                                                       dir),
>> -                                                       data->timestamp);
>> +               iio_push_event(indio_dev,
>> +                              IIO_MOD_EVENT_CODE(IIO_ACCEL,
>> +                                                 0,
>> +                                                 IIO_MOD_Z,
>> +                                                 IIO_EV_TYPE_ROC,
>> +                                                 dir),
>> +                              data->timestamp);
>> +
>>         return ret;
>>  }
>>
>> @@ -1365,7 +1370,9 @@ static irqreturn_t bmc150_accel_irq_thread_handler(int irq, void *private)
>>                                         BMC150_ACCEL_INT_MODE_LATCH_INT |
>>                                         BMC150_ACCEL_INT_MODE_LATCH_RESET);
>>                 if (ret)
>> -                       dev_err(&data->client->dev, "Error writing reg_int_rst_latch\n");
>> +                       dev_err(&data->client->dev,
>> +                               "Error writing reg_int_rst_latch\n");
>> +
>>                 ret = IRQ_HANDLED;
>>         } else {
>>                 ret = IRQ_NONE;
>> @@ -1412,13 +1419,13 @@ static const char *bmc150_accel_match_acpi_device(struct device *dev, int *data)
>>         if (!id)
>>                 return NULL;
>>
>> -       *data = (int) id->driver_data;
>> +       *data = (int)id->driver_data;
>>
>>         return dev_name(dev);
>>  }
>>
>>  static int bmc150_accel_gpio_probe(struct i2c_client *client,
>> -                                       struct bmc150_accel_data *data)
>> +                                  struct bmc150_accel_data *data)
>>  {
>>         struct device *dev;
>>         struct gpio_desc *gpio;
>> --
>> 2.3.6
>>

--
To unsubscribe from this list: send the line "unsubscribe linux-iio" in
