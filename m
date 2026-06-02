Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220E83D891C
	for <linux-iio@vger.kernel.org>; Tue,  2 Jun 2026 11:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780399311; cv=pass; b=uBfWg4BcwlpJBtjmhmuqevP6DdIkXhNdveCYOA+7/Sog41hvoXea3Fcnsl4wfKdjmPOehK9uxPwWNImcB31vKTzs5vAm1hdtri35fk9rT7eH/26dOFwDadmTcWxgyHOELg7UaPC1XWkTrTbz4Ia1Qatvq8g0+KYN0jQOjA5B/Rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780399311; c=relaxed/simple;
	bh=YFWTpa768Mizy6Y9RP1z5B3yTHYadcLcipl2r2WP5ic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q9dqJTR50+Nde0d2kvAdGBgjMM/1Ton9GBQmDh52oXeoMnhat0OJaTGLT9N++rOhYYePBNZvkk1XBJcW0vgCMyusfR4Eh5daTY90huwDGavkBXuUxYF/nyuNqQ+7Y5ihlSwR/Qutn1E96vQm5rzENBC1/DVY0e9Uv7T4C/uB/dM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pCnCVOqe; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pCnCVOqe"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-45ebafde87cso7520375f8f.3
        for <linux-iio@vger.kernel.org>; Tue, 02 Jun 2026 04:21:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780399306; cv=none;
        d=google.com; s=arc-20240605;
        b=Xd1uVdngaiOijwUvJZ1+gxMi178qaCpQI7XkWJXIbrNUkxEnWGJ50CW4JQY97oDfnv
         g2YjgjreRRKHBT8FSTyWdSWlWm/WuJRExubg2h/tGqJoho2HjnQ5jYFJK/hL/Er+dUKR
         c5qKMYe/heB60kjKvppeHzh5icMLEAEPYaibK+R/SYgipAEC/QGTOQ5nwgntqYct/kzX
         TXF0nWIGuSHHexikwnuBVV/s3FiWMWscMWH5fzXUIlcjiEBVNBp60QG3ULqr6afommCG
         UwSKyiFLr2rzSLqs8uxFCMja9YbMxejvxMfwP50BfAcbL18aWj71gc3rUPwRalbaCQWL
         ci9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZLqHBgXsfQzat/RItjNrifpP2fiT1XPOaumQDI9WwPk=;
        fh=uMpaqrrEa/zFvLNb2CxBscR6sslON8ycgDivvnOM7H8=;
        b=Hiy1/xWOvaMWkMYM6kAGyORN8+sq6KvnEZ55FUWEh/ZkDeK+2oK+3Np5EBqRKoCUVP
         OYIBpjTcLpLkunCICF57PA9E9F/EDFDSN4cNX/V83xMtLTROJ7Hyqj2TPPGCPCu2gPnw
         Kolr6pt4APl1fTR4ONf++gpklZHfMv/QT/3v3a6t8SlHoAQjyQ9kYj5CTTgqAjev7ux0
         zhHqEnxhn3luGScd5vnp8j6IFnyI4ZDw9XTfo/wV4OG5ItmayNwuDsUJtJnH7ZdkAyX0
         X8JkzOO2ZushTGD7OSfGenb1xkGfDqg/gnJ9WKgaCLohYHauQClR7hzEQKM5q39mFfuP
         T5JQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780399306; x=1781004106; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLqHBgXsfQzat/RItjNrifpP2fiT1XPOaumQDI9WwPk=;
        b=pCnCVOqeI1WbYufiTLH6wXklubXrzr3ina22dpdrWp1totW2Os9D45601P/l4G3Qv+
         sinI8F/Wk+XwwJ7nQxqg/Erll8Hts3eFSDA0UChjOKfBrViZKQigqrXaDq8HzNFISuui
         Tuz411bUFwQdgBkpIEUevS3zuod4CDdamg9kUU3leExAlULNNq/Cpry83MiG/MfNZdjA
         BB0v99k6uWFNgUHSoc39TgyXEHFggK2gNmR+leJFGScDqJPRy5sl7UFJg2XtRTq1I70k
         nLHSFit3tsGYh5rLkgZG22RKleh66JFC3Bec782yOIcQGtXnXxFiXYj3p0uFQOiB608a
         dLow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780399306; x=1781004106;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLqHBgXsfQzat/RItjNrifpP2fiT1XPOaumQDI9WwPk=;
        b=lutcGCY+cJ+8X8hNUBr9F+M6hoX1jw4sirWZ49/s+i2yCe9ZJeOEerN1OBGkwvGdAy
         ZKcmFZnEy+apWMiLDmhYGFO3QHoNKL7GxbMiVocceAWBA4K9H029Py1PmM+RsL0leHqH
         7vhWkCRzvHREinmZL55maoR5+rBq7Oq5oGyyrk5/uuwXDgG4hhjLZiIl9Rn/K7/uGzUN
         fsTUwvws12LmELP50u37clFayVpcMrjBlss8uLRPU17X+fw2WiWNpcqIlr6lTfGtpjDR
         Df0erheflAPOOkAxSZkHg5eWJmLfik6mVmYmAFauqo7efLYOwkQVlXG91uR1PAvAUXoM
         9OuQ==
