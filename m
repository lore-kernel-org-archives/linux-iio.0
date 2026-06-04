Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9286394EBD
	for <linux-iio@vger.kernel.org>; Thu,  4 Jun 2026 08:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780560607; cv=none; b=uSQWNNc+Jl3bK3t4lu3TBbsa3JVhs1geJGHkpu3sR10S1MVSjsrcdSkcZIoxgugzHeCisg0Tdj5v90Pm1UsF9ORrT/fwh6M0sEgJclGlo1jmzjQ1wDQIabi8RN/Zy+7D0BIwFek05nvwkYOkwz92sa4/FVbMX2c7a6fFYMA3r+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780560607; c=relaxed/simple;
	bh=FZQMkrX+okeT4SlD7Tf4t2UW+eiFRO3yu1a1DqNEutQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=SbVbwTepDK7ZDGqtV2l11pQHopy5r/YLiIoTNK6B4+fxy3AmlvKszY7LaZRV1leaZ43r4cAQxQh5/T98Pjyj5fUbRnkRDZCso9j8MRJY+yY8K4bUUaDk2juCWnX5sZKfQK6u0dD/LpChiZplxS9Bv40CZmVD0YHQz/hzwGr04/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHzm2vdW; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHzm2vdW"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-45eea68dd6fso179329f8f.2
        for <linux-iio@vger.kernel.org>; Thu, 04 Jun 2026 01:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780560604; x=1781165404; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eq5xpfpddkc8h4wqB4/es/lPRW0lpYTExJdBasPpfqU=;
        b=gHzm2vdWb5QrHBHaFxWY3RL8CuRx0ktyVIsGN73YoZ1OWoOE4wQ4D0VkpDXhN//C+p
         INr6eRBV1qEvj3YXhOlp9FRlKuXahBC541J7PTngjtIaWo0pcl/j7mf+YO2/2ExXps5Z
         H0TZIrOn0GC+8sxLJPCvmfxyRXzYlCI+g8f0Bln61QKtpDml2FLu5o3+0z4vziJAVzdm
         SRT56Vdjj88MaX2Qv8uM1S1XYuc3YEvwieXMGgPJBTSr3dE+UZfNIzH8A4dDTwYiacVs
         IKVVGxjyZoBmeKMsCupveGXy6Tf1ZV89AHepYz79LbkVeLbcONLp83Dr2KYNmajq0H5f
         bRhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780560604; x=1781165404;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eq5xpfpddkc8h4wqB4/es/lPRW0lpYTExJdBasPpfqU=;
        b=VQuEWmQiWs8BaPxwqtL2fxwiNjG7L+/stKTJWJrS6j8pix4s4ccZoJSHwHgs2ZZmBH
         kBLdyezgYU6r6mwVkQaBISuM1q1U5DcrCC1sDZebK3yW9PDouqXsLpMxw91bM2ZAIr/Z
         U46w5+w2KDSi4xkAQWqayDU8JtBuYpx6NlFzjKRAjbHTPBS2PxzeIK/tvsDTS5dAce4z
         kcIonMeNie2IuRqUCJei8bdmFUsje15zSiVevxc6FvhKHTGcgadKkPnl9GN9nbbvlZRv
         vtUXdzjQcHkcwZ46mKSr4Q3TB+ibKl/g5NDuy6F2o/5sXH0iSWDwLEg49a5UzQQYn5+R
         Zwow==
X-Forwarded-Encrypted: i=1; AFNElJ+I/+ZR3ARNJheZwDzNTwJl33TykAqyPQXOpWxJmg/gF44RvklzMNJ+WNts6eInMsc4BDBJwa+YSag=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyaf9+rqv3TXD/meFpXxYpaNPUXGNXgmZg2DeeQ4Gw1UexheN6o
	MKHk75b3C6iqRpMcPb0zabBGpFQVZvqMzVeZ3qt0JeIWcGvC4hhl/D1Sc4t/DE04
