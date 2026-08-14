Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F2041DEE2
	for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2026 07:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786693206; cv=none; b=g37LK4LXDQV3w5AAbPcHuPxNmcTxIVjhhMFke4PisHpsqOdG1VWm0zN3cKPZWi6+kITHDqq68gccv4gd2WsCYJbcq/tkqkBelpwTR2NB18i93hkXEDhwSYSywaiyucXYxXCo9NeGMvJxRDjx0o2GPsMPPhVsFBBGgNSnQ1JLx/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786693206; c=relaxed/simple;
	bh=ASl3e31PS932WWfbIY/CWxi1TGEiR9T4KhSKVQzU2m8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ls++mCxAgyvDL/6vl31LGRYEYk3oDPOUrgVdSA6Xz6jqTO1QvexFJQzpY5QEhI7TovJdUxPIvi+F7/F43uWhdKyXN/WCqsxX46S2j7HnujGpiTxaFAJAh7A2GNlPWk4eEH6F0jZ/DhXLD9zU5SvWliWmt+B7Jr7DpIL8pK05CX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SeRlqxpX; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeRlqxpX"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5b457a0b4e5so683295e87.1
        for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2026 00:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786693190; x=1787297990; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4QG8erjlorMelULvLA91wOciYnAu6jKIMiuNqcfPdEA=;
        b=SeRlqxpX6XVJnP7IiCHCBHv0E9rjfeKIpnHWwTG9ceOmkAYyAY9ULtTZS6hE+J2rz4
         I950CJ9Ql4l24pUGaJ3rbmhtkefRLq4KVZijVUrmkRY538gpcrkNIXItIS3d71k95Hrm
         X+7VJyut8X8haJFZyHomASCmbitq7a3nUbOAF9GTRQ7aabcwXyhMJP8xVHQp2KFk+6a0
         +sefNZGn5c3dsW3jhjw4ZinezRJCHb5mSsvw4QGgzxuO7kqbYFX41r+4+IAy2WR/wOyA
         K8zIQPY6vJKjpnsw/k+3OrtcXJ1AE9NvecG/s9w9yCCYXtRYC2uIgns63sFFTzqUy8Fz
         UE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786693190; x=1787297990;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4QG8erjlorMelULvLA91wOciYnAu6jKIMiuNqcfPdEA=;
        b=UAKf7t/KpulU5Gac5e61GQ/EZUjwaI+VFccpLAGsgE+NQGHQjkzY3S9X59OYo3OHuB
         pCvVMdlDqCoo0gXu94nY1jXXAd+L4UEUyhnl2LacgG7FUgsSmBgaZe7nWCfpVx1Jaljl
         zkrN1Am7Ol3Ahp+JJEF8IuIN4Ff12KAUYj9Hqi5IHdcFXDMdcuBchT0GDen3APfXY/gE
         x76gN7VrM5Dtbo1CZtb0WxD5kSVciBo+6MoQGCabGKXpJK5ccswa8gN83PXPSzWQqZ4z
         lkf6W2aXG6WlSnFEeShVy/EQedZoxFoOHZdYJ07qGFWugzDsWWyCiUwoZkGDfaoB1hwU
         NJfg==
X-Forwarded-Encrypted: i=1; AHgh+RqrhGcVfunCDzOJsUupIduyOMBPEjpRVmmJxlYs1kx1PrsoCcqvQRFqlP8t1+xE42LvcUJaaDRmtHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC2aqvKKD8aEeQw1vRhVirfRv0quddlmuNSdQZVF31JPQU8qg8
	4axAGOWIqu6b6Jz1HMVGHm7Xg6SPqWRngK0SiSTQB8vNO9PvOHZ5ZBsi
X-Gm-Gg: AR+sD13MF5Cw9QClRLEaZMJ851gShSsmnWNlBNVOqKYCI3UmLPbwU9e1iS19caxvAbD
	I4++QTDZQzFIaV5px67vNgZFmYYvoGYhoj4KiVkyT42JpRyhAE3ATikaX3jKnhyYmZ0BMyIn814
	rwtVzVVFEp9RPuntygXO+P4WsuswijSAG12QSDHw4ncVY/lVUi7/1+nfPV3p0s2Nz8Ed1wJFWbD
	X4AIFjLsnl0pzDVwLUFcYz4hTh2W8QHD1CyjPR3ViTkBCCLrF//bs4pvBYG2UPndEqFQYLYWVba
	8sGxoDS1D1CzjqV93jw+aENDueGBVogk5Ftxzk63slkmQWwtzluigqhk4INh7NrFJtDXLkme5d5
	wxAgJpUzRsJH0l6Qp7ZL9ingdc0xXS859vArs5yRBcqpsEohLRwfRzgld1UADslgAbGEiO1WCvb
	WQCJyKASH1sM9tmp54dCgmtq0DOdIiUu3u6lYxLCWdW1VIs2yMC69ly0C7/irPgslQv+szhOuEa
	laRla05B4OPGdYJdIHeidwXMBlPExIGjVk9s3bRk4S0
