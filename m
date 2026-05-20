Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FB734E762
	for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 07:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779264000; cv=pass; b=jrwbqLL8rNbOO+mQuIAxRIBitLbiN7GfHTI6gSEwfmO3ctmflT/fmJ3uuqtupXFLVrCGC1qFGFIT403SgzQ8dqCDVsZTcEjz4NK2jaIM4LfX+AXdJ5hFjOWgnLIwd+nxTxIRNhHEAsoyDfooNBExf3i43eWwYwfxWRX9SMoHiHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779264000; c=relaxed/simple;
	bh=gLKkvrPd8WDYkNr6zpplE+sWuXbgiUo9qWP2bGP6r8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IDmKGhl22PpS8kSC9U2lTBlOHPCB5bcwN+jyW/g1ebtbRbc3TLIt2QRPUQd7Oicr3yYI5stbYAR5S8DCu6BxmWuwrD3lucW+Geuye6a3jRvkBzMQNM4v3RtV9aLC5EkHxfPvb4OT28qPgtgJW26qggU0OuFUTGqc/SiF4QJSLck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ly7TAbPu; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ly7TAbPu"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso38824645e9.2
        for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 00:59:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779263997; cv=none;
        d=google.com; s=arc-20240605;
        b=MExgs8O69ZuKpirHwukOd+tXV4/AsvX+fN4daRslN6qIIqQFrWNaeD5S6o0ckir8l/
         hQgLWObSazTe0FXnCXSfqLxFCyDoVJiUbjhrKpMOnCTs82LbSKcakXBLYfIYlABf5KCY
         ykQuAuA5cCP385cVTh6rMOaprU6wckwi0pqNfQdqAwko5U6boPC1s/2yYKgPf8Tpi15O
         7rZ0gXmrcbYtybQO3Ynm8jSYjTnGv5kz9RCEky+WLW9PPpqxaJunDqwiIBAA9k1WZz48
         3wsvKmA0zXqHw3DEpZ0iLIlUqV9erMCQdvox9bQTyg8PpvNdN945bw8romcDAfc3Fih2
         Uq8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cq71RQNyMI8AmBA0uR0b6qzFKcn3nBaBWfVomG/2ktY=;
        fh=WMgJekq7Nf07wIbwh68eUec/6Fg9jSKpvzYD+Hacg8c=;
        b=TgcpypYhKwnQ3VXHXN7C+IQMhX6x6ggfdj5zvJlwlNb3jHdugJSJWJ42sIHTzT1lqQ
         l5sY8zb3k7MYOpe33iEVLsBl+uZiXhuMcvuT8HvDPSCuXtjs/Q/9vvuCwppi0MDtkMTZ
         MQsXP01yOxDep0HvTjnifeWyphxxxhZSG0pHDYc89BBAVqStGaqvmXq0Y+PjRciazeGY
         bGUTqiD5bOEA4NWYxU8K4tNie3VgmxTng0u99Ehsj52fHO8oLTt1mXTQwi4BfdPcE6HU
         nUfbZKJ6Ek9koevubAjV3sPj6VzF5ZiqWNfItIWch9B+bJsE3Kj5H81W+2WbhOO8mjtf
         khew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779263997; x=1779868797; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cq71RQNyMI8AmBA0uR0b6qzFKcn3nBaBWfVomG/2ktY=;
        b=ly7TAbPuBpNzLPRQPds2DWtxUOqHHYCTGYWPyHYA6DwEdru5jbY5D/6CRkS8Wu2WTY
         OLY+vFyDtIsMtj1FVA+0PYnW8NwBiMHIibsBAqwT92eIpeXD7hq5v6gThg8QkcExDvnk
         1WU7Znfrz6Rged1vCY77F4ORfBmeL3FmTtgPmwFirKj9WMBjsMLc08RTuZhoqmdF6mfL
         7lDA9F8Nr+34x0RaER9n1yh7mKL3Aqi9JFpl/IYgWterZbvEm/YHugNo8D0Dwk6idX2h
         OzQL4nb6nLkuczYe9LmW0vuteIg61PMdEIXXP2Q0D1ETCKszotZ+xVQTY6fMBZspdnOP
         BGBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779263997; x=1779868797;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cq71RQNyMI8AmBA0uR0b6qzFKcn3nBaBWfVomG/2ktY=;
        b=d9qvPszg+4fe0iq8gSuKO76uug394Je9FW7rg7WMMmhQX20JWRbGX+sPbFikqXTNQx
         5APgdbBtr3Yx7p9fp8twPEfp93Qjw23tWwZ+vYySg226GYhCthWkNv7agLMg2vMCbFKc
         1j4+DBLWIMTj9mJl7wFiO9mNmbCGRlyv3hM3mNw0TdXlFVDJ6Xh1OKip/10FPhtiFLCW
         jhu5mIOjnDkxFX8XExxukz+89K7/KzZ9KZRw16+E+FpaXPV5yycUWvmqHu1HY5QYppdI
         se8Hmo46qFtq6GbNFuv8RRHiRffPSnBbzVzRlLRlw/YUq9YZWyzIipdMsLlII6srFhO9
         4K7g==