X-Gm-Gg: Acq92OHKeABw0wmqgnu3bVIzQy1zBo5Wmitglk9QYZo9kc4jQ3ky+7FFepBxcvGTtbo
	2jW2LHjFpB+z+jcmwCWw3a3Rv/dzdBL/klhN2jw8NbtGvji2IOCiZDIlZXKvzKRcqtvReGcVkKH
	QZsU07l9MAzkS7CX8POkzBekzvoY3mNLqsE1wzW6Dxg22ABiiS+9noTiXipcGGUKAhXN5FRax9p
	NSzHemTr1K3EurDTYGcNR7hVaSDLlD+HJfCwDkvViJdzie6AdXE7+sAyTANljUHwEFf8XAwTJ//
	gh/7SzLWdofEJzexaDJwQr1bKCKOcIT3t/Bq27CEez10jiBSgjC603nCxc/DVNEFSRN5Oc/4EoH
	+y/SQzs9mTh56wIsgH9sUajYPURaK6Qn1dcSKiSY4pe7eyRKb+Bc08qsZEYkOkNmbuNsFCaVS3d
	11vNMAFkj0vrBd3+7MrZbRt6+Wht+7+A1q+uWlYvvSybLITX78mwc=
X-Received: by 2002:a5d:4987:0:b0:451:3b12:9bca with SMTP id ffacd0b85a97d-46021831001mr7968041f8f.25.1780560604206;
        Thu, 04 Jun 2026 01:10:04 -0700 (PDT)
Received: from [192.168.37.44] ([217.61.173.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2eadefsm15126722f8f.11.2026.06.04.01.10.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 01:10:03 -0700 (PDT)
Message-ID: <d82b27d8-4e0e-4749-bea7-a09f43554fb2@gmail.com>
Date: Thu, 4 Jun 2026 10:10:02 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] iio: tcs3472: implement wait time and sampling
 frequency
From: Aldo Conte <aldocontelk@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 shuah@kernel.org, joshua.crofts1@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
References: <20260522123420.45495-1-aldocontelk@gmail.com>
 <20260522123420.45495-9-aldocontelk@gmail.com>
Content-Language: en-US
In-Reply-To: <20260522123420.45495-9-aldocontelk@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/05/26 14:34, Aldo Conte wrote:
> @@ -196,15 +359,29 @@ static int tcs3472_write_raw(struct iio_dev *indio_dev,
>   		if (val != 0)
>   			return -EINVAL;
>   		for (i = 0; i < 256; i++) {
> -			if (val2 == (256 - i) * 2400) {
> -				data->atime = i;
> -				return i2c_smbus_write_byte_data(
> -					data->client, TCS3472_ATIME,
> -					data->atime);
> -			}
> -
> +			if (val2 != (256 - i) * 2400)
> +				continue;
> +
> +			data->atime = i;
> +			ret = i2c_smbus_write_byte_data(data->client,
> +							TCS3472_ATIME,
> +							data->atime);
> +			if (ret)
> +				return ret;

Hi Jonathan,

Two questions on the INT_TIME case in tcs3472_write_raw() before
I send v4.

- The compute/write/commit pattern issue you raised elsewhere
also applies here. I plan to swap the order: write first with i

return i2c_smbus_write_byte_data( data->client, TCS3472_ATIME, i);

then update data->atime only on success. OK?

- Sashiko flagged a race ( 
https://sashiko.dev/#/patchset/20260522123420.45495-1-aldocontelk%40gmail.com ) :
target_freq_hz/uhz are read without
the lock and then passed to tcs3472_set_sampling_freq() which
takes the lock internally. Two options:

1)  Take the lock briefly in write_raw() to write ATIME, update
     data->atime, and snapshot target_freq_hz/uhz. Then release the
     lock and call tcs3472_set_sampling_freq() (which takes the lock
     again internally). Minimal change, but ATIME and WTIME updates
     are not atomic with each other.

2)  Split tcs3472_set_sampling_freq() into a public wrapper that
     takes the lock and a __tcs3472_set_sampling_freq() helper with
     the lock already held. Then in write_raw() take the lock once,
     write ATIME, and call the helper. This keeps ATIME and WTIME
     updates atomic.

In these cases, what is used to do?

Thanks,
Aldo

> +
> +			/*
> +			 * ATIME just changed, so the cycle time changed too.
> +			 * Re-run the sampling frequency logic to recompute
> +			 * WTIME and preserve the user's last requested
> +			 * frequency.
> +			 */
> +			return tcs3472_set_sampling_freq(data,
> +							 data->target_freq_hz,
> +							 data->target_freq_uhz);
>   		}
>   		return -EINVAL;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return tcs3472_set_sampling_freq(data, val, val2);
>   	default:
>   		return -EINVAL;
>   	}


