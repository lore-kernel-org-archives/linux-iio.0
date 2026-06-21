Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47AD2ED141;
	Sun, 21 Jun 2026 17:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782063911; cv=none; b=sAo+FhxIFAft1NKQKdiFDDIq/8PAVB5XKo9SZl+zI5Tm3b1xxHUMOouZ5LFgcTEVtveL100d8/b1rMdhPtg7hdLV4we7xp8Ra3yA0leYx/D/dozCkM8hK9Bl+rL4GNpmmG7pGLf9us8PG1mmq15Xe8Jce3TBAK/Bma36mCjUUm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782063911; c=relaxed/simple;
	bh=sqZEyJRV4wVnzaqKk/FXXmISdUGaS7beTCzqAAM6uac=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OSuACTONQ+exjGqFQIN25Vnh9lMCDz9S6z72mS6r+WwPwX94czlQ4l+tkQ+Q32SL4C0ZEdNdLLd3y3ILIE22bFQmnGjXO4PpYJ1oNpMeAtEtqXMHBlbJjML3qNN225f9Jt4SvLBmsmuCK98sI2CiDOiaI2vGQWmIw+q16UdyDOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mCAYQ3c/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCAYQ3c/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A661F000E9;
	Sun, 21 Jun 2026 17:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782063910;
	bh=keA/Wzh3w0PmlgEJU+hlK1X0S+C/P8/vh/nuxU/5sKw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mCAYQ3c/IsrtFnSYPgC4yz6zRqgUJbk03Q4wlAxiWfB35hsZzSoWkuW6Rgerfk57F
	 TrmbOz/uX59I4lXjP1E63sSFF4aJsyY7L2DGE8xWAS5utOk79qiAXB/inuvQ/G8Vj6
	 pRoWyAEx8ow5WHBe13twNnmJjcfCFhpYI0YT+6j2cPLK8tVQkIjK1jNtaxAG2W52dq
	 LQax02UJhmnGKQ8C43v09dfD89YuSMpTsoTHNMsc7qcUIIryN71R8+34VE7awDq7T6
	 o0KyPm1+kEV4uhgtYHVpczEn47KVQaTVmTIz0snajNWP2e2Bci26hP4jjxH70cf33U
	 7zdK3O/GiA7Aw==
Date: Sun, 21 Jun 2026 18:45:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Biren Pandya <birenpandya@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: gyro: mpu3050: Fix runtime PM leak and refactor
 trigger state
Message-ID: <20260621184502.7c99616b@jic23-huawei>
In-Reply-To: <20260615214504.38979-1-birenpandya@gmail.com>
References: <20260615214504.38979-1-birenpandya@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jun 2026 03:15:04 +0530
Biren Pandya <birenpandya@gmail.com> wrote:

> mpu3050_drdy_trigger_set_state() calls pm_runtime_get_sync() when the
> trigger is enabled, but several error paths in the enable branch return
> directly without dropping the usage counter again. pm_runtime_get_sync()
> increments the usage counter, so every failed enable leaks a runtime PM
> reference and the device can no longer autosuspend. The driver state flag
> hw_irq_trigger is also left set after a failed enable.
> 
> To fix the error unwind clearly and avoid an asymmetric goto block inside a
> monolithic function, this patch breaks the trigger state handler into two
> distinct helpers: mpu3050_drdy_trigger_enable() and
> mpu3050_drdy_trigger_disable(). The enable helper correctly implements the
> error unwind path to drop the PM reference and clear the flag.
> 
> Additionally, pm_runtime_get_sync() is replaced with
> pm_runtime_resume_and_get() for robust error checking.
> 
> Fixes: 3904b28efb2c ("iio: gyro: Add core driver for the MPU-3050")
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Biren Pandya <birenpandya@gmail.com>
> ---
> 
>  drivers/iio/gyro/mpu3050-core.c | 156 ++++++++++++++++++--------------
>  1 file changed, 87 insertions(+), 69 deletions(-)
> 
> diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
> index d84e04e4b431..7dea7ab6b2d6 100644
> --- a/drivers/iio/gyro/mpu3050-core.c
> +++ b/drivers/iio/gyro/mpu3050-core.c
> @@ -950,97 +950,115 @@ static irqreturn_t mpu3050_irq_thread(int irq, void *p)
>   * @trig: trigger instance
>   * @enable: true if trigger should be enabled, false to disable
>   */

As the bot called out.  There are docs here that need to move
with the function.

> -static int mpu3050_drdy_trigger_set_state(struct iio_trigger *trig,
> -					  bool enable)

