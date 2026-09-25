Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501C432ED3A;
	Fri, 25 Sep 2026 02:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790303393; cv=none; b=tIW1zl5cJ78FreBEbk63Qr8W448Ndgl9C+XSYJttk1+1klF1HpmlKfk2VzzNLUEHPGZya1ZLJXrzofF7uvntF7W7633YdtumUHWTKUk2IXh1if0plHIsdjJV6iC9oggjZSCZCDRHMWH4EZadEhDeWtXEg0usqgLpgbbnYcMN3uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790303393; c=relaxed/simple;
	bh=ACy/nwsB7HpWWLMAcb80jIHOeANVG0WMuOfpC/whvag=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dMUA9G78/mGZ+5udWWqynd9Cz3TfSQ9dG+yrXdXhon9e7sB4be33DzzX2bKVKrIMsrW3Zm/DS8G46ARS9xZ8czVn35s6rig83LZJh28Y0IOGx9NrPKOzyjQta0BRxMLsCIwoDRHg5vY972ATmzP/W9lMRQkG2Fdr6Uv7cN5Ckuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2JHtYmj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2JHtYmj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F4B1F000FF;
	Fri, 25 Sep 2026 02:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790303391;
	bh=Ngpk8/dnM3nM0hAqPjYNe/Wds9b4ejVfy/0iVorRQNw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=C2JHtYmjwKSGZCsVGVSw4qz6euuRZUEnAVIjxGYAFC3N4nPtyK8Dkmrv9JCtFqGB0
	 L0N+7CfTOMpVSam7jLYx68D+cI5i9BQqvKcaDs98ipUj6AUYwJfuh+oXH6WRHmRXne
	 5LBiIuSHQx/mPVtvCBHiI4RX0Gu5bcO8r0rJrT59lru57r+d6mnbV+vJsDh7pxvkbp
	 sJpH3exGpdY8R1BM/GKXoHjYACfKicY2y16076WxB8SpmWowLerZiWCibiP2KYOqP+
	 HGmUuXvupVeN2H1BfJpW9CURQe+C5gDHWOXkJQ3ZlbTkM3uNgAAOXmVdjJ/R84ca7c
	 OnZ6HfvUnwdZw==
Date: Fri, 25 Sep 2026 03:29:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v9 0/5] iio: magnetometer: ak8975: driver cleanup
Message-ID: <20260925032944.5855136f@jic23-hlaptop>
In-Reply-To: <20260920-ak8975-cleanup-v9-0-1b0f00ec19ef@gmail.com>
References: <20260920-ak8975-cleanup-v9-0-1b0f00ec19ef@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 20 Sep 2026 20:05:22 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> This is a 4-month old series that I had in my working tree and
> completely forgot about. It's a continuation of the ak8975 driver
> cleanup that Andy and I worked on, all that was missing was to
> implement Jonathan's powered_on bool idea. The rest of the patches
> have Reviewed-by tags.
> 
> Very sorry for the long delay :(
> 
> Original cover letter contents:
> 
> This series is a continuation of the previous ak8975 driver cleanup
> effort, as most of the patches were picked.
> 
> Changes include:
> - using BIT() and GENMASK() macros
> - moving to devm_* resource management
> - adding a scan index enum
> - moving from using wait loops to iopoll functions
> - various code style changes
> 
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
Applied with the tweaks called out in patch 3 (and a commit message
to mention that was rolled in).

Thanks,

Jonathan

> ---
> Changes in v9:
> - Add powered_on bool per Jonathan's review
> - Move forgotten dev_err() call to use a local dev variable
> - Link to v8: https://lore.kernel.org/all/20260518-magnetometer-fixes-post-pickup-v8-0-088d610108a0@gmail.com/
> 
> ---
> Andy Shevchenko (4):
>       iio: magnetometer: ak8975: switch to using managed resources
>       iio: magnetometer: ak8975: unify messages with help of dev_err_probe()
>       iio: magnetometer: ak8975: use temporary variable for struct device
>       iio: magnetometer: ak8975: make use of the macros from bits.h
> 
> Joshua Crofts (1):
>       iio: magnetometer: ak8975: add scan mask index enum
> 
>  drivers/iio/magnetometer/ak8975.c | 213 +++++++++++++++++++-------------------
>  1 file changed, 107 insertions(+), 106 deletions(-)
> ---
> base-commit: 40288c9206c17eb66a603262e06a58d300d0f279
> change-id: 20260919-ak8975-cleanup-206e303af804
> 
> Best regards,