X-Forwarded-Encrypted: i=1; AFNElJ+daBYYOJowpiyBZsPksIHIrsgQPxMB1DwiPgCg+dKPv6NRoleWvrpNrlc31e6EHXM2UQJGIxJ6dW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjwnJff1OgBZBp6FW8C+s4S+1opde14N4NtP/fSW72s7/2DtiV
	elE5/CrfoIE1WfETb9yVZ7qE7HBMrxp8JT1LOQxH4hDbTch7VUZORWP6ly5oC8z8jTcCvaZSjMm
	j9gZYjD3ObQt79oNSuk4cG69+1UH17TQ=
X-Gm-Gg: Acq92OFAhSQ1yUtHF3nqioe7prlAJsaQu7kiWoqEtoBwhMoM7tvcVr5RXF7oV2m9azv
	qpbeYBRAOsF74VOz2HZ90HbgC1NZwXB01UvVySWYC9OpjbmIs2LuXaKIr9OEzppzBtFoq8de3z8
	P9njVWCLiuqxUjNx+VDkOEe/8f5t5bkfl0n4Q4h3dwHfRYWzc6Q7NzXPiUM+pfy0ZA9iMSGskA8
	cNwF4lgZj12JIYaSCrjOPm8egh6mBAhFC/RvBwjASlOQt0/MwDafXQxsIu6FLbfF7JM2NW4SaFq
	Ox5H7bzOal8/+R1c29M1TqsLUjO6O0d/khvu/qWnLrDRcQPSdx1SyMcbi+FQAZ9jtl3sPuLTyvE
	5+FM5Re8BAXN14W6aJIry6ZyB5giD25npykht62dDlIYMAeK5LxUV0+kD/VWOrLHQzJV08nERkT
	P719OolnnXOk9pRYAR
X-Received: by 2002:adf:ea04:0:b0:45e:de0a:1773 with SMTP id
 ffacd0b85a97d-45ef6b93c7bmr20479177f8f.33.1780399306177; Tue, 02 Jun 2026
 04:21:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531-veml6031x00-v4-0-e64f7fdce38d@gmail.com>
 <20260531-veml6031x00-v4-2-e64f7fdce38d@gmail.com> <ah6p-f2RCW8VcuDR@ashevche-desk.local>
 <DIYI40YK6CSX.2P4017PHVJHCT@gmail.com> <ah66ljSiIc0ywFC2@ashevche-desk.local>
In-Reply-To: <ah66ljSiIc0ywFC2@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Tue, 2 Jun 2026 13:21:34 +0200
X-Gm-Features: AVHnY4JnJuVXmwDjzbvcOTJxkPYCt3QsTcWYCYMeswe3B4QFyV_njNnZZmIFMWI
Message-ID: <CALoEA-wdakU-Ei2FE3WpGR+CYRDN1bjv2sZ=XJ01ZeH3NP8xeA@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] iio: light: add support for veml6031x00 ALS series
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Jun 2026 at 13:17, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> > Do you know any tool to automate this beyond asking an AI? Manual
> > auditing is not very reliablo and it is not that difficult to miss a
> > header that has been indirectly included. Building with W=1 and similar
> > stuff did not help.
>
> `iwyu`, but it needs a custom configuration. Even with that it's quite far from ideal.
> The custom config had been shared in the linux-iio@ mailing list this year.

Let me help with that.

https://lore.kernel.org/all/20260512073505.1310-1-joshua.crofts1@gmail.com/

-- 
Kind regards

CJD
