Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A53C395276;
	Mon, 17 Aug 2026 09:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786959620; cv=none; b=rtr8GGrRlp0gD5MOa9GBFiIS5B7L+n7TcjCKKexDEtf9SJswfMubaX/sUF4/oL8+Tzt/DsSUkM4PEs2fqFOXo3mQqkaxggnh4C8PntjYcU8JF0BV/+6YQ+mcMzfE7PDLtqsvFV8+qnIfbQW6reHOjScUBP7y0i4b3di4mLHS9CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786959620; c=relaxed/simple;
	bh=asAwnWxlptpAnCA+f+KfGNHkQoMLjrr4vqG2AT7XG1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BdFm7biTInKFDiWqte5kEkhLMLgwxx3DGrJGrVdASDFlE0L6kvg1v52OrWNU7XuD7hcYbjiRqyKAaBo39k81R0IaM477Lm8wOMKtuhUCQMeIek9bKpiT9Uq2Ai4dosHqUYg98/Lg/HyCaqwFKDYtC+bZQa17QWiBnc2dWiz5ORY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a2598f189a1f11f19a56ed5b684f684d-20260817
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:5299f48d-3c38-49b2-a63e-6575ae88b585,IP:0,U
	RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:7db8b62,CLOUDID:088e16246dcd3fbc65b5132bbb989c4d,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|136|865|898,TC:nil,Content:0|15|52
	,EDM:-3|-100,IP:nil,URL:93|82|11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil
	,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a2598f189a1f11f19a56ed5b684f684d-20260817
X-User: lilinmao@kylinos.cn
Received: from [10.0.2.15] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 70628495; Mon, 17 Aug 2026 17:40:08 +0800
Message-ID: <c9619639-d9ee-4e4f-a36c-43e0096a0c49@kylinos.cn>
Date: Mon, 17 Aug 2026 17:40:04 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH togreg v3 2/2] iio: imu: inv_icm42607: restore runtime PM
 on system resume errors
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Chris Morgan <macromorgan@hotmail.com>, David Lechner
 <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260811020345.950137-1-lilinmao@kylinos.cn>
 <20260811103301.1157404-1-lilinmao@kylinos.cn>
 <20260811103301.1157404-3-lilinmao@kylinos.cn>
 <20260815215848.20d5ea79@jic23-huawei>
From: Linmao Li <lilinmao@kylinos.cn>
In-Reply-To: <20260815215848.20d5ea79@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/8/16 4:58, Jonathan Cameron 写道:
> On Tue, 11 Aug 2026 18:33:01 +0800
> Linmao Li <lilinmao@kylinos.cn> wrote:
>
>> pm_runtime_force_suspend() leaves runtime PM disabled after it succeeds and
>> expects pm_runtime_force_resume() to restore runtime PM management during
>> system resume.
>>
>> The resume callback returns early if enabling the vddio regulator or
>> synchronizing the register cache fails, skipping the matching
>> pm_runtime_force_resume() call. Runtime PM consequently remains disabled
>> after the system has resumed, so runtime autosuspend can no longer turn off
>> sensors enabled afterward.
>>
>> Call pm_runtime_force_resume() on both error paths. Keep the first error as
>> the return value and report a runtime PM restore failure separately.
>>
>> Fixes: 3007c1530f96 ("iio: imu: inv_icm42607: Add PM support for icm42607")
>> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
> Sashiko has some comments on this:
> https://sashiko.dev/#/patchset/20260811103301.1157404-1-lilinmao%40kylinos.cn
>
> I would note that in some paths error handling is best effort.
> There isn't always a sequence that leaves us in a remotely
> useful state.  So maybe what you have here is the best we can do
> even though it is a bit crazy to expect the driver to do anything
> useful if it can't power the device.
>
>> ---
>> Changes since v2:
>> - Restructure inv_icm42607_resume() along the lines Andy suggested:
>>    handle the error case in its own block and call
>>    pm_runtime_force_resume() directly on the success path.  No
>>    functional change.
>>
>> Changes since v1:
>> - Split the device side of inv_icm42607_resume() into a helper so the
>>    PM bookkeeping stays in the wrapper.  No functional change.
>>
>>   .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 23 +++++++++++++++----
>>   1 file changed, 19 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
>> index 0da362967f63b..f4ef75da22c76 100644
>> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
>> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
>> @@ -664,9 +664,8 @@ static int inv_icm42607_suspend(struct device *dev)
>>   	return 0;
>>   }
>>   
>> -static int inv_icm42607_resume(struct device *dev)
>> +static int inv_icm42607_resume_core(struct inv_icm42607_state *st)
>>   {
>> -	struct inv_icm42607_state *st = dev_get_drvdata(dev);
>>   	int ret;
>>   
>>   	ret = inv_icm42607_enable_vddio_reg(st);
>> @@ -675,9 +674,25 @@ static int inv_icm42607_resume(struct device *dev)
>>   
>>   	/* Sync the regcache again after regulator shutdown. */
>>   	regcache_mark_dirty(st->map);
>> -	ret = regcache_sync(st->map);
>> -	if (ret)
>> +
>> +	return regcache_sync(st->map);
>> +}
>> +
>> +static int inv_icm42607_resume(struct device *dev)
>> +{
>> +	struct inv_icm42607_state *st = dev_get_drvdata(dev);
>> +	int ret;
>> +
>> +	ret = inv_icm42607_resume_core(st);
>> +	if (ret) {
>> +		int rc;
>> +
>> +		rc = pm_runtime_force_resume(dev);
>> +		if (rc)
>> +			dev_warn(dev, "Failed to restore runtime PM state: %d\n", rc);
>> +
> There is a question from sashiko on whether this can be reached.
> Even though that may be the case I'd keep the the error print because
> it hardens us against future changes.
Agreed.  I would keep the warning, and I think it is reachable. When
pm_runtime_force_resume() needs to invoke a runtime-resume callback,
GET_CALLBACK() can select one from the PM domain, device type, class or
bus before falling back to the driver.  The NULL runtime_resume in this
driver's PM ops therefore does not mean that the entire callback chain is
empty.  For example, a generic PM domain runtime-resume callback can
fail.

On sashiko's other point, leaving runtime PM disabled would not by itself
block I/O with -EACCES here.  Provided there is no pre-existing
runtime_error, the read paths use PM_RUNTIME_ACQUIRE_AUTOSUSPEND(), which
calls pm_runtime_get_active() with RPM_TRANSPARENT.  The acquisition
therefore succeeds when runtime PM is disabled.

Calling pm_runtime_force_resume() on the error path consequently does not
newly expose accesses after a failed hardware resume; that possibility
already exists without the patch.  Depending on the transport and actual
hardware state, such accesses may either fail or return unusable data.
>
>>   		return ret;
>> +	}
>>   
>>   	return pm_runtime_force_resume(dev);
>>   }
