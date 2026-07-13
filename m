Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3889E1A6834;
	Mon, 13 Jul 2026 00:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783903342; cv=none; b=FD2rcAQZNo7CcVt1WBTcOBnxDDatSPLkqRBohJUb51vxTMNTkY9wmvALpZetVAjxnr0g346xhiB3smD54Qb4nRz0VXzSb0077mlW0k0mHRTHl8diQNwrMKGhWqv01yPOilXPbi8cfN4LnrjY4e1QuJRAw4h5di28ut6yR0QrMNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783903342; c=relaxed/simple;
	bh=QEIaD8hTs0ScmuOJJVzqKP7PnJ26SgKybZY/s2QiZGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=slmef9gAjZsFc5EHpedw2febk0GP5S7EOPvN5IAFi3ggbdZOvihfWs2Q5yA6vcOU3vKUVP60rMe9K86UjRL0QjLsORCOzcy8h3I52v6r/d75MMbKixbyj8up2cyjpwakMbzJerXFXYg4QHNHftzX8BDIUnB20FKaQFckf3AyqXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzu/zE19; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzu/zE19"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF7D1F000E9;
	Mon, 13 Jul 2026 00:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783903340;
	bh=ycmylFCKYEhpouHBwht1ZLrKYUJhrM30x/8UQc7SEI0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kzu/zE19+oGzQAX71ZMIG50s6Ljrj6kfyk7tVu+3EKXznqYkXbgCes8GsgVfQCF8j
	 RqrZNijSxljXT5CdPcJa0LUnFgVBKNdfTgx6ut3tvXMoA2jVBSDk3T8EPgDz+PiN2c
	 Y2pw3753tQwG+kSYVIr75mK436uB109DRe0vTD9W9U8rqxbVMTE0f5NIf0M1XX0/sM
	 4blunA+6p1MgC6l83Qpsdz/5Irvsu/nFk0422dYwOmIOsy8NmIVNgF+4dVBKiZjDwc
	 /KqRdOsm3y+x9OiedHSq+geExXmPMelhkop68jRTLDZWt24jyUlz4klPx4GrPtEbfj
	 D/a6XjVdiF8tA==
Date: Mon, 13 Jul 2026 01:42:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nikhil Gautam <nikhilgtr@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Stefan
 Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/4] iio: light: opt4001: Fix read-modify-write of
 wrong register in power down
Message-ID: <20260713014214.74a12af9@jic23-huawei>
In-Reply-To: <20260712202451.20822-2-nikhilgtr@gmail.com>
References: <20260712202451.20822-1-nikhilgtr@gmail.com>
	<20260712202451.20822-2-nikhilgtr@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Jul 2026 01:54:48 +0530
Nikhil Gautam <nikhilgtr@gmail.com> wrote:

> opt4001_power_down() intends to clear the operating mode bits in the
> CTRL register but reads OPT4001_DEVICE_ID instead of OPT4001_CTRL.
> The device ID value with the mode bits masked out is then written to
> CTRL, corrupting the conversion time and fault count configuration.
> 
> Read the CTRL register instead so only the operating mode bits are
> cleared and the rest of the configuration is preserved.
> 
> Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>

Fixes tag please (you asked in the cover letter and yes it is appropriate
even though these go all the way back).

Looks correct but I think we can take this opportunity to simplify
the code whilst fixing the issue.

> ---
>  drivers/iio/light/opt4001.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/opt4001.c b/drivers/iio/light/opt4001.c
> index ba4eb82d9bc2..f2cf496cc243 100644
> --- a/drivers/iio/light/opt4001.c
> +++ b/drivers/iio/light/opt4001.c
> @@ -228,7 +228,7 @@ static int opt4001_power_down(struct opt4001_chip *chip)
>  	int ret;
>  	unsigned int reg;
>  
> -	ret = regmap_read(chip->regmap, OPT4001_DEVICE_ID, &reg);
> +	ret = regmap_read(chip->regmap, OPT4001_CTRL, &reg);

Let us jump directly to a regmap_clear_bits()

It will fix this issue and generally improve the code readabilty.

Given this is only called in one place and the code will be nearly a one liner
after that change, lets also just  move it directly into opt3001_chip_power_off_action().

I my opinion all that is just about fine in a single fix patch, rather than a
separate fix + code cleanup to follow, but if you would rather split it up into
fix first then refactor I don't mind.  I may well decide to mere this whole series
for the next merge window anyway just to ensure it all makes it reasonably quickly
(at expensive of the fixes making it in a little faster and possibly delaying any
cleanup).

Thanks,

Jonathan


>  	if (ret) {
>  		dev_err(dev, "Failed to read configuration\n");
>  		return ret;

