Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB463A7D82;
	Sat, 17 Oct 2026 23:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792278345; cv=none; b=IrCzjwTre46hCbcqkqOfrn+68612EpwraAMi0C8EdCX2EYPHtYMqp0EIYWcxp72eyQiQj3RFH++lD2Pw68tb9GYPMGze4jbZfr5o7kvtN2IPznWuUAd8PrZ9HVj1OGZfqU7iEKzy7r6hpxJw+2RcZVYdXKKdOqEvEHe6tjVI1/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792278345; c=relaxed/simple;
	bh=PXVPig7EqycTypNjjoaYNXNFgVf9kEVw9jkRSuvzynI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZSeJOGMHPqyp7T8QEgCKhNnwemP9/OuLwD1kotZpYwW1oSBeupjWY5hPxCbu69vvq4PAvNRjZLD7yuKf4/TZjwRqILUkkU/jJAcf0/5QnmEfjvU3wRfO7PdFeaZGjsXDbj9KCcUZdOe+wgedJugSZ0C9M+aAJmuI+C0tpZRkBWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8vKhvbJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8vKhvbJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B895F1F000C4;
	Sat, 17 Oct 2026 23:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792278344;
	bh=3hnIk0NuGdf7idnEmspQgwD26Xx6WkGASBeA683EU90=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=T8vKhvbJvp8fXGUdtdKHlcf/aAi8d/tK/ejV9nYL9EoYWBK6CScJ7A3VqbNBabgwZ
	 PFAaYiEt/bsbYlN09wuh6skZyBRs7uC3joJVxVS/EPcZTjANazaS3JvKQUxsPsflAH
	 gwBH+1/kTZ//D5cGSxgQpZ119p0kWcyIluxt/kKD2I0eXyz35SFDziZFVDEkxICs+t
	 YpnHZQuU+665Q7E6B/l72icQDwssVlgqHlOyjLPUxXqeuzqIaxQ1M8oZ7A0e+DUYO6
	 hAze2LhgrnoDLX40GRd06TZdutQtb+KtSVXuEj5h7Hi+4p9xuMt2Bnh1FyPW6vbnaS
	 oBfi0+tDC6Tiw==
Date: Sun, 18 Oct 2026 00:05:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: Arnav Kapoor <kapoorarnav43@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: inv_mpu6050: fix magnetometer scale of Y and
 Z axes
Message-ID: <20261018000539.4077736a@jic23-hlaptop>
In-Reply-To: <BE1P281MB14264B9E6725E3B3C471C11ACE9F2@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM>
References: <20261011045619.357261-1-kapoorarnav43@gmail.com>
	<BE1P281MB14264B9E6725E3B3C471C11ACE9F2@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Oct 2026 07:50:52 +0000
Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:

> >inv_mpu_magn_get_scale() returns st->magn_raw_to_gauss[chan->address],
> >where magn_raw_to_gauss[] holds one coefficient per axis, computed in
> >inv_magn_init() from the per-axis factory sensitivity adjustment values
> >(ASAX, ASAY, ASAZ) of the AK8975/AK8963 magnetometer.
> >
> >However INV_MPU9X50_MAGN_CHAN() never sets .address, so it is 0 for all
> >three magnetometer channels. As a result the Y and Z channels report the
> >scale computed from the X axis adjustment value, and userspace scales
> >the Y and Z readings with the wrong per-axis calibration.
> >
> >Set .address to the axis index (0 for X, 1 for Y, 2 for Z) in the
> >channel macro, matching the order used to fill magn_raw_to_gauss[].
> >
> >Fixes: b1392de06184 ("iio: imu: inv_mpu6050: add MPU925x magnetometer support")
> >Assisted-by: LLM
> >Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.
Note I'll be rebasing that tree on rc1 before sending a pull request.

Thanks,

Jonathan

> >---
> >Compile-tested only (W=1); I don't have MPU9150/MPU925x hardware. I
> >checked the built object: before this patch the X, Y and Z magnetometer
> >channels all have .address == 0, after it they have 0, 1 and 2.
> >
> > drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 2 ++
> > 1 file changed, 2 insertions(+)
> >
> >diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> >index 38c3f3b398d4..1614f49be66c 100644
> >--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> >+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> >@@ -1576,6 +1576,8 @@ static const unsigned long inv_mpu_scan_masks[] = {
> > 		.type = IIO_MAGN,					\
> > 		.modified = 1,						\
> > 		.channel2 = _chan2,					\
> >+		/* index of the axis in magn_raw_to_gauss[] */		\
> >+		.address = (_chan2) - IIO_MOD_X,			\
> > 		.info_mask_separate = BIT(IIO_CHAN_INFO_SCALE) |	\
> > 				      BIT(IIO_CHAN_INFO_RAW),		\
> > 		.scan_index = _index,					\
> >-- 
> >2.53.0
> >  
> 
> Hello Arnav,
> 
> good catch indeed, thanks for the patch.
> 
> Acked-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> Thanks,
> JB
