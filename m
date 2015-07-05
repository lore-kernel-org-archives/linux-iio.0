Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59638 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981AbbGENEF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 5 Jul 2015 09:04:05 -0400
Message-ID: <55992B44.7020705@kernel.org>
Date: Sun, 05 Jul 2015 14:04:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>,
	Vlad Dogaru <vlad.dogaru@intel.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: sx9500: fix bug in compensation code
References: <1435663259-21998-1-git-send-email-vlad.dogaru@intel.com> <1435663259-21998-3-git-send-email-vlad.dogaru@intel.com> <559434A5.3070900@gmx.de>
In-Reply-To: <559434A5.3070900@gmx.de>
Content-Type: text/plain; charset=iso-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/07/15 19:42, Hartmut Knaack wrote:
> Vlad Dogaru schrieb am 30.06.2015 um 13:20:
>> The initial compensation was mistakingly toggling an extra bit in the
>> control register.  Fix this and make sure it's less likely to happen by
>> introducing an additional macro.
>>
>> Reported-by: Hartmut Knaack <knaack.h@gmx.de>
>> Signed-off-by: Vlad Dogaru <vlad.dogaru@intel.com>
> Acked-by: Hartmut Knaack <knaack.h@gmx.de>
Applied to the fixes-for-4.2 branch of iio.git

Thanks,

Jonathan
>> ---
>>  drivers/iio/proximity/sx9500.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
>> index ba1cbbe..798b973 100644
>> --- a/drivers/iio/proximity/sx9500.c
>> +++ b/drivers/iio/proximity/sx9500.c
>> @@ -80,6 +80,7 @@
>>  #define SX9500_COMPSTAT_MASK		GENMASK(3, 0)
>>  
>>  #define SX9500_NUM_CHANNELS		4
>> +#define SX9500_CHAN_MASK		GENMASK(SX9500_NUM_CHANNELS - 1, 0)
>>  
>>  struct sx9500_data {
>>  	struct mutex mutex;
>> @@ -802,8 +803,7 @@ static int sx9500_init_compensation(struct iio_dev *indio_dev)
>>  	unsigned int val;
>>  
>>  	ret = regmap_update_bits(data->regmap, SX9500_REG_PROX_CTRL0,
>> -				 GENMASK(SX9500_NUM_CHANNELS, 0),
>> -				 GENMASK(SX9500_NUM_CHANNELS, 0));
>> +				 SX9500_CHAN_MASK, SX9500_CHAN_MASK);
>>  	if (ret < 0)
>>  		return ret;
>>  
>> @@ -823,7 +823,7 @@ static int sx9500_init_compensation(struct iio_dev *indio_dev)
>>  
>>  out:
>>  	regmap_update_bits(data->regmap, SX9500_REG_PROX_CTRL0,
>> -			   GENMASK(SX9500_NUM_CHANNELS, 0), 0);
>> +			   SX9500_CHAN_MASK, 0);
>>  	return ret;
>>  }
>>  
>>
> 

