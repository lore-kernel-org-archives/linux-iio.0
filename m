Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7705C3A6B6B;
	Wed, 29 Apr 2026 09:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777455374; cv=none; b=KjYC8K9lqVMGe/NmuExUF8LfqvI+t9Q4PulKIyYzKS31voq+PYC3ev/U4hq8dtXfqEUKz7hJ2KFDs+w3XeibH8enuelLsxZ0zcwwVvb0bJpeTxzpOD5X+ofWC3BtBndaGMqPWwU4Y91vH1sR/Awd9GlvCefFAFqscpJPd6fxPRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777455374; c=relaxed/simple;
	bh=d6gxp3HIf2QhShbND0PuD91/gATv3xLI5OTznUOaV0E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hPs3Kk35a9SRby0t+O1qk/fhtXKlYoEPar08cBxhpwCT5Kl58J1K/VX0ve1ZsYxfYCw0ckO8v8kjhxUHjTp330NB5pKe9sArgRDokQeeAeKfrBXmidA50yz/fS6H+NmdQo/I+FRNVmPFD4HN7ZQAvvMeT6cCsmndHlsz4Wg1REw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FV3STRId; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FV3STRId"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 454F9C19425;
	Wed, 29 Apr 2026 09:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777455374;
	bh=d6gxp3HIf2QhShbND0PuD91/gATv3xLI5OTznUOaV0E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FV3STRIdvmDiEfjecDdpwTq4N9f/nXJyOifhYt9dJWoJkdm9Mf/0vE5koBbH8Ikjw
	 x4TXykH3/x04s+H1gLMLWlWNSoke1Q+tccjkw4mvI/P8m8ms4cYEo3jmfr2QT738DV
	 0EpVgRrD968SokFCFt9cVjJTjpe3c5wJN4cd787WIX6eHD7d8+759cnQcuZoUbITQD
	 Z+fydWwH1JgsYe61R5TI6U1o4eeCgG1gAjaOeXpxcNpL6ANM8ywI2p+qNqk9byYN02
	 gWi22/X1G7RLTAxrGAu4JbOCNF0x1dnc0qjkWuoZIQIEBMWPKHCJJFNiiiYQ/zOCMI
	 zDNqPJt6QJuVw==
Date: Wed, 29 Apr 2026 10:36:04 +0100
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
Subject: Re: [PATCH v3 00/11] Fixes and cleanups for the AD5686 IIO driver
Message-ID: <20260429103604.6ef17302@jic23-huawei>
In-Reply-To: <20260428-ad5686-fixes-v3-0-9cff7bd67a15@analog.com>
References: <20260428-ad5686-fixes-v3-0-9cff7bd67a15@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Apr 2026 18:02:15 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> This is the first series of three on updating the AD5686 driver.
> 
> A bigger patch series was sent before ("Extend device support for AD5686 driver"),
> but this is not exactly a v2:
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

Applied the fixes - so patches 1-4 to the fixes-togreg branch of iio.git and
marked them for stable. The rest will have to wait for now.

Thanks,

Jonathan

> ---
> Changes in v3:
> - Misc changes like parenthesis removal and line breaks
> - Link to v2: https://lore.kernel.org/r/20260427-ad5686-fixes-v2-0-188e05199368@analog.com
> 
> Changes in v2:
> - Bring fixes first and cleanups later
> - Link to v1: https://lore.kernel.org/r/20260426-ad5686-fixes-v1-0-7c946a77794e@analog.com
> 
> ---
> Rodrigo Alencar (11):
>       iio: dac: ad5686: fix ref bit initialization for single-channel parts
>       iio: dac: ad5686: fix input raw value check
>       iio: dac: ad5686: acquire lock when doing powerdown control
>       iio: dac: ad5686: fix powerdown control on dual-channel devices
>       iio: dac: ad5686: refactor include headers
>       iio: dac: ad5686: remove redundant register definition
>       iio: dac: ad5686: drop enum id
>       iio: dac: ad5686: add of_match table to the spi driver
>       iio: dac: ad5686: add control_sync() for single-channel devices
>       iio: dac: ad5686: cleanup doc header of local structs
>       iio: dac: ad5686: create bus ops struct
> 
>  drivers/iio/dac/ad5686-spi.c |  73 ++++--
>  drivers/iio/dac/ad5686.c     | 521 +++++++++++++++++++++----------------------
>  drivers/iio/dac/ad5686.h     | 120 +++++-----
>  drivers/iio/dac/ad5696-i2c.c |  80 ++++---
>  4 files changed, 412 insertions(+), 382 deletions(-)
> ---
> base-commit: d86db1905add39f905cf9f04252804b359914ed6
> change-id: 20260426-ad5686-fixes-63ea68811bdb
> 
> Best regards,

