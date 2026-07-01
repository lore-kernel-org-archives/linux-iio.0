Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6151F3C1400
	for <linux-iio@vger.kernel.org>; Wed,  1 Jul 2026 22:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782943638; cv=none; b=lVMfwuAE3qxx68mKaCRE1TmP4TweuSyBpu2BC/WTcRMyTtbWTcFcM2J9coQTwf/KpBecmX9eGGUS2Abp7I+xsfzx1X13THWRwpllC85XJtYFIxxkCLXqqKYY825qxo0ljL7GxzjzW7eQyYpXbdgHxOKUAPt/gS09ofOrwtDMkR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782943638; c=relaxed/simple;
	bh=CrpNqwYFbROwfChNL5ll5/GzTfwpskYniMG1vJ5UhFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y9vmsJv4CfdrpBtdl40CPfhFk0C9qh3d4tm9m4H7YUeyz3ZdRwulAkQjLb/YyhT4+fodtdh3cZDYUIt2xaTWdGr0S5gF2hV4gWNC8l8ABCM1hhAAZ8HMzNmLgjvq4b1S3nwvskPfNzljHyuCxyZlaYghrcg4D9JMEI3enJbKQlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=hfz12u1j; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="hfz12u1j"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6a3110f349bso158687eaf.0
        for <linux-iio@vger.kernel.org>; Wed, 01 Jul 2026 15:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782943631; x=1783548431; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0W+YFg7WrnuWDqmzXv1zo2hy7v44Z4ropHEq/o61SnE=;
        b=hfz12u1juqOIDNEohMBR75n7rMtD5+8ucC7+it9EHFDQLv+DkAERe/OkS64X77GYs5
         kHJ2kg5WmlPCg7LwsblYah6y/MiCGSR0clVllfKP7YRXg74I/71HxLjIrH/9+hiQDq2X
         F5I6zYcMNjYE71gQUqT70CLMdodxZ9QuahduMOLJrwtfgEwnJ7D0K2gjWehSZltKEnMw
         XQhcBQ55cd+xwQrz8kwyzV3TuvjxZ8h011O4q+hBd0teM9Si+tqXVHUGu/edahS7n82x
         sE64ygSNvnEdoRC8Sm65HRaa1f+FF4H7qDn7T2cyE8vWHiw5ehHuz9F/HzIOhk3YVLet
         4iPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782943631; x=1783548431;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0W+YFg7WrnuWDqmzXv1zo2hy7v44Z4ropHEq/o61SnE=;
        b=aaGSl6RhL+rFHp1LOtvT6bApXj0fCQmfoNoRcNgNEWxjNVKTNIcL32p3ZgUcFXlyAO
         wzTZcwmI7UfbLo6WX9T4vVJ6mvTLi30ApcecW3AqpyXGwX67qKXCHPdt9VvFGkkm7TM2
         UovZ/dBV+VvFefiz1xfx0IvE18+GF2twykBPVIaF2Y8COsEt0x5OuwVMYorF03xp86OC
         owuQbpSzTLihnNeG42yNREDdDPb63Fg4/R3Gm1YA+VRAlALW+L9+n4h6VRobaO+6pTaf
         8L/T5929Jigv4TCQfgby+BPM5FQrr48zIuqUD0eMvKXYbkg2YO0Gcw4WhE/sYaC5c7L/
         NGmw==
X-Forwarded-Encrypted: i=1; AFNElJ9PVd3W776UEfd+jnsF6uSu/GahtSYGdZEkWQodPh8vy2Oid3tDWPrA+FCqhSoTzmO7HL6q400ovoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YziHKE7/Xj1wA/DRE2mbtx8rb/c5Cdz3L9UvdFv8PWxkfRlXI9U
	8qJ2nQoCJO6e6FwP5cvHoMr6O4niNqs9rLYScFhLHEm1rUkFtMIFDKnOn2iXbON8ymk=
