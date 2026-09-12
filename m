Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DBA41B8E4
	for <linux-iio@vger.kernel.org>; Sat, 12 Sep 2026 10:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789210435; cv=none; b=HJ6iP8onjC8EpyIs0t6IqSB5dKv/QNpEaanFWMBWRTKoxmoLOKoHFh9Z+iHzN8bKgUusWVCkJHGP5G2CEhHmO1t+u7yM+N0cX8Bz1xpwsUlOPWi8Oa7ruaQLbjktr92sxpZqAToNzAmdjN4xrlOF2aDWjTNdum9jZtvNm7Sk9AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789210435; c=relaxed/simple;
	bh=+3dgw+SyqyP5cHz3qKsr2NG5x9quI0kysHekgOkcwK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IgrnwRiUKPqA+UBgDcXpsgmC8TUr6GFYXUL2GttvW2+73Chkp8I53Lax3nmE+O9gvfFdBGrvQn8tQ8yp+dFMj404seWm+jbPJ4hE9AtJOfDEg8oMe7WIdqLdm5rIcjaXfvDXRUV2aYXkATy8sBbErcNE5yXH3dJNZdTixDiV7JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=S9JjDC74; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="S9JjDC74"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747eefae4so1634775ad.0
        for <linux-iio@vger.kernel.org>; Sat, 12 Sep 2026 03:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1789210433; x=1789815233; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nr1SLU55rNmWqCBEV0vSapMHoC3fE3LeZrZJe5Yc7T0=;
        b=S9JjDC74P76PzYj/1h7I5r9EnzQH/OSmtHdCV8g8+EwC+sAbfRW74ItbNbUsr4CPTZ
         uIth046ZaChCQk6e9nCOuzJ5AV92lkQYaw9oLoJHNxhclD2kdeztyzgd72bPa+sntQ8/
         Cjp8ejH+g0N+cSN/BILf87k0yP1OZ2t1vh/GDx9x4+Iq4LEZShLEgjFTpiGrjzH67ITO
         n/7OzChpUYC2JO0jFinPaXhU7gUI3M4xYZS40py2q91oVvDs/xAJ/ucUqQ5b1gOcMbAn
         Lc8wTCmZSUwNzsy9/McTVUXEZzDttw8pEOBcl/amF8uCU7dl3grczM9NchEJz9ofA1e+
         HxxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789210433; x=1789815233;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nr1SLU55rNmWqCBEV0vSapMHoC3fE3LeZrZJe5Yc7T0=;
        b=KeN2YONoQcCPIkT1kd7pZr4jpwgN4ghndSIC+AhbVOW4sVJm5FfoJ0zi9y8XOGYYE4
         npe2A+AVlk6Yq/eo9qk8Q90TylTKHuz9J1LcVimeRPosSVv81YNXaJFRzIkJ0dN/APMz
         JaKj6E5eq0XuUKdceK1RdIlqu3fKBCw3+A5bvDy+dOLiDFOFlbrDCwN/s9Z2B67RftfQ
         JM51wmnv0zfxk9ldtjMEas2UisB0Hyg0G0scMVpkSpyjHdK5AoUFXpga1eRufTbzXSq3
         wRa08bJlNbwPirIPokXG9DROcTO6f26aL7gBof71UYDT4WBhWhpeWkJxxT6xrR3S5Z8T
         sOOg==
X-Forwarded-Encrypted: i=1; AKwUvByPAttaYL30BnDnVlGVIVBt+TxDGmKsjY5nyFriozver5dZFsCuxIC3tjf6cobqtgvo0BEnrOJONzM=@vger.kernel.org
X-Gm-Message-State: AFuF++keKKVoR00vQuMIxLU4CCcHB4axqDCLFxJDsNrD26b4ebtPFH3i
	JZXfytmKY/K4VSxZTBYmUkHC4RQLsFKsOJ0XixwCpJkoyYR7Gg7d7bFyfZ8iBx/0ViA=
X-Gm-Gg: AYBFou2sm9IwDZV/nE5/B5xqmdmGQEKvEErEF2kJMmzEvHJhqneCJrmXDYdtXDPGjPt
	JZawzwttPFY2fALIE1lIgkJFY3OUhuLP4HoU2IJcDR6fJlj8LV/TM/ivQbw5Sh6TjlZKZrulpw8
	RSPeSsVbsAXh+jYhMk3Kdv3t9vxSRgNOEMcoHznvsZF3+f1uiFYuy9q6jRVL4ec+JsfTGuk6Wb6
	WY9JcN9KqmL4lehgUWlstqWtI6XLEZjlL1fGZEAzXHKzoso3vGwQAhHOyTreKWgh9Jw97WgxHiQ
	lgAtVcCC12CPvpulejf6qWh1z40QtrH0N6VoaH6kbufgvQD9gEue47UOc0l2WoZbmuAqWBZkhfb
	eGi/zply6l4FlUB90Z3zktJvpQ4VuLcDXYRIsIjZVqYtrGKherfXJE7T7LEhyV8OpxHtSxIgqZb
	NQohgaffY48G1qpGphdwE4RcoPxNRUVVWbdhr50e1HQEmBX5XRD6MRyWhJepWccdUhoA28l7IiV
	gsPqjuEeTqpHgRNRdvrghLCyqeaoWD9g+uaK+qzfybyAKcEf0daiX0Yvchumdkp
