Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F894195C9
	for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2026 16:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786379486; cv=none; b=bXx2a2dMl61XKQKCWMGI8Li/A3VXqyNfXwRS1DK12EXPUVOWzw0Wm4fP27P3wIr+p3Eg6SlfCydplrg8LaFKLGj6/eb0D95PHnLr86ofUw15rdSOKcLc2Lx0NufzyeH1+uqbj4qqpiWnck5Fx7iugs1w/zc6cKsl56oonPb5U28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786379486; c=relaxed/simple;
	bh=m3C7XInPLOUD6JvFRKXJX7cSBpYecZrWd2US7RhDPtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QOjSZ9ZY62qCqmVh4fLf4tJIPJTfx0LXCGWeI0CtXRQCUPUL3OemEQbkQQxSiURUFVYpDv/sqbHaeVi7VeSYNg0oH5sf+eLQoOTEqmKEaS+WZXLPcIFXvXmm1E6pbRD5MybXNmyjYueIkk30XQTbY4rCWREezeu2StdpDCFqfyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=fDMrOHHk; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="fDMrOHHk"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6acc15016f1so1194761eaf.3
        for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2026 09:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786379483; x=1786984283; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mYGxVmCUHr4pstwMWmIdi+L9AxMi3Q4nuvjSCNXWKtA=;
        b=fDMrOHHkKtzgBqZ/tqifO6bvf/NgSP/XkUf4XTieKAiikCM6AP2qj7kk8bY5ZyXtkI
         0dRbag4Xhdei3VmxmukOIuJVsd8tl/5v8Sn2j2PeHs7uFimkkrKt2DswDqXZfCmvMBbx
         D9wEBgNHTs9tLST4LLAHXiGiuxNKE2qMDYGzqYEaYVf+Ld9XisXCiT0v9aXrNR+8p1hY
         SDMc7BGfH3ywv5hR1I2a2ox5wjPCfZqkks40h7EmeBNPsgfQscRFLFHBUJc2NC7KhehP
         adPeWd/xJzXw8OpeLwhfv6GGxchCsU0QUpUYS1l7LTlCko8AowDIjNMC/LFKU5fZe8K7
         9PRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786379483; x=1786984283;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mYGxVmCUHr4pstwMWmIdi+L9AxMi3Q4nuvjSCNXWKtA=;
        b=j6Zxsfjuayl+0GagVoQo4zmsLBmv9hxBC1qBGJMvsQRfY4sjKCKzTmzOYWJckE+JwX
         SC/fuDsndgPVnoqhuvyZqVnNfHlmH4JehPGZ2dHgUoSYPpBZvJSxW3n3kYxUD7UaNizp
         OatJLMGB0+OaCtxWytbGgtdx4LoMiH58/yzjRtXcnwUyMLk2ja8CzErTb2vez6I2nUpq
         sSu7AZxcV+cQWsq1xjBC+BeYmp8K6i7bepvj/wF0H0O1IY9aVvsjuT0/b2qRCAon/UFV
         5l44ltka8MVEbo8KcwBynkLkSroJczGc8+kKXsYvSIEANZ19rUnpeTGftxMDC3N4Rs+7
         eDqA==
X-Forwarded-Encrypted: i=1; AHgh+Rqg77LUoQU0a3LS58dOaKmAXxZs1bRWfgEjXt+eK0hMlK0K4hQZODP5BIVG6Jp8rmjaTnBI/uib2DI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwy4+nY3gwyiSVrRqOhUiHxJPCPJC8G2VOIIY8dVO0HCsO62gt
	cX+tkShQpLkMGtbZl0kQRdbs07O6bCX9szW+otyuLWyCVdqHnW8IuoNjwhB3rR1xMmQ=
X-Gm-Gg: AR+sD10gw5u09d27ZxX/bHakcW2nhzvWK8fTyQlQbvEMvEaFPAl1wQ8V4QWtpDfjP2D
	+5iDeH1njWTkzbjTjCfBR2SCsia3YqIIDtMtzO10ZRuOBXlcytG2h5iW2N32doMTwe/4s9Vu0gl
	po0wmS4nImXqtuI7gLilZ+NKAS3w4Fz1Ccg9pgA8EOSTejdwfMAeYfzQ6DKBuqSdgXnVvAurQcw
	/tSeU61ekYhwJ4al9cu9HgR3C2Zx2gMuSIWSXS/mO/GSViIWhrCs2uMs/16rlLAZA/E79gtxb1y
	KLMI1AeoZuCy6xJpAvdFbsTp4+9kiOLNcInVnMCDI7Zgq7Pu1AjlaOw2X4iV6qyicEJDKNDq3CO
	7gWvDmVshSDq3CyU9bBfuQNNNx3U5P56rGDVF4V6Cilsh3fIUy0Y2aLPLTGb75s6aWw3WG7s5Kr
	/t0GJu4WszzlkmNGbPwttOskLBBLLcNGWWZEPgUnAc9Wmo609UqFXb5WNn0AjDJMKKPiZ/G7s2i
	jsrekmyxlzzUYOqoGnIRIiQKwenf1aKNFc0jOs=
