Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004EA1EA7CE;
	Sun,  1 Mar 2026 12:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772368066; cv=none; b=CnQnXPjn35zChUrpNLK9pin3boojl7fWBGNEYjfL4nm0QDL4+1xy97qFw42Xt1FYIAn+K+qGLToS+bM8fMhHO4Hh1qXqNsrYtxgcyCVZKDz0/tVSF11vhOLS+9QdgOf0bFDK1U81Lm9ZhjVUIjvYvjs+S4HlEjPTZof0bzJAryY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772368066; c=relaxed/simple;
	bh=G6UeRlgiNHA9TJrb86keHuy+ajfvEWLGBsh27WYDiLk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pqwuX01vm3Mzi2SPrsxReojFlDEEkBkFA+LoM06aUgsS07UvxEfr3VIZUKcjO0NhCawUD9r2CT+Aq+wjEEzb36AADxFFiBgmAQatNYke1voaNWmQVwONP+Hpgy1bk4OH52iNOIHZCaduYMIhM9sy++2sEDVKZgp/FsT3tsDMxTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZT3RDGXO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZT3RDGXO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 570A1C116C6;
	Sun,  1 Mar 2026 12:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772368065;
	bh=G6UeRlgiNHA9TJrb86keHuy+ajfvEWLGBsh27WYDiLk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZT3RDGXOTvXGoqMlsN/pBaot/3abgt5GCcK1L1zYyLJHxi9lrSNGmja7opVa9USSl
	 9gVnpmVZEs+2hmUg2OqDuP183HrQ0K++hbBi5NBjggzdVkg0LN+LQqWv+X3sr9d/XD
	 V0vfqP9vE1fInBjV2mO54/PRlXnaek2oE7/iRcAqMXgx72Jv3b2GuNEMptlPNJb8YT
	 gSpdSu9QwrUOXbLnoGy0ZGLGl7fuaxq7imNl35RJO4Xms4fvX8WllAhJlA0o+HcCwn
	 GrUMCkGdhbMLOOIvSv5Hu4zZsTuwO/PNgHWHOYmseayRgLuxQW8QpQVZShHqxcp6wv
	 ye8TT2D1KwUlg==
Date: Sun, 1 Mar 2026 12:27:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: bno055: fix BNO055_SCAN_CH_COUNT off by one
Message-ID: <20260301122738.3e4a74a1@jic23-huawei>
In-Reply-To: <20260214-iio-imu-bno055-count-off-by-one-v1-1-42b2675edc6a@baylibre.com>
References: <20260214-iio-imu-bno055-count-off-by-one-v1-1-42b2675edc6a@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Feb 2026 16:33:54 -0600
David Lechner <dlechner@baylibre.com> wrote:

> Fix an off-by-one error in the BNO055_SCAN_CH_COUNT macro. The count
> is derived by taking the difference of the last and first register
> addresses, dividing by the size of each channel (2 bytes). It needs to
> also add 1 to account for the fact that the count is inclusive of both
> the first and last channels.
> 
> Thanks to the aligned_s64 timestamp field, there was already extra
> padding in the buffer, so there were no runtime issues caused by this
> bug.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> I didn't put a Fixes: tag since this there were no runtime bugs. Didn't
> know if this was worth backporting or not.
I took the view that it isn't obvious that this is not a bug and hence
it might confuse readers in the future.  So I gave it fixes tag.
Still I didn't +CC stable as agree there is no urgency to backport.

Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/bno055/bno055.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/bno055/bno055.c b/drivers/iio/imu/bno055/bno055.c
> index 303bc308f80a..c96fec2ebb3e 100644
> --- a/drivers/iio/imu/bno055/bno055.c
> +++ b/drivers/iio/imu/bno055/bno055.c
> @@ -64,7 +64,7 @@
>  #define BNO055_GRAVITY_DATA_X_LSB_REG	0x2E
>  #define BNO055_GRAVITY_DATA_Y_LSB_REG	0x30
>  #define BNO055_GRAVITY_DATA_Z_LSB_REG	0x32
> -#define BNO055_SCAN_CH_COUNT ((BNO055_GRAVITY_DATA_Z_LSB_REG - BNO055_ACC_DATA_X_LSB_REG) / 2)
> +#define BNO055_SCAN_CH_COUNT ((BNO055_GRAVITY_DATA_Z_LSB_REG - BNO055_ACC_DATA_X_LSB_REG) / 2 + 1)
>  #define BNO055_TEMP_REG			0x34
>  #define BNO055_CALIB_STAT_REG		0x35
>  #define BNO055_CALIB_STAT_MAGN_SHIFT 0
> 
> ---
> base-commit: 0713b26190addfa3a774b386c8658952ef9f7faf
> change-id: 20260214-iio-imu-bno055-count-off-by-one-3b67a0caaaf6
> 
> Best regards,

