Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F913C455B;
	Sun,  2 Aug 2026 17:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785691623; cv=none; b=IP5+M/aeA9bKtkyJMpgVkvz5kWRsZXIjcgowGtadPreLmLEjlAV+ur040NOURa+6BbPuT00EfLQHPrgWvdaZsh4GyOWNupLeHYp80FBcSe3QVc4jbGw3GyI94gzQAbJQKVN86lNXSC8myLc4J2fD5uu67+Kc24ApBbCAobAPsz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785691623; c=relaxed/simple;
	bh=GLu7tNGjJwMWX4u8hWBSklnoyl9KmTUE+uMA6SgSCnE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lwllVEOpd9RwBPBn2npYhw1522Co/WcJ1FridiSOdVHW6WFInHjJzWEZVKfPzjgAFivGNEnVTMrui7tB1tE/jb2uNX++0l0X5OH1YbLgwett/tjxlAWXKDxAwAU3jQ4yzkD7gk1Kl063RuHwobC4vwtUYKL2N22HWI+Yo5PCZ3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdgOrd1g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdgOrd1g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9C91F00A3A;
	Sun,  2 Aug 2026 17:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785691621;
	bh=YQIE8XgKYt/EUINULOT/JC5r+V7wX1jbi6M/ucAZS60=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kdgOrd1gSiqTPL+atSoKrTrrQNdxHnVW3zeXTYGN0bZ0IJt+tn32WLspNIF4GpFUo
	 wlWn+kttl0ZfBnn6EWmiwJE4IaGwzwZ7tlYhN0z62Sde5LfTyLH5fOGdojkssJoaVV
	 0ebz2uTZr2QjAnNvFSACZzMdH7ZEuUzeWz4ewLUPbsUH0gvFSp8VU6VelC2+BZzmCM
	 oylCdz8nLuyeeZTjm3Rx/xfzOwlcnFLP2rgSI26tZ2m330+pPhfJC/o7Tj0zFl7hIM
	 DxiJVCY5w20PT0sr69VcS6SWzYxyQQTYe+k04rurnfyZd24g7ioAEuJhTh2MQzVj/z
	 YKZ3Y97yMp4LA==
Date: Sun, 2 Aug 2026 18:26:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: mdshahid03@gmail.com
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Joshua Crofts
 <joshua.crofts@broadcom.com>, Broadcom internal kernel list
 <bcm-kernel-feedback-list@broadcom.com>, David Lechner
 <dlechner@baylibre.com>, linux-arm-kernel@lists.infradead.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Ray Jui <rjui@broadcom.com>, Scott
 Branden <sbranden@broadcom.com>
Subject: Re: [PATCH v3 3/3] iio: adc: bcm_iproc_adc: Convert probe error
 handling to dev_err_probe()
Message-ID: <20260802182657.65d459e0@jic23-huawei>
In-Reply-To: <20260802103520.114582-1-mdshahid03@gmail.com>
References: <20260802030433.696454fe@jic23-huawei>
	<20260802103520.114582-1-mdshahid03@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  2 Aug 2026 16:05:20 +0530
mdshahid03@gmail.com wrote:

> From: Mohammad Shahid <mdshahid03@gmail.com>
> 
> Hi Jonathan,
> 
> Thanks for the detailed review and suggestions.
> 
> I'll address the formatting comments in patch 3 and also reduce the
> unnecessary churn in patch 2 as you suggested.
> 
> Regarding the suggestion to convert the probe cleanup to
> devm_add_action_or_reset(), my intention was to keep this series focused
> on the dev_err_probe() conversion and submit the devm-managed cleanup as
> a separate follow-up series, since it is a larger refactoring.
> 
> Would that approach be acceptable, or would you prefer that the cleanup
> be included in this series?

I'd leave the dev_err() prints where there is a goto alone
and do them as part of the devm_ change so as to reduce churn on
the code and shorter the eventual set of patches.

Just add a note to the dev_err_probe() patch to say you are doing
that and then they can be separate series.

Or if you prefer just do the lot in one series.

Thanks

Jonathan

> 
> Thanks,
> Shahid

