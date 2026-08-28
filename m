Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D703BD65A
	for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2026 09:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787910390; cv=none; b=XEjGPUIYv8dHcbctuoSH3H/fcnx+UQ2iah0C6dYU9dZcxF47cRfZlrCMi7mVsPpPvfhgvSoaCdOE+la0HLMaKxskSUfcjscNFioC4L7gzZ7ItulWRczLtfoMF09hCHCB0OUiEcBBlECkJKETt1ehfzL2w0RSHjC5S4Nu84FBxd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787910390; c=relaxed/simple;
	bh=Uf6ldwilcJEaPDe7MOC/blE6zw7sKZkBqZq+x81xo3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QU2z3QqhsFfyHoKiyGHpX8VvZo+CQhkZBOH89IqNPgqMFmvbLs1NnYzyeSL0qy9MP6iu3OP0Jbcis5wlIayBzaAgaArIdNzLMfWx53plPCNs2qeCpwItttutgi8e1w6FQ37E+Vok4QMepYIzjGs0vFmFFS0dcLXmGVCtPvFniF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mj1Hdoi9; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mj1Hdoi9"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5b159850b16so796835e87.3
        for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2026 02:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787910386; x=1788515186; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XEaU4Vf2pUTQUtqKK4E9Z2UzMvc6WXT0v5g5IP0is00=;
        b=mj1Hdoi9X8IjqXSGKApdm2NHvJCopqj05VIAhzv1PxZf+3f7AQJdDrPruM6QuJAPaE
         JGWOFjE1kOXrp4Yv4Q3fnlV1YBSYdgmtYsg/EXOdzCxTfegbguiCrVjL1OMXGVKM21vf
         B0ruzYUT6MitKdGq2Xev8+2a5cBgFRWC0khLx/s6RBvoK3alt1n2GCMVI9XhISFAWLin
         xKLqKggXuwgkPVODgsw7gw47mkSWYmjN8sVJv9jcTfUmihaR8Fq6ywLaPl0f+guixsCm
         Y9CVNTO0PBpNuuKTpLd8mUoL6gMqc/HSRVaPVckGakPPV9oG18Xfr3mIyUP9QpL6aXP+
         XqWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787910386; x=1788515186;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XEaU4Vf2pUTQUtqKK4E9Z2UzMvc6WXT0v5g5IP0is00=;
        b=G2a3MH5cbMy6xEtlfdn2QiLtkyzC2Dxxusl5oEmJby/UyVkv50Jw4+0OBMh4jDmi4N
         9M7I09BwGBT/u539nKD+oO7+NqUdehR21nOdDKBgL/KeqcysEQLywVfIibhwrrqhgMWD
         k4EdIWKupCLnT13sKHQA6uo1T8Sj0HtXaK3/1Jfx+gXiF8RLV+kf2O1ttu7fW/AnOPBB
         18hbzvoOZIknEUJeIqQ8jWdBp2hMLrKKuSh5XK6vNSRdylYxOSVCrbHqrCWJKzRlq1tR
         RgHB8L09sTOi/c6kzFhrdyDQCZ8ZcivGdVvymRiTOFpV0b/lNCMm1+hLmQVqR7+wbaZR
         KRCQ==
X-Forwarded-Encrypted: i=1; AHgh+RpE0to9DnZZtv98LudC22FSENF73F8E4VPTl78XfaHFkliPll7VuMMHEPHnLirI05CZGwMf3SxDxQM=@vger.kernel.org
X-Gm-Message-State: AFuF++k94XXPHABuGcWSkGp62pTEOViSKcdY/1g1Q3ol60Fwy3ccIJYo
	KrEZKHViKztfZyQWxDgMC+1iEDAQpjwKBhC5A77tbPzn4L1tr9mNTQ+c
