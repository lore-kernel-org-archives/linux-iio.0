Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFF440926D
	for <linux-iio@vger.kernel.org>; Tue, 21 Jul 2026 23:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784676243; cv=none; b=Sw4o4cQ65yuLLck/aEh2IfAOcPNRUhTUsDXQj3Qj2T1WsSP/oVWoacASyrRmNfPX8ZCeecwszrqNuJbSBoySED4talS0oY0CTBCfoJFPW93WDkBWiPVxDv/2uw0DlHpXJb8+GiWxPwQ9MI9N6Exf3Aw7VYNERPvGmIkp2lCmwx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784676243; c=relaxed/simple;
	bh=XgWv11L6ip6CFyx+2u/2peTCfH6NhDzHxMu5oVNsPk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JOMoTvIYU1DUIHoolbPYZsG3yPWdQJxKxoA9NhTU9FL2onOb3jrvy6S+cNbNMJBk/pQwFAol/SkBpOfEFxe0yrX0CNNbzGKjy3gffrIX1BofjuwUkQlgrZzThHA4vUGFAz2Ct8G1UEkElcO3mYCORyM8lncomQrRKtZGF4jLbn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=jqLkdC9r; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="jqLkdC9r"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7eb5bdb50fcso4305957a34.1
        for <linux-iio@vger.kernel.org>; Tue, 21 Jul 2026 16:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784676240; x=1785281040; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sW7gZsjVgkA7TTzDHIw0bfDxx463hW8am2oGgWYtPWQ=;
        b=jqLkdC9rW0b8M0CVzrL+K8rOKaHgRhbyeWczcXrSTQ2zv7+uMGj4HefTJqcy7VVEHn
         xTLOYqZY6cXTwdOcug17qyss2xxm+aNgaIFNOBNnVY3d32pZowr6te0lGfvyGBW+XhYI
         CRqrLOLkF+YqIB/7U2AyVV43AI7AKiHxziX+xXkoIaeD9VbSebvclS8v8eHisdPPnlnw
         wdpUVhiN7JXwn0RT/gcfS5weV3wW4R3vp9mHTp0/jxuR/0s1U2cKZvs/tgfC5O60L+W9
         xr2WEYqEtfUYev61/VaIB9I1A5U4mC9Vayt1YWDWJZnG7ffaY1XSqsmI9hz19JBebMDG
         xnqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784676240; x=1785281040;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sW7gZsjVgkA7TTzDHIw0bfDxx463hW8am2oGgWYtPWQ=;
        b=ixPCEzv99PCSgE0aaUG/bqi9VY5SaFLhmvObYs7njQiaqOV3+wAmHAZ3iK76IvN6SI
         MLSiZcRNS/Exo9csnBpgY+UCNXpT5SveiKo7juHURtja17STIcha3gQCMk+zhkGxZElU
         NRYKzFaDKkdpa6r0ujhiIqjCEQ5JN6BxBVSoK9rokn3mv0WKiJju8BkdPsMxADJ2RnZ2
         /aPop1sy10EoVcsxpbUZMAXkzyzNYc5dix52PVop3r/SKwAwMqyqUgG8DjyfWqDpK9tL
         4QCPL7tsipBUpRGML+gApDt2RynvgKSUlgFbn1+NOguAJoVuGsB9AR7qsPpYYBTrXBVq
         DjMg==
X-Forwarded-Encrypted: i=1; AHgh+RoPpKzrmla8hfcUXAlmYXzr5c2rE2+E0WSoW2R72YlI1kJ7gsNRH00L85XK7V7KZOeqjYqWmCxbDSs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf2TkoVz0u6wjDQQij0QgAWABIsXMVK5zt/tMTSFw7YdHw6FjQ
	Tbc89D/EBoBluiau6dZDO+y2Y51d9N7m4caACYH3CZBKJ8GUudvm09Xh+1FV3YO99YA=
