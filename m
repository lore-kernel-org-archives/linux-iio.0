Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7026A32AABC
	for <linux-iio@vger.kernel.org>; Wed, 24 Jun 2026 13:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782309128; cv=pass; b=NIkMQ9rBC/4HDsuFZYRTEUMmMI2y3c2WVowlm8kpTw/VUggwrWctVcFEe16u9HDb4Uws1lBJeyGZ0UX5pvS5cJ1PuS+IkEaUi5aWaZZYW+4cBvCDmRrOnKe025Z3xx+/TbRqnPFFrAni2VJjFuq2Jl2NdMS2mi7tY5z3c76l1RQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782309128; c=relaxed/simple;
	bh=M0HmWkSWd9SoNdLB/1JBTpIcmc5oxevxumChcYu0r14=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uEQ1OxJ1z/bVW1vcakW1VlrWj3b/bu+ygt0EaEasVMZbQ6yc0lbaVaE1qCDugeB3erJzTSuVeTx5DU0XmOqqWeKI1c1U3c+80ju1L/vjx8nMpO8t02fLDXmYDrVNml8b3Ml8NiFCLd6bzDyYNgvCNsu6UK14krF86wEx5TcbXuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=njwWQqoo; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="njwWQqoo"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c07fd4dc2c8so114392666b.1
        for <linux-iio@vger.kernel.org>; Wed, 24 Jun 2026 06:52:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782309125; cv=none;
        d=google.com; s=arc-20240605;
        b=RefjIYxHHVe2pvYGWzXAIHj4D7SmOiqJg16F3tiK9Jl8dilfj/KxLA9D9F38AFfadN
         SkPjXSW8rLDHpqWCQc0aNNk+P8uaC29+BxUlr5VZ5ssjl1tQh18YI18RccnaQlxR0jlY
         uqNXZYbP29opzbY+w9FFE260O4m7d9V5ObPj9XSYD3UncNrog2c2FzGj+Fop5iujjcZn
         1APd+zHkrBMmMdeI66jBBennpudYDRpCiWJYKW/I+VDZ1jUdps8JMiV36NT4OsiA/wzR
         Ab+dJs/KiJUAV+79JOtoQ8V8GYuUkGPBPbq3F8QCWbdWg6FeH1/q8olAE/ueIeu8lbdv
         3edQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :mail-followup-to:from:dkim-signature;
        bh=JVKkeSAj9cEIT5s5aHGZfnYhC/Asr1gCUKNdYQVD9Y4=;
        fh=g/2VHfCG0FFfP0Y9jJJFEyV6JyEOtda6JGBunFKKoXA=;
        b=HIiTeTP3zD9IFfCbBZjoiGSrwBpJEh2GD1KaVHCEj5AAlFzwPR1do4C5ORbCwSzNKO
         IlxKF9gewoxLFf+zcK3MzqlFS29cnTLZDpyZUHCPL5IGsf4fag6O0qlXzYLy63kyWpUg
         zfIgyuMpxqYFjtUD6Rq/hcGB+UHbqLJal7sv70MRbT2ftrhizMI1XNvDv8ylEp/DW+2Y
         uHX9xcWXkhHJ3mu8hf2+fOAFfVVAaAWi+c9cHVqB77t4rWWRG+5ggOmZ8OQYrlrlfCje
         Km8GhKQNVd3pEN5QV5zsdTO0yfNEuJWrU5qmAQoehAOP/BcEMF+VC3hoauqvVrQNAtMX
         n1NA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782309125; x=1782913925; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :mail-followup-to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JVKkeSAj9cEIT5s5aHGZfnYhC/Asr1gCUKNdYQVD9Y4=;
        b=njwWQqooCDw3hUkTLZLmDVJjWE5eeoLzIQZoLHahsOWqkjU//awX3K2W4jysMiU5JZ
         aZ9cvIvIqiSAbkve/MVsrXc52T6MlPpnI/qWjloD/Rcyz2zBPcp8h2W3UcyV5o7eo+gu
         ji0sA2eOnaFanCg7z6Zuo9Ie8JeiaKr6X3I9FRzrdaSdT2UNO8nFaXTWYOoGbZWml/9+
         c/8V7lAgQ7XpjSGsnuQ0kStNtRajcSc+xwYyBF82KHj6W4xphgxp+W/zO9Tu0P4KkPHa
         smD6/T/10lNUe0ZG6rU5X2E9ExG/0rXf9hNdqPHUer7hTqTteAEEreTnxbav8eWnKJES
         HUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782309125; x=1782913925;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :mail-followup-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JVKkeSAj9cEIT5s5aHGZfnYhC/Asr1gCUKNdYQVD9Y4=;
        b=l41U9gpMUW1SxlYAiPzzbSxt4NQji5nQVlJMm9Kffahfu4UYcx0yq6owQddq1C3h11
         tMSIYz33hcVHvvd87505QQ7jf8002hM/NdD5y7lvo1hs6nC3NqlZqF6f9x1vq0BrgUZy
         oZd5o1DKJJ63oSPbn0fvYR8N67gvcqg8gNjNiRvKJJJKAImkPIsCPWN23TJe9tk7gbgi
         esLT69klqeKkKAeIMcbNohna6ksbUneLjZkb2sS259NINqpGsdlvRiIsPnielQari0/E
         SqxPJ4MbhcoxDk+3bTQ9ugQcOXje6HwRrxRF9T2BNDc3ybDmxadBMxrZ3TmQEWXuKZHl
         gZYA==
