Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01052E1746;
	Fri, 21 Aug 2026 23:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787354255; cv=none; b=PKwk1t2E566ve1Nv5y8WJdrf+DOIZwjNrLu4t+PXUEfNJ/RsDJXhU7jMXYweyhBjVE1dWKWNHRxQRqmUmJD3yhW4uz/gpWnSTcH9HNkIXvi+mPLu3TSc2i1cDQZT85RCvnqnhfEXuSMJJGwLAluiLOut1bzAww6jmjRlsbwXnQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787354255; c=relaxed/simple;
	bh=wruGzQ4R1zkKSo26B8COubgG33cyKtQ1V/ioBCY2NlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KPzqGgYKew8gyLTqoI8NovyVUJrB6LpZs2wIpwamVbjNFRBNgQmAAgmyNCjZhrRzrqrN9WNmjXr4LFHajNjPRRJ5lH3i618wGkYbRH07cU9O2V9EZs5yjIcYtVF5zW8Kb5N0NXbsumDxjkkafWL0O0sKFrHYtDnMDSnFyrq28GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJe2+Zfl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJe2+Zfl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 374381F000E9;
	Fri, 21 Aug 2026 23:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787354254;
	bh=qBeQTJcCmTxIDyDVZ2wxVHaFWGBCccQSYczu6X2wyEk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IJe2+ZflygN5/qQJs4Sul1DBia5fxrGgdQohUaB3jzKfnrtMSH4ZHvJhaeEsC5FVP
	 F1E0a2XXNtVJtP8mFfDhifzM5zU1zMSV7JRN1moBeLkXs6MRanagHOf/s95I6v0Y4M
	 bDC0o4EmIxgwX+lGwlfuQdIqDN7rmLsIVRufIZY+5Du8O7tkptIvawld1tmacSqyMz
	 1xPdrxhjB6xGH4rbDL/B1ci1KEkY1iNHbWZz5FwsSGsLriC+cdZIHwS1fTRCOL4q8s
	 aR6U1QB1NS2gKwcHjUT/0Bal6twKD0Wb2xbvKfitz4bUXm6v5gDLIgCiUYY/ETlWL8
	 oW3/lX/qP92xw==
Date: Sat, 22 Aug 2026 00:17:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vladislav Leonov <vlad@zlab.su>
Cc: andy@kernel.org, dlechner@baylibre.com, heiko@sntech.de,
 linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 nuno.sa@analog.com, sjg@chromium.org
Subject: Re: [PATCH] iio: adc: rockchip_saradc: Add support for RV1106
Message-ID: <20260822001728.32f706c5@jic23-huawei>
In-Reply-To: <20260816114544.35502-1-vlad@zlab.su>
References: <20260815022036.7c47585e@jic23-huawei>
	<20260816114544.35502-1-vlad@zlab.su>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 16 Aug 2026 14:45:44 +0300
Vladislav Leonov <vlad@zlab.su> wrote:

> Hi Jonathan,
> 
> Sent a separate patch for the dt-binding fix:
> 
>   https://lore.kernel.org/all/20260816113636.33635-1-vlad@zlab.su
> 
Just for completeness (as I replied to that just now)
please send them both as a series so all the info is easily available
to anyone looking at either part.

Thanks

Jonathan

> Regards,
> Vladislav

