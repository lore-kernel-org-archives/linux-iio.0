Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6C333B974
	for <linux-iio@vger.kernel.org>; Sun, 22 Mar 2026 14:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774190069; cv=none; b=YzErtejtc3kFp6YuCnTjTTDZPaG06JfWt3GZ4iyp4lShrqQpzHTiM2D4fByDQ/nF3tvk0aeRpj5ZwcMU9pQ1x2O+gb5TUo9+ek7zpMAjKEPunqmV1UqS63nPEPdrjp0HXqUAL6aXRsxjJjpCjOve8lV8IvHBfzZlWwjLUylslc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774190069; c=relaxed/simple;
	bh=U7KSkfO7CouU1DVjGUDWy4vJlG1h+IQKkVaM4pMQIEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oT3BCNMnKVMwZLEixCp5pWzaXI/RbzBxH2oexgYj8sWZVu/wyI1K4sm+K6UZN/66nVX9ZL8BxKn/R31g7CLIgq7JdyisH1Wk4Xu5+RfJ2sDJjW/YMQSnyzXb7qSWjhcmjhoowqNDmZwC3W1KiAcL9ayg6bWNEBVc3UIW4WZKdEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=eJXfjWn/; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eJXfjWn/"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d7422b4ff1so1130324a34.3
        for <linux-iio@vger.kernel.org>; Sun, 22 Mar 2026 07:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774190066; x=1774794866; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EWy0Djm3zJ1FDFJX6sj4xTqQeSs9XFMQf8coYBnmbE4=;
        b=eJXfjWn/NIhAlDxms9b45lp1DX/XkAD4hS6W7Yt84L0V4pL/gcnDWimKH0/DJv/YLP
         /C3LPrDVE3ADCxVfe0NTJMzjyQyWqlrDzeYP9gNWVoz2KxVjvX39SRI1UsyxtlP37AoE
         0FZHo5CPbxanKGqV+4KB4x0Vo7drH4jfuU/6LNbeI5rT4p9N6fXWpQ5tSbNtzGBayq5c
         vw/hG5pQQt9VSeP4TRFEN09ExHxU3ydo6xHpCxT8P/bghK8ekawydSgNmO+pjq/+cR+L
         Qkrmau227i6pMYvol/XZbnzL8NkTyTFx0wAeaQOglFGexkkMtg98EeIEro0/zr9XexzY
         LqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774190066; x=1774794866;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EWy0Djm3zJ1FDFJX6sj4xTqQeSs9XFMQf8coYBnmbE4=;
        b=AN0Z4SKppPLZu16+/94JT9d7jAuGjTEoEspQze7dXctO8WV84a899gGIUEb+LGp4B/
         c+DGO/PrrcHDXAK6Ha2EmLtvNzc7M+ldoY9Jz2fUKqrY2IttuZ6WNzVKbBSOhJ/1qydm
         V61K8Nr/HBPyi/KZwxyI54KygEzpzPBwvEgvPmROt6PRRWifcbISEvgY1vkhCunEchMI
         K9ukmCpbGvHqi7uftqsPmBxTxWv3TVcw0mkqqDG/EJ0ps3KDSlOFBVadhwFjWN8dFkrf
         masmsObQi+dz8OoW2RpAHVezR33kvGq7jXAnPwqzucYQnfiBi3m/jZKKH6qwr4G96DkO
         V0Ug==
X-Forwarded-Encrypted: i=1; AJvYcCWaa1bFdJaGpuEBR8hD+p8D+wijNGq/EONYYaD6fLLMUQO9dn5s6qOfOqqEMHl8F7NH7YvsZeIriUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiKvLIqbsMMUq+IARNnrar50aJYZmV/xCsoh/EwxpGNGnmJGXK
	UaHwCrTEAWHFqtpbseslSk9kUd1X+QPmUcDBRBcMY1ZgF7Q18eLUjK4cN0sAgW3ezKl+EAuZD6n
	WPb3u
