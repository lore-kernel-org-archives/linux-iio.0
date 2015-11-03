Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-240.synserver.de ([212.40.185.240]:1062 "EHLO
	smtp-out-188.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751289AbbKCJWb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 3 Nov 2015 04:22:31 -0500
Message-ID: <56387CD2.3010906@metafoo.de>
Date: Tue, 03 Nov 2015 10:22:26 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>,
	Ioana Ciornei <ciorneiioana@gmail.com>,
	linux-iio@vger.kernel.org
CC: outreachy-kernel@googlegroups.com
Subject: Re: [PATCH 1/2] iio: gyro: check sscanf return value
References: <1446382725-11765-1-git-send-email-ciorneiioana@gmail.com> <56365728.9020304@kernel.org>
In-Reply-To: <56365728.9020304@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/01/2015 07:17 PM, Jonathan Cameron wrote:
> On 01/11/15 12:58, Ioana Ciornei wrote:
>> This patch fixes the checkpatch warnings:
>> WARNING: unchecked sscanf return value
>>
>> Signed-off-by: Ioana Ciornei <ciorneiioana@gmail.com>
> Hi Ioana,
> 
> Couple of minor process points (the patches are fine!)
> 
> You should have cc'd the driver author and generally also
> the various listed reviewers in MAINTAINERS.  In this case
> of of them is the driver author so possibly just pinging him
> is the way to go.  In the case of Analog devices parts,
> Lars-Peter is also the maintainer so it's all about as
> easy as it gets in this case.
> 
> Lars, looks fine to me.  Your driver so please sanity check.
> Clearly it's not a bug as the inputs are entirely controlled
> by the driver code, but I think having a sanity check on
> the return value is a good thing (from the point of view of
> best practice). 

As you say strictly speaking it is not necessary, but if it makes checkpatch
happy why not.

Acked-by: Lars-Peter Clausen <lars@metafoo.de>


> 
> There is a second patch for some the IIO drivers that are your
> problem as well - I'll let you pull that off the list as I'm
> feeling lazy ;)
> 
> I did have to check that sscanf never returns any more helpful
> error codes, but unlike the glibc one it seems not.  What fun.
> 
> Jonathan
>> ---
>>
>> based on linux-iio/testing branch
>>
>>  drivers/iio/gyro/adis16136.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/gyro/adis16136.c b/drivers/iio/gyro/adis16136.c
>> index 26de876..bb09bff 100644
>> --- a/drivers/iio/gyro/adis16136.c
>> +++ b/drivers/iio/gyro/adis16136.c
>> @@ -435,7 +435,9 @@ static int adis16136_initial_setup(struct iio_dev *indio_dev)
>>  	if (ret)
>>  		return ret;
>>  
>> -	sscanf(indio_dev->name, "adis%u\n", &device_id);
>> +	ret = sscanf(indio_dev->name, "adis%u\n", &device_id);
>> +	if (ret != 1)
>> +		return -EINVAL;
>>  
>>  	if (prod_id != device_id)
>>  		dev_warn(&indio_dev->dev, "Device ID(%u) and product ID(%u) do not match.",
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

