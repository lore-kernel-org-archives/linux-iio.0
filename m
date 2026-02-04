Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAFB23AB8D
	for <linux-iio@vger.kernel.org>; Wed,  4 Feb 2026 01:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770167261; cv=none; b=NORh77aavQssoWYJ9/NK1gR+Ypy8NyM7TWTUbvPs9TQq+MeWf8WfAGhXGY80YeHCLJojN5DGvzNi+5v9mGTkTV6PVNC7Fr0s7h3bLQrszAGj0S+HsG0Ogn60lhuLO3TH22DI4kGn9IlqnB8iyKL3eX0f0glvR1ZOBYAW3EEb5pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770167261; c=relaxed/simple;
	bh=xxI7mec5UdoUZoAC5zkWDSuIBrjfjO5eDLJux1jswbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QiEYrNIiDcqNTNbbHD+Y/PYwvDnXesRDo2hGnv0BV3Bq6HrLjPv7RlRbo8aLwRZoRPyQPQ51eDNL3tt6zY6kC/dw6bHPRBy+2Zkotg2xBKx+GmFpwwUsTQAyDLu4Usup5PMLlFFCvjAcPukVtxLZHDkPfnhKMusx75/oWoLk3rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BK9hABpL; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BK9hABpL"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7cfdf0c8908so174921a34.0
        for <linux-iio@vger.kernel.org>; Tue, 03 Feb 2026 17:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770167257; x=1770772057; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OuTrkpMdL03xgpmcCJA+pWmGpQI6ZJtw88w/yKt/MXE=;
        b=BK9hABpL0c36B50QSeP0GXmDvbU/4GXTopIzK0na4zc8CwlaRATr/F2wn3q3qfQjay
         72ZvenxCI+/hwSrd/7O05Th4USH8ONpW3yum6Gz6b0bkHrXzMT0Jkw3EmPjvyw+vq+ZK
         GvSPCESO/O4HLifm3JT6L74VzRoGtwRxbG6ypjNI9BTO1cRPbeJR6bMHMVatyjBfNfmM
         +fX6Q7aCuISrJyV3AKPforvCXeX8dNkd+jG023s3F8NXdyy5ed5pxHSb60wgrUVHpW91
         EJE00qfPi3hE9DgsRqW8NUzxE7DAWpU1RtMDVZJmSLtkWkewdO4escvIwrwo81DECu13
         Slfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770167257; x=1770772057;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OuTrkpMdL03xgpmcCJA+pWmGpQI6ZJtw88w/yKt/MXE=;
        b=RUh8dKtWFC032hN9Zj2B6Wt7pawRblAjlM5li9gaBWRJ44+4+bentsCemOa+ZdB7Nn
         dWozPDhzPcvQzffoLa+zgf7MLOiW8Goui47CSWP541w6W69sFBHk6AgEDuk0WGF5glQr
         GLPxfq4bQqz4LreI1yWFwrWxIGSoFCp4SDpHWw7aAO8fjPgjlMZ4jXrkMuXTR6W223r7
         4JBtk++iIoiIaDkIMEGrq4JFNxc8GnZwpevFuB7sYUoIKDlG30CZtZjuua4DOMpg1ewl
         R/diTBBQP9KD99V75wXnZoHANy0bQpCuUnBnNV8dMpPxZxHfRJCLF+DOTQNaoVXUHOlc
         1Qzg==
X-Gm-Message-State: AOJu0YzdJuO84hN7nrKg2Jwz2FXv65Puc8rU+4jGp5Txgbaji8lyYdSM
	7Oq8mZZRvHzIWTWPIcL6lhyIQmJtfQgN3kY4PJyBPkhF8CLD2MtrUDIZj/CO9h/BJqw=
X-Gm-Gg: AZuq6aK2wIM3/UkILn0BtCl+Uuy33Yjba3x7RKNaTT5XrOcBeHGGb04nmbhfAcG1MhD
	fgcgeLZ4GiibEBw7x2l+svPyxYM6TBAJJITzU7Vf0JQXHa2x7V4KYZ88gpWqzhcXcKYriixTWRx
	sY7fTv7uBa2uK6sGhfC3wxQqIrd1edSKdjwMlhnGitgb19tEmFloYLuG2Ved+tqDlPlTL1ESjao
	+p/cM28VIO5ShwSEY4IFBcQtFup5Vcr1N1JlXjBRzm9f3zWqpbnpj7cHrK0E2ByWozptpY7AEi1
	C9ZfRna7SzNNQ7JOuebDmHLYKTiocJIMHee37QXtYS6i8o/CwCgtmqGqieN5gJNPC3aXCv/YNNk
	5EOqun3qjpbQVeruhiQha9HUK4PgaTwogsl/2AB6PBuFFpgxzxgjRIYxiEJRgx1M/f5kTK+MQU8
	KLjsXYaZ7fDC7guPISTBq3Q8AbhL/GgITRU4scg9l/h6QvwrupDFTbrg8=
