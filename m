Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF834365A1A;
	Tue, 26 May 2026 15:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779809675; cv=none; b=UFn4Fem5Kb22M5uEtzhXaEdf9J8565qJP2xlAuOlXAfk7YKb8Md2E+ItroaKxT9NqIrj2BBOM5qU3Q/ZEcdsWFKzrZ5XLj0FBSMUW7zBnBRD4vzmgePq6FUjHq/c/IBJyCR1vRkYTOm3lTTdxLdHwuUA925v4maKUiz3xYv8rIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779809675; c=relaxed/simple;
	bh=CDbKEYTZrmBwWqCdkDwNhKO56oDd0fsYyCx85Qs8wYg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nHO9R1Pv+0DeGa1Rzkom7ZIXs6WD+dw5Ywr57yKMBKYRbEYqOFnec9oT7ftFPSl0qHn9UxWWcHf/37bngcs/StxdhC6MGwvAFoEy6rc2vfxuRjHjXAto4mYMe8R+PdpPMpsB7DfnQActI4iHhXKOoMqfoGIVkPa8TI3F5HHErP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X70CHmjL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X70CHmjL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF771F000E9;
	Tue, 26 May 2026 15:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779809673;
	bh=Ds2g90zxvqImr13wdxwsttd2gprlOlJ5GtPzDjdR2U8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=X70CHmjLHhMnnZhSQOTLaNafdZOaR3V0Dt0f81tv0fA0b4BdrHA5i/XGHIHAJSUEh
	 m5Va3szpGnAjYQhT8HWphuiwNwg2vXrsnpoluoaEGyWX2FfOECgBM6NnrvxInGzhse
	 p9R1HAWL/AvJyAS1f4cGvDul4uh4+Z0dZgZcTYaE1M/iwdPKebanYWcSHwr+nJqiYs
	 ClS2ea6o/kaZHKyU1GLdEiUMiq3f2SC5DL4oK4TCjQQqDKBDX2++m9xzzZ/poNwI+J
	 D+uPAo99gWyTTkkFowsI/0nq6boi9ah62/ga9g800wDPlw8fhFNBbzJQzAKlONhQhS
	 T7+NQMpGLUVZg==
Date: Tue, 26 May 2026 16:34:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stefan Popa <stefan.popa@analog.com>,
 Jonathan Cameron <jic23@cam.ac.uk>, Greg Kroah-Hartman <gregkh@suse.de>,
 Michael Auchter <michael.auchter@ni.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Andy
 Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v7 0/8] Fixes and cleanups for the AD5686 IIO driver
Message-ID: <20260526163423.6d7da740@jic23-huawei>
In-Reply-To: <20260524-ad5686-fixes-v7-0-b6bf395d08bd@analog.com>
References: <20260524-ad5686-fixes-v7-0-b6bf395d08bd@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 24 May 2026 11:17:00 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> This is the first series of three on updating the AD5686 driver.
> 
> A bigger patch series was sent before ("Extend device support for AD5686 driver"):
> 
> https://lore.kernel.org/r/20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com
> 
> This one adds a number of cleanups and fixes, like:
> - Refactor include headers (IWYU);
> - Remove redundant register definition;
> - Drop enum chip id in favor of per-device chip_info structs;
> - Fix internal voltage reference control for single-channel devices;
> - Acquire lock when doing power down control;
> - Fix powerdown control for dual-channel devices;
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
Series looks good to me but I think we are waiting on the fixes to be available
upstream - so might be a little while before I can apply it.

Thanks,

Jonathan

> ---
> Changes in v7:
> - Drop fixes (already accepted).
> - Use named fields in device tables.
> - Link to v6: https://lore.kernel.org/r/20260505-ad5686-fixes-v6-0-c2d5f7be32be@analog.com
> 
> Changes in v6:
> - Protect powerdown masks on read access too.
> - Minor changes to power down handling and constants.
> - Link to v5: https://lore.kernel.org/r/20260501-ad5686-fixes-v5-0-0b2f45488418@analog.com
> 
> Changes in v5:
> - Drop I2C read operation changes.
> - Create helpers for reading and writing powerdown mask bits
> - Link to v4: https://lore.kernel.org/r/20260429-ad5686-fixes-v4-0-bb8f1cbd68e1@analog.com
> 
> Changes in v4:
> - Address issues spotted by sashiko.
> - Link to v3: https://lore.kernel.org/r/20260428-ad5686-fixes-v3-0-9cff7bd67a15@analog.com
> 
> Changes in v3:
> - Misc changes like parenthesis removal and line breaks
> - Link to v2: https://lore.kernel.org/r/20260427-ad5686-fixes-v2-0-188e05199368@analog.com
> 
> Changes in v2:
> - Bring fixes first and cleanups later
> - Link to v1: https://lore.kernel.org/r/20260426-ad5686-fixes-v1-0-7c946a77794e@analog.com
> 
> ---
> Rodrigo Alencar (8):
>       iio: dac: ad5686: refactor include headers
>       iio: dac: ad5686: remove redundant register definition
>       iio: dac: ad5686: drop enum id
>       iio: dac: ad5686: add of_match table to the spi driver
>       iio: dac: ad5686: add helpers to handle powerdown masks
>       iio: dac: ad5686: add control_sync() for single-channel devices
>       iio: dac: ad5686: cleanup doc header of local structs
>       iio: dac: ad5686: create bus ops struct
> 
>  drivers/iio/dac/ad5686-spi.c |  73 ++++--
>  drivers/iio/dac/ad5686.c     | 528 +++++++++++++++++++++----------------------
>  drivers/iio/dac/ad5686.h     | 133 +++++------
>  drivers/iio/dac/ad5696-i2c.c |  80 ++++---
>  4 files changed, 418 insertions(+), 396 deletions(-)
> ---
> base-commit: bbc109ae655c8a5d4db117fea01947eb6bf51e71
> change-id: 20260426-ad5686-fixes-63ea68811bdb
> 
> Best regards,