X-Gm-Gg: AfdE7cnk8y6U7ljsteE91NU0asPK4MvIXe63ln99UF5iZXWX5jjw/iiDvl/uacumo0/
	w8fN0fkdFNztHYC038tpX9K92EdD36YD60u/KsUGYwnBFBETrCszXDSRVUwrmVbScKzl41QnNxe
	BTYzUkvada5Yk4JiotMVR1+OzlXS7LRE73vqIbn7638PjFW5xWgj5YsVS8k8jaIEcuz/TpkAC0t
	9HiCBTWgfGaXg45dXRjeAKLFJyWyHn7IdWPLzRP7Erm2yU2YbBq8Qps3wzxk/JWd+D7CTLYLtg/
	qWuS1r54+zCMQb/M+vwYEgrulEbHs0BhS0u+HKLFNMj8VFG1560ij3EGxxPEpPO0oxnRtP9KGps
	DYUx2BfZ9w6KyhRzOmjMljNoIkDKu2ua64qVjHiBo4hWCOHMwjX8Ps/sNmWgEqA8/Az89HnrCUG
	q4kmUkmxsEHP3XtQYHmDWAB1mZgMCKFOJ3xQZeUZqZlYR5J3MRtYhxKTCYvS3B
X-Received: by 2002:a05:6820:810:b0:6a1:1978:59f3 with SMTP id 006d021491bc7-6a309a9a8f0mr2133372eaf.28.1782943630851;
        Wed, 01 Jul 2026 15:07:10 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:d4c1:7681:5df:9500? ([2600:8803:e7e4:500:d4c1:7681:5df:9500])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44cbe84f609sm1119946fac.1.2026.07.01.15.07.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 15:07:10 -0700 (PDT)
Message-ID: <fa7c348c-119e-429f-9806-2c76d328695b@baylibre.com>
Date: Wed, 1 Jul 2026 17:07:09 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] dt-bindings: iio: adc: Add excitation current
 sources properties
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chris Hall <c-hall@ti.com>,
 Patrick Edwards <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>,
 Nguyen Minh Tien <zizuzacker@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260625-iio-adc-ti-ads122c14-v2-0-ceb9b0b561cb@baylibre.com>
 <20260625-iio-adc-ti-ads122c14-v2-2-ceb9b0b561cb@baylibre.com>
 <20260701203932.20e688db@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260701203932.20e688db@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/1/26 2:39 PM, Jonathan Cameron wrote:
> On Thu, 25 Jun 2026 16:55:04 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> From: Kurt Borja <kuurtb@gmail.com>
>>
>> Some ADCs incorporate current sources that provide excitation current to
>> resistive temperature devices (RTDs), thermistors, diodes and other
>> resistive sensors that require constant current biasing.
>>
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
>> ---
>> v2 changes (compared to Kurt's RFC v2):
>> * Make units nanoamps instead of microamps to fit known devices.
>> * Drop bit about allowing single value for multiple channels.
>> * Add bit about semantics of the array index.
>> ---
>>  Documentation/devicetree/bindings/iio/adc/adc.yaml | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documentation/devicetree/bindings/iio/adc/adc.yaml
>> index 12800737d4fb..860601ec5334 100644
>> --- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
>> +++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
>> @@ -81,6 +81,26 @@ properties:
>>        ADCs usually allow choosing between internal reference sources or a pair
>>        of external pins.
>>  
>> +  excitation-channels:
> 
> How would this apply if a device provided excitation on pins that didn't correspond
> to channels? i.e. some extra ones.  Perhaps such a device that also supports
> configuration (rather than a static set up) would just need a different binding.
> Feels like I'm creating a corner case we may never see :)
> 
We could have e.g. a ti,current-output flag to say that this
is just a current output channel if we really needed this.
In that case, I think we would use single-channel to specify
the pin and not have excitation-channels or excitation-current-nanoamp.
But as you guessed, this not something we would expect anyone
to actually do with these chips, so we'll leave that out.

