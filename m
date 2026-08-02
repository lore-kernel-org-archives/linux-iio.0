Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C1B3BBFC0
	for <linux-iio@vger.kernel.org>; Sun,  2 Aug 2026 15:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785684108; cv=none; b=sDF/HUuq+Kdxl78YIt/kSQA+HWKM00wysVgfi+IH+SlpR+mUCX4k2zSu3I7n1KOBlLhb0+Y94pBFglrNxfDlsqNhPp0eDkXfRkRKdfkeDTywZmGQT7PQbbQeSJPOibpTIM2mBbyUSj+ZLdDNNrRTBh+7pPJAiJ4mw9RTOFe30HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785684108; c=relaxed/simple;
	bh=oPIPJIbT996fDCjpLjlK/ZsY97vJTBErQkLcDSYPjus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EyJb69/XXRJYjhzyMpyqHdqc37jWfp4n4sPeFZ2d529/l8B2JdAwW6o08IUZxwpQPfXsvpllGeHXnGTiFkTnDiYY4TG6YzBvsK8TQnJ7DkmA5HZsMEdBS9ms0O6JIlJlYpjJVwJEsUHR2REJpRbUuYdHhxaBGmPMaKqLwBhE0Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=FuUHKUM1; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="FuUHKUM1"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-4569e871502so701278fac.1
        for <linux-iio@vger.kernel.org>; Sun, 02 Aug 2026 08:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785684105; x=1786288905; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kPqOl4wp7KWWvdGsj9eCGVRa0PYoR/ErdETgCVgpTQk=;
        b=FuUHKUM1KzwS2MQ+9NmMqcT6uJHYboTu5ZF99UbQje0MzLpo95skdMWNbl8rDrIMxd
         fTpMLYL0uZ0iG6PiRqLmgtk8JvnCiwtWAZKWqsVkn/aY2Y6130RcXtq3gJ12ebLBIiPC
         IMaWN5fkotB6wFMThjZuqXWJOxDrK/iXTZowUUjX0nhRM4LaKSEvhzJ6blI0ti87kMll
         U01PoeijqcXdNMgCfTF6s2NgW5zaeFLk00MGIjYG7WGvwB6qb/Ym3GPTcEJw+K9dByFZ
         3ywppGBYQbXsZzSs5aiFelAIBpdHRueIml4xHSApD+4iu3YLx3hEAF0lBGsEEjeMXCCn
         araw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785684105; x=1786288905;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kPqOl4wp7KWWvdGsj9eCGVRa0PYoR/ErdETgCVgpTQk=;
        b=Q6g7JqLAa0hditatc1+oN46sz4nSWNqVwWuWuJEim0yZGX5+PQmrEKoLApm+aTCGaT
         Ousq+U0ZQIqNJrfUk1dc6OWCGnuWirsqVUFVar+CYSPExo8U9rFnjuKJRV5KrxEaysss
         6MKuPRwPZyEmksNFNGni+NzmPDxfBtGKYNJtptJxzvt7XEUoMFsNlU65Na/P/ZO5wcFr
         nCR+zLMXzuTa0xvtsld1MDUnnMOIhNRbg9AGJN4EnuH3EA6X4OR6waOA5MQwf9Qvcmhz
         nvQ4KQW49SJq3F4OOzmyGKrjxi19MAusjPTS1dnZIsVbqsUr2zqQuV/kb4v9d5HS0eEY
         AT3g==
X-Forwarded-Encrypted: i=1; AHgh+Rpp/YGa5p1ntL6hLUzcJXYs3GsQYHyVEOqL3Tss7G5VyutJ53pC6rAiWKVbPUXwkqHTvclmigrGeLw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2xM/DO7DsR9AjJHg39L4ekn7g4LfW+/0ameVHAT2be7KYYn4g
	HozsfTvIpzJ+EGQffP90dF/2Myeq7+R6Fhw9gnnIyAw0Y8hC+ihRvspwiyRMhDRvoM8=
X-Gm-Gg: AR+sD10oPUfJMZDHOwl7tJhnliPPCRTQ/9i1LsRId6xLYW2WeqHD80nckJOTwpus7Kh
	BHNXfUUuJs6nf5TEOpeZJ6PUmoPvggAKm/G3CUG2R09AhqoeOk7r7W9kSjXIvBfddbyC3OhroHh
	Ls5WVlcDFoxG1Bph79yWm42Elt9PW+QShiMBwHNfdCflbsJjN2179aCcxHdNVPfb16Dqv/mMD5k
	5/4zGHctAectx+m5gkwdy/w/o+cw30f0Y5hTjAk9c9PdgFTq6Ix1hFQ9LD/j5aao7OLPvNbeC28
	B4qHdFut0nrILBVyp69UtqNqz96+mMmAUaOSNyJNPgOnfmysQKUhHq2gAhjisRSuZT8R6WT/QAl
	a6a03WwYbHpJcvsjKENOUe8e3y+zrO/K2uYrm0XPhHVI137D6q7PHH0LPCd6D+V/C5ujO49Pu1w
	f35jxzsoNSD9sBUJ4PquNNQx0IvPgZqXq/YhmrDLsFB/LErlMaBd8r8Y9L/uiLNKwPAazEz0n8C
	TwO+FfFpt5q6xDo5lNx6fnPRnf+yoaN4UPYSmQ=
X-Received: by 2002:a05:6820:991:b0:6ae:46cd:e8fd with SMTP id 006d021491bc7-6ae46cdea66mr8564071eaf.21.1785684104915;
        Sun, 02 Aug 2026 08:21:44 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:5487:2b6e:1057:d3d3? ([2600:8803:e7e4:500:5487:2b6e:1057:d3d3])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-458f60650c2sm6608256fac.2.2026.08.02.08.21.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Aug 2026 08:21:43 -0700 (PDT)
Message-ID: <89176b25-bcf6-4d44-94b3-7a29abec7b10@baylibre.com>
Date: Sun, 2 Aug 2026 10:21:41 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] iio: health: max30102: fix NULL dereference in
 interrupt handler
To: Jonathan Cameron <jic23@kernel.org>
Cc: Marco Chen <marcochen.dev@gmail.com>, nuno.sa@analog.com,
 andy@kernel.org, pmeerw@pmeerw.net, matt@ranostay.sg,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
References: <20260731184124.112124-1-marcochen.dev@gmail.com>
 <aca9bdb5-f068-491f-a651-d24a80a2786e@baylibre.com>
 <20260802031035.6eb2be14@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260802031035.6eb2be14@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/1/26 9:10 PM, Jonathan Cameron wrote:
> On Sat, 1 Aug 2026 10:18:42 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> On 7/31/26 1:41 PM, Marco Chen wrote:
>>> The interrupt is requested in max30102_probe() and stays enabled  
>>
>> I've always wondered why most IIO drivers seem to do this. It seems to
>> me that requesting the irq with IRQF_NO_AUTOEN and only enabling it
>> when everything is set up for reading data would avoid spurious interrupts
>> like this.
> 
> It teaches discipline.  More serious from what I recall the no autoen thing
> used to be done via a racey bit of trying to turn it off as fast as you can.
> 
> Most of the time we should be able to write drivers that don't need to
> use that flag and don't touch enable_irq() at all.
> 
> Obviously that's not always true.
> 

Hmm... so I should go back and change [1] since it isn't strictly
required there?

[1]: https://lore.kernel.org/linux-iio/20260731-iio-adc-ti-ads112c14-continuous-mode-v2-1-eb13da38e8fc@baylibre.com/


