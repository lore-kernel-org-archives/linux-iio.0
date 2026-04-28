Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B6E43C061;
	Tue, 28 Apr 2026 15:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777389268; cv=none; b=BkZZQCRmoiBYfTSrpdnw1MmFn8m/MPLb11A51MGswu3Ie5hNB6LmHmRK6sO1PLxCP+oxL1ZSmoXoHUVi9FZReeTa7a/d0Q4j+Q9VdBsk6QA3BoEYe5pGC3geg7XhcnBCtLIS3OIfCbWfUB2UXLm5wXiMe7rWKrJ6GvwY6PXYUQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777389268; c=relaxed/simple;
	bh=kJk01xYl5EtP/dp9wx8zlb7AmLmRvRGIw2Ub8CC9gmw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L+o6AoG8sBBrmGpBsT6zTfhRzUL7cPWBXHbXV8zhpu5TH5jrkkHajA4hp0enjyUyFLgGltD9xaZHDPkJMUS7tpmcVRGvYSh4CzdfxrqaSxVDVQToKcjdCL5zt6sgIO6uG7i0KiohxhpZtf4wllf7hgc9MDSGxuR6s57fhxK/Gps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KPtT39u5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPtT39u5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83ACEC2BCAF;
	Tue, 28 Apr 2026 15:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777389267;
	bh=kJk01xYl5EtP/dp9wx8zlb7AmLmRvRGIw2Ub8CC9gmw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KPtT39u59XwuvTo+eOgP8s50p9FKMl1i2PZHOrK/42Nts3RF8M4SPN0NBsT3215JY
	 xk2KiFB4/4vL4DC2uBWgSMoCck2rAXGCwm9IfzTlVx5nc0W+s+lDkK+n8PGaheDG/h
	 fGfMv6KWI6XbxEOvsXG1tiVcmpJe1NPjlqps3edoI5mgmABSd+MSAmxN/sTy4s0a3l
	 K8tHcJhzwFcfGJHTiu7uwr5Dshl7ycLR/qav0tHhkYLKWb8bdUR3mvygWGUosH2elt
	 3EkZMdj5TapoY/VgAYCeSe+QZ6L1jIq1FupT9bWbsVzmlC2nhevxZBmP3C0LYV9ZUD
	 B6TlsDMKKajdA==
Date: Tue, 28 Apr 2026 16:14:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Cc: joshua.crofts1@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] iio: light: si1133: group generic <linux/*>
 headers
Message-ID: <20260428161417.20b73314@jic23-huawei>
In-Reply-To: <20260428-si1133-checkup-v2-4-70ad14bfefe2@gmail.com>
References: <20260428-si1133-checkup-v2-0-70ad14bfefe2@gmail.com>
	<20260428-si1133-checkup-v2-4-70ad14bfefe2@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Apr 2026 15:18:36 +0200
Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:

> From: Joshua Crofts <joshua.crofts1@gmail.com>
> 
> Group generic <linux/*> include headers to improve code style.
Not particularly important but you could mention why these two are
where they are.  For the unaligned one that was a mass replacement
of asm/unaligned with linux/unaligned that didn't reflect local
ordering.  No idea for util_macros.h!

> 
> No functional change.
> 
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---
>  drivers/iio/light/si1133.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/light/si1133.c b/drivers/iio/light/si1133.c
> index 5c5c5ae0535a9592522c0b21496f47068044c6ff..f2a79675c026c86bb56d85a65cd035d7540d0ef8 100644
> --- a/drivers/iio/light/si1133.c
> +++ b/drivers/iio/light/si1133.c
> @@ -21,14 +21,12 @@
>  #include <linux/mutex.h>
>  #include <linux/regmap.h>
>  #include <linux/types.h>
> +#include <linux/unaligned.h>
> +#include <linux/util_macros.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  
> -#include <linux/util_macros.h>
> -
> -#include <linux/unaligned.h>
> -
>  #define SI1133_REG_PART_ID		0x00
>  #define SI1133_REG_REV_ID		0x01
>  #define SI1133_REG_MFR_ID		0x02
> 

