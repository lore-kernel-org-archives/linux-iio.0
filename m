Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494A73E6DE1
	for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 13:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776172865; cv=none; b=qw2325kcIPrhfLrFD/PqcjMLVZatvYMi1C+8xZEryJ5cO1r8zdV1LwVpO8X9v1a7YXZTobZBtrSesNZK4A/mmrh4Fd8cSQPcjNZkwlRS1of9KTiQ7QirOBPu+7qTQubv9SAl29UMqRAuW3yFJGEkwmIaZTZyNAFwQ9hX8daxhzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776172865; c=relaxed/simple;
	bh=4QYgKeuSeFD0eNOKMMbOyXdSYuWNflG3V0djnFMlPvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nwC+dt8r/PhAY4hTTScWt7nVp7kAS4nniUHVLG7M2dX/qIFJr3kwj0TYFu69EejoJOBDa4ElPTM00v2CsIxshYAI/rBOsIr7NX5gobyrNdZFoDcTxD//Z9nkRHuDK2ZA1ZVyfi+yn8lNPGIB1NpFXZvEQUfWiUOUiLTH1GIXh8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=DIEDDlCg; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="DIEDDlCg"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-79ab3e26cceso53092337b3.3
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 06:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776172862; x=1776777662; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e9IoxLx9C8w0UWrmo+gGaqbRUyRrip85QzfvpWd/L8w=;
        b=DIEDDlCgKNpVhMAzBIBvBp5rt1w03YghEiwaC+SfGG5w+uYyAIOZ2bsHY8gKgjrpiK
         nNEuD3LREWBv3o/i8MutQ080Nn6XGCNvRNng8DuuqEE8oBUdovIeMQbAU+vKUZL5UQtw
         jqvTBbGm30JzA+uT5gV9iDILcSMmTepntWn4vse4UkdK9AY78BnKeaOPz7POM2E1LsP4
         7EHWocrgTd6G7py06zDPTdpRDBdzoFyJrjM1cVM0XCNBq5KoMgwRpV4/ED8sBoOWEziQ
         tFP2D6k4ieVFvpxCbYA0RCwESE+HlXO9YqBZ5NsWMT1J9HE8PTtE7dQKMvlv7xDcN0e9
         2WOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776172862; x=1776777662;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e9IoxLx9C8w0UWrmo+gGaqbRUyRrip85QzfvpWd/L8w=;
        b=tEaF7n71MolqGsUsZe9d5mOE2VXUc/NexeTiENrjAKUQ3VlStI8SyQPoRzLBKcrG5n
         J1CoUR0JhKeZOYfvOh+8fnMfT6eJViAfuTwGlCt6NVVMRKwaDDZs1MJ7SJR86r9F9xU0
         0Dd7fQkCExkLPaF87CVGkzgiZSKSeDONr1smYo0O44ZAjSVkqU7MIyrsy1yYM9pFl/vF
         /wGgg/deg1xCA9SEfYqaahXuXyayZ10bi9ONCIx4nAYUoZ5bFors3Qz9RIcAAnrGw6gB
         twWqw0qF37fjt3u8BbshvMGT4vT/3etX/X49R5Lc5B3aQ4y5F9Ki/ryPfO2cTFINXVUk
         XpaA==
X-Forwarded-Encrypted: i=1; AFNElJ+VIQWDirTzRZRorxjM7aEef4mg8Rbqev236AwEEvquesSG0iWf7merxGehiDwdBvd3ihNKhXG9Wf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrrLRIPFEl0K7UeVVA+lSPoR8I/MyPsPxJdlFMfFoqSmmjefqP
	dKb4TnQdYy2VTrgL9HbiGehjwQpiWDjqiQUWvxZTSId2W72AR8VX/4aCBST//WiOnoM=
X-Gm-Gg: AeBDiesokAhehkOKd1mZF/iC2uUIrT75imu3o+Ilqji7GOqRCYY2OB4WaaawgReSETC
	BdShfQB50o1A2m20XBbS81ACHYZq7MTFX3L2Gg9EkmUipvrN09PnMuHamtwrodB6Ukhbvaf0Bms
	s7CkpGNYcKPnNCBmMi20oBoz2wV9UmKBNLJ8MLgpnpBFFsC/UE2LCH4iiVxUJxTu1jUIZ8l35Gv
	//7v6UHNtlFeXL4PBT4YAbqXoNijbMxzPhKwk05r+hM2RLepPVPSBiJiA8YRN7LJ9DCRetBOFJX
	qgQjdsI53srp/w04o1JI2zI314sCJk6y7sjLkJrKSEXd4jnfNwjhK9ocbRPkQ/FD6jOs5zh5aad
	N9C9NuSfzUDbkPGFJ4M+CCnvdHP2qgS+rdUCZPKrCAOqSEvSzcRYtpwhNS2xKluN2Mc3j0ZVExQ
	iAsogdJ+IaVEYZR2MrCP9KelgJ79udnq8X2H/zBHi4ffc7AQwwp5Xq5sxb/tOS4B3e+RCgDgP0t
	A==
X-Received: by 2002:a05:690c:c241:b0:79f:5ce4:d6a0 with SMTP id 00721157ae682-7af71e43579mr193258787b3.36.1776172862116;
        Tue, 14 Apr 2026 06:21:02 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:5bfd:a817:5527:c417? ([2600:8803:e7e4:500:5bfd:a817:5527:c417])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af3d1c07absm67668977b3.19.2026.04.14.06.21.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 06:21:01 -0700 (PDT)
Message-ID: <70eb71c1-d239-4618-a12b-e64fff8e54d2@baylibre.com>
Date: Tue, 14 Apr 2026 08:21:00 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: dac: Fix passing uninitialized vref1_uV for no Vref1
 case
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Ariana Lazar <ariana.lazar@microchip.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dan Carpenter <error27@gmail.com>
References: <20260414-mcp47feb02-fix4-v1-1-9d71badfd25e@microchip.com>
 <ad43ofFZwzEkYifY@ashevche-desk.local>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <ad43ofFZwzEkYifY@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/14/26 7:48 AM, Andy Shevchenko wrote:
> On Tue, Apr 14, 2026 at 03:33:38PM +0300, Ariana Lazar wrote:
>> Initialize vref1_uV variable to 0 before calling
>> mcp47feb02_init_ch_scales() in mcp47feb02_probe() to avoid passing an
>> uninitialized value when have_ext_vref1 is false.
> 
> ...
> 
>> +	vref1_uV = 0;
>>  	if (chip_features->have_ext_vref1) {
> 
> I'm wondering what will happen if we do the below unconditionally?
> 
>>  		ret = devm_regulator_get_enable_read_voltage(dev, "vref1");
> 
> If we have no regulator, we get a dummy one, right? What is the voltage will
> be? 0?

It will fail with -EINVAL because dummy regulator doesn't have a
voltage specified anywhere.

> 
>>  		if (ret > 0) {
>>  			vref1_uV = ret;
>>  			data->use_vref1 = true;
>>  		} else {
>> -			vref1_uV = 0;
>>  			dev_dbg(dev, "using internal band gap as voltage reference 1.\n");
>>  			dev_dbg(dev, "Vref1 is unavailable.\n");
>>  		}
> 

