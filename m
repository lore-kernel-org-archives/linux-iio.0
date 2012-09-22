Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52713 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754587Ab2IVJLS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 22 Sep 2012 05:11:18 -0400
Message-ID: <505D80B7.1020601@kernel.org>
Date: Sat, 22 Sep 2012 10:11:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
	Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [patch] iio: dac/ad5755: signedness bug in ad5755_setup_pdata()
References: <20120919062700.GA28864@elgon.mountain> <5059FBF5.7070703@metafoo.de>
In-Reply-To: <5059FBF5.7070703@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/19/2012 06:08 PM, Lars-Peter Clausen wrote:
> On 09/19/2012 08:27 AM, Dan Carpenter wrote:
>> We need "ret" to be signed for the error handling to work correctly.
>>
>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Thanks,
> 
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Add to togreg branch of iio.git

Thanks
> 
>>
>> diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
>> index e6dbe5f..5db3506 100644
>> --- a/drivers/iio/dac/ad5755.c
>> +++ b/drivers/iio/dac/ad5755.c
>> @@ -451,9 +451,9 @@ static int __devinit ad5755_setup_pdata(struct iio_dev *indio_dev,
>>  	const struct ad5755_platform_data *pdata)
>>  {
>>  	struct ad5755_state *st = iio_priv(indio_dev);
>> -	unsigned int ret;
>>  	unsigned int val;
>>  	unsigned int i;
>> +	int ret;
>>  
>>  	if (pdata->dc_dc_phase > AD5755_DC_DC_PHASE_90_DEGREE ||
>>  		pdata->dc_dc_freq > AD5755_DC_DC_FREQ_650kHZ ||
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
