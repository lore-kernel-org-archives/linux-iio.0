Return-Path: <SRS0=6FAb=H2=electromag.com.au=rtresidd@kernel.org>
Subject: Re: [PATCH] iio: magnetometer: mag3110: Add ability to run in
 continuous mode
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
References: <cc70f548-7c42-25a3-e908-b24ed8156c69@electromag.com.au>
 <f9675638-e5d4-481e-6061-a678f5325cec@electromag.com.au>
 <20180506174527.69bc8fb0@archlinux>
From: Richard Tresidder <rtresidd@electromag.com.au>
Message-ID: <a63db232-8cbc-e9aa-cc8d-4dd5458f9037@electromag.com.au>
Date: Mon, 7 May 2018 10:37:34 +0800
MIME-Version: 1.0
In-Reply-To: <20180506174527.69bc8fb0@archlinux>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 7/05/2018 12:45 AM, Jonathan Cameron wrote:

> On Mon, 30 Apr 2018 17:53:54 +0800
> Richard Tresidder <rtresidd@electromag.com.au> wrote:
>
>> Hi
>> Again sorry had maintainer wrong...
> If that happens, don't resend, just reply ccing the maintainer.
> Sometimes the maintainer may then ask you to resend.  Right now all
> I got was a cryptic mess of patches when they turned up in my email
> client.

Noted, wasn't sure of the procedure.

And sorry about the tab issue, seems Thunderbird even though I told it 'Text only', reformats stuff unless you change the

the paragraph style from 'Body Text' to 'Preformat' which I wasn't aware of. :(

>
> Note, when a patch is applied all the text above the --- goes into
> the commit log for ever more.  Hence any side comments like this should
> be below the --- cut line.  That is also where version change logs etc
> belong.

Thanks, I'll limit comments above the first --- cut line and stick general rambling comments in the change log area.

> Also this has nothing to do with your other patch (at least they should
> not be in the same series.)  If you didn't want to put them in a single
> series then it should have numbered patches and a cover letter.
> As it is, we just have the two different sets overlapping because
> you sent the second one as a reply.

Yep sorry was just trying to inform that some of the code additions were sourced from the other driver (prior work), probably not relevant.

>
>>    This patch adds the ability to run the Mag3110 in continuous mode to
>> speed up the sampling rate.
>> Depending on the sampling rate requested the device can be put in or out
>> of continuous mode automatically.
>> Shifting out of continuous mode requires a potential 1 / ODR wait which
>> is also implemented
>> This part is largely based on the mma8542 driver implementation.
>>
>> Also modified the sleep method when data is not ready to allow for
>> sampling > 50sps to work.
>> This is similar to my other recent patch regarding the mma8452 driver.
>>
>> Have tested upto 80sps using hr timer and iio buffer
>>
>> Signed-off-by: Richard Tresidder <rtresidd@electromag.com.au>
> Again, I think the fundamental change is good, but as you suggested
> in the other patch, you should be sticking to just that change
> not a mixture of 'tidy' ups and the real change.

Ok wasn't sure re the tidy up stuff, as about half the patch sets I read through did a mix.

I'll remove all the white space changes and resubmit as v2 patch

Will look at logs and cc recent reviewers and submitters.

Will then do a separate cleanup patch.

Thanks

   Richard

