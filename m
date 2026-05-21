Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9F829D26E
	for <linux-iio@vger.kernel.org>; Thu, 21 May 2026 01:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779325411; cv=none; b=LCGWOKe/3nABJShekYiJFf8Wgp80IHRXUl10Tzz62+cmeXo9NmRynnYCU2j8uwZMf25pNrh1i/uH73X+btPhem86Whx5YbWCi5MX/Oxe8MqLwTIpZD3fEspJnIp8DiAqvZPsZ+cI0xJ9SDTnJeAdv+MEpi+4hDDCwoLEcHA/rRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779325411; c=relaxed/simple;
	bh=I1Bk0y7uh9jEUQlRg4tZ4CjR2YWjq1SMqrMc4cSuJ58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fcA5JUVM1KgZgf08xEAXGKeT5DsUw8qg6mAUIShLSD1Sq08lPA7QbXRi16TCacaDMSWbCaw2hjQq4yOgnS/lIw+sm4r+JcAFT+OWBLyaI4ICVcwSjNaAkY8wZVTFJX7rOkg1S4I/F8OZORgRWHkZZIcXjC2SXwEgcQYw3Wy9u40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=fQvDkVEM; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="fQvDkVEM"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-40974bf7781so5149742fac.0
        for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 18:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779325408; x=1779930208; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K5NSL+rhTt1O4xke8D9QIDMxAr5REVLMl3NEv7dtOAU=;
        b=fQvDkVEMqyi95CUmmtRd6fmXJGHc8gceoIleqoGRWuUKNg0eGQga7o37GDQjOtX5EW
         7qVyEQcXkNT2a1w9IVG70LS7SqutteCQ0zJpFJ6TInlL09mKIiZSuT0uRsC1sN/i8dzj
         d4Xgu3cDi+D45VR9OHdlvzxtI846p5NDJ6t0l50JMwp6oJgqUdxnNN7vm767lJ0ykblt
         Z7J0DtKDDqvA047cQsAKTHak1jbl7Ds4HgmZXBrw+geCFZ+O9IaUbQz1B55vKqyVAZXF
         qmBJol9tCgeIGwx4VQjS1CmEztgqiL8w0YvG5VAd83PruFeW5BQOEZOQ3WFzsqJweT6a
         wRdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779325408; x=1779930208;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K5NSL+rhTt1O4xke8D9QIDMxAr5REVLMl3NEv7dtOAU=;
        b=ehY4bn7egSg6xgTvwkT5OtCF3X4Wn7vlCfmWyDA9ZIIcXSEjxqbK+eQizpSJaEbpwT
         9SD4zZ9z2+G1p3K3Ivkv0kEdImnS/SCtyufcWeGuoefrDsrgPNsoDgCcTRay5QGT+OSu
         ekeAYeH4JvGg7qvO/3S1W2//zUHdEH3Yz83+oH1LyeegAyFZ8b4oeNurCMh08CnqOXfo
         uv+J2iq1KaesVArHAf5meUX/DiMm5fGGOr6UtlxHzfgiu5+DpmLkC99NcPLdy/hY4Mli
         VdBc5uxltBQDknE4QXfiyUxPaqOmVnT8SKEpCLBqYNHHyq+VKgh6Si+Rbdysew8bbnvd
         mzOQ==
X-Forwarded-Encrypted: i=1; AFNElJ80qR6lyomem/YZOwQctCofb09x4YnxZ2jYa3firR6rrQjbc+zYd1PTK1YO1a/m59cGUuVx3agW6QQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbe7kiArNzfc1c10PN9zwK5Hu71J/GWqqmrp/OY2ZLgRrugJeC
	omLdAjqMncAnkWlthQvoQezqq60BJuLJgvYxjKZIw71lK6HkSASLFhWWO6ZpxqSp+pU=
X-Gm-Gg: Acq92OGf1Cr50tjjGeooRjOzZSxSswGQIROL1QfNqQHkJIr79uyOy+cfxlV9biWg+cK
	O8eKJFOcfJ8Yh3L4zq4pIIWf6nit0zq7Vb0KEZuDBTd9xPmvp2BQPd5I4BuV+5y3RCQbmGx89Bb
	Dv1p4HvXoyDFOuUtKgXDQjGAmOiyn1AoO/urcdCRYMjnLAmi2XLmqbkKSGtmsKLpacnROW42d/h
	KwPEMVLt3ms9WehRBn6Sa+9uwB40S9r/7bxES41hqTvliq79UWRGqZHF7bZC/bnhxEL6a06GnOn
	svpqraY0EWNrAo+z/WTc+zYEEnz+CoWzUrOTV05ZICEp5Sg9X/38kGTGjAnW1JaTqowm8DUJA+/
	kk0e+co+oIC8MIKnui1OVx2LRFzHqiDOplJ1Xw4QktFYBlzr94ik5ifPcBvb7bKu92pN0afy44F
	k8h+N6ysGEzbnrjNVCJlp7QxHBX+EJZVzogQoG6t+qWvnj43REnbTefG0yf4EQysZeYMF/W8UF7
	g==
