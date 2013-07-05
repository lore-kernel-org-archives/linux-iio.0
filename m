Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-102.synserver.de ([212.40.185.102]:1025 "EHLO
	smtp-out-102.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756162Ab3GEJzG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 5 Jul 2013 05:55:06 -0400
Message-ID: <51D6981B.8090001@metafoo.de>
Date: Fri, 05 Jul 2013 11:55:39 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
CC: Wei Yongjun <weiyj.lk@gmail.com>, jic23@cam.ac.uk,
	wfp5p@virginia.edu, yongjun_wei@trendmicro.com.cn,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH] staging:iio:ad7291: add missing .driver_module to struct
 iio_info
References: <CAPgLHd-v0MJWgtjY66Ky87ieQYxXg_9bFQxB0N5zoibshCV7Jg@mail.gmail.com> <20130704160110.GC13897@kroah.com>
In-Reply-To: <20130704160110.GC13897@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/04/2013 06:01 PM, Greg KH wrote:
> On Thu, Jul 04, 2013 at 09:46:34PM +0800, Wei Yongjun wrote:
>> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>>
>> Add missing .driver_module of struct iio_info. This prevents the
>> module from being removed from underneath its users.
>>
>> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>> ---
>>  drivers/staging/iio/adc/ad7291.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
>> index 3fc79e5..a2e61c2 100644
>> --- a/drivers/staging/iio/adc/ad7291.c
>> +++ b/drivers/staging/iio/adc/ad7291.c
>> @@ -517,6 +517,7 @@ static const struct iio_info ad7291_info = {
>>  	.read_event_value = &ad7291_read_event_value,
>>  	.write_event_value = &ad7291_write_event_value,
>>  	.event_attrs = &ad7291_event_attribute_group,
>> +	.driver_module = THIS_MODULE,
>>  };
> 
> That's a hint that the register function should be changed so that no
> module ever has to set this value.  Look at how PCI and USB do their
> driver registration function for how to do this properly.

I don't think that the same approach as used for PCI, USB and others works
as nicely here. For one we do not have a registration function for the info
struct, it would probably be possible to rework things a bit, but not
without some code churn. And secondly we'd also have to make all the
iio_info structs non-const, which is something I don't like. And thirdly we
do have the proper tools to auto-detect such missing initializations (e.g.
using coccinelle), so we can catch these errors early on and they won't show
up in new drivers.

- Lars
