Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8016B386567
	for <linux-iio@vger.kernel.org>; Thu, 23 Apr 2026 18:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776969919; cv=none; b=SNFs9dmhkSzS2NbimH7A8UMzQ7Qv3BUaHqjnl7tT2sC80PHZhf/7JBww5bi72Oaqiu0Y07A3daSTjv4HjpaUjBwo65D91KYZXHDpmVcp2jOtq/mgJwRRVhbElXbwed23+NA1gwnmRbVEEBfUMdbAlIL287zu3IiIIA6lcLselrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776969919; c=relaxed/simple;
	bh=azt7suwh3NmTsvQzKwKi7RuA/MtpuKtvyVvMUc5uBPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tgN0931opsRXvPJhvdDomecwb7uxQs51VEFmDZ5gQaXHjI9rLgocmrDyClWI7/eSY7pXdruIuVClPpD67fAEAewk2sqOGXIDz5orRxMBD0lkPZC9ZWFF77yJTxR+AxoF+ZkxWARXS3ixJtn7oYlYGSNQIr1Th+HY4cOvt8SZpRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=rNgKKUE+; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="rNgKKUE+"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-68244d317e5so4149646eaf.0
        for <linux-iio@vger.kernel.org>; Thu, 23 Apr 2026 11:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776969914; x=1777574714; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h7B9//ZIs2xqUgapk+BAH8bzTkTMhU5fRky03+jOP4c=;
        b=rNgKKUE+vqkUqzg29eBHxVhFGXiLBHcNA68qZqlzAgbxzAZBLpqxzFnSL1oUOZeqtr
         3uNWiINzRRq+g6dGRxBIRkv/gvmB/1GuMbfSrgiiBvI/D+6kmjQtjn0aLwWfOWzY7l63
         gph5f8rydWSbb7ZJFSXYxdjL5KvQhBljZtMuDkEJSaXEysJxHdiwd/DcSBPp0iKK1AAe
         X4yclSWSGMZZMH6KabRm2F+7Ji8n8wMnhip3scoJ6CpApzrNsxRpgMTKsBfsuT9diAut
         tepSTXhNX5sOcdjH/Uim8DRBY+FohcDsHEhLFk1tiZhKluYqyTqzg5C4J2b0XtGeC2Sh
         zdzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776969914; x=1777574714;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h7B9//ZIs2xqUgapk+BAH8bzTkTMhU5fRky03+jOP4c=;
        b=lrMIoAa4Puk6WlU8OxYSkS8hSgJeJJKqzB7Nsm4uWv9bjGBSyklkrQeN5hnEpZlSDH
         kuF0rGDQLvT34C1yZ5QCDQ7FfuqdcCuDVKXklvls/i6D9KLEa0ymbQKyk+oA8kGnmu9v
         qh1s7lfjIU9LnMHmCCUpRfA6cY8GmfJYGVXRHK0R3dteUU6Y/XrUlIwegstV7evGHikd
         MAVb134PFUD+mCCflwP9HPSB5cP5dwRZLqLEoNxvt2ZjlFwEOijoJku977LaeB2Fcid2
         a0CQ6sqsHUauBRpntQk4HOiD+1He6kWF29NnTGjnO0Bh8tL9STKZk1g8cCRydjuOy1I8
         nj0Q==
X-Gm-Message-State: AOJu0YxnKIHyccxOJ5VC84fa7Xj4u8dEm4fMI1VWt1VjxjH6Pzy1h4hB
	wiPuBz1SrvnnP1+4KcoqtgdcdlgCcf9h8IplwpuQL/d/aBrx2VH2zFIF46LdJtMsTi4=
X-Gm-Gg: AeBDieuY9VJWmo8MPX07HYjEzZXkjoRxWoh9beWKnqmL7ZV9tkWBsDGTXORQdKyqN2e
	3bs2gL7ewKHn75yDknmdDkWiDTfA0gYN7Ja3OS7HDwPi4h6DM+FTXF3ZsrUMkHvIYCOJxHOEbG2
	ACwOhXlI6d2VjMisIU2VuQmOwEgbE80TxNbj7tIpIv26Rih3JROn7sZID2izlpJmAn7AZ7EW5PK
	jfkQOlfwNhZKvpW1JyQy5rcJcwDOBOfrLyCYHRQqcuD6G0Nwx8hhR2KazbRP4BS3DvillEF1Cgg
	omwwR186ns976Zg0S/Q64hYXs5zP7r053b1/8qjbDD22zKU/KeTAMiqYis9bgjgG2XfpIeJHG3/
	ncTNpQdLGoX8JD4jWY4opl/hP/ekYoj9OYAKH//o8l7yLvtMoIOvy8Y3W6FsJujcgEiumhcU55q
	wUCDD0qo7rJOkx8kvxryAwic2GkSSRk0A27xeofYby4dZmOHnhElf0pq3Ng+A3IFrr2vFalIjBK
	YVbYSEt7Qc0
