Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.20]:54500 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754087AbbHaT0n (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 31 Aug 2015 15:26:43 -0400
Message-ID: <55E4AA69.30208@gmx.de>
Date: Mon, 31 Aug 2015 21:26:33 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@gmail.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH 2/6] iio:dac:m62332: shutdown on remove
References: <cover.1440459082.git.knaack.h@gmx.de>	<17d2da9c4c05f45dce7aa81362770f9bdeae0bed.1440459082.git.knaack.h@gmx.de> <CAEnQRZCbn5w9GczdcHHBAYrxoPi8n_5m=yLU6QDO0sEcP-HxXA@mail.gmail.com>
In-Reply-To: <CAEnQRZCbn5w9GczdcHHBAYrxoPi8n_5m=yLU6QDO0sEcP-HxXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Daniel Baluta schrieb am 31.08.2015 um 14:56:
> On Sat, Aug 29, 2015 at 12:59 AM, Hartmut Knaack <knaack.h@gmx.de> wrote:
>> The regulator framework requests to balance regulator_enable() calls with
>> regulator_disable() calls. To meet this requirement, set channels to 0 on
>> remove, which implies a regulator_disable() call in case that channel was
>> enabled.
>>
>> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
> 
> Acked-by: Daniel Baluta <daniel.baluta@intel.com>
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

I thought about factoring out the same two calls in _susped() and reuse
it here, as well (discarding error codes). But in contrast to the suspend
call, which gets aborted on an error, both regulators have to be disabled
in _remove() unconditionally.
And to just have a call here like _powerdown(), I'm not really convinced
the overhead/effort is worth the slight benefit. But I don't really mind,
either.

> thanks,
> Daniel.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

