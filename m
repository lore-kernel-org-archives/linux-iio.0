Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57301 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175AbbGTRoa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jul 2015 13:44:30 -0400
Message-ID: <55AD337B.4000109@kernel.org>
Date: Mon, 20 Jul 2015 18:44:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: "Tirdea, Irina" <irina.tirdea@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"Dogaru, Vlad" <vlad.dogaru@intel.com>
Subject: Re: [PATCH 5/8] iio:magnetometer:bmc150_magn: add error handling
 on gpio probe
References: <cover.1437090791.git.knaack.h@gmx.de> <655373255075b12f451e644d81b36aa0588aa9c1.1437090791.git.knaack.h@gmx.de> <1F3AC3675D538145B1661F571FE1805F2F06BB7E@irsmsx105.ger.corp.intel.com>
In-Reply-To: <1F3AC3675D538145B1661F571FE1805F2F06BB7E@irsmsx105.ger.corp.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/07/15 18:36, Tirdea, Irina wrote:
> 
> 
>> -----Original Message-----
>> From: Hartmut Knaack [mailto:knaack.h@gmx.de]
>> Sent: 17 July, 2015 11:52
>> To: linux-iio@vger.kernel.org
>> Cc: Jonathan Cameron; Lars-Peter Clausen; Peter Meerwald; Tirdea, Irina; Dogaru, Vlad
>> Subject: [PATCH 5/8] iio:magnetometer:bmc150_magn: add error handling on gpio probe
>>
>> bmc150_magn_gpio_probe() may return some error codes, so better check
>> them.
>>
>> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
>> ---
>>  drivers/iio/magnetometer/bmc150_magn.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
>> index f1b6a4dc40ea..e1f804b2b244 100644
>> --- a/drivers/iio/magnetometer/bmc150_magn.c
>> +++ b/drivers/iio/magnetometer/bmc150_magn.c
>> @@ -920,8 +920,13 @@ static int bmc150_magn_probe(struct i2c_client *client,
>>  	indio_dev->modes = INDIO_DIRECT_MODE;
>>  	indio_dev->info = &bmc150_magn_info;
>>
>> -	if (client->irq <= 0)
>> +	if (client->irq <= 0) {
>>  		client->irq = bmc150_magn_gpio_probe(client);
>> +		if (client->irq < 0) {
>> +			ret = client->irq;
>> +			goto err_poweroff;
>> +		}
>> +	}
> 
> The error code for client->irq was not checked on purpose. We would like to be able to use this driver
> even if the interrupt pin is not connected (reading from sysfs in poll mode or by using iio hrtimers). 
> 
> If the i2c core does not initialize the irq, we try to initialize it through ACPI in bmc150_magn_gpio_probe
> and if that fails too we do not register the interrupt and iio trigger (see check for client->irq >0 below).
> In this way we could still use the device even if we don't have interrupts.
> 
One of the advantages of a pre push to testing is I can still rebase when
I jump the gun and mess up like this ;)

Anyhow, patch dropped and testing re-pushed out.

Sorry about that, should have left these a while on the list before applying.

Jonathan

>>
>>  	if (client->irq > 0) {
>>  		data->dready_trig = devm_iio_trigger_alloc(&client->dev,
>> --
>> 2.4.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