X-Received: by 2002:a05:6820:629:b0:696:1a25:fdda with SMTP id 006d021491bc7-6961a26036amr2084343eaf.26.1776969913953;
        Thu, 23 Apr 2026 11:45:13 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:3cc7:689f:be44:d58a? ([2600:8803:e7e4:500:3cc7:689f:be44:d58a])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-694994277a4sm5442766eaf.4.2026.04.23.11.45.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 11:45:13 -0700 (PDT)
Message-ID: <a9307e04-3754-465e-a610-92c6e83cc3e6@baylibre.com>
Date: Thu, 23 Apr 2026 13:45:12 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: fix header includes across multiple drivers
To: Caio Morais <caiomorais@usp.br>, jic23@kernel.org, nuno.sa@analog.com,
 andy@kernel.org, michal.simek@amd.com
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20260423183349.636757-1-caiomorais@usp.br>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260423183349.636757-1-caiomorais@usp.br>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/23/26 1:33 PM, Caio Morais wrote:
> From: Caio Morais <caiomorais@usp.br>
> 
> Remove unnecessary includes and add missing ones as reported by the
> include-what-you-use (IWYU) tool.
> 
> Files changed:
> - drivers/iio/adc/xilinx-xadc-events.c
> - drivers/iio/buffer/industrialio-triggered-buffer.c
> - drivers/iio/common/st_sensors/st_sensors_i2c.c
> - drivers/iio/common/st_sensors/st_sensors_spi.c

We'll want to split these up, one patch per file in case they every
need to be backported as a dependency to a fix.

> 
> Signed-off-by: Caio Morais <caiomorais@usp.br>
> ---
>  drivers/iio/adc/xilinx-xadc-events.c               | 4 ++--
>  drivers/iio/buffer/industrialio-triggered-buffer.c | 8 ++++----
>  drivers/iio/common/st_sensors/st_sensors_i2c.c     | 2 +-
>  3 files changed, 7 insertions(+), 7 deletions(-)

This looks like sorting alphabetically, not actually adding or removing
any headers as seen by the equal number of insertions and deletions.

Usually we don't bother with sorting unless we are making other
changes on top of that.

> 
> diff --git a/drivers/iio/adc/xilinx-xadc-events.c b/drivers/iio/adc/xilinx-xadc-events.c
> index d16e61953..20b796ec7 100644
> --- a/drivers/iio/adc/xilinx-xadc-events.c
> +++ b/drivers/iio/adc/xilinx-xadc-events.c
> @@ -7,11 +7,11 @@
>   */
>  
>  #include <linux/bitmap.h>
> -#include <linux/types.h>
>  #include <linux/errno.h>
> -#include <linux/mutex.h>
>  #include <linux/iio/events.h>
>  #include <linux/iio/iio.h>
> +#include <linux/mutex.h>
> +#include <linux/types.h>
>  
>  #include "xilinx-xadc.h"
>  
> diff --git a/drivers/iio/buffer/industrialio-triggered-buffer.c b/drivers/iio/buffer/industrialio-triggered-buffer.c
> index 601a26398..5796c9da7 100644
> --- a/drivers/iio/buffer/industrialio-triggered-buffer.c
> +++ b/drivers/iio/buffer/industrialio-triggered-buffer.c
> @@ -5,15 +5,15 @@
>   */
>  
>  #include <linux/errno.h>
> -#include <linux/linkage.h>
> -#include <linux/module.h>
> -#include <linux/stddef.h>
> -#include <linux/iio/iio.h>
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/buffer_impl.h>
> +#include <linux/iio/iio.h>
>  #include <linux/iio/kfifo_buf.h>
>  #include <linux/iio/triggered_buffer.h>
>  #include <linux/iio/trigger_consumer.h>
> +#include <linux/linkage.h>
> +#include <linux/module.h>
> +#include <linux/stddef.h>
>  
>  /**
>   * iio_triggered_buffer_setup_ext() - Setup triggered buffer and pollfunc
> diff --git a/drivers/iio/common/st_sensors/st_sensors_i2c.c b/drivers/iio/common/st_sensors/st_sensors_i2c.c
> index 6ab143498..974e349ae 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_i2c.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_i2c.c
> @@ -10,10 +10,10 @@
>  #include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/i2c.h>
> +#include <linux/iio/iio.h>
>  #include <linux/linkage.h>
>  #include <linux/module.h>
>  #include <linux/regmap.h>
> -#include <linux/iio/iio.h>

On this one, it would be more logical to move the iio header
down one line to group it with the one below.

>  
>  #include <linux/iio/common/st_sensors_i2c.h>
>  

