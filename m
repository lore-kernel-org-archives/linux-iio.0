Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793781909;
	b=VUVOs/Ml+0AB6A+Dojx0mbBjClF5TtQbAkR4Xr+lfK+tkNAFCkzP5jzzIMKnzdminSWq
	 3YtuVLyUM2aJOMUJ/SXG6GlCUjPFiRhpR7H/nRJLyG52tlp09Bb2zqa3+GKurqaFwl+OT
	 xVmzN6heOzHE+hNKECUts/ECmOWYlT7szJbieAxul3okBe0S4SsJwOCR4WmemCz04+yZw
	 uNhIJTwuPBN9TH09k+f1vuoDlApKYmPjh0rjSgaLMZL+CucbnC9zIUJozqc+uUXp2+42c
	 VKBIfgKmJizBPvR+iuEgqI1rohIiIkQmpfjZWYjMRwbmxsKSQQSCpRfTpgGLFYEeM+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793781909;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
	 References:Content-Language:Autocrypt:Organization:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=sewKb4uzrc83cn/bmcIRxi4zBM4CwiMJbeIGg3rMpL8=;
	b=RKqQQCAZB5IIG3Ip/5CFWSjEns7e9WcByzCT8M8HX4N7xlcrJP2ARwg31z1NmNR3AxK2
	 DJJr3CmswmWB8e1S5WU8qhiP/jh5vFwDlV7az8+eFUaxFHyOa70BRWW7LXR3EJrZTsEh/
	 tRvyYn9CKDsz1HGbz5zZCkKK3y311yKeOmVkhaE950VDg0Fg1ahEN6jM1pO//TvkBrCGA
	 ySLlQXoaHtvHRbCQXhcVq417KePqWxtUuMpQUWntoAk1frdsuqg/Z3hl9w3rZtcLjemMk
	 8/fipJ9V5qqaCXlF/XFybP5pVhulwLylF1mQ+A4LD1CkFGrCCyn1VwNcFFRyEtRpqDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD9E606A338
	for <linux-iio@vger.kernel.org>; Wed,  4 Nov 2026 08:45:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCD9E606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4ac95761c85so2438625e9.2
        for <linux-iio@vger.kernel.org>; Wed, 04 Nov 2026 00:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793781904; x=1794386704; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sewKb4uzrc83cn/bmcIRxi4zBM4CwiMJbeIGg3rMpL8=;
        b=lhZds9+ZHwK2V+PeQ/IRFU1kXExrO5GO1gRGTuSzj1vnh9JwwsDjztEp3smuuajVSn
         Fs1EAO3XXiTA3NnJdHzOcJpycWTRy9kG00n2sBOg9Vmn7PXRdVkSqB9p4F3nKQiblY0z
         SwGrz04AwE+znAnaNeEkdNCD0uuaTp7rtglwRGTB3nBw6av+wwZXBfLu+h56HppsF5j+
         DDH7Bz+GAwRRVxTxz/G87v/PNGXk39mQ/jF+Dok4V2r4siGCRqybjBbt6LeMhNkVgH7L
         LdZ0ZmwdcQxFo3TqDzzIv644MdqZE5R1gBUYriTgi9BoLhRoq3cFdqD4ddF8EbmhqnXh
         2m8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793781904; x=1794386704;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sewKb4uzrc83cn/bmcIRxi4zBM4CwiMJbeIGg3rMpL8=;
        b=Cr6EzJWvFsa7A12k7IEUjt2/W73VCCyDfsXdv2PuhHKqT9S08sNWtweoUuE6NYhz6v
         XUpb0q0EmEe0eSl3bfeh4ib1wJnSx179o686359cyjF+nB5uX68AEMRae3PAHh2whZH6
         bwKSdAdTDMvEjvlmS6zT12hSWRVOZ5tN9cCLeXgLFJKQpHP8hsYi2VmVeHUp+Oy1V8d3
         Hdx0az22lW0aKI1og5UNFgoMh/Cspd83pXuc4IuTpaltKLt3ebaXUREUdmmEg4vpqLhx
         RS13K71WYhOnTFBGFHeOugYeQNzOudIgZH/IwXnY5YQy4MXQ6oGxnONVhOVacEueqGn8
         ia8Q==