X-Gm-Gg: AR+sD11XcLG0Y470cGaAxBaKDsuQH7pWMJ7k1l0jRmeINDRY8f0857rSY+8vc+WULzs
	YoufCAV/ag8tifzHhYHYPPem4IqoefB8dh7TlUrz1uh3wMIE8I+oPngPm9ksbqjZJ7AlzvkuALp
	Ak9t/Fu2U+B1YgCouBFGfWQ9pGL4UK6xOjgA/sl7/nvjXFo+hnrSq5+ch3YxrSQBBpB0neSkm9x
	DeSF1/1z2fO7GCUK8U7cJfC3ShJ0EtSanCsb4DK7tzfRIMSTrbQlaezCGFvrd7enk/L/IUyU7+A
	1JtNjnD3DzWLEvC4dfnlsmsqHXayEjn4Nj6FFqIv/4c4yl+Fth0NJgNxoYOFQvvf5v06xm3KkYn
	3zKW4zVEnPjGGIiugdi4rrjtMC+Xw9aadaBHSHApToaSSiCk0EaZBTzmnDSThgj7Rz9sdX1wLh7
	DWbuPK0ZQ7QlEkhZ0fw4DFv0nzXxHE8A4DXX9IXaZulBsyE6aN1U4T8SgIs9kSgm2BSKdS0bEvI
	D9knpzbACSYW93QPEiBCtmHb17K+Xt8WGYOaAAbxxJl
X-Received: by 2002:a05:6512:400c:b0:5b0:165f:17fd with SMTP id 2adb3069b0e04-5b5e68ec97dmr1491553e87.14.1787910386137;
        Fri, 28 Aug 2026 02:46:26 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a305386b60sm1797241fa.7.2026.08.28.02.46.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2026 02:46:25 -0700 (PDT)
Message-ID: <5d274bfb-2570-4336-af16-60640550e6c9@gmail.com>
Date: Fri, 28 Aug 2026 12:46:24 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] iio: light: rohm-bu27034: Fix infinite delay on
 error
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Matti Vaittinen <matti.vaittinen@linux.dev>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Mehdi Djait <mehdi.djait.k@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1787901813.git.mazziesaccount@gmail.com>
 <7f0d8efb3578cd4f23a7c70fa4a8f7a967c9df8e.1787901813.git.mazziesaccount@gmail.com>
 <apE-gauHWlJO8-5X@ashevche-desk.local>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <apE-gauHWlJO8-5X@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/08/2026 10:53, Andy Shevchenko wrote:
> On Fri, Aug 28, 2026 at 10:40:36AM +0300, Matti Vaittinen wrote:
> 
>> When reading an integration-time fails, the code will use error code to
>> compute the sleep time.
>>
>> Fix this by using the smallest integration time as a default if
>> reading fails.
> 
> ...
> 
>>   	wait_ms = bu27034_get_int_time(data);
>> +
>> +	/*
>> +	 * If reading the integration time fails, default to the minimum so we
>> +	 * don't lose samples. This may waste CPU cycles, but as a hardening
>> +	 * against theoretical, once-in-a-blue-moon error, this should be Ok.
>> +	 */
>> +	if (wait_ms < 0)
>> +		wait_ms = BU27034_INT_TIME_US_MIN;
>> +
>>   	wait_ms /= 1000;
> 
> With the above being open coded the _ms feels not right.
> I would expect the TIME_MIN to be in MS from the start
> (and for the consistency's sake with the below) and having
> all this to be written like
> 
> 	ret = bu27034_get_int_time(data);
> 	if (ret < 0)
> 		wait_ms = _MS_MIN;
> 	else
> 		wait_ms = ret / USEC_PER_MSEC;
> 
>>   	wait_ms -= BU27034_MEAS_WAIT_PREMATURE_MS;

I don't like using 'ret' there.

At first glance, the
ret = bu27034_get_int_time(data);

looks like ret is containing just the success status. Furthermore,
 > 		wait_ms = ret / USEC_PER_MSEC;

forces one to go back and see WTF the 'ret' is (even if just couple of 
lines - but this is not an improvement, using ret is obfuscation).

I could change this to:

wait_ms = bu27034_get_int_time(data) / USEC_PER_MSEC;
if (wait_ms < BU27034_INT_TIME_MIN_MS)
                 wait_ms = BU27034_INT_TIME_MIN_MS;

(but for me this feels like unnecessary bikeshedding than anything else.)

Well, I'll change this if I respin.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
