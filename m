Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40396 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752533AbbLBSon (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 2 Dec 2015 13:44:43 -0500
Subject: Re: [PATCH v2 1/1] iio: chemical: vz89x: rework i2c transfer reading
To: Matt Ranostay <mranostay@gmail.com>
References: <1448557874-3812-1-git-send-email-mranostay@gmail.com>
 <1448557874-3812-2-git-send-email-mranostay@gmail.com>
 <565B0B41.3080203@kernel.org>
 <CAKzfze-O_hgnVzLsD7q5SP_aua2RHSVxZy_Vq+NkGVeJ1WwewQ@mail.gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <565F3C18.7040502@kernel.org>
Date: Wed, 2 Dec 2015 18:44:40 +0000
MIME-Version: 1.0
In-Reply-To: <CAKzfze-O_hgnVzLsD7q5SP_aua2RHSVxZy_Vq+NkGVeJ1WwewQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/12/15 04:59, Matt Ranostay wrote:
> I just noticed... "  return (ret == VZ89X_REG_MEASUREMENT_SIZE) ? 0 :
> ret;"  which is wrong it should be the count of the messages
> executed....
> 
> I need to see why this passed my testing :/
As I'd only rebased a few mins ago and I doubt anyone pulled my tree
in the meantime I did a bit of history editing and removed the original
patch.  Generally however, once a patch has been applied, I'd
be looking for follow up additional patches rather than a new
version of the original patch.

Will deal with the new version at the weekend as this was just
a flying visit to deal with merge issues.

Jonathan
> 
> On Sun, Nov 29, 2015 at 6:27 AM, Jonathan Cameron <jic23@kernel.org> wrote:
>> On 26/11/15 17:11, Matt Ranostay wrote:
>>> Add an optimized i2c transfer reading function, and fallback
>>> to racey smbus transfers if client->adapter doesn't support this.
>>>
>>> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
>> Few comments inline but nothing that stops me applying this.
>>
>> Applied to the togreg branch of iio.git - initially pushed out as testing.
>> Note this branch will rebase soonish so don't base anything much on it!
>>
>> Jonathan
>>> ---
>>>  drivers/iio/chemical/vz89x.c | 66 ++++++++++++++++++++++++++++++++++----------
>>>  1 file changed, 52 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/drivers/iio/chemical/vz89x.c b/drivers/iio/chemical/vz89x.c
>>> index 11e59a5..c3367aa 100644
>>> --- a/drivers/iio/chemical/vz89x.c
>>> +++ b/drivers/iio/chemical/vz89x.c
>>> @@ -34,8 +34,9 @@
>>>  struct vz89x_data {
>>>       struct i2c_client *client;
>>>       struct mutex lock;
>>> -     unsigned long last_update;
>>> +     int (*xfer)(struct vz89x_data *data, u8 cmd);
>>>
>>> +     unsigned long last_update;
>>>       u8 buffer[VZ89X_REG_MEASUREMENT_SIZE];
>>>  };
>>>
>>> @@ -100,27 +101,60 @@ static int vz89x_measurement_is_valid(struct vz89x_data *data)
>>>       return !!(data->buffer[VZ89X_REG_MEASUREMENT_SIZE - 1] > 0);
>>>  }
>>>
>>> -static int vz89x_get_measurement(struct vz89x_data *data)
>>> +static int vz89x_i2c_xfer(struct vz89x_data *data, u8 cmd)
>>>  {
>>> +     struct i2c_client *client = data->client;
>>> +     struct i2c_msg msg[2];
>>>       int ret;
>>> -     int i;
>>> +     u8 buf[3] = { cmd, 0, 0};
>>>
>>> -     /* sensor can only be polled once a second max per datasheet */
>>> -     if (!time_after(jiffies, data->last_update + HZ))
>>> -             return 0;
>>> +     msg[0].addr = client->addr;
>>> +     msg[0].flags = client->flags;
>>> +     msg[0].len = 3;
>>> +     msg[0].buf  = (char *) &buf;
>>> +
>>> +     msg[1].addr = client->addr;
>>> +     msg[1].flags = client->flags | I2C_M_RD;
>>> +     msg[1].len = VZ89X_REG_MEASUREMENT_SIZE;
>>> +     msg[1].buf = (char *) &data->buffer;
>>> +
>>> +     ret = i2c_transfer(client->adapter, msg, 2);
>>>
>>> -     ret = i2c_smbus_write_word_data(data->client,
>>> -                                     VZ89X_REG_MEASUREMENT, 0);
>>> +     return (ret == VZ89X_REG_MEASUREMENT_SIZE) ? 0 : ret;
>>> +}
>>> +
>>> +static int vz89x_smbus_xfer(struct vz89x_data *data, u8 cmd)
>>> +{
>>> +     struct i2c_client *client = data->client;
>> I wouldn't have bothered with the local variable, but it's just
>> a matter of personal taste so lets leave it be!
>>
>>> +     int ret;
>>> +     int i;
>>> +
>>> +     ret = i2c_smbus_write_word_data(client, cmd, 0);
>>>       if (ret < 0)
>>>               return ret;
>>>
>>>       for (i = 0; i < VZ89X_REG_MEASUREMENT_SIZE; i++) {
>>> -             ret = i2c_smbus_read_byte(data->client);
>>> +             ret = i2c_smbus_read_byte(client);
>>>               if (ret < 0)
>>>                       return ret;
>>>               data->buffer[i] = ret;
>>>       }
>>>
>>> +     return 0;
>>> +}
>>> +
>>> +static int vz89x_get_measurement(struct vz89x_data *data)
>>> +{
>>> +     int ret;
>>> +
>>> +     /* sensor can only be polled once a second max per datasheet */
>>> +     if (!time_after(jiffies, data->last_update + HZ))
>>> +             return 0;
>>> +
>>> +     ret = data->xfer(data, VZ89X_REG_MEASUREMENT);
>>> +     if (ret < 0)
>>> +             return ret;
>>> +
>>>       ret = vz89x_measurement_is_valid(data);
>>>       if (ret)
>>>               return -EAGAIN;
>>> @@ -204,15 +238,19 @@ static int vz89x_probe(struct i2c_client *client,
>>>       struct iio_dev *indio_dev;
>>>       struct vz89x_data *data;
>>>
>>> -     if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA |
>>> -                                  I2C_FUNC_SMBUS_BYTE))
>>> -             return -ENODEV;
>>> -
>>>       indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>>>       if (!indio_dev)
>>>               return -ENOMEM;
>>> -
>> THis is a random white space change that snuck in - hardly crucial but would
>> have been cleaner if this hadn't been in the patch.
>>>       data = iio_priv(indio_dev);
>>> +
>>> +     if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
>>> +             data->xfer = vz89x_i2c_xfer;
>>> +     else if (i2c_check_functionality(client->adapter,
>>> +                             I2C_FUNC_SMBUS_WORD_DATA | I2C_FUNC_SMBUS_BYTE))
>>> +             data->xfer = vz89x_smbus_xfer;
>>> +     else
>>> +             return -ENOTSUPP;
>>> +
>>>       i2c_set_clientdata(client, indio_dev);
>>>       data->client = client;
>>>       data->last_update = jiffies - HZ;
>>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

