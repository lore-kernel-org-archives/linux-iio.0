Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9FE3115A5
	for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 15:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782141333; cv=none; b=eBvGPVvaIMCc8F4IYVzMt7sfYjWnvcSW3E2aHb1TQ3TE4XMii7qWz5n5IEsiraJiCQlWIcGGgVvDbwTeHffld1yXBFBkhqyimzfZ4xT0V9XoBYQWvj8mY2AOPcX/+dSVxRJbyRysXp/ZPlDLyyawKxXjjmzWkleDxiQ2sHdXD8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782141333; c=relaxed/simple;
	bh=52v6EikHXqHTeK9jDU8zPQbmNRwFSleOTkI5p/vxXQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hPfHaBQUph4RejqK6bI6SLg45xJSMRlUSoVIlJUcCwMLiQykO9t9o+MxRU7ep8zcSRYOtJbXeKTwqhJiuJlPIt7vgl1gv4l/xw5/KW8CamWdtMGqbJWJgacYknildvz5qEWlgolDRD7XNHfgzwHpHq1MbDfsYvAV3gOkVntXYaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=ET+zK9qk; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="ET+zK9qk"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7e92c443cbcso2360918a34.0
        for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 08:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782141330; x=1782746130; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OTX1ZL/gGgSNJBSIP8X1q3a0zVOqpxsfg6hzwDs9W2Q=;
        b=ET+zK9qk8FWqzezVwmYZs3PdtILgEieEdybWYh5maqeZVtwxxJZ+L7imfhBchaauss
         PO3GNQLqDwdD0y+otwKD8W60dYFsueVWnVRSVEoC1MOln1nglOgeaFBFkadH1GT0p3ZN
         ToDhJ/91ldWemcb+xBxH7wQO27504bS2jtSdRfNdk9Zvbrf+4zd5SUTC3WJvensebzGG
         p7hAz1O68MOxsdHLZXoaZor7d5BYdMs1GJGkMfQzq0PXghvFcqJUcU7TemZbYtR14tlf
         pPqVLFCJx5dslJUw9QiHXZL2vr+GMOSdJ5XrhTik3bGS7ihD/YOmpsJw5hVKW+WZ1ktk
         stsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782141330; x=1782746130;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OTX1ZL/gGgSNJBSIP8X1q3a0zVOqpxsfg6hzwDs9W2Q=;
        b=CPA6xdks44UsqJRbaPWNK1BkwxUdi2J/XiOLHcQ9KrMXuGz3iS3YcaaWwQOeUYM0Wi
         9kLLjHent98bzDOFgJObzFj8QEIxuGxObEK+DOOBewAv96ELvZuQ1z1J8Uqn3fYdZuVN
         ZeeYAhn6H1Q3djf9p3Lrrsl+4TPDOfZSSbjgjdCVuIR8SXTNG+xvCl9a8F2SzeEF/0Ge
         u99jNRyYARfSYa6CXLra372ANYrljhSSWodSurrTWw9WvrFBt7kSClIKMdm/iA9Wyugg
         7jICOpoCJFScp9F/4aFPGKPTLL3F0jDUOILrZ5RFK5J/eQNO7Sjal4oBx2Qklug3aitI
         sF7Q==
X-Forwarded-Encrypted: i=1; AFNElJ9XlEtOm2VCN/Npusf5COGtD0IuK1lw3XVV7v/frNK5xKCi/jyvVe23wwo0uvrM6xsUoGVCGoZhMqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJp/BqWT34BXk/D3AqvEO/zN73+z7Yjr1cgRuDFJu7KrBAe3i0
	HrUSKy48s5CU5KD6Rcz046cvadHkDiOk0GroKdP78pKWUqVidWR+khwaPTGnHu1dLHD/V+0fuc/
	wjHff+Ts=
