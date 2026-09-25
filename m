Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3C3472076
	for <linux-iio@vger.kernel.org>; Fri, 25 Sep 2026 08:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790323962; cv=none; b=M3Nnf4Huy/n3RBfRkaz/usaB82b+qjTrzOBEPfCxgYmbjxL0+k+RUCPy4nabzO+HUoEdd5gE1CwQNvVDB6jYicgmsjfXA1Ry0ynBYP19SwenhXsJuYNr48//1kzds04493wHeq9Ib9e/6iRsrcj3IPwtpQ8DHbvPSdHhFnOvS08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790323962; c=relaxed/simple;
	bh=F0pWMUz53o74VHfGDjLqFGkToYkSgo8+QZV8EalfPAU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kHP1kiEjKkptCstkpFX2RbwmRQE1GHXzecPyZs89Wpcx4V9+iojj7HpiFcRtfl6HDURTlL0f2Q68+wW+0KVi2YrDVmWQGfisDcf/X/ccCFr83Fk/bdvp4/aEGmfl/jtUIkgkSyrf76g0YMRItok8OhMUIKPnE4mC/7pf3PtECjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JZbW5VH9; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JZbW5VH9"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7d2bb404so2028925e9.1
        for <linux-iio@vger.kernel.org>; Fri, 25 Sep 2026 01:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790323954; x=1790928754; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ATk7xMKP08uK1zoQuR5gtkcggdAXygth+dWq3sg9U0A=;
        b=JZbW5VH95n8qS3OkappBNq64+Ev7wUSqzSPSwBCms3Qr83bacL9P4vyE4YUw3EQ8EP
         evlPc+1LWZgVQ6V7Ee1cBu/fJflSSWjIKofKLjC9CP/2UN3RMwBMBDVO3dHGu7iOyBp2
         ToeqO2ymtyWx//g9lHVJipsc18RqoJsEpdOpiDCtnp3/c5UXT2InBLpFgSzdETE1vH+n
         4Cp2SOvBRTUKT8r2W3nliVRDkgDN4g02oiE6x240IENIine6tA0GroZIkwGuh8CJbxqG
         rwtRKAtKQ1XrYd4z1lUVtwK3k5o/prKa9kXjHTUEbGAnjog00FZ3qlcFEa9buskNJTPM
         2JaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790323954; x=1790928754;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ATk7xMKP08uK1zoQuR5gtkcggdAXygth+dWq3sg9U0A=;
        b=jLREhOb10KIep9wF+EhWyPbHKQT1Fnze70ILOCMcnXKrV2nhvFLdc135nWmpEIsusa
         BLFgodkw/0fNtU/JowsGR31VzI93ulpzUwjz4fAJlWtU6iln1GboKwItb6xzLiqIZuK2
         0aCCmUwttXpXV9LgpN+Xxg9kMoMjbHJs+ZBBjAELddUk+Ye5TxJ0bb9CYCc5bylMb0Ud
         kwvSBUfab57TDNjXQKkcOPhZ60Y66FadgVnery0gYDV2oqGnw5U459LlTtirEXlvwWoH
         gVcuEL8Q/Ek8liK4l7IFLN38SYcvnXl9jhodCFWq4madxbX4m6ZLLViZgf8BtFWp0VAl
         msog==
X-Forwarded-Encrypted: i=1; AKwUvBy6e0NfKNSi3+uyI1HGPWHf71Hc5IFueAsbognookGln7CsjtisxgV1/cYmW55uPzXK820Z1X0lssE=@vger.kernel.org
X-Gm-Message-State: AFuF++kvtJ46J+J3xr/Mv/a33ovyNs34aG6HtOxzabvedOnd4Z85g61W
	ASanbDnvhaTSTMFtvIB/p3EP1vSRUhkGfiBk8//+vbwo64KIc5JzCEea2zODuZWgy9Q=
X-Gm-Gg: AYBFou2kUJVC63hZRrP+4vQII5EmpCRyeTAO2CooiygUmFs8bivEuQ+puY7s20XCl8q
	PX3+dFKdosrZGYaqpSM6vcC4khgfiJUM03y7Iqi9Xy/Af6S4IhboimSjR/HbkC+HH9kVCK7Itop
	84OfzOxACAxx2OEfpHhwQiAAR/Squ0VXreeHDG8KXOu8nmwlOm5NxTO4jzKk9O+lvfgxIuFMDG3
	HO3J0WX94trIVfeCA5m75hslDgVRY5z5P9G6h2wBykvJ7RTW8gQys2EtSaysLnU6i4xZ0TW4Mtc
	Mlb0E/OXyitV8uph0ogU/ya2cCxavz/oVG87ZCZYmImoUXNVUwblq6KO8LmMp04S1poNm3G5hhU
	evbW7bOqqAv57d+YWDiUY7ip39BYvDrvWu9uzl9k8U8O/4ujnMyqrIYdTbaz8f1Z0f6LW3VeXP3
	30torvCRO9z5pHxpivAS6V6niNmC8Vbtj0F0Mq2RM+LhZWd5DYy76ymadyrHW4Ffd4LEoD83g32
	2DhmkPpGY/8OTQ0+rcBSwmOYqO6HT31AYMFhDundP0WmSXa0D+Arg==
