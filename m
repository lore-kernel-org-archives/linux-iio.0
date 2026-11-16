Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794821674;
	b=tD9g+jlLP6LvWvQhBoqmm+0KHeHqrkvUTKG2qiffOcP2eb7L0gEUa2ZKUQ5/5cAuMSoU
	 UtvxKc8OeWuywOyvaIv8xdv62MU9+PaU6l79PitZsFYnUrJWFUDMz+ACjkUnbTuz5yCc9
	 Oz18cApIvY7ZnRY0w81+KxJiVqg9urJLe/gRp6GmPQRdPfimyWCzpFzQtpf13cah9pVPz
	 +N2wP0uEJefJBRjhcuhq2FP4Voq/3fJZLkbO8FJk8UHDJhnYlAu+U2+gOCL1upKrvGmIe
	 ZoAm2I32HsDkcUV1MjA+qYySWVJD+ymDeNBmySrhOJnWVKq+sA3dfqZtwmmDHeP4UxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794821674;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
	 References:Content-Language:Autocrypt:Organization:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=2ZrA5P0wXUVoRp2VZkO2qiNI9NmJNGtWhDtxHgxWigY=;
	b=djpFwlx9RAniFrfuyR9VvnsiJq7Z0HkzKhO66YrgCX6CgxKHqlhSKNDyWrlR3v7aSqpp
	 Wtw4I047MCtcbygzJ6mvEs2TsSKF/9g79s0Cb4dHpQi4TBCPfIzVRdhET1qLf8+SD8yoC
	 7lAfXDmxQO8qhrm/76PMl6055t7dbwz0dS9fwsAOKApsAAiVFmkSE2pIXqCtmSPtQmmDa
	 V+xdzAw1llsz+5vVkUF+oANTXl1EUQd1ICPpbUMhg9JfZdVNIIRXpaiPfz/H32u/1lJ9H
	 heS09gZtTLLMVzpmMUgC/PbI+PSWfKcDorOZn2LuISXj9RS0dmW+b+uJt+Sk7a1Lcqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=L8h8c4OA;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71204606A329
	for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 09:34:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71204606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=L8h8c4OA
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-490d59c3edaso1871746f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 01:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794821672; x=1795426472; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2ZrA5P0wXUVoRp2VZkO2qiNI9NmJNGtWhDtxHgxWigY=;
        b=L8h8c4OAG0iJGoI4SYdCQqNoB2wUCwc11dheL0EaAYY85etpc0W42XdsxcsZ/mlApV
         Bzz30yakezwte3pccClYtBUCGE3AWSUy2w4o2X+7r9EmVSfk094yNuaXOUuITyRVVoAa
         8vJtQmTBMctg2/pDeO2R163YYqEZjP/CjDd9vn28vE/4fZ0xQsWWSSEFqxG4jQOgj/38
         dguwrXdC/5py05kAcSUW0lzbimox3SC57WRpIrThthKgVeGsmyPBCgTIw/bKunHflxLN
         FoysZu2pxmTaMWtAg2fBxBNmkm0J7L2dRJ5AV/rZalDBKIBlfH5q+fzRsF19SMfTvdvQ
         YcxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794821672; x=1795426472;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2ZrA5P0wXUVoRp2VZkO2qiNI9NmJNGtWhDtxHgxWigY=;
        b=hvnD04Xr/e2keV1RQIfE3SYL9Bbmtn8wCdpJzqohYf4CCZVxid2Ds0k/dMjcNi3tTt
         Cvt1oqB0KIXGPMtGf+hfKSsHzz3QM10kPJvi2QKdMk8ZCA1gDlc5/6IN27w1ElobY3Wz
         MbX2J790nKrLioDp3EGCCCvyCK+tU/HDEHmqRpJBFwQdyyTnqBqvdL5+675XLJOYdD9n
         fd0kEHsP/e+8GzSXHL3rOPCZyl8/RAYwyZO0itY/JV+aCLgVIVI+l144zfGSHgoTtUSU
         6PetTemtVV47r6Fyh//NvTYGeGfzqkEW8U42i9YXcFWxTDQnd2xopWL/BqlsyOVv/T0i
         mjDg==
X-Forwarded-Encrypted: i=1; AL+hErGREvxvr6Q6TIqMCqLpmoS0996R7TsSV75zTxEqzjCIva2OzWY54lxhd4sZE+/uTFL+AyNu3vdIkk0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Nd+Fw2ZR88TAXOGi6jRg+qzy+Rvq00bT64zYRfsg58/aZWI0r
	q8b6DkGY/s3MiiH5kLw/L/d4D7MO53h9D9N01hdfw2BLWNm0/h65nu8hQd9f+c2YQLM=
