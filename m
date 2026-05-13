Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF7C3B95FA
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 20:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778704201; cv=none; b=Nru9sAHF37xa5QvabgTu5mdg1Yma62ziottBfoAAthpAbQN44RR33F2H2q6WioTXTOS+3dwv/PihmdkR580JdYhg1jZWtW7q7WbEL0Eg9g80TgA4xl21NT2y9/ecGRyeq5c2fdtzGAY5DuUOLOju+moB4l+2k5padFWLX+ZPUJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778704201; c=relaxed/simple;
	bh=jHFlF295HYzF2B3H7tjKS4sy/QRMeoh2eLu7AGEMh9s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=O1J4uUqZCMOsSMIuPblL+S0JoOjqszgpDsAqWcwjRRVchUM4CUkw1ZXjbQbW6WqFH6+S66qXVacETy+6NeaLcUY9rWh8j9TTEtbE/kmsYp6oqUGG2GUomQRkpNG3ywkGERbf0ZsKKvnIDrFmlPAQny33/snI8CIe5caUTtCkSgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xx9HbNyr; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xx9HbNyr"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso64906275e9.3
        for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 13:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778704197; x=1779308997; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jAvNBpV8Q/y6fPQg34WIPbh535gNEElB5bP/5NvjoC4=;
        b=Xx9HbNyrYcJOT8m4WnyaLZAkFWLN3aED7h6xo7TK8oYCKZia50wjwcEilqx8ntNcaL
         /Q2qHNkaxcdJ/Y2hJVOU4VepF48K6hy6aWHhO7um7gOMGKklSFfK/Io/UpyAMluWWIUo
         JR5454exVT6FElSE0r30zp6qXLt4JrHF5dYr6/VlGr4wqBw2XvFhAUBRbLZrZqFkw1/b
         yuC/pagVj25a3XqdV2O8ron+oBq7oX/mNqXPXY8JKQCqnKlMjK35xT4oDEJB2n0Fnzf5
         SX1RjWY63B+NL6aUuDLSmIIbr4hsKk+EkfSuSkR4riXe8UPXU7A90wtdfuld8VXzvMrH
         QgXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778704197; x=1779308997;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jAvNBpV8Q/y6fPQg34WIPbh535gNEElB5bP/5NvjoC4=;
        b=im2Nz/f6knBzOfu1PVp0D1XPsOtGeBet3va56cd5MdQvznuotRi+miW5QbLojHaK30
         K0DfkMKZcMPAXP/pwRmtzEVGVSRyDui49J/rHGYefaBa7AS9HxjZPf3vMz+BVp8cnjzk
         APq3zEBBpS++Z847+ZUv0nEmKW/5CBvHp/2sxaU1+yXsrdbX0VkSfpDmxPHyLa1onzn4
         GEJf7z/zpOJoAjdlYFQ/UCmfJG+rrPu8ep91pD0RbRnr84uKuMIPqLKm0wKpVAVZAycW
         e4m9y477/BPD+hxCNa6SCFK739qEdVQX63Z4DzGrMB9cs+sLn1b+joU/JhZf0QHsazaC
         1l5A==
X-Forwarded-Encrypted: i=1; AFNElJ+GwhaeC+c6fqMRSRppqqQI/ZJoY5OdEPyobxTbPym4YdA9dCN3LZ1KB5NO1bAS70Uj4l7FYX+RvV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaTcxmSOmCeVpGJOtgILIhuo7cPkx9tmYHu5M4NWnKSeOkX5x/
	834StILwPaMjzTjgVG+zAHi6wewn4G/Z5YoxcYN2bAuBDEcLDEVzV9TJ
X-Gm-Gg: Acq92OEMwPCYj6LUafbfxfgvFPWdxfI4PhzB7gDjlEgyODTIn407JQi8PbYN6Erbk4l
	DJLYLuGkcRzsTnhkD/GRtGwGkPMCSs0W/K9fvEumq7ST4dZr+7atiFgqgV6WNw0hrMci3o9ZJxm
	Giz1sycqgXanWaMBoOHmS0kkMpZ3qOx6B7QyLKe/kcMicYXoog4YSH5/TpL5T5cLjvuG9dhhvMG
	sPwWs8zZw/+JzwGyiU5ddXXk2aEgbiucw3QHESV+oI2qlEi4RFqYpND0pIrvTAVBkDYwuitoie8
	WjEPVLmESfnq1YEqt3bqGvC8Fc82G++P9ulHR7YmykxTpXUmsdAG5kjp7NbDxBn/KJBXIe+hWs9
	DzTNgeJtgdy5Kz6Rx84OB8baYdJJi2fhDULySdm5m5rauNghLHvlSX/1c79WftyFUs2Exs/ddDv
	w0eKTSxobOtr5kUsNMDT1lGdy63Dyx8FbPzrEDS93vVszCWlEZz67YrvMXXZ9KJ09eUV2cYs8=
