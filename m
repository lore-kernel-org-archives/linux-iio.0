Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966552E1722;
	Sun, 23 Aug 2026 17:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787507659; cv=none; b=ZF2M57IjIWp6pkAnd48p0cOFiy5kcnsYkZ1tZUgx8BOESVy6fpzhzAXHFHBWStoVD2ktX67KSW9AgCTOP8PyyBZLK7ftNnRXbNTfMrkAlqs1qGRONxu99qark/E/x6wzfeaoPAOg4LoQl4We+3iN1IQLZ75TPreniPS5e2nuMns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787507659; c=relaxed/simple;
	bh=L0b76RO3gpjT7tIt832OlfePj6CMIFyZxs3hokw0awA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N/RpIRE8bzotOkTzuUjM+bwQ2xpmZj9/6Fhl1Kl4Kdu+V/b6tnzgtsuaQ12xhQLp6793L7OLl4G6OSV2DUglTptTBVa1dOeDUN3Fa26ehOVChbtNaI4LoYMxRTIMGPXhOw0dXdq1JiFJ8adwGyEUk4yH7sf7cdEQ+x2MLP6k1BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j87pUFAo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j87pUFAo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB5D1F000E9;
	Sun, 23 Aug 2026 17:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787507657;
	bh=iE06MUFmXX9wgPtWiOwDe4rGxUCom7GBuElMy7mTu8k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=j87pUFAoCSuPjVc39gECDhnx2kgUBeVN1hkfGWhrZsr9xZNxxIT7ivYsgrzU50zsz
	 +Ly4A7L7WZj/IfTAG2AdtjoaWhABVC0myv/qZhHxvZgYzqR557j/UAKXGmXWfmiBBR
	 DX5IsDraE8ub0Itd1EEyyWfpQSSu4sEJIokmgZ/Havhiom46lLEjnQjH980Yvhz5Oq
	 Uzv3T8qUQPs6NjjMiv5pVrh4VsqMomxBZ15xfwXRB43xF+ds1llTKWhyzRy4eNPmfR
	 iIpLoQaAUACVYIWEO1rO579KJds2ofUFRRKUW90IWb/7Q42dWPaS/nbPvtwd7NHY8g
	 Wu6AkgzW9VuHQ==
Date: Sun, 23 Aug 2026 18:54:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Crt Mori
 <cmo@melexis.com>, Puranjay Mohan <puranjay@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/14] iio: temperature: mlx90632: sort headers
 alphabetically
Message-ID: <20260823185413.11af400e@jic23-huawei>
In-Reply-To: <20260822-kernel-header-removal-v1-5-ee31b124be11@gmail.com>
References: <20260822-kernel-header-removal-v1-0-ee31b124be11@gmail.com>
	<20260822-kernel-header-removal-v1-5-ee31b124be11@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Aug 2026 10:02:32 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> Sort headers alphabetically to improve readability.

Whilst I don't really mind these being separate patches the main motivation
for doing this is to make it easier to see what is added and removed in the
next patch.  When only one or two entries move in the reorder it matters
a lot less.  Upshot, you could combine this with the ones making actual
changes.

Jonathan

> 
> No functional change.
> 
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---
>  drivers/iio/temperature/mlx90632.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
> index 2fde48f337e2..73c935364d33 100644
> --- a/drivers/iio/temperature/mlx90632.c
> +++ b/drivers/iio/temperature/mlx90632.c
> @@ -16,8 +16,8 @@
>  #include <linux/jiffies.h>
>  #include <linux/kernel.h>
>  #include <linux/limits.h>
> -#include <linux/module.h>
>  #include <linux/math64.h>
> +#include <linux/module.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
> 

