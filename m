Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1234D22538F
	for <linux-iio@vger.kernel.org>; Sat, 29 Aug 2026 16:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788021403; cv=none; b=e3cm00RWbBTqBsLeZ8zXfpo4P/WbE1yMN1xpFC1vLNM8uhM4P/wHs4Yzr86rpKwtxLNAF/lercSXPlAXbsdydEWzSMGO1ZFhIQyjcltUUbC2opyiLct2E+V5QBQ8s4CkobR1q7CRAp8TXcJ23uoMW/WG44vrFSEojYruLhBmX6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788021403; c=relaxed/simple;
	bh=GQDdbYBhfTWwI4lw+f/HHlZvilbjL/C3vJRwmTyJO1A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JPB64+5Ms/eh57pOYSjcBkHR9fa6gqoX3kMcyflCfrh62WnWxW2RWjj+n088xiioD+xuY005R6eDottow06nsscSte84fa23oAUi6pWlNDl9ANTtw+bo9+48QBQ7M/cCRL62YszCKwJ7UnjztndGJoNg6WIoG8xlc6lWYC1Zcag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZVclHmzQ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVclHmzQ"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso12472775e9.1
        for <linux-iio@vger.kernel.org>; Sat, 29 Aug 2026 09:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788021400; x=1788626200; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4OSi7MMm07peXNc9aOu04WCVC9TQOGqHoXbsa8tJFTQ=;
        b=ZVclHmzQRzUyolY59bubDpUdVKrA61Dyk2BQizqDigloXP/pMchdqU4EjDX6YaRM3q
         sGO3unDNlbVYyEU/84ELgJ5OSfSkgrp3BWagHj7aGifUwECQzDF/bGRrQrz4OcLB24/m
         nZLfijxaQQe8I3KygkzwGX08mF20LeBVVbUUJac4ZwngwPyLVwW8ypYvc/AKBtp019IY
         OHDKn8vwEIgK/piOv2LkjSmA2xgI4suOVMHqs4FVPQkwaCYQpqQmpIumNGNvawQIYabB
         9qD7mdWXpDh2khU4cVHeEhxhv0J+JLSJSkolvDB7Va4u0jk96oKdVs6b1vZ97fyCWhfd
         GyRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788021400; x=1788626200;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4OSi7MMm07peXNc9aOu04WCVC9TQOGqHoXbsa8tJFTQ=;
        b=X87aMAesCTWZDU8ckKsS+odLuXmNVHiXzOAIbTmafE7vWW2Hcbhepvbj4NZYNbd+wH
         aVR375l2fODx4LlxDmc0Hoqyhi5vATYKTyXN2AshAUNJyRTNLKNxWmMgW2RO9O+HFo4e
         TdsHCgDm1v5RZiZ0+7Y61owW/BNNpBtuh7Aeei7Q3HiNRDWkm5YtRTL0Adc2meP+lZkS
         xc+hJvdZFeRikQmqxtV9AaD9FyCzX666O9zQE45KpJHtNWwW8BfWeIEGNkkHEidDHzZd
         293hw8dFmtiH+DSVeTM7+Gfv38bP4psJrjlNJ/BvayD8Wzff9ccfm4TeqT3OQIIHcM0a
         6yug==
X-Gm-Message-State: AFuF++lopCLl/qi23Hx9wGGYWrXFiT9UWgBfWD753bTvdK2hAcanzlNl
	P3yetq17n0Yb1FKb7BOs0VGTcwiqS9B4YG+HMMJgBQn7S3ZG1wBIfw6g
X-Gm-Gg: AR+sD11yu3DlA8/AFiHlF6U/3SDwTaZl1TObn5fcMqrqLhJ/iC59AKfeb1b3RMjKW1c
	GLwWw3jb3CFfFKUSf7oSfDKLkWZeMDc9ltQCk+85PNKJM7MEnaipkbyE8FOiMlUkBprxX9gUXFJ
	7sevVShUc/G9qnyr2RFGiPsbMA952XARAgzWRN7HTqx92Bcdv5pG/KgpAVQr9YMCrD5Ita5yrr6
	nGopZPXnqtRcWahO/Q5Q83C4PcG9q06E0LTSJ4NOs42pw9orNqs6xMIs13gLsfL4qbUFCEDPLbZ
	r25khqAyLhJwPXj/QOIPsJHA6TRgwQiHtuHgjqn912BOh7HXyyRh0DfgxcwmaVa4V43Gtv9cVEU
	RFMWC5J8qpk54e8wcLs3ZKITVO5KV4lTkGMlw/uiOA9//YmrhXAMleWumfSeeqqaBFhjgqk5nfu
	0fl81IN+OuC5ewHiq5uaxmUVEIiifvDMgHXK69Ia2W8MMZD9/FVApapHTpfnIp3n3M+X3cgdDe5
	w+3FQzxBsBwAyjWuNqJ2DBCtxgV/hC9ixrrO+UFK9sdHtZj0Ohydn7ydNTC4v+qjcMWNc5WaY9E
	bfl32t4fyS42JwIeJcTdX7Us1/zQvdsjJKIjChcXyUUP2eAkHi+bigfB1IwOw8mhiRjaQvHIGB1
	JK7q/QaJ5nBiOIEBPrT8r3k/TJfQ4dHY=
X-Received: by 2002:a05:600c:1d08:b0:499:bf0e:95c8 with SMTP id 5b1f17b1804b1-49b91c2e145mr237756535e9.1.1788021400014;
        Sat, 29 Aug 2026 09:36:40 -0700 (PDT)
Received: from systembl0wer ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbb32d30sm11662342f8f.34.2026.08.29.09.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 09:36:39 -0700 (PDT)
Date: Sat, 29 Aug 2026 18:36:38 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Crt Mori <cmo@melexis.com>, Puranjay Mohan
 <puranjay@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/11] iio: temperature: tsys02d: make headers
 conform to IWYU
Message-ID: <20260829183638.607526bd@systembl0wer>
In-Reply-To: <20260829-kernel-header-removal-v2-11-c67739d5dedf@gmail.com>
References: <20260829-kernel-header-removal-v2-0-c67739d5dedf@gmail.com>
	<20260829-kernel-header-removal-v2-11-c67739d5dedf@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 29 Aug 2026 18:26:08 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> Remove the catch-all kernel.h header, add missing headers and remove
> unused headers.
> 
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---
> Header changes explained:
> Added:
> - <linux/array_size.h>: for ARRAY_SIZE()
> - <linux/bits.h>: for GENMASK() and BIT() macros
> - <linux/i2c.h>: for i2c_client and i2c_device_id
> - <linux/mutex.h>: for struct mutex and mutex_lock/unlock
> - <linux/sysfs.h>: for sysfs API
> - <linux/types.h>: for fixed-width integer types (u8, u16, etc.)
> Removed:
> - <linux/init.h>: not directly used in this driver
> - <linux/kernel.h>: catch-all header no longer needed
> ---
>  drivers/iio/temperature/ltc2983.c | 1 -
>  drivers/iio/temperature/tsys02d.c | 8 ++++++--
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
> index b8deb9aa9d48..6c4de6854683 100644
> --- a/drivers/iio/temperature/ltc2983.c
> +++ b/drivers/iio/temperature/ltc2983.c
> @@ -11,7 +11,6 @@
>  #include <linux/bitops.h>
>  #include <linux/completion.h>
>  #include <linux/container_of.h>
> -#include <linux/dev_printk.h>

Ugh, how did this stray change get in here? Must've been
a bad fixup...

-- 
Kind regards,
Joshua Crofts
