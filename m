Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792661032;
	b=yckk5gLIBr8esoQjhD+ZvzjEJjrjp/e93kwZWtSRLiotpyXIN2wuimcu3PFAPOM6GhoG
	 /sqWfPqFM713VMMDuq/RtzgyuC+kWMCb4CdlP6PKmVuVXKf6h/CIKY7YuSOih0JFAMFYV
	 TEXkIUPJ+nBgAdyiEk/4fvBpV4FUrX8wtg77mYYvR0cJcBoiWliFA9EKKFPPzKQXrBtD6
	 nSkKLYpk1uAtYIh2T9MrjzClPm5qwTGQzd7sV2zzj3fK6eSyLwy7Tkf+/bEfxWOc89Ebl
	 Xn1I2bdHjDYOogiLAMkydoRUHnWDwWfWijz1k7Z4TXK46GuwV9ts9SHLz7n1heMkVTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792661032;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=gkhBBRoKjdMjfG0Ulhfds5pPtjNKOakoMGJLQPu1F7U=;
	b=TOU0E3qnpUrVb5ku4K7zyVUU8ZfCkStByTvHzvH4/IQQvM93ggfusNNlSxOoA47OQxxq
	 V124n7StS6dg7bRTObYRrQloPxBry0/YA7snWuNFcTGQPnyWqO2I0iB42MfOt+JiVJLkp
	 Pch0Pv3cDD0u3PAJEE2bY0U0X1c35vDyGzXA1j3Bfgx4mbHGHekp2kVM9qoYvrYy8/FMm
	 LeH3NEnV/scRl68PH9j1Js3tAJUN2bOiEmOr/vUP/R93h/vUktedg/zHlKVt47kpVPVCq
	 CDD0klCt93o8C85ciY+3+uqJCs2XAs+hussu6qzBZiOjYAzM4V1jorlcYwtWHH9eHdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.171
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827F9606A31B
	for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 09:23:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 827F9606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5eaa5e03c47so606263e0c.0
        for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 02:23:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792661031; x=1793265831;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gkhBBRoKjdMjfG0Ulhfds5pPtjNKOakoMGJLQPu1F7U=;
        b=DU3lrnElgv6V1ljS4RVS1Vtoa/zB0xIX5V+xq1vE3NWu250FoRk78e5xLP92xWARPO
         vraHvYLLJsT27KBZDoSojmXzlfve/LMPvj54NBTE1QkmHGvGjp+43xIPeu1fSomv4nmo
         pgr60VwcRYH9ukchFMC7eCohgCnhW8lkylCQpQo6nrdpBKgSo/obSB1hVxI/7PjYOz/s
         xw7BX1fAeNXDmZHvJk+JuNcph9L3e2HeplW2GxoTvehhBNAsrGVW9ID/noQ+AgZW2VUO
         phQ6WNe/hSxicM3dnXAYyevyZq5WhhplhiZug255TsmSiC0AVDITbtPOe8bOXQYS8jiV
         St6Q==
X-Forwarded-Encrypted: i=1; AKwUvBz+LsiNl6vkWXILPGcPiQtEs0OE/kzWnLfdAxmJutCrL3xcosZu4vXGGA4ye4GWQk4RHEKYEhTVZkw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIhjw5g8E/S82o2pxaZUNRTp4zPme1bw9Jp3nuLBygOmW4B1isX
	X8nVhBYkH8mYfiAdGQv7LQKVE34pLz6AIkaYmKJlvVCPtQhcFUzfCiSMgKzn3nIE