X-Received: by 2002:a05:6820:80c8:b0:6ae:46cd:e908 with SMTP id 006d021491bc7-6b09078b3ccmr1499580eaf.17.1786379482614;
        Mon, 10 Aug 2026 09:31:22 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:e05b:7923:cf50:e4cf? ([2600:8803:e7e4:500:e05b:7923:cf50:e4cf])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b056cad736sm5390430eaf.0.2026.08.10.09.31.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 09:31:22 -0700 (PDT)
Message-ID: <f3ea3859-aff1-4c15-9302-095119faec78@baylibre.com>
Date: Mon, 10 Aug 2026 11:31:21 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/9] iio: adc: ti-ads1262: support triggered buffer
 sampling
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
References: <20260807-ads126x-v3-0-f89925d72792@gmail.com>
 <20260807-ads126x-v3-7-f89925d72792@gmail.com>
 <1b6b6981-1a08-42a2-a03a-4366b980da13@baylibre.com>
 <DKK9S36LB543.2T124NE3TNETN@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <DKK9S36LB543.2T124NE3TNETN@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/9/26 3:28 AM, Kurt Borja wrote:
> On Sat Aug 8, 2026 at 1:39 PM -05, David Lechner wrote:
>> On 8/7/26 10:58 PM, Kurt Borja wrote:
>>> Add triggered buffer support and a data-ready (DRDY) hardware trigger.
>>>

...

>>
>>> +	u8 tx[11] __aligned(IIO_DMA_MINALIGN);
>>> +	u8 rx[11] __aligned(IIO_DMA_MINALIGN);
>>
>> don't need second one to be aligned, they aren't independent.
> 
> Ah, I forgot this observation in the last version. These are used in a
> full-duplex transfer, wouldn't that require for both to be on its own
> cache line? I just started learning about DMA.

No. In this case, it works roughly like this...

- We fill the TX buffer before the transfer. (CPU access to memory may
  just live in the cache at this point and not actually be sent to RAM)
- We request to start the SPI transfer.
- The core SPI code flushes (or maybe I should say invalidates) the cache
  on the TX buffer. This ensures that what we wrote with the CPU available
  to DMA.
- The actual SPI transfer happens that uses DMA to access both TX and
  RX buffers. (Again, could just live in a cache and not be sent to RAM)
- The SPI core code flushes the cache on the RX buffer. This ensures
  that when the CPU reads the memory, it will see what the DMA just
  wrote.

Since there isn't a time when CPU and DMA both write to the cache line
at the same time before a flush, there is never a time we could have
an issue with stale data replacing data that had not been flushed.

It does mean that we can't update the tx buffer for the next message
until after this message is done, but we have to do that anyway.

What does cause problems is if we just had a regular unrelated variable
after this in the cache line and the driver updated it during a SPI
transfer. If this new value was just living in the CPU cache, then
when the RX flush happened, it would write over that new value with
stale data from the DMA's version of the cache.


> 
> [...]
> 
>>> +static int ads1262_enable_and_read_last(struct ads1262 *st,
>>> +					const struct iio_chan_spec *spec,
>>> +					__be32 *val)
>>> +{
>>> +	struct ads1262_channel *chan;
>>> +	int ret;
>>> +
>>> +	lockdep_assert_held(&st->xfer_lock);
>>
>> What happens if something else (e.g. gpio in the future) decides to do a
>> register write here. If it wins the race, will it unintentionally read the
>> data? So do we also need to read the stored data via command here too?
> 
> On each trigger, we are holding the lock before we enable the first
> channel, until after we read the final conversion. So we don't really
> care if there's concurrent activity in-between triggers. Am I missing
> something?
> 
The datasheet doesn't seem clear on it, so I don't know if you are
missing something or not, that is why I asked. :-)

It looks to me like the way this is working is that that when data
is ready, on the very next SPI transfer, the data is placed in the
RX buffer no matter what is in the TX buffer. So I was imagining that
if we got a DRDY interrupt, but someone happened to set a gpio output
at the same time and the gpio request won the race for the lock, then
when the gpio request was made, it would receive the RX data and trigger
the next conversion while setting the gpio output, then then what was
supposed to be receiving the data would receive I don't know what.


