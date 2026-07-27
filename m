Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB48227B94;
	Mon, 27 Jul 2026 01:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785114604; cv=none; b=XV0vWLaKC4r6VyFZpc/w/G/aj8tq1Ih+UitIjNJl84QhFyE59wkRCuJsse1iJvVYReDt+HnxYwdxO1IYr9RvFJj6zv62QR6wqx0EaeO/j7medRmJuQ3zXcPuNuGUlKcjHnQk8goW7dOvZ4NaVx+Tnb5dr8DiGHTBtiFzHsy4tws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785114604; c=relaxed/simple;
	bh=/2lnLfQ+6mpcXuuk+osIOAfNOjG4abamUzcxuOCMs/0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XKRla8giN0XdnEmRyH+84DZNCnWifNI849wHT/hElJ/aGZjuKKS11jJl2l6tHLTNp+fvYa3kFVCSEWEu78uy8yrZz/lyV8+5+FIFT7ugoXeWd2D03GzrOPaOes1a41pk2oxMgEb7ZqLuA0cNtKzvoVx675musNoMngG3QX9cpVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ldzz2bSd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ldzz2bSd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC111F000E9;
	Mon, 27 Jul 2026 01:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785114602;
	bh=4tTC/X1Rkkv2V3lmYt0Jz6pd4I0gzoGvUjx74QXtY8M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ldzz2bSd2lvE/YZLInqu7njaifqHWmCye4lV5+tHLyfso80Yw0qutaY+sY89XKieC
	 5KEzqk8O2jhe1bNNeBa7uEEM/Xei0rDTXK7DYIaY9E9WI8mB4UyX5HNmTlP8gVL5TK
	 4CDFBzbyxg7CLpkXFs2EB+erYyABMxADSaIKBZFi0kY2WKADHSdPizhFgiurqYhRfa
	 Aop9IwTEbg1ToYpvpVBY31Wr3UrX2tqBc+Nx6m16pf4Kvl7EbCAylAM8gWr199zF0/
	 1bLBxdJiwpOFNcashuPZ3p/0XDf4GK8XW5yNLaSgWX42sve2yDfe0yFAVBkOwVsW7O
	 kvvjcH/TXc/Zg==
Date: Mon, 27 Jul 2026 02:09:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Chris Hall <c-hall@ti.com>, Patrick Edwards
 <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>, Nguyen Minh Tien
 <zizuzacker@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: ti-ads112c14: add support for buffered
 read
Message-ID: <20260727020958.4e39fe87@jic23-huawei>
In-Reply-To: <20260724-iio-adc-ti-ads112c14-buffered-read-v2-2-98b06f3d47d9@baylibre.com>
References: <20260724-iio-adc-ti-ads112c14-buffered-read-v2-0-98b06f3d47d9@baylibre.com>
	<20260724-iio-adc-ti-ads112c14-buffered-read-v2-2-98b06f3d47d9@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jul 2026 10:55:07 -0500
"David Lechner (TI)" <dlechner@baylibre.com> wrote:

> Add support for buffered reads using a triggered buffer.
> 
> The device has a continuous conversion mode, but that can only be used
> with one channel at a time since there is nothing like a sequencer to
> support that in hardware. Instead, we use single-shot reads like we do
> for direct reads to be able to read multiple channels.
> 
> Since CRC is always enabled, buffered reads include the CRC byte along
> with the raw data without verifying it. This allows userspace to perform
> it's own CRC verification per-sample and drop bad samples rather than
> failing the entire buffered read for one bad sample.
> 
> Support for continuous conversion mode could be added in the future if
> needed.
> 
> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
Looks fine to me other than the thing sashiko caught.

J
