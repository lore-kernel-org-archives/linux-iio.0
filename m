Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59655 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752283AbbGENHQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 5 Jul 2015 09:07:16 -0400
Message-ID: <55992C00.9060704@kernel.org>
Date: Sun, 05 Jul 2015 14:07:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Karol Wrona <k.wrona@samsung.com>,
	Antonio Borneo <borneo.antonio@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] iio: ssp_sensors: Remove redundant spi driver bus
 initialization
References: <1435070714-24174-1-git-send-email-borneo.antonio@gmail.com> <1435071148-24453-1-git-send-email-borneo.antonio@gmail.com> <5591186F.6000505@samsung.com>
In-Reply-To: <5591186F.6000505@samsung.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/06/15 11:05, Karol Wrona wrote:
> On 06/23/2015 04:52 PM, Antonio Borneo wrote:
>> In ancient times it was necessary to manually initialize the bus
>> field of an spi_driver to spi_bus_type. These days this is done in
>> spi_register_driver(), so we can drop the manual assignment.
>>
>> Signed-off-by: Antonio Borneo <borneo.antonio@gmail.com>
>> To: Jonathan Cameron <jic23@kernel.org>
>> To: Lars-Peter Clausen <lars@metafoo.de>
>> To: Karol Wrona <k.wrona@samsung.com>
>> To: linux-iio@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>  drivers/iio/common/ssp_sensors/ssp_dev.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
>> index 9a40097..d338bb5 100644
>> --- a/drivers/iio/common/ssp_sensors/ssp_dev.c
>> +++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
>> @@ -700,7 +700,6 @@ static struct spi_driver ssp_driver = {
>>  	.remove = ssp_remove,
>>  	.driver = {
>>  		.pm = &ssp_pm_ops,
>> -		.bus = &spi_bus_type,
>>  		.owner = THIS_MODULE,
>>  		.of_match_table = of_match_ptr(ssp_of_match),
>>  		.name = "sensorhub"
>>
> Acked-by: Karol Wrona <k.wrona@samsung.com>
Applied to the togreg branch of iio.git

Thanks,

J
> 

