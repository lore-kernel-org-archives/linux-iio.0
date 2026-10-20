Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792487915;
	b=SqSTOaTluWJJ3qwnmwNBdKPW2tyhCV4KdiSNJfJje5xd/YFNmcK0t6jF8ZqifOOL0rXk
	 69fPETIWLcoqNAgHUz1wbwqp74FOLMhhYkieAiZhmczOchZu8Z30sruiDKb1J16Z1rLr6
	 eSuTKwPa6qcREqh2+1P+XqNMm+wQjKqh42gdLbgSEkSSvz1WoWsGSSH90o4uAIqoHkzLS
	 8FTJ1dccGPgV2uvHCXCpTRRri308GidXaAEIgcZw+B5t2jW6epvRDxlaAquP6lY+sQUUc
	 1lancd3AK2YSwXXUyo925UwoI994NmGxf/4g4icoa3EhMDY6E1vx5pgkZ99mSzjcDPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792487915;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
	 References:Content-Language:Autocrypt:Organization:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=RXrka+trTKfbRU3hvw3qF/+2ovmjJPpFg2SNwUFDjw8=;
	b=EXLXy1YfYNYF9EQg9i34Z0C99o/r1Y1JmQqd8gNscVfEkjcETE6AOiKVxnulbd/YF9z+
	 p2afJCKh+mGADcrSpFt6nXxK+YCcx8bdRhlZm+1BWwd3wApWdMj5jRAjqxf5ouKphr2JO
	 NtNVgSRfqPeqyGNiYapAunUo2nQoYzmGwqvis2bBvbF37erMliTQjHO41RC1ydE19yZcs
	 Pi/Xh+nm4Hmw8SMYDW1kPrtmCGp46xT3pbrADTxll+2E5FlvrAIhkrYhCcz46KBOkuDOa
	 1o91v8RXvDbqkkSK7C5RrjESz4SHwkrrqASbFztaCqrDGVmQu6RAPOm8X2CpA78/5RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=eu9+PFbj;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E64606A320
	for <linux-iio@vger.kernel.org>; Tue, 20 Oct 2026 09:18:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60E64606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=eu9+PFbj
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso30676495e9.1
        for <linux-iio@vger.kernel.org>; Tue, 20 Oct 2026 02:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792487914; x=1793092714; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RXrka+trTKfbRU3hvw3qF/+2ovmjJPpFg2SNwUFDjw8=;
        b=eu9+PFbjTCo9hO/2wRz3mZ9tJtbZXaq6q7QeYQCidVMm0k9jHKrJQg1tbT2YpdOuor
         EVzBGJJg8/Z+jF5T5VUaVoJf0GJptUaec4MUZK8wzwG7CGIMa/Ty1C09xhayj053kQkc
         l/n9wm+xqMyecy8Ys3w+3IkCybOvXQEbqxy6ycr4yaa37uLTHj+LQM8UaytKcQ1ykdz6
         Pa/g+uRMv0iEHgAVy+1hAtOSrprDg8bOzee1fMVLWMm7DLuR0djspAHKLUdkCZhm3iFY
         NCXqtb+RcO2G4oAOfv0FVu9zt7VsqBxMJT83va70oYDscXxYyOA7CpVcCMMrB/V96Y/5
         XolQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792487914; x=1793092714;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RXrka+trTKfbRU3hvw3qF/+2ovmjJPpFg2SNwUFDjw8=;
        b=vlJUaBBALEjVTQ9gjJesdxp1PgHHuGt801Hjk9ygU2+FNsQBMblx3vvIbcaHos9mat
         3mJz8xRSgNeUnbFINhSfY60aRc1TriBoVuWmeSFQPVegHKc6+dHKnOOk6NfaPuRl1OBz
         DfhnU4FgtSJgwzB5XRtMtuRk28FjJHqUTmv0/Nxr8MXjRhTECy3QrUJqj9sSDPrbXJPr
         1/luixxZBMLv++HkcDpGOSx5HfxnZ/tJuA/FZ5uh84uSH0VQ4oPptjrqAN/ES8cQb6b9
         xCdygbN08UNsHL/wX33zXckea5yY3XVA8aRUC07HpsckmaZShXA31HyijfDX6caJgj/C
         tfMg==
X-Forwarded-Encrypted: i=1; AKwUvByptqYN+T76vVaoDAK6C2skrPHCEtzwuVUa6mE5FCiyzd+FojSiaNzRlf8SXbgZ32aQVJbgEszpUE4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ+srmvkPJ2CRbXu8nd3/jCDfSXLrLK7qXlCkwl1R+fslaAAnc9
	rbVgWPyzfJ4UOr1YGKHGeSBHDlEkyCcAdKYiL6i0gG02kJAzvVJ7cjkrCwpDv7YAQkk=