X-Received: by 2002:a05:6512:3407:b0:5b4:5838:30ee with SMTP id 2adb3069b0e04-5b459163b3bmr571415e87.7.1786693190252;
        Fri, 14 Aug 2026 00:39:50 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b458b9a8b0sm369446e87.9.2026.08.14.00.39.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 00:39:49 -0700 (PDT)
Message-ID: <5424d7ba-861b-44ea-ae92-f4b334958a71@gmail.com>
Date: Fri, 14 Aug 2026 10:39:48 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/12] iio: accel: kionix-kx022a: Prevent memory leak and
 fix statey
To: Mehdi Djait <mehdi.djait@linux.intel.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Matti Vaittinen <matti.vaittinen@linux.dev>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Mehdi Djait <mehdi.djait.k@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kalle Niemi <kaleposti@gmail.com>,
 =?UTF-8?Q?Topi_Sonkaj=C3=A4rvi?= <sonkajarvi@hotmail.com>
References: <cover.1786347811.git.mazziesaccount@gmail.com>
 <85e6bd3998863e0247c52dcf0c1486b2cddff567.1786347811.git.mazziesaccount@gmail.com>
 <anxcithfWakkARl8@mdjait-mobl>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <anxcithfWakkARl8@mdjait-mobl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/08/2026 14:47, Mehdi Djait wrote:
> Hi Matti,
> 
> Thank you for the patch!
> 
> On Mon, Aug 10, 2026 at 10:55:03AM +0300, Matti Vaittinen wrote:
>> From: Matti Vaittinen <mazziesaccount@gmail.com>
>>
>> The driver allocates memory for samples at buffer enable path. If regmap
>> operation fails in the kx022a_fifo_enable() at the buffer enable path, the
>> allocated memory is never freed. Furthermore, the state information and
>> previous hardware configuration(s) aren't undone, potentially leaving
>> WMI interrupts and buffers enabled, or driver state flags wrong.
>>
>> Free the memory and revert the hardware configuration and state flags on
>> error path.
> 
> Reviewed-by: Mehdi Djait <mehdi.djait@linux.intel.com>
> 
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> Fixes: e7123a4dfcd7 ("iio: accel: kionix-kx022a: Refactor driver and add chip_info structure")
>> ---
>>   drivers/iio/accel/kionix-kx022a.c | 27 ++++++++++++++++++++++-----
>>   1 file changed, 22 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
>> index 8a13f78aeab0..49e8b4b943da 100644
>> --- a/drivers/iio/accel/kionix-kx022a.c
>> +++ b/drivers/iio/accel/kionix-kx022a.c
>> @@ -980,26 +980,43 @@ static int kx022a_fifo_enable(struct kx022a_data *data)
> 
> Do you think this error handling should also be done for kx022a_fifo_disable():
> in case __kx022a_turn_on_off() or one of the regmap_clear_bits() fails before
> we free the fifo_buffer ?
Good question. I am not really sure what IIO thinks if disable returns 
an error. Should the driver be in a state where it can handle re-try of 
a disable (Eg, a new call)?

If so, then returning an error from "turning on" the IC
return __kx022a_turn_on_off(data, true);
is problematic as fifo_buffer is already freed. New call to the disable 
would then cause a double free. If this is the case, it should be fixed, 
perhaps by just "NULLing" the fifo_buffer after the free.

If IIO does not allow "re-disable", then failures before the free() will 
cause a memory leak. Furthermore, the hardware state may be left 
inconsistent. Considering that such errors should be quite unexpected, 
and probably a symptom of shomething being off - I am not really 
terribly worried about the leak or inconsistent state - and I don't 
really know what else the driver could be except re-try - which might be 
a never ending story if problem persists.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
