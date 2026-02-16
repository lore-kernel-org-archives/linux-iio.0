Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23B832A3C8
	for <linux-iio@vger.kernel.org>; Mon, 16 Feb 2026 15:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771255562; cv=none; b=rNO0bGQ3qgW0ytBrWHyoCTE8VUV7zKZwaS/1wJ3xwwoHmqIR2cOhqSmefnpa+AxBhBdNDq7MUAI79M0yuurYeIEXyirGqotUknL5ERu2AL9gEA3k8y7EHB3Xd8CpWGqNFFrYawmy2CnH26pEVg7vl8E0xPr/HHt3Q41buNpxyNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771255562; c=relaxed/simple;
	bh=s/u9a7RFxBkreXqZx0ZwHqcPArovGyAc5UL+kxKtdg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P0YAarXEgh4JSbkzLxHzv3LFBp0OFDB3eFLXimJvSp/T0+cMZGaLoZmQ+pIPZzPJZAOGG0dBiX8cnPV0w29XDjViZcuitngW1FIFAmvwpxWGzAWAbasFfVmGaRMeuOf7pVL50H4MWCHDJ5ot6EhtAxSYWENpznrgKiI+EsN6IHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PpW5tVCi; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PpW5tVCi"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-45f194e9a98so893342b6e.3
        for <linux-iio@vger.kernel.org>; Mon, 16 Feb 2026 07:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771255560; x=1771860360; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WDY1pgwN95gNKwiq9tVCFy3TSoHft79BSNGMSnMpMmY=;
        b=PpW5tVCicIKPqMAOlJwMhEr1fYa2vvWqmJy57HILg5XA9v6Wk+lEjJ91+YfohWAxN2
         X7da4y74D2oov7MaxOm32ntYHnvMZp0MMszj5MmTrmQ5Cv5k/HdQBjuJ13rdr59GRkAX
         DtoUCqzikSMmSdOuok2h8tFgtFS7qsrt/ETz3ehY3lrf1HXUag9EqM4QNrMQaTwSpoSo
         Fs5tRGapW5Jgl+YdGNihNhlfJZ304fgV9XsrzBkz/8nYVBx2GI78c3VfCoPrVqkf8CBG
         TiOlmze9rUSgCa5MwzuDFTJHE77dgXUoJa1BnDKXnD2snWTPNynE9CpcaLIr1N6TIDlA
         3xVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771255560; x=1771860360;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WDY1pgwN95gNKwiq9tVCFy3TSoHft79BSNGMSnMpMmY=;
        b=uSUo3v6EmFWfAu4o9abxOFkDYIFJTDXItpnS4jN+xARr9D3VDrpNkRldloyFtm3HiW
         8ih3mkg93mB1VXI22zdsEAIY+kyCkeFoJb82sa/Fel3O2SCqx3xuaYtdFS782SUx+Uol
         R2LNLJMSSNdwmTO4nTAJ8D8VB+kfDpCIs3WOban0wTt5WgdBJ6A1ffGxqL8ZbbCN/gKU
         KeXAaMGYOrbIDEkz4oK2vBvV5XEQuyrjh43Bsx3iecwAXkyM2QkhGvP/B7KzqV/AvSv8
         4IbLNzkFqlAeQpjL3qKJ919thEKOg2WQ/XQSEJxy98gYOuWZwVuJm5ck0Vod7m2HY+xa
         1xsg==
X-Forwarded-Encrypted: i=1; AJvYcCXBcSiYlQmeUrawrNOn0TN7VF3YoglZs/7idrEU593qx7W37as5nKvtDxb60BhVGZ4eNWuDeNyJsk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBxZ0bz3/DvbpwDTbMbdtDQxfaPJhjfB2YaXHSSG9xvsMUWbZ/
	65+8NJ576eceTpvRMoL1DK+MjtZbvxKUHykdMRb5lZF3a8U0EtrMdTCItVoYfUlU9ZU=
X-Gm-Gg: AZuq6aIP43Tsrv3M4P4Cwmt4UIzqGfP9vcGt9bismT01fBJpSjiRiQrw4mT4Plw75Hs
	vW+m4b5yJ8rtDJkBsH5KkV2EykHODwOuImaLtQJGreuowM6PcACfgsUzSUwvP9rjqOM1pGAFDO6
	yEaAqyHqKuBkRWK0+5HqOqnY4KL2qqCKZE4mvN+HubRicR837FY4srY/22WP3TT7cx+wUR/1j6i
	Om0crnHvCwmvAHkIcD5/yDi6Sk5GE5Dn+HiGnozcbUfTe9M/qGgNyvhRQ98e934pJr92CQdChoJ
	NQ56MuamOlVr90cugoS8HK545vfH3JOluQOy7myK5bgtYDXkkBNABx/2dCfERgc4+/XSiTxPUSy
	fuPmfxnFWfRNODpau4XSN1Ga9NMGQZ+SE8GFfXfhI40dohmJSx7l+iwD4XSMgjdjSXyD410dKad
	6Bk0cCpvm+lanTD69oPi3Xl88i3H0QACOi5Kp52s+fC5xZCnuNDDi1Gg22X27KRIH8JzO/IIi4
X-Received: by 2002:a05:6808:c29b:b0:45e:e07c:3fd8 with SMTP id 5614622812f47-4639f1bd0cdmr4633325b6e.43.1771255559738;
        Mon, 16 Feb 2026 07:25:59 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:2d75:8cf2:6289:6a96? ([2600:8803:e7e4:500:2d75:8cf2:6289:6a96])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-463a4ede045sm6507701b6e.9.2026.02.16.07.25.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 07:25:59 -0800 (PST)
Message-ID: <bcfc711c-a02a-4470-a2a6-de43c71e7c2e@baylibre.com>
Date: Mon, 16 Feb 2026 09:25:58 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] iio: orientation: hid-sensor-rotation: fix quaternion
 alignment
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Jiri Kosina <jikos@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-input@vger.kernel.org,
 Lixu Zhang <lixu.zhang@intel.com>
References: <20260214-iio-fix-repeat-alignment-v1-0-47f01288c803@baylibre.com>
 <aZLKy4l6OlPgIkZx@smile.fi.intel.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aZLKy4l6OlPgIkZx@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/16/26 1:44 AM, Andy Shevchenko wrote:
> On Sat, Feb 14, 2026 at 03:00:19PM -0600, David Lechner wrote:
>> The main point of this series is to fix a regression reported in
>> hid-sensor-rotation where the alignment of the quaternion field in the
>> data was inadvertently changed from 16 bytes to 8 bytes. This is an
>> unusually case (one of only 2 in the kernel) where the .repeat field of
>> struct iio_scan_type is used and we have such a requirement. (The other
>> case uses u16 instead of u32, so it wasn't affected.)
>>
>> To make the reason for the alignment more explicit to future readers,
>> we introduce a new macro, IIO_DECLARE_REPEATED_ELEMENT, to declare the
>> array with proper allignment. This is meant to follow the pattern of
>> the similar IIO_DECLARE_BUFFER_WITH_TS() macro.
> 
> In both cases it's quaternion, maybe be more explicit and define
> IIO_DECLARE_QUATERNION() ?
> 

It is really the fact that the scan_type has .repeat > 1 that requires
this, so I was trying to make a name that shows that link.

But right now, quaternion is the only thing that has .repeat > 1, so
I guess it would be OK either way. We'll see if Jonathan has an
opinion on the naming.