X-Gm-Gg: AZFdTZf4ysIJUmRDr+VTixQI8rAq6hraeEmJDsyMfLDcFPO9XKF70ExHwoYFnrSNokh
	UU414fDYKbAXPN1mqkiO/owCjSf7DbjxP9hDHIxedcxJyMlbVKEYXcIeZf2zn01ODfhkroXAs8P
	ve7D2iksUz85CCbazrVPM5lrgfTd+7RG/O/ZjMgPIMHdc9P3j4Bn/G3JVW2QW4iLYEReKcUc6B7
	Rru7oHWKpXNfTPE7kUIwag/Zj0t4BOGSBFkYWx/BwffhrOFF/h6k8oS/vvqtKnX4u6lB8sb19ox
	L41YYZKSMF7JdHOPlH2PMhUwZNk7BLZpWZBgeU5L6H04x+mrBfFfxWpG1MPcYXLQjVpDwodfuNb
	yuSrO8Z3EHxrCqFDGewTq0joiHYcEXoNL4VJA2uQvocbPRaSsu5jQrejfSKg8idjMMi8fyqfO7u
	FdxNdWr1qHgqaZN5/nGurYZuPZ4V+2offxbByyufcyvDKJXz0GC159p7NrMEzqh3HVKEoQdxAzU
	USLRcJDu9LA2Rmk1+E1E94yBpJKw31QSauoi3cuidUVq6vlafhBOPxxRrKg4o9+12hanJIHhbxS
	RRhOFB2Jn4+CSTsoKNECtFVgG6s67SRvt7e82kZAKZ9XMKpCizA7CbqWYUpOViNxAniEeEssxm+
	tsNbVvEtl
X-Received: by 2002:a5d:6f04:0:b0:48e:eb:56c5 with SMTP id ffacd0b85a97d-49c6f5e8321mr20994211f8f.8.1794821671376;
        Mon, 16 Nov 2026 01:34:31 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:575d:8fcf:e30d:5aed? ([2a01:e0a:106d:1080:575d:8fcf:e30d:5aed])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5f1c1797sm23358056f8f.11.2026.11.16.01.34.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 01:34:31 -0800 (PST)
Message-ID: <6cc41f58-970a-4a18-8a8d-dc6e7b42fe1e@linaro.org>
Date: Mon, 16 Nov 2026 10:34:30 +0100
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
Subject: Re: [PATCH v5 0/3] iio: adc: add support for the MAX34417
 Four-Channel High Dynamic Range Power Accumulator
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Michael Hennerich <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux@analog.com,
 Conor Dooley <conor.dooley@microchip.com>,
 Marius Cristea <marius.cristea@microchip.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
References: <20261102-topic-sm8x50-iio-max34417-adc-v5-0-0ffa5e5f2d5c@linaro.org>
 <20261104021700.14e69abb@jic23-hlaptop>
 <01fe2a71-ba6f-470b-b6bf-e536a1013b09@linaro.org>
 <20261107230925.5e66b234@jic23-hlaptop>
 <51eaa37a-9634-42cb-9aac-4c842ab2af07@linaro.org>
 <20261114184622.5d47903f@jic23-hlaptop>
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
In-Reply-To: <20261114184622.5d47903f@jic23-hlaptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/14/26 19:46, Jonathan Cameron wrote:
> On Mon, 9 Nov 2026 10:52:22 +0100
> Neil Armstrong <neil.armstrong@linaro.org> wrote:
> 
>> On 11/8/26 00:09, Jonathan Cameron wrote:
>>> On Wed, 4 Nov 2026 09:45:02 +0100
>>> Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>
>> <snip>
>>
>>>> But for the other reports:
>>>> - [Medium] iio: adc: max34417: shared accumulators clobbered on CAM power/energy read
>>>>
>>>> This is a tough one, today if either we read power or energy, we erase the accumulated
>>>> power+count in the context, the context accumulator is only here to make sure we don't
>>>> loose data from other channels, like if we had a single HW channel.
>>>> This simulates this, if we had a single HW channel, at each UPDATE we would get back
>>>> to 0 in hardware anyway if we did read the power or energy.
>>>
>>>
>>> I'm only half understanding this.  Let me see...
>>>
>>> I'd expect userspace to see accumulated values since we enabled the channel
>>> rather than since last read.  I think that's the final suggestion from
>>> sashiko.
>>
>> Oh this changes quite a lot of things.
>> How do we handle overflow in this case ? we disable the channel and enable again to reset the state ?
> 
> Is it possible to accumulate into a sufficiently large type that overflow won't happen in a feasible
> timescale?  Anything else is going to be a but unpredictable for userspace if it
> is expecting an accumulated number.   The other things that accumulate in IIO tend to be
> moderately small so it's never been an issue (things like step counters).

The hardware can store up to 4.55h of data with it's 56bit with the default rate,
we store in 64bit in software, so we can store up to 256 times so up to 48.53 days.

It's possible to lower the SPS to 8, in this mode we can store up to 6211 days of data.
I plan to add this mode afterwards.

I'll switch to this and clear the overflow only if we disable the POWER channel.

Neil

> 
> Jonathan

