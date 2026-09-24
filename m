Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870C44A261C
	for <linux-iio@vger.kernel.org>; Thu, 24 Sep 2026 15:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790263441; cv=none; b=NSRj7ke6Gf3CCKZ0UUDyPRpdvBSPOLwMiGCcukCa6zSoELc5BLAylAATtSjRROpFKkRLsC24TXctvc4SsbmG8Wa6Y60nVpAoT0qbMkvHk+IS80DjfUWTkn+Mvwvqe0mETHJOJlRu4TmLWUJvbl1oNQLytakh5mOsp8IlJd9nAJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790263441; c=relaxed/simple;
	bh=IzhOLVKsqwgB42QUPIej0sfnAYJnOXzy1Dnq+Xf7mcY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=AzbzLOqV5gW0PiuOjeWEtlFdu/mxc80JBjMIdv2uH32IZFK8MAFtYYUp/14+8ZaYqWiWIrI0h9RWW4Hd3XstsGz4fGtszu2ckZyUXnDdHcg3Mt0qtpwOu1l2buk4TZz3UqmKbothUHjqzjqOf50ESPG7eAjhIyeH2IAT2BIJVyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=isxjtbMs; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="isxjtbMs"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e71cdb22bso16573775e9.2
        for <linux-iio@vger.kernel.org>; Thu, 24 Sep 2026 08:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790263435; x=1790868235; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q9PzBhkbr0buW5EMvI92IjryNXR5uhHKomis0hHXcI4=;
        b=isxjtbMsEISrr+nOqIq5Va2JwJfaWovg8RwBXcuRRhTBnTTXvMGulrx3B0ec4vSnWV
         REjAFnqZ86bxJMoSmAlpuRgTyanWxlqMQPGBvjmaV8n89J1PTWAk1FwgD7WJSfAUtBmY
         1GG4rSkolBd7VwUbaktacRp5BhAO8wiAgiCPAeuyr0HgTzgwTnR0facmLpvSo4QOPN0G
         7cmn7z4oCqjyZ1z3WRNIhT14IazTo20CWudQnE5B1D2pRhk82g8HKXmoVRyskiKcTFbz
         HBt6WADyv0N+Rqa55h1VY6vhmMtu8Idls22Bhwyl3nq6T7qklApAIKzVWeByhDoSOtJS
         N9+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790263435; x=1790868235;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q9PzBhkbr0buW5EMvI92IjryNXR5uhHKomis0hHXcI4=;
        b=EmfOgpAVbXe6J7/ccxO5Ao5XvE9MTVzms92SpSUWr09B64C70KcF9emuhlht5SIsLT
         yMooI4uU87gvDV3aR8lKuSeyWrGjdaqs7vwiq/1xlrWSn3qR59s6PQdh1t7sq703Zhco
         dF/EdrXiUvMesZr1J5XgUsCtzUR/Ub8BcrQJRtx1SWnOlI17g6YrT9w7pV4DMPmNijgv
         EfUcTuqdL/1eyVcN9Z6Wmco5ffEHwzPAptVCcaUt+nqOlm39FBAa+L/Cwj2C1GL5xi0l
         u6reJemHjpTplYo/CPNT2BfJLBRyDcF6s38P4jXVSr0h1ZlFQasP6mrj+vkwy/Gqaqse
         Neqg==
X-Forwarded-Encrypted: i=1; AKwUvBz7nbe5iWeat+WynEXV8AwbWV2Q6aUzxzk7uc+PVKgvVfg2CmnCOTlLbV+DDyn/SZFvXh7EqUO4I+M=@vger.kernel.org
X-Gm-Message-State: AFuF++mQqMrtjOe5ZU1ONkGaFLflfxb+sMMSMSxwpzQqcb4NMfMSQ8p1
	vPW3SeadtVssOTsGRnvae69SkmsC1JEBMRDlPqlX6pOwa2zkofNi71XMbwPZaw6nuRA=
X-Gm-Gg: AYBFou1jX5GftvMakKAmulCwn54vrKoI/bQ6e7MCp5SgH8j53Xm3RKU5kCiYdOvHEx9
	+/bCNVLOAkSCAH4IMihyaH2SNWsnk4wU3dHLqSOBEXFyTVPEbNxoT5MtvjS01WmmHXwywXX1dky
	cWDhzcFj/SonGqvB+n0ZnKsI8sROeJqPZX8P7mD1n4aX5gmL36Rzr/mWV95pXnFldK39s4Tlg1Z
	G0fFIqFgbXG1cNs5lCQlblfyegnW2Pa+XINfMiImGVvalUZ3OJ2g0CbhEHwsJl/x/mM3UmIfRdL
	vd3J+jhfzjI8BV+cpsG/TSLC2Osa5BODQjruGhSjqZOEMYlsBTWBqEt6DiNSTz9C/NNiehUT1BO
	vMa6YeioR7JoOPtk0mCdOyBjE2RMU6fkoriCMZF3WVcZwdpV39QU7zcllEiEpVEnIVxtG5Qcm+o
	7ODVW8j/SfprxgFemILK08oYWFWAj8YxHQhftwD343HJl1xGCmW/eROMnEqY+ooRj+N1INoktBE
	Pw3dHXAFMxJyGt3of0CIEc86LKvhBj1l68h+i7tPX86yYm4G7JwTA==
X-Received: by 2002:a05:600c:4e86:b0:49c:dcec:bd27 with SMTP id 5b1f17b1804b1-49fe66cb868mr47177865e9.8.1790263434520;
        Thu, 24 Sep 2026 08:23:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:b956:9fee:508c:ebd8? ([2a01:e0a:106d:1080:b956:9fee:508c:ebd8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5dfa6a7sm116649845e9.12.2026.09.24.08.23.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 08:23:53 -0700 (PDT)
Message-ID: <fa02f447-21db-4448-912a-aa39b26f364a@linaro.org>
Date: Thu, 24 Sep 2026 17:23:52 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/2] iio: adc: add driver for the MAX34417 Four-Channel
 High Dynamic Range Power Accumulator
To: Joshua Crofts <joshua.crofts1@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260923-topic-sm8x50-iio-max34417-adc-v1-0-41d4ba1bfc41@linaro.org>
 <20260923-topic-sm8x50-iio-max34417-adc-v1-2-41d4ba1bfc41@linaro.org>
 <20260924095457.00006ed6@gmail.com> <arUxl7QeiEzFlI7O@ashevche-desk.local>
 <20260924171220.00002cbc@gmail.com>
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
In-Reply-To: <20260924171220.00002cbc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 9/24/26 17:12, Joshua Crofts wrote:
> On Thu, 24 Sep 2026 17:20:07 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> 
>> On Thu, Sep 24, 2026 at 09:54:57AM +0200, Joshua Crofts wrote:
>>> On Wed, 23 Sep 2026 21:10:23 +0200
>>> Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>
>> Joshua, below also something to you to pay attention to on top of the good
>> parts you covered already.
> 
> Thanks! Unfortunately a v2 already popped up on the list today...
> 

Just ignore my V2, I'll apply Andy's suggestions in a v3.

Thanks,
Neil
