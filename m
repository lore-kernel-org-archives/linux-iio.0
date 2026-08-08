Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3581F09A5
	for <linux-iio@vger.kernel.org>; Sat,  8 Aug 2026 22:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786228552; cv=none; b=PdV/QSqbEyhH4wqZBhOKZP5hn9AO35ACJA50Lof4WrSPMqPF1Qeo6JGdIFB45ey4hIDmkcbsmI2UvAilun/3GYQ4ndIwx67P+RPv9LWQ0Nc1x+W6x2LgIun18FryXfDAfjBGaT5K6JPa8hC+H/rtgbWZlOOnK73bXALBPSOvpTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786228552; c=relaxed/simple;
	bh=ThsXSy910Kxj+U09LRzpiF8ougdSnR07B8GFSNyb9hE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kDyxfCFVndwnAW2buZ13XxpquZn0jCFOLlRpYjoJv4jZXgkd5HQlIjCFdTfGkmAA6GVKadLG7E3/3s4zTj+o3Azej4PoVXu/sgH7/tP7uoQkihDQ3QnQBXpkYHoKXrLAi9NVsKrES152dhoEJ1vGeyOGG8HPQcsNItmszc8wn+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=osuxGL7l; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="osuxGL7l"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4af173320f9so407753b6e.2
        for <linux-iio@vger.kernel.org>; Sat, 08 Aug 2026 15:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786228549; x=1786833349; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yQfW34he5hWnfmFpf7/3FQ0KRYGIGQ/GJRwqEgPg7k8=;
        b=osuxGL7l32HYiWWk8lOTLuGfIWr4q+DAqz6xjqmg+jiO/uz4S2Pk8CSigfgH2w5SQr
         MHivnLSutOpDSt7dICGrO3BIzJiAhkR/ruae/gDHDRqTZZ9+zS99R3/opzQdlhF90HcB
         OpdkeOEyR/UQAK/lGEGx4qSyZUK1NTbiG+oOj2Vu2E9g1P8iCt555iYygL5zAgq3VBRn
         pWUTLRaUCdgMsnYHpZNTYmUbW/resD5MWqGcGFaTARIdM8gV6zealANbhWzjCb3ZzX43
         fJHxeEn69qd4yBUFSRNhESY2P/yLYp+ZClt10bDCypq/DPsaQuwBqEaG0uP22cr18hPP
         fTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786228549; x=1786833349;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yQfW34he5hWnfmFpf7/3FQ0KRYGIGQ/GJRwqEgPg7k8=;
        b=pXD1mN/jm/hLJbSxLCcEgHFmd2zegqK/cTr7ygxWeZg6eDbrfFWKeG55mUFjTUGoL5
         XequWwYJFm3f1ne4n2Xm8aKIkAd2Ye51ipG1mNc7qqzD1bz9xbC7d2BloX6jDlaSjKIS
         4+aX3O4oz3nHKhjjVwjgnug+M5VqKYRlgg6X66XcdWXmc9RwhfrYw3Dk3TJShGz6S9Ma
         mxpBGNji5HOBNZ1HcxSj6Rk1X7cPv8/G01XzaF7DXlhXicHId/jn07N+XAoHHP9sKDBq
         QS8ZqJgXZ1WL5Wgz1l4wbaoMQD88RBWDjPBpF0VgIZNbqC4MuOQuA8AWDNm7ErgZnFFf
         1PRQ==
X-Forwarded-Encrypted: i=1; AHgh+RpOCbRO+ctduakrO+FHU4F0ZxOPrnsIVCFlQgRH0z0p4NQw8ILAfbr5HhXzYsdMHi+G+xzRieoZ1+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcTPlbUPpCsVXC4P+G96yzfp8nVcR4USdCCt95xcOXMzZc0vA/
	hax80mUPR4IpMcVWLlgWroVuLKJdNm8Frdkp1FfjRfb4IZfN+c6w060JKCqxLVqBukE=
X-Gm-Gg: AR+sD13VTwRN06K3WaWaqsG3Q1J/Qx3QA2D5Lr2hBiIjNhJlAbKM6UGy4mrphhVCmz8
	dkH4A4eZzGcGb+IRPZOty74NfcZof1psqXbOYu8gq4RURmhg7y8+2xVbMyR8/tqd/eeeYkoNHbQ
	bIh1+B9r7oS2nkTp6f2fJopBCKrFQhbFv1tW1ygh/zrc4E0im4S066Bzt0UOb/uKNjQDfWhBi5w
	Vy59z7R7CdebN8gnFmEKPB4BXTvvinGV8RCmIGBw9ojMlZ2KWVzKSaShpxzdSnvErsWTfEk801f
	JhxUfR2c29YvF2rCgBiYVIGaTPQAYTopQJHEUhSbAEeCEiNK8OIRp07A9RE4pWWefpmD78W2xXu
	gTEv8bRukH7K9EaivAedR5iL/NXykoCcvcxS1keRaRcmOAn0E1bRLqlz4s4hXgRyxuIjkocGJWW
	5qTlvzeXIhDLZ5MNUlEVm6PUHNqgtfMTzInqRhGsbhytkcJxRPb2PARsQOQll1nj9qMw7oEbEmJ
	O26x0BmFHz0KPeoEBEYz0LvGWTpwSBz41FLTfA=
X-Received: by 2002:a05:6808:191b:b0:4aa:cad:cb4c with SMTP id 5614622812f47-4b13317f7ccmr10407933b6e.1.1786228549426;
        Sat, 08 Aug 2026 15:35:49 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:99c2:f16e:201c:3bb5? ([2600:8803:e7e4:500:99c2:f16e:201c:3bb5])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b1af63b441sm2919282b6e.14.2026.08.08.15.35.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Aug 2026 15:35:47 -0700 (PDT)
Message-ID: <261dcaa5-3e9f-4da8-adb9-dae4eb7310f2@baylibre.com>
Date: Sat, 8 Aug 2026 17:35:45 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: accel: bmc150: use IIO_DECLARE_BUFFER_WITH_TS
To: Yash Suthar <yashsuthar983@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260808220236.421832-1-yashsuthar983@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260808220236.421832-1-yashsuthar983@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/8/26 5:02 PM, Yash Suthar wrote:
> Replace bmc150_accel_data plain buffer with
> IIO_DECLARE_BUFFER_WITH_TS() that also keep
> timestamp aligned.

Please don't wrap the lines so short. In git commits we usually
aim for 76 columns, IIRC.

> 
> Signed-off-by: Yash Suthar <yashsuthar983@gmail.com>
> ---
>  drivers/iio/accel/bmc150-accel.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/bmc150-accel.h b/drivers/iio/accel/bmc150-accel.h
> index e8f26198359f..e0773533efeb 100644
> --- a/drivers/iio/accel/bmc150-accel.h
> +++ b/drivers/iio/accel/bmc150-accel.h
> @@ -64,7 +64,7 @@ struct bmc150_accel_data {
>  	struct bmc150_accel_trigger triggers[BMC150_ACCEL_TRIGGERS];
>  	struct mutex mutex;
>  	u8 fifo_mode, watermark;
> -	s16 buffer[8];
> +	IIO_DECLARE_BUFFER_WITH_TS(s16, buffer, 3);
>  	/*
>  	 * Ensure there is sufficient space and correct alignment for
>  	 * the timestamp if enabled

Probably also needs fixes tag since the old array was not properly aligned.


And as a follow-up task (in a separate patch), we can look at replacing
iio_push_to_buffers_with_timestamp() with iio_push_to_buffers_with_ts()
in this driver. Should be trivial in this case.

