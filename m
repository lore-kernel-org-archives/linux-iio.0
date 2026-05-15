Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183DC48B39A;
	Fri, 15 May 2026 15:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778857713; cv=none; b=T8i8+xo4wHunjeN/2xshsZKF8Pnch5vvQuMdE7/EWIfyXXCj1phvUhJ/CEqHB2cd9KAd03R6ZcE6WUIjCYKjgjaagbaCm9kbtrR2zuSyGBmijVNSZsoEt2OQQJu5YDwfmgJ9zHSG81F8heGpyT0o00HQ40Zhbir/GIXh89J6N7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778857713; c=relaxed/simple;
	bh=KVDbXf05RMyUvIEp6REFw0cGssyeSrRiGfzsbTFfOKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bd1mogYBJSdBIdtZfJhuJOySSpnw1j6Ua2zDtNSacdc8zmwGbepWKLeALSKv9ta3Uf6qsqCZrhLNvDGfFp9c+083/8YsJrwm1CtwdKT53h0SJuZeg5F4AQt42IxC7+kvNVaC1GBERJiKVAfsvGEGqGEHa/QwRsxbOr+U6bTlqcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjOkJ08n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjOkJ08n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F3CC2BCB7;
	Fri, 15 May 2026 15:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778857713;
	bh=KVDbXf05RMyUvIEp6REFw0cGssyeSrRiGfzsbTFfOKQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PjOkJ08ndKJ+zTjJIOdrGEWmlNMIjyfVZRrq4Akikm/cyQJOTJz6sv55SoKHYj7Mr
	 Uxwj9kgmWzFrnYtsOYyec/BBX18tDcF9a63HuYOy4ZnC2mdbUuTr0lyK8j5NW5f+cx
	 scuDwtvSXZTQgwH5V6KZ8VXEzixWimp3IivecTfGOWgU921WBMDqsVWptT3Gu7h2al
	 lw5zuEI6CFB5KM5O8YNNRXeIpafZymvoaR4MmjClxqMKuOUjm1eBjwazUwkNse01xH
	 oztQsEwd1cOJsXGLVTubIzXF8J7YDYHa5BmFkiT16TlfNbf0mzUW7kc4xkTT0h9t/s
	 XQS2N2Gg909hA==
Date: Fri, 15 May 2026 16:08:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Joshua Crofts via B4 Relay
 <devnull+joshua.crofts1.gmail.com@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Gregor Boirie <gregor.boirie@parrot.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Sashiko
 <sashiko-bot@kernel.org>
Subject: Re: [PATCH] iio: magnetometer: ak8975: ensure device is awake for
 buffered capture
Message-ID: <20260515160824.74ae776c@jic23-huawei>
In-Reply-To: <CALoEA-w+Oe1jwX+M5_sNPVaTcGOTPPhT2g3-90NNd6aamZL+UQ@mail.gmail.com>
References: <20260513-ak8975-fix-v1-1-104ea605dd54@gmail.com>
	<20260515141723.5fbcaeca@jic23-huawei>
	<CALoEA-w+Oe1jwX+M5_sNPVaTcGOTPPhT2g3-90NNd6aamZL+UQ@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 May 2026 15:22:42 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Fri, 15 May 2026 at 15:17, Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Wed, 13 May 2026 16:35:52 +0200
> > Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:
> >  
> > > From: Joshua Crofts <joshua.crofts1@gmail.com>
> > >
> > > Currently, the ak8975_start_read_axis() can be called while the device
> > > is autosuspended, causing two issues:
> > >
> > > 1. I2C transfers in the aforementioned function will fail or timeout
> > > because ak8975_runtime_suspend() disables the device regulators.
> > > 2. Since ak8975_fill_buffer() does not hold runtime references,
> > > ak8975_runtime_suspend() can run concurrently, and since PM callbacks
> > > do not use a locking mechanism, it may cause a race accessing the
> > > control register via the I2C bus.
> > >
> > > Fix this issue by adding struct iio_buffer_setup_ops that contains
> > > preenable and postdisable functions to ensure correct that device is
> > > powered on when running a buffered capture.
> > >
> > > Fixes: bc11ca4a0b84 ("iio:magnetometer:ak8975: triggered buffer support")
> > > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > > Closes: https://sashiko.dev/#/patchset/20260511-magnetometer-fixes-post-pickup-v7-0-9d910faa28b6%40gmail.com
> > > Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>  
> > I'm going to take this as a clear improvement but the point sashiko makes
> > about turning runtime PM on only after the interfaces are exposed is possibly valid
> > as a general comment.  It applies to all the other paths though, not just
> > the buffered capture.
> >
> > I believe we are actually fine here because the device is powered up
> > at that point (the set_active making that clear).
> >
> > Open to other people's views on this though.
> >
> > This is another place where we really should work out a best practice
> > guide / set of standard patterns to use.
> >
> > Anyhow, applied this one and this is one I've marked for stable.
> > However given mass of stuff around this driver it'll still go the slow
> > way and we may need to manually do backports.  So applied to the
> > testing branch of iio.git.  
> 
> Ah, I forgot to send the v2 with your Suggested-by tag. Up to you to amend
> it I guess.
I'm lazy and don't care + don't resend to add tags if there is nothing
else. Just rely to the thread with it then b4 will pick it up.
I'll have to tweak the order though as it'll put it at the end of
the tag block.
> 
> Thanks
> 

