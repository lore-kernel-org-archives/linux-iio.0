Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A960D39B94E;
	Sat, 28 Feb 2026 18:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772302590; cv=none; b=YF3kF1LZ+TU+CnANyp/YjoKULlqkRRqcJCwd7o0/vbtx2hHbBHsFr/igqhfIRaGUm+THhc8I9TrLNFv+YbDjuFZEplppHqHIUrYGhvDGl/r6QoL8welUhyMmDcSKPIrC9c0BCaHdPAKIsv2sPZmCtFVIKh2AICG/42IyHREt0uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772302590; c=relaxed/simple;
	bh=Abmm1NkX0D6AmNaf4BEsvP+lrQnHO1AYo7x7lsKOOL8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CPsQkibap4uOi/lOr4GpWgEHv8BL7S/Ew9MnbbzzIldbdRIiXcOrkYDx/tnXGze1SpjW4XInqqUrzyA3dGPcAZPjT5zF9iVf31anbs5AzxnmpHO9Eh9O3YH7pY86OopRwt7K3+YZxdZR+gXro9NWKoI+tqekqOk9eif6XCpMwcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7ji897x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7ji897x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B46DC116D0;
	Sat, 28 Feb 2026 18:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772302590;
	bh=Abmm1NkX0D6AmNaf4BEsvP+lrQnHO1AYo7x7lsKOOL8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X7ji897xmXTD4+vYz8khbT1AFFQKnkjiXsCfuQ3fpm+Dz2vOGvPYQheV+gkF5zSJT
	 PWRKzlP43PJRMlgFLalSQP+T874h7+Q8T5FvBzxCz3+difAvYb2qJN+T4gW/1FfsHa
	 dgYhkQMFdn9igvyS8Ow8F/fGAZyPP3K5XNmQGY3uFURIIdQm3hUKHRCnrfHAG9wfxL
	 uEe/UiTuohVxpUbG0OQSZF+mOLWunyzWk1srBHZD8QDf1m+P6i4UD3hMW4HzbqRxsl
	 F4aXJCrfBoK6V9RNxBH+uXIOgAN323s0+FxERvu+RUDGByvGcEhGon8oodJyxUDQf6
	 lTqpPU4HMLYmg==
Date: Sat, 28 Feb 2026 18:16:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Ethan Tidmore <ethantidmore06@gmail.com>, linusw@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] iio: gyro: mpu3050: Multiple bug fixes
Message-ID: <20260228181621.0c3cb77f@jic23-huawei>
In-Reply-To: <aZ7kqDQP1zAKgnUp@smile.fi.intel.com>
References: <20260224224818.2452675-1-ethantidmore06@gmail.com>
	<aZ7kqDQP1zAKgnUp@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Feb 2026 14:01:44 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Feb 24, 2026 at 04:48:14PM -0600, Ethan Tidmore wrote:
> > This series fixes 4 bugs:
> > - Patch 1: Fix free_irq() being called with wrong handler.
> > - Patch 2: Added missing free_irq() in an error path.
> > - Patch 3: Moved iio_device_register() to end of probe function, in
> >   doing so had to implement correct error cleanups and place
> >   iio_device_unregister in beginning of remove callback.
> > - Patch 4: free_irq() is after called iio_triggered_buffer_cleanup()
> >   which breaks LIFO, place it before it.
> > 
> > I plan on doing a proper devm_ conversion of this driver, but went ahead
> > and did these fixes so they could be backported.  
> 
> LGTM,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> The commit message in the patch 4 sounds to me as needs an improve,
> but I leave this to Jonathan.
> 
> 

Series applied to the fixes-togreg branch of iio.git and marked for
stable inclusion.

Thanks,

Jonathan
