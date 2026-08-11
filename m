Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CA5367B95
	for <linux-iio@vger.kernel.org>; Tue, 11 Aug 2026 18:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786471617; cv=none; b=H8LvPlfVCG0rcLV0vs1ywCux0sZH77sjuWX6fQaowoxBKKWQJuT9BCdjemSdtun6MSkdtXlpK5j//akZfCXCNOYVyQnvK9nIZOzyUxpbBdcQiOvV3q6vjZg0Q+BW5xOb9av08tWlaqWSTkkKs60FgXWBXA5+o/0/1xojWcnWoU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786471617; c=relaxed/simple;
	bh=h/kU+0khOs2mbueaGLEuF1Wzrn64yqgGdJQhL77jvF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ncz8A4/AB3YbdgaT5cxQj5a85YLZExa6CG0YOedmWH1E/dRJiCpVGFoekCVHWS5l+1jyd+zUdVLRKKuXDTa1UGt201Wjckw6y4uz+zLeKP1Ad/xygEG3ZqDBHTSWEy9nC6Sd1Sa2V9q9YSypCnzhaPh2M8F4k2bBZmSmIMYrEgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=G2wIi+yn; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="G2wIi+yn"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6ae9b721927so119379eaf.0
        for <linux-iio@vger.kernel.org>; Tue, 11 Aug 2026 11:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786471612; x=1787076412; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bPLjvPRzdcvXjvZulrX1VDW95Qi2CQ4uYFgXPT7AZFI=;
        b=G2wIi+yn99UljNCOa5CWxhG6GV0TBam8grJ9vflP1hwBpbSbKnNOXSypssCIg6Wqeh
         w/cYFxo1XpbCVQQHZn3qtAqcM4l1DjmwQ/cpQMw/xj8VSDZG8kpqjwtBuDilAExPHNfV
         pObqE6G428i6JUQWHL+8q5WPLMUDtT6VdD42tZRolbeikdllotNU5IPeKdlGcB1mOGfy
         ttxzrje2zeHmA1WTrDyt33rswiaFWCTNPvhHndJKgQdhc+X5l5cj1PcF4UjYFuBs9uBT
         CktAPodfzjaos5mQjCEosYNFYyK1xNGhzZ3H3lQijtCYRw73BIzleWTirfhZlmDwCUcX
         fzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786471612; x=1787076412;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bPLjvPRzdcvXjvZulrX1VDW95Qi2CQ4uYFgXPT7AZFI=;
        b=Bf86D0AU65qmzP2cN8HQPgMAkoabXDpLkk4sAI3m5jZLVEQixi6d8VgDQdpFHsEpNn
         A0RLEVLYG1hZVLShGYWw02OTtOLV4fx2cmLp/HFKgFDv+cm6LDoQxc9XIjJWL8frCrek
         LWzUMYGwWri8n5KjtkC9GujzjyYv+UyPbQvCMVMyHmbIDcK4EDbIskgcOSd+LpOjr4Mb
         x/XCID3S2zhZuqU00EHTU7znwGI5dGSNPaCNUQzQXjuISohoaWGVx6XiXLFTxQKxQsc4
         TG8KmavZMjIK0bCoIirIR0TP/RshFu7loB7jXH+qWGdQXTNKRFS+6LEC0XbNcV2OA/7c
         XDCg==
X-Forwarded-Encrypted: i=1; AHgh+RoaC9RVKuKnx01OQ+Ba6dwWJ1TcqStPZnzTxd+PW+X5lo6f7mIJhbDX/kATiCyQw+640BQ4CGvgcyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8y5sOTIzYhAq1dsqUStuvbEKuBAagOsniBx8Ie5+abJDAM8Ae
	rm4Sp2GQpZrF5dVuF8uRXjfu01ViSVaAMBrC3fhluAYSto8NCgxyztY93TqB3CwPMEo=
