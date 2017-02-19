Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37366 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbdBSMC6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Feb 2017 07:02:58 -0500
Subject: Re: [PATCH 7/8] iio: pulsedlight-lidar-lite-v2: Set parent device
To: Matt Ranostay <matt.ranostay@konsulko.com>,
        Lars-Peter Clausen <lars@metafoo.de>
References: <1486816461-28618-1-git-send-email-lars@metafoo.de>
 <1486816461-28618-8-git-send-email-lars@metafoo.de>
 <CAJCx=g=3-ffVxQDSd09dONuq7hDxee2RZdWJNk=XjBTLsec2dQ@mail.gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <a6d9d31b-7d28-6f26-8c24-86984f383d2d@kernel.org>
Date: Sun, 19 Feb 2017 12:02:56 +0000
MIME-Version: 1.0
In-Reply-To: <CAJCx=g=3-ffVxQDSd09dONuq7hDxee2RZdWJNk=XjBTLsec2dQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/02/17 15:40, Matt Ranostay wrote:
> On Sat, Feb 11, 2017 at 4:34 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>> Initialize the parent of the IIO device to the device that registered it.
>> This makes sure that the IIO device appears the right level in the device
>> hierarchy.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> 
> Reviewed-by: Matt Ranostay <matt.ranostay@konsulko.com>
Applied.
> 
>> ---
>>  drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
>> index 20c16a0..36c1ddc 100644
>> --- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
>> +++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
>> @@ -278,6 +278,7 @@ static int lidar_probe(struct i2c_client *client,
>>         indio_dev->name = LIDAR_DRV_NAME;
>>         indio_dev->channels = lidar_channels;
>>         indio_dev->num_channels = ARRAY_SIZE(lidar_channels);
>> +       indio_dev->dev.parent = &client->dev;
>>         indio_dev->modes = INDIO_DIRECT_MODE;
>>
>>         i2c_set_clientdata(client, indio_dev);
>> --
>> 2.1.4
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