X-Received: by 2002:a05:6830:369b:b0:7c7:6558:277a with SMTP id 46e09a7af769-7d4489af503mr905338a34.15.1770167257360;
        Tue, 03 Feb 2026 17:07:37 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:8e13:880:992:e796? ([2600:8803:e7e4:500:8e13:880:992:e796])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d449113d34sm806042a34.9.2026.02.03.17.07.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 17:07:36 -0800 (PST)
Message-ID: <c9a5b1b3-760e-4d55-b058-e461507fcad0@baylibre.com>
Date: Tue, 3 Feb 2026 19:07:35 -0600
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
 <215cabfd-497b-4f22-ace2-ff8f6145d79f@baylibre.com>
 <e9f9e1b0-4cd7-4d6c-a7b9-25ea0e6e774a@vaisala.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <e9f9e1b0-4cd7-4d6c-a7b9-25ea0e6e774a@vaisala.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/3/26 3:50 AM, Tomas Melin wrote:
> Hi,
> 
> On 02/02/2026 17:50, David Lechner wrote:
>> On 2/2/26 7:04 AM, Tomas Melin wrote:
>>> Hi,
>>>
>>> On 02/02/2026 14:40, Nuno Sá wrote:
>>>> On Mon, 2026-02-02 at 13:08 +0200, Tomas Melin wrote:
>>>>> Hi,
>>>>>
>>>>> On 02/02/2026 12:28, Nuno Sá wrote:
>>>>>> On Sat, 2026-01-31 at 14:30 -0600, David Lechner wrote:
>>>>>
>>>>>>>
>>>>>>> Do we actually need this one? Alternative could be, for example:
>>>>>>>
>>>>>>> int iio_backend_enable(struct iio_backend *back)
>>>>>>> {
>>>>>>> 	int ret;
>>>>>>>
>>>>>>> 	ret = iio_backend_op_call(back, enable);
>>>>>>> 	
>>>>>>> 	return ret == -EOPNOTSUPP ? 0 : ret;
>>>>>>> }
>>>>>>
>>>>>> I would prefer not to assume we can ignore the backend not supporting
>>>>>> the call. It opens up the question for other operations.
>>>>>>
>>>>>> My preferred way for this kind of fundamental operation (enabling/disabling)
>>>>>> would be to check with DT maintainers if we could have some kind of fixed-backend
>>>>>> (fixed in the sense the HW is present but not controlled by Linux) dummy device that
>>>>>> with implement a no-OP enable/disable().
>>>>>
>>>>> There is also use cases for the always_on cap with a configurable
>>>>> non-dummy backend. Some applications are such that the driver should
>>>>> leave the enabling/disabling up to the user space consuming the data.
>>>>> For this case it's great to have the frontend leave the backend enable
>>>>> alone using this capability.
>>>>>
>>>>
>>>> I would argue the above would be something to take care at the frontend level. The way
>>>> I see it, the always_on cap is pretty much saying that we can't really control the on/off state
>>>> of the backing device and we just assume it's on. 
>>>>
>>>> If we can control it but we need it always on (for some specific usecase), I would say that should
>>>> be handled at the frontend and just enable the backend once. Also note that as of now, I think all
>>>> of the users (or most at least) we have just enable the backend during probe and leave it on until
>>>> we unbind the device.
>>>
>>> Yes, this is debatable. It's not necessarily always on, but should not
>>> be enabled/touched by the frontend during probe.
>>> But anyways, having a capability that says if the enable/disable feature
>>> is available, is in any case useful and what I was planning on
>>> leveraging in my use case.
>>> Fundamentally, with the capabilites as now proposed, it is possible to
>>> select what features of the ad9467 are available, in addition to the
>>> basic requirements.
>>>
>>> The ALWAYS_ON capability could be inverted, like CAP_HAS_ENABLE_DISABLE,
>>> but to me, the ALWAYS_ON naming still seems the better option.
>>>
>>
>> Ah, this is what Jonathan mentioned before about this really being a
>> restriction rather than a capability.
>>
>> Perhaps we should have a separate restrictions/quirks flag? If the flag
>> means "do not enable during probe" then a better name would be
>> *_DO_NOT_ENABLE_AT_PROBE.
>>
>> And I agree with Nuno that if the backend can be enabled/disabled later
>> (after probe), it should still be managed through the frontend driver.
>> There should be no usespace access directly to the backend without going
>> through the frontend.
> 
> Thanks for the input, that use case is slightly different from normal
> usage, let's keep it in mind if actually required. For now, the option
> to just leave the enable/disable alone is what would help to solve
> smooth integration with this device for me.
> 
> ALWAYS_ON does not seem to get much votes here, but how about calling it
> something like IIO_BACKEND_CAP_AUTO_ENABLE or
> IIO_BACKEND_CAP_HAS_ENABLE_DISABLE?
> 
IIO_BACKEND_CAP_HAS_ENABLE_DISABLE seems the most sensible given the
way it is used in the ad9467 patch. Although IIO_BACKEND_CAP_ENABLE_DISABLE
would be more consistent with the other flags being added since they
don't say _HAS_.

Probably IIO_BACKEND_CAP_ENABLE is enough to imply both if we want
to keep it shorter.


