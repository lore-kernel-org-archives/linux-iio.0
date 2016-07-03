Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57934 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752063AbcGCMNo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 3 Jul 2016 08:13:44 -0400
Subject: Re: [PATCH] iio: adc: ti-ads1015: add indio_dev->dev.of_node
 reference
To: Daniel Baluta <daniel.baluta@intel.com>,
	Matt Ranostay <mranostay@gmail.com>
References: <1467340430-15184-1-git-send-email-mranostay@gmail.com>
 <CAEnQRZB2wbAtd8M45g8d_-Bsw32z1YQLnEctwZvfwh__dTgRLA@mail.gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <0d76955e-2194-aba5-b233-a4e41fad1c25@kernel.org>
Date: Sun, 3 Jul 2016 13:13:41 +0100
MIME-Version: 1.0
In-Reply-To: <CAEnQRZB2wbAtd8M45g8d_-Bsw32z1YQLnEctwZvfwh__dTgRLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/07/16 14:34, Daniel Baluta wrote:
> On Fri, Jul 1, 2016 at 5:33 AM, Matt Ranostay <mranostay@gmail.com> wrote:
>> Add the pointer to the device tree node of the ADC so that iio
>> consumers can reference the respective channels.
>>
>> Cc: Daniel Baluta <daniel.baluta@intel.com>
>> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
> 
> Acked-by: Daniel Baluta <daniel.baluta@intel.com>
I've applied this to the togreg branch of iio.git.
Arguably it was never right before so no regression, but
if you want a backport to stable we can probably argue it as trivial
and useful.

Thanks,

Jonathan
> 
> 
> 
>> ---
>>  drivers/iio/adc/ti-ads1015.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
>> index 8be192a84893..6f75a4aa67c1 100644
>> --- a/drivers/iio/adc/ti-ads1015.c
>> +++ b/drivers/iio/adc/ti-ads1015.c
>> @@ -585,6 +585,7 @@ static int ads1015_probe(struct i2c_client *client,
>>         mutex_init(&data->lock);
>>
>>         indio_dev->dev.parent = &client->dev;
>> +       indio_dev->dev.of_node = client->dev.of_node;
>>         indio_dev->name = ADS1015_DRV_NAME;
>>         indio_dev->modes = INDIO_DIRECT_MODE;
>>
>> --
>> 2.7.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

