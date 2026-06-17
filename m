Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FB2396B6F
	for <linux-iio@vger.kernel.org>; Wed, 17 Jun 2026 16:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781713603; cv=none; b=CL2g+Vbglndl3HVMObP6Ur3cn4k6uAa763dzZV6PFvaLy7EDEEJ4pjKAZIedbMbcPhV0ZdTO/AgLLwgCdlpBy3VXyoofcmxNFy2nBsul53BgIAjYTSm2BiK4TZ1wHqpD8LsOnsPUmBo+IYo1LnVRR+BuWAA/ulFRJApGKXQ8uFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781713603; c=relaxed/simple;
	bh=yuTjtCSL6nDqPw5bh1+o5icGaaHPmtOBvYQ8hXVMyTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=koi0+yqVReWEaL/phX7A0R4CxvuSLMtvttCcG6J3LoxblzppZAvX7xw4uczF9tOcuZoz73ZgknnnG97oqYHEBf3OlYW37KWyEYmQ4shxyYFvGuPtIDaPLeZNfQuZcgN42uzsUwmcrOq9uegluP9ahE944/R3aueT/vnHXN4ZtCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2+DqcHQ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2+DqcHQ"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49222b6e871so44441415e9.3
        for <linux-iio@vger.kernel.org>; Wed, 17 Jun 2026 09:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781713597; x=1782318397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=048WwcP8hXWTPpyEKeHyvAZ7Iw1D9/1dB7sPBKVJt9E=;
        b=c2+DqcHQjA0QrGtPnP6aYWJ3HqvwIzBbXk1wtIKhw5z9PZuoMvnbSNesMTs6cc5o7z
         aEr8agzlZqx7k7C4LYOyBygwml5GvEhIWNWpXP8kqAtBdVbJiddnbCHAQw3wjSJB+0HP
         g0C46SKN7qxjcjMopoVwMF1mVXxzPgGd9EjTvGzJTPELusbua8p1P3wjKD5ZsecIsUcW
         kEYy4O6RevMsZQ2oNmeAyXA+I8htA1dp1UfnZY2x7WO0ltbYsIjttsKCBvoDnLAHakzI
         3aGNKTEx1vj18+PAv9yPaaayUYCl9SvDYNSckuNSsMryGD0ckwQXEw0NAsSu8CzLEPae
         WKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781713597; x=1782318397;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=048WwcP8hXWTPpyEKeHyvAZ7Iw1D9/1dB7sPBKVJt9E=;
        b=s8lfLdRtYXem248htcR3bX7WT0yW+Tex+Zcb5tSQJPFBmsTMfJe6GQvRo/Es7V1h+b
         4JVMAwMdxfJ96DvQ016bLFoE1080/90FlmOW0pG35CQ1bmkdP63ldq68beYVlcB4VSMN
         J4tieno/LKjOSRrUyPAtGHDo397wS9RfTbBzojL4HC0VUWcwZKHJ975c5N6GNAfG1Bb6
         4ia9AOaVN1zggDkXZS82XLYoNv8TnLc/kFNQNybO2V6MITnbk4kEVH9QZ8MdlSCfKTOL
         Pia7EjsIu8BQ2kt32cPx+Wx3awwWEPaDrz53C3WO3A5InRN8pkmbW8Adpbx5AdLH72rQ
         exkQ==
X-Forwarded-Encrypted: i=1; AFNElJ/UH1WOLyKtEBr4m4AM4w+cib/ot5AR58vAvbQvdoK0BTMZaTSs37IDkHbdSC099Bm2tYC7TclUNuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxYTa04SgjJdwieKbrQx02IFp6n1E7IFoEE8Y5i0W7C5J4i8p4
	vQHsKnZCRPAsESA91cG6+XEZv45JIUNn1hbVu+shBcs3sYMgqiIlQULE
X-Gm-Gg: Acq92OEA//eIOybYmS1Dwl26+eAPUQDfDFU/ti4vpGxRYlZrSSUbkQOhKBPWeWpbhry
	ow/T+UuByNZwCRLApZi/R3yzundndDbJZg5pft8sgYOVFTfR/VnbCO3Qo1LjClrZQgOaXE59k7Q
	XnLmJiqj6rb83XU6A8T3BF2xJ5TNutCN3gQDQ450S+qYi0UCGEbWK9osBp2NrFH5f7Aq5ZIKaO/
	1LehnbLPGjTX5zDcWy5GFZSFgtDisi3INe+5mftgZq/yySJ1HbDykD4mYhhdSSQPTdI6DWzHJUZ
	N230lGSRDHWJ2bNlrGo7uOth+6z+bdoDnDE7nvf4Bh6NQfShkCYcGvM3yZPrXMbo9I/NPl5IwWH
	th/uUjjZ9tI57X83aZnz2rtJSiG3uMJ16iBlRD6GETeH6BRUfelZ/g4fiE3zXqObPr4TsRDsgBT
	emhpQ9xh5ZuRXW4k9saHsk9wbAIDT17l6y4lS2qxAOxiQ1Q3bOrm5mQxt/KfH5b4q92pUphbjex
	pid1vk=
X-Received: by 2002:a05:600c:b43:b0:492:1e36:8c4c with SMTP id 5b1f17b1804b1-49234142053mr49117205e9.37.1781713597036;
        Wed, 17 Jun 2026 09:26:37 -0700 (PDT)
Received: from [10.128.11.42] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923687d2casm25491995e9.0.2026.06.17.09.26.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 09:26:36 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <1d0b09e0-66b1-4170-bbac-1e3a39ca7be2@gmail.com>
Date: Wed, 17 Jun 2026 17:26:35 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] iio: adc: ltc2378: Enable high-speed data capture
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
 dlechner@baylibre.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, pop.ioan-daniel@analog.com, marcelo.schmitt1@gmail.com
References: <cover.1781661028.git.marcelo.schmitt@analog.com>
 <9f173c47928446aa3e900cf0becb6130dd76846b.1781661028.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <9f173c47928446aa3e900cf0becb6130dd76846b.1781661028.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Marcelo,

On 6/17/26 03:04, Marcelo Schmitt wrote:

> +	select LTC2378_LIB_OFFLOAD_BUFFER if SPI_OFFLOAD && PWM && SPI_OFFLOAD_TRIGGER_PWM && IIO_BUFFER && IIO_BUFFER_DMAENGINE
The PWM in this expression is unnecessary since you're && it with
SPI_OFFLOAD_TRIGGER_PWM.

- Julian Braha
