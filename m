Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AF83DC87D
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 08:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778660131; cv=pass; b=VcO7WYc4uEs+RgPN1vJPlkKB41kUs7s5NkxDKlGSI+MRzDB/Mg0DIVOWt3xATONMmGy8CxBC88w9LGeCx0LtQgmGYTcUzhk8aZXFQ+3zou14XWRbSNGhFkwc30UELUeOKl0QpiV7oGYK2H9ojUp9unNfBKKIdCvY6YNMOUQn04Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778660131; c=relaxed/simple;
	bh=lYv8a8ENVmLvpG8SK0wT5vDJT10Y+Y5S8ekfSoBh9WY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=olalfxwV6YvFgPXdZFiMA+7KfiSwC6lLRhWw5MWpQA1a4CNVEFcij9gpiG6lB7nHTDaxHyGLTg7ZTttOaSkuUUKQmgyDCwblkT/XgtcHCyYVDqBhZP+Hq/lN9uPbWFyLUfpCY7O11PnTGNTNwq2wzdqXt3m8RVbwaHm7Mxkbmk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXxyd0zo; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXxyd0zo"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-45ae6a0e523so1076942f8f.1
        for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 01:15:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778660127; cv=none;
        d=google.com; s=arc-20240605;
        b=F+NVqQj4BO/MdXvJO/URG+kObIxSai4fBsYpHbiyHmlNgHkl47A8yM4Pqc7DOGMGZq
         wJ49hAHCQwVnTGUEfzljXPlGibpgz5KSSuPV/Jw0X3aVWGOzh7959gjIYNboA+oI/AuI
         5v2tSg2JaZWrC7u5i6k80i+Jlp0/RZ+smjsir7Lny5dRk/uFAC9LZDFqzZQ/i8Q9q8Ks
         R1z3FgMMv7smYDqJBHhp/yjtB4Wv1/r80sNhy8Mrtz7SgoYykCvWtJd4P+ojcXqvjwJh
         6/fWnto6bKyG8tzoIELdDFFiJWmnCZyYfN8BFKVkm+EvzaUOCL5AhzTEvgnVLnIx/Asw
         zb+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ihd6IIZewTAFs61vT8dRXOpRuE/aFWajhj8VCrvf4kU=;
        fh=a/lz1+FYyxHjCvL/sPRCkOKBflNqZiWNHWFfr8G891o=;
        b=GEswFH9EKHApDnw9BIc5i9n36t03k8RkJ6khfPwr5vx10ed/dwYUUk83cDL3K0VI/o
         SiA9phQ1x0GO6rHdB1wu2/FAFkixYId8mcCzG49Ftz/FkuqEPCheEjxomhEGTJtwWe8y
         atrkG09HFtoq4+12V/mcGWILY63w9gtFydtYPo28qovihG7zeIdp7n+F47gpNSbo+qbE
         PbWrOlI0FMjgdpJLs/4JwhCgpNEYaCozcBvUG0ujK3ychH+2XNR8UIuBjb7bDJalbU4b
         zHkfBcHcRS5lCWBZhidXeE0szVYhkkhTGjvNewaZg1ucmR0g/HwA1QiIazJ32TPjrBfQ
         /E3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778660127; x=1779264927; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ihd6IIZewTAFs61vT8dRXOpRuE/aFWajhj8VCrvf4kU=;
        b=AXxyd0zo0ZKSL7gOT7gYvoaa0ZWtS2js4xDhyD9oAjdyd5KqkMifbW+qrReOvPjlvw
         VCeVcVeR3J7aVzK/OPQNqGofsMvPMZcw1d81k+Jiz7+XGzB6s1U8o9wfpicU9tseIwZ+
         6H/AiKMU+aee1pHjheT78aWdUwe3H8EjrFbIQcc2mj4l3CGsh7ayrmDRk+2XXKVm1xJz
         mtaNg9aFnPX46qZIBlFy1SqVkeGBxYS1ohZaD8biydVbiJYZlcxGrRvobyDvFGh+XR6/
         hrcQ9Tz7VHLGQbuFbCh71N/RwH7vuT7YxovlIgfwd20sQdLHhca9Iu56wheCl+eycdhX
         6e7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778660127; x=1779264927;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihd6IIZewTAFs61vT8dRXOpRuE/aFWajhj8VCrvf4kU=;
        b=bwlTWVX0HpzRqnYPWL/WuJG+GN9g5QPuF+cvISkTa8IMeeJz9Bdhkgi52H1PsOoTZx
         7cdBh6A/JiaoddDrNNqXRJkEL0DcNYxdOkYqFWx6q1+NN+sApiLMTXf7UuOqi+oyTZIE
         Oje1y+fr8NvyAq6hJSnMfXJLCB/SUIqH6DtB+wIbs3gVAVGU/KxRh7oc9Ay22sD+KGkC
         iUAU2UTBJWPppGZJP5BkoCbSdftI+iXHmknMHvNSjWA+PGbUca6Ecc0lW95UdNGN/eQS
         XmNhlz5BmFo4xCAlpzq1CYjY+bxolvtAUFJZLsK0MPiVi94POBIr5R0b9xMg/W+0i7+C
         eHmg==
