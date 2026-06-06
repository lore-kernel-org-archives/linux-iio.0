Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D7115A85A
	for <linux-iio@vger.kernel.org>; Sat,  6 Jun 2026 09:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780738043; cv=none; b=V990PN2iogpE2PY2iX/C8hVq2dGB2VopKXujQPZ6XjNzgoUJVleJ+kzG5NxtalubYAX8amsL/9LwP1ins3hQ3EEl7DRmLC1vREGX2rrxb9yu0wPQQa1jZrIv7Z7CtGf5hPhJbcXjvxHOIjT2JfenWxHVeuGIicuPIzaZSQ4rmxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780738043; c=relaxed/simple;
	bh=oAYcyU/xg32+wm+itzwDqLCUlfsHpkpwyRpoAl2AWxY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=imyQqosI/xs74OatgYlFP6ZgkBRPtXEdqqN1b1ywGyisL1bWgMGbqIEBTjab/tdLc85iVCkDbB2Yt4IA6/7jbTwKLA4/SSxJQ56Fe5WcGL7DyZPG5cC+BXECBhNE2AX/vGFKyePvGW0orj4JO82g1s8IHNO4v46v/9smHpeSSGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZuktn8k; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZuktn8k"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-45ef5146b56so2399551f8f.0
        for <linux-iio@vger.kernel.org>; Sat, 06 Jun 2026 02:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780738038; x=1781342838; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6rnRDWNFodJfpGcCxgsSzIm6WWEVisydV6yWbLjUSzg=;
        b=ZZuktn8kr543bkfzyigF/qBxC/dOSpD7Np/+SZriQJ5BUSPyEQPyG93PowgCqnW58b
         FfUbM3l51yZ81GN18yIdw/Dq0UcbxHu0hnNGGeOGhlTSS6GYPJxEirgp70blg0B4xrUV
         cIKN8BhPWHL3YVMRJ+oaflDuGh34wdmoSYzy9bIl97jNB5SlNiIBfO/WOHAwH0zxJDJM
         ncriqwJuSF66G8gnIveYQw6XoGixXwYZXmfPk02Ik8H8eoDMa7d8REyvHiTCOTrOwchQ
         E9xcFxLzgoPG0qxKBtD1dtQVc0/CJjZ/7fkbz0BZkmaW1kxcSzE5fkxF+5bh2fDMTEAX
         lFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780738038; x=1781342838;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6rnRDWNFodJfpGcCxgsSzIm6WWEVisydV6yWbLjUSzg=;
        b=sG16zrkk3PyYqRyxG34M5zbg7hPzBWS1EixxTE9R8dSJPfvEst+szTFStcyAJSVAKb
         JjzznsN1vGTrbaVYrnxtigtfh7k3AvF20sdeIyLV8z993vw6gUED3hg7mD+DE+xksnaL
         kz0t7mI9W6euMZ6eaM01HuFcWhlZxOXWHntTNhoZ5pJUSqUJs5jIXdLK8gGxUTFdny2o
         olQBWRIBwoYRgJkqWtrrBTt6t/rGN+vrwDkVUUkuxN4AuxAyneKEiYYj7jLLwaVVRmGi
         TMT+5sw/f0X6hQI+4uqDZuo6ACIrR0zxyhKXUws6tONU07Cl//nQXhP8EAfHlXgH8BFu
         YKAQ==
X-Forwarded-Encrypted: i=1; AFNElJ/C3oW7zivmTVfjT2rqRoAaFVghE6+Un65uOPhe5aOXBzUSXoLy7p3Oi+TUd1yLPWAE/9gPzTI/KqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM7jG+E3RpN7HZAyEsmbNJcIs95/oRtiXEe7P983GE7nUlHQNq
	7nilxLe0XZaQYobeV3/4b5B+XzdLM/5w7Z2L8Lza9dKZ7GCJvo/Qfljz