X-Gm-Gg: AYBFou3J1+B4SwPKYaGMA6Ie+pjvpyU8R9+zgN3x6+8C4iB3fFC2yjMrBlBUJWML1J7
	dVdO/6FRvqODsNRH9lxtQvsIUAU8kUYG5/R9KxDH94f2wU++gEV0jZYu4k2T62L1WYr9wRJTdVc
	pJc//FC4wQCUH1OhVEtzELHsR64LxirkYGojEAQXBzLerEApwpv7dCU+qmZeD+35h97TiDY6YpG
	wj87Dlgv4+6yClGPOGOnsoZmA0dnrUYhjCpY6I/pJf7o97kMJpCGWVM9bcHvnq37pneg8vnQMzy
	JnuOTPnV/rIJpWMnfdgXoMRMS145/uZtS/cFC2T3CAIDxxhK/xJu9IrFIxsOctmRVSfCFCqcHLm
	daJlHraxIAXGvJv7omz99rY9KGgkWhbzalgXSsN+e+x5iizo0ZgTZqnGsz0FDwpyjvEStGN43ba
	vR8DrLGNayAzOhcmlfCTVVa8gUYd9Wfz6CwU0H4aLysucZqw3CK+/KBkoVrzaJn2Bw25s8TYPnt
	nmAwofGsfJAXTSmI2340EkX+NMfS722CB8urhWTD4XbwS7ZDey8uSN/yFJh2lnoXQAqt7i8GyZ7
	Kf3hm4T0j+DkNyQN6Q==
X-Received: by 2002:a05:6102:6054:b0:7ca:8f2d:5c29 with SMTP id ada2fe7eead31-7cca9b1ce25mr403733137.27.1792661031456;
        Thu, 22 Oct 2026 02:23:51 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cc9237bbf7sm5619454137.6.2026.10.22.02.23.50
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 02:23:50 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-78fb1fb9508so566197137.1
        for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 02:23:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzLM+OkcjSvbSJtRljz6u7tpH3EBkKi8UR26SPeLuB7qomy9qpf5yNEhs7yn4ieUPJhY5ejOyYfLSY=@vger.kernel.org
X-Received: by 2002:a05:6102:5093:b0:7b1:3ecd:3d8d with SMTP id
 ada2fe7eead31-7cca9a1a007mr483763137.7.1792661030261; Thu, 22 Oct 2026
 02:23:50 -0700 (PDT)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021235818.3059519-1-briannorris@chromium.org> <20261021165858.v2.6.Ia4649c7263a5733426a8778ac4b2dc459f3ffef6@changeid>
In-Reply-To: <20261021165858.v2.6.Ia4649c7263a5733426a8778ac4b2dc459f3ffef6@changeid>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 22 Oct 2026 11:23:38 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWNuVOnn9KwYuRm5TYsMEf362V_4fSwQGp3fOfR_i7jkg@mail.gmail.com>
X-Gm-Features: AclHuK9DeixcMDu5pJYEJIO6mwWZklXvy1cHSqlxPpUgEBM8a99XYlxTEG_tKGQ
Message-ID: <CAMuHMdWNuVOnn9KwYuRm5TYsMEf362V_4fSwQGp3fOfR_i7jkg@mail.gmail.com>
Subject: Re: [PATCH v2 06/17] iio: adc: rcar-gyroadc: Discard
 pm_runtime_put_autosuspend() return values
To: Brian Norris <briannorris@chromium.org>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulfh@kernel.org>, linux-pm@vger.kernel.org, 
	Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Oct 2026 at 02:01, Brian Norris <briannorris@chromium.org> wrote:
> This driver propagates the return value of pm_runtime_put_autosuspend(),
> which is not particularly useful.
>
> Returning an error code from pm_runtime_put_autosuspend() merely means
> that it has not queued up a timer or work item to check whether or not
> the device can be suspended and there are many perfectly valid
> situations in which that can happen, like after writing "on" to the
> device's runtime PM "control" attribute in sysfs for one example.
>
> For this reason, modify this driver to simply discard the
> pm_runtime_put_autosuspend() return value.
>
> This will facilitate a planned change of the
> pm_runtime_put_autosuspend() return type to void in the future, similar
> to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
> type to void").
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
