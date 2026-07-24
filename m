Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6096D434E33
	for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2026 14:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784904459; cv=none; b=nS1Y9nlg+zHLSYDJXHj3M5suT9MCN83fioTUyJ1sKIyTLcbL8B+yxV6YeHOv6u113bV+uC7tnU45sxvYmzlBZOEyZC44HUnb1mkSc7y1IWnOMAzlLlENj09rvb/2UedVMngOfRWJXlMlO1eGR6w1caTigNrpcU401Fc+yIj8LoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784904459; c=relaxed/simple;
	bh=Nx87VYJM0REWWok6Rt3R7OhjA0KYcrlavwA8aaReBlo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EG4Zge9LM87PuS6Z4pgGfZUnnM3d0ZsKGPp89te6yWx2ACASHYDko/LuHY0WLqnHvb9zala/dpwOsPwZsyGutyjwEQixS0Q7rZl0+ZI+0L3cWcqBJyt3K/4zy7ShM+XyTogva1hD9GFRvLZ6ylWsBPd2use3mKEyfU02VEXkNG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=g9UZy27I; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="g9UZy27I"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6a375ba035eso259820eaf.3
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2026 07:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784904456; x=1785509256; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dRlF3IQQlS/Ntedp5kuuB6fxxHvV2JxB/PlK113cVg4=;
        b=g9UZy27IS3bGwUcfcBSSVlxqa+oj0k+Oh50JuGxEoI8TgqXXkkcrMgNW339Bt1s9o8
         u2cDnJrhXEkO3FepUORYO3ekqQCqKc8qxglvH6dUIsX37Ac1tsWT44aBXdsAYwkcU51N
         WHDAzyQKUjrgHzkXxPCIDGWvHsr3SQf8mDa0/CZXsYfd+FWYrfcF45ZPVRZ3nEe1BERw
         uPKHMJbmLssc5pPKfFT87ea3GYQyRKOUOneaGkoda45daxgcLpA1DsDpLEHYiQhTqh0m
         1+yDKAfmVj4it07BhWosNu1Rf4cs777pBvUfszCXzKk87Ot03OxFvxam93dxjlEP4ZTw
         DSvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784904456; x=1785509256;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dRlF3IQQlS/Ntedp5kuuB6fxxHvV2JxB/PlK113cVg4=;
        b=EtlxbbWoUegYyO7ibapsMDBXFV8jqGGC+SHvYPcYA1Ul1LL83IcF2qggk28V6tpW9+
         rKOIXevjEXOjSPj0MYKEnDkCZdMFtxI67ZtdXxIYkjzv2/NRF5ZBSIk+LYC9mPBSZee+
         WZriQ685HSmC9CA9zlM45KXejY5ish532sRst5kan1PSEIO3xn5gbQn33wbTd8cuTMwr
         naCMNl2O96gVU33bKCq6rHnBIQXkvU36QDrtmBA7nQemPWSYpse0eQRiSoL18enzMIqJ
         3GMhAQ95zjLTPTuBJfps3N59x0OkhlGre4sZxGE6FmVP5wB5ofjqFlutisVt7tVVZeTF
         kr1Q==
X-Forwarded-Encrypted: i=1; AHgh+RoDxJP2/+ZKFKTynagMpq3I9Z3cQpaM7GQYhVR3OQAIKQHQ5bdbBJO+022RHgVg0ti1v9Hy7m11Hmo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygcg69IdoPyUsr3GBfNCkZPkhvrSSRaMaUbcizgZZj+7fU0MPf
	CyWgITsmzTkLOUHmr69afglq/LY3d/RHduSaVm9wjyNJE2fwhIk0wMzmcqoPPQj6f9g=
X-Gm-Gg: AR+sD12vDxs/9XE3ocBOVmraS4JdqMrsTpsXYcPtfJf2mcJUeV9tKYM5LSb9+7T/9An
	Rr/CQBiv7Kvutl4ZURfWSZVQMQAA0F0guythBKtyJ1XGtCqFx0/gCkmMv2V3mWZ6H4Q3KDeojtj
	qWt1dsGtFKKMbUbVXKkVO20ITeDEy8J9REwS0eU28EY/hPQXlJmggQ8HzlG9zsodb+BuBk3ajIq
	eU+EBHGu0Ft+AGLeNcNB/3dpae6EOReC4KAX/ANEr/p2TNnyIWlVKv8GzfbFRjZcLww4KgdxbFp
	pKKnqYeZY9Wndyysufyt14G2IEohvi6D2x714/P6D+Lu79f5gpzGZxV2+IglO/QqSwIKkqvlb3H
	6zx6pGMSO6opy544CxNxUyqzVuImFCUdglgAPxv1t/gd9+9DW4IzTN3KnSZxzYJtRNzP50rdxvl
	/RmuB6h88nlRPeqBJMzqxUoxGAy7xWyiPJnjhmIjBQuxpH9pFX6Te3Xja9Qx2+
