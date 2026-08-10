Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF62A427F9E
	for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2026 16:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786380141; cv=none; b=GnQNwF2sjDlenVzIH2BeyBlJxRcZNcdeggMnpfybX12Br/iphj1rnAHc+hS7kWuq4dhP77l+sDODCf4jgBzRkDDtOiz5dgu0ArF2HWa66ZDjZpwHKhh0EXkXyPfDVtsZeZ7f0dXz24wM5zqXCy/M/n1tb9l5GPevRIxwxDZoNoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786380141; c=relaxed/simple;
	bh=UraNGmZFA5REm5mXU8cijvRUoAo6cvI2W9iHwqUD45g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NqhpvxRpTRoFLjo4BxKbJALeOjdeSYdSn0Q6GrklSopcL0e2dckerbdDksCfLHMpvmruZyXHJSDHd5Ih6sHY2tm8tSQBCVtbXr2MvjYvwpczgV8Iflbq+GF2HxZp+vMPWT7Ro3BnI0C1TOtI6L/tSUPUe7hzyBpgjyRxNKm30RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=QVL7N2Lf; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="QVL7N2Lf"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4a483a552efso527351b6e.1
        for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2026 09:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786380138; x=1786984938; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4CrwjdneBCLq2MjyKhUL/tcV1sygNbjbpu5GnTQQd44=;
        b=QVL7N2Lfjlmjxiv1+cn9tFernccaVe8QfmO14LEc7AmROiH+NYCEh6jeiR1MoPpx5K
         4x9iToehymnSIgSfIOaQPvsrVZvz6458O+0ndqjnnPl+wzQi2pgg5UalsmxKnli8vd59
         qL8bLs0Hktu6xc2Ge8a+CZp6rWMKjXd15t1oKdmGxlZTCG1Kd+vDRpucDRwXmGvAB2Q3
         I4l1tLKh3WO7mnh7GLpOEIFnfFq2Vsx03JLEA7Lk3R89Ygcli+QlT2/n40A7UNJJR80v
         AJ3sVHvEUC/q0+nOCjK2MMzSiWtMQH8MjvUhAO7BmgVMZ6MnVT2tLB4WFkMkruT3pYv5
         IwLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786380138; x=1786984938;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4CrwjdneBCLq2MjyKhUL/tcV1sygNbjbpu5GnTQQd44=;
        b=lbwV7TJ3WS7CKu4l8gP1DOBBC+Z9iXg5qWN/BW2GnvedPDgv6cMJUsLPz7g+KQPQDE
         vox1vHzqBWAPWIsqj75JqmsgJTEKn/EnyzrGa3m9asPHHhYvEeAOhyX08DG/xFN4ujY6
         YKhP7wuafGYztAmYa/ZSM7sy+4dC3AElWP1CAg+itSSKTLGXHbIG1JgXO5x6KmlUMQ61
         Q/Ypp5Z11tSigyn5IV9+bBld9Rdg0uGmiuM7/8rq6Niwdt78404E8MKOvp0hX2b92a+6
         eEQN67CjprKMJgHFXjn1pqubyJFFXpmuGY0P10UWlWb2/wl7IOAGxANABwiHe/x/xfca
         mFJw==
X-Forwarded-Encrypted: i=1; AHgh+RosMYEcfN50Qq1d2TtQ4VXB1hS4f2OXmZsfb3QU1q5+uERILYgnnMWAS+stb9Fr8sEVgjZEORBDHoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWidE1z3bVlrX117cwmvKgUGuVstTwuknFwad7rdQhRmotL/Ft
	41aI6tE/oqMUzDNzGO0eTSUpsmnfg9STiEsngtu7Z0X8AH/5RUHgmDxKxfZtik0WrCs=
X-Gm-Gg: AR+sD13cgvrS3FIbR5pfBN6U0fdaXdcJCTZs6BUcow78M3eBGmJw9LzCH6s96NZ4BgL
	qh/m64vBF5rLinLOPMcYSH64AVYy7lo66JLfqjigZAsWSTA4oHwtxReWuFW2d+ewtXZTBHR8ibS
	ViMBSiZExh3TPLt/0cIarzOdSk0iRMY+lsJhY3N+bCtgvU90uPxN2hS4uwP8t6HAfl6UhCvZ/wk
	cP5CvaNJq/ymwSw5LT6k0soBYwRPFfAKw+IH5hcGlOz1OFPXX1nD0+icaRWAxh8G1hDTkblp984
	XnzxpFVJVzVayRi6vADlzHEzW1jOw1S9eMwopizjHCJrehwBsgrYFVSElLOBNFFvSm9vJDB82ol
	9obLt74myr1tSvb0BBd1ZmxYhgz2x7hPCk4BASlp8RUvu4yCqz5UoNe18QymbU+rd8miIHgp3n0
	7U8dLnxzBgY+GObtO8vmIfTIfaode+NrnGtxw7bLYlTkp1bjaRaQA8ZJD34TaH/R5G4/9GkUrIk
	JVfDiOdLf6nmx3ENRjNnvv4yjM0qhIycLyAP5M=
X-Received: by 2002:a05:6808:bc8:b0:4a4:c12:49d9 with SMTP id 5614622812f47-4b1e770811cmr1551304b6e.3.1786380138504;
        Mon, 10 Aug 2026 09:42:18 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:e05b:7923:cf50:e4cf? ([2600:8803:e7e4:500:e05b:7923:cf50:e4cf])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b1af06d90dsm7404797b6e.3.2026.08.10.09.42.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 09:42:18 -0700 (PDT)
Message-ID: <4de0742d-c17f-4d0a-aab1-35870eee053a@baylibre.com>
Date: Mon, 10 Aug 2026 11:42:17 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] iio: adc: Add TI ADS126X ADC family support
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
References: <20260807-ads126x-v3-0-f89925d72792@gmail.com>
 <9c2e2c46-32de-4e8a-88c3-bfc2cfe8157c@baylibre.com>
 <DKK9T3XRZJEV.R83PII0D35H@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <DKK9T3XRZJEV.R83PII0D35H@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/9/26 3:29 AM, Kurt Borja wrote:
> On Sat Aug 8, 2026 at 1:37 PM -05, David Lechner wrote:
>> On 8/7/26 10:58 PM, Kurt Borja wrote:
>>

...

>>
>> And the driver also allows using an hrtimer trigger to do single-shot
>> samples for cases where one doesn't want to sample as fast as possible
>> in continuous mode. This would be more useful to someone who just cares
>> about sample rate and not about filtering.
> 
> Why did you go for this instead of just leaving the continuous mode
> running and reading on each trigger?

The hrtimer trigger allows more than one channel to be enabled, so we
have to do all of the channel setup for the next channel before we
can send the start command to trigger the next conversion. Doing it
this way eliminates the possibility of not being able to update all
of the settings in between the DRDY interrupts.

For cases where we only want to read one channel, then we can use
the DRDY trigger instead of an hrtimer trigger. Since we don't have
to change channel config in that case, if we miss a DRDY interrupt
because we took to long to start the I2C transfer, it isn't a big
deal, we just drop a sample.

> 
>>
>> Just posted the series yesterday:
>> https://lore.kernel.org/linux-iio/20260807-iio-adc-ti-ads112c14-filter-support-v1-0-4d3ba00caf18@baylibre.com/T/#t
> 
> Can you Cc me this series too? The settlingtime stuff is something I'll
> implement too.

Yes, I meant to. It was late on a Friday when I sent it and I didn't
the best job checking all of the details like that.

