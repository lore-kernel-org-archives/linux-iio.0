Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38322 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803Ab3HCQ5U (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 3 Aug 2013 12:57:20 -0400
Message-ID: <51FD4487.2090207@kernel.org>
Date: Sat, 03 Aug 2013 18:57:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Amit Kucheria <amit.kucheria@linaro.org>
CC: Sachin Kamat <sachin.kamat@linaro.org>, linux-iio@vger.kernel.org,
	jic23@cam.ac.uk
Subject: Re: [PATCH 6/6] iio: light: tsl2563: Use devm_* APIs
References: <1375173868-13235-1-git-send-email-sachin.kamat@linaro.org> <1375173868-13235-6-git-send-email-sachin.kamat@linaro.org> <CAP245DUw-U8N2QZFwesb9c8EcRbnwiBMtyA_avCiE++FwB9hCw@mail.gmail.com>
In-Reply-To: <CAP245DUw-U8N2QZFwesb9c8EcRbnwiBMtyA_avCiE++FwB9hCw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/30/13 10:07, Amit Kucheria wrote:
> On Tue, Jul 30, 2013 at 2:14 PM, Sachin Kamat <sachin.kamat@linaro.org> wrote:
>> devm_* APIs are device managed and make code simpler.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> Cc: Amit Kucheria <amit.kucheria@linaro.org>
> 
> Looks good. I don't have the device to test this on, though.
> 
> Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
> 
Applied to the togreg branch of iio.git

Thanks,
>> ---
>>  drivers/iio/light/tsl2563.c |   25 ++++++++-----------------
>>  1 file changed, 8 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/iio/light/tsl2563.c b/drivers/iio/light/tsl2563.c
>> index 1f529f3..ebb962c 100644
>> --- a/drivers/iio/light/tsl2563.c
>> +++ b/drivers/iio/light/tsl2563.c
>> @@ -702,7 +702,7 @@ static int tsl2563_probe(struct i2c_client *client,
>>         int err = 0;
>>         u8 id = 0;
>>
>> -       indio_dev = iio_device_alloc(sizeof(*chip));
>> +       indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
>>         if (!indio_dev)
>>                 return -ENOMEM;
>>
>> @@ -714,13 +714,13 @@ static int tsl2563_probe(struct i2c_client *client,
>>         err = tsl2563_detect(chip);
>>         if (err) {
>>                 dev_err(&client->dev, "detect error %d\n", -err);
>> -               goto fail1;
>> +               return err;
>>         }
>>
>>         err = tsl2563_read_id(chip, &id);
>>         if (err) {
>>                 dev_err(&client->dev, "read id error %d\n", -err);
>> -               goto fail1;
>> +               return err;
>>         }
>>
>>         mutex_init(&chip->lock);
>> @@ -751,7 +751,7 @@ static int tsl2563_probe(struct i2c_client *client,
>>                 indio_dev->info = &tsl2563_info_no_irq;
>>
>>         if (client->irq) {
>> -               err = request_threaded_irq(client->irq,
>> +               err = devm_request_threaded_irq(&client->dev, client->irq,
>>                                            NULL,
>>                                            &tsl2563_event_handler,
>>                                            IRQF_TRIGGER_RISING | IRQF_ONESHOT,
>> @@ -759,14 +759,14 @@ static int tsl2563_probe(struct i2c_client *client,
>>                                            indio_dev);
>>                 if (err) {
>>                         dev_err(&client->dev, "irq request error %d\n", -err);
>> -                       goto fail1;
>> +                       return err;
>>                 }
>>         }
>>
>>         err = tsl2563_configure(chip);
>>         if (err) {
>>                 dev_err(&client->dev, "configure error %d\n", -err);
>> -               goto fail2;
>> +               return err;
>>         }
>>
>>         INIT_DELAYED_WORK(&chip->poweroff_work, tsl2563_poweroff_work);
>> @@ -777,19 +777,14 @@ static int tsl2563_probe(struct i2c_client *client,
>>         err = iio_device_register(indio_dev);
>>         if (err) {
>>                 dev_err(&client->dev, "iio registration error %d\n", -err);
>> -               goto fail3;
>> +               goto fail;
>>         }
>>
>>         return 0;
>>
>> -fail3:
>> +fail:
>>         cancel_delayed_work(&chip->poweroff_work);
>>         flush_scheduled_work();
>> -fail2:
>> -       if (client->irq)
>> -               free_irq(client->irq, indio_dev);
>> -fail1:
>> -       iio_device_free(indio_dev);
>>         return err;
>>  }
>>
>> @@ -807,10 +802,6 @@ static int tsl2563_remove(struct i2c_client *client)
>>                                   chip->intr);
>>         flush_scheduled_work();
>>         tsl2563_set_power(chip, 0);
>> -       if (client->irq)
>> -               free_irq(client->irq, indio_dev);
>> -
>> -       iio_device_free(indio_dev);
>>
>>         return 0;
>>  }
>> --
>> 1.7.9.5
>>
