Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2976A3E8C78;
	Mon, 17 Aug 2026 09:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786959186; cv=none; b=qxzIkULpINOQsUD8bPGuOotDH3xy2D+qkbfddkbtUPRH8oB6ufEZCHQZCdL7G3fmGVQj6ut8Z0XWaxr+uviTiH0sMbvl13S0pxmWkQNt0ZCCVBM7Ay9DhuYRM9vMkqKlpuEjEnrkXGuiSVYh3LwI7+bzGwFkIPV5WcgyXgAeqys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786959186; c=relaxed/simple;
	bh=mWOhG75wa+8dAlYfw970eWFyLANVtyaQj88LY0Mnjzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kErknoSGPWejlR2GZ0JPrzz+Ixebj3k8mXeNHU4v5Ayi5LKNAyRA7vgxwpX4cjlhqVBKuT/fzgQvQZw2ud7MlltjZ2/AxLa9CEOsNBirhZ45br/eoI6CGI6akLarmxZ+2DLIQ0b+12swA5yHH+5VXMToGGnolJCKIpcxWQDzCIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9b330c2e9a1e11f19a56ed5b684f684d-20260817
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:6ed4dce8-9393-419a-8cc0-1dbcabd42684,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:3d8cdabbb776ca01fb8297f2148520dd,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|136|865|898,TC:nil,Content:0|15|52
	,EDM:-3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9b330c2e9a1e11f19a56ed5b684f684d-20260817
X-User: lilinmao@kylinos.cn
Received: from [10.0.2.15] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 204623507; Mon, 17 Aug 2026 17:32:46 +0800
Message-ID: <51769a1a-8d28-4224-9b36-06b04282db74@kylinos.cn>
Date: Mon, 17 Aug 2026 17:32:43 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH togreg v3 1/2] iio: imu: inv_icm42607: propagate runtime
 suspend errors
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Chris Morgan <macromorgan@hotmail.com>, David Lechner
 <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260811020345.950137-1-lilinmao@kylinos.cn>
 <20260811103301.1157404-1-lilinmao@kylinos.cn>
 <20260811103301.1157404-2-lilinmao@kylinos.cn>
 <20260815215028.784c7579@jic23-huawei>
From: Linmao Li <lilinmao@kylinos.cn>
In-Reply-To: <20260815215028.784c7579@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/8/16 4:52, Jonathan Cameron 写道:
> On Tue, 11 Aug 2026 18:33:00 +0800
> Linmao Li <lilinmao@kylinos.cn> wrote:
>
>> The runtime suspend callback always returns success even when updating
>> PWR_MGMT0 fails. The PM core can then mark the device suspended while one
>> or both sensors remain enabled.
>>
>> The sibling ICM-42600 driver propagates the corresponding
>> inv_icm42600_set_pwr_mgmt0() failure from its runtime suspend callback.
>> Make ICM-42607 follow the same behavior by returning the sensor shutdown
>> error. Keep a void wrapper for the managed teardown action, where errors
>> can only be logged.
> What is the practical affect of a sensor remaining enabled?  Bit of
> power loss or something more significant?  This info matter when deciding
> if we should rush this in during the rc phase, or wait for the next
> merge window.
As far as I can tell, the practical effect is additional power
consumption while the device is idle.  I found no corruption path, but I
have no ICM-42607 hardware to reproduce the failure or measure the
current.

It does not necessarily persist indefinitely.  If the PWR_MGMT0 write
fails, regmap may contain the requested OFF state while the hardware
remains ON.  A later sensor read requests an enabled mode, so
inv_icm42607_set_pwr_mgmt0() retries the write instead of taking its
"no change" return.  If the bus error was transient, the cache and
hardware are then resynchronized.

I also noticed a cost to this patch: returning an error such as -EIO from
.runtime_suspend() makes the PM core set power.runtime_error. Subsequent
reads then fail in PM_RUNTIME_ACQUIRE_AUTOSUSPEND() before any sensor
register is accessed, until the PM status is reset.  A successful system
suspend may clear that state.

The patch therefore trades a logged idle power leak that may recover on
a later access for a potentially sticky runtime-PM failure.  Since this
was found by inspection only, I would not rush it into the rc phase.  I
would rather revisit the error handling and target the next merge window.

Linmao

>
> Jonathan
>
>
>> Fixes: 3007c1530f96 ("iio: imu: inv_icm42607: Add PM support for icm42607")
>> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
>> ---
>> Unchanged since v1.
>>
>>   drivers/iio/imu/inv_icm42607/inv_icm42607_core.c | 15 ++++++++++-----
>>   1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
>> index 190e998f7b8ef..0da362967f63b 100644
>> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
>> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
>> @@ -537,9 +537,8 @@ static int inv_icm42607_enable_vddio_reg(struct inv_icm42607_state *st)
>>   	return 0;
>>   }
>>   
>> -static void inv_icm42607_sensors_off(void *_data)
>> +static int inv_icm42607_sensors_off(struct inv_icm42607_state *st)
>>   {
>> -	struct inv_icm42607_state *st = _data;
>>   	const struct device *dev = regmap_get_device(st->map);
>>   	int ret;
>>   
>> @@ -552,6 +551,13 @@ static void inv_icm42607_sensors_off(void *_data)
>>   					 st->conf.accel.mode);
>>   	if (ret)
>>   		dev_err(dev, "Unable to turn off sensors\n");
>> +
>> +	return ret;
>> +}
>> +
>> +static void inv_icm42607_sensors_off_action(void *data)
>> +{
>> +	inv_icm42607_sensors_off(data);
>>   }
>>   
>>   static void inv_icm42607_disable_vddio_reg(void *_data)
>> @@ -619,7 +625,7 @@ int inv_icm42607_core_probe(struct regmap *regmap,
>>   	 * Ensure if sensors get turned on at some point, they're turned off
>>   	 * as part of teardown.
>>   	 */
>> -	ret = devm_add_action_or_reset(dev, inv_icm42607_sensors_off, st);
>> +	ret = devm_add_action_or_reset(dev, inv_icm42607_sensors_off_action, st);
>>   	if (ret)
>>   		return ret;
>>   
>> @@ -688,8 +694,7 @@ static int inv_icm42607_runtime_suspend(struct device *dev)
>>   	 * however the tradeoff is that an unused sensor won't be
>>   	 * turned off until the entire chip is no longer in use.
>>   	 */
>> -	inv_icm42607_sensors_off(st);
>> -	return 0;
>> +	return inv_icm42607_sensors_off(st);
>>   }
>>   
>>   EXPORT_NS_GPL_DEV_PM_OPS(inv_icm42607_pm_ops, IIO_ICM42607) = {
