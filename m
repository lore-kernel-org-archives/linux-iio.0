Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17B33C0A0E;
	Sun,  6 Sep 2026 17:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788716180; cv=none; b=PD1A0LAj1nprDYRD6CFYeZCN3KhTXwOHv4ncJVaeMMWhE8+I3krGVgV4lXjzNA3kKpuJtcIcq7N9QhUYod0vQ7ivKO8lrWJNkTOhF/KNdYCgrE05l/LHjiCJrysRHBNoCp6t7yn518clFPiXzHw3KCcQ/fdPUbNmy3h8sFVU3cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788716180; c=relaxed/simple;
	bh=Y9Giu1+OMfdJ3SzWiJCOrTtnmsAlSOxFRJvchxWtEAk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tnIw3n3QTBcqy1YnDVzA+ZrmO+e4O/0lDPxMX1uxxummBFZSHXY4iorM5w4zYQbYaUPAofcN6GjLh7SFH0YA5G4lpTz+tudeDavbkAopG26Zch/LUSaqInXQv9wjLNvwkGs6cFtOMq0v3P8IyxvpiHyxfC50A/nkJwNdXvgg1qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etnTAlcd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etnTAlcd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B081F00A3A;
	Sun,  6 Sep 2026 17:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788716175;
	bh=tQI50zAlpRNRl7CNe3z23eRiYtts28BaDCn5eRT3PKY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=etnTAlcdyW49WLTIO6+24BzpYy3B3zpdaEfduraFJDISbmru+pkZoNgxaBX3szNPl
	 S9Vp2AwtgOLg/M1i4tRzMW/qqmy3VylqBPGnOooBoW/nRNzqbMhy1l/y2Vq8Dhlp5H
	 iGryy/5ndmOD/U0Vus86WbLBfnYU5FqSTdIR+HDT1DXckxHPTo9EDdYWNnY1amB0lW
	 ZOsRyt9IUNSMqlbRZiv5k9CiGKSMjTHCjkVc2zs5LvKeIW1s8zzLbzgv4HBvEztmwG
	 zu0ChVCeWiYop5pVJ37ntLKuHytj51Xl3+mJPEAoqw7QQf4DNmuoNEauAcO74rMLhb
	 EZn4YafavVTFw==
Date: Sun, 6 Sep 2026 18:36:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Felix Gu <ustc.gu@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Chen-Yu Tsai
 <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel
 Holland <samuel@sholland.org>, Quentin Schulz
 <quentin.schulz@free-electrons.com>, Maxime Ripard <mripard@kernel.org>,
 linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] iio: adc: sun4i-gpadc-iio: two fixes
Message-ID: <20260906183610.24d09404@jic23-huawei>
In-Reply-To: <20260906-gpadc-v1-0-92d3dc8ef355@gmail.com>
References: <20260906-gpadc-v1-0-92d3dc8ef355@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 06 Sep 2026 23:58:33 +0800
Felix Gu <ustc.gu@gmail.com> wrote:

Some text here would be normal even if it doesn't add much!

Anyhow, both fall in the obviously correct category so
I've queued them up on the fixes-togreg branch of iio.git
and marked them for stable.

Thanks,

Jonathan

> Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> ---
> Felix Gu (2):
>       iio: adc: sun4i-gpadc-iio: drop underflowing pm_runtime_put() calls
>       iio: adc: sun4i-gpadc-iio: clean up on thermal zone registration failure
> 
>  drivers/iio/adc/sun4i-gpadc-iio.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> ---
> base-commit: 9d80aa4617b32f5054c5aa471d06b66704854935
> change-id: 20260906-gpadc-d41b964d8f17
> 
> Best regards,
> --  
> Felix Gu <ustc.gu@gmail.com>
> 

