Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0800432693D;
	Sat,  7 Mar 2026 17:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772904556; cv=none; b=VFLViX1GTqAeAC4ib652Sh5e8lK3MSOYzxHqCiGlTmiQQ4R9T8GbofMSBQbKoOfZ2AFkVelm692O6Ie2j3/N3smcaAB3pXEO0x3Zlae0diDe8ItfKOWQA7IGMb5wEFBpJaSaav1ObcTvYQGi9wl52s/09jcYjM0WcyHhGb/yG4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772904556; c=relaxed/simple;
	bh=0piUMOh00fFvFRi3m2f3renFJXBPTjReKzud91lrY4E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uu4P/parAO+o13hRnJNbH3pmloeseS2GNdMO6zTD3xvJojFS4R9WNIlVfL218PUAeGr9V9+eR2C2PgwWdinjl681WSWL+1Y4ynI1iQbow34yOtmiWnmge6rQv2NPXfWzmz65bSAaO670QkbnRR1aNTerGPAqxiOSixWOyCV+uDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p1iqRt4d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1iqRt4d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B281C19422;
	Sat,  7 Mar 2026 17:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772904555;
	bh=0piUMOh00fFvFRi3m2f3renFJXBPTjReKzud91lrY4E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p1iqRt4d9P8Oa6zVaQNQncVFOrL4yjpRHr7PvE655dHjpiXXCkPzj52qo/3jcbzkU
	 p+PtlikOlpmZ5988Ot7APZXZMCgI+PZFd/XkJlSshise/1PajTUTzV3HSs+qibWaOa
	 +2az4hRwz0QRfZzgddWhCW4on0EEexqoR367rj8LMmigVXcx96p2ORUCZeO6zhAC4e
	 BV8JxDkdfOoJXOLzI2sb0MaflX3D+f0qr2EWlGEp8zGX4MWkCt+X+tAEkXy3aLn4U8
	 gLesY/b+/lsTkvCFlN9CceXWiYoaPpsdnm3Q9dwusk+IlQc7xDqYnGWXEVDfb+hE/C
	 ogG8vq7axHQFQ==
Date: Sat, 7 Mar 2026 17:29:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Shi Hao <i.shihao.999@gmail.com>
Cc: andriy.shevchenko@intel.com, andy@kernel.org, dlechner@baylibre.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 marcelo.schmitt@analog.com, mazziesaccount@gmail.com, nuno.sa@analog.com
Subject: Re: [PATCH v2 2/6] iio: adc: fix spelling mistakes in comments
Message-ID: <20260307172906.43d6f976@jic23-huawei>
In-Reply-To: <20260307104705.49129-3-i.shihao.999@gmail.com>
References: <20260307104705.49129-1-i.shihao.999@gmail.com>
	<20260307104705.49129-3-i.shihao.999@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  7 Mar 2026 16:17:01 +0530
Shi Hao <i.shihao.999@gmail.com> wrote:

> There were several spelling mistakes in comments such

Just noticed you have a short wrap to commit descriptions.

Usual (not particularly well documented) convention is up to 75 chars
for these to allow for default git settings indenting them a few spaces.

Otherwise this looks good to me.

thanks,

Jonathan


> as mulitiply, referrence, ocurring, consequtive, and
> celcius, as well as other occurrences. Fix these spelling
> mistakes to improve code readability and consistency.
> 
> Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
> ---
>  drivers/iio/adc/ad4030.c           | 2 +-
>  drivers/iio/adc/ad4170-4.c         | 6 +++---
>  drivers/iio/adc/ad7380.c           | 2 +-
>  drivers/iio/adc/ad7887.c           | 2 +-
>  drivers/iio/adc/ad7923.c           | 4 ++--
>  drivers/iio/adc/at91_adc.c         | 4 ++--
>  drivers/iio/adc/max1363.c          | 2 +-
>  drivers/iio/adc/mcp3564.c          | 2 +-
>  drivers/iio/adc/men_z188_adc.c     | 2 +-
>  drivers/iio/adc/npcm_adc.c         | 2 +-
>  drivers/iio/adc/palmas_gpadc.c     | 2 +-
>  drivers/iio/adc/rohm-bd79124.c     | 4 ++--
>  drivers/iio/adc/spear_adc.c        | 2 +-
>  drivers/iio/adc/stm32-adc-core.c   | 2 +-
>  drivers/iio/adc/stm32-adc.c        | 2 +-
>  drivers/iio/adc/sun20i-gpadc-iio.c | 2 +-
>  drivers/iio/adc/ti_am335x_adc.c    | 2 +-
>  drivers/iio/adc/twl4030-madc.c     | 2 +-
>  drivers/iio/adc/twl6030-gpadc.c    | 2 +-
>  19 files changed, 24 insertions(+), 24 deletions(-)
> 
