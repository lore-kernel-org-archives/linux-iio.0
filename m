Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794699887;
	b=gaIuo+wr9oi3a9HN/10RC+a2IPvlwdlE+y/SClG9OaAs0hfiNC4ag6OOzEakZWhxiPtJ
	 eJDS61sF3wGjJ7ph4yutMeEDL6QHc7goMr+xLQjV6f0W+XdFppVomky7m2CtkgMnFSIWn
	 paO4cEjVgTeS/YLcv33Nn1qchGF/cjQY+RlV5b9aR/5RApsiH279ZN+/6iH05YWqvRaYd
	 4Ib/nC2AcNn47ehnUOygoCV9aMpySmAs0uAj0CkJH3MCu57ivTYf19C8aBOQy903PnnzS
	 qYWx0inaUb6rWbwxqJ9TeFFAoou3evTPDrug7qpMYznPntMu1IKhVnwpquIXt9S/tsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794699887;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=2KmlMcUCn1VuTpuR2dzvTUv5vVaG8QkaQ53na1ScPCo=;
	b=EePk/1tePi+ZwFCPk5C0UESY7jauD5+66dpbguuTQZTy9YB5F4H6GyPMXA5VDrd05Zsj
	 6oRVOpGmspat2RNpCp0/Phs4aFCiOVv0VWa3TzX556kmZOv0saL/xWz9soonuhHSK6IKK
	 FEFHIdjm3JhbLftaz2Vv1xwGqBpOCZcVqil+VRXh0Yy9HoixqbIgJKUsj+jyhDfPs3tTW
	 CwNsGWb0TXrpabc4PNysWW09AJUXxLMOqcaHGdVv92onA+Prh+Khq3k4ZgRXWawuCD9vy
	 tJNKRahYwUg8J+Rqm57SOIT5Db65JnuLx5DFYDUnEiZ58FN8rQJ52ZAl0SE3e8fizFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jhN6hYFd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D181606A329;
	Sat, 14 Nov 2026 23:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jhN6hYFd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A871F000C5;
	Sat, 14 Nov 2026 23:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794699887;
	bh=2KmlMcUCn1VuTpuR2dzvTUv5vVaG8QkaQ53na1ScPCo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jhN6hYFdT8VglO1MPzWZNHQs3OzGZ9a3EF58LkQ9HX4qCvBbE4K+bKTqeI+brW/xX
	 zR+CQGno9U/UcqhBXTccm6yVLAGFoKXsSSikBVJpboQkf2oIJFM93Yz4XmmRkTtlYI
	 VXjRPG5M07+044ZjUvRdfHuwQK8LqYTCZedweAw1w2DYB1Ys8lvlFFeBU00bUGUAOp
	 uEEVdg/C7Rz58EZza/8UbujvJ5Gzs3MmWaYbgDg1vCzDVvpGBUwAC0VNxu9LNYu8ev
	 N3aQlPkcVbRyrMqJIplPqBsQ/pToG34Sn+fCYiGBChXfvPONqdLg0Jk8pIdGKZHnQ3
	 cpq99D6Jg075g==
Date: Sat, 14 Nov 2026 23:44:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Arka Mondal <arka@arkamondal.net>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Robert Eshleman
 <bobbyeshleman@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] iio: light: Report the available lists via
 read_avail()
Message-ID: <20261114234440.60d61186@jic23-hlaptop>
In-Reply-To: <20261109050738.93424-1-arka@arkamondal.net>
References: <20261109050738.93424-1-arka@arkamondal.net>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Nov 2026 14:07:36 +0900
Arka Mondal <arka@arkamondal.net> wrote:

> These are patches 1 and 3 of the v1 series. Patches 2, 4, 5 and 6 are
> applied and are not resent.
> 
> Changes since v1:
> 
> - isl29125: the available bit goes in info_mask_shared_by_all_available
>   instead of info_mask_shared_by_type_available, which is the sharing
>   level that names the file scale_available, so the attribute keeps the
>   name it has and no ABI changes. The Fixes: tag is gone with it, and
>   the patch is a cleanup rather than a fix.
> 
> - max44009: the list is IIO_VAL_INT_PLUS_MICRO instead of
>   IIO_VAL_INT_PLUS_NANO. All eight values are a whole number of
>   microseconds, so three zeros go and nothing is rounded.
> 
> I loaded both drivers against CONFIG_I2C_STUB under qemu and read the
> attributes. isl29125 shows in_intensity_scale and scale_available, no
> in_intensity_scale_available, and scale_available still reads
> 0.005722 0.152590. max44009 shows in_illuminance_integration_time_available
> reading 0.800000 0.400000 0.200000 0.100000 0.050000 0.025000 0.012500 0.006250,
> and no unprefixed name.
> 
> Link: https://lore.kernel.org/r/20261102074700.63075-1-arka@arkamondal.net

Applied both to the testing branch of iio.git.
I added a note on the ABI break in patch 2 being a fix of buggy ABI and
cross our fingers case

Thanks

Jonathan

> 
> Arka Mondal (2):
>   iio: light: isl29125: Report the scale list via read_avail()
>   iio: light: max44009: Report the integration time via read_avail()
> 
>  drivers/iio/light/isl29125.c | 29 +++++++++++++++-------
>  drivers/iio/light/max44009.c | 48 ++++++++++++++++++++----------------
>  2 files changed, 47 insertions(+), 30 deletions(-)
> 
> 
> base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e

