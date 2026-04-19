Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D061287257;
	Sun, 19 Apr 2026 17:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776619738; cv=none; b=ha2yQbbHzHhIZUTb1cbb30wdu549T0A9U2tkhrVnsqWdcWeBweUrJrqBhEKfJT2VmxN/RYQDWVJ+8fBkD5rjG92qFyN4aAxhwiywqV2M0jeWOmVv7r4R9CTNVVIfNOH97OO51HjGdtGONVLagbpV62fbH1wstagcykjgfBBD8Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776619738; c=relaxed/simple;
	bh=nG1QbJuzRuPOHbqJ8bI8ZCcJXovGLw+NF0udyjmR9ko=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XgCokzHRIgsQkpTOyIjJPMcdeQkFxGQoFAMqxoJ+0bb7azj5snoI163cp6zhjvkRgge1zQXcq2EMYBUPDGlc7OACQyvJel2fNuLU2vQKH23NQ83QQA+vXcQOT/aN8CWW5e/wkIqonOn33C13qS5CL71swdf/VeZf6OsdHBtW0Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQETjFMt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQETjFMt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 213C6C2BCAF;
	Sun, 19 Apr 2026 17:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776619738;
	bh=nG1QbJuzRuPOHbqJ8bI8ZCcJXovGLw+NF0udyjmR9ko=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DQETjFMtsVMNAkIn0PPekAsDJ7IDIgGbXzl3BbeMWjEpieC6ykkjHaOfkHjaUbqcs
	 EdnUncCTHp2AW8t5TE8VNLBxh5dqsKj7NRE6faN8lyPyM2Gts08kj8YPCmyiSwLWRB
	 fRvjgC31JWu/XE489HCaBRAlSmKsniEjfUNaz4XR8fZ2Y1lQM8v4YtGhPknpjxvfKo
	 B8UbCDHBH7Qhu0KARW361wA2xLFeNWlNSFee8pVbkm1vjObf6VlXPjyMcTXccnwauK
	 tmm6CP67QrRph0K7U2+k8KUR//ML1epIgUDSiaSZ9UlYtjmAUZaBIYzF8KqsLyct69
	 A5tDUbPwcU5UQ==
Date: Sun, 19 Apr 2026 18:28:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 tglx@kernel.org, christophe.jaillet@wanadoo.fr, mingo@kernel.org,
 nabijaczleweli@nabijaczleweli.xyz, kees@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/7] iio: ssp_sensors: cleanup codestyle warning
Message-ID: <20260419182848.7c6182b8@jic23-huawei>
In-Reply-To: <20260415050749.3858046-2-sanjayembedded@gmail.com>
References: <20260415050749.3858046-1-sanjayembedded@gmail.com>
	<20260415050749.3858046-2-sanjayembedded@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Apr 2026 10:37:43 +0530
Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> Reported by checkpatch:
> FILE: drivers/iio/common/ssp_sensors/ssp_spi.c
> 
> WARNING: Prefer __packed over __attribute__((__packed__))
> +} __attribute__((__packed__));
> 
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
In interests of cutting down on how many patches are in flight
I'm going to pick up at least the first few patches from your series.
If another version is needed for others don't resend the ones I've
picked up.

Applied this one.

thanks,

> ---
>  drivers/iio/common/ssp_sensors/ssp_spi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/common/ssp_sensors/ssp_spi.c b/drivers/iio/common/ssp_sensors/ssp_spi.c
> index 6c81c0385fb5..8c1e15d61db7 100644
> --- a/drivers/iio/common/ssp_sensors/ssp_spi.c
> +++ b/drivers/iio/common/ssp_sensors/ssp_spi.c
> @@ -29,7 +29,7 @@ struct ssp_msg_header {
>  	__le16 length;
>  	__le16 options;
>  	__le32 data;
> -} __attribute__((__packed__));
> +} __packed;
>  
>  struct ssp_msg {
>  	u16 length;

