Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55583 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148AbcCEOBg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Mar 2016 09:01:36 -0500
Subject: Re: [PATCH] iio: potentiometer: tpl0102: change i2c functionality
 return code
To: Matt Ranostay <mranostay@gmail.com>
References: <1457160925-20254-1-git-send-email-mranostay@gmail.com>
 <CAKzfze9u7bOZKD9+nU5qJGN4SDaaLu+jWXPRKHx=1x7e0=BfyQ@mail.gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56DAE6BC.9060809@kernel.org>
Date: Sat, 5 Mar 2016 14:01:32 +0000
MIME-Version: 1.0
In-Reply-To: <CAKzfze9u7bOZKD9+nU5qJGN4SDaaLu+jWXPRKHx=1x7e0=BfyQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/03/16 07:05, Matt Ranostay wrote:
> Bit embarrassing that I missed my new driver in the original cleanup :)
> 
> On Fri, Mar 4, 2016 at 10:55 PM, Matt Ranostay <mranostay@gmail.com> wrote:
>> Change i2c_check_functionality condition check return from ENOTSUPP to
>> EOPNOTSUPP which is now the standard return code.
>>
>> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
Applied to the togreg branch of iio.git - probably will have to wait for the next cycle
now unless there is a big delay in the merge window for some reason.

Jonathan
>> ---
>>  drivers/iio/potentiometer/tpl0102.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/potentiometer/tpl0102.c b/drivers/iio/potentiometer/tpl0102.c
>> index 313124b..5c304d4 100644
>> --- a/drivers/iio/potentiometer/tpl0102.c
>> +++ b/drivers/iio/potentiometer/tpl0102.c
>> @@ -118,7 +118,7 @@ static int tpl0102_probe(struct i2c_client *client,
>>
>>         if (!i2c_check_functionality(client->adapter,
>>                                      I2C_FUNC_SMBUS_WORD_DATA))
>> -               return -ENOTSUPP;
>> +               return -EOPNOTSUPP;
>>
>>         indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
>>         if (!indio_dev)
>> --
>> 2.7.0
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

