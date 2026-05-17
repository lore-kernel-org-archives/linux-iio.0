Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B573254A5
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 19:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779045729; cv=none; b=UNF/2niP+vKFFtlRMZ01GZmICTMRLhG21SUNZKzrtPK/fpYI37aeXPNT9d5JMucp2vL9Vfofxd9LG8vFVHs6BQGoioE0yHfRa8Ma0BQleBgOLX7UQpADB7GSFuZ4uSsq8Zqs17RgG5TLc3e5FsZQ9ksyeNDh5X66lbJtGdPHtQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779045729; c=relaxed/simple;
	bh=6F4HRBnD1ijw9LojF5iljzN3VgqrvJ5ysiNE+lXRJWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jLtdkc/oFlq930/misTF3iCj9RVcIp6Qus4UPe37qrc5l3KWfQhRrq8wlSoMb1u4NRh9mHMMa/RaJaq0Y9njFD38hsTabG68/WJCRMQ38pRPh6PRsyUMN2DreLnnUsxrOtncdqj4eEL8Lqne+3YCp/ub0HtcB8+MM2DEkFYpEPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=iocBRHyq; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="iocBRHyq"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7de7c57b52cso1562298a34.3
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 12:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1779045726; x=1779650526; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t8oeugrZbzajef/1vQAam9ttn87tFGEQi6JKVNWh+g0=;
        b=iocBRHyqpDjJsX6VFYSTVFE2rR207Lw2d9ok8NkEfnXyF6dSLo0iOgwy7bZusWOmz3
         x+3FSd6gOGvOgbG6vatDZoZ/cFOY9jGvn+6S6nl04z0FOHmx5LD88t+9kvQ9jOVdRbUD
         DRlWJTO+PB1ihFLCKYe13qZp1Nj8EkOaIgqgwZt7NGZbTgTrPg72s8ZMgf5f9N5xq34g
         zodUSTJuqyoso5aXJEcMtCzfO6KGcJip7dqIrkcyv5SfRROEJ+LFpY4xt1l9hnfKwyrc
         HZW2s6aYGnS6IuHbBPkSqf9EvJAeTTtPMWjnw8TgMdSeAATBGEZ9Cufjxjq2L5SietFb
         n/QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779045726; x=1779650526;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t8oeugrZbzajef/1vQAam9ttn87tFGEQi6JKVNWh+g0=;
        b=i2XLXZD9jJwJ3H6GRKUrxCtqsuSr8WTluiOcHCz/NR7LsUMw55hZDyf1bpDeUWZTEl
         dhLPV64D9/OWE2cRhtn+XFZFcuZZC5wRrk1qbYofH7eN78C7bZwLRjn/tksd4RMDYmMf
         UuM1kDzm2ljJr1lVS89UY2E5kVv2RemOxcXVp2mXrFLnc/zz6BhXut0Ml9cZ1Z1Yd5oB
         ZkFwEI1LL/qy5CRSlDmKh6VvNV7uWGOxyFoQ9ZKAlw4eBGen58kU7zhU+28Pv390LcxX
         YyAtlKZvF1fx9anmbC6GK0H9IFT3B6MgF0w+48iJljNTB+BgsolojA7W0PzOTy3jSdUl
         BE6Q==
X-Gm-Message-State: AOJu0YyqBenDDbsm6vQr7xtH2NnWKnKlcrzxt3v340giypfG1tU/qeIQ
	Lof+BNBVP5M1M/lg/ld5gHGcwz/U7zKnTQd6f0EPPEIwBJMj9BNzV1seRmNySaFh/Ak=
X-Gm-Gg: Acq92OG8+jzBoh3J5nfCpDFSBAuAxnFsHFKLHtWO59doOElrj/KLgixltDnFFAyUfvt
	uYVA9hUl9jGaI6Us9Ns3LOXkXvbWTMCzXIy3njB5HWxU/fVOT7vweVYcTr536durcztP9FylUME
	T5idFF6ZlZ5Gs746n3/8BMQrOWshTrKUSOjWfeiUFMnXr7a4e5QWpsC+/GxXWnvvy/yImuf0vv7
	K69ZzrdpZDp6SBb5mvPLjgc9eTwr64cFnDXF1yfY4CrrKtHSgvzXQiR+tKLG+PkoYD2ldW2cIQX
	pwc7s0FbJ1WaAJ7feETHfkT3693tDY79SKm2hN/7bMCpNbNQxga1pT0Xfh6gcvNj59yyc3SfbN4
	MeUe4sbcBqc9AzAhrkVb5BUwbREGeR0Rea+IIO+eZkvNVfDIIP97CAgdS8nmx6as9BRJa2OT1ST
	FPdqGKK4NN3NfW+rTxeSNiVaBqQ49JqZm9CdkdM+zuk8LiMRWk2ZfAWxKD7t7LtKReRXkuUapAc
	Jm17+LTcg==
X-Received: by 2002:a05:6830:628a:b0:7e3:d199:3164 with SMTP id 46e09a7af769-7e4f2aa4df0mr8632934a34.11.1779045726420;
        Sun, 17 May 2026 12:22:06 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:7a4b:ddf0:f61:f58d? ([2600:8803:e7e4:500:7a4b:ddf0:f61:f58d])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e55bbd10aesm6121272a34.18.2026.05.17.12.22.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 May 2026 12:22:04 -0700 (PDT)
Message-ID: <83c11e2c-9688-4cc9-b7ee-6380de30fb58@baylibre.com>
Date: Sun, 17 May 2026 14:22:03 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] iio: timestamp declaration cleanup
To: Jyoti Bhayana <jbhayana@google.com>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, chrome-platform@lists.linux.dev
References: <20260517-iio-timestamp-cleanup-v1-0-61fb908c11c7@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260517-iio-timestamp-cleanup-v1-0-61fb908c11c7@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/17/26 1:17 PM, David Lechner wrote:
> While looking around the code, I noticed that there are a lot of places
> were we are manually filling all of the fields of an IIO timestamp.
> 
> This is error-prone (as seen in the first patch) and more verbose than
> it needs to be.
> 
> I went with the approach of using the existing IIO_CHAN_SOFT_TIMESTAMP()
> macro for doing a struct assignment. This does require a cast, which
> makes it a bit more verbose, but we were already doing that in to
> drivers, so I went with it anyway.
> 
> If we want to consider alternatives, we could make a iio helper function
> or macro like the first and second patches did.
> 
I should have looked harder for existing alternatives. Just found one
more that avoids the cast via a local variable (in ad4170-4.c):

	/* Add timestamp channel */
	struct iio_chan_spec ts_chan = IIO_CHAN_SOFT_TIMESTAMP(chan_num);

	st->chans[chan_num] = ts_chan;

And similar code is found in ad7192.c.

