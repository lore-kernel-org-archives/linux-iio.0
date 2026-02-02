Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C4D2264AD
	for <linux-iio@vger.kernel.org>; Mon,  2 Feb 2026 15:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770047425; cv=none; b=XugSNgOY/51hYQyDjCjFVZ9uA6dsMr5klHzLHXPsVYc16/pJYvLte19QUWJ+ll+0dn6eolxQ0g8ChWTXg1BL6QG1B918pZQ8OHw12nmRrBkvVbkUJnUEScGhtIb+jhF50JhKWGYmFsHEBlPCDbu/ASrTcx7Jh6k2npw4xLlbU/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770047425; c=relaxed/simple;
	bh=Brjk4IdN51zZB9Magk4cZB5p9EXzv4j4vDko606r5Ro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r8uYYGuxIdJ4IKqJiUBJlfGW6WXSreaV2j58QYEGTVngEsEKgfOkfrCNAjnr33Y6Kacvve56m8ePjo7EV85VkPVjf7ZlTFXmU7pJrhqEejGwZN1xSFtYYa8bZcP675Ove2ewxjj9w0jF3uDkQvaFCs0CTPMWVTtMZeZEWLfe8zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rU3Zz5f0; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rU3Zz5f0"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-45efd53148eso1633904b6e.0
        for <linux-iio@vger.kernel.org>; Mon, 02 Feb 2026 07:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770047422; x=1770652222; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hnDDUa28LGqemPTX4cc38DKDuI7QrSxNj3QqouenRIc=;
        b=rU3Zz5f0vaiHe9jFp5kBxd3zND5KukNqfcw0VK8/CaQw1J9flMPgRjKsbk4NZ41MER
         lTmJlBOl5qQGEu7GG9nx8R1+eEs4wBDiZ2gbaJBv8CIXMGa7Rq8lgwqoMvMkQtyc0BYG
         i8j0qh0OiC2CEwI2PDL4Sm6nUpB1qdyvtAnAGSX9VOqKWXONqnvTKlUiXjFLw+/kCz0F
         a7MPDj/ArAN3M4gzy2VmqxnIR/75IqFnOtjIVv7+APTASma3Um65A/ydJp+npdKvm4Ph
         0xkxwgYvhEP6V+CHvhMf/+4YYYVxbanS9pRaj+Jh/4Rzy2nnCDYzfR6EoQRawDc9i8DU
         Egyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770047422; x=1770652222;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hnDDUa28LGqemPTX4cc38DKDuI7QrSxNj3QqouenRIc=;
        b=d9uyv5FRyiJypsLyL9miFlqhG9OcFHdD6cFGboYF4Txdr3v+I6wai+ixi3CHmdxzkd
         wSlbY9N3qf2s9jjNVKL5XAS1XJyAPJwz+rtngzqqEoZpI50YRXCwGVOvFhZOliP/gbz2
         LO72+JSh9Ji06cBTDWjewo26HLDwKgxRYZDtwpD7j76z1BgXfyKERzVaHM35HJq2Pkaj
         jxkUzDco9T25IzMyUmuNHUGo+0x1g+ULj8CaEQQ2qk0Np+vJLo3Y3/l2lYfxiaCHtVkw
         PG0UJu849ov1ep6jHVlcoPfLN9chw7e6kdETjoa7h9QMWZdwKE/VP6HRfoPf2ariFYPR
         1uKw==
X-Gm-Message-State: AOJu0Yz+2lcrshnt3/N+0Gy9X2rFSlxS8B/sfpuPgM2POuM4OKWd3L2C
	4ig/o3tmNDLrwVkfIyFBcmRx51cYP1Co1+rFMZ/H4uHQiDTyULBc9dshmf44M6u73c4=
X-Gm-Gg: AZuq6aLXJ7ZItomo23pkUjlkS3Y6okIdURfVO6LIgEBt617R/0Y3b8LjsKsOg+zXqd4
	z/AjiI/FxBcWhN+xO+TOakQ41Lz4o71JCx22d0XB+7vB5F4JxzpQZyMwyM8XDdZ6/tCPUGd8o7s
	Jyq8xoZcQBU27KHEVtG06QctFu52Pps9KyfulMx9j8P89rzw1O2a4Mhps4sG1WPiPJqsIRvFjME
	f5d+URe3C6NEWTBKpsrEDXebte85GSR6SbXFpGeDx4Da8Fo3Jo1rRU2OriFnAOD1bTIPzOWKhyb
	PNHfnRecG6pyEz084rQZ/hD6Ff7uWyiEjtzVt+XRz/V8DiLuyrMuDXLD8hLNTvzAJqsiBEuS+LI
	HieUwhl7nxLu1LNvN42tIg/xQk8sofbFh8ROVwUrUtackXpGny044NpzaT9XSoSIKR3K3rrmgrZ
	NRIJZWsg8HM3zK4c+2yDxFBMDlR/dVs+4dTqTCmzDLaH0rIBAje1v9WecAxeEP
