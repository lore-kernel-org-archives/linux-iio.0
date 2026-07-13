Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9972BCF46
	for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 03:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783913616; cv=none; b=pKtcuavcjGOE5kHYLhdl4kPJ6LtBJiktJ4VJHl0mdfNf7fLXiGwk4tcdlcLtVVZjdc1Hd+hJgUaADhgFFIZptyF0ruuJwZLW/U3Uz9He2c+w5xULyQny/xd3uIwH/rDx1gZbpuA4+7Zo2+Pge0EdIEXqTtKVzkYCeacdreaCC4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783913616; c=relaxed/simple;
	bh=FO0sdiv2KgDK6VD113Oh3Pv7byNpquq6SyZpulPnUn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kz6woFodxcYFtStvsxw145Xh9qw5iMAVrwruUXQolibs3GEgi2MdoU8tP1PhCDrgstY/J4A3QqjckbmZp/c46slC1+AZLK6jgUBze/KkukdQ1E4vVhQSuSKminTXUipiJUx0yjJvLyEnQiEdOcR1Zg11suDsTqPj8NzaorVlU4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gy55SqiR; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gy55SqiR"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-381b831d535so3119732a91.0
        for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 20:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783913614; x=1784518414; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dRzPveD+KOFZtYU49xSentCNs/Jbn07eF6RCpZrdRsA=;
        b=Gy55SqiR56R+kIrdQzjroFecKjVViZV5i/UH70oGD/7G3KUGZVdd5WABm7GEANWOnc
         M/5fK5KE+LK6oRzrYJG6xElZcf3MVcrJqVF/mQ9j+UzDAHDwb3tehI3lEljmKuLaVHDQ
         UdWD+sksfv8AtjPq99zsIs5n2h8MeBhKMzAZiCiJvaGq6Fup2igJ1M+dDnn5V53szCbg
         71popAVimDEx5aAk/rR+EX/hdq6rks6/LDx2QJvGL1E8og3wE7JDFBegX9AVcyMVVASR
         Hrpb1m5ReQ+PIY+6DIEiLdIQikqjPFEbSIA018NcRaRbYleZU0L6mJfu1CKV9pSrhAaj
         prSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783913614; x=1784518414;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dRzPveD+KOFZtYU49xSentCNs/Jbn07eF6RCpZrdRsA=;
        b=b9HAknfYRjtkpHCwjdH1xYurhs+AetoJL6nXWjbBLpZRAhEsGxkmJHVFotcM2oGw1r
         GZFB2r90m22YdeFXNpjbTWrRWRSCVnUiXK3W9myPF0b68ilWhj6PCKJcEDeZ7g2WZLiL
         6rJOTc35AChJKTUsJMvKqW6rBEW8S+cAShzfUS8e5K4dtvXV6FtKQz0LS9+MT9eULUlf
         Ii5E+KRM6220OIwpjwYnQkDsBYNUziLADWyjioLuyxh5mW8Cca4Xb89GS8vSv5WjrhrI
         d0nSPTCWVvobt7BINDxrc4/x6Jm6nEpzKogkQfOVXn+M82y6eMhBsXa7IIQHiJXgM/yJ
         qVcQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro8wwugYsEFDUxrZmyNkACWq3KwZZhHSz8zpDQ9Gd8+yoKx3UbNdHb2S+iHNv8TTk/VPbJD95TxvWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKXNz/c/C9Wix/sHirvEKQzwsDK8NuXxH0MaYxh1oNWitdel/N
	BGQoEF4LcfrqojfVe4Kgny1zDnO1oQvtPEmyhjhHB+BwyRxB8jOG2TE=
