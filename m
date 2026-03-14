Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9FE37F744
	for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 19:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773517915; cv=none; b=OSX6Ebm9ST0SVR1ykGUN3tsaJz1ZqExDTXgf76NFfKjxu4Pm+3OyxCpe8nsVCq6NfRH0z8/7L02vjmUHYWk1Vd8O4vNdslxwlieGJXrn5LJ3iz67iKrrsFBR7EcNXIgAg+cv/lnSyoTtNVLvAzDg85QlN0ix3ico70GwYzcCHyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773517915; c=relaxed/simple;
	bh=PN/ebOVkl3Ch2oEl48DSbiQkNWOJst/IpNNfFU9a8WU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IrmpXRTlh4fwSAOmdFuRHix+EaGRri9hx69KKiWHUTzURbB374f5hbRaH9t3TpkHeZBreLAzQZpmUNc479kS9N3RP3YSAvOLkWow4Wa21JpVTkThm6OIzo7bDJWovv9L3Z7IzMfGvJLILL6AzIlLvQZKuwrtcjFiVaimODBGIdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=flEhqgR4; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="flEhqgR4"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-466f59dbe4bso780223b6e.0
        for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 12:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773517912; x=1774122712; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D8F1aqi6Qy869M29EukxOGNGMVc3+0t8hXdBRfmiktU=;
        b=flEhqgR4mKUaS/olngJFGDWd7v8oKAo/r6t+CEfnMQiKnG5qCpDOL995SiGRCr0zBK
         sKxyTS3Ub3Iv7xo3TC7eHJa/MAR9afA9ED0Tglx2nhiyoXafAS4Cihpk0mccsb35QWo4
         LFfkpEmMu3X1qPnNXkgUvkm1zYqgmvEjWZB9ADQWnXaf49MCtBYJdMCjntroQJ5+83Av
         djvi2uf/U2gZGvAHigYZGPYafgsofKJZ34BsgR+blnB71FYqZNonOWFdpmuhd1IdvxLC
         6JKOTTTUNrwp6H6br5xZcdhMmLBgL+nF5TWXAoHdkzrjRQ01oqtPS6J0Hz5Fj4EO9a9L
         A4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773517912; x=1774122712;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D8F1aqi6Qy869M29EukxOGNGMVc3+0t8hXdBRfmiktU=;
        b=R6zNlXcmHpHr04vCiOg3nK39Vo7eFfl5e+9QPuEZTn6er//XcVgrRzvpR8l+nZ2cTV
         Ub7dUZLtIgmB8jgrwVkuzNIey6Qoz6xls0eYHJ5i6B5/qrlTMXnAw8g+jnK16CqcpnWw
         dRKb8XB2SOfDrAPcruIzJ34/qS92wjWd1cSdD0PEOdtYnfdD0I0H8f7Y3cHLKKtpvMad
         +FCcq1Bp/o+Tpg268gIYZ6sdFV8SwtfhhOx/E4ruhYalQU/kq8jfBTQKCeeHYelUOx3i
         OIvSGk02pIJMXmzE2TKLcJYa9Cer8KeuVLwIlTa7hIreD/kVDu/PxPO4ETbMbc+jj6GA
         /HLg==
X-Gm-Message-State: AOJu0YwTozEKZznpcE9V4l4EroLIKdn8aksWSJhF34sdTa+Ti+I7wmz6
	uabh2HB5hnuOmmnFg8QaTtK37oqDIPLaXLDBgDwb3gqoDKfP6eoXychfoN6MeO094nQ=
X-Gm-Gg: ATEYQzzu+Xq6SeUFqdEw5dv9xti+3sf7BQvNwZ6EEcojCvSM6VC+5oohiLh9+G/sLY5
	Cbx0R9DQsMVsLE6iQHiTVr60pOrJgkpHQmf8gKT0WXTHHuow+ddizhzMh2316qmFuscaUn2XYys
	jETR3QA4lLuW87xDaWrS1u3nZq3bUWToYmxNcvcxa/3/q03zHPAS8IkLXET1+JP1/JF6+UmBb0J
	zzvzIDJliUClPX6Yu88EQN8l2GZfzSp6XeLQUOXurR5A1ZcIm499Zg5N7WQykhjlofVcL4naVZD
	p7EkS26RrT43BGAM5CNZoP5M2SpY932kgoFtW6W01T/Vk1NFrwCiaG0F8pA31vc3Jjys+zDSuGA
	uXhIMqDdqFuGmDi9MulCIJsTSwbsmdSTajmoGTCDuL/F6pOQnpwZHyja1uNOtLdrTaZaPM63X6k
	cnE91tu2xF4XN0reueMh5LmeoSAjJjARybVj0/Khm6bO542IilO47L9Kk66oeEwu6CiJEIBziu1
	A==
X-Received: by 2002:a05:6830:828d:b0:7c7:63b6:89d3 with SMTP id 46e09a7af769-7d782510f72mr5089963a34.19.1773517912188;
        Sat, 14 Mar 2026 12:51:52 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:14a9:db6c:e65a:4287? ([2600:8803:e7e4:500:14a9:db6c:e65a:4287])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d76aebc9d3sm9157746a34.24.2026.03.14.12.51.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Mar 2026 12:51:51 -0700 (PDT)
Message-ID: <cde8cef8-1bfa-47e0-8ebb-6c295f31f497@baylibre.com>
Date: Sat, 14 Mar 2026 14:51:50 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] iio: light: vcnl4000: replace mutex_init with
 devm_mutex_init
To: Erikas Bitovtas <xerikasxx@gmail.com>, Jonathan Cameron
 <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org
References: <20260314-vcnl4000-regulators-v3-0-3c4a48d30676@gmail.com>
 <20260314-vcnl4000-regulators-v3-3-3c4a48d30676@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260314-vcnl4000-regulators-v3-3-3c4a48d30676@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/14/26 11:06 AM, Erikas Bitovtas wrote:
> Replace mutex_init used across driver with its device-managed
> counterpart, so all assigned mutexes get destroyed.
> 

...

> @@ -1985,6 +1993,7 @@ static int vcnl4000_probe(struct i2c_client *client)
>  	const struct i2c_device_id *id = i2c_client_get_device_id(client);
>  	struct vcnl4000_data *data;
>  	struct iio_dev *indio_dev;
> +	struct device *dev = &client->dev;

Purely cosmetic, but I would have put this two lines up (right after
*id) to keep assignments and longer lines together.

No need to v4 though, everything else look good.

>  	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
