Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2D542BC45
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 00:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784074566; cv=none; b=DmSvHtEzHE+h4HKHdUHXPhk+UHF2j0rg582Jk2RJIbB4e+vgrH+majwaZyVfTTqqs2dciCunv2gSCpAPa1eUUZz79WQLZhDHivA5ANVRJeEoy0sdk3R5hp1bKPekv3NBoDfEWH5kLili75i6sfzqEmygEFWoLD0vCY91mZXLZTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784074566; c=relaxed/simple;
	bh=N5TlvO5iZe9P2vr4aiEd6RD7NLTdSfHOkOJZXZGkKtg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sHhZZJ5qDE38u0SbjAGMowFPXZbL9NbVDil/8thgHn3DMqMYaXckej+u8UQZ6pjRJImbwfU5gDCfTFdp1bvDsXQDLAVi8nkTYzNBGqFS8NnKFKp2Dzq6RKsVvAp3ovxxlQQJugSR07R7AHf+mcFdFTqMLlD18CQ7HiEElQDuWHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=MihXKCjC; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="MihXKCjC"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6a324d200c2so2649734eaf.3
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 17:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784074563; x=1784679363; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v20txCudxnU90G5a1KJ/IuEQut4SBvkqPVwM403HGOg=;
        b=MihXKCjCc5SM/Ok9Wa9khUv58N/Mo8kEs9gkbbhUlNrMj7YbMSaDWjVKukvIemJ0E5
         Z3XpF2+BmkNAQ6eEZnJPO6c+TCt1ska6+572USfhLZc0LwMdE8Lhxd+bHGZt7+lUxcq9
         G31JHdQRkf4FOPcVwVXlBixs1QH4XDpHrSiRNw9OWQQnWVOWmlW85FzW0BUVwShNM9WF
         EVGe6TW7h0JzgF0heuEkUfAQQWa3k8QxCUwp5NHRIV5CZUdgCPpN1WaMu8uCblOWEqQv
         lEB66bDThSuxj2GwiLW7z3Ui3NtfN3dzQqV1HaJmCdPjvOHL43zDxhujVLan8pZ93WKl
         ikgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784074563; x=1784679363;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v20txCudxnU90G5a1KJ/IuEQut4SBvkqPVwM403HGOg=;
        b=svC8kWjkxrZMGKO3xuHh/COfmIv35cFCjHsQ3sSpmJNOOW/8SiZmGF8ryYx2msZYTF
         XJyW14luBVAh94i76F+MP5xmgnpnDD90o1iDozBB44dX0tAJojZ95VP3iApgY6WWx8sh
         FJHsxtX43i+V3Pjbkyxlf3Yb03wj12GeW1+QmczWxli6ziqsyexcKFYpJGyElN0ObTbW
         F3CjKPMHE1m93n8jp6w2k2zUkMYpNCe/gIOXbuzIAZKwtH8fNjiwXPc6H5M3ADN3iYBi
         LyLttGvTMQsCJBtKxzWKm7W8MyuxBQkF7Xh7CzY8vdzX5yWWNxN0dD557hxBrTa1QJz2
         9BYw==
X-Forwarded-Encrypted: i=1; AHgh+RpGxPbmj4V0MeTTvVWEt7l9AEAloBDgEn0N64MWwa99R8T3ykacjda9+XxKAV2TAwR80/O79YOQNWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyztB1tO6iFUw5zF0oT0JwrJaxFwEnV2SAx3nme4R+iAr/K6spY
	iV0sHoXuH9bQOaUe0dT8Pprk5G3bjphfNwHTjF6vriYmM9h7WhhwPFWjwYyGar0loCQ=
X-Gm-Gg: AfdE7cmPOeAXIDB2nyVtlsXEmyNCzgr0Xuc1BI9b6GO688yOL0HD20OoHIDS7TSaVRE
	Fmu0vQ3/PGogp7hoaJDjBCNHW7zQc/cvdSjjPAiHlZxHhiwJ5cku2ZS199484MYZCiw+GmSa8dT
	4pxxUhfd6cA0zsMbsYTsQPBT6DzA1mRhG44Y9EmcjMidbG27otKQp27ggES4e5rbD+sANPUWOKn
	cPepMEomkexCZ9VogyLLWo7j0EPYEf+Y4vw+HEo4BXComwoZypzvCzh+5q78bNy13MXJfUv9sc3
	7uN3pNovMTZKqep3cElicETtVjW4hA0QZXDkfPcADHqJ5WgEARkN0T1KLSlsTfXScH+iA1jnIpM
	qpdlGOpJxLIjoIXeq0g+zJC1Z7XnImIGiSE4lUurBzFjPfSnCAEPlanTzNwZLmjQLaLPtAqZOnG
	F7oy7RT+C2w3MTPTym45/qD5T1ocg3DIxGBK+h+7f88GN/FL7PjMTxRSYP89pIO/E=
X-Received: by 2002:a05:6820:188f:b0:6a3:78bb:c885 with SMTP id 006d021491bc7-6a3c62ada81mr3315258eaf.72.1784074562921;
        Tue, 14 Jul 2026 17:16:02 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:280e:69fd:7612:d5a9? ([2600:8803:e7e4:500:280e:69fd:7612:d5a9])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcb2bc241sm16460743a34.20.2026.07.14.17.16.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 17:16:02 -0700 (PDT)
Message-ID: <f56fab43-c038-467c-bb5f-d96ca548f652@baylibre.com>
Date: Tue, 14 Jul 2026 19:16:01 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/8] dt-bindings: iio: adc: add ti,ads122c14
To: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>,
 Kurt Borja <kuurtb@gmail.com>, Nguyen Minh Tien <zizuzacker@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
References: <20260714-iio-adc-ti-ads122c14-v4-0-25f8e3084485@baylibre.com>
 <20260714-iio-adc-ti-ads122c14-v4-5-25f8e3084485@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260714-iio-adc-ti-ads122c14-v4-5-25f8e3084485@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/14/26 6:21 PM, David Lechner (TI) wrote:
> Add new bindings for ti,ads122c14 and similar devices.
> 
> This is an ADC that is primarily intended for use with resistive sensors
> (RTD, thermocouple, Wheatstone bridge, etc.). There are a few unusual
> properties because of this. In particular, the reference voltage source
> and current output requirements can be different for each measurement,
> so these are included in the channel bindings.
> 
> The REFP/REFN reference voltage is usually just connected to a resistor
> that is being driven by the ADC's current outputs, so there is special
> property for this case rather than requiring a regulator to be defined
> to represent that.
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
> ---
> v4 changes:
> * Generalize temperature sensors to resistive sensors in commit message
>   and bindings description.
> * Remove leftover paragraph from v1 in commit message.
> * Added if to make clocks and drdy interrupts mutually exclusive.
> 

...

> +# /DRDY out and CLK in use the same AIN7/GPIO3 pin.
> +if:
> +  properties:
> +    interrupt-names:
> +      contains:
> +        const: drdy
> +then:
> +  properties:
> +    clocks: false

Doh, I thought I tested all combinations, but must have missed one.

Sashiko correctly caught that this is wrong when interrupt-names
is omitted and clocks is present.

Tested correct is:

# /DRDY out and CLK in use the same AIN7/GPIO3 pin.
if:
  required:
    - interrupt-names
  properties:
    interrupt-names:
      contains:
        const: drdy
then:
  properties:
    clocks: false


And my responses to other Sashiko mentions on this patch are the same
as last time [1].

[1]: https://lore.kernel.org/all/f1c5be4b-6bbd-41d9-a152-ee480988f44d@baylibre.com/
