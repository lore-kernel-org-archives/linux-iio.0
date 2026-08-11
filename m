Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326A241A77C;
	Tue, 11 Aug 2026 10:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786444346; cv=none; b=XziabXmGFRehD52CzIPnqtQ/npUOEcgd2kEHwTPJW5ZSiTNAAFqoLYSAHdiVn8G9V28qzfQUcdsBZUOxo1vJ1vLlyBW7rKv2e+nWCD6q6X6nwbwFvVTJj34c69FMzNYCFRA328nj3iLL8uTbfPbDhr++0+dMqLPUdI1lBWpBsgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786444346; c=relaxed/simple;
	bh=6IMTf3+1jC4yr6wr5n8bSO4qA9cZA7pNkezlnwPDjxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B7Dh4GqfZAd7AC2JEFMiECJyThJE0cfUIk3mPuc7/sKi76aYyxHDMATCwChf3ch/V2YS9PtEZoqqphi91e1jKCEgvyo6HBByknhytvrrrMGXAt5XMoDO71cunRs2brS68KfTyfHfhvbQZ+FcQ+20WN40orRdujO+GG/+zL5sGnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ed35bfde956f11f1aa26b74ffac11d73-20260811
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:0a805d15-0d64-410e-b44e-3ce478f7bdf6,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:d49b12fd2e25a25e7eef250c2f915ff9,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|136|865|898,TC:nil,Conte
	nt:0|15|52,EDM:-3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:ni
	l,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ed35bfde956f11f1aa26b74ffac11d73-20260811
X-User: lilinmao@kylinos.cn
Received: from [10.0.2.15] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1219464849; Tue, 11 Aug 2026 18:32:17 +0800
Message-ID: <6cc3ae53-1c47-434d-8c57-724e396d20a6@kylinos.cn>
Date: Tue, 11 Aug 2026 18:32:15 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH togreg v2 2/2] iio: imu: inv_icm42607: restore runtime PM
 on system resume errors
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Chris Morgan <macromorgan@hotmail.com>, David Lechner
 <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260805035451.487465-1-lilinmao@kylinos.cn>
 <20260811020345.950137-1-lilinmao@kylinos.cn>
 <20260811020345.950137-3-lilinmao@kylinos.cn>
 <anrjMowu4HT1yiW1@ashevche-desk.local>
From: Linmao Li <lilinmao@kylinos.cn>
In-Reply-To: <anrjMowu4HT1yiW1@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/8/11 16:54, Andy Shevchenko 写道:
> On Tue, Aug 11, 2026 at 10:03:45AM +0800, Linmao Li wrote:
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
> ...
>
>>   	/* Sync the regcache again after regulator shutdown. */
>>   	regcache_mark_dirty(st->map);
>> -	ret = regcache_sync(st->map);
>> -	if (ret)
>> +
> I wouldn't add this blank line as these two are quite coupled. OTOH it's a
> better style, so I leave it to Jonathan and others to decide.
>
>> +	return regcache_sync(st->map);
>> +}
> ...
>
>> +static int inv_icm42607_resume(struct device *dev)
>> +{
>> +	struct inv_icm42607_state *st = dev_get_drvdata(dev);
>> +	int resume_ret;
>> +	int ret;
>> +
>> +	ret = inv_icm42607_resume_core(st);
>> +
>> +	resume_ret = pm_runtime_force_resume(dev);
>> +	if (ret) {
> I still don't get the logic here. Shouldn't we rather call the force_suspend()
> last in the .suspend() and force_resume() first here?

pm_runtime_force_suspend() may invoke the .runtime_suspend callback,
which writes PWR_MGMT0 over the bus. It therefore has to run while
vddio is still enabled, before inv_icm42607_disable_vddio_reg().

On resume, vddio and the register cache need to be restored before
pm_runtime_force_resume() re-enables runtime PM. Otherwise runtime PM
could be enabled while the device-side resume has not completed.

This is the ordering already used by the driver; the series does not
change it.

>
>> +		if (resume_ret)
>> +			dev_warn(dev, "Failed to restore runtime PM state: %d\n",
>> +				 resume_ret);
>> +
>>   		return ret;
>> +	}
>>   
>> -	return pm_runtime_force_resume(dev);
>> +	return resume_ret;
>>   }
> Okay, after reading other drivers I think the above can be written in a bit better form.
Thanks, I have used this form in v3.
>
> 	struct inv_icm42607_state *st = dev_get_drvdata(dev);
> 	int ret;
>
> 	ret = inv_icm42607_resume_core(st);
> 	if (ret) {
> 		int rc;
>
> 		rc = pm_runtime_force_resume(dev);
> 		if (rc)
> 			dev_warn(dev, "Failed to restore runtime PM state: %d\n", rc);
>
> // and yes, I would go with longer line here (that's why I renamed variable)
>
> 		return ret;
> 	}
>
> 	return pm_runtime_force_resume(dev);
>
> It seems that if the above analysis is true (I haven't deeply checked that),
> there are many drivers in the kernel suffer from the very same issue (when they
> need to do some work before runtime PM resume may be called from inside the
> system .resume() callback.
>