X-Forwarded-Encrypted: i=1; AFNElJ932PCXs9W0cpHXXvjDyD8psNi5XYHlM+58CIiqH2u9ZnR48xD0VvvFkjpA8hA2l+C1iM/G3fYSGYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXpcnYfQHdF8/+EMFkfpwyY31LgwVecStnyqTJ9u3/A1y121EZ
	XzcNXZk/CYdpVxJcntXi2HRv+1+r4dxGZ0RFE8U1HIjv6F6Gt0uSmdefJqD3/OAz7SaFdfHszdP
	sx10mkp+bbgnqXDbeKsgCQh7eQdh0CwaGXEeZQmhtGQ==
X-Gm-Gg: AfdE7cktrdHhxCWzGPoQovLv7xQjGWcvlZE3Rv+caX/Mj9gfqqnjb8ZQc7GmhDbvnvH
	aMQTWoPaycq6vz7yS7EvjchOXQ6C+7hl7DRNdhXO94w78oxoYLUsXmBFWGgq+feSOm+3chp99fY
	VdTMFcIgX5NRZ0CPmygKQh7gOiWPtirpltBByz5TrIurlgvOfjHnzgrnBLVaAFiSyVWAnzSSG7q
	ZkT1SRny9vZIWs+AMstch3C0NeO9lrYA/28fKL61kmpwRix63b8WRi2dQeEcOZAHfeQUp25dAwa
	2WpsBFlrZ8jopudhzixZdmLB3Q==
X-Received: by 2002:a17:907:60c9:b0:bfe:ed06:5a14 with SMTP id
 a640c23a62f3a-c119f6123b6mr182955966b.50.1782309124805; Wed, 24 Jun 2026
 06:52:04 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Jun 2026 06:52:03 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Jun 2026 06:52:03 -0700
From: Angelo Dureghello <adureghello@baylibre.com>
Mail-Followup-To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Angelo Dureghello <adureghello@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
References: <20260618-wip-stmark2-dac-v6-0-48761dbb96d7@baylibre.com> <ajr4LvdPZKHrqDVp@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ajr4LvdPZKHrqDVp@ashevche-desk.local>
Date: Wed, 24 Jun 2026 06:52:03 -0700
X-Gm-Features: AVVi8Ce0Oz4uWAyICirL9pSge-M3xWIHMYk0X2M6seIbhH3jA-_W8vl1mqu01X8
Message-ID: <CALSJ-wAFwYC38X0VUYYBX_AYsWChpFxDQtQ52KHhbFV2Bm=prg@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] add mcf54415 DAC driver
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Angelo Dureghello <adureghello@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi Andy,
On Wed, Jun 24, 2026 at 12:18:38AM +0300, Andy Shevchenko wrote:
> On Thu, Jun 18, 2026 at 11:04:14PM +0200, Angelo Dureghello wrote:
> > This patchset adds a minimalistic DAC driver for the NXP mcf54415/6/7/8
> > builtin DACs.
> >
> > Currently the driver enables the raw write only. Feature as dma, sync, or
> > format are not supoprted for this version.
> >
> > Additional options suppoerted by the DAC module will be added to the driver
> > later on, as needed.
> >
> > The same patchset prepares the m68k/coldfire architecture to support
> > the driver.
> >
> > Below some basic tests done on stmark2 mcf54415-based board, voltage check
> > on DAC0 and DAC1:
> >
> > ~ # cd /sys/bus/iio/devices/iio:device0/
> > /sys/bus/iio/devices/iio:device0 # ls
> > name               out_voltage_scale  uevent
> > out_voltage_raw    subsystem
> > /sys/bus/iio/devices/iio:device0 # cat name
> > mcf54415
> > /sys/bus/iio/devices/iio:device0 # echo 4095 > out_voltage_raw
> > /sys/bus/iio/devices/iio:device0 # echo 2048 > out_voltage_raw
> > /sys/bus/iio/devices/iio:device0 # echo 4096 > out_voltage_raw
> > sh: write error: Invalid argument
> > /sys/bus/iio/devices/iio:device0 # cat out_voltage_raw
> > 2048
> > /sys/bus/iio/devices/iio:device0 #
> >
> > Same behavior for /sys/bus/iio/devices/iio:device1.
> >
> > Generated a sine wave by shell script, sine shape is good.
>
> Heard a presentation (Embedded Recipes IIRC) where one tried sine and real
> sound (it was about sound DAC) was really awful. So, Can you try a bit more
> sophisticated signal?
>

sure can try some sound with this 12-bit, but don't think is possible now
with only raw output. My idea is with further patches, once ColdFire DMA
is fixed, to extend the driver and be able to sample higher frequencies.

> --
> With Best Regards,
> Andy Shevchenko
>
>
Regards,
angelo