X-Received: by 2002:a05:6820:1c97:b0:6a1:8b23:d4c8 with SMTP id 006d021491bc7-6aad3f90dd2mr4667159eaf.3.1784904456312;
        Fri, 24 Jul 2026 07:47:36 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b635:d463:c98:cc75? ([2600:8803:e7e4:500:b635:d463:c98:cc75])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6aa79301fe8sm5634326eaf.10.2026.07.24.07.47.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2026 07:47:35 -0700 (PDT)
Message-ID: <d8d69bf3-8fd7-41ed-8fd4-8b42e9165ac9@baylibre.com>
Date: Fri, 24 Jul 2026 09:47:34 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] iio: adc: ti-ads112c14: add support for buffered read
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Chris Hall <c-hall@ti.com>,
 Patrick Edwards <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>,
 Nguyen Minh Tien <zizuzacker@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260714-iio-adc-ti-ads112c14-buffered-read-v1-0-fe6e1c971288@baylibre.com>
 <20260714-iio-adc-ti-ads112c14-buffered-read-v1-3-fe6e1c971288@baylibre.com>
 <20260720015527.0ccc543d@jic23-huawei>
 <7a600363-ae61-48db-a0a2-34b9a4919b6d@baylibre.com>
 <20260724002508.7e176510@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260724002508.7e176510@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/23/26 6:25 PM, Jonathan Cameron wrote:
> On Tue, 21 Jul 2026 18:23:58 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> On 7/19/26 7:55 PM, Jonathan Cameron wrote:
>>> On Tue, 14 Jul 2026 19:19:32 -0500
>>> "David Lechner (TI)" <dlechner@baylibre.com> wrote:
>>>   
>>>> Add support for buffered reads using a triggered buffer.
>>>>
>>>> The device has a continuous conversion mode, but that can only be used
>>>> with one channel at a time since there is nothing like a sequencer to
>>>> support that in hardware. Instead, we use single-shot reads like we do
>>>> for direct reads to be able to read multiple channels.
>>>>
>>>> Support for continuous conversion mode could be added in the future if
>>>> needed via a 2nd buffer.  
>>>
>>> How about enabling that if only one channel is requested?  I vaguely recall
>>> us doing that for another driver (though I might be dreaming :)  I did
>>> see your comment in the cover letter about it affecting timing and that
>>> making life complex.  Fine to leave considering this for another day
>>> but maybe don't suggest a particular solution here.
>>>   
>> Actually, my latest thought it to do it by trigger type. This chip has
>> a DRDY interrupt that can be used as the trigger for the continuous
>> conversion mode but we need some software trigger to the single-shot
>> mode. It think this would take care of the timing issues as well.
>>
>> The logic would be that if the self trigger (DRDY) is selected in
>> the trigger/current_trigger attribute, then buffered read will use
>> continuous mode and fail if more than one channel is enabled. If
>> another (software) trigger is enabled, then use single-shot mode
>> and allow multiple channels.
> 
> Hmm. Bit unintuitive but can't really be helped.
> 
>>
>> The timing issue is that (or will be since I haven't sent the relevant
>> patches yet) there is a settling delay before the first sample. For
>> single-shot mode, every sample is considered the first sample (because
>> it is "single"), so the chip applies this settling time on every sample.
>> So it might be good enough to just document that as a quirk of software
>> triggers for this particular chip since they would be using single-shot
>> mode?
>>
> This is where it gets messy if settling time is reported. I guess acceptable
> given it doesn't make that much sense for an external trigger anyway.
> In theory if the settling time has to happen each single shot, we could
> just merge it into sampling frequency (as no longer depends on whether
> channel changes or not) but then we have to make that dependent on whether
> it is the devices own trigger or not. Messy. I guess one to paper over
> as a quirk / corner case and document as you say.
Yes, this is the direction I am leaning as well. The input chopping feature
that we have been talking about has a similar issue. In addition to doubling
the sample period, it also includes the settling time (2x as well) minus a
few clock cycles. Even messier.


