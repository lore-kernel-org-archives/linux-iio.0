Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2E4334C00;
	Thu, 29 Jan 2026 16:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769703212; cv=none; b=CSubb6+6iGhH2ZM6CpnjELwiCkVsjuKUO3caS7osG3Lcm9oPMogstTNw7t45hL+aPCFTW28ivGBjBTXFA2sdL00Kt92mBVa+O9fd/LUqgIWlNJRCVPa1zgpmc8h6LT7jhrrxApyg/wcd41PJ1vkO0Eaic++zISqYvNEiq+mnaPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769703212; c=relaxed/simple;
	bh=3Lf7dnM4IFrElB7yczbm4tHHkvxw0b3IuurTDhMRVyo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R84yPX4JmNS1Tq7x5PLQaudgwQcOJyag8zYVvmuQtn+iKDwPpNTT5ctQ/43lFxjqEhSbdbdpy9uvD7VsaBrmK8Mjfo9YESOzgguT5lt8lC35ZS4KkaBWVeJbzCFlGWDJZTcYRR0sLZbSBO8AC7/vdVathouwx++Y1PE8I9Q6HwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1IZ8h0m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1IZ8h0m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1579C4CEF7;
	Thu, 29 Jan 2026 16:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769703212;
	bh=3Lf7dnM4IFrElB7yczbm4tHHkvxw0b3IuurTDhMRVyo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U1IZ8h0mIMRZWury8++0ry58MX6Tl0mnQwy3y9fZKKgt78ehuyDTfPwWake6vCkOu
	 tdzkoBLdiG34LAAIk/hxe4K0Rf0hMEq/RlEWZAQwdB7J6KNVlj26Qbx05bs3GoJfcc
	 bdubFXbLlgtFt42fpzL6ug9uOiuJjiXvspCf1XA51ZLMO3f1//KkgNp8183Usl95rL
	 d9YSfuFAhIG7yeCy93hdqKjN5Pw1hSIVM/tAccMknUnPL32YVDzI3j5NUhlNfkbdtq
	 90jE1zUM/UvN1zPvGAeZsPFg8LqnGjs8bPqSShtOUAAnB8W23DwFq3kDJPE158M5/E
	 Kl6cuVodCRcIg==
Date: Thu, 29 Jan 2026 16:13:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 18/20] iio: magnetometer: Remove IRQF_ONESHOT
Message-ID: <20260129161323.6b491e95@jic23-huawei>
In-Reply-To: <aXoJXg5JFnFXZqUT@smile.fi.intel.com>
References: <20260128095540.863589-1-bigeasy@linutronix.de>
	<20260128095540.863589-19-bigeasy@linutronix.de>
	<aXoJXg5JFnFXZqUT@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Jan 2026 15:04:30 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Jan 28, 2026 at 10:55:38AM +0100, Sebastian Andrzej Siewior wrote:
> > Passing IRQF_ONESHOT ensures that the interrupt source is masked until
> > the secondary (threaded) handler is done. If only a primary handler is
> > used then the flag makes no sense because the interrupt can not fire
> > (again) while its handler is running.
> > The flag also disallows force-threading of the primary handler and the
> > irq-core will warn about this.
> > The force-threading functionality is required on PREEMPT_RT because the
> > handler is using locks with can sleep on PREEMPT_RT.
> > 
> > Remove IRQF_ONESHOT from irqflags.  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
Applied.
Thanks

