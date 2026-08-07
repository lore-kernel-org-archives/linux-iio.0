Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26444379C48
	for <linux-iio@vger.kernel.org>; Fri,  7 Aug 2026 21:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786137526; cv=none; b=aPp1F7EmdV7cggtcZWqqvd/PwztMQFrzbFegZNDvOcJ0tFU4jHfOqHo6+DjJLhFWaULuOBPWi+SEE8VQW6Q/Zrz9Dq2wFy6sPtR/S42uWPsl4TBz7o7olvqokexJtXt56kkQrXsGMyVDL85yR9CHd+nggifPaNGY++No78bKTFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786137526; c=relaxed/simple;
	bh=ebwt30Y0Zh/vgceV7Qyq27GLp9L8sKExezLdZMd479U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q+mkSKvqqB3ts12fH6vyC2d7PM13wO8xZf4kZRQkilIBbbnubHy1zmPMkQQ/M6iZCxlYMNdsTYoR/VvR2pkFS1OeCOINPu85Kl95I/O9JKxG2qBhfi9NLt+xV2oEH/XnKgx9ccsxRYy6PYJUtkNT9qq0oc3oFsIUPGuErLD5QCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=SEJ8GflP; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="SEJ8GflP"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7ec3b429a3aso34225a34.1
        for <linux-iio@vger.kernel.org>; Fri, 07 Aug 2026 14:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786137523; x=1786742323; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iK39GoECH7eBfBcXOc+Hr3sqqq4Dev0XE+0hVdtjYDk=;
        b=SEJ8GflPOjHnbyen8qq6Wah5XTz/mU7kD/G76I1gauZa4siBlGDw6R47UGZW1hDc9W
         ZeKCBJpcWLSY01pzfuwffFHZtKjyODpuINq3zk1l1P2uXAE4vR5Wd0NAdRyjmmjC6ZT2
         61oePwbIfsyjEFbXMrSh7sv5p53xqgfsyjrQe29qNYyxEL09GBWDHjmE4ot8A3V4japv
         5FjeivXDPXeFnIW8wNft3jUC0KNkvf5T/afE2WcU1BSqj5ipK/tbcA3ZgDT1bqlnEnAM
         5MRjNAnSyLfyL0JQnvQleUnRBM0DcmebDpsToMYZL2yruhmIzDKpR6KSlIL7g7aQflC7
         UZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786137523; x=1786742323;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iK39GoECH7eBfBcXOc+Hr3sqqq4Dev0XE+0hVdtjYDk=;
        b=qTZvkP98WWGQb8jmRxxhnN4MyKYVVFhxexzSZmbIkp+SqjB/vbkDvH/BnQmC9d/z8j
         Fsy7R2RT1kEj16u63eC+3E8jKbUlJ8A67slmjThRDlPF5yYjvaqGUOlzq2aq4XBECgfN
         LCcS/YqxnDf1UMi9Gzqria318xTGk58bO83B43Hy3CKYEMvJmlRwd85/mNkBgqKWzJGw
         s2J8WMu8rmz6+k8cjZPNmnskvau157T3L57Fv07ECnZnFSMvBw6oKbaX9qaayZyTL+RM
         3nIPQZ1AkGKBfTG1qcxu7J/Di5nhwTK+3cy99kzox7P0cHyzXSygiUGTZySEYaC9ulio
         md7g==
X-Forwarded-Encrypted: i=1; AHgh+Rr402grr3pDAF1il61qwx0Dk0G/vXCh7QIF1Z9EpmvCemSM7L9txf2zfi/T351ouOTozFVWZonM4cw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUhazcVPKH6ct3dAVH3GvT8eKz1+awTRNcziiZA3NMD8/iDc5e
	5cyp86Eu2n6Vxh8WOUR8gKEu+dCi86RnWLFuAicYPVF/ht6pN6pdj3yOZppqKTsqkwE=