X-Received: by 2002:a05:6820:8309:b0:694:99de:9989 with SMTP id 006d021491bc7-69d6e37a176mr353611eaf.32.1779325408221;
        Wed, 20 May 2026 18:03:28 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:3658:e18d:1ce8:44cc? ([2600:8803:e7e4:500:3658:e18d:1ce8:44cc])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43a956f6b2asm11003564fac.11.2026.05.20.18.03.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 18:03:27 -0700 (PDT)
Message-ID: <bfd9d999-57cb-45fc-a7e1-369905896770@baylibre.com>
Date: Wed, 20 May 2026 20:03:26 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] iio: light: tcs3472: move standalone return to
 default case
To: Aldo Conte <aldocontelk@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, nuno.sa@analog.com,
 andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
References: <20260512223215.25596-1-aldocontelk@gmail.com>
 <20260512223215.25596-6-aldocontelk@gmail.com>
 <agRfMWL9BughLT2x@ashevche-desk.local>
 <36ed59a7-8af7-4458-9e90-70ea251b389e@gmail.com>
 <agS70Dph8-zQT-e6@ashevche-desk.local> <20260515190517.70bb0ba5@jic23-huawei>
 <1c87362a-bba8-45b8-a836-153f468815c4@gmail.com>
 <20260516132555.64e27d62@jic23-huawei>
 <7f56ee25-11ad-4dcf-87bc-a353bed3f914@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <7f56ee25-11ad-4dcf-87bc-a353bed3f914@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/20/26 12:12 PM, Aldo Conte wrote:
> On 16/05/26 14:25, Jonathan Cameron wrote:
>> On Sat, 16 May 2026 13:04:13 +0200
>> Aldo Conte <aldocontelk@gmail.com> wrote:
>>
>>> On 15/05/26 20:05, Jonathan Cameron wrote:
>>>> On Wed, 13 May 2026 20:58:40 +0300
>>>> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
>>>
>>> ...
>>>
>>>>
>>>> I would add for this that, to reduce churn it's fine to add the
>>>> struct device *dev = ... bit and use it in new devm calls. Just do the
>>>> remainder in the follow on commit.
>>>>   
>>>>>
>>>>>   
>>>>    
>>>
>>> Hi Jonathan, Andy and all!
>>>
>>> Thanks for your reviews! they’re teaching me so much!
>>> If I understand correctly, I need to wait a week before submitting version v3
>>> such that other reviewers can comment right?
>>>
>>> I’d like to take this opportunity to suggest two alternative lists of what
>>> version v3 might look like in terms of patch order:
>>>
>>> First option does not consider the "== NULL with !" patch and so:
>>> 1. iio: tcs3472: power down chip on probe failure (NEW precursor, bug fix)
>>> 2. iio: tcs3472: sort headers alphabetically (same)
>>> 3. iio: tcs3472: convert several functions to use guard(mutex)() (modified)
>>> 4. iio: tcs3472: use devm for resource management (slimmed down)
>>> 5. iio: tcs3472: use locale struct device * for remaining cases (NEW)
>>> 6. iio: tcs3472: implement wait time and sampling frequency (revised)
>>> 7. iio: tcs3472: move standalone return to default case (same as v2)
>>>
>>> Second version will consider it:
>>> 1. iio: tcs3472: power down chip on probe failure (NEW precursor, bug fix)
>>> 2. iio: tcs3472: sort headers alphabetically (same as v2)
>>> 3. iio: tcs3472: convert several functions to use guard(mutex)() (modified)
>>> 4. iio: tcs3472: replace == NULL with ! (NEW, optional)
>>> 5. iio: tcs3472: use devm for resource management (slimmed down)
>>> 6. iio: tcs3472: use locale struct device * for remaining cases (NEW)
>>> 7. iio: tcs3472: implement wait time and sampling frequency (revised)
>>> 8. iio: tcs3472: move standalone return to default case (same as v2)
>>>
>>>
>>> What do you think?
>> Either is fine but swap the last two patches.  The wait time one is
>> more complex than that trivial cleanup so might take more revisions.
>>
>> I frequently pick up the first part of series just to avoid people
>> having to keep sending the same unchanged code to the list (that I've
>> often forgotten about completely by the next version!)
>>
>> Jonathan
>>
>>>
>>>
>>> Thanks,
>>> Aldo
>>
> 
> Hi Jonathan,
> 
> I have two quick questions.
> 
> First, Uwe's "[PATCH v2 0/7] iio: Rework i2c_device_id initialisation" also touches tcs3472.c. My series modifies the same file for unrelated reasons. Should I wait for Uwe's series to land and rebase on top, or is it fine to send now and let you handle the overlap? How does it work in  case?

Just add a patch to your series that does the same change
for that one file. Then it won't matter which one gets picked
up first.

> 
> Second, the first patch in my series fixes missing power-down on probe failure (goto err_powerdown). Do I need to add the “Fixes” tag?

Sounds like it.

> 
> Thanks for your time.
> 
> Aldo Conte
> 

