Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B9121CC43
	for <linux-iio@vger.kernel.org>; Mon,  2 Feb 2026 16:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770048456; cv=none; b=bTB0/xthf94o473wCyql1yoXaJ96YIVRYzAtZ5eTycdR/5dpbJLhvim5dWS/ccfnZdVgvBsglosYJPstlAzepBrSnEt3xM3uK8Vcfi8kPgqWzclYaQiW/v9gS/OwRCaaGrMUlDos2Bx7oT+NUikn5drP7C81vKh6poV4u7AFUY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770048456; c=relaxed/simple;
	bh=OpRGjz9IYT7GwHvfRb29Y3Eed+Zq/JbsDVAU7eqFrJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XStoa+/ZNaao+4oRzXMJ/RDZWtqYT5FHKWoRdfxNzmiLIBb+W+usCe9vS04sCPJ+d+QsIKT7nSoPo7/7OBV5ND8KeZya6N045qci8QsOztcvHdTjMbsAyjqVe0nA8zNLvcAaIWizjuxyMdZcdGOvGW7zJjc39XmzsLkXVAeOBv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qbTRdEY4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qbTRdEY4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29493C19422;
	Mon,  2 Feb 2026 16:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770048455;
	bh=OpRGjz9IYT7GwHvfRb29Y3Eed+Zq/JbsDVAU7eqFrJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qbTRdEY4F5lImlG1lX8ENTM93Yl3OFCbA9HsYjV0FiiG+Z5Jla4ihLHt+fdnhwoen
	 sYJncUC9Lk6MbSr90QDEgvyZKXwqMP+reculfNYxFrlJrlM15GzBSlQRsfroEoHEiB
	 yEF+gV233GM/diDNtRgiC0wVRRadm/Vao2Yz5y0Y=
Date: Mon, 2 Feb 2026 17:07:32 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: New device support, features and cleanup for 7.0
Message-ID: <2026020249-neurotic-resolved-aad7@gregkh>
References: <20260201165951.481378da@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260201165951.481378da@jic23-huawei>

On Sun, Feb 01, 2026 at 04:59:51PM +0000, Jonathan Cameron wrote:
> The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:
> 
>   Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-7.0a
> 
> for you to fetch changes up to 0713b26190addfa3a774b386c8658952ef9f7faf:
> 
>   iio: magn: mmc5633: Fix Kconfig for combination of I3C as module and driver builtin (2026-02-01 16:53:35 +0000)
> 
> ----------------------------------------------------------------
> IIO: New device support, features and cleanup for the 6.20/7.0 cycle.
> 
> Slightly messier than normal unfortunately due to some conflicts
> and build config bugs related to I3C drivers.
> 
> One last minute Kconfig fix right at the top after a linux-next report.
> I've simplified the Kconfig and made it match other instances in the kernel
> so that should be safe enough despite short soak time in front of build bots.
> 
> Merge of an immutable branch from I3C to get some stubs that were missing
> and caused build issues with dual I2C / I3C drivers. This also brought in a
> drop of some deprecated interfaces so there is also one patch to update a
> new driver to not use those.
> 
> We are having another go at using cleanup.h magic with the IIO mode claim
> functions after backing out last try at this. This time we have wrappers
> around the new ACQUIRE() and ACQUIRE_ERR() macros.
> Having been burnt once, we will be taking it a bit more slowly this time
> wrt to wide adoption of these! Thanks in particular to Kurt for taking
> on this core IIO work.

I got a merge conflict in drivers/iio/adc/ad9467.c and resolved it this
way:

diff --cc drivers/iio/adc/ad9467.c
index 2d8f8da3671d,9cfe66425d4e..000000000000
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@@ -94,8 -103,8 +103,8 @@@
   */
  
  #define CHIPID_AD9434			0x6A
- #define AD9434_DEF_OUTPUT_MODE		0x00
+ #define AD9434_DEF_OUTPUT_MODE		0x01
 -#define AD9434_REG_VREF_MASK		0xC0
 +#define AD9434_REG_VREF_MASK		GENMASK(4, 0)
  
  /*
   * Analog Devices AD9467 16-Bit, 200/250 MSPS ADC

Hopefully I did it right?

If not, can you send a fix-up patch for me?

thanks,

greg k-h