X-Gm-Gg: AR+sD11adJibc4H1GhWwftc6XAc7//xEAi6eNhfIZj4tNAsUxtmm7cjuAPcwjUIL8qO
	hITJK8sL4Hs6gWEk/FPkcwct0enK4Uf1ZQSlBIK7EzS1E8OyAjrX9jeIbhuYs2wJvwzpO77yio/
	1x4AWLI7n6ReCgHNCOJc/2mDHNrfqP+c06qIaapKn4Aq35HmW5PY92MOtNeg+A/rcvxrxTN+4sy
	mhMYD07YqPMftdYUDfPkSSpobYhPcHrMfXx1auwoa0e3IDMQOluXqKwnuVIQdq5W+36aEpGnJVJ
	Ole63aEvYsMhUtnAe27nTfEsA7xn6CxXDww5APit2yKFrtReMkjRrQy7vcQyqXDHROuMZS7k83R
	FUR0XOhr8W28QLhv08X3rCCH/527pwaKDlAWc4aA4+prQ9onMbdJ+eIKdnme3DKrjPPjL4yQV0i
	BnGVkDwKrlVRFZa0Z6pWiSdAUDVebY3GZlL/3Xzz65qbAlmg81pX+JfXqLhaS6bymA5TjYXXx8Y
	XP+ptQlsaA/3to0JxAhrjRuXANFTiHqjd8b
X-Received: by 2002:a05:6830:3913:b0:7e6:d0ad:5254 with SMTP id 46e09a7af769-7f1e5d8da15mr19311167a34.8.1786137523090;
        Fri, 07 Aug 2026 14:18:43 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b714:88c:313d:dee2? ([2600:8803:e7e4:500:b714:88c:313d:dee2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f35b2edd41sm2073828a34.0.2026.08.07.14.18.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 14:18:41 -0700 (PDT)
Message-ID: <05baac51-bb6c-4a2a-9587-4ae3e30aee21@baylibre.com>
Date: Fri, 7 Aug 2026 16:18:40 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] iio: adc: ti-ads112c14: add support for I2C CRC8
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>,
 Kurt Borja <kuurtb@gmail.com>, Nguyen Minh Tien <zizuzacker@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260727-iio-adc-ti-ads112c14-buffered-read-v3-0-cbbcaf030148@baylibre.com>
 <20260727-iio-adc-ti-ads112c14-buffered-read-v3-1-cbbcaf030148@baylibre.com>
 <anUwKGyjjwYxQ8NI@ashevche-desk.local>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <anUwKGyjjwYxQ8NI@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/6/26 8:08 PM, Andy Shevchenko wrote:
> On Mon, Jul 27, 2026 at 09:09:50AM -0500, David Lechner (TI) wrote:
>> Add support for I2C CRC8 to the TI ADS112C14 ADC driver. This verifies
>> data integrity of all I2C transactions with the device.
>>
>> For now, it is always enabled, but it could be made optional in the
>> future if needed (e.g. for higher-speed data acquisition).
> 
> ...
> 
>> +static int ads112c14_i2c_add_driver(struct i2c_driver *driver)
>> +{
>> +	crc8_populate_msb(ads112c14_crc8_table, ADS112C14_I2C_CRC8_POLYNOMIAL);
>> +
>> +	return i2c_add_driver(driver);
>> +}
>> +
>>  static struct i2c_driver ads112c14_driver = {
>>  	.driver = {
>>  		.name = "ads112c14",
>> @@ -1217,7 +1347,7 @@ static struct i2c_driver ads112c14_driver = {
>>  	.probe = ads112c14_probe,
>>  	.id_table = ads112c14_id,
>>  };
>> -module_i2c_driver(ads112c14_driver);
>> +module_driver(ads112c14_driver, ads112c14_i2c_add_driver, i2c_del_driver);
> 
> This is not needed if you call crc8_populate_msb() from the probe using
> DO_ONCE_SLEEPABLE().
> 

Good idea, but this series got picked up already.

