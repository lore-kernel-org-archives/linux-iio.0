Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9259135CB95;
	Thu, 15 Oct 2026 03:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792034774; cv=none; b=sUJI8hpRuH53haf9T3j8QrO/P0lXIVPzUT9NwY/kpZsR6mzE/9nFKakYkdoIrvOTo99Y4VwxoiOTaloVOIb05QGT2vfEDs1BVETG65hWEfzNDJRRUZu67jkywzw96z1d88RWfCQxJqAz51VLPFctbPQlkq02Y+lFRN45cdFtXcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792034774; c=relaxed/simple;
	bh=pg34VnP4oWC/MuqjqMp7Kcszt9+ahTeg//gBCn332MI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbzAABhemGNzEMjVAG8gYjSRmunsvYk4XVUG0TPBHipl1/J6lOHx2K6bsgoZVTZ4cVCyZYzHggq9KzO5D6Nw47O3QPlUpZv81B/l6Mz1nCk/CykIZpZXY/3IQrt8piQe6pK7PE38Br7MhIHZiYBVRrGhP3tMvb+gDhFN1KpXEmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hn27OtEN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hn27OtEN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E621F000C4;
	Thu, 15 Oct 2026 03:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792034773;
	bh=rPwRWld4FE84bY7lYdtF/Y0GzRjE9ayoAA1AIyQRNrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hn27OtEN7Xdw/H/abW1k3A2ORRq/WjtAzXRZ0D7+dPKIT8a7cc+ywF+c9otTAvP0Y
	 wmW7LC4vj2T98tqH/1vaRAtbI6UvZvlaV4/nq67GQxiHXuAsTZ39iLwBanaALH83Db
	 TDEXQFGOgVxLHV7XY0wlCpA85Y/fR0/Sh9lt66AS9bF/J9xWafXpf5pp7MhHXct8WT
	 CYmH9LQvvEon9mGx8NuS5Sw9a7IPJ/8RGGShdj8tSdzj47bYzCsmTf9zyO5XGI/2CC
	 XCkMxuN10/FADRbaG2Aj+9sFowZDh0qbsOjEQ2i1OyBN7Q9nqYXiLk7cSHDgTzdF9N
	 MrpuxarMuqIig==
Date: Wed, 14 Oct 2026 22:26:10 -0500
From: Rob Herring <robh@kernel.org>
To: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	krzk+dt@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, Michael.Hennerich@analog.com, andy@kernel.org,
	conor+dt@kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: temperature: add ADI MAX30210
Message-ID: <20261015032610.GA472284-robh@kernel.org>
References: <20261015012159.44-1-johnerasmusmari.geronimo@analog.com>
 <20261015012159.44-2-johnerasmusmari.geronimo@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015012159.44-2-johnerasmusmari.geronimo@analog.com>

On Thu, Oct 15, 2026 at 09:21:58AM +0800, John Erasmus Mari Geronimo wrote:
> Add device tree binding documentation for the Analog Devices
> MAX30210 temperature sensor.
> 
> Signed-off-by: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>

Missing Krzysztof's Reviewed-by.
