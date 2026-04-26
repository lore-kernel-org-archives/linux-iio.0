Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E91363094;
	Sun, 26 Apr 2026 13:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777211602; cv=none; b=Uq53H55T49yxH4nrdAJT8oofsmtOzMdpj3IhFKbZwLtHtDzkCnxfeLiOEPZszy4+c4pvZiSZYFHh50QA4Lc1Vky+jQSGjJAk0ndZ0yqaLF4EQwpViQO4Uh8xQl3WeZcmlN2t+5qZc1ftHxci+CV7plsQb2diz9Xhjd/r+Z4nSco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777211602; c=relaxed/simple;
	bh=hqwEMoittJ/V/9u2sjaWcPTfCNftXJdAPkzIMIjI/Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ihGESOiGSX6dr7F4HtvZQY7sdkoTHwKZatxKFGfsfWQqg2Jmvu8mScx7XRNi+7SsVZvYZ29fupHAtuKITpDeRfKoA4C016RMSsBsi5UYc/BIbOxUES5DnawpBX4Duw0El9AylkQ42Q4TwuqH/UFPCCZkef2xVySiboMnStXiQ9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gceu++xo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gceu++xo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F72FC2BCAF;
	Sun, 26 Apr 2026 13:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777211602;
	bh=hqwEMoittJ/V/9u2sjaWcPTfCNftXJdAPkzIMIjI/Cc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gceu++xoMkF3ONzLPjDVNMXykQUYz0mOZhKooYTPGNlFoWqfKEfeq+xLUzRmP2Kif
	 vE8jmsBLhZgBk+TKHHVafGGiR7PRRnwtksp5aKopKoIELaU3XtNeUg/fsGDJm5P3eJ
	 TRkN+7vdp7N3vdoPhzpRrmPE/GmOtm9KOfz1Wl21LwnytgYZp6p3XeGi9jSbrIY4yG
	 J3AWJ8OkfVbbLHBIIbdrhHe9zW4kVgG/prdwJeAU5WDzqw/zvCSDNBwDrOmBoeJbdm
	 teuoPKUtiT3dTPBa6Y5GCt6M82TUVaLf20DML2Pk4jjPttdkuAGpU6Nol6yucZA3bO
	 1R+2/LB8hKBYQ==
Date: Sun, 26 Apr 2026 14:53:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 mingo@kernel.org, christophe.jaillet@wanadoo.fr,
 nabijaczleweli@nabijaczleweli.xyz, kees@kernel.org,
 kyungmin.park@samsung.com, k.wrona@samsung.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/9] iio: ssp_sensors: cleanup codestyle warning
Message-ID: <20260426145312.06bcd30e@jic23-huawei>
In-Reply-To: <20260426091710.3722035-2-sanjayembedded@gmail.com>
References: <20260426091710.3722035-1-sanjayembedded@gmail.com>
	<20260426091710.3722035-2-sanjayembedded@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Apr 2026 14:47:02 +0530
Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> Reported by checkpatch:
> FILE: drivers/iio/common/ssp_sensors/ssp_dev.c
> 
> WARNING: Prefer __packed over __attribute__((__packed__))
> +} __attribute__((__packed__));
> 
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Applied to the testing branch of iio.git.

I'm trying to pick up some of the patches on list just
to reduce how many are getting sent in new revisions and
the time it takes people to look at them each time.

Not sure how far I'll get in your series so look out for
when I stop saying I've applied them.

thanks,

Jonathan

> ---
>  drivers/iio/common/ssp_sensors/ssp_dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
> index da09c9f3ceb6..7d07fae295fd 100644
> --- a/drivers/iio/common/ssp_sensors/ssp_dev.c
> +++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
> @@ -28,7 +28,7 @@ struct ssp_instruction {
>  	__le32 a;
>  	__le32 b;
>  	u8 c;
> -} __attribute__((__packed__));
> +} __packed__;
>  
>  static const u8 ssp_magnitude_table[] = {110, 85, 171, 71, 203, 195, 0, 67,
>  	208, 56, 175, 244, 206, 213, 0, 92, 250, 0, 55, 48, 189, 252, 171,

