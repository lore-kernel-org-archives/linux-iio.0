Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4DD313272
	for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 17:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776189173; cv=none; b=e1bLl85J7oJ1i/y7vj9inHUD5iBABpcGIxfCi2QRtcapgsA/ALcKXujS1+5f9QrZGJMaw2FP3nvVXxYdtxqPyBz4mHh1Vo6i2uTBx7l3AM/y5mIegEGlxTpBGOLPZQjBidfpWcsvBokJHUr0PKbhWgTt8wAb2sUu+AvcK8SojwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776189173; c=relaxed/simple;
	bh=REjQkR+edEnkg4p0CQ7AKc+sFxZJARFL3lANqLYf4PU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hnFnZEvAwUvRF9qQ11anIzGOUSkCq2x7rmMCsWWXgQ5bVL0L4G8N+aEsUylah2bqyfl2VtFH+0rGWDhZp2Pf15dSuWqeuR4xtx/EFg9WEbZu7SSGo1xDY/Z/uUtb/JfejO/13JS3hiWEaBymk0V5YFcscxL6tzaRJa/g8MID1lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=HUxkp/i7; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="HUxkp/i7"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7dc51aa8926so1221026a34.3
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 10:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776189171; x=1776793971; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9vrhfGgTmoKRpC1hiMmRSSKFyU1STXFQ673v9mh9T58=;
        b=HUxkp/i7uQ9Xqg15KLYL85NRSc8kANCMC2Ua1ty3pfM8ab46zInb6cxYTbYQ61lOK/
         9C61N3pkWk5laCA4edVRk2W0t3Rs2nLqleJ1EGX7+fdySymSQbC5vdUXBtndu+a3EJoz
         Ke4Ejp32vGeIViKgHOmaXI7MOFY5JTEYVDtHZWVBTtyc4kPIEO+vv9/TXxDGNIcTnBNA
         YZow681mNQutjJ6dNwiDK+Jv2cCN5In6xzmPsMW5NZzo7gY30BxhD3jIowwAlg2Xe/OD
         VYiTRsEg9KQIy5D6beNbl1EL57VXmLmxETzq9FlbYZSLeeA2lZtY93tLQbuYVBTAQexf
         gX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776189171; x=1776793971;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9vrhfGgTmoKRpC1hiMmRSSKFyU1STXFQ673v9mh9T58=;
        b=QXndQ2E71oI/ql6AtpdQLNPGTx8fr7SzRIqPY2mPV+dfy9HjjbRwQHiUv/X3MNS/fg
         yPjSnMfz8Mff90nIzdXLi2T6an9F2f2T+mAIZGEuaAleSPZBEVHZQS+ih5RlkKbdJ8Z9
         tJ2R6zoOSIgCSbB7ATICZMmYppSuKFBuHNYiG8fHlQ8k0PLp5ybGWVTMZGE62lTUuMC8
         74RL81kllsBDtHcfL67946e+35FZkmt9oplMgkW3SOI1mhz37foOeguBn+i2ziiRoFza
         oMpKpkCrHkXVu0IS2Qtp1pMd4PKB4W/p+C7nbISbalszyS+UYXgPAHe1IsNqpx5nkImQ
         Hm2A==
X-Forwarded-Encrypted: i=1; AFNElJ+TK2UKgWqE+PJ+UmJ+hnkAfoB/JnehDFs5fzsyRTGekcVa6VTJx6EPDuC18w3hjXOE2uXzNyp78Zs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh8umYX0q6+PkUNf0EfTVse1UCARxx1JTv1vQoCPA68BDrjKFb
	Fc6Ap2TaKxjS3jZSfdtOY16Ia2LnobqKyWxdscgfr3ebPv3bFSz3zJGxQwY7Rtcu5/6z+ganS5S
	IjKl+