X-Received: by 2002:a17:90b:2542:b0:398:9bd3:d6d1 with SMTP id 98e67ed59e1d1-39d9805e1a8mr8139982a91.11.1789210433156;
        Sat, 12 Sep 2026 03:53:53 -0700 (PDT)
Received: from [192.168.50.161] (61-245-156-102.3df59c.adl.nbn.aussiebb.net. [61.245.156.102])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d99531b21sm9549704a91.13.2026.09.12.03.53.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Sep 2026 03:53:52 -0700 (PDT)
Message-ID: <56f77aaf-30ca-451d-b3f4-8a80f3be1c6a@tweaklogic.com>
Date: Sat, 12 Sep 2026 20:29:36 +0930
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iio: light: apds9306: fix default sampling frequency
 definition
To: Jonathan Cameron <jic23@kernel.org>,
 Tsz Shan Chan <tsz.chan.dev@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Tsz Shan Chan <tchan@jacques.com.au>
References: <20260904-apds9306-v3-1-4f668393c2ae@jacques.com.au>
 <20260906045929.0a1c46fd@jic23-huawei>
Content-Language: en-US
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <20260906045929.0a1c46fd@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/9/26 1:29 pm, Jonathan Cameron wrote:
> On Fri, 04 Sep 2026 11:19:48 +1000
> Tsz Shan Chan <tsz.chan.dev@gmail.com> wrote:
> 
>> APDS9306_SAMP_FREQ_10HZ is defined as 0.
>>
>> According to the datasheet (Broadcom AV02-4755EN, page 11,
>> ALS_MEAS_RATE), bits[2:0] set the measurement rate:
>> - 000: 25ms  (40Hz)
>> - 001: 20ms  (20Hz)
>> - 010: 100ms (10Hz)
>>
>> Change APDS9306_SAMP_FREQ_10HZ from 0 to 2 to write the correct value
>> for 10Hz.
>>
>> Datasheet: https://docs.broadcom.com/doc/AV02-4755EN
>> Fixes: 620d1e6c7a3f ("iio: light: Add support for APDS9306 Light Sensor")
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>> Signed-off-by: Tsz Shan Chan <tchan@jacques.com.au>
> Looks correct to me, but as driver is only a few years old, I'll leave
> some time to see if Subhajit is still about to take a look.
> 
> Jonathan

Hi Tsz,
Really good find.
I am just trying to find out how this happened as this is not a logic or implementation error!
Let me rig up my test setup, read back from the reg and make sure it gives 0x22 without any init.

Looks all right to me according to the datasheet and init sequence.
Acked-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>

Thanks Andy and Jonathan.

Regards,
Subhajit Ghosh

>> ---
>> Changes in v3:
>> - Move datasheet URL to datasheet tag in the commit message
>> - Link to v2: https://lore.kernel.org/r/20260903-apds9306-v2-1-e8673986ae56@jacques.com.au
>>
>> Changes in v2:
>> - Add datasheet link to commit message
>> - Remove blank line in the tag block
>> - Link to v1: https://lore.kernel.org/r/20260903-apds9306-v1-1-3f892aa4f156@jacques.com.au
>> ---
>>   drivers/iio/light/apds9306.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
>> index f681b02e4922..7dd41136734f 100644
>> --- a/drivers/iio/light/apds9306.c
>> +++ b/drivers/iio/light/apds9306.c
>> @@ -61,7 +61,7 @@
>>   #define APDS9306_NUM_REPEAT_RATES	7
>>   #define APDS9306_INT_SRC_CLEAR	0
>>   #define APDS9306_INT_SRC_ALS	1
>> -#define APDS9306_SAMP_FREQ_10HZ	0
>> +#define APDS9306_SAMP_FREQ_10HZ	2
>>   
>>   /**
>>    * struct part_id_gts_multiplier - Part no. and corresponding gts multiplier
>>
>> ---
>> base-commit: 940de590b839f71d6dc846160534bf202401b8b7
>> change-id: 20260903-apds9306-bedba7b74e59
>>
>> Best regards,
> 

