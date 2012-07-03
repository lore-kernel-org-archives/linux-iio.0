Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56288 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757118Ab2GCUIV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 3 Jul 2012 16:08:21 -0400
Message-ID: <4FF35134.7000506@kernel.org>
Date: Tue, 03 Jul 2012 21:08:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: "Zhang, Sonic" <Sonic.Zhang@analog.com>
CC: Sascha Hauer <s.hauer@pengutronix.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/3] staging iio adt7410: sysfs store function must return
 length
References: <1341307288-1926-1-git-send-email-s.hauer@pengutronix.de> <1341307288-1926-2-git-send-email-s.hauer@pengutronix.de> <DB904C5425BA6F4E8424B3B51A1414D17140805E77@NWD2CMBX1.ad.analog.com>
In-Reply-To: <DB904C5425BA6F4E8424B3B51A1414D17140805E77@NWD2CMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/03/2012 11:41 AM, Zhang, Sonic wrote:
> Acked-by: Sonic Zhang <sonic.zhang@analog.com>
> 
>> -----Original Message-----
>> From: Sascha Hauer [mailto:s.hauer@pengutronix.de]
>> Sent: Tuesday, July 03, 2012 5:21 PM
>> To: linux-iio@vger.kernel.org
>> Cc: Jonathan Cameron; Zhang, Sonic; Sascha Hauer
>> Subject: [PATCH 1/3] staging iio adt7410: sysfs store function must return length
>>
>> Otherwise a write to the resolution entry never returns.
>>
>> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
merged to fixes. Thanks.
>> ---
>> drivers/staging/iio/adc/adt7410.c |    2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/iio/adc/adt7410.c b/drivers/staging/iio/adc/adt7410.c
>> index d7d9ad9..fa54a40 100644
>> --- a/drivers/staging/iio/adc/adt7410.c
>> +++ b/drivers/staging/iio/adc/adt7410.c
>> @@ -257,7 +257,7 @@ static ssize_t adt7410_store_resolution(struct device
>> *dev,
>>
>>       chip->config = config;
>>
>> -      return ret;
>> +      return len;
>> }
>>
>> static IIO_DEVICE_ATTR(resolution, S_IRUGO | S_IWUSR,
>> --
>> 1.7.10
>>
> 
> 


