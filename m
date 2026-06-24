Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343543BD63C
	for <linux-iio@vger.kernel.org>; Wed, 24 Jun 2026 14:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782310685; cv=none; b=HFSn3gQ0qp42X/1KPIs/8nF8YjTJImRk+ECi8VzIEjxjv3FMKdFlM5HqYeKDixVc2lgwVMOUamoBbRlMWLC+0zOwSnNd9O/1TrnkrKxaQpJJsuJjXJQIDo7pOYKh46jkQf4+sd1qXU2TY516OJmXgXVciTEku+8WDMzDsAje7P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782310685; c=relaxed/simple;
	bh=XwINuM2d9r43k4pENtoklLvyYqq1bsSLEQaX73tWHzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ppsQSujczsqOe12ZymLbqKQq0oA2drUlslo5uVaIxM9Ej5mizfmB4I3lSyLGqbRth8HrN9qTTPpxrCO4W/vwNnEfRX2bPrN00vpuINcQ8eTCoIzcMSmFA4axUHCmMPRbAWvKDoOczUacb5bKsCRbjz7vkqPofDbm8/v9UwI3zlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Fb/UZ/8X; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Fb/UZ/8X"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7e6d37b7098so1076586a34.0
        for <linux-iio@vger.kernel.org>; Wed, 24 Jun 2026 07:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782310683; x=1782915483; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i+rebP8UcTIOnkK9eOy9m0DatNhwkLGwqp1CZQ/L0Yg=;
        b=Fb/UZ/8X77WVJhHFR886hE3lfLHXT62B32x8VQ5+341CCcr18HxQ+2HmQDBHlw1GCN
         2r+2lnri0fEmJJR42BspVn7F2aYJtd010DLGObMUoTPKvIFbdWCU9cRRkzzegsBx7EIR
         1pedfH2Q465wm7WtOFMkmC3rOklQMXabu8765rl6IjMGI3tRCnR3WyxgvHJVgJeVrZmN
         RDF2WlvWyHJrh9uOK/YfhPIplxVgzitCo7V5sIiPzkxho8Y8VcgRymV4LOcwqXwBkJmM
         ZfAO7Av+ficeBoW4Ncll18M2p83yrlvxMeff2/yY8yJiTkSJpMlw3Hr3kq/FffLKjNYx
         7MqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782310683; x=1782915483;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i+rebP8UcTIOnkK9eOy9m0DatNhwkLGwqp1CZQ/L0Yg=;
        b=HsZIfCu/fuOfarMqbOgMIJumS9ABUTjlQYaKiRETRWwCLzIeGYyp2DTD3xukgLuRKK
         9qT1RvgP6QMjM4ltCISWJJ3dm+TjXyqjGRbrXIY2yaxECKHGs4M3pJ8i7bGQHDd0Zw1d
         ScOinix1ARxU2Oa08sNoOuP3wI/SqSwdUsY6jVuwM6NrrJsXvLtR5u9iHV0R5nfejdtt
         mkFeP4o9QTTFNbiqtFMxqVcvdnR4JpMsQOEpQoE8bLQA2deb6J/32VXQquqvlxjQKIPA
         UsK8T6Ot11rYFWn6j6/aPkm4f5QolmCR/7Wz32dE0IpJqBWUvUaIsBh7d0Uyuhjp/EWI
         98/A==
X-Forwarded-Encrypted: i=1; AFNElJ/tBQonc+pH01uuvlOv/HVy1Siz7bmN4Hwb6ioqVtdKmyf6vxyj7qjFlpcGKAK59D5fxP4xTpQnlPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBKzRs+Iigt/y3z8Bldjv+/VOoLxOFJFbxpS5c7qwVmYgKZW8T
	loDMl4w6gLiV8+YAa1NWcVUlOFOtTL2jWnZDItDqUSd2m5ptoyKwafI+QeoPU4IzOVw=