X-Gm-Gg: AfdE7clvl/GR709kL+zs60u5fxXQB2LlYqCrRT3WaKFDturIPv6WJ1PQloQVfRLzC8Y
	ieFwtyjpHT4wZXIy2IGfld14dFP+OaYCirTiSeheoulG7MCpbUz/fMxj2ay0ggUQFQSceu1Hg9G
	n7/BnGsyt8/VbxZm+1GpaSEjjlUceEo7ckEgVEoWm65yw9zivpW0WPVsFE0tcfQdoWBtEn5gBhO
	O34ocQzQjfuUp7/HMAAdgtC2W8WVqfPKlJMvJHVe7xoWs7dkuF4O3/3K70VhJR/Gmjr62czzev9
	QFHn1+bUSsXKFVw34sr+Gf0Ge05YDBFXt3+VYibCWBr0M8/izUOR0qHfp7nAMvYwvGvaYfl7exo
	vZylM8dbr3XgQxUlPS2HEy34gW6NXwsBtpT7BAa6kqzUN3eGIUJdpEWampJrht45mHHlD1I/MB2
	4un7jk+VQWXQ2simjbfSbeZBdQE0q+xQbEmX9hiogjNFLLhx+TEY+ajG/Y6Q==
X-Received: by 2002:a17:90b:5443:b0:37f:9ce1:cda6 with SMTP id 98e67ed59e1d1-38dc7735b02mr7759350a91.28.1783913614343;
        Sun, 12 Jul 2026 20:33:34 -0700 (PDT)
Received: from [192.168.1.45] ([101.0.63.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f72a6sm75086924eec.1.2026.07.12.20.33.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2026 20:33:33 -0700 (PDT)
Message-ID: <6d7e489d-5438-4a76-829f-45796f1a4117@gmail.com>
Date: Mon, 13 Jul 2026 09:03:29 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] iio: light: opt4001: Fix read-modify-write of
 wrong register in power down
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260712202451.20822-1-nikhilgtr@gmail.com>
 <20260712202451.20822-2-nikhilgtr@gmail.com>
 <20260713014214.74a12af9@jic23-huawei>
Content-Language: en-US
From: Nikhil Gautam <nikhilgtr@gmail.com>
In-Reply-To: <20260713014214.74a12af9@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13-07-2026 06:12 am, Jonathan Cameron wrote:
> On Mon, 13 Jul 2026 01:54:48 +0530
> Nikhil Gautam <nikhilgtr@gmail.com> wrote:
>
>> opt4001_power_down() intends to clear the operating mode bits in the
>> CTRL register but reads OPT4001_DEVICE_ID instead of OPT4001_CTRL.
>> The device ID value with the mode bits masked out is then written to
>> CTRL, corrupting the conversion time and fault count configuration.
>>
>> Read the CTRL register instead so only the operating mode bits are
>> cleared and the rest of the configuration is preserved.
>>
>> Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
> Fixes tag please (you asked in the cover letter and yes it is appropriate
> even though these go all the way back).
>
> Looks correct but I think we can take this opportunity to simplify
> the code whilst fixing the issue.
Sure, will add Fixes tags.
>> ---
>>   drivers/iio/light/opt4001.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/light/opt4001.c b/drivers/iio/light/opt4001.c
>> index ba4eb82d9bc2..f2cf496cc243 100644
>> --- a/drivers/iio/light/opt4001.c
>> +++ b/drivers/iio/light/opt4001.c
>> @@ -228,7 +228,7 @@ static int opt4001_power_down(struct opt4001_chip *chip)
>>   	int ret;
>>   	unsigned int reg;
>>   
>> -	ret = regmap_read(chip->regmap, OPT4001_DEVICE_ID, &reg);
>> +	ret = regmap_read(chip->regmap, OPT4001_CTRL, &reg);
> Let us jump directly to a regmap_clear_bits()
>
> It will fix this issue and generally improve the code readabilty.
>
> Given this is only called in one place and the code will be nearly a one liner
> after that change, lets also just  move it directly into opt3001_chip_power_off_action().
>
> I my opinion all that is just about fine in a single fix patch, rather than a
> separate fix + code cleanup to follow, but if you would rather split it up into
> fix first then refactor I don't mind.  I may well decide to mere this whole series
> for the next merge window anyway just to ensure it all makes it reasonably quickly
> (at expensive of the fixes making it in a little faster and possibly delaying any
> cleanup).
>
> Thanks,
>
> Jonathan
>
Agreed, that is much cleaner. I will move the regmap_clear_bits() call
directly into the devm action and drop opt4001_power_down() as a single
fix patch in v2, with the Fixes tag added.

Thanks,
Nikhil
