Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29E937AA97;
	Thu,  6 Aug 2026 02:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785982910; cv=none; b=VuWdaGwHkeI9n8TbT9LMi7Qst/7QZQSngmpG4G7doB3DBobZTg2RypiIyArN/c5WhuJ18rcQJVJF0+1b1kBApy6/xhZyMgstmHCrXrHNDTFAGEbrINa7PFULyadkvJCH9JCWhtEUaMJ0vquEyGHONqB4vQqOBMoR1k7LDy1bw6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785982910; c=relaxed/simple;
	bh=8uoyAPcsSt8J/qGZdG/JsjWwdFYDy/vyl2iEds9af38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WdFyXZPWnmsaS87GSqQP1c7lcr7DksLDo96UTD9fYxUktUspOZL/l749Qv2oToilyHBdWAM4YuE3Bn5hWTE9Vt1InDz8dTTqImdYlLmdXTD5xZl1ueKhbDlqmjx9BZDXq4193cSjQ5KOswn19QFOOCzuvJb+weHGlHIQVoWGLb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9143600e913d11f1aa26b74ffac11d73-20260806
X-CID-CACHE: Type:Local,Time:202608061018+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:333f92e8-8d1a-4c75-a442-4c662475927b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:7b60ace3d7fdcc7f8ff96baea4633948,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0
	|15|52,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
	SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9143600e913d11f1aa26b74ffac11d73-20260806
X-User: lilinmao@kylinos.cn
Received: from [10.0.2.15] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 655876035; Thu, 06 Aug 2026 10:21:44 +0800
Message-ID: <b61d786c-9200-46c6-9072-d7c43639b6b5@kylinos.cn>
Date: Thu, 6 Aug 2026 10:21:39 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: flow: slf3s: restart measurement if VDD disable
 fails
To: Maxwell Doose <maxwell@maxwelld.cc>
Cc: Jonathan Cameron <jic23@kernel.org>, Wadim Mueller <wafgo01@gmail.com>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260805110255.504576-1-lilinmao@kylinos.cn>
 <CAKqfh0G82W5wWg2xMs_qRcUAWCk1Uq1BXTPAD885h6k8sJi8Gw@mail.gmail.com>
From: Linmao Li <lilinmao@kylinos.cn>
In-Reply-To: <CAKqfh0G82W5wWg2xMs_qRcUAWCk1Uq1BXTPAD885h6k8sJi8Gw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/8/6 0:45, Maxwell Doose 写道:
> On Wed, Aug 5, 2026 at 6:07 AM Linmao Li <lilinmao@kylinos.cn> wrote:
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
>>          struct iio_dev *indio_dev = dev_get_drvdata(dev);
>>          struct slf3s_data *sf = iio_priv(indio_dev);
>> +       int restart_ret;
>>          int ret;
>>
>>          guard(mutex)(&sf->lock);
>> @@ -470,7 +471,16 @@ static int slf3s_suspend(struct device *dev)
>>          if (ret)
>>                  return ret;
>>
>> -       return regulator_disable(sf->vdd);
>> +       ret = regulator_disable(sf->vdd);
>> +       if (!ret)
>> +               return 0;
>> +
>> +       restart_ret = slf3s_start_meas(sf, sf->medium);
>> +       if (restart_ret)
>> +               dev_warn(dev, "failed to restart measurement after suspend failure: %d\n",
>> +                        restart_ret);
>> +
>> +       return ret;
>>   }
>>
> In addition to David's question, why reenable vs keep it sleeping (and
> why don't we dev_warn() after regulator disable failure)?
Because a failed suspend callback means the device never gets its resume
callback, so nothing would restart the measurement.  And as the comment
in probe() says, a stop command sent to an already idle sensor errors
out - slf3s_suspend() returns that error - so every later system suspend
would fail as well.

No dev_warn() on the regulator error because it is the return value and
the PM core already logs it.  Happy to add one if you prefer.

One thing I noticed while doing this, not specific to my patch: the
datasheets for all three supported variants say that after the stop
command the sensor "needs up to 0.5 ms to power down the heater, enter
idle mode and be receptive for a new command".  probe() and
slf3s_set_medium() both send the next command right away, and my
rollback can too.  Is that something you have had to care about in

practice?


Thanks,
Linmao

>