X-Gm-Gg: AfdE7ckWdpslgd16VKo1LXmXJP4uycn2+Q9s9Nkl5IAmS93a7Z0f0LU+zB1WhypK5Py
	Q2vhj8RtgD/dseVA9FHg8d6zi64MKFKzCOONO0bMu2foJLyzHkbcRfV0OK36V4iygM5fMbi9PB/
	s8M0W9tl9qKdscwMC0NPJYtphkwL6kzFgDDGMEzQiIYVymBAD7KrPQNiku5OQQKdcyZYm3X0yNC
	qrVNiqaKWkSa1cco+i+FvAdRGXSTa/kkFsaxIyRJ/Ohp8kNL2WZzG8bk35Yeh2dXwziKJlWwVRd
	NM5ASZ9FHyrS78YcCruzwKP6T0aA1FjmPlSzM8odidPzlGdqRi+njbr0oVUpa5yegDIv9oGl+uO
	mdyNJbt5GS3l18LNQOqcZnOJ6v6XAW9M36at311g2huZdV4mAAB1psrk0WnoLKOO6JCdMeuyqBb
	hgswnoGEDmoLcmnsIlQVsWggP+OXOGqstpMpsliTl9FMj6B1PsVy2jo6Gl/8JC
X-Received: by 2002:a05:6830:6602:b0:7df:5fc:3fd5 with SMTP id 46e09a7af769-7ed9a7d4360mr11441486a34.1.1784676239979;
        Tue, 21 Jul 2026 16:23:59 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:d067:7d1:556a:2be5? ([2600:8803:e7e4:500:d067:7d1:556a:2be5])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ee2a0b3ee5sm127926a34.24.2026.07.21.16.23.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 16:23:59 -0700 (PDT)
Message-ID: <7a600363-ae61-48db-a0a2-34b9a4919b6d@baylibre.com>
Date: Tue, 21 Jul 2026 18:23:58 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] iio: adc: ti-ads112c14: add support for buffered read
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Chris Hall <c-hall@ti.com>,
 Patrick Edwards <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>,
 Nguyen Minh Tien <zizuzacker@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260714-iio-adc-ti-ads112c14-buffered-read-v1-0-fe6e1c971288@baylibre.com>
 <20260714-iio-adc-ti-ads112c14-buffered-read-v1-3-fe6e1c971288@baylibre.com>
 <20260720015527.0ccc543d@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260720015527.0ccc543d@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/19/26 7:55 PM, Jonathan Cameron wrote:
> On Tue, 14 Jul 2026 19:19:32 -0500
> "David Lechner (TI)" <dlechner@baylibre.com> wrote:
> 
>> Add support for buffered reads using a triggered buffer.
>>
>> The device has a continuous conversion mode, but that can only be used
>> with one channel at a time since there is nothing like a sequencer to
>> support that in hardware. Instead, we use single-shot reads like we do
>> for direct reads to be able to read multiple channels.
>>
>> Support for continuous conversion mode could be added in the future if
>> needed via a 2nd buffer.
> 
> How about enabling that if only one channel is requested?  I vaguely recall
> us doing that for another driver (though I might be dreaming :)  I did
> see your comment in the cover letter about it affecting timing and that
> making life complex.  Fine to leave considering this for another day
> but maybe don't suggest a particular solution here.
> 
Actually, my latest thought it to do it by trigger type. This chip has
a DRDY interrupt that can be used as the trigger for the continuous
conversion mode but we need some software trigger to the single-shot
mode. It think this would take care of the timing issues as well.

The logic would be that if the self trigger (DRDY) is selected in
the trigger/current_trigger attribute, then buffered read will use
continuous mode and fail if more than one channel is enabled. If
another (software) trigger is enabled, then use single-shot mode
and allow multiple channels.

The timing issue is that (or will be since I haven't sent the relevant
patches yet) there is a settling delay before the first sample. For
single-shot mode, every sample is considered the first sample (because
it is "single"), so the chip applies this settling time on every sample.
So it might be good enough to just document that as a quirk of software
triggers for this particular chip since they would be using single-shot
mode?

