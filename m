Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45232 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603AbbHBREE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 2 Aug 2015 13:04:04 -0400
Subject: Re: [PATCH 7/8] iio:magnetometer:bmc150_magn: expand mutex in
 trigger_handler
To: "Tirdea, Irina" <irina.tirdea@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <cover.1437090791.git.knaack.h@gmx.de>
 <6b1b2b7f33cc5a9654f32785626a10c8276d73e6.1437090791.git.knaack.h@gmx.de>
 <1F3AC3675D538145B1661F571FE1805F2F06BBD6@irsmsx105.ger.corp.intel.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"Dogaru, Vlad" <vlad.dogaru@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55BE4D82.5050600@kernel.org>
Date: Sun, 2 Aug 2015 18:04:02 +0100
MIME-Version: 1.0
In-Reply-To: <1F3AC3675D538145B1661F571FE1805F2F06BBD6@irsmsx105.ger.corp.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/07/15 18:48, Tirdea, Irina wrote:
> 
> 
>> -----Original Message-----
>> From: Hartmut Knaack [mailto:knaack.h@gmx.de]
>> Sent: 17 July, 2015 11:53
>> To: linux-iio@vger.kernel.org
>> Cc: Jonathan Cameron; Lars-Peter Clausen; Peter Meerwald; Tirdea, Irina; Dogaru, Vlad
>> Subject: [PATCH 7/8] iio:magnetometer:bmc150_magn: expand mutex in trigger_handler
>>
>> Keep the mutex locked, until the content of data->buffer has been pushed
>> out.
>>
> 
> Looks good to me.
> 
> Acked-by: Irina Tirdea <irina.tirdea@intel.com>
Applied to the togreg branch of iio.git.

Thanks,

> 
>> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
>> ---
>>  drivers/iio/magnetometer/bmc150_magn.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
>> index ac0cdbde813b..bdcf49ee75df 100644
>> --- a/drivers/iio/magnetometer/bmc150_magn.c
>> +++ b/drivers/iio/magnetometer/bmc150_magn.c
>> @@ -664,7 +664,6 @@ static irqreturn_t bmc150_magn_trigger_handler(int irq, void *p)
>>
>>  	mutex_lock(&data->mutex);
>>  	ret = bmc150_magn_read_xyz(data, data->buffer);
>> -	mutex_unlock(&data->mutex);
>>  	if (ret < 0)
>>  		goto err;
>>
>> @@ -672,6 +671,7 @@ static irqreturn_t bmc150_magn_trigger_handler(int irq, void *p)
>>  					   pf->timestamp);
>>
>>  err:
>> +	mutex_unlock(&data->mutex);
>>  	iio_trigger_notify_done(indio_dev->trig);
>>
>>  	return IRQ_HANDLED;
>> --
>> 2.4.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