X-Received: by 2002:a05:600c:1f83:b0:49b:8f5e:51fb with SMTP id 5b1f17b1804b1-49fe66c8087mr84370395e9.3.1790323953453;
        Fri, 25 Sep 2026 01:12:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:3151:fc9b:d41c:770b? ([2a01:e0a:106d:1080:3151:fc9b:d41c:770b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fee915f3dsm45286775e9.1.2026.09.25.01.12.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2026 01:12:32 -0700 (PDT)
Message-ID: <9be6cfd1-5cb6-4437-b253-1590292b8cbf@linaro.org>
Date: Fri, 25 Sep 2026 10:12:32 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 0/2] iio: adc: add support for the MAX34417
 Four-Channel High Dynamic Range Power Accumulator
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260924-topic-sm8x50-iio-max34417-adc-v2-0-9a0609e72f5c@linaro.org>
 <20260925041325.0efac345@jic23-hlaptop>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20260925041325.0efac345@jic23-hlaptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 9/25/26 05:13, Jonathan Cameron wrote:
> On Thu, 24 Sep 2026 15:14:14 +0200
> Neil Armstrong <neil.armstrong@linaro.org> wrote:
> 
>> The MAX34417 is a specialized current and voltage monitor used to determine
>> power consumption of portable systems. The driver support getting the channel
>> voltage and accumulated average power over an I2C/SMBUS serial interface.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> 
> Hi Neil,
> 
> As pointed out too fast for a v2.  You aren't new upstream so
> that shouldn't come as a surprise!

Yeah sorry, but with the initial feedback v1 was far form beeing
acceptable, will adjust timings for next versions.

> 
> Secondly for devices that are all about monitoring power supplies
> etc we always ask for a clear statement of why IIO rather than
> hwmon + to CC at least the maintainer and often the hwmon list.

Sure, thanks for the suggestion.

> 
> There are various valid reasons for that choice, but it is good
> if they are clearly stated for discussion.

I don't honestly have an strong opinion on that, for me IIO offers
much more options to retrieve data from the sensor and adding the
complex feature offered. The IIO triggers for example would
perfectly match with the bulk readout we coulnd't implement with
the hwmon API.

Thanks,
Neil

> 
> Thanks,
> 
> Jonathan
> 
>> ---
>> Changes in v2:
>> - switch to shunt-resistor-micro-ohms no more required
>> - removed gpio.h from example
>> - Fixed max34417->MAX34417 in Kconfig and comments
>> - Added missing includes and remove unneeded
>> - Fixed typos in comments
>> - Switched to fsleep()
>> - Better aligned max34417_read_power declararation
>> - Handled 0 acc_count
>> - Switched to GENMASK_ULL() for 32bits systems
>> - Added missing empty lines
>> - Moved the input correction into a helper
>> - Set default input correction for all channels
>> - Switched to dev_err_probe() to return from probe
>> - Switched to device_for_each_child_node_scoped()
>> - Handled invalid shunt-resistor-micro-ohms value
>> - Link to v1: https://patch.msgid.link/20260923-topic-sm8x50-iio-max34417-adc-v1-0-41d4ba1bfc41@linaro.org
>>
>> ---
>> Neil Armstrong (2):
>>        dt-bindings: iio: add: document the MAX34417 Four-Channel High Dynamic Range Power Accumulator
>>        iio: adc: add driver for the MAX34417 Four-Channel High Dynamic Range Power Accumulator
>>
>>   .../bindings/iio/adc/maxim,max34417.yaml           | 100 ++++++
>>   drivers/iio/adc/Kconfig                            |  11 +
>>   drivers/iio/adc/Makefile                           |   1 +
>>   drivers/iio/adc/max34417.c                         | 374 +++++++++++++++++++++
>>   4 files changed, 486 insertions(+)
>> ---
>> base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
>> change-id: 20260923-topic-sm8x50-iio-max34417-adc-209e880533fb
>>
>> Best regards,
>> --
>> Neil Armstrong <neil.armstrong@linaro.org>
>>
> 

