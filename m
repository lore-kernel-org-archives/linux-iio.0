Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BF131D371;
	Mon, 13 Apr 2026 19:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776109190; cv=none; b=APrlJD0SUXe/jEy+1+Iu4ePr5P11uht0o4HC51h2nUZlb+FrTysf8eTelHXjBClHv6ATHdlIuYxxfmYymsBN116gAyLAIv4ZhAXHHOx8hgDOLcR4GB1QsCm0pIOpX/4GBJK/7aX92wGPdYk/4cgdty7R8poa2W9yKIuhPHyzCTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776109190; c=relaxed/simple;
	bh=xTJICU61uWhPhfgMFUbMpWDNifDbHYgS743TqTin9do=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MevTbjZUSUII7omRoj6KggSStKXZ67W4HrxjSAPOsBM3YldYHbJivlqUk3FjJjEObCeoV02H8+DKo1queoIDIXcPBJ8RjhoG7D4wpz1jSTZ8x2GfERpTCZuFTF3AlqoGXcb4pNsWqwPJPD+wRlE+IJ+uit+dqPrLgYBsHD31dXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6r1gMp3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6r1gMp3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0F19C2BCAF;
	Mon, 13 Apr 2026 19:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776109189;
	bh=xTJICU61uWhPhfgMFUbMpWDNifDbHYgS743TqTin9do=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E6r1gMp3Osy+qHhNCnJ9e6KzMwjd9Oj633+ci824omd6ylTe8nlj0BgShPY7Cash7
	 G3Uietb95YyWZTXJFRD8zxl9yQmv5k3SxiC1tOMnzOo4lJPr29WdYVYv1AxQVF2cNF
	 qq+wIQ43GCDqTRVv7zbJPzICfCrplziIVHBwSIyXm2bz/O/hUuB8myOUOxciwfKZKS
	 UdgOiuLVT0xG5Lq4Fv3U1pRndRU9/yZnwa+Q68BTYtwgYl0M7c1JQTb7rPsRxHHlhL
	 BrvPly6dNLKfmHYM5b3eTumSMoeo2RUQVWXFDdV1QRmgfNSbgrmJIwEodaMGZo5rDx
	 Hhtiw8CnIIsXA==
Date: Mon, 13 Apr 2026 20:39:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, jean-baptiste.maneyrol@tdk.com,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 andriy.shevchenko@intel.com, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V3 8/9] iio: imu: inv_icm42607: Add Gyroscope to
 icm42607
Message-ID: <20260413203940.0533f1d5@jic23-huawei>
In-Reply-To: <20260330195853.392877-9-macroalpha82@gmail.com>
References: <20260330195853.392877-1-macroalpha82@gmail.com>
	<20260330195853.392877-9-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Mar 2026 14:58:52 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add gyroscope functions to the icm42607 driver.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
One very minor comment.

> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c
> new file mode 100644
> index 000000000000..80473c07c6a4
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c

> +
> +static const struct iio_chan_spec_ext_info inv_icm42607_gyro_ext_infos[] = {
> +	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, inv_icm42607_get_mount_matrix),
> +	{},
	{ }

> +};
