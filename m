Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58197 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673AbbHLVQ5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Aug 2015 17:16:57 -0400
Subject: Re: [PATCH v2 4/5] iio:light:stk3310: use correct names and type for
 state
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
References: <cover.1436398691.git.knaack.h@gmx.de>
 <692d0850562d1381c92759fb8e91652be40772ab.1436398691.git.knaack.h@gmx.de>
 <55ABACFA.9020504@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Tiberiu Breana <tiberiu.a.breana@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55CBB7C8.4020608@kernel.org>
Date: Wed, 12 Aug 2015 22:16:56 +0100
MIME-Version: 1.0
In-Reply-To: <55ABACFA.9020504@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/07/15 14:58, Jonathan Cameron wrote:
> On 09/07/15 22:51, Hartmut Knaack wrote:
>> Indicate the bit number of predefined states, make use of these names and
>> change the state type in _resume to u8 to avoid type casting.
>>
>> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
>> Reviewed-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
> Again, needs to wait for the fixes to make their way through the trees.
Applied to the togreg branch of iio.git - initially pushed out as
staging for the autobuilders to play with it.

J
>> ---
>>  drivers/iio/light/stk3310.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
>> index d6df40220007..0056f4870357 100644
>> --- a/drivers/iio/light/stk3310.c
>> +++ b/drivers/iio/light/stk3310.c
>> @@ -35,8 +35,8 @@
>>  #define STK3310_REG_ID				0x3E
>>  #define STK3310_MAX_REG				0x80
>>  
>> -#define STK3310_STATE_EN_PS			0x01
>> -#define STK3310_STATE_EN_ALS			0x02
>> +#define STK3310_STATE_EN_PS			BIT(0)
>> +#define STK3310_STATE_EN_ALS			BIT(1)
>>  #define STK3310_STATE_STANDBY			0x00
>>  
>>  #define STK3310_CHIP_ID_VAL			0x13
>> @@ -436,8 +436,8 @@ static int stk3310_set_state(struct stk3310_data *data, u8 state)
>>  		dev_err(&client->dev, "failed to change sensor state\n");
>>  	} else if (state != STK3310_STATE_STANDBY) {
>>  		/* Don't reset the 'enabled' flags if we're going in standby */
>> -		data->ps_enabled  = !!(state & 0x01);
>> -		data->als_enabled = !!(state & 0x02);
>> +		data->ps_enabled  = !!(state & STK3310_STATE_EN_PS);
>> +		data->als_enabled = !!(state & STK3310_STATE_EN_ALS);
>>  	}
>>  	mutex_unlock(&data->lock);
>>  
>> @@ -683,7 +683,7 @@ static int stk3310_suspend(struct device *dev)
>>  
>>  static int stk3310_resume(struct device *dev)
>>  {
>> -	int state = 0;
>> +	u8 state = 0;
>>  	struct stk3310_data *data;
>>  
>>  	data = iio_priv(i2c_get_clientdata(to_i2c_client(dev)));
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

