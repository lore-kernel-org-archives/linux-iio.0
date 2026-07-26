Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0548C346FAE
	for <linux-iio@vger.kernel.org>; Sun, 26 Jul 2026 11:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785066265; cv=none; b=ILuG6pFXIuqmAwhUY3jpMvnMrj4gJJjB4l0kShHeK5SQ6HGj7w2yvMHP2MrquQCxV4oAUsJC+Vo2Ul+vn3/wUwG/U5vt4F77h4N7aK6mK+/HEGcBN5J9sknUn3SJ30jmO9ect9MB9NFxrDNzZakSQ9dYdhjLrvXBXE6brPoqBpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785066265; c=relaxed/simple;
	bh=aRAxuoFIpT5iiNuX1y0oJLKjAX7jWXl8mgVLbL0uStE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hga4Lpvr5ylG9+Z5Np9qwa8pZDPV1fIqHx+2HoPUuJfZvAvzk1bOZpBe7AOK2YvxFW94RmFh+NKkhcEi7BapocLMDCOaskXNq550Uws67+ckdqLp2OOX7lnjt4f2vCWh0Uj+Ehc/0y0Gq0/0xFgcVnSXiJmA/pcXbMLzq4iMfmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFY7V1+e; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFY7V1+e"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4955158f26aso11839005e9.3
        for <linux-iio@vger.kernel.org>; Sun, 26 Jul 2026 04:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785066261; x=1785671061; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LlEYYQFwJ049ecKkONrkZDcdDe6IgGEY4lTlwkRmH6g=;
        b=eFY7V1+e+2jBJGaasmYGIk3Y6lKIazs1dNK4t6LLpX1rloQslNI8HAzj6ngu6sgjQT
         jbS3gOZavUG9iJd9co3urMnPWl+S7v9IQT/zshd+Q7pFI7qpwlKdd1h8td7HCQ0nJRTk
         h1MmpdU4zbjzzd0FmEKtpUCFM1oWYfbOqIn0pyttiPgXc2lemBuJFHxdakTyvYk7MTHm
         V9p3Q64vRWCeHqUMmFVLmy7bptv95PaBoYIVIY61UUuLH7KnTYO++ou2WzzhW6RpyDLE
         j6zQ08RHx7AN99PrfYOwjj9C4Cf3OAeajDir/eEciQX5Y00KS+el4UpXzps6ARBANeeW
         27Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785066261; x=1785671061;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LlEYYQFwJ049ecKkONrkZDcdDe6IgGEY4lTlwkRmH6g=;
        b=MViE3u+Uw2zHXuCG8MebVKFk/2uzS1h4Rly1W9AE1sLxbyVLLn7A19CV7K3Sp8ei6F
         qFiRAnPbL7/2mrNEIvjtTmC6Q6FYEdu5xoI5DwBPP1okTTRywf83iJUSobTSnx7aj1Ph
         egp0vPTYT4XnsQV6P5I2vihEf8YbzYwzvh8+lYAaJxHfNatNGHobSfbc8Z7SXI9bFTVN
         c1sEORTYS/pnClCYd2S3nQFbxBS/H+j57MyHpWy2vp2WVl5fae+ewqgkb019f3C+73S3
         QfO+O9FYBk4CAaXACFQ8UWNczYF8pVz/h7yFnBNm9Z2WsPCWfrPJYePA1B2GCaTETJlF
         Ym/A==
X-Forwarded-Encrypted: i=1; AHgh+RrvobGG8/AbXpIDhqJUTdU4puciiDyxKrQEbKQpn4i0g4KCR7iIZ2OyZKlObJD47HDJApdmhriVEeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEjMU/y7k8M1P2K5Uj4VO4lesI9nKYXnmNeekbKbC6tS+p083f
	9XUwLzrQEbmn/iPSyXBucpnvRFqdKs+Mlbhtuib4g2augMyArc5RY3k+