X-Gm-Gg: AfdE7cmuAG0gttK5FbS8C3hgfyqICBt0mQOrh/UGC7uWjMW5v+jCaOsVhmvZZXKLDCC
	ShrGLZDg7p+quuRghbeFl5MLXBEDuUPVNu2CCad7aJKfN1fPbGoItOrWCUpIUhmCTMwHuvUsBm3
	QrH95809SqAcojmA2atB3IH9EgRxNshpsdc6vcCfzIXYwU/xQMDryyt2BicCrVCeNuY5YTPH6yi
	rCA4EYLYNgyzXLwDpzj1uk2ZDlRZUO7+NUJHWepDV6clp39JQ/Xz4MIiryTIewWr8PYPVcBwkx1
	knJrcuTRS7i/Ifae344KH71akW7ADyaw96Ou0iALYi02OcvvIO8CpZ4lFPjBtx/u384tm3qZBAx
	bVYz1Y7e4JlIZiCYGls6ksObpVJAHefqNmZPN25OspSckeie2TwNEIXuTXT+bTLU6kU4RqatuPz
	NPoMJWwdQh9+yVLgMCPLdZcDNSKFHqECIgR5oN9tnWMyaIzpvhGgzAspkmciUKxi4=
X-Received: by 2002:a05:6830:82c9:b0:7de:4f6b:9e10 with SMTP id 46e09a7af769-7e92d455b40mr11838367a34.0.1782141330386;
        Mon, 22 Jun 2026 08:15:30 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b69c:5a77:b8fb:a5cf? ([2600:8803:e7e4:500:b69c:5a77:b8fb:a5cf])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9442e98c4sm6331134a34.26.2026.06.22.08.15.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 08:15:30 -0700 (PDT)
Message-ID: <3e8c5c72-c2e7-4e81-ab03-907899d60333@baylibre.com>
Date: Mon, 22 Jun 2026 10:15:29 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: buffer-dmaengine: Add support for cyclic DMA
 transfers
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
References: <20260611-iio-dma-cyclic-buffer-support-v1-1-bcf00e8d802c@analog.com>
 <e05dddef-2ffc-4ab6-8ce7-f676b7801eff@baylibre.com> <ai-0CIqteaSJJkau@nsa>
 <ajk1FX-d_KoW14f-@nsa>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <ajk1FX-d_KoW14f-@nsa>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/22/26 8:15 AM, Nuno Sá wrote:
> On Mon, Jun 15, 2026 at 09:21:02AM +0100, Nuno Sá wrote:
>> On Sat, Jun 13, 2026 at 11:33:36AM -0500, David Lechner wrote:
>>> On 6/11/26 10:28 AM, Nuno Sá via B4 Relay wrote:
>>>> From: Nuno Sá <nuno.sa@analog.com>
>>>>
>>>> Allow buffer blocks flagged as cyclic to be submitted as repeating DMA
>>>> transfers. For cyclic blocks, use DMA_PREP_REPEAT so the engine keeps
>>>> replaying the descriptor.
>>>
>>> Is this for both directions (e.g ADCs and DACs) or only one?
>>
>> We just have usecases of TX buffers. IIRC, there should be some
>> validation (some layers above in the call chain) not allowing cyclic RX.
>>>
>>>>
>>>> Skip installing the completion callback for cyclic blocks. Since the
>>>> transfer is continuously replayed, the callback would fire on every
>>>> period, throwing off the block refcount.
>>>>
>>>> Because nothing prevents a new cyclic transfer from replacing an
>>>> already active cyclic one, always set DMA_PREP_LOAD_EOT so the engine
>>>> correctly terminates the active transfer before loading the new
>>>> descriptor.
>>>
>>> Is there more to come after this to actually make use of it? Or is there
>>> a way to use this with DMABUF from userspace already?
>>
>> Yes. One can do TX cyclic DMA transfer today. Some waveforms examples:
>>
>> https://github.com/analogdevicesinc/iio-oscilloscope/tree/main/waveforms
>>
>> For normal non cyclic transfers, libiio also handles DMABUF just fine.
>> Best way to use it is with USB where we support zero copy between IIO
>> and the USB stack.
> 
> Jonathan,
> 
> It seems there's not much activity on this one. What do you think about
> the changes?
> 
> David, from you silence either you forgot about it or I guess you
> are happy with the reply :)

I don't have anything more to add.

> 
> Just trying to move this one forward
> 
> - Nuno Sá
> 
