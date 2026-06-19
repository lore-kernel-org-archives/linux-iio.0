Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F008A3148C5
	for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 07:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781854055; cv=none; b=K4sQadObXpFR/namyEPK4ptqH8UGRyxvVkAEVEZtydqU3ERVDmVnF/vyehAxB1DWgNBcIr1s831/ofIH7Z4aiVuEb7xBqciwudAdOk/rFXKFSfdtKq6aCJM7ArBPFks5nwuqNvmS648w5JEdDcHuB10JwtiL27X7is0hYbw0CM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781854055; c=relaxed/simple;
	bh=1j4oMI2D2hKkZmKe9lT1S5LDalhiuzK3P27rYpFG5gU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MVMvEcgI+gCWV3v8olYMjCLLk/v3p782IeALKCivPymzgbLFylNPVoMoqdZlindvX2eqYYOjdO3pJFfdGwQi6wQv6mxIp/ma7acMKDDaOag+emCmh8TGrLoLMIjaZ9xOK4VCicB0+eWrSfUWmOLSbD+EIUE+lrj6Nmw2xeNNStI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5YGdshk; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5YGdshk"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4624c1409c9so1347587f8f.3
        for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 00:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781854052; x=1782458852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jhh2Nw2RHmSNo+YXRWJWHdzKkT+CEgHXm2yuMwOy9yU=;
        b=M5YGdshk4YiwKBZi2egrfVHhYDByghwqsrSmgc7z4bCwkw3bYQ/y04l74HKCi3TPEL
         KHZnjdoGhZJhWkn+r83PRAaGaF+9LQ+wh9xUzBk6qERH1YToNOGfLLyP9JljWlLFIfTU
         orvaHwwW0TTPuu/9D9zyvy7HyHAmbl9JWlV6/G/bR4g+ZEpryyDnVxKDACLjP0ZP3SrN
         i4yfogx7qeN5PvP10lXHv9bTOxD3krH3/oVI3upBGsuULX0H05lFrVLVLiKHIVLT8o9R
         bLnFwJJIVPhNHUXZW/4GSnuYHXCEnITJB0gSpxBpMVeu4UH1JPDEbWjMB/oIQRYffCcu
         3Vjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781854052; x=1782458852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jhh2Nw2RHmSNo+YXRWJWHdzKkT+CEgHXm2yuMwOy9yU=;
        b=VKaWlDfLfeuXkDk+eIcVd7ubYIvhkDAMWGvcElMZ55XUtlzroRCSflixBBf1XcO58H
         KLTj11pDf9qOozagEW4f+ausLabDvS9FgW0eQfj7CQE+uXWSIcjrNDLvtaB7WQZqzvvN
         InREVI0ofLf0jChJOb1nSlwkLkusKrtmmb7HX608N81534J02MAqSa6V6FcgNi3y0POo
         Pn12Epn3CxOaVHVZjh6sIX+ulTZxhrnkmGsNFyr7tOThUGnVdHF86MiLPFiQHP2MkxEI
         to6nxrn3ys8tmP9zr7hsMkHVy5wltuaLT+MgQNo5J2gO9OdNCWOOuXdwWUTrPxjGnPIO
         lrqg==
X-Forwarded-Encrypted: i=1; AFNElJ/S5UKNyG3KxwCjvFiA2AGSWUhDbJSs2hvB1+S1jioiAiGECSvYbMBSSBlUDhLcQhJAYD9wrYSfQwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YykVwzhRxlu28g8qqVXF4YcGAcZEnn2UevEg6gJCDBeAb1lsWpE
	a1IUr1c1Nc6Ejnp4aRj3BFhe8JJXm1HgFH3DixGascRFW3GhJJbdLj5L
X-Gm-Gg: AfdE7cnC8iJvu9zxfq3Z2Ir6ClH8BW3GTvTDy4amtdwIc7GKYJO3atWuswNXl+Y67JI
	1A2uI4uaII94UjOloZtFOfoqNk0MoEz6oPqftp59wY46fgS6YsYoJcGn4cSSeGv/RORoGoBJ3Qx
	C6z09NWISwbzotKtNmdOqZSX7Czes16n0dfQ3rkv++PSFCS9IbnuPoXjeSNdSiOCQojZ4X/SkZV
	D7SSdgGt1vUG4kqQvWJNWIToHKm8z9Du6ujXr9/ICA/2PYeEgHlZ2xpg4BCnrKyvchNjy0fynA6
	Wx31EGIYemmDSC/XKQIs2/RaFv7NZzmFPfxZpTbWoQCA8rIZiJ9lu6FPkLRKlPdEcsBH/OloE6E
	RB08BJbIR4H3BZfxYGIp7VPMrR9K1iUXnG3plVTROkd6PIum1IJVueFBLHWCQilD/cL75RE1VaO
	zlApw60OwNujKBtBtLiLuLSXJ2ZIdlEWckubOBZyz9Uoqj1fI2jJQmEGAJq4Gtkk8fMxbqoOb5+
	5bSOYkHXZlP3gJqGDFaXDp0FZUyo+wvCjxTHOQzJq3FOwr3cR+huREzOxMsuObG+gMJJAkN9IFm
	vNP5F0q1FpUWaD4APz6CY7U+jzd31dR/CBb8TSmb0SOhwRR8pjzX6LGKw+07g9bwug==
X-Received: by 2002:a05:6000:430a:b0:462:ce05:c5e4 with SMTP id ffacd0b85a97d-4650211efeemr4622713f8f.37.1781854052321;
        Fri, 19 Jun 2026 00:27:32 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-465090c42e1sm5872109f8f.11.2026.06.19.00.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 00:27:32 -0700 (PDT)
Date: Fri, 19 Jun 2026 09:27:31 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Miao Li <limiao870622@163.com>
Cc: jic23@kernel.org, andy@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, dixitparmar19@gmail.com, bigeasy@linutronix.de,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Miao Li
 <limiao@kylinos.cn>, Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v3] iio: accel: stk8ba50: Update includes to match IWYU
Message-ID: <20260619092731.0000090f@gmail.com>
In-Reply-To: <20260617013834.166337-1-limiao870622@163.com>
References: <20260617013834.166337-1-limiao870622@163.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Jun 2026 09:38:34 +0800
Miao Li <limiao870622@163.com> wrote:

> +#include <linux/array_size.h>
> +#include <linux/bits.h>
> +#include <linux/dev_printk.h>
> +#include <linux/errno.h>
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
> -#include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
> +#include <linux/mutex.h>
> +#include <linux/pm.h>
> +#include <linux/sysfs.h>
>  #include <linux/types.h>
> +
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>

The driver uses sign_extend32(), which is included in <linux/bitops.h>.
Consider removing bits.h and adding bitops.h instead.

-- 
Kind regards

CJD
