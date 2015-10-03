Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44002 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751894AbbJCJ2q (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 3 Oct 2015 05:28:46 -0400
Subject: Re: [patch] iio: accel: sca3000: memory corruption in
 sca3000_read_first_n_hw_rb()
To: Dan Carpenter <dan.carpenter@oracle.com>
References: <20150808191642.GD8034@mwanda> <55CF9BA1.7020804@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Octavian Purdila <octavian.purdila@intel.com>,
	Aybuke Ozdemir <aybuke.147@gmail.com>,
	Josselin Costanzi <josselin.costanzi@mobile-devices.fr>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	kernel-janitors@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <560F9FCB.40704@kernel.org>
Date: Sat, 3 Oct 2015 10:28:43 +0100
MIME-Version: 1.0
In-Reply-To: <55CF9BA1.7020804@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/08/15 21:05, Jonathan Cameron wrote:
> On 08/08/15 20:16, Dan Carpenter wrote:
>> "num_read" is in byte units but we are write u16s so we end up write
>> twice as much as intended.
>>
>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Hi Dan,
> 
> This is fine. Given it's an old bug, Greg is not going to take this
> sort of fix until after the merge window.   I won't be doing another
> pull to him to go in during the merge window.  Hence fastest route
> will be as a fix post 4.3-rc1.
> 
> Give me a poke if I haven't picked it up and sent it on by rc2 or so.
> 
> Thanks and good find.
> 
> Jonathan
Nearly forgot this one!

Anyhow, applied to the fixes-togreg branch of iio.git and marked for stable.

Jonathan
>>
>> diff --git a/drivers/staging/iio/accel/sca3000_ring.c b/drivers/staging/iio/accel/sca3000_ring.c
>> index 23685e7..bd2c69f 100644
>> --- a/drivers/staging/iio/accel/sca3000_ring.c
>> +++ b/drivers/staging/iio/accel/sca3000_ring.c
>> @@ -116,7 +116,7 @@ static int sca3000_read_first_n_hw_rb(struct iio_buffer *r,
>>  	if (ret)
>>  		goto error_ret;
>>  
>> -	for (i = 0; i < num_read; i++)
>> +	for (i = 0; i < num_read / sizeof(u16); i++)
>>  		*(((u16 *)rx) + i) = be16_to_cpup((__be16 *)rx + i);
>>  
>>  	if (copy_to_user(buf, rx, num_read))
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

