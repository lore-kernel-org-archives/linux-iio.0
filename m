Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BEE19539F
	for <linux-iio@vger.kernel.org>; Sun, 15 Mar 2026 19:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773602163; cv=none; b=Lcx8hy8zJwPlDaHZV0UsKM0fScUoncQwFOt92pJ52+zCZ1RooyNhSGDdgGAPHGfhMB3v4Jeyox9lLDXFH54p04NpMjPFjdVJBwnKoW+JD4M4ANfa2y3Sgiq4IGX26bO9Ku1NFegSraiKvc5z5v7+92D1MD60FpbycxdtArKWqlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773602163; c=relaxed/simple;
	bh=a6zCJ7W8/2j3GTCTCY6FAyHidVZVuKayQ1N0RO9KOEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fmPy4jZGzCxa/efnEhoiZWfh229yMDPAfbhCXH2iaxjljhmeKG380o5qyEKqPx4Dt01QQ9Brm1gyN5DwZP5YU4IEvNVfQNyARd/1BcZQPvbqJAqfRYWyNXJKBYZ6buvHpbUuag3gPADUgfwNNRrRPMZhZ72JLi68J9Dr1oF18Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DxvjKQs8; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxvjKQs8"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b97ba4c2be2so31541966b.1
        for <linux-iio@vger.kernel.org>; Sun, 15 Mar 2026 12:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773602159; x=1774206959; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j24q+WEEaIIpTAaLp22q5B3jSJrQk0EvfwD9aUHG8bI=;
        b=DxvjKQs8kWy2u73OGxFvaR8tCE3IMk0ePE9vqxw+/7XaS9NXNB6JcuMm8TNqiGffmE
         +23cB11lX47Lw9mkCj433edZ698dowY9OD2NUX3y3hJ+NwzYB7w+CeOBQFWVDGXSCxur
         QLROn93dVOC8k6Dy7D+3zCpaatwExWf+h00rsMqKbMTeyqwNbB9twOOfKaXPCADsDCe7
         enIEJFbjQMmK+iSymqPtkqn9BwxIMrpsNfzHQggWQ8NvIQlUOgIxw2v+qNiplciUbXYC
         AJNU6jfWtUFGTPbZdKcAdTD4CSdeLC52EEUXt6Ed+X/RBGgB1PkB2d+7DZl7WjXe7I0k
         R9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773602159; x=1774206959;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j24q+WEEaIIpTAaLp22q5B3jSJrQk0EvfwD9aUHG8bI=;
        b=QeBxu8J1qzaXlvx3Vrw5RSxgxcEF/piv3QZoTbHHTqabgiMBVUHcXG2RVCSXnbX0px
         jE7LbSjAFwV9MxPyhZJ4x5RtWbb+gyhVYF9bHecvgf8xp9LYJOK5sYV2CWP6ygxb9zGM
         /lz8KR0QM5cebbnsdH8cmenDE9WuhwLgw3LkeiftDDCBeqXT41xKa9NPlqSVzC6+lfVE
         TvtK2bsxXd/LzAMBUPPnUoAWLM47pBPnMIPrY+ID2qZS2kH10Im7TtESEGcTWV8dMo+H
         y2cdJl2oUo85B0ALUefykI9DYqdR+M75lD1mykpVtzkTZFCAu+hkQHLDyZLekyGaRxFB
         kMDA==
X-Forwarded-Encrypted: i=1; AJvYcCXH2Pvt507O75a05UQ/6w0U3Pt+swd2rQh9DTGfcbL+fbIJkEpESAx+Et8J07F/jmziawQsG/1dTT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkZEleDqUdFr3TJ0KaGdkUACqbft2dP18NGbyg80a4akk1OWbl
	ynUggJJYYmjq06PIa5ZrgAqCVV/Y55hlLNh3ZkFNYRH8j3gsgwofEUHF
X-Gm-Gg: ATEYQzxfiOtKax2beRK70wHKaGYPYGe9kXHq+0hYEmFbO5vRMtyoIhNcpvjullpF7pu
	87fIzJDacJN6aWZl6ijF2YDKy17Ecwv8pKWHbPaPdjiKUc7/OysI+GggWorCSjdE8rxnnUPRXvu
	7CXATOD+SlgPMob/AKYGeF2KoW3NVvJoQrsNZQkNnZcXwtkr1dwDDuljxo3Dsyb9HJ0Z8q3lAho
	/l5ELkxe0aJqWOl2mYLfgwHxsc2UXKp18/ab+7AXf0MEpRg2BKv9zt/5szY1S0JmvAifyCYrIXF
	UsoLc5SvloBpXV6TKDeXzum/jiKSUvu2PTr19Y4l7e0ZQw2532Poz6mazv7vM5Q/umwaDaP+PUC
	zOxjpjbnnl85uQ9bh4HOCvSBMIpQuJrMH8dHUwlwHo8OgHtWxn2oODC6qOU6wGvrHGXwH9lD64V
	KB4T6xIA3RV+S/XRULrsf9OThTJg==
X-Received: by 2002:a17:906:4a9a:b0:b97:f3:1231 with SMTP id a640c23a62f3a-b97653525a2mr439485666b.57.1773602158949;
        Sun, 15 Mar 2026 12:15:58 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b976cdb1d20sm421911166b.41.2026.03.15.12.15.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Mar 2026 12:15:58 -0700 (PDT)
Message-ID: <706a349f-63e5-4f47-9f77-c84db1058f5e@gmail.com>
Date: Sun, 15 Mar 2026 21:15:51 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] iio: light: vcnl4000: remove error messages for
 trigger and irq
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org
References: <20260314-vcnl4000-regulators-v3-0-3c4a48d30676@gmail.com>
 <20260314-vcnl4000-regulators-v3-5-3c4a48d30676@gmail.com>
 <20260315183127.59036e25@jic23-huawei>
Content-Language: en-US
From: Erikas Bitovtas <xerikasxx@gmail.com>
In-Reply-To: <20260315183127.59036e25@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/15/26 8:31 PM, Jonathan Cameron wrote:
> On Sat, 14 Mar 2026 18:06:34 +0200
> Erikas Bitovtas <xerikasxx@gmail.com> wrote:
> 
>> The error code is available in the log after return. Remove duplicate
>> error messages to reduce noise in dmesg.
>>
>> Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
>> ---
>>  drivers/iio/light/vcnl4000.c | 9 ++-------
>>  1 file changed, 2 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
>> index e501db7249d7..c8bb1826b916 100644
>> --- a/drivers/iio/light/vcnl4000.c
>> +++ b/drivers/iio/light/vcnl4000.c
>> @@ -2041,11 +2041,8 @@ static int vcnl4000_probe(struct i2c_client *client)
>>  						      NULL,
>>  						      data->chip_spec->trig_buffer_func,
>>  						      data->chip_spec->buffer_setup_ops);
>> -		if (ret < 0) {
>> -			dev_err(&client->dev,
>> -				"unable to setup iio triggered buffer\n");
> 
> Is this one a duplicate? I don't recall us being particular verbose
> in terms of error messages in iio_triggered_buffer_setup_ext() which is
> where that ends up coming from.  I think there is only one path
> where it can return anything other than -ENOMEM and that one is a duplicate
> registration check (so fair to not print).  So perhaps all this patch
> needs is a comment on what errors can surface from this call and why
> it is therefore not worth printing anything.
> 

I do not see anything being printed on iio_triggered_buffer_setup_ext(),
so I guess this is not a duplicate. The function can return -EADDRINUSE
if a buffer is already assigned, to prevent cleanup function being
called on a buffer that wasn't allocated.
I will add this print back if necessary in v4.

