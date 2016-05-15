Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:34833 "EHLO
	mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932512AbcEOD4e (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 14 May 2016 23:56:34 -0400
Received: by mail-lf0-f45.google.com with SMTP id j8so104424124lfd.2
        for <linux-iio@vger.kernel.org>; Sat, 14 May 2016 20:56:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <06678591-2f64-de15-ef86-1f530c7f498c@kernel.org>
References: <1463028468-13880-1-git-send-email-mranostay@gmail.com> <06678591-2f64-de15-ef86-1f530c7f498c@kernel.org>
From: Matt Ranostay <mranostay@gmail.com>
Date: Sat, 14 May 2016 20:55:52 -0700
Message-ID: <CAKzfze8A0e6Wa=KFLhNqj-Bbx3oG4Vy6spThJvQW363ivc1mrg@mail.gmail.com>
Subject: Re: [PATCH] iio: potentiometer: tpl0102: remove unneeded i2c check
 functionality test
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

No isn't breaking any hardware that I know of.

Thanks,

Matt

On Sat, May 14, 2016 at 9:58 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 12/05/16 05:47, Matt Ranostay wrote:
>> Actually I2C_FUNC_SMBUS_WORD_DATA isn't need for this device, and regmap
>> handles all single byte reads transparently.
>>
>> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
> Applied to the togreg branch of iio.git.  If you need it quicker I'm happy to push
> this trivial patch as a fix but only if is preventing known hardware from working
> (i.e. we have users complaining)
>
> thanks
>
> Jonathan
>
>> ---
>>  drivers/iio/potentiometer/tpl0102.c | 4 ----
>>  1 file changed, 4 deletions(-)
>>
>> diff --git a/drivers/iio/potentiometer/tpl0102.c b/drivers/iio/potentiometer/tpl0102.c
>> index 5c304d4..7b6b545 100644
>> --- a/drivers/iio/potentiometer/tpl0102.c
>> +++ b/drivers/iio/potentiometer/tpl0102.c
>> @@ -116,10 +116,6 @@ static int tpl0102_probe(struct i2c_client *client,
>>       struct tpl0102_data *data;
>>       struct iio_dev *indio_dev;
>>
>> -     if (!i2c_check_functionality(client->adapter,
>> -                                  I2C_FUNC_SMBUS_WORD_DATA))
>> -             return -EOPNOTSUPP;
>> -
>>       indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
>>       if (!indio_dev)
>>               return -ENOMEM;
>>
>