X-Gm-Gg: AR+sD10s974VoF/vRDsWpK1a49S5FJfqL+Jv2Qz/9S2AvQUMCG63PKnhQglCtF2hVzb
	VmnnXjpvr64rY8iqsCeQIt2FB7g1UolfOqnn/J5PhrxeXiE8LUN2dbK+yzaUeAt7P8clPuRjHft
	i30K4sesK7iwI66gxlxHu40TESCtUHV1m6UQhs194EDfxHlrkMcuz4Xv457tJVt9NVkDkeePVWG
	akOI3vm5t4y13JL6TZt33fejiACVKoqE6TiMfCOh29knK8BjblgdkZZ8OwYzlMAbVJhhkUgLC4e
	hneBK+ceuTR6yXvvgUqQRedL0FCRh5G91Tqna0a/7wCyH6yVMucxFV8pYDsuXv6yW6r3prtJ9Sb
	X/BgwF7FFCfrNUxqc/IjSrZhjEEubxfnJxthfbIre9p7iWdQCsLqrM3UW9e9/NSX8nAJDVwBnO+
	HjOeHKCP+9/9wdLwO+SEXC9ZW9jO/SnNEg8ShSTyXJOUSjXMoAqzA1AaGcf2Q6VX6osOdjdKCQY
	px+6u9IjYFzSLcyqysD7XQf4PEZ9ejPLf5b
X-Received: by 2002:a05:6820:560f:b0:6b0:abaa:bd3 with SMTP id 006d021491bc7-6b0abaa0e22mr1275805eaf.9.1786471611847;
        Tue, 11 Aug 2026 11:06:51 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:7060:91df:60e9:76b? ([2600:8803:e7e4:500:7060:91df:60e9:76b])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b0ad500d37sm382701eaf.7.2026.08.11.11.06.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 11:06:51 -0700 (PDT)
Message-ID: <125ac6a1-a089-4ce8-9b20-c3448b6b5208@baylibre.com>
Date: Tue, 11 Aug 2026 13:06:50 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: humidity: am2315: add am2320 to i2c_device_id
 table
To: =?UTF-8?Q?Nicol=C3=A1s_Antinori?= <nico.antinori.7@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Brigham Campbell <me@brighamcampbell.com>,
 Jori Koolstra <jkoolstra@xs4all.nl>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
References: <20260810183337.451812-1-nico.antinori.7@gmail.com>
 <anqKwJOkl_cxzCT6@debian-BULLSEYE-live-builder-AMD64>
 <anrRkty6ugdJUGmE@ashevche-desk.local> <DKM7MV8J10HS.2OIM1TDHB9VHQ@gmail.com>
 <2d7dcced-47f9-4fcf-9668-30acb9e8c9b1@baylibre.com>
 <DKMB5HGIEQCW.3EKGVS7GLRBOF@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <DKMB5HGIEQCW.3EKGVS7GLRBOF@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/11/26 12:58 PM, Nicolás Antinori wrote:
> On Tue Aug 11, 2026 at 12:49 PM -03, David Lechner wrote:
>> On 8/11/26 10:12 AM, Nicolás Antinori wrote:
>>> On Mon Aug 10, 2026 at 4:28 PM -03, David Lechner wrote:
>>>> On 8/10/26 1:32 PM, Nicolás Antinori wrote:
>>>>> The AM2320 is fully compatible with the AM2315 sensor in terms of I2C
>>>>> communication protocol and measurement conversions.
>>>>>
>>>>> Add the "am2320" entry to the i2c_device_id table.
>>>>
>>>> Interesting. No devicetree bindings for this one? What kind of
>>>> system is it on?
>>>>
>>>
>>> I am testing this on a Raspberry Pi 3b mounted on a protoboard.
>>
>> How do you tell the RPi to bind the driver?
>>
>> Since Raspberry Pi is ARM-based, usually we would use devicetree
>> overlay to do this, which would mean that we should write a
>> dt-bindings .yaml file for these chips.
> 
> I do it manually.
> 
> I use that RPi for development, at the moment the kernel I am using is 
> 7.2.0-rc6-v8+ with CONFIG_AM2315=m. When I need to use the AM2320 I
> modprobe it with:
> 
> $ sudo modprobe am2315
> 
> And then 
> 
> $ sudo bash -c "echo am2315 0x5c > /sys/bus/i2c/devices/i2c-1/new_device"
> 
> (With the modifications I made ... echo am2320 ... works as well)
> The pins for i2c I am using are GPIO 2 (SDA) and GPIO 3 (SCL).
> 
> If a dt-binding yaml is needed I can send another patch with it!
> 
> 

Yes please. It will make it easier for others to use as well.