X-Gm-Gg: AfdE7clpnHBGE15kJOSxpTUm4Bry27D1hzS+HjI0czgfdNhM925/mH/NGt+d7dZ7+2N
	0oL48HoYIK3j03P4ymLvzQYFKFHSMZJZMbExYy+6jB176UKqEk/k+aUmwWfyxNuzOJP3nbkSjGo
	KstE4jxvHxS4Obii6anPIunFRsNB3/Sg7unYLldZajtRTuJIWhoCeHbnDq1BUuLU6WduzIwZjzh
	vzjWiTjwhEvPhO3+tY45aySlKd456s0c5mouB1aNY6oU+zjUMYnYJVRt25JZr+13Uu08v5ZHJ0v
	uIn+ELgWBP6v0jD4V0ijp5JHtpGaENRCE6Z1Ryd4WiE3sD4SepNUQwQb2C0i1LwkOmn4460IC2z
	pb+frEKn8naFLfFb79i3j+/NzmWhUocCUpxPEpoaBS9OlZVcPYerJxy4YKK35XuyV2gP8pOQJ+R
	dm4KyXcDc0NrBY5ESnbz7dLgeAqCNlXKnlRPh0zEUNMLmu7hHQqDU5a0cAhcb0hE6T+6LfHXOJc
	Q==
X-Received: by 2002:a05:6830:210a:b0:7e6:deb1:484d with SMTP id 46e09a7af769-7e986a90b58mr2661944a34.13.1782310683152;
        Wed, 24 Jun 2026 07:18:03 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:68dc:b788:b3ac:e34e? ([2600:8803:e7e4:500:68dc:b788:b3ac:e34e])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e944068feesm10965181a34.11.2026.06.24.07.18.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 07:18:02 -0700 (PDT)
Message-ID: <c64ed5e8-90b2-4898-b218-b1e41382765d@baylibre.com>
Date: Wed, 24 Jun 2026 09:18:00 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iio: dac: dac8163: Add driver for DAC8163
To: Lukas <lukas.metz@gmx.net>, Siratul Islam <siratul.islam@linux.dev>
Cc: andy@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 jic23@kernel.org, krzk+dt@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, nuno.sa@analog.com, robh@kernel.org
References: <20260623-dac8163-work-v1-0-5b508158faa0@gmx.net>
 <20260623-dac8163-work-v1-1-5b508158faa0@gmx.net>
 <36ffe80feb5a521c28b1a6d10bf1338dc39ddef1.camel@linux.dev>
 <ajuVjk-lw-DqUVnl@berta-MS-7693>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <ajuVjk-lw-DqUVnl@berta-MS-7693>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/24/26 3:30 AM, Lukas wrote:
> Thanks for the review. As i said this is my first time submitting a
> patch. I have looked at already existing spi dac drivers for reference
> but i seemed to have missed quite a lot. But the comments are greatly
> appreciated.
> 
> On Wed, Jun 24, 2026 at 12:56:15AM +0600, Siratul Islam wrote:
>> A link to the datasheet here would be nice.
> 
> I will try to add all the small suggestions i dont mention explicitly,
> like style issues or using guard instead of manual lock/unlock to v2.
> 
>>> +
>>> +	if (st->internal_ref) {
>>> +		st->vref_uv = 2500000; /* 2.5V internal reference */
>> A note on where this value came from or why this was chosen, or a reference to datasheet would be better.
> 
> I think i would add the suggestion from David Lechner to remove the
> internal_ref property completly and add "the way of doing optional
> voltage references". This includes using the macro
> DAC8163_INTERNAL_REF_mV. Would this be acceptable?
> 
>> You have a CMD_SOFT_RST defined but not used. Should this be used to reset before doing any configuration?
> 
> Yes this is a command which isnt used at this point. But maybe it makes
> sense to reset the DAC first when probing.

In general we tend to reset IIO devices during probe. DACs can be an exception
though since they are output devices and resetting it could change the output.
This device is quite simple anyway, so reset probably isn't needed.

> 
> Best regards
> Lukas

