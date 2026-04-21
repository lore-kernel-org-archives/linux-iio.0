Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AD02D9ECD;
	Tue, 21 Apr 2026 09:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776764296; cv=none; b=EaJpLxPno5/JY372W7V0iAIwQ7jH8j78bBz6yzODbv/wG9Pe1fM2hTgK2gmR+GXtM62NYBvbbysFVnSXuh28n6+bmiNVRdb6cdfROkqSbOtHaB2I6PToeHmsm28C5eofcQT32+3eV0wFQS4ZS9dCQOqSa3bHnYyzlwnnCHsCCaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776764296; c=relaxed/simple;
	bh=ahyJvMUP2W95BZS2h17Ehp2o3euSz6WrsQWr4me/tis=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AFUIbBEXrgYBdZMZn+xUxjGcuPHIKvBr7H1d2Cvhy3i4zr8wPlpNBVabLzD7h5d1EpFMicKe40Q7B4PhcrWiIbQlXyZwpP27RqOWG5HaqLzTND5HXrPmvNMJYeQv7s2BEBFoaaRCci4pjgTeBQeuFI+HVt/C41a46A8VRO6z7v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OcsEueru; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OcsEueru"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC79C2BCB8;
	Tue, 21 Apr 2026 09:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776764296;
	bh=ahyJvMUP2W95BZS2h17Ehp2o3euSz6WrsQWr4me/tis=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OcsEueruNpPrVTL/D5KueoL7jeD8JCNi9t0Xm30AbzDY4x16WDww25lIEASd9JvTh
	 F8GHtO+A0ZN127TPBXF0Q1o0JxL/RCRjP0VOpPo/ZqFZMf1Sbr7+KIrFpldUEauys0
	 cZVBmhJiVd+RA1t5kWn29xWwxYjp0niWAKVxMib5gMivbn4HeigJ6GBkG1j+6F+qA1
	 nN0oT+2qgEb207yIvfBqCYPuUtHQ4hHQ1MvF1cqIz4JkmobSnuP7WK1qG4PeSKnc3e
	 kA+yUdwC0kGqzsOoxuKe64CaMGYz/GsWmsuGSFTcS6/Ira6rZ9ahVXB1Ha0aI70WF8
	 AXMEHjoe3uNmw==
Date: Tue, 21 Apr 2026 10:38:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Junxiao Chang <junxiao.chang@intel.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 gye976@gmail.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 lars@metafoo.de
Subject: Re: [PATCH] iio: buffer: fix warning in requesting threaded irq
Message-ID: <20260421103807.7ca935e9@jic23-huawei>
In-Reply-To: <20260422005038.1600632-1-junxiao.chang@intel.com>
References: <20260422005038.1600632-1-junxiao.chang@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Apr 2026 08:50:38 +0800
Junxiao Chang <junxiao.chang@intel.com> wrote:

> IRQF_ONESHOT is for threaded IRQ. If there is no threaded IRQ
> handler, this flag should not be set.
> 

See the guidance in 
https://www.kernel.org/doc/Documentation/process/submitting-patches.rst 
on how to mark new versions and do change logs etc as this isn't even
close which makes it very hard to track.  As such I'll not merge
this version. Please send a v4 (?) Maybe it's gone past that already
with all the rules about change logs and patch titles followed.



> This change fixes a warning during booting with kernel v7.0-rc3.
> Hardware: ARLs(Ultra 9 285) desktop
> Software: Ubuntu 24.04 + v7.0-rc3 kernel.
> 
> WARNING: kernel/irq/manage.c:1502 at __setup_irq+0x1639/0x2510, CPU#3: iio-sensor-prox/974
> Call Trace:
> request_threaded_irq+0x2c7/0x490
> iio_trigger_attach_poll_func+0x353/0x6b0
> __iio_update_buffers+0x2420/0x2c70
> enable_store+0x183/0x270
> dev_attr_store+0x5e/0x90
> 
> There is no threaded handler in thiggered buffer setup, e.g. vf610_adc
> and hid-sensor. They might introduce this warning.
> 
> Fixes: 23f2d735a932 ("iio: Add helper function for initializing triggered buffers")

This is a complex fix to tag as until recently it was harmless.
All we actually have is a warning that says the combination in non sensical
that was added recently.

Jonathan


> Signed-off-by: Junxiao Chang <junxiao.chang@intel.com>
> ---
>  drivers/iio/buffer/industrialio-triggered-buffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/buffer/industrialio-triggered-buffer.c b/drivers/iio/buffer/industrialio-triggered-buffer.c
> index 9bf75dee7ff86..40eea3a447246 100644
> --- a/drivers/iio/buffer/industrialio-triggered-buffer.c
> +++ b/drivers/iio/buffer/industrialio-triggered-buffer.c
> @@ -64,7 +64,7 @@ int iio_triggered_buffer_setup_ext(struct iio_dev *indio_dev,
>  
>  	indio_dev->pollfunc = iio_alloc_pollfunc(h,
>  						 thread,
> -						 IRQF_ONESHOT,
> +						 thread ? IRQF_ONESHOT : 0,
>  						 indio_dev,
>  						 "%s_consumer%d",
>  						 indio_dev->name,