X-Gm-Gg: AYBFou3gwm06ROvltBs0YKbNN/IDYQwTJiZIh4diNfWBMBcchi4/ffTl/pDgDufpcJ0
	sQCG6FcrRTpDQaUBgI8nZeH5NlvMt8d1c4L066kqHqIBhE3jGtqO8Cw9Kqi4aj7kC3m9rY/LeAE
	ROK+ac0fwkLYBt78LtQtwf8kgQ2HnJn0vpLhHzIU4Um/feD84ecWv90uHm/RuTa00oFApy13XkI
	b6GkwJevixIfRWQE+x0c8hRIecwQ8zuypab6r/IYrYy4BZulGvVv76NrnbgjBEWJeSdrFABJPBj
	8pT+fwg5VtZBo1sVOFGKh3yb7s9/CvgO9dsvErmcpWUNDidvxRL17G0EAw6TAD5slwb2j8LBYvo
	SC9lVt/w3vfGubAFmn6w994Krq1eEomB8Ngq1xfTFpw608zSqdP3pycoNBqIJ6PUjey/o2YeA37
	mDdwyDe3wJtQ/HCOTokHNRJuc7wOsr5MwI18j9/LmpHmxerh74aqAkEyqOACQCDwE7CHM2rxn7Q
	MebrNeMiGe0udFdibUuU9VZfUMbVL8U6Whn3UTdqGK94PE8aVLigg==
X-Received: by 2002:a05:600c:674f:b0:4a1:8efb:c9ae with SMTP id 5b1f17b1804b1-4a1d760d2fcmr198847445e9.23.1792487912614;
        Tue, 20 Oct 2026 02:18:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:e3a1:1a65:a394:be54? ([2a01:e0a:106d:1080:e3a1:1a65:a394:be54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2ca3597sm56737215e9.2.2026.10.20.02.18.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 02:18:32 -0700 (PDT)
Message-ID: <729d7100-56b5-4826-be86-358e96be2882@linaro.org>
Date: Tue, 20 Oct 2026 11:18:31 +0200
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3 3/3] iio: adc: add driver for the MAX34417 Four-Channel
 High Dynamic Range Power Accumulator
To: David Laight <david.laight.linux@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
References: <20261013-topic-sm8x50-iio-max34417-adc-v3-0-d3604ae4a229@linaro.org>
 <20261013-topic-sm8x50-iio-max34417-adc-v3-3-d3604ae4a229@linaro.org>
 <20261020101312.47d2eaf0@pumpkin>
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
In-Reply-To: <20261020101312.47d2eaf0@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/20/26 11:13, David Laight wrote:
> On Tue, 13 Oct 2026 16:07:13 +0200
> Neil Armstrong <neil.armstrong@linaro.org> wrote:
> 
>> The MAX34417 is a specialized current and voltage monitor used to
>> determine power consumption of portable systems. The driver support
>> getting the channels voltage, average power and accumulated average
>> power and energy over an I2C/SMBUS serial interface.
>>
>> The MAX34417 datasheet only specified on how to calculate the
>> accumulated average power, but with the Sample Per Second rate
>> we can easily get accumulated Energy in mJ.
>>
>> By default the IIO driver only supports single-shot Voltage
>> and Power sensing, but the accumulation can be enabled by
>> enabling the Energy IIO channel which then enables the
>> Continuous Accumulation Mode.
>>
>> The counter is common to all channels, so when reading a single
>> channel we will copy all accumulators to registers, so in order
>> to permit reading individual channels we must accumulate the
>> other channels in the driver when Continuous Accumulation Mode
>> is enabled.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ...
>> +#define MAX34417_POWER_READ_LENGTH	8
>> +#define MAX34417_POWER_READ_OFFSET	1
> ...
>> +static int max34417_read_acc_power(struct max34417_data *max34417, unsigned int address,
>> +				   u64 *acc_power)
>> +{
>> +	u8 buf[MAX34417_POWER_READ_LENGTH];
>> +	int rc;
>> +
>> +	rc = regmap_noinc_read(max34417->regmap, address, &buf, sizeof(buf));
>> +	if (rc)
>> +		return rc;
>> +
>> +	/* Ignore byte0 */
>> +	*acc_power = get_unaligned_be56(&buf[MAX34417_POWER_READ_OFFSET]);
>> +
>> +	return 0;
>> +}
> 
> I was thinking:
> 	struct { u64 pad:8; val:56 } buf;
> then using bswap64(buf.val) >> 8 on LE.
> But why not just:
> 	u64 buf;
> and be64toh(buf) & (BITULL(56) - 1)

Right, I mean all this could work but I would like to keep using something
simpler and get_unaligned_be56 matches all this.
I don't think the need for performance is enough to use complex ways to get
the value.

Thanks,
Neil

> 
> David

