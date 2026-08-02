Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC25188CC9
	for <linux-iio@vger.kernel.org>; Sun,  2 Aug 2026 15:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785685712; cv=none; b=NbZBDdapULP5d/C8dyOq7GQdRCrwkrB/Kjv8WMQp78YInpabpzMABggxJwl+tkOSjekL2OYI4v8lwQJWplB91UugCgOud6seinwEly7gBHYiOrFxQ7Kb2Bm0fDBEkNZp+G4raT6hljppIYOUajfNMRSzeK2vjr/dL7RcI3Mn+nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785685712; c=relaxed/simple;
	bh=myTdP4N4s072DWu1gMOV6W69n/MSNQkO82Bmy91tiEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QerkglO7zIhfrKL/nWSmmyBCuvaT+jqr7QWD7qt0MdGKyO4OwaE/iWVaRDfxCHXpEl9BGaOHALLC/rwlARZ9sJ8yodOGQW9ZkJN+oH19s8Ch6no58ziPmq9H8I1ZMhrn7/HA95rTSnq3vHi6f69Sh0n9nmIHAcTu5MqcW2ErIKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=pfIcUDRy; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="pfIcUDRy"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7eb4d532e65so997129a34.0
        for <linux-iio@vger.kernel.org>; Sun, 02 Aug 2026 08:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785685708; x=1786290508; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nLFjfOG0F3eOdr1zFSNvNYgJ1EFWsu5Z5Uaya2xDFW4=;
        b=pfIcUDRyD5XZSVDwci0YsxwyvZERKtH3g2EwYCnn8KFnuwa0e87V6dIpH8M9pwdG8d
         72cB0TJcwuvui3nm/FCor3CCUoDOv+SJ/5aPk7CY3li0rsQoK34iWVHHcqaaivFQYEeI
         G8f6WJ+AjesBpaT+q814YCzizllOC+p+f/5ho7D+RYYfKtv43pwVrFl5F9k+/KsmVb34
         LluVnpQbvY1yUHQNFeOkJNhmhDkwnLTtbvXpz1JLaZXWd7n2z4RzEOJ2Popb349VkQuq
         ZRD14v0wbCqO7o2qCM59yDbpnGVvwsy3GIFM8sJNaAd4Zb5rDp8J8goMhR3SFSoSBAiz
         19NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785685708; x=1786290508;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nLFjfOG0F3eOdr1zFSNvNYgJ1EFWsu5Z5Uaya2xDFW4=;
        b=EhzCiV+yIkris++t2hcp28fp7RYeQhNE4jRbeSelLJBE0OpNsWkiJQeUFZCTFvLPRz
         0I8dFkbmcxwH7GvwNApRLJVmyLTJSdgnGna+6JoqH2FzsZfrXBO+H4qCbLFXTghaTXQP
         ENMPgqlqFXPkEJALZktWPVfjqavNZsd8l/D7nVzIRuzzlmVk3UTzAypUvaMx9rzRvwaK
         kmPuUL94WaWwz+GK/+tJRWYHhMEFW+8+jjTFifjCnlFHhkPnvXdBzeS5XCu6Ks6gp7l2
         DHftH3sV+fWdQeI/EWa4mvdLc5oIaKW9jAfpSwx0Szfaenb3Z7YfpkGPGrZlr4E7HrPE
         YYrQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq9lvILhZweN5TeBv4P1A2FeuSoNaRivtDv+YG4enrynaB2FC+N2COS4HrnpTShq76vo3vslYL6DyM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3ChEFB5j86P8CT5zcghOjaRmolkOhAq6drb3hKUQTxaOZGA7Z
	YTS3HxrJcrgn8GSkI3BvVc6y8l6wmyTYDDvd2k6GjdkYDBpGXn9+0do+MpnKRY2axJ8=
