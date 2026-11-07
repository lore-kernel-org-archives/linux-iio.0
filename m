Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794078470;
	b=PY08ziW3fuMU5/82eWn/lIiDGg5fE/Hhyb6SXQP+KgK4msWWAJWTxce+Qmjm0t+tjvqM
	 XCfBHIlbKO71ujfc3wGvKl7x3pomP2B7DIIdAcjynNbgr4mxwOkMDjnvF+j74mLNrExt3
	 Z6Z5x9Lftxv8FSix7GZvUbI4sMI3LVAyB6iKxC7LO+Arl2SB3XTpB47p4wlxoaLI7mXTW
	 NJ3Ewr++1mHlJe4LLK6xU76bAUDSg4LmDY5Qi58Yv+UmcEsbZc5beaADFbsU4FcaRnDOH
	 7/9Q6693dKSv3QZoPeNnlFQNULbl51qnJN6WZ/kaBVpQtALevw7n/I6XqP9Z19AI82A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794078470;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=cyz2NFxR2TTqznASBFfFVQdH/HjNm93pYhLVGS1WQFs=;
	b=ksS9zYQxaPndGCrHIJuPumlcbSIvdntA+om4h/eOw6FzjkSRLQD63ZCK5QdI24fU9tys
	 JrGUjYac+Zvd4i+RQ2BW+7SS7DkJ7vf7yKMkG4rd4CPPjvT1N6nc5Zn7ZV7kiDn3WV823
	 /PTo/gZg3f8vNmMz9BpLcXAGoY+kXBas+TTaOrLT0iXmDQnDRk8aB+P50Jy7EoRjB0dzD
	 NiJdDek8qAPviYAUoUqSep27q6ik85xVXjMi2cmYRAFVYyYY3fOd/4oUC1JIU65zmvPgs
	 9scw+wdtMbaMAGBF+0q0+KvYzryaIMp5fcNMBAw+k2Y9m7rtjvnsZVrU7RR3Hr1q+zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YrpiGbFd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6466C606A32C;
	Sat,  7 Nov 2026 19:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YrpiGbFd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 252FE1F0089F;
	Sat,  7 Nov 2026 19:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794078469;
	bh=cyz2NFxR2TTqznASBFfFVQdH/HjNm93pYhLVGS1WQFs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YrpiGbFdJS6XCu941w0dbx2RfXi88d89t8XsOQ/nXEhw5JWr6bsZECFD70cPsjsEM
	 YEtaS5k2eO++bZ2Wvo03ah9sidP3iX/FrGPQHdqjyDDzEznSxfs7jyzdvHtKufHTtS
	 rSzRp5taPNAg0GuHLlGoD4+GZ3WT3zFx315FPtdXDYU2pim47Pq68F0v43O4G4PPGj
	 HNnWnCyYRqoUbHOL7y0+O7Dv1xMkethoFFLIYAjNyVeWOigNTFof7k/k1SyCz6z8p9
	 MoNu9fUmCRjgUN0QSPZLrs4Vk418Lm9u4rZgHN6Hd1b52spzDAnMQ028pECOK0qboz
	 +QDL0hRs6Uvkw==
Date: Sat, 7 Nov 2026 19:07:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Gwendal Grignou <gwendal@chromium.org>,
 Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: proximity: sx9360: reject unsupported hardware
 gain values
Message-ID: <20261107190744.7640de2a@jic23-hlaptop>
In-Reply-To: <20261107111710.442318-3-kapoorarnav43@gmail.com>
References: <20261107111710.442318-1-kapoorarnav43@gmail.com>
	<20261107111710.442318-3-kapoorarnav43@gmail.com>
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

On Sat,  7 Nov 2026 16:47:04 +0530
Arnav Kapoor <kapoorarnav43@gmail.com> wrote:

> sx9360_write_gain() passes any value from userspace to ilog2() and then
> FIELD_PREP() into the 3-bit PROX_CTRL0 gain field without checking it.
> Only gains of 1, 2, 4 and 8 are supported (and listed in
> hardwaregain_available), but other values are not rejected:
> 
>   - 3, 5, 6, 7 are rounded down to the next power of two;
>   - 16 to 128 write gain codes 4 to 7, which the driver does not
>     advertise, and the next read reports gains of 16 to 128;
>   - 256 and larger wrap around in the field, e.g. 256 sets a gain of 1;
>   - 0 and negative values write code 7 (read back as 128), because
>     ilog2(0) is -1 and a negative int becomes a large unsigned value.
> 
> The write returns success in every case.
> 
> Return -EINVAL for anything other than 1, 2, 4 or 8.
> 
> Fixes: 1cdb4c47f7f5 ("iio:proximity:sx9360: Add sx9360 support")
> Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
Same comments as for the previous.  Fine to reject stuff that will
get unexpected results. The rounding down is more reasonable so
don't reject that.

J
> ---
>  drivers/iio/proximity/sx9360.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx9360.c
> index 2a9b37df8f62..c6e5b3e557bb 100644
> --- a/drivers/iio/proximity/sx9360.c
> +++ b/drivers/iio/proximity/sx9360.c
> @@ -625,6 +625,9 @@ static int sx9360_write_gain(struct sx_common_data *data,
>  {
>  	unsigned int gain, reg;
>  
> +	if (val <= 0 || val > 8 || !is_power_of_2(val))
> +		return -EINVAL;
> +
>  	gain = ilog2(val);
>  	reg = SX9360_REG_PROX_CTRL0_PHR + chan->channel;
>  	gain = FIELD_PREP(SX9360_REG_PROX_CTRL0_GAIN_MASK, gain);

