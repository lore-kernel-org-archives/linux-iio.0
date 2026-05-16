Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA613E4C6A
	for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 16:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778949622; cv=none; b=jfLjoaRktO+GRKapmY1Lvhlo8H0REwMMxjaHAtJCDQc4Vfz+eiOYeLFfu/E7rC1LKwzVV5Ly6gVXmANhN4M3RY1GjiYDTgTTFY3g03bdei6Qo0jayH03tQp0QRyGdwKBwcay8geVE1FrVEE79v4lC3rKgEOaa5ikuOqhM/3BPCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778949622; c=relaxed/simple;
	bh=CdqJEGbSPF3YjVUNwmIAWhJJsL06rr85axwqdznAgzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N2BCvZO/2NLstk3CaElHu9IlBYrb4PrBWxh7YKbIX7GUQTPtk+4s5vMrtmJ3rx9BjJRy+k/rCDyUC5Itm+COrmYjF2Leo1cZseVaeDKFh+Ekf8NBK0a6yWDUWnRKTcitYNKE2slfL9F3UCVZDIKiWnQf2F61QHUU7G2SE4IWTlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=zCtnHhv1; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="zCtnHhv1"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6948ed7139eso281581eaf.0
        for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 09:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778949620; x=1779554420; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6jm966xj7zPGPn8amxpVaRSTtZJqzq+SHHS0XJfx6jk=;
        b=zCtnHhv11odmQgIWUhL+wGwI4/6RmSyjXuvnhbcoGP64Q59oBVsT0Acd59DCMYJeOG
         E5s7egY1HKJYmAvAQWBg+p+YweqJw0WYX0gssePv4mbHHVLIyGr6T5tKJFWfYP0E056L
         MwwgMscCiLczmIiIsuKJdG7MXjWRqmi+QVNAmg5Y6Dt5VWkINn1AhJtAFqoqppc8WuS6
         wOiHC8+y4/ytIF5Gt+NiObGFA2IAt5R2MWZJAkQlMfAheSRrGD8W/ESrY3/4LzV96RbA
         iZFvhNoptuyEYAHM32bV6zFCUe95v5RTNMqcZRWFTYD/Y+1BYHTQdpk6DBl1eP6C/B28
         R4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778949620; x=1779554420;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6jm966xj7zPGPn8amxpVaRSTtZJqzq+SHHS0XJfx6jk=;
        b=GKiOwMpRCpJDP94e09/QCMozI9Qw3+d5mLmIfeKABElv1klbqH5OqCz4aZBuGW2hTe
         SxrCBzWWspo9dDjv46m7NIfC5Z0GRUQXLNRs7JLSv/umCT3ZbUcwFiK+GtIth/34HI3h
         vkw8J1kiPGe6kdYFy2bLtoFhM1gwXcAt2gJedsOz4nkSRjLqn0jKeISPBAiiUgPthAI6
         yHsvl7+A8SRUievgp+d+B+5KgGXXN8ScrBMnwF2Ti9FjFBjKLN9l8PkXsaPOzSzc7MIc
         TlZupW+JMIbqNQFQWQKiN7mGJ4uc4I8FOQ6RK0A0ZiCstAFLrFebxLpbF6D/Fwa2Bk2o
         b4hQ==
X-Forwarded-Encrypted: i=1; AFNElJ9t5adH8pNwWtVYvIN3dD+MmAq2pXmiQ7Dl9D/5xyPkmciMzWurqHPwGFlWQPL+cwd+LhJA4rBnowc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnDAGT5Gge60AqV8df0ft7jrrCo4ULl1dWG4Tk+8m27+w46fM+
	W1s6xfS0a2SGUAYVn/V5oJLPFJDhVXdt7SDBUm6y/3O5iKlK8IMUad3FnSnW9nAQBGw=
X-Gm-Gg: Acq92OH3jZL3Fz5iU81WC4mHgudsddfcD+9/qaESiuOzXUXCXznQy38CHIo8a3fiO9d
	K8/k7Opr27FS1HuajGBkLwofH4nfYZotBwpL9nMsul7cijxU372W3l4sc8++tuNAAX7QFMIbNpj
	AW2yhUFgU0Bfelnm1MjZ6lKmSylvx0Y8/9IWOwiTaKEAoQZ9u3wXOtQJqc0CsF3lRvZqGMomUUN
	+prA8o3C/Xu6lg5IIrga9RJ1tzcaBS9GPz5vxhMTuxutFBlBhSnRYSua7X7WJTrregH4CZKT6pG
	7YgSzAk/A1mL6OeSsxhbAk6wZ8KOpUPseGePQkuUSC/OirFwlaYDLqHya27qIEfvjjWQUYgZpvL
	4XhrCC8VHVWryxuoaB0MxtOhEBPWdWbFrXq8n8Tz4Z1MyoJZuIyCz7V+nXg+SCd7TpANmmWXdGT
	on9MuzF79CGfhWigVv7apnN8+mPab1TbXmtn7TEoC1T1Xm98wSRY3vURMZStaxow4zBSyntl7Mt
	qBryEIaeM0C
X-Received: by 2002:a05:6820:f034:b0:69b:5696:e518 with SMTP id 006d021491bc7-69c9429428dmr5894777eaf.2.1778949620026;
        Sat, 16 May 2026 09:40:20 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b36d:bd18:7c02:29e2? ([2600:8803:e7e4:500:b36d:bd18:7c02:29e2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69d041da4basm2702766eaf.0.2026.05.16.09.40.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2026 09:40:18 -0700 (PDT)
Message-ID: <4c1b2887-1e95-4723-b42e-329ef5b1ee90@baylibre.com>
Date: Sat, 16 May 2026 11:40:16 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] iio: adc: add support for PAC194X
To: marius.cristea@microchip.com, jic23@kernel.org, nuno.sa@analog.com,
 andy@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 broonie@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260515092946.10791-1-marius.cristea@microchip.com>
 <20260515092946.10791-3-marius.cristea@microchip.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260515092946.10791-3-marius.cristea@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/15/26 4:29 AM, marius.cristea@microchip.com wrote:
> From: Marius Cristea <marius.cristea@microchip.com>
> 
> This is the iio driver for Microchip PAC194X and PAC195X series of
> Power Monitors with Accumulator. The PAC194X family supports 9V
> Full-Scale Range and the PAC195X supports 32V Full-Scale Range.
> 
> There are two versions of the PAC194X/5X: the PAC194X/5X-1 devices
> are for high-side current sensing and the PAC194X/5X-2 devices are
> for low-side current sensing or floating VBUS applications. The
> PAC194X/5X-1 is named shortly PAC194X/5X.
> 
> Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
> ---
>  MAINTAINERS               |    1 +
>  drivers/iio/adc/Kconfig   |   12 +
>  drivers/iio/adc/Makefile  |    1 +
>  drivers/iio/adc/pac1944.c | 2172 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 2186 insertions(+)
>  create mode 100644 drivers/iio/adc/
Can we please split this up into multiple patches by feature added?

We are already drowning in reviews here in the IIO subsystem. It takes
many times longer to review things that are not split up into bite-sized
pieces (aim for 500 lines in a patch).