X-Forwarded-Encrypted: i=1; AKwUvBy1dxoAraidvotZSuW1428A/gHzu12zbO6Yt0fiMOWRA8PWmo1kQeosJb6v78x3n/zAWy4z7kpuQKQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9XntsoD9vSimOyiIGJR1FEnoRkLKnEUZHDQ2RR9eSySx0nBv4D
	uPepI30PJVKtdSmU2A9N9GVL3tlPsB5yH/ZmOFEYgbxdfl1FB2mb2naSwi10Zr88J5A=
X-Gm-Gg: AYBFou01OnNtSIP/ztLn85AGqKYfmqaKpMbQ+fXhj3Qt6vVs2tBdHwusI8Iza8BKvX6
	ywUH8CzBfZfrHUv2q5UKoTs+ot5eF8qoTxHi/YvnzYXOb0AjCrte0F9ZOn/nkQauLkWSBQ+cKDn
	PPO9hhiwXWTfRz1O+ZASPKzsNZAaX/9URmykBACC+n4dxcpeEZ9rEB1FSCCEM+Kx2bPSZYRC2XW
	z7GEe6iwyAwdQ+Smn82OTdoRKcBb6EtCkh6g5lhwKP2+AoH2lsO4J3jcMtY9cw1LCQnAo7c5huU
	9T050AM8SXMLof6HqOMlup/SWhcigt7+A7igWUgOOu8144emVslGJnLdRjiRfFZv3hkj7u7jAU8
	bbEu7XnKL3z+5ocg2Wn+z5TbOHHczFz+aglC2RbqU/TK+16YqVhtqYGVebbm1kK8wPOrjvYlrXf
	Q2PyY0GKHH+6wLfyuMMIMo0PoFoeDOrhhLxmLS+i+34P1/O2wP2bWN79OH7szKqsj5mjWslJvSk
	kKaT33Kz8zcfH7PZy0PWXOGPfNxFiGcom3FB4pQgm2StPvL/Hf8PSeIsQh5kfPwN+aelSC049mH
	FkRJqKv9qKoh/fPdGn6Li8I7B9r70OqgoGb7NWwau6xoalLC2SdXoiGkGgPTs5djBvMpsa/mljh
	Jfkefe9k=
X-Received: by 2002:a05:600c:628d:b0:4a2:397:73e9 with SMTP id 5b1f17b1804b1-4ac17d1995amr354869205e9.18.1793781904156;
        Wed, 04 Nov 2026 00:45:04 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:6762:47bb:1e06:ff70? ([2a01:e0a:106d:1080:6762:47bb:1e06:ff70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b43cff3fcdsm37072035e9.11.2026.11.04.00.45.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 00:45:03 -0800 (PST)
Message-ID: <01fe2a71-ba6f-470b-b6bf-e536a1013b09@linaro.org>
Date: Wed, 4 Nov 2026 09:45:02 +0100
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
In-Reply-To: <20261104021700.14e69abb@jic23-hlaptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 11/4/26 03:17, Jonathan Cameron wrote:
> On Mon, 02 Nov 2026 15:49:03 +0100
> Neil Armstrong <neil.armstrong@linaro.org> wrote:
> 
>> The MAX34417 is a specialized current and voltage monitor used to
>> determine power consumption of portable systems. The driver supports
>> getting the channels voltage, average power and accumulated average
>> power and energy over an I2C/SMBUS serial interface.
> https://sashiko.dev/#/patchset/20261102-topic-sm8x50-iio-max34417-adc-v5-0-0ffa5e5f2d5c%40linaro.org
> 
> Sashiko had views and the dt one at least checks out.

I'll fix the bindings one.

But for the other reports:
- [Medium] iio: adc: max34417: shared accumulators clobbered on CAM power/energy read

This is a tough one, today if either we read power or energy, we erase the accumulated
power+count in the context, the context accumulator is only here to make sure we don't
loose data from other channels, like if we had a single HW channel.
This simulates this, if we had a single HW channel, at each UPDATE we would get back
to 0 in hardware anyway if we did read the power or energy.

- [Medium] iio: adc: max34417: missing 1 ms delay between UPDATE commands

It's unclear if we need to wait 1ms in CAM mode, I think we should but should we block
from the read if we are under the 1ms ?

- [Medium] iio: adc: max34417: scale truncation and mJ unit in max34417_read_raw()

Ok this one may be real, should we return Joules or milliJoules ? If so we could
fix our precision issue.

- [Medium] iio: adc: max34417: missing UPDATE before CAM in max34417_setup_cam_mode()

It's highly improbable, but I'll fix it.

- [Low] iio: adc: max34417: reuse max34417_reset_smm() in max34417_trigger_smm()

I'll check if it's worth it

Thanks,
Neil
