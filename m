Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219511A9FA4
	for <linux-iio@vger.kernel.org>; Sat, 21 Mar 2026 21:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774127482; cv=none; b=TghULs8xfgOnc3FC1AUx/DcZZpEBTrVB9j6b3W/SHzx4+VQnZZ5z+IYiqhFWN2VfgP0RL1Lz1KJohEZBZLYn3aaAJLDFPysrNTBVLQCoUsQgeVphpOnvv/px8GitpqUgoYueWzzDe0nBsn0lKsrYjDozINA6pAnxym1X6IuB39c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774127482; c=relaxed/simple;
	bh=7md0ICLu/wMPVFoM/Vo05CdSxxuoh49aINxNR8msCYk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZYdgOjTgk7lV8aN7EcpJoGHCSeJVFFUd8SERgPudkr8OKnooj54OV2bgHOHRMCCjMHutvjTy7sOY1E1AjjIbVtTEtC2jnLpVY5QSWSUz1W7/qhebanlTwAkTNJDkTWmqyeeQ788tjLKRtfLc8D7ihm7ooJ975zB7dbJRxb12Z78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+dpb+9q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+dpb+9q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C32C19421;
	Sat, 21 Mar 2026 21:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774127481;
	bh=7md0ICLu/wMPVFoM/Vo05CdSxxuoh49aINxNR8msCYk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T+dpb+9qz+buvJYWN/ptlt7JqMcVOyA8t/nOgr2J2bSWGMd/w+Z2GEgdcrtlAlAim
	 5Pxv/q7c40An9wIOLn2xux1A+PrsL/uNZ4n6aqLCOM7r+ZoWB00NakYYeVcecckAvt
	 5Rtwv1xGYH8IqiDUyad9bXapPwAq72+5flTPTEPSxzlsFYC/3FkbLvBMqW0rVWxtKV
	 yYp2gSZlGq6Ptwy0H8XxVpzMN/qc2F+5GG6zSP56+w6hg9pfulYI3NlYkvIk9vM4e0
	 RQBNDk+0MFg9syfNaCOZNkF0N78opJbYtu5wOE4DSrHi68y86eTWlrS0NcVI4gUYrt
	 +QmXXeyNUQWWw==
Date: Sat, 21 Mar 2026 21:11:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: antoniu.miclaus@analog.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7793: Format block comments
Message-ID: <20260321211113.5c162c71@jic23-huawei>
In-Reply-To: <20260312072603.38478-2-giorgitchankvetadze1997@gmail.com>
References: <20260312072603.38478-2-giorgitchankvetadze1997@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Mar 2026 11:26:04 +0400
Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com> wrote:

> Move the trailing "*/" of multi-line block comments to a separate
> line to comply with the kernel comment style.
> 
> This fixes checkpatch warnings:
> 
> "WARNING: Block comments use a trailing */ on a separate line"
> 
> No functional change.
> 
> Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Move these above the thing that is being comment on rather than trying to tweak
comments that too long for being struct after the thing they are talking
about.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7793.c | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
> index 8ff7b70d6632..c56c43468db6 100644
> --- a/drivers/iio/adc/ad7793.c
> +++ b/drivers/iio/adc/ad7793.c
> @@ -35,9 +35,11 @@
>  #define AD7793_REG_ID		4 /* ID Register	     (RO, 8-bit) */
>  #define AD7793_REG_IO		5 /* IO Register	     (RO, 8-bit) */
>  #define AD7793_REG_OFFSET	6 /* Offset Register	     (RW, 16-bit
> -				   * (AD7792)/24-bit (AD7793)) */
> +				   * (AD7792)/24-bit (AD7793))
> +				   */
>  #define AD7793_REG_FULLSALE	7 /* Full-Scale Register
> -				   * (RW, 16-bit (AD7792)/24-bit (AD7793)) */
> +				   * (RW, 16-bit (AD7792)/24-bit (AD7793))
> +				   */
>  
>  /* Communications Register Bit Designations (AD7793_REG_COMM) */
>  #define AD7793_COMM_WEN		(1 << 7) /* Write Enable */
> @@ -69,15 +71,18 @@
>  #define AD7793_MODE_CAL_SYS_FULL	7 /* System Full-Scale Calibration */
>  
>  #define AD7793_CLK_INT		0 /* Internal 64 kHz Clock not
> -				   * available at the CLK pin */
> +				   * available at the CLK pin
> +				   */
>  #define AD7793_CLK_INT_CO	1 /* Internal 64 kHz Clock available
> -				   * at the CLK pin */
> +				   * at the CLK pin
> +				   */
>  #define AD7793_CLK_EXT		2 /* External 64 kHz Clock */
>  #define AD7793_CLK_EXT_DIV2	3 /* External Clock divided by 2 */
>  
>  /* Configuration Register Bit Designations (AD7793_REG_CONF) */
>  #define AD7793_CONF_VBIAS(x)	(((x) & 0x3) << 14) /* Bias Voltage
> -						     * Generator Enable */
> +						     * Generator Enable
> +						     */
>  #define AD7793_CONF_BO_EN	(1 << 13) /* Burnout Current Enable */
>  #define AD7793_CONF_UNIPOLAR	(1 << 12) /* Unipolar/Bipolar Enable */
>  #define AD7793_CONF_BOOST	(1 << 11) /* Boost Enable */
> @@ -113,13 +118,17 @@
>  
>  /* IO (Excitation Current Sources) Register Bit Designations (AD7793_REG_IO) */
>  #define AD7793_IO_IEXC1_IOUT1_IEXC2_IOUT2	0 /* IEXC1 connect to IOUT1,
> -						   * IEXC2 connect to IOUT2 */
> +						   * IEXC2 connect to IOUT2
> +						   */
>  #define AD7793_IO_IEXC1_IOUT2_IEXC2_IOUT1	1 /* IEXC1 connect to IOUT2,
> -						   * IEXC2 connect to IOUT1 */
> +						   * IEXC2 connect to IOUT1
> +						   */
>  #define AD7793_IO_IEXC1_IEXC2_IOUT1		2 /* Both current sources
> -						   * IEXC1,2 connect to IOUT1 */
> +						   * IEXC1,2 connect to IOUT1
> +						   */
>  #define AD7793_IO_IEXC1_IEXC2_IOUT2		3 /* Both current sources
> -						   * IEXC1,2 connect to IOUT2 */
> +						   * IEXC1,2 connect to IOUT2
> +						   */
>  
>  #define AD7793_IO_IXCEN_10uA	(1 << 0) /* Excitation Current 10uA */
>  #define AD7793_IO_IXCEN_210uA	(2 << 0) /* Excitation Current 210uA */

