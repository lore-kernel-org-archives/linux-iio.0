Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35845 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063AbcEDOjs (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 4 May 2016 10:39:48 -0400
Subject: Re: [patch] iio: dac: ad5592r: Off by one bug in
 ad5592r_alloc_channels()
To: Dan Carpenter <dan.carpenter@oracle.com>,
	Lars-Peter Clausen <lars@metafoo.de>
References: <20160429090330.GB18656@mwanda>
 <dd84eb1c-277e-78f0-24b1-8a170e4d8730@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <2cd58da3-6cad-bcf6-b034-4b85e45b1e1e@kernel.org>
Date: Wed, 4 May 2016 10:53:15 +0100
MIME-Version: 1.0
In-Reply-To: <dd84eb1c-277e-78f0-24b1-8a170e4d8730@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/05/16 20:04, Jonathan Cameron wrote:
> On 29/04/16 10:03, Dan Carpenter wrote:
>> The > here should be >= or we go beyond the end for the array.
>>
>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Good spot - marked it to pick up when I am back on the internet soonish....
> (though perhaps not when I my computer manages to sneak this lot out!)
Applied to the fixes-togreg-post-rc1 branch of iio.git which I'll
push out sometime in the next few days.

Jonathan
>>
>> diff --git a/drivers/iio/dac/ad5592r-base.c b/drivers/iio/dac/ad5592r-base.c
>> index 948f600..69bde59 100644
>> --- a/drivers/iio/dac/ad5592r-base.c
>> +++ b/drivers/iio/dac/ad5592r-base.c
>> @@ -525,7 +525,7 @@ static int ad5592r_alloc_channels(struct ad5592r_state *st)
>>  
>>  	device_for_each_child_node(st->dev, child) {
>>  		ret = fwnode_property_read_u32(child, "reg", &reg);
>> -		if (ret || reg > ARRAY_SIZE(st->channel_modes))
>> +		if (ret || reg >= ARRAY_SIZE(st->channel_modes))
>>  			continue;
>>  
>>  		ret = fwnode_property_read_u32(child, "adi,mode", &tmp);
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

