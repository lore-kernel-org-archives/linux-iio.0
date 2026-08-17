Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4961D435F;
	Mon, 17 Aug 2026 00:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786927805; cv=none; b=pj3SFNQmWfpY2XPD0+pyP4AFNMgVPbU2xUrXMzm9wzyr1K+qBmVZlfcZ5uWuaFOoB+MDHjxRiTLuSGbi0PlLiyMf72Fmov1cTIiC2xc9yC7k2nHQKf7aty+Xxa9FilJ3PaugriFzST7vdHHsDD9zN6T2AVm46uzgLlevYPHXXw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786927805; c=relaxed/simple;
	bh=1RJ7RMBfMk0EPSNPY7YzW8uYR7CAiwnvJ48sK2CN3ys=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LO4lds4QbjcSfGQBTyukkleqgKKwv1TQUPQWWkD9Yv1wn+6Qmw7LzRy4Dq7LmRe6WBr/bMN3ZWGA0W5jHEr4nT/IUbTfcdUQ8SPsHi+yIsUFF72X/yHw1emAnHZguA3obND1UmidWLsGG2Fus0ezli/h9Chsj5VToLA582l6ebQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gONuobsw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gONuobsw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 763561F000E9;
	Mon, 17 Aug 2026 00:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786927803;
	bh=AfddIIxlGuNXYYdaMI8fpWMrK+XO/flVXkFaRFcQVqU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gONuobswneh/Ik8e9aO0KipckYd+c9a4yJCyScgcHTGJTKvcwvjPtXyxFqLUuejB2
	 C8gsbYZwOMiy0DRFqPpynvRqqknEyj1o76O749V/mxV9fDtO+5MdpazhD4AsaiNwAK
	 p0/aXWM/kVScc9JBEseXB29++joMHDNE/6XnMaPynkGQq/rZlqFzHYhCVDW3Qj547q
	 mfdGHpqE1CB3TG5fSsUT7aD/fr2lHwW6yuFC+1VH9735DrlFnusSsC/c27OWs9aumm
	 SlF87EZXBAmIoTLwma3zbk3P6Aej2Zdy/FFZ9Jiito59Q04TyoSsm/gWfLr5H/TZ8T
	 3Ypzf63J2weXg==
Date: Mon, 17 Aug 2026 01:49:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Adi Nata <adinata.softwareengineer@gmail.com>
Cc: lorenzo@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v2 0/5] iio: humidity: hts221: update probe and logging
 implementations
Message-ID: <20260817014958.4ac98155@jic23-huawei>
In-Reply-To: <20260813153129.12423-1-adinata.softwareengineer@gmail.com>
References: <20260813153129.12423-1-adinata.softwareengineer@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2026 23:31:24 +0800
Adi Nata <adinata.softwareengineer@gmail.com> wrote:

> HTS221 is an older driver. This series groups a few small modernizations
> based on current development practices.
> 
> - Report available values via read_avail()
> - Add a blank line after variable declarations (style)
> - Allow unknown whoami for DT fallback instead of erroring out
> - Use dev_err_probe() in probe paths
> - Reject calibration data that would cause division by zero
> 
> No HTS221 hardware was available. Verified with checkpatch --strict and
> builds of hts221, hts221_i2c and hts221_spi. Probe and calibration
> error paths were exercised against i2c-stub with register contents
> pre-loaded via i2cset.
> 
> ---
> Changes in v2:
> - Use a local 'dev' pointer instead of hw->dev in error logging helpers
> - Fix punctuation in the commit message of patch 2/5
> - Adjust commit message for patch 1/5 to include fixes due to ABI change 
> of in_humidityrelative_oversampling_ratio_available
> 
Looks like you've fixed up the stuff Andy pointed out in v1 and all looked
reasonable to me, so applied to the testing branch of iio.git.

Note that branch will be rebased on 7.3-rc1 once available and only
then pushed out for linux-next to pick up.

Thanks,

Jonathan

> v1: https://lore.kernel.org/all/20260808090026.34187-1-adinata.softwareengineer@gmail.com/
> 
> Thanks to the reviewers for all the time you spent going through the
> code and the comments.
> 
> Adi Nata (5):
>   iio: humidity: hts221: report available values via read_avail()
>   iio: humidity: hts221: Add a blank line after variable declarations
>   iio: humidity: hts221: Allow unknown whoami for DT fallback
>   iio: humidity: hts221: use dev_err_probe() in probe paths
>   iio: humidity: hts221: fix division by zero in calibration parsing
> 
>  drivers/iio/humidity/hts221_buffer.c |   1 +
>  drivers/iio/humidity/hts221_core.c   | 168 ++++++++++++---------------
>  drivers/iio/humidity/hts221_i2c.c    |  11 +-
>  drivers/iio/humidity/hts221_spi.c    |  11 +-
>  4 files changed, 84 insertions(+), 107 deletions(-)
> 