>
> Thanks,
>
> Jonathan
>> ---
>> diff --git a/drivers/iio/magnetometer/mag3110.c
>> b/drivers/iio/magnetometer/mag3110.c
>> index b34ace7..7cdd185 100644
>> --- a/drivers/iio/magnetometer/mag3110.c
>> +++ b/drivers/iio/magnetometer/mag3110.c
>> @@ -26,6 +26,7 @@
>>  #define MAG3110_OUT_Y 0x03
>>  #define MAG3110_OUT_Z 0x05
>>  #define MAG3110_WHO_AM_I 0x07
>> +#define MAG3110_SYSMOD 0x08
>>  #define MAG3110_OFF_X 0x09 /* MSB first */
>>  #define MAG3110_OFF_Y 0x0b
>>  #define MAG3110_OFF_Z 0x0d
>> @@ -39,6 +40,8 @@
>>  #define MAG3110_CTRL_DR_SHIFT 5
>>  #define MAG3110_CTRL_DR_DEFAULT 0
>>  
>> +#define MAG3110_SYSMOD_MODE_MASK (BIT(1) | BIT(0))
> GENMASK not combination of two individual bits.  That would
> have been fine if they had independent uses but they don't so
> this needs fixing.
>
>> +
>>  #define MAG3110_CTRL_TM BIT(1) /* trigger single measurement */
>>  #define MAG3110_CTRL_AC BIT(0) /* continuous measurements */
>>  
>> @@ -52,26 +55,35 @@ struct mag3110_data {
>>      struct i2c_client *client;
>>      struct mutex lock;
>>      u8 ctrl_reg1;
>> +    int sleep_val;
>>  };
>>  
>>  static int mag3110_request(struct mag3110_data *data)
>>  {
>>      int ret, tries = 150;
>>  
>> -    /* trigger measurement */
>> -    ret = i2c_smbus_write_byte_data(data->client, MAG3110_CTRL_REG1,
>> -        data->ctrl_reg1 | MAG3110_CTRL_TM);
>> -    if (ret < 0)
>> -        return ret;
>> +    if ((data->ctrl_reg1 & MAG3110_CTRL_AC) == 0) {
>> +        /* trigger measurement */
>> +        ret = i2c_smbus_write_byte_data(data->client, MAG3110_CTRL_REG1,
>> +            data->ctrl_reg1 | MAG3110_CTRL_TM);
>> +        if (ret < 0)
>> +            return ret;
>> +    }
>>  
>>      while (tries-- > 0) {
>>          ret = i2c_smbus_read_byte_data(data->client, MAG3110_STATUS);
>> -        if (ret < 0)
>> +        if (ret < 0) {
>> +            dev_err(&data->client->dev, "i2c error\n");
> Don't introduce new error messages into existing code paths.  Definitely
> don't do it in a patch making more substantial changes elsewhere.
> It just distracts from the important stuff.
>
>
>>              return ret;
>> +        }
>>          /* wait for data ready */
>>          if ((ret & MAG3110_STATUS_DRDY) == MAG3110_STATUS_DRDY)
>>              break;
>> -        msleep(20);
>> +
>> +        if (data->sleep_val <= 20)
>> +            usleep_range(data->sleep_val * 250, data->sleep_val * 500);
>> +        else
>> +            msleep(20);
>>      }
>>  
>>      if (tries < 0) {
>> @@ -100,7 +112,7 @@ static int mag3110_read(struct mag3110_data *data,
>> __be16 buf[3])
>>  }
>>  
>>  static ssize_t mag3110_show_int_plus_micros(char *buf,
>> -    const int (*vals)[2], int n)
>> +                        const int (*vals)[2], int n)
>>  {
>>      size_t len = 0;
>>  
>> @@ -115,7 +127,7 @@ static ssize_t mag3110_show_int_plus_micros(char *buf,
>>  }
>>  
>>  static int mag3110_get_int_plus_micros_index(const int (*vals)[2], int n,
>> -                    int val, int val2)
>> +                         int val, int val2)
>>  {
>>      while (n-- > 0)
>>          if (val == vals[n][0] && val2 == vals[n][1])
>> @@ -130,7 +142,8 @@ static int mag3110_get_int_plus_micros_index(const
>> int (*vals)[2], int n,
>>  };
>>  
>>  static ssize_t mag3110_show_samp_freq_avail(struct device *dev,
>> -                struct device_attribute *attr, char *buf)
>> +                        struct device_attribute *attr,
>> +                        char *buf)
> Not in this patch same for any more of these above this point.
>
>>  {
>>      return mag3110_show_int_plus_micros(buf, mag3110_samp_freq, 8);
>>  }
>> @@ -138,12 +151,118 @@ static ssize_t
>> mag3110_show_samp_freq_avail(struct device *dev,
>>  static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(mag3110_show_samp_freq_avail);
>>  
>>  static int mag3110_get_samp_freq_index(struct mag3110_data *data,
>> -    int val, int val2)
>> +                       int val, int val2)
> This sort of tidy up doesn't not belong in any patch making a functional
> change.
>
>>  {
>>      return mag3110_get_int_plus_micros_index(mag3110_samp_freq, 8, val,
>>          val2);
>>  }
>>  
>> +static int mag3110_calculate_sleep(struct mag3110_data *data)
>> +{
>> +    int ret, i = data->ctrl_reg1 >> MAG3110_CTRL_DR_SHIFT;
>> +
>> +    if(mag3110_samp_freq[i][0] > 0)
>> +        ret = 1000 / mag3110_samp_freq[i][0];
>> +    else
>> +        ret = 1000;
>> +
>> +    return ret == 0 ? 1 : ret;
>> +}
>> +
>> +static int mag3110_standby(struct mag3110_data *data)
>> +{
>> +    return i2c_smbus_write_byte_data(data->client, MAG3110_CTRL_REG1,
>> +                     data->ctrl_reg1 & ~MAG3110_CTRL_AC);
>> +}
>> +
>> +static int mag3110_wait_standby(struct mag3110_data *data)
>> +{
>> +    int ret, tries = 30;
>> +
>> +    /* Takes up to 1/ODR to come out of active mode into stby
>> +         Longest expected period is 12.5seconds. We'll sleep for 500ms
>> between checks*/
> Please run checkpatch.pl over your patches.  I expect it will complain
> about this comment.  Coding style is very rigorous in the kernel and
> this isn't how we do multiline comments.
>
>> +    while (tries-- > 0) {
>> +        ret = i2c_smbus_read_byte_data(data->client, MAG3110_SYSMOD);
>> +        if (ret < 0) {
>> +            dev_err(&data->client->dev, "i2c error\n");
>> +            return ret;
>> +        }
>> +        /* wait for standby */
>> +        if ((ret & MAG3110_SYSMOD_MODE_MASK) == 0)
>> +            break;
>> +      
>> +        msleep_interruptible(500);
>> +    }
>> +
>> +    if (tries < 0) {
>> +        dev_err(&data->client->dev, "device not entering standby mode\n");
>> +        return -EIO;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int mag3110_active(struct mag3110_data *data)
>> +{
>> +    return i2c_smbus_write_byte_data(data->client, MAG3110_CTRL_REG1,
>> +                     data->ctrl_reg1);
> This little wrapper doesn't add anything - if anything it makes
> it a little harder to review as the reviewer has to come find it to
> see what the call is doing.
>
> Just put the i2c write inline where you are currently calling this
> function.
>
>> +}
>> +
>> +/* returns >0 if active, 0 if in standby and <0 on error */
>> +static int mag3110_is_active(struct mag3110_data *data)
>> +{
>> +    int reg;
>> +
>> +    reg = i2c_smbus_read_byte_data(data->client, MAG3110_CTRL_REG1);
>> +    if (reg < 0)
>> +        return reg;
>> +
>> +    return reg & MAG3110_CTRL_AC;
>> +}
>> +
>> +static int mag3110_change_config(struct mag3110_data *data, u8 reg, u8 val)
>> +{
>> +    int ret;
>> +    int is_active;
>> +
>> +    mutex_lock(&data->lock);
>> +
>> +    is_active = mag3110_is_active(data);
>> +    if (is_active < 0) {
>> +        ret = is_active;
>> +        goto fail;
>> +    }
>> +
>> +    /* config can only be changed when in standby */
>> +    if (is_active > 0) {
>> +        ret = mag3110_standby(data);
>> +        if (ret < 0)
>> +            goto fail;
>> +    }
>> +
>> +    /* After coming out of active we must wait for the part to
>> transition to STBY
>> +       This can take up to 1 /ODR to occur */
> Wrong comment style.
>
>> +    ret = mag3110_wait_standby(data);
>> +    if (ret < 0)
>> +        goto fail;
>> +
>> +    ret = i2c_smbus_write_byte_data(data->client, reg, val);
>> +    if (ret < 0)
>> +        goto fail;
>> +
>> +    if (is_active > 0) {
>> +        ret = mag3110_active(data);
>> +        if (ret < 0)
>> +            goto fail;
>> +    }
>> +
>> +    ret = 0;
>> +fail:
>> +    mutex_unlock(&data->lock);
>> +
>> +    return ret;
>> +}
>> +
>>  static int mag3110_read_raw(struct iio_dev *indio_dev,
>>                  struct iio_chan_spec const *chan,
>>                  int *val, int *val2, long mask)
>> @@ -235,11 +354,13 @@ static int mag3110_write_raw(struct iio_dev
>> *indio_dev,
>>              ret = -EINVAL;
>>              break;
>>          }
>> -
> Clean out any unrelated white space changes.
>
>> -        data->ctrl_reg1 &= ~MAG3110_CTRL_DR_MASK;
>> +        data->ctrl_reg1 &= ~MAG3110_CTRL_DR_MASK & ~MAG3110_CTRL_AC;
>>          data->ctrl_reg1 |= rate << MAG3110_CTRL_DR_SHIFT;
>> -        ret = i2c_smbus_write_byte_data(data->client,
>> -            MAG3110_CTRL_REG1, data->ctrl_reg1);
>> +        data->sleep_val = mag3110_calculate_sleep(data);
>> +        if (data->sleep_val < 40)
> Why 40?
>
>> +            data->ctrl_reg1 |= MAG3110_CTRL_AC;
>> +
>> +        ret = mag3110_change_config(data, MAG3110_CTRL_REG1,
>> data->ctrl_reg1);
>>          break;
>>      case IIO_CHAN_INFO_CALIBBIAS:
>>          if (val < -10000 || val > 10000) {
>> @@ -337,12 +458,6 @@ static irqreturn_t mag3110_trigger_handler(int irq,
>> void *p)
>>  
>>  static const unsigned long mag3110_scan_masks[] = {0x7, 0xf, 0};
>>  
>> -static int mag3110_standby(struct mag3110_data *data)
>> -{
>> -    return i2c_smbus_write_byte_data(data->client, MAG3110_CTRL_REG1,
>> -        data->ctrl_reg1 & ~MAG3110_CTRL_AC);
>> -}
>> -
>>  static int mag3110_probe(struct i2c_client *client,
>>               const struct i2c_device_id *id)
>>  {
>> @@ -374,8 +489,11 @@ static int mag3110_probe(struct i2c_client *client,
>>      indio_dev->available_scan_masks = mag3110_scan_masks;
>>  
>>      data->ctrl_reg1 = MAG3110_CTRL_DR_DEFAULT << MAG3110_CTRL_DR_SHIFT;
>> -    ret = i2c_smbus_write_byte_data(client, MAG3110_CTRL_REG1,
>> -        data->ctrl_reg1);
>> +    data->sleep_val = mag3110_calculate_sleep(data);
>> +    if (data->sleep_val < 40)
>> +        data->ctrl_reg1 |= MAG3110_CTRL_AC;
>> +
>> +    ret = mag3110_change_config(data, MAG3110_CTRL_REG1, data->ctrl_reg1);
>>      if (ret < 0)
>>          return ret;
>>  
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
