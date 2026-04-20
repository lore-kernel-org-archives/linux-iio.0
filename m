Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF452EC54A;
	Mon, 20 Apr 2026 12:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776689848; cv=none; b=fMcdtd2u+sQ19L6iKfMP024EN2zDljAOy4RXow4GuFMwGoAefoSMCnBLvaUgwJ775WQjLuBXgKqgZTyuO3TqBUGEyD7Xz9NvEYJewcOP7mTJ2zFUZc/DNDqdMoi5aPAQPAG4yUfdxIig1Xa2HvXlBzqnxyivj5BdTrPsxeXQnrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776689848; c=relaxed/simple;
	bh=htaGDVOWZumW1shSQuT4U+VueFbsGDux33MOQCdC5f4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pLoTCtLafwi03Z2x/fFtAbMwfBeQlyPXfGVDEyIy2bBMWOgRcwBMWExQNrvF9BEraiVWgzn5JhwQzYevE/yInorGsppfMDxLfVaeIxOV5VmoAiKvJAMtR0ioqjatnANdLj3U+TiYZCFNq1SIYG/zm7qV8bRl/JAbRnM12QsWCfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u2Z5nO5B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2Z5nO5B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59568C19425;
	Mon, 20 Apr 2026 12:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776689847;
	bh=htaGDVOWZumW1shSQuT4U+VueFbsGDux33MOQCdC5f4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u2Z5nO5BLH8MqAyTFglYIeO8IR+RLPZ7qYLPcFBzcQAJMIKIDS+Nm9WGFqYlk5/UR
	 aF4Q+4CLa8Tbdl66o0WUu4LO/ywiRYOtf1f4Wj6PThxvRSEdM+DEhyfiLhLj6Mxy6E
	 NPZj1KBPd9XrjvdeF/2LJqeKPKxehwbZZDeEZd9/7aj4UbC/5hXJuApSBU+L9rW9vZ
	 bspPV4eEHVQPddakRFoYCBFGB1akaOTlNp8BQRo/MkyxNSFG+hZGVQ11zNHIgwXnEj
	 xes06OsdsQdn0Hzf5qWjIrmaUocHiHd/i+e1w1PXKg2qJjsJ65OuXronF2k7CjR9ti
	 hPluvsuRBBm+A==
Date: Mon, 20 Apr 2026 13:57:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Archit Anant <architanant5@gmail.com>, dlechner@baylibre.com,
 lars@metafoo.de, Michael.Hennerich@analog.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/5] iio: adc: ad799x: modernize resource management
Message-ID: <20260420135718.520b0641@jic23-huawei>
In-Reply-To: <ad505ojCcZgkyIFg@ashevche-desk.local>
References: <20260412093739.17116-1-architanant5@gmail.com>
	<ad505ojCcZgkyIFg@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Apr 2026 20:09:58 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sun, Apr 12, 2026 at 03:07:34PM +0530, Archit Anant wrote:
> > This series modernizes the ad799x driver by converting resource 
> > management to the devm_ infrastructure. This results in cleaner 
> > probe error handling, the removal of the ad799x_remove() function, 
> > and improved overall code maintainability and safety.
> > 
> > Key changes in this series include:
> > - A prerequisite cleanup to sort headers alphabetically.
> > - Static allocation of the rx_buf using IIO_DECLARE_BUFFER_WITH_TS()
> >   to avoid dynamic memory leaks during scan mode updates.
> > - Caching of VCC and VREF regulator voltages during probe() to 
> >   optimize read_raw() performance and simplify power management logic.
> > - Migration of regulators and mutex initialization to device-managed 
> >   resources (devm).
> > - Fixing a potential race condition by moving mutex initialization 
> >   before IRQ registration.
> > - Removal of the manual ad799x_remove() function and all goto-based 
> >   error cleanup labels in ad799x_probe().
> > 
> > These changes ensure the teardown sequence is always correct, 
> > following the reverse order of allocation, and remove unnecessary 
> > boilerplate code from the driver.  
> 
> Some pieces still can be polished, but this is good enough, let's go with it!
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
Applied to the testing branch of iio.git.

thanks,

Jonathan