X-Received: by 2002:a05:600c:8705:b0:487:5c0:671f with SMTP id 5b1f17b1804b1-48fce9c731dmr74047535e9.9.1778704196412;
        Wed, 13 May 2026 13:29:56 -0700 (PDT)
Received: from ?IPV6:2a01:e11:5402:d840:f1ee:c5d:74e4:6e19? ([2a01:e11:5402:d840:f1ee:c5d:74e4:6e19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd64da1absm21690035e9.14.2026.05.13.13.29.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 13:29:56 -0700 (PDT)
Message-ID: <0de09560-6a79-46f0-8a63-3fb904a38231@gmail.com>
Date: Wed, 13 May 2026 22:29:55 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] iio: light: tcs3472: use devm for resource
 management
From: Aldo Conte <aldocontelk@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 shuah@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev,
 Joshua Crofts <joshua.crofts1@gmail.com>
References: <20260512223215.25596-1-aldocontelk@gmail.com>
 <20260512223215.25596-4-aldocontelk@gmail.com>
Content-Language: en-US
In-Reply-To: <20260512223215.25596-4-aldocontelk@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/13/26 00:32, Aldo Conte wrote:
> Convert the driver to use device-managed resource allocation:
> - Add tcs3472_powerdown_action() and register it with
>    devm_add_action_or_reset() to ensure the device is powered down on
>    cleanup. Before this patch, the chip remained powered if probe
>    failed after enabling it.
> - Replace iio_triggered_buffer_setup() with
>    devm_iio_triggered_buffer_setup().
> - Replace request_threaded_irq() with devm_request_threaded_irq().
> - Replace iio_device_register() with devm_iio_device_register().
> - Remove tcs3472_remove() as all cleanup is now handled by devm.
> 
> Rewrite the read-modify-write pattern in tcs3472_powerdown() and
> tcs3472_resume() so the new register value is computed first, written
> to the chip, and committed to data->enable only on success.
> 
> Use a local 'dev = &client->dev' in tcs3472_probe() to keep the devm
> calls compact.
> 
> Suggested-by: Andy Shevchenko <andy@kernel.org>
> Signed-off-by: Aldo Conte <aldocontelk@gmail.com>
> ---
> v2:
> (Suggested by Andy)
> - Rewrote read-modify-write in tcs3472_powerdown() and tcs3472_resume()
> - Use local 'struct device *dev = &client->dev' in probe.
> - Dropped "Compiled with W=1" and test details from the commit message.
> 
>   drivers/iio/light/tcs3472.c | 107 +++++++++++++++++-------------------
>   1 file changed, 51 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
> index 4fd4fd74d0d6..7a6dc8360326 100644
> --- a/drivers/iio/light/tcs3472.c
> +++ b/drivers/iio/light/tcs3472.c
> @@ -427,13 +427,38 @@ static const struct iio_info tcs3472_info = {
>   	.attrs = &tcs3472_attribute_group,
>   };
>   
> +static int tcs3472_powerdown(struct tcs3472_data *data)
> +{
> +	u8 enable_mask = TCS3472_ENABLE_AEN | TCS3472_ENABLE_PON;
> +	u8 value;
> +	int ret;
> +
> +	guard(mutex)(&data->lock);
> +
> +	value = data->enable & ~enable_mask;
> +
> +	ret = i2c_smbus_write_byte_data(data->client, TCS3472_ENABLE, value);
> +	if (ret)
> +		return ret;
> +
> +	data->enable = value;
> +
> +	return 0;
> +}
> +
> +static void tcs3472_powerdown_action(void *data)
> +{
> +	tcs3472_powerdown(data);
> +}
> +
>   static int tcs3472_probe(struct i2c_client *client)
>   {
> +	struct device *dev = &client->dev;
>   	struct tcs3472_data *data;
>   	struct iio_dev *indio_dev;
>   	int ret;
>   
> -	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
>   	if (indio_dev == NULL)
>   		return -ENOMEM;
> 

Hi Jonathan,

In v3 I have a small style cleanup: replacing 'if (indio_dev == NULL)'
with 'if (!indio_dev)' in tcs3472_probe(). This was suggested by
Joshua Crofts in his v2 review.

What do you prefer it is a separate patch
or folded into the devm conversion patch (which already modifies the
context next to that line).

Either way works for me. Which do you prefer?

Thanks,
Aldo

...

