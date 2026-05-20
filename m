Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CD729B8D0;
	Wed, 20 May 2026 18:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301522; cv=none; b=Aau8rgpYpV9LgQa6mGKvs2y6HyISDJYTZvNrKQxPXeOljmGIRkIi1/Zh8t90OCEbFbq2ZcfMv3zxCkdPlIByfiM+pmcu3x1Ctu6XdC3MPUtd84+KqTllRgDSS0NbVU3lP2Ia6CIBWZ4AYzbRCy+GQwt9HlNKGUzAFinw6BQCF5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301522; c=relaxed/simple;
	bh=A+o7XzfWfBrZrOx8gkzhQVkEzOrLMDiQpkXtYhDZM3g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=puAUBiKJIQ52pC8SfymIdiqdEOM+qtLYuQC2UapAJi42Il2KwM3Oeur/DABHg2HfZbcbF7uzaZfTfmbiTXxS1Hpiug1PKhhyFW9zaZDYsqlZOShXCixS2WVcbbTlt5YoaRA/QsaVFI4lYwfkmztiKf57UcoWau8TEgaFPUSfnNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfUi31sE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfUi31sE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A668B1F000E9;
	Wed, 20 May 2026 18:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779301521;
	bh=qC3laSeJVYxtXQW1VP6ZHwBO3kT+Jq0l1y1d3tRQhlw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KfUi31sEzWWY99MWECO8x9Yww8S3TwnQFcnQilGBH37r0zUWUMXAVgtvGwOG+/j1/
	 DJGcbxN+XLgITyazTmod6aaY8dsBE3W2pP5dNn8yMQuZuZ/vuV3d61rybSVKBt8WZO
	 K19mRMw0mlf1GtEzqyahnzS8sApV17VLItLJ4PqvoYujDr5GrLVN9bUknoiFCJBpNU
	 U87UyL6dvSjTK+YEXX5f7VZ0f1FHlCPGd3BbEwgckAhA8lrabxeG6/lmmbOs1RCgGu
	 lpQwov3SGzvjX1JxumS9H8XMiltztJrtAalxoyATEQ18a2yeg1f85Or/RYO7cBQkLA
	 scFxm+ajpFu9w==
Date: Wed, 20 May 2026 19:25:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, jean-baptiste.maneyrol@tdk.com,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 andriy.shevchenko@intel.com, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V7 09/11] iio: imu: inv_icm42607: Add Wake on Movement
 to icm42607
Message-ID: <20260520192510.7b6fa723@jic23-huawei>
In-Reply-To: <20260515203629.3dbf7133@jic23-huawei>
References: <20260515130018.237378-1-macroalpha82@gmail.com>
	<20260515130018.237378-10-macroalpha82@gmail.com>
	<20260515203629.3dbf7133@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 May 2026 20:36:29 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 15 May 2026 08:00:14 -0500
> Chris Morgan <macroalpha82@gmail.com> wrote:
> 
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > Add support for wake on movement for the icm42607 driver.  
> Could you add a bit on what is supported on each of the two parts.
> Not everything on the 42607P it seems.
> 
> There is quite a lot of fairly complex feedback on this in sashiko.
> 
> Obviously we are late in the game and I should have suggested
> this earlier but I would have dropped this for the initial driver
> just to keep it more manageable to review.
With hindsight / v8 I failed to say I meant just the bits related
to wake on motion. I'd failed to notice that the fifo interrupt
handling is in here as well. That bit is definitely needed.

> 
> It's very much an add on feature.
> 
> Jonathan
> 
> > 
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>  
> 