X-Gm-Gg: AR+sD12EtpCIdg25Q2BgZ2rL1N9/zEyCbVHAc+3Ye/JsPojPkjFo6dXhvIgJ1E+25tr
	tbXW7iX5QKQBw/p+ZIp7G6l/hzss1qZwWBdW9kDdNgBKhvhzMwK3YtbZhbSdQS1SNPOytKo/zbq
	5HqW5jgi8x91Ou2tH1mesCzLeQeTmNYCkeFsxrMW/KUlscxVCqx5XfK0uLhuOsPLp3dprUT1Wbj
	S5G8BqdxqbiUAcgGR4X1LZNzOWPRgXlRZZW88Qbma2ztHO/TsISVli8caRQObjD9T5iHQ5f1G7N
	/XhsrXxc4+PR+Dp3wJUyyf8rah/o2t5oXtnnlDDIpMrpoIJaXNmsRy8I61Lpm+rHwNRrANRZbo2
	2eBp1ABXt/ZjcWbZRaN4egyyaqIgZWS2cFMoOwpfvdhCpusDRI/91eSuFNL54JxWfLvOPRprkxc
	5wYOsbxTth4HOI0MMBHJAx1jAAna0obWppR9lKf8YjWSd15xvrbcZt3uIADeFjnNClxvr4ag9PG
	PxB9O9oPCFoavAZjMeNtC1tRC2WdtcEFOb0Ma7aSgFfn8H3I8Q=
X-Received: by 2002:a05:6830:63cd:b0:7ec:6512:ee12 with SMTP id 46e09a7af769-7f196d614f5mr12718596a34.12.1785685708502;
        Sun, 02 Aug 2026 08:48:28 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:5487:2b6e:1057:d3d3? ([2600:8803:e7e4:500:5487:2b6e:1057:d3d3])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f18f07a586sm5341084a34.16.2026.08.02.08.48.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Aug 2026 08:48:26 -0700 (PDT)
Message-ID: <06f059d0-ac5f-408e-81ed-220f4cb1daf5@baylibre.com>
Date: Sun, 2 Aug 2026 10:48:26 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: pac1921: fix wrong channel used in trigger
 handler read
To: Cong Nguyen <congnt264@gmail.com>,
 Matteo Martelli <matteomartelli3@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260802071246.62046-1-congnt264@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260802071246.62046-1-congnt264@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/2/26 2:12 AM, Cong Nguyen wrote:
> pac1921_trigger_handler() walks the enabled channels with
> iio_for_each_active_channel(), which yields the scan index (bit) of each
> active channel, while ch is a separate counter used to pack the samples
> contiguously into the scan buffer.
> 
> The register to read was looked up with the packing counter instead of
> the scan index:
> 
> 	ret = pac1921_read_res(priv, idev->channels[ch].address, &val);
> 
> pac1921_channels[] is ordered by scan index, so channels[bit] is the
> channel that is actually enabled, whereas channels[ch] is merely the
> ch-th array entry. These coincide only when the enabled channels form a
> contiguous prefix (e.g. all channels enabled). With a sparse scan mask -
> for example when only the power channel (scan index 3) is enabled - the
> handler reads the wrong register (VBUS instead of VPOWER) and pushes it
> to userspace as the enabled channel's data.
> 
> Index the channel array by the scan index (bit) to read the correct
> register, keeping ch only for contiguous packing into the scan buffer.
> 
> Fixes: 371f778b83cd ("iio: adc: add support for pac1921")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4
> Signed-off-by: Cong Nguyen <congnt264@gmail.com>
> ---
>  drivers/iio/adc/pac1921.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
> index bce7185953ec..0037509503ed 100644
> --- a/drivers/iio/adc/pac1921.c
> +++ b/drivers/iio/adc/pac1921.c
> @@ -1037,7 +1037,7 @@ static irqreturn_t pac1921_trigger_handler(int irq, void *p)
>  	iio_for_each_active_channel(idev, bit) {
>  		u16 val;
>  
> -		ret = pac1921_read_res(priv, idev->channels[ch].address, &val);
> +		ret = pac1921_read_res(priv, idev->channels[bit].address, &val);
>  		if (ret)
>  			goto done;
>  

Looks correct.

Reviewed-by: David Lechner <dlechner@baylibre.com>