X-Gm-Gg: ATEYQzybu3sJ/DZPoLSZ8YiCAAkIrjKl9+R+my54k19l3wfNXAsPBkFKDIu45YzDAFg
	jiqRzhJdRTaLOYd14WI+rq3FhBuZoqDVZu3gLahlnar9RCBZBj3mHzLPl73Abu+P0YeiIKTeoL1
	1VVbPG+bkGv4YzDW6/JrvTuJr8W7KHrjgwtJbnFvdBBrqR/R2zOGkxhZX2u4sXrGmzYdEgu42uO
	IXLFcmjuEgwP751vA0Tq6ozn80OVrNNeEe9EuEHK5KUhvBHCLP4UK1LH/7w452OG9/uah2sQ68S
	cOpiB1t4SJAiiYUD9vLqkvPoCR/aSBMBIAphQiqJOPRygnU9YADKRpXLdgJILQ7Z16Ju03W3aWp
	7cDDRis6f0G+WPOPmUGSbUd2bLDoBUOPA+WT2wkB9iJxhCwIbxyg6Nsy0WZ70iIw0JiD+Uaqsjf
	j5qMQQmj/kIrhLEHTUm6C1GbBVso3Mx0+wXQkN1xmPjpNbqmTTv/R0uZXpmNBm/2gPWf8SgI8=
X-Received: by 2002:a05:6830:4491:b0:7d7:fc2a:2fab with SMTP id 46e09a7af769-7d7fc2a32f5mr4003877a34.33.1774190065660;
        Sun, 22 Mar 2026 07:34:25 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:fb84:df2:aafb:553d? ([2600:8803:e7e4:500:fb84:df2:aafb:553d])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7f8ec22casm5207885a34.21.2026.03.22.07.34.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Mar 2026 07:34:25 -0700 (PDT)
Message-ID: <b90be3d0-1372-4ace-8e7c-aeab1ff60815@baylibre.com>
Date: Sun, 22 Mar 2026 09:34:24 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: chemical: mhz19b: bound receive buffer copy
To: Pengpeng Hou <pengpeng@iscas.ac.cn>, linux-iio@vger.kernel.org
Cc: Gyeyoung Baek <gye976@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org
References: <20260322031923.58031-1-pengpeng@iscas.ac.cn>
 <20260322134807.16217-1-pengpeng@iscas.ac.cn>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260322134807.16217-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/22/26 8:48 AM, Pengpeng Hou wrote:
> `mhz19b_receive_buf()` appends bytes to the fixed 9-byte command buffer
> without first checking that the new chunk fits in the remaining space.
> A single receive callback can therefore write past the end of `st->buf`
> before the driver sees that the command is complete.
> 
> Drop overlong chunks and reset the partial command state before the
> copy.
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---

Please don't make v2 a reply to v1. It makes it hard to see that a new
version has been sent. Also, please include a changelog here (below the
---) when sending new revisions so that we know what changed compared
to v1.

For this patch, you can just reply with the changelog instead of sending
a new revision.

Also, you received an Acked-by on v1, so you need to explain why you did
not keep that tag when you sent v2.

>  drivers/iio/chemical/mhz19b.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iio/chemical/mhz19b.c b/drivers/iio/chemical/mhz19b.c
> index 3c64154918b1..fbd7f14483b3 100644
> --- a/drivers/iio/chemical/mhz19b.c
> +++ b/drivers/iio/chemical/mhz19b.c
> @@ -240,6 +240,12 @@ static size_t mhz19b_receive_buf(struct serdev_device *serdev,
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(&serdev->dev);
>  	struct mhz19b_state *st = iio_priv(indio_dev);
> +	size_t remaining = sizeof(st->buf) - st->buf_idx;
> +
> +	if (unlikely(len > remaining)) {
> +		st->buf_idx = 0;
> +		return len;
> +	}
>  
>  	memcpy(st->buf + st->buf_idx, data, len);
>  	st->buf_idx += len;