X-Gm-Gg: AeBDiev9x31RHQFLoR1cxVGzPCMLgF4vUk/s4xBDQM7NyKJk8xZUwiH9hxizbxnq2c/
	Mfe57O4qNSl+RcoDVe0uvsGRDEiROZed5wgWeSQqUtqo+etBjLDOjt8iUqdIrJPyCuL33EEtZ9G
	oljmuhHiK6u3C3e1yjIUP+ahVDBQi/zH+l4YStZy0hXhjg27F0EUXaMnMCyp69DGpzTue9dViAd
	CJtw1eZ+lJVbRay58KIpLukp6y2OIw5Xvzfuf6CIMh9J1mV+3jalOr7rAcoq594YcgSYdhER0R0
	yHzId/jAmkPYJN57JQWQOpQDO+jmieLiAPYw6OrS2bhHakEKpUMNlB9VwingLo60ZiqxJIgrNYj
	y7/X1DfnU6+Zic+lVQqmtrX2zui6zPPOK9G465F6/b0hsx2qhn0R4nWYG6/kwDnRBEUzTrZmDbR
	UdvzD9R2IHiis/7+lJOvTYW2ETTX1z6QV+RopS3wSwrDvJ8i7+dhjT9yfEdCKnKG9Coe5jlf0fv
	A==
X-Received: by 2002:a05:6830:82e1:b0:7da:557:b9aa with SMTP id 46e09a7af769-7dc27c63d59mr11159411a34.6.1776189171298;
        Tue, 14 Apr 2026 10:52:51 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:5bfd:a817:5527:c417? ([2600:8803:e7e4:500:5bfd:a817:5527:c417])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc265c2c66sm12262179a34.8.2026.04.14.10.52.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 10:52:50 -0700 (PDT)
Message-ID: <03ea65e3-4c34-4a20-b638-966abad78d7d@baylibre.com>
Date: Tue, 14 Apr 2026 12:52:49 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: ti-ads7950: use spi_optimize_message()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260411-iio-adc-ti-ads7950-spi-optimize-msg-v1-1-617766ef2e38@baylibre.com>
 <ad4OywqHDC7aYapD@ashevche-desk.local>
 <d14d23df-0fad-4b87-8e57-67241b29fc30@baylibre.com>
 <ad5ry4i6OPOS156E@ashevche-desk.local>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <ad5ry4i6OPOS156E@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/14/26 11:31 AM, Andy Shevchenko wrote:
> On Tue, Apr 14, 2026 at 08:29:29AM -0500, David Lechner wrote:
>> On 4/14/26 4:54 AM, Andy Shevchenko wrote:
>>> On Sat, Apr 11, 2026 at 05:13:33PM -0500, David Lechner wrote:
>>>> Use spi_optimize_message() to reduce CPU usage during buffered reads.
>>>>
>>>> On hardware with support for SPI_CS_WORD, this reduced the CPU usage
>>>> of the threaded interrupt by about 5%. On hardware without support, this
>>>> should reduce CPU usage even more since it won't have to split the SPI
>>>> transfers each time the interrupt handler is called.
>>>>
>>>> The update_scan_mode callback hand to be moved to the buffer preenable
>>
>> s/hand/had/
>>
>>>> callback since the SPI transfer mode can't be changed after
>>>> spi_optimize_message() has been called. (The buffer postenable callback
>>>> can't be used because it happens after the trigger is enabled, so the
>>>> SPI message needs to be optimized before that.)
>>>>
>>>> The indent of ti_ads7950_read_raw is changed since there is no longer
>>>> anything else in the struct to align with since we removed
>>>> ti_ads7950_update_scan_mode.
>>>
>>> Some of the func() are mentioned w/o parentheses and I got lost which one is
>>> which. Also callbacks usually mentioned as .callback() (with a leading dot).
>>
>> I didn't put () in the last paragraph because I was talking about the function
>> pointer, not the function. I guess I missed update_scan_mode() though.
> 
> Then probably spell it as "pointer to func()" ?
> 
>>> The second paragraph doesn't tell me clearly if there is a behaviour change
>>> from user perspective.
>>
>> It is not clear that the difference the user can notice is that there are
>> some CPU cycles freed up for other tasks?
> 
> He-he :-)
> 
> I asked more about possible behaviour changes in ABI (note, that [significant]
> delays moved around might affect ABI if some user's program times out due to
> that). But I think it's not the case here.
> 

No, I don't expect any other changes either.