X-Gm-Gg: Acq92OGT78uFl0yUtHkKgUvpY/v9/zdWtMPM1PZWhWNFfYv6I4+GBS0BJDWiVhpTYxs
	guTQsM/dPcp/YG1ukCP00jVkQXU9itKYQLPtdC0QFMto41qtCs5wqLXm5CTVpfcTcu9r1HUNqey
	Hlg6uXzFSyiPmkoSYsieE463sBtE5qXlqGpCHyr1THvuaoJyHTtBz5/vOQzXnZqwGE+Gof9aTcZ
	SmCsCvigQnk0YB5rPYrYdllvpCOWVc/vDPrilH057WOkFzwM8A5x0SZb+R4n5OaOeBHi0nsZDBq
	jfAEtPNIE6tH017r97yD02kYwITOT89fDMIReWRbKockXHxWCjHoK6qX3K4k+f6E7GGhgNTUaAU
	0LSaQHT8OZ3LiG6qolAe4Dz56YbkrwAuJs6NeXs0FoUAF76EJ+qCXz6itDbB7QcJQtjP2VWt74U
	7c4klzzidcFxznBRGlBAcLdiOPAla1rB/sooC8vy75b9AyoU81Wxgmc7Ov73cbCtVL7yasPziNW
	VtkrdUWsA==
X-Received: by 2002:a05:6000:2083:b0:460:11bd:3fde with SMTP id ffacd0b85a97d-46032da2286mr8499620f8f.13.1780738037992;
        Sat, 06 Jun 2026 02:27:17 -0700 (PDT)
Received: from ?IPV6:2a01:e11:5402:d840:f1ee:c5d:74e4:6e19? ([2a01:e11:5402:d840:f1ee:c5d:74e4:6e19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46028a6dce6sm25534821f8f.30.2026.06.06.02.27.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jun 2026 02:27:17 -0700 (PDT)
Message-ID: <8392f8a6-719e-43d9-813a-0a163f450ed8@gmail.com>
Date: Sat, 6 Jun 2026 11:27:16 +0200
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
 <9c0bec93-e102-4655-8074-fd544b16d912@gmail.com>
Content-Language: en-US
In-Reply-To: <9c0bec93-e102-4655-8074-fd544b16d912@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/06/26 11:23, Aldo Conte wrote:
> On 22/05/26 14:34, Aldo Conte wrote:
> 
>>   static int tcs3472_req_data(struct tcs3472_data *data)
>>   {
>>       int tries = 50;
>> @@ -166,16 +214,131 @@ static int tcs3472_read_raw(struct iio_dev *indio_dev,
>>           *val = 0;
>>           *val2 = (256 - data->atime) * 2400;
>>           return IIO_VAL_INT_PLUS_MICRO;
>> +    case IIO_CHAN_INFO_SAMP_FREQ: {
>> +        unsigned int cycle_us = tcs3472_cycle_time_us(data);
>> +
>> +        tcs3472_cycle_to_freq(cycle_us, val, val2);
>> +        return IIO_VAL_INT_PLUS_MICRO;
>> +    }
>>       default:
>>           return -EINVAL;
>>       }
>>   }Hi Jonathan,
> 
> One more thing on v4 before I send it.
> 
> For Sashiko's "tries too short" finding, I made the timeout dynamic
> based on the actual cycle time:
> 
>      cycle_us = tcs3472_cycle_time_us(data);
>      timeout_ms = max(1000U, (cycle_us * 2) / USEC_PER_MSEC);
>      tries = DIV_ROUND_UP(timeout_ms, 20);
> 
> 2 * cycle_us gives some safety margin, and the 1-second floor keeps
> the original behavior on default configurations.
> 
> This solves the timeout issue but introduces a new concern:
> tcs3472_cycle_time_us() reads data->{enable,wlong,wtime,atime}
> without holding the lock, both here and in the SAMP_FREQ case of
> read_raw() (also flagged by Sashiko).
> 
> For the SAMP_FREQ case I'll just add guard(mutex)(&data->lock)
> before the call:
> 
>      case IIO_CHAN_INFO_SAMP_FREQ: {
>          unsigned int cycle_us;
> 
>          guard(mutex)(&data->lock);
>          cycle_us = tcs3472_cycle_time_us(data);
>          tcs3472_cycle_to_freq(cycle_us, val, val2);
>          return IIO_VAL_INT_PLUS_MICRO;
>      }
> 
> For tcs3472_req_data() I plan to use scoped_guard() only around the
> cycle_us computation:
> 
>      scoped_guard(mutex, &data->lock)
>          cycle_us = tcs3472_cycle_time_us(data);
> 
>      timeout_ms = max(1000U, (cycle_us * 2) / USEC_PER_MSEC);
>      tries = DIV_ROUND_UP(timeout_ms, 20);
> 
>      while (tries--) {
>          ...
>      }
> 
> Could this be ok?
> 
> Thanks,
> Aldo
Hi Jonathan,
do you have any updates on this idea?

I have already implemented it and it seems to work.

If you agree, I am ready to submit the v4 of the patch.

thanks,
-- Aldo
