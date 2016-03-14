Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:30868 "EHLO mail.aswsp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754760AbcCNKs0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 14 Mar 2016 06:48:26 -0400
Message-ID: <56E69726.8050904@parrot.com>
Date: Mon, 14 Mar 2016 11:49:10 +0100
From: Gregor Boirie <gregor.boirie@parrot.com>
MIME-Version: 1.0
To: <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v6 1/1] iio:pressure:ms5611: fix crash when probing regulator
References: <cover.1457522751.git.gregor.boirie@parrot.com> <7767ba4decd3938eb1b37990f707b016228e0ef5.1457522751.git.gregor.boirie@parrot.com> <56E3F7C0.3080408@kernel.org>
In-Reply-To: <56E3F7C0.3080408@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


On 03/12/2016 12:04 PM, Jonathan Cameron wrote:
> On 09/03/16 11:34, Gregor Boirie wrote:
>> When not compiled-in, regulator layer will return a NULL pointer when
>> trying to get a reference to any regulator using devm_regulator_get().  As
>> IS_ERR() does not consider this an error, the ms5611 probing operation will
>> try to enable a NULL regulator, which will invariably cause a kernel
>> crash.
>> This patch fixes this situation by using devm_regulator_get_optional()
>> instead of devm_regulator_get().
>>
>> Fixes: 3145229f9191 ("iio:pressure:ms5611: power regulator support")
>> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
> I've been thinking a bit more about these cases and think we are missusing
> the optional regulators.  If regulator support is present and a non optional
> register is requested then it will feed a dummy regulator back.
> The intent of this is to handle the case where an non optional regulator is
> needed, but not specified (typically because it is always on).
My intent was:
* if regulator support not built-in, keep going ;
* else :
   * if regulator not declared (platform or device tree), keep going ;
   * else :
     * if regulator not properly declared, error ;
     * else enable it, then go one initializing.

So, I suppose dummy regulators should be allowed to support all
possible cases (use devm_regulator_get()).
Have I missed something ?
> So the question is how should we handle the regulators not built in case.
> If you do call devm_regulator_get you'll get a null pointer.
> Without regulators built in regulator_enable will be fine (returns 0)
> as does regulator disable.
>
> So I'm unclear on where the crash is coming from.
Probably from the fact that I use an up to date IIO subsystem ported onto
an old kernel (3.10.x), which rather complicates testing with regard to
other subsystem dependencies.

> Also interesting is this driver enables the regulator but never disables
> it (which it should).
Right. I thought regulator_put() implicitly disabled the regulator, which
is wrong...
>     I was clearly half asleep when reviewing this.
> Sorry!
Well, I wasn't that awake either. Sorry for the noise.
Grégor.
>
> Jonathan
>
>
>> ---
>>   drivers/iio/pressure/ms5611_core.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
>> index 37dbc04..a2a871b 100644
>> --- a/drivers/iio/pressure/ms5611_core.c
>> +++ b/drivers/iio/pressure/ms5611_core.c
>> @@ -387,8 +387,8 @@ static const struct iio_info ms5611_info = {
>>   static int ms5611_init(struct iio_dev *indio_dev)
>>   {
>>   	int ret;
>> -	struct regulator *vdd = devm_regulator_get(indio_dev->dev.parent,
>> -	                                           "vdd");
>> +	struct regulator *vdd =
>> +		devm_regulator_get_optional(indio_dev->dev.parent, "vdd");
>>
>>   	/* Enable attached regulator if any. */
>>   	if (!IS_ERR(vdd)) {
>> @@ -398,6 +398,10 @@ static int ms5611_init(struct iio_dev *indio_dev)
>>   			        "failed to enable Vdd supply: %d\n", ret);
>>   			return ret;
>>   		}
>> +	} else {
>> +		ret = PTR_ERR(vdd);
>> +		if (ret != -ENODEV)
>> +			return ret;
>>   	}
>>
>>   	ret = ms5611_reset(indio_dev);
>>

