Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8642C3644C1;
	Tue,  1 Sep 2026 01:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788226058; cv=none; b=Xlzctpa+Sb4eNGy2ht486kTg6/3isXNZqsoaq+mdaK1sfYs75VC1lNOVcvpiGluq3ANV8g/n5BqhDYb2hkPWJoxVTa0fm/TF2ftSHQKEY8CkwQ2+toxL7fV0re2lMwSyYIW560WZtgg5jWxPHEh3VgSDMLjeHGWorO64iMMFJEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788226058; c=relaxed/simple;
	bh=dPUbXtUpVQce6L2rkl6gdMyl272vjbuTIlA2WBa/9WA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y2vih+8BSlm8FD4H+Ec9i93cl+AhIhphHWyuZDrtsK667zXl/H4stl2S6TCbHK32SpvHH1Lk3szDXxW2/klyL9uetmcPD6z1N8ZowLzCdxFhBtHKcIQWave2lcufgEm7VaMuM99XW8QoC1EaYY9EVvgXW/s3yGfSfZ4hH2bz64w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fk2/XIob; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fk2/XIob"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 099061F000E9;
	Tue,  1 Sep 2026 01:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788226057;
	bh=KPTGYcc6tMbGzBHV2jLq7SJqWpOtKGZN6srs/Q+RVnI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Fk2/XIobZKW8sRkFW1kPdrfApTUbiFTyD551HFxfyDbD+kBCWdM5fredYCy/3tZOQ
	 TVUDWb6dsxKVQACOPfcw1pNmR2fftDE8Sg4ZShBLm9viZNWqx5zFQm1eLpR1q3pu7c
	 pbjRv21KjyethzkVlzMLOGLc/EXD2NBZhGKZMT9EFeD3qAsjB59J83mBbHgyAB3MVO
	 jY5wT8p4nsi3NO5leoVmvo9n79rosYGKYLXzR/7AmU5Ci/ouXP5Lraod1YI7a99mcu
	 bkf7l2Q8/e+0hKYicq3v0ei+8r9xy1gjU5c8znl0ImIJ5mMm0fYELex2PwNXlLcq2T
	 vcr9SxclDyK8w==
Date: Tue, 1 Sep 2026 02:27:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Salah Triki <salah.triki@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Ivan Mikhaylov
 <fr0st61te@gmail.com>
Subject: Re: [PATCH v2] iio: proximity: vcnl3020: fix ISR bitmask check in
 IRQ handler
Message-ID: <20260901022731.10771244@jic23-huawei>
In-Reply-To: <20260824042908.8887-1-salah.triki@gmail.com>
References: <20260824042908.8887-1-salah.triki@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Aug 2026 05:29:07 +0100
Salah Triki <salah.triki@gmail.com> wrote:

> The threaded IRQ handler contained multiple issues in handling interrupt
> events and clearing status flags:
> 
> 1. ISR bit check: The handler incorrectly checked the Interrupt Status
>    Register (VCNL_ISR) against VCNL_ICR_THRES_EN (BIT(1)), which is a
>    bitmask meant for the Control Register (VCNL_PS_ICR). In VCNL_ISR,
>    BIT(1) corresponds only to low-threshold interrupts. A high-threshold
>    interrupt (VCNL_INT_TH_HI, BIT(0)) on its own was completely ignored and
>    returned IRQ_NONE.
> 
> 2. Event direction & channel index: The handler unconditionally pushed a
>    RISING event code on channel index 1. The driver only registers a single
>    proximity channel (index 0), and low-threshold interrupts should be
>    reported with IIO_EV_DIR_FALLING.
> 
> 3. ISR clearing: The write-back to acknowledge the interrupt only preserved
>    BIT(1) instead of masking against both valid status bits.
> 
> Fix this by checking both VCNL_INT_TH_HI and VCNL_INT_TH_LOW bits in
> VCNL_ISR, pushing separate IIO events with the correct direction and
> channel index (0), and properly clearing handled status bits.
> 
> Fixes: 3363fbbe19e5 ("iio: proximity: vcnl3020: add periodic mode")
> Signed-off-by: Salah Triki <salah.triki@gmail.com>

Trying an active address that is hopefully the same Ivan!

This looks fine to me, but I'd ideally like input from Ivan.

Jonathan

> ---
> Changes since v1:
>   - Extended the patch to fix additional bugs found in vcnl3020_handle_irq_thread():
>     - Corrected event directions (RISING for high threshold, FALLING for low threshold).
>     - Fixed channel index from 1 to 0 (matching single proximity channel).
>     - Corrected ISR W1C clear logic for both HI and LOW bits.
>   - Updated commit message to detail all IRQ handler fixes.
> 
>  drivers/iio/proximity/vcnl3020.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/proximity/vcnl3020.c b/drivers/iio/proximity/vcnl3020.c
> index 7f417372566a..d0b8f429999f 100644
> --- a/drivers/iio/proximity/vcnl3020.c
> +++ b/drivers/iio/proximity/vcnl3020.c
> @@ -584,16 +584,26 @@ static irqreturn_t vcnl3020_handle_irq_thread(int irq, void *p)
>  		return IRQ_HANDLED;
>  	}
>  
> -	if (!(isr & VCNL_ICR_THRES_EN))
> +	if (!(isr & (VCNL_INT_TH_HI | VCNL_INT_TH_LOW)))
>  		return IRQ_NONE;
>  
> -	iio_push_event(indio_dev,
> -		       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, 1,
> -				            IIO_EV_TYPE_THRESH,
> -				            IIO_EV_DIR_RISING),
> -		       iio_get_time_ns(indio_dev));
> +	if (isr & VCNL_INT_TH_HI) {
> +		iio_push_event(indio_dev,
> +			       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, 0,
> +						    IIO_EV_TYPE_THRESH,
> +						    IIO_EV_DIR_RISING),
> +			       iio_get_time_ns(indio_dev));
> +	}
> +
> +	if (isr & VCNL_INT_TH_LOW) {
> +		iio_push_event(indio_dev,
> +			       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, 0,
> +						    IIO_EV_TYPE_THRESH,
> +						    IIO_EV_DIR_FALLING),
> +			       iio_get_time_ns(indio_dev));
> +	}
>  
> -	rc = regmap_write(data->regmap, VCNL_ISR, isr & VCNL_ICR_THRES_EN);
> +	rc = regmap_write(data->regmap, VCNL_ISR, isr & (VCNL_INT_TH_HI | VCNL_INT_TH_LOW));
>  	if (rc)
>  		dev_err(data->dev, "Error (%d) writing in reg (0x%x)\n",
>  			rc, VCNL_ISR);