X-Gm-Gg: AR+sD12S4+pcg+0LIvKcvITF6gIPjBfMIFBROZKUV+B2j4y3ddrHXGWI647VlsDAuhV
	gJ293ixpaU5Z09AjFviuIaAWe2oGDm+foZzhcZKxFwk3JfV29qj9lSdXbFG1/q9PRy6gtEraTx5
	LhOnc5BAcQLFfyd+Oak/hvnpgX+vlriCdYLi3u1kQFQtJwz+qBvDqhsudXuGPvY8wkMuksrBhkx
	xfwVliyR2iZvkkCwHXbxoWxLG2cB0WoBGiH31ZwzGSlOxT/fwyf6KALSRD7PO4OsGDzWQAVgc4z
	9fuwFFtAp1VNPUYPjLFj8T9E9DMQeIfHWv5sRA0vb0GZK99N1VquE8JtzpGI7wnSLKxADEI7BuN
	fcpvJ0Mn+l5eE7bphbgoHU/fmVFo3vHy/1y8Vz9QEoZpVHzxb6Gg+3bpehj6LPHj2qciSuEJ3zd
	2sXaEc05sTOn0Qmcm0M9upKjtL3G1z/bDlmzbUtEDwcHuRimjTz1yn
X-Received: by 2002:a05:600c:5486:b0:493:e57e:7aa5 with SMTP id 5b1f17b1804b1-496b56f9c9cmr60868985e9.22.1785066260893;
        Sun, 26 Jul 2026 04:44:20 -0700 (PDT)
Received: from ?IPV6:2a01:e11:5402:d840:e7f1:1a60:4b66:808b? ([2a01:e11:5402:d840:e7f1:1a60:4b66:808b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4ed6b76sm142289215e9.2.2026.07.26.04.44.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jul 2026 04:44:20 -0700 (PDT)
Message-ID: <39df42eb-433f-4cc5-b76a-8a7beeb3704b@gmail.com>
Date: Sun, 26 Jul 2026 13:44:19 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] iio: light: cm3323: fix reg_conf not being
 initialized correctly
To: Jonathan Cameron <jic23@kernel.org>
Cc: ktsai@capellamicro.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, daniel.baluta@intel.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 me@brighamcampbell.com, linux-kernel-mentees@lists.linux.dev
References: <20260407151702.15208-1-aldocontelk@gmail.com>
 <20260407151702.15208-2-aldocontelk@gmail.com>
 <20260420185333.3bab224d@jic23-huawei>
Content-Language: en-US
From: Aldo Conte <aldocontelk@gmail.com>
In-Reply-To: <20260420185333.3bab224d@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/04/26 19:53, Jonathan Cameron wrote:
> On Tue,  7 Apr 2026 17:17:01 +0200
> Aldo Conte <aldocontelk@gmail.com> wrote:
> 
>> The code stores the return value of i2c_smbus_write_word_data()
>> in data->reg_conf; however, this value represents the result
>> of the write operation and not the value actually written to
>> the configuration register. This meant that the contents of
>> data->reg_conf did not truly reflect the contents
>> of the hardware register.
>>
>> Instead, save the value of the register before the write
>> and use this value in the I2C write.
>>
>> The bug was found by code inspection: i2c_smbus_write_word_data()
>> returns 0 on success, not the value written to the register.
>>
>> Tested using i2c-stub on a Raspberry Pi 3B running a custom 6.19.10
>> kernel. Before loading the driver, the configuration register 0x00
>> CM3323_CMD_CONF was populated with 0x0030 using
>> `i2cset -y 11 0x10 0x00 0x0030 w`, encoding an integration time of 320ms
>> in bits[6:4].
>>
>> Due to incorrect initialization of data->reg_conf in
>> cm3323_init(), the print of integration_time returns 0.040000
>> instead of the expected 0.320000. This happens because the read of the
>> integration_time depends on cm3323_get_it_bits() that is based on the
>> value of data->reg_conf, which is erroneously set to 0.
>>
>> With this fix applied, data->reg_conf correctly saves 0x0030 after init
>> and the successive integration_time reports 0.320000 as expected.
>>
>> Fixes: 8b0544263761 ("iio: light: Add support for Capella CM3323 color sensor")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Aldo Conte <aldocontelk@gmail.com>
> Applied this patch, but patch 2 will need to wait for this to make its way
> into upstream - probably middle of the next cycle before that is in place.
> 
> thanks,
> 
> Jonathan
> 

Hi Jonathan,

The fix this depended on (commit 1f4f0bcc5255 "iio: light: cm3323: fix
reg_conf not being initialized correctly") has since landed in mainline.

Is there anything still needed on my side for patch 2 (iio: light: cm3323: use 
dev_err_probe() in probe path) to proceed?

Thanks,
Aldo