X-Forwarded-Encrypted: i=1; AFNElJ8PeqZqu/9OUVOfuyW7pKreIZa5jMrWU4RVSOmCLT7z7tpSdjbkC00293Bbw0LAT/qswC1d+Y9tqgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbP07At3RQOZ50oR13uDD95jX3nDoqK7NKhvffCtOnP7jUkMqO
	cqQhLD6qJjD3zgzK/2ba8eGjT3dLKlUoiUdtieBF3Kwr2LTtu4GEbSc8/QhCjUrEfYpnNobGoHv
	u01xvm1zRgX8akNwsWh3iiBQFRMSd+Os=
X-Gm-Gg: Acq92OGhCfGjSseSo37tIy3qR0kyYrvNNdbmej1jqCcsWJqR3NBJBHl2M6Zngct899+
	51CnhZMchw7pkZmC8ecFZSX536dZpaPtUTo/XAO894gSu7t3toT8/ShRFBe1wEwFjbFT/xusCbv
	B8z/dfDi1w/6moyDROjWzEDOf8nPhArUDpTYQ5ceYAt0asxC9Fuj8eBTqq+79cN0uW0HasDkFDL
	f55mDziBO4HcgclwcfnhkHMUvJ3WWTUkLawCMtXS4sN0IvP69IoyTGxrx3YQz664NVwnn3fpB4m
	FLhtj1oBYuCVf6ZqAPZjZym6nny+YIn3eJx5g74cRU8h4YQXR8UW9mM/GyonACRRqFIU2OUiToO
	iU41mcwggcDCE8itagz4gZMfTpHliQ1c1b4S0Fyr7ZXa6mzLwF1xy1lz46ZcCJUlBSiawekeK6t
	ccrtkoLlTGkUOZdBnm
X-Received: by 2002:a05:6000:2481:b0:452:a209:560 with SMTP id
 ffacd0b85a97d-45c59bd69bamr3403676f8f.28.1778660126733; Wed, 13 May 2026
 01:15:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512223215.25596-1-aldocontelk@gmail.com> <20260512223215.25596-2-aldocontelk@gmail.com>
In-Reply-To: <20260512223215.25596-2-aldocontelk@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 13 May 2026 10:15:15 +0200
X-Gm-Features: AVHnY4LREJDdBCiZ3UmbFhMT9ufyew7p-sRgEBV2Un7SA8xGSShNpr7DliqBzw0
Message-ID: <CALoEA-zype4pcy6dPNa_EPnAbTYLazdsZ7d_zEbbqGPrk9=HFw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] iio: light: tcs3472: sort headers alphabetically
To: Aldo Conte <aldocontelk@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 May 2026 at 00:39, Aldo Conte <aldocontelk@gmail.com> wrote:
>
> Sort the #include directives in alphabetical order in preparation for
> adding new headers in upcoming patches.
>
> No functional change.
>
> Suggested-by: Andy Shevchenko <andy@kernel.org>
> Signed-off-by: Aldo Conte <aldocontelk@gmail.com>
> ---
>  drivers/iio/light/tcs3472.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
> index 12429a3261b3..9b0f64cd9c50 100644
> --- a/drivers/iio/light/tcs3472.c
> +++ b/drivers/iio/light/tcs3472.c
> @@ -13,16 +13,16 @@
>   * TODO: wait time
>   */
>
> -#include <linux/module.h>
> -#include <linux/i2c.h>
>  #include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
>  #include <linux/pm.h>
>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/events.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> -#include <linux/iio/events.h>
>  #include <linux/iio/trigger_consumer.h>
> -#include <linux/iio/buffer.h>
>  #include <linux/iio/triggered_buffer.h>
>
>  #define TCS3472_DRV_NAME "tcs3472"
> --

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards

CJD
