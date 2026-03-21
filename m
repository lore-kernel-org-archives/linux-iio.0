Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B37192B90;
	Sat, 21 Mar 2026 19:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774120609; cv=none; b=sJXFq1JpBtwDjxm7+jwvbodj3n7NpZD7GgO6KRan9oHdkTtomSn1hFcD+uy0dw8VoKySY1d6iKTGvp2Q+Z0mchruGgxNSiwTHhRVSm/KIwS4uZ5UpuEGomChPhVvgbkCsLo2e7YuHpEqIIhc6NxcL5Vi5WupgjBokurNeXELLO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774120609; c=relaxed/simple;
	bh=eKDUR8hjUfW3SJ7QBjBzBKaaBqjQZ6NClaLJiKzij1w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kbxhmgp1ReieBk+ThjYuqI38WKJncGvv4cJ8h+YJdOLrp2jHhe5IKDIl+9QMTzNhioXB9DBdOcQnNqc50VH+o+TR/Pn/K4lG9Nyr6HpFyUEF1TsxzE6vPQqWpE25cJs67V1GBTxrpAbHqdQnVUthwJqIzb083beNWsrPZwTW3ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUjdKh8T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUjdKh8T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F285C19421;
	Sat, 21 Mar 2026 19:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774120608;
	bh=eKDUR8hjUfW3SJ7QBjBzBKaaBqjQZ6NClaLJiKzij1w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WUjdKh8TyFartyGCz1lPTScfsGp4ZHs9WQh8F3Hbki31CAN1KnvXCncNpdEYKLoQr
	 evW1ZpdV3PSby71FbgA3kQdcNwCWnfQSNxXCvdPakbKXijeeyLqeMpvOm2WxNj1pxO
	 zCPPwAFcsX7vQeqTvnffzUnBeq0u5VULXmT75Owu8vFb7kgcojGRztAn8oDOIio955
	 zLBGuPjEs5Z86333sEo+rcYSmFuh/We70kWV0Qyyo3ZyJmHshjhlpJo7NXUdTnHgeO
	 j+1uOWQlcqGh743LbMFlm+Lh+7s5u+T3T4alx7VRcONpvKiCUFNnYFD8s/71mZXynK
	 /GPG2zUOxZu4Q==
Date: Sat, 21 Mar 2026 19:16:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Shi Hao <i.shihao.999@gmail.com>
Cc: andriy.shevchenko@intel.com, andy@kernel.org, dlechner@baylibre.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 mazziesaccount@gmail.com, nuno.sa@analog.com
Subject: Re: [PATCH v5 04/14] iio: imu: fix typo from adjustement to
 adjustment
Message-ID: <20260321191640.3cafab02@jic23-huawei>
In-Reply-To: <20260316090023.14691-5-i.shihao.999@gmail.com>
References: <20260316090023.14691-1-i.shihao.999@gmail.com>
	<20260316090023.14691-5-i.shihao.999@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Mar 2026 14:30:12 +0530
Shi Hao <i.shihao.999@gmail.com> wrote:

> Fix incorrect spelling in a comment.
> 
> - adjustement -> adjustment
> 
> Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
Applied.
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
> index 6aee6c989485..47394594d17a 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
> @@ -125,7 +125,7 @@ static int inv_magn_init(struct inv_mpu6050_state *st)
> 	}
> 
> 	/*
> -	 * Sensitivity adjustement and scale to Gauss
> +	 * Sensitivity adjustment and scale to Gauss
> 	 *
> 	 * Hadj = H * (((ASA - 128) * 0.5 / 128) + 1)
> 	 * Factor simplification:
> --
> 2.53.0

