Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FB7347BA9
	for <linux-iio@vger.kernel.org>; Sat, 27 Jun 2026 21:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782596378; cv=none; b=sLWywY2D7zxgcSmWpau8yI/Nano1q8BzYeWkBbL7zdc18JTuc/sIFQhYOW2Gr/9TchrbPA9nmuGs1e2yrPQb40QWa+8PZR5OiQVdFWH8fFZSzinOV5HnI+IgKPm4b2CjHy/JgoRyk+ormVhDHd36/q+gqABIy0f9Mtp0qfoGCxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782596378; c=relaxed/simple;
	bh=Jrw43e9my7yjDySFOHdkZacbQ+d1cBOiqQNFbZ/fcC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VCBeS+wVqSOR4QBAr/zWjhXWKmTz6OPwKl/ik4WW4RJd3ATtUVjFBsS0sxhnq/+GZ0z/TF8N3GlR2W7LRraxdh+J/6PW4dx50z2XcFEgXPBX+zDxGEjE2d5ium3mkA7gpIU1+PnZyT5MEeZ0P+Bl/Dzc/VGoiVw0iSuzMwa9JuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=lwaDr6K7; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="lwaDr6K7"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-48f0e5e6698so1568523b6e.1
        for <linux-iio@vger.kernel.org>; Sat, 27 Jun 2026 14:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782596374; x=1783201174; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mi58OHINH72wJR2vpcoc/xSWHNR4hKCJuepbJpQnH/0=;
        b=lwaDr6K7ErXT/qBQqketc+6HyPzQo76+PWB2I5vtxG/oEYY+KiCG3YgrWgSi4QA31d
         o1p8T52d2btzdSk642f6zYAlqgXJuFl7NGU5YUI6DONsIVrVbDxISOawk8o9EJ3Myp37
         W3jywzlHPQWTxm1KwHpXDq7H/U6OIbv2oL6Gxn8cHg5C6b2dG9h+dVBM+fZ7kU9281OZ
         ZwL36uSeqCcbQWVVggWr0HTlQkmLpEms4SU1Yo1phV9JQI+rMRY7Yhukk/1RcxtXMLD3
         zZe/WrGF825v69KlAnIlHE5UjZf+FOgqgKsCUFJCuMwf8UkZQlrqBXbba/njOQ2UoXUp
         lfmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782596374; x=1783201174;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mi58OHINH72wJR2vpcoc/xSWHNR4hKCJuepbJpQnH/0=;
        b=As2vI8jBoQTtPkaI+K/yc4iPLiqcA3rzdJ5by0PK0AuXoQzylJMsvwJm+kkpdCaqo1
         idfJ5gzzJqCwVL45id8OtBxDmr4vPUdtnOVJvUECUWOJDyxPPZeLypr4FC8Z1D6n+TBc
         wd3A9btIg25lEBVssNOBz8LLBovS/XXiRDKujg0M8onwoXG0a5MtGzvbq4dRUjLebmQk
         XdQgzPS0jY295fONxOvO2Hh0tnZK26jIiVbEFbzMoZtZ8CuttrKDPfgJYmNNejIwX6G0
         ay6QkVwLyE68iPIFNIA8HNnZAauhE0OHpY/qKaQXwDm/W1B8htvaAyRQxMN5lpEUw0/F
         +SDQ==
X-Forwarded-Encrypted: i=1; AFNElJ8NQTZaMEj+WLR4dyH0LH6QlPX0BuWKguU0wv0qkbw6+n7j92LGyhV0y1ro4k3CVWE8uf8AJb3f4yY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygzl6yYmhcUpEQ1yIYpE8tVa6gCChpuewsZoldW8cOSup28kf0
	1y4xWZ3BhN23VHtPiMQO95zAhLl79PKreg0Lo72HrXR6/grEGhMtUmN1rr3QLBqK3bw=
X-Gm-Gg: AfdE7clHTTjk172xfwS55DmALSEAMNl8ndUGbFJFTctRmSqiDD4K82z1At92M83jHvm
	tfKMjAzFTOOuAEIVDHwDr/M0mc9G2wvvAFUupHxa5oSyS/4qBMkSg8uTlobepVO0sUKGwdr1mQz
	VxwvBIQrfjqbYqMQaupE33e0LT/ko30tSL4yKLSp8kIXDc/KIpQdJe9MoQD8RUmnJTlEO5V5zOs
	9uk0c+IU2+jBqgNzPx/WJd0cYQ5l2XZppqlwL4hQsxfpaArLZrMypxddVqCNXa0a1czCEzeS+Ss
	ue5+5B5avigIA5/h3fwpvmVxHcheaMpYL18lEW44k2WPRxxO9RqU7x1QY6/pVGfJuUiwvG26Sb1
	83E5pDifcO94cyd95x86H3faoaSRl1wBGk2pMbgTAVmlM8oD/bQ89+mZIai1gQzeNpL/7YPpItx
	AF8jcg+7x3NuItc+yj+CESmaLZIgXYqdzPWdiFJJS6KmpnWUVXpnuVOKXVRz5AVQ8+g3nBdgYUt
	w==
X-Received: by 2002:a05:6808:3442:b0:495:af31:c66a with SMTP id 5614622812f47-495af31ddc8mr752314b6e.15.1782596374257;
        Sat, 27 Jun 2026 14:39:34 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:f242:ecd6:f61e:d764? ([2600:8803:e7e4:500:f242:ecd6:f61e:d764])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-49352b057dasm3927523b6e.6.2026.06.27.14.39.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jun 2026 14:39:33 -0700 (PDT)
Message-ID: <a2fa4d9b-1f09-4226-8f06-371bd11ef919@baylibre.com>
Date: Sat, 27 Jun 2026 16:39:32 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] iio: adc: Add support for LTC2378 and similar ADCs
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 julianbraha@gmail.com, marcelo.schmitt1@gmail.com
References: <cover.1782397418.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <cover.1782397418.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/25/26 9:34 AM, Marcelo Schmitt wrote:
> This patch series adds support for LTC2378 and similar low noise, low power,
> high speed, successive approximation register (SAR) ADCs. These ADCs are similar
> among each other, varying mainly on the amount of precision bits, maximum sample
> rate, and input configuration (either fully differential or pseudo-differential).
> 
I had a few minor comments and I suspect Sashiko found a few legitimate
things. But this is looking really nice now.

Reviewed-by: David Lechner <dlechner@baylibre.com>


