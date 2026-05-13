Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFEC48122E
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 16:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778688749; cv=none; b=nqM+ToVzZUybYcJ+nUy6rzNDoA7zJHMDfVl9S9AQgxmBYUJIA73uLMZuuCbIxHGakjvzK9mPz3/uoHqPZ7d4Du4wKURbWbGhwLU8zepZ1kyHDubSPP/2m4gYzRanYGSUslMNkSPaoXfr9HNDaZF+XcmFLClDKSLwNr3oXpXNFp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778688749; c=relaxed/simple;
	bh=Lf94+U8uB4d6shrtPK64fSV3D5WpuG9aew0bJ7m7ysA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jAuPwKuDHnu9kMe21+RG5NGVBj8rMF0R1NLjWK70LbW8/TbQ2aW/UqtG4h2Vdm1SelU/a2M8TEFLHMC/la1URzuB5r/hGOwX9I7KbHXDqcCdDvJpaU5/Alz0nTTcU6kmKR4YzGemjaasUe4J6ytNUd8RgKjI7XLb4cQN/sNaDo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8FWFoJe; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8FWFoJe"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43d77f6092eso4426110f8f.2
        for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 09:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778688747; x=1779293547; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ai6dR/bymyCWlBYI6Ti2e17lWUNYyrdNZIbrxhMJBME=;
        b=j8FWFoJeQy3kVUFweQOdgG+jhq3GxPuxV5CSbOUCvNaJkCB72i3ljiUCHNk7e3todL
         sQ2/vQ0BbSCox0NoNCVLuaUZ9eAb6aRkmV07WIfftcmrVyeUbzUwUtN+Sawm63bN0Ifo
         wfsWfTurOZrU22m7tyLx8JQmrQGRtVw0AmzSNkYzWDxbbLBaxJ7LeXnMkHUB5Ib1Gkil
         /dxrDopoJiD/amFH+hTvAqmKHcBel5m3A+rfRKxUfT9S6vzBo4JTodDJXCkxKudlsAon
         2iz3inK7NJ4Ut8bB4bD7wa1nnuHCsW+Tg7t9eyU42n2eGONDD8EnVrQA6X2KLcK2c6uj
         oyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778688747; x=1779293547;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ai6dR/bymyCWlBYI6Ti2e17lWUNYyrdNZIbrxhMJBME=;
        b=rXurKS/Yjhqpi73Nn4JSVtrKyi4/UkBSn+SCVNJFvWmOcHBE9hhmGDU+Va070XD+8e
         E11UIUuF/vx+/PoBO/1mPOVO3c55X2I3+m28Jur966UHxphaUpEdCD5uyixML2X5F6Sa
         hroK/zUxZd4tIbihxEXJ7JkTUL+HogTuYJOHSL8S+A3TZkhOQFQ2kpEyKHPzA7Tl5FIF
         G/+SP8Z+RP/cjMHu+z50J3cwlpgcvNfQ4uoceFpaNlaqlYkcOBcMqoVRt1mWaOZIhXE4
         m8T8M5ijfIgfQ9kxp5gFj14Ed2NroRrPqzgC74nRqfHsSqbCfKWnF6o7BqP0oV9SWI5t
         cpJA==
X-Forwarded-Encrypted: i=1; AFNElJ9LYhr/slxdIye5i5l9R7rLyo0PAuRlLj+uHp1OW+z8fm0c/l3tvGo5djWx+0pL5q8ZDEwgxDuNl5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNubSdwzaT4N/tRck8SvUxb0RFCheIcQf6J7hZ0OmQLDvZX9Vd
	5e7twRTMnRSd3gri4kKlyKNvNUQMBqpz070pW3I2SHYRqfyYRrGdcDHX
X-Gm-Gg: Acq92OHbBFQZWowpHGBvMFZewwn+3tUQxX3q83BpPJYoLneK2DOb9VjS82i9ZmAz0ds
	fmArKzjCxG1MA3BcgkCB7az8ajNAAKVjvG9Y3OkDTCvsP0zADWLcXIpep76kjEmUQcxZtvKI+4u
	kP1c9wwqoeeQIOw6xGAwwDybputa9KDaMJaOh51xG9OO7t82CIcTmxfbkfrL8gfhIo66Pbv6cPH
	VOemEdrrC5LXUvV92KXiWYoy+xkvrYXIBTJamtsaQocN8k0mRvPuTb3cOwL+KVT7y7G+WrTYQHH
	oVb0zVaIGz4HuUKvvJYv+VuniTuwjhDtjTThe3P5N5AM2rseNz3ZKtZoLmAwycmv+ieLDVZ4iqU
	obemRgTADTd1LhGoz2mzdleJ1ET/ypgXt3cyKxJt4AAl97Sy/bXJHFSTomL5+w7zlCrwaaVklLD
	ltXTZec8yjrHuJjVK2xEhee2Cz9ntLCw==
X-Received: by 2002:a05:6000:220c:b0:44f:f4de:a844 with SMTP id ffacd0b85a97d-45c5a392f2fmr6242310f8f.37.1778688746247;
        Wed, 13 May 2026 09:12:26 -0700 (PDT)
Received: from [192.168.37.44] ([217.61.173.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491bae13csm40293279f8f.29.2026.05.13.09.12.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 09:12:25 -0700 (PDT)
Message-ID: <36ed59a7-8af7-4458-9e90-70ea251b389e@gmail.com>
Date: Wed, 13 May 2026 18:12:25 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] iio: light: tcs3472: move standalone return to
 default case
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
References: <20260512223215.25596-1-aldocontelk@gmail.com>
 <20260512223215.25596-6-aldocontelk@gmail.com>
 <agRfMWL9BughLT2x@ashevche-desk.local>
Content-Language: en-US
From: Aldo Conte <aldocontelk@gmail.com>
In-Reply-To: <agRfMWL9BughLT2x@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/13/26 13:23, Andy Shevchenko wrote:
> On Wed, May 13, 2026 at 12:32:15AM +0200, Aldo Conte wrote:
>> Move the trailing 'return -EINVAL' statements at the end of
>> tcs3472_read_raw() and tcs3472_write_raw() into explicit default:
>> cases inside the respective switch statements.
>>
>> This removes the need for a separate return statement after the switch.
>>
>> No functional change.
> 
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> 
Hi Andy, Joshua,

Thanks for the review. Before I send v3, I want to make sure I split
the series the way you want.

My plan is to split v2 into 7 patches:

   1. sort headers (same as v2)
   2. convert locking to guard(mutex) (drop Suggested-by, clean up
      trigger_handler)
   3. replace == NULL with ! (add Suggested-by: Joshua Crofts)
   4. use devm for resource management (drop Suggested-by, remove the
      dev_info change, add devm_mutex_init)
   5. use 'dev' for dev_info() calls (new, taken out of patch 4)
   6. implement wait time and sampling_frequency (drop Suggested-by,
      fix macro style, simplify cycle_us and all the other revisions)
   7. move standalone return to default case (same as v2)

Two things I am not sure about:

   - Should patch 3 ("replace == NULL with !") really be its own patch,
     or do you prefer it inside patch 4, since that line is right next
     to devm_iio_device_alloc?

   - Is patch 5 (dev_info refactor) in the right place after the devm
     patch?


Aldo