X-Received: by 2002:a05:6820:2217:b0:659:890b:3f9 with SMTP id 006d021491bc7-6630f0516b0mr5626553eaf.4.1770047420206;
        Mon, 02 Feb 2026 07:50:20 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:3695:6954:27c2:42ef? ([2600:8803:e7e4:500:3695:6954:27c2:42ef])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6630606f2dfsm8782278eaf.13.2026.02.02.07.50.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 07:50:19 -0800 (PST)
Message-ID: <215cabfd-497b-4f22-ace2-ff8f6145d79f@baylibre.com>
Date: Mon, 2 Feb 2026 09:50:18 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] iio: industrialio-backend: support backend
 capabilities
To: Tomas Melin <tomas.melin@vaisala.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <noname.nuno@gmail.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260130-b4-ad9467-optional-backend-v5-0-7da803ba7326@vaisala.com>
 <20260130-b4-ad9467-optional-backend-v5-1-7da803ba7326@vaisala.com>
 <688cbfb1-0944-492a-929d-91ebb9ab22fb@baylibre.com>
 <812a8c408c2e3a87ebe1ddc983acdc2cebe3b36b.camel@gmail.com>
 <30cf63eb-50ba-445d-a78b-d6532aacdc8e@vaisala.com>
 <177d62446d9c2098bbfe8b0f7fd9418d5afb60fc.camel@gmail.com>
 <aa5010ba-27bc-4c0d-9fce-8264216d4aa1@vaisala.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aa5010ba-27bc-4c0d-9fce-8264216d4aa1@vaisala.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/2/26 7:04 AM, Tomas Melin wrote:
> Hi,
> 
> On 02/02/2026 14:40, Nuno Sá wrote:
>> On Mon, 2026-02-02 at 13:08 +0200, Tomas Melin wrote:
>>> Hi,
>>>
>>> On 02/02/2026 12:28, Nuno Sá wrote:
>>>> On Sat, 2026-01-31 at 14:30 -0600, David Lechner wrote:
>>>
>>>>>
>>>>> Do we actually need this one? Alternative could be, for example:
>>>>>
>>>>> int iio_backend_enable(struct iio_backend *back)
>>>>> {
>>>>> 	int ret;
>>>>>
>>>>> 	ret = iio_backend_op_call(back, enable);
>>>>> 	
>>>>> 	return ret == -EOPNOTSUPP ? 0 : ret;
>>>>> }
>>>>
>>>> I would prefer not to assume we can ignore the backend not supporting
>>>> the call. It opens up the question for other operations.
>>>>
>>>> My preferred way for this kind of fundamental operation (enabling/disabling)
>>>> would be to check with DT maintainers if we could have some kind of fixed-backend
>>>> (fixed in the sense the HW is present but not controlled by Linux) dummy device that
>>>> with implement a no-OP enable/disable().
>>>
>>> There is also use cases for the always_on cap with a configurable
>>> non-dummy backend. Some applications are such that the driver should
>>> leave the enabling/disabling up to the user space consuming the data.
>>> For this case it's great to have the frontend leave the backend enable
>>> alone using this capability.
>>>
>>
>> I would argue the above would be something to take care at the frontend level. The way
>> I see it, the always_on cap is pretty much saying that we can't really control the on/off state
>> of the backing device and we just assume it's on. 
>>
>> If we can control it but we need it always on (for some specific usecase), I would say that should
>> be handled at the frontend and just enable the backend once. Also note that as of now, I think all
>> of the users (or most at least) we have just enable the backend during probe and leave it on until
>> we unbind the device.
> 
> Yes, this is debatable. It's not necessarily always on, but should not
> be enabled/touched by the frontend during probe.
> But anyways, having a capability that says if the enable/disable feature
> is available, is in any case useful and what I was planning on
> leveraging in my use case.
> Fundamentally, with the capabilites as now proposed, it is possible to
> select what features of the ad9467 are available, in addition to the
> basic requirements.
> 
> The ALWAYS_ON capability could be inverted, like CAP_HAS_ENABLE_DISABLE,
> but to me, the ALWAYS_ON naming still seems the better option.
> 

Ah, this is what Jonathan mentioned before about this really being a
restriction rather than a capability.

Perhaps we should have a separate restrictions/quirks flag? If the flag
means "do not enable during probe" then a better name would be
*_DO_NOT_ENABLE_AT_PROBE.

And I agree with Nuno that if the backend can be enabled/disabled later
(after probe), it should still be managed through the frontend driver.
There should be no usespace access directly to the backend without going
through the frontend.

In this case, I guess we could call it a capability still. But I would
call it something like *_DEFERABLE_ENABLE or something like that. The
logic would be something like:

int probe() {
	...

	if (_DEFERABLE_ENABLE) {
		/* Basically equivalent to buffer enable, but there is no buffer. */
		register_userspace_enable_attribute();
	else
		iio_backend_enable(backend);

	...
}


