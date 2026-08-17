Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AED19F40B;
	Mon, 17 Aug 2026 01:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786930514; cv=none; b=MKONAS2QiqoCp4YxZ1b5j+pt9g3kFBidtAOyrzmjyk9i5Gcos9JzF5oTLvETDf3embnJQdeplXp95XhdIHQofRQHZHj3FH/0AgsLvWmyh/g6S+ugF1aHFBr2rGKeK89UKei9VUAcPCRlJiFqACQq+vTfwfof2xmZEfZj3Ml8rBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786930514; c=relaxed/simple;
	bh=qqdu9FhrNjAYm3lpKEwHdqdsFmQmSVPhf7A1yUzWGFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OFmdM6yG7NGk/XS+jltUU5uyxoV/fwU5xB4n/IhoGQJhO67RTFwOvQNq7VFPbpy5Cj9knFmVDRmoo8odj86ih0xp1nYl/Ah6Lh0nR3AJ43hTNaB1co48wcQAQZE4BoZlOleH7GoHhVcmqikjd4uKhqsIUiNQ7oTau3H5RCP15t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: dc4391cc99db11f19a56ed5b684f684d-20260817
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:32fc536f-beeb-4c2f-a94b-99dd28997905,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:4efef9cb51bb47867a0c5f47dee6560f,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0|15|52,EDM
	:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: dc4391cc99db11f19a56ed5b684f684d-20260817
X-User: lilinmao@kylinos.cn
Received: from [10.0.2.15] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 586452921; Mon, 17 Aug 2026 09:34:59 +0800
Message-ID: <1085ebf0-f829-4e8b-ae0a-03e7f2316dbb@kylinos.cn>
Date: Mon, 17 Aug 2026 09:34:56 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: flow: slf3s: restart measurement if VDD disable
 fails
To: Jonathan Cameron <jic23@kernel.org>
Cc: Wadim Mueller <wafgo01@gmail.com>, Maxwell Doose <maxwell@maxwelld.cc>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260805110255.504576-1-lilinmao@kylinos.cn>
 <20260815220523.0769e222@jic23-huawei>
From: Linmao Li <lilinmao@kylinos.cn>
In-Reply-To: <20260815220523.0769e222@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/8/16 5:05, Jonathan Cameron 写道:
> On Wed,  5 Aug 2026 19:02:55 +0800
> Linmao Li <lilinmao@kylinos.cn> wrote:
>
>> slf3s_suspend() stops continuous measurement before disabling VDD. If
>> regulator_disable() fails while the supply remains enabled, the system
>> sleep transition is aborted. Since the PM core does not call the
>> corresponding resume callback for a device whose suspend callback failed,
>> the sensor remains idle after the system returns to the running state and
>> subsequent reads fail.
>>
>> Attempt to restart continuous measurement on this error path. Preserve the
>> regulator error and warn if restarting the measurement also fails.
>>
>> Fixes: d240b0b8a1ce ("iio: flow: add Sensirion SLF3S liquid flow sensor driver")
>> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
>> ---
>>   drivers/iio/flow/slf3s.c | 12 +++++++++++-
>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/flow/slf3s.c b/drivers/iio/flow/slf3s.c
>> index dfa7c14090454..75ee82fbd3295 100644
>> --- a/drivers/iio/flow/slf3s.c
>> +++ b/drivers/iio/flow/slf3s.c
>> @@ -462,6 +462,7 @@ static int slf3s_suspend(struct device *dev)
>>   {
>>   	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>>   	struct slf3s_data *sf = iio_priv(indio_dev);
>> +	int restart_ret;
>>   	int ret;
>>   
>>   	guard(mutex)(&sf->lock);
>> @@ -470,7 +471,16 @@ static int slf3s_suspend(struct device *dev)
>>   	if (ret)
>>   		return ret;
>>   
>> -	return regulator_disable(sf->vdd);
>> +	ret = regulator_disable(sf->vdd);
> Similar to previous thread I replied to, I'm not convinced spending much
> effort to recover from this sort of condition is useful.
Fair enough - this was found by code inspection only, so I cannot say
how likely the regulator failure is in practice.

One consequence that was not in the commit message is that leaving the
sensor idle makes the failure sticky.  The comment in slf3s_probe()
anticipates the stop command returning an error when the sensor is
already idle, and both slf3s_suspend() and slf3s_set_medium() propagate
that error.  So subsequent suspend attempts are expected to fail at the
stop command, and selecting a medium cannot restart the measurement
either; recovery then requires the device to be reprobed or otherwise
reset.

The restart is only a best-effort rollback for cases where VDD remains
enabled; the driver cannot determine the supply state from the return
value alone.  It does not address whatever made regulator_disable()
fail, so a later suspend may fail there again if that condition persists.
Its purpose is to avoid additionally leaving the sensor idle.

If that still does not justify the extra branch, I will drop the patch.
Otherwise I will respin it with the error handling out of line as you
suggested.
> If we have a regulator that doesn't respond reliably to instruction chances
> are we very unlikely to recover, and adding the recovery logic complicates
> the driver somewhat.
>
> I we do decide this is worth doing then not this style.  Keep the error handling
> as the out of line path
> 	if (ret) {
> 		int restart_ret;
>
> 		restart_ret = ....
>
> Makes it easier to spot that it is an error path.
>
>> +	if (!ret)
>> +		return 0;
>> +
>> +	restart_ret = slf3s_start_meas(sf, sf->medium);
>> +	if (restart_ret)
>> +		dev_warn(dev, "failed to restart measurement after suspend failure: %d\n",
>> +			 restart_ret);
>> +
>> +	return ret;
>>   }
>>   
>>   static int slf3s_resume(struct device *dev)
>>
>> base-commit: 0efaefce4e95a3331550329c0078b2fb38b3ff1f
