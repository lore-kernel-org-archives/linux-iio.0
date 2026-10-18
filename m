Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459AE3C345C;
	Sun, 18 Oct 2026 22:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792363874; cv=none; b=CMOcJ80T2xXAUowLXqsrZ/h04Q5tZEoI3lydYwnjEic/JBJwE2RXzsGxkxF1QFhtROKz8CbILnBZ7aVMdfhlgysf0oLxaRblKmYxmVL9yRZ81zKBTOsWhnhVXPL9/dlAbYPFxt5biPKO+2oNXQw2wH5FyniTrU6s8USYM54MW/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792363874; c=relaxed/simple;
	bh=xk4xl7yKRg9h72kbfdeaahlr6AWqxfywQyViCwJR8Zo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JbGAOuulRiuwWQtKMMl5UHhaeJLJP/tyretCtZpsWlPDGUgcsUpMzF0t3h8c5pyOn/yKLuEzNU8DoNWP+KUIPHc0lqZY4ztv84dREkopezcD+sXUvsSzzSHDI+330swmTt86dP4jtDvqOv+UNbygqOt2fUSKlPMWf0jyqTcbvTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ELpnZAvc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ELpnZAvc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 479571F000C4;
	Sun, 18 Oct 2026 22:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792363872;
	bh=fN1au1C51cKJOlzjz55aHd/ETyVpJQBoZOkakCz4fxE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ELpnZAvccn2INvmzPV/SfTOBT8eCLdS6gBHeEoO6JtBhdaqgFStx1oLcImM2O7fzx
	 IsKRRSI1gZCHJW4ptXXHeBBmMdg5Afoc6+nGqeiqWjpHsu8G//evEhJLdI4/9jY/KU
	 CB2t4HLAoI+zdPPuwTfrDEMm6tjkC4LaDYcdb+yDsWLqBiqGiL+4xpSCf/rqoNhvsF
	 UaW3K+0DhF6yrhpyF2Io421hQ1Q5Pyes06fI67n2TllQnFLB9xITjz7t1hwkGmkfDm
	 tzBPJjvdwIHParj3JFlAeJeqS7CHIwyXhKBS7Av0uj+/WJ4xdq+pFYCkph8p/dTEuw
	 DOAcTlR7kHe4w==
Date: Sun, 18 Oct 2026 23:51:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Salah Triki <salah.triki@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: temperature: tsys02d: Fix state
 desynchronization on resolution write error
Message-ID: <20261018235106.06f3ed48@jic23-hlaptop>
In-Reply-To: <20261005161950.000066da@gmail.com>
References: <20261005132004.255462-1-salah.triki@gmail.com>
	<20261005161950.000066da@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Oct 2026 16:19:50 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Mon,  5 Oct 2026 14:20:02 +0100
> Salah Triki <salah.triki@gmail.com> wrote:
> 
> > In tsys02d_write_raw(), dev_data->res_index is updated before checking
> > the return value of ms_sensors_write_resolution(). If the hardware I2C
> > write operation fails, dev_data->res_index remains updated with the
> > new index despite the physical sensor remaining in its previous state.
> > 
> > This leads to a state desynchronization where subsequent reads via
> > tsys02d_read_raw() return an incorrect sampling frequency.
> > 
> > Fix this by handling the error path first, updating dev_data->res_index
> > only on success, and using guard(mutex) to clean up locking.
> > 
> > This was found through manual code review.
> > 
> > Fixes: 53bf4d067d51 ("Add tsys02d meas-spec driver support")
> > Signed-off-by: Salah Triki <salah.triki@gmail.com>
> > ---  
> 
> Makes sense.
> 
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> 
I'll take this one the slow path given it is a fix for an error
case we don't really expect to see.

Applied to the testing branch of iio.git.

Thanks,

Jonathan

