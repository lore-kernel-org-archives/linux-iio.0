Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41798 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685AbbJKOmR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 11 Oct 2015 10:42:17 -0400
Subject: Re: [PATCH 2/6] iio:dac:m62332: shutdown on remove
To: Daniel Baluta <daniel.baluta@gmail.com>,
	Hartmut Knaack <knaack.h@gmx.de>
References: <cover.1440459082.git.knaack.h@gmx.de>
 <17d2da9c4c05f45dce7aa81362770f9bdeae0bed.1440459082.git.knaack.h@gmx.de>
 <CAEnQRZCbn5w9GczdcHHBAYrxoPi8n_5m=yLU6QDO0sEcP-HxXA@mail.gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <561A7547.8030203@kernel.org>
Date: Sun, 11 Oct 2015 15:42:15 +0100
MIME-Version: 1.0
In-Reply-To: <CAEnQRZCbn5w9GczdcHHBAYrxoPi8n_5m=yLU6QDO0sEcP-HxXA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/08/15 13:56, Daniel Baluta wrote:
> On Sat, Aug 29, 2015 at 12:59 AM, Hartmut Knaack <knaack.h@gmx.de> wrote:
>> The regulator framework requests to balance regulator_enable() calls with
>> regulator_disable() calls. To meet this requirement, set channels to 0 on
>> remove, which implies a regulator_disable() call in case that channel was
>> enabled.
>>
>> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
> 
> Acked-by: Daniel Baluta <daniel.baluta@intel.com>
Applied to the togreg branch of iio.git - as ever initially
pushed out as testing for the autobuilders to mess around with it.

Jonathan
> 
>> ---
>>  drivers/iio/dac/m62332.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/iio/dac/m62332.c b/drivers/iio/dac/m62332.c
>> index cffc0630ed32..c61720de8606 100644
>> --- a/drivers/iio/dac/m62332.c
>> +++ b/drivers/iio/dac/m62332.c
>> @@ -243,6 +243,8 @@ static int m62332_remove(struct i2c_client *client)
>>
>>         iio_device_unregister(indio_dev);
>>         iio_map_array_unregister(indio_dev);
>> +       m62332_set_value(indio_dev, 0, 0);
>> +       m62332_set_value(indio_dev, 0, 1);
>>
>>         return 0;
>>  }
> 
> Wouldn't be nice to factor this two calls in a separate function?
> 
> thanks,
> Daniel.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