X-Forwarded-Encrypted: i=1; AFNElJ8bPVQ0sM8VtjE3mabOdTP7CcKFwr3kW2bcWn85V/bPOdihZsZpCuObbccleTKOc3/QOZmsyhv5Qn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YypFVmRFVlFRo3gr+kb92Lm+U98Y5wkzr1wd64zxiX9RkKQ13vO
	x0EvzS8xWm6To6xqYh9zSAcn/Dd5ZHbEVTIbbLXersFs4bN0Embk9CJmglRAtYbbVxMInPFuShW
	Kh/X9dLcu9gy61YPm7jYCRY4/zeLxNxE=
X-Gm-Gg: Acq92OHv5nTtHAAfswbK++kS2IJjzRUbVfRrx2VnBWJifwjQLjz3trVWjLnTq4avCpv
	juEoFY53qrz9Yz81fqYIzOpNvorKVt2yjw8Eqjd1Cs62td+h/vI5sigICGivuYFc3XJmvr6zvL5
	Pfdhxn5ARmRGCfv4BSqu6CnCMUgs49lGvItKqgTuJO93EYLvYWdUqEbQnk50T3KymJoFwaaIpTL
	tqvd7MrUA9MyDvBxQoGyEdlfLVY5LH4Yx3psCVLM5Zzj/LRuZ9iUJ3bRwQnqAcpmGoTekZtTIr+
	/cZimSds7vv6zpcWrKF4je/gtPh4+ZK94VZnKQAKVVoQAKvpV6jOwLpMdEigYzoUpmUwA0VKRiU
	Z848Rew/ftOeqjYdf87mtj1LgWBEeOpbyadKOT4K7r2pV+NNtzzt+hslOdxeMdEDYcBpe+fakBQ
	PmgMNZOSURQTf9ucFG
X-Received: by 2002:a05:600c:314f:b0:490:389:7644 with SMTP id
 5b1f17b1804b1-49006db5bc0mr216098075e9.17.1779263997315; Wed, 20 May 2026
 00:59:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520072843.3593-1-kimjinseob88@gmail.com> <20260520072843.3593-4-kimjinseob88@gmail.com>
In-Reply-To: <20260520072843.3593-4-kimjinseob88@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 20 May 2026 09:59:46 +0200
X-Gm-Features: AVHnY4LibJ-k84UCcgSiKOiq_SKlPJItvh7cn6hdkPZpeTaScSKdQ7TTMwmqIoE
Message-ID: <CALoEA-xOGAGb=-uXBv+Q2QC=viPCGUESGZw=rfoBHdEJFCkEAQ@mail.gmail.com>
Subject: Re: [PATCH RFC 3/3] MAINTAINERS: add Open Sensor Fusion IIO driver entry
To: Jinseob Kim <kimjinseob88@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 May 2026 at 09:35, Jinseob Kim <kimjinseob88@gmail.com> wrote:
>
> Add a maintainer entry for the Open Sensor Fusion IIO driver and binding.
>
> The driver path reflects the current RFC layout. It may need to be adjusted
> after review if the driver moves under a different IIO directory.
>
> Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c2c6d7927..001ba4ea6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20011,6 +20011,13 @@ F:     Documentation/devicetree/
>  F:     arch/*/boot/dts/
>  F:     include/dt-bindings/
>
> +OPEN SENSOR FUSION IIO DRIVER
> +M:     Jinseob Kim <kimjinseob88@gmail.com>
> +L:     linux-iio@vger.kernel.org
> +S:     Maintained
> +F:     Documentation/devicetree/bindings/iio/imu/opensensorfusion,osf-uart.yaml

All of the above should be added in your dt-bindings patch. If you're
adding a new file,
it's expected for you to also add a new entry in MAINTAINERS in the same patch,
otherwise it creates confusion and an unnecessary additional patch that the
maintainer could overlook (highly unlikely, but could happen).

> +F:     drivers/iio/opensensorfusion/

And this line would be added in the actual driver patch.

-- 
Kind regards

CJD
