Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E352339705;
	Sun, 18 Oct 2026 02:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792288929; cv=none; b=fXVN3ZpFtY79YBLg4vJs6XO2Wo/bb6EZpW8fwLo9gpSB1Hz13fAfRk1X33QFWtFgv3ER4o18Ow5SUUXKKiUj06BdfOWOP2Tr/t0D3NSEZiK9eaewxb9Qzr+97xNOHat3RD7hlKfAQSC0rdsL1925KR17lOnZD8lpsbMu6fsAm3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792288929; c=relaxed/simple;
	bh=3abZHzWEexrxG6KWsW5D60qc64awaTM391LkHB/KkzU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hn/oyP8MZRAYYvCSP/rh/aMVfd5bXOYcw+So1atJeqxLAxudx0kAngQHkZ/hhwry0v0p+21EabXlfgWnUJ58Vt2KnFkO///UrRjKdiCiHxk3SBMVtvKZBpnWNK7PH5gMqqU3+3dC2B7LvJJ4BsSEsVMe95wrntbvfo4OrHR25GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3XIATOe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3XIATOe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B2771F000C4;
	Sun, 18 Oct 2026 02:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792288923;
	bh=uIgX3j6t/32oz54/9mAoGM9KoupuZpKcsXvEIrGuhyc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=m3XIATOeZ7WRvIGwSHVesFMUgivBlpYcIjPFkm/hSRx3xZIsCqI00qbM9uLZR+sKK
	 dUUPJmCBrNhQzYMBRs+nzaVmoJQ1rc1V+smkMQ5kBKrnXXx44QCle8EMq8Ye3838xa
	 yWmE2gnIoNUTeB8Z4B5rSzlOU4fzVi0UwvFRy+t6OgF/Yjy+wT7ShAzkH+YRzd+vjH
	 sImXyGvbFeTHs9gGcrHqt+12ZOfu8wSOAQ/7cx3poWv2paXKjtyFes9m08nJ+l3Dfp
	 HQ087F/Okwhakq7Bt7uxUAU8GeqTt3bOowSvQ/sCoGuorJtyjkiicrxx6Vl40Umy2k
	 ruw+RSYU+++bg==
Date: Sun, 18 Oct 2026 03:01:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Sashiko
 <sashiko-bot@kernel.org>
Subject: Re: [PATCH v2 0/2] iio: adc: ti-ads112c14: minor fixes
Message-ID: <20261018030159.6aae16cb@jic23-hlaptop>
In-Reply-To: <20261009-iio-adc-ti-ads112c14-fix-settlingtime-sign-v2-0-6b54a7378101@baylibre.com>
References: <20261009-iio-adc-ti-ads112c14-fix-settlingtime-sign-v2-0-6b54a7378101@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 09 Oct 2026 17:24:56 -0500
"David Lechner (TI)" <dlechner@baylibre.com> wrote:

> Jonathan picked up the filter series for TI ADS112C14 already, but there
> were a few minor things Sashiko found that seemed worth fixing.
> 
> https://lore.kernel.org/linux-iio/20260913211128.25734544@jic23-hlaptop/
> 
> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
Give you are building on the driver with other series, my inclination
is to not rush these.  So for now I've applied them to the testing branch
of iio.git, but shout if I should do differently!

Thanks,

Jonathan

> ---
> Changes in v2:
> - Change settling_time_us to u64.
> - Link to v1: https://patch.msgid.link/20260925-iio-adc-ti-ads112c14-fix-settlingtime-sign-v1-0-1fd53e7242e8@baylibre.com
> 
> ---
> David Lechner (TI) (2):
>       iio: adc: ti-ads112c14: fix negative settlingtime check
>       iio: adc: ti-ads112c14: fix settlingtime creep on write back
> 
>  drivers/iio/adc/ti-ads112c14.c | 34 ++++++++++++++--------------------
>  1 file changed, 14 insertions(+), 20 deletions(-)
> ---
> base-commit: d8c0f48f0b1583308a98401c0c7b1a65d1d43a6c
> change-id: 20260925-iio-adc-ti-ads112c14-fix-settlingtime-sign-a8e34f974d24
> 
> Best regards,
> --  
> David Lechner (TI) <dlechner@baylibre.com>
> 

