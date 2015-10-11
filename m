Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41595 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbbJKOK5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 11 Oct 2015 10:10:57 -0400
Subject: Re: [PATCH] Staging: iio: cdc: Remove unused macros
To: Shraddha Barke <shraddha.6596@gmail.com>,
	outreachy-kernel@googlegroups.com,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
References: <1444250290-32700-1-git-send-email-shraddha.6596@gmail.com>
 <561A6DCD.8000505@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <561A6DF0.4050502@kernel.org>
Date: Sun, 11 Oct 2015 15:10:56 +0100
MIME-Version: 1.0
In-Reply-To: <561A6DCD.8000505@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/10/15 15:10, Jonathan Cameron wrote:
> On 07/10/15 21:38, Shraddha Barke wrote:
>> Remove the macros since they are not used anywhere throughout the
>> kernel.
>>
>> Signed-off-by: Shraddha Barke <shraddha.6596@gmail.com>
> Hi Shraddha,
> 
> This should have been cc'd to linux-iio and Lars-Peter Clausen
> (who maintains all the Analog devices drivers).
> 
> It's straightforward, but worth checking that they are fine with this.
That would have worked better if I'd then remembered to CC them myself.

Sorry!
> 
> Jonathan
>> ---
>>  drivers/staging/iio/cdc/ad7746.c | 7 -------
>>  1 file changed, 7 deletions(-)
>>
>> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
>> index 028b4e8..a4bb152 100644
>> --- a/drivers/staging/iio/cdc/ad7746.c
>> +++ b/drivers/staging/iio/cdc/ad7746.c
>> @@ -27,11 +27,7 @@
>>  
>>  #define AD7746_REG_STATUS		0
>>  #define AD7746_REG_CAP_DATA_HIGH	1
>> -#define AD7746_REG_CAP_DATA_MID		2
>> -#define AD7746_REG_CAP_DATA_LOW		3
>>  #define AD7746_REG_VT_DATA_HIGH		4
>> -#define AD7746_REG_VT_DATA_MID		5
>> -#define AD7746_REG_VT_DATA_LOW		6
>>  #define AD7746_REG_CAP_SETUP		7
>>  #define AD7746_REG_VT_SETUP		8
>>  #define AD7746_REG_EXC_SETUP		9
>> @@ -39,11 +35,8 @@
>>  #define AD7746_REG_CAPDACA		11
>>  #define AD7746_REG_CAPDACB		12
>>  #define AD7746_REG_CAP_OFFH		13
>> -#define AD7746_REG_CAP_OFFL		14
>>  #define AD7746_REG_CAP_GAINH		15
>> -#define AD7746_REG_CAP_GAINL		16
>>  #define AD7746_REG_VOLT_GAINH		17
>> -#define AD7746_REG_VOLT_GAINL		18
>>  
>>  /* Status Register Bit Designations (AD7746_REG_STATUS) */
>>  #define AD7746_STATUS_EXCERR		BIT(3)
>>
> 

