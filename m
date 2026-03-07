Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080BB337BBB;
	Sat,  7 Mar 2026 17:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772904608; cv=none; b=Qnaf0SRE6bTJLFQ5lv3xOs6A6l9Y2LGE5nrCtm9iTDDJULbZqNZDrDV3NQQEyZkmFsnXN1Vg5qtWatBpzcsggC/iBhOQFy/stP/aYEPKTxdzmKaqIYPe1zecqXA0xMRPoUj3V9v60zUiIgZNlgw1jDpXiQ4vfcE8+9+p0d08+To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772904608; c=relaxed/simple;
	bh=yhhLjYCKHTOv4Q+j3I7dnnkZM29xJxZ62F2RS5612sA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WLd7bt9gDO7a4NZCM1BYyqU8XGVLElsfaAyLhzOpj5i1PM3/MEL1+7E0CWFhROZFTwNccJ9Uw1Q/rOnXm9xFwP4416WvTAnX3CjDo14cqeM1ffH5NqK6tEt7DwINJOe2dUiV2q+feO+OFxa6ayGU9zqh4m4nRrjY/wTSNNRmTqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJpRaj0Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJpRaj0Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748FFC19422;
	Sat,  7 Mar 2026 17:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772904607;
	bh=yhhLjYCKHTOv4Q+j3I7dnnkZM29xJxZ62F2RS5612sA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kJpRaj0Qtab9KG9N/SZMndN9NJ4UlIMkliiWEhdbBNcVhEx6V78f1DLfF/2nfUgYN
	 3OlYvakx7dA4yRnYuvH9rgp/fcrVkQ0mxSWIKsnUVMj5kSdfHATnJZ5X64WdV0Mopw
	 qJxGsZnIIJlr09uEddNKsjON5t2vdtvHZJm9aiPgZ4u9Ieo2wWW4NSpNsePtci1jd8
	 qdYueosfnrMv0qQ2JRK2va5nwGRd+hIwwiDIq3fldz35urhwLIrsEIX20ZvSg58+ew
	 IxHqZxC56Ow01aNeym59JI9nQkNytvCataXLTIcxg0q1MSMa83qm/QRnTMzN601W0Y
	 hkwWC2W43fx5w==
Date: Sat, 7 Mar 2026 17:29:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Shi Hao <i.shihao.999@gmail.com>
Cc: andriy.shevchenko@intel.com, andy@kernel.org, dlechner@baylibre.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 marcelo.schmitt@analog.com, mazziesaccount@gmail.com, nuno.sa@analog.com
Subject: Re: [PATCH v2 3/6] iio: amplifiers: fix spelling mistake in comment
Message-ID: <20260307172959.64a3fdfe@jic23-huawei>
In-Reply-To: <20260307104705.49129-4-i.shihao.999@gmail.com>
References: <20260307104705.49129-1-i.shihao.999@gmail.com>
	<20260307104705.49129-4-i.shihao.999@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  7 Mar 2026 16:17:02 +0530
Shi Hao <i.shihao.999@gmail.com> wrote:

> fix incorrect spelling in comment
> 
> - Curren -> Current
As with the 1st patch, as it's just one thing good to say what it is
in the patch title as well as here.

Thanks,

Jonathan

> 
> Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
> ---
>  drivers/iio/amplifiers/ada4250.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/amplifiers/ada4250.c b/drivers/iio/amplifiers/ada4250.c
> index 40f396ea9069..71e361af2074 100644
> --- a/drivers/iio/amplifiers/ada4250.c
> +++ b/drivers/iio/amplifiers/ada4250.c
> @@ -109,7 +109,7 @@ static int ada4250_set_offset_uv(struct iio_dev *indio_dev,
> 
> 	/*
> 	 * Compute Range and Voltage per LSB for the Sensor Offset Calibration
> -	 * Example of computation for Range 1 and Range 2 (Curren Bias Set = AVDD):
> +	 * Example of computation for Range 1 and Range 2 (Current Bias Set = AVDD):
> 	 *                     Range 1                            Range 2
> 	 *   Gain   | Max Vos(mV) |   LSB(mV)        |  Max Vos(mV)  | LSB(mV) |
> 	 *    2     |    X1*127   | X1=0.126(AVDD-1) |   X1*3*127    |  X1*3   |
> --
> 2.53.0

