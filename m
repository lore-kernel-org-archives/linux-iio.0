Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6767A2DE6F1;
	Sat, 21 Mar 2026 17:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774115446; cv=none; b=jaQ0c0VrAVtjOi4mbZI02CSBl2gCdBzCfrdxTp5YjijDmMBMQTIPBiuNOCi293l03t6MDpDsOjUJxJ9IxFUNq17Biqag6UE2E5eGPcHb0oCs5Azt4CV53UVaqwFTrj7b0NdreMFQOElARxr9AtIXqbfgMVP+Daan5D+XNIgbCAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774115446; c=relaxed/simple;
	bh=WlpfjXMa/ChNrQGYBFa320G/kg7Eakf+zjKpza9XjK8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uGAq1Oc+Vr5R0bHr8oE4EgwnQ77PCaBw6BycySNnSam3VRO8C1nW7dCBsyb2bnzbjP550rxFA2nfc4n9YSp1xSNbG6es8V8wobD0uXap7zbEk+F+dLMEv8noBL2RS5RX1Q9lyumb2Z98/AQxyDkB5EYrDUJH93Q0WHOgfmk/JIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfBmtXwK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfBmtXwK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1203DC19421;
	Sat, 21 Mar 2026 17:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774115446;
	bh=WlpfjXMa/ChNrQGYBFa320G/kg7Eakf+zjKpza9XjK8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KfBmtXwKANmSjP+03gkIx0drmQPmqoFWSfqh5v2dldKaysB+9Th/3/cIGboh1llZj
	 W7BWswiQdlntgjS2nfzidLAhgN+Z9YY6jzFzCrCoB8DDhWvo3B6R6f8FpV0trVF9Dd
	 w7dOB1T+cJbDbiROqx0fxxlpN2fy04q5bW20pnkoNwwVZksYZFurh8ecib1jA4/tgm
	 zWwCu3hE7VqbCFqcpn2nBPKK1vvnlMg2VpBn+4WK9GB2j8gDE7l8RKS38yByDlLr7O
	 Xb+oGRbrNVlq0EABMNruJ6lDZXz2aqc9i4tRY+4T5a0tz2cOnvYUv75hViMq2aAUlp
	 6xTtKT5G64jQg==
Date: Sat, 21 Mar 2026 17:50:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, jean-baptiste.maneyrol@tdk.com,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 andriy.shevchenko@intel.com, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V2 2/5] iio: imu: inv_icm42600: Add support for using
 alternate registers
Message-ID: <20260321175036.50c6a29f@jic23-huawei>
In-Reply-To: <20260319182956.146976-3-macroalpha82@gmail.com>
References: <20260319182956.146976-1-macroalpha82@gmail.com>
	<20260319182956.146976-3-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Mar 2026 13:29:38 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add support to the existing inv_icm42600 to support similar hardware
> with slightly different register layouts. For example the icm42607
> and icm42607p has most of the same functionality and even many of
> the same registers, but the addresses for indiviual registers differ.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>

> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
> index 11339ddf1da3..32aa2e52df2e 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c

> @@ -775,13 +774,13 @@ struct iio_dev *inv_icm42600_gyro_init(struct inv_icm42600_state *st)
>  	ret = devm_iio_kfifo_buffer_setup(dev, indio_dev,
>  					  &inv_icm42600_buffer_ops);
>  	if (ret)
> -		return ERR_PTR(ret);
> +		return ret;
>  
>  	ret = devm_iio_device_register(dev, indio_dev);

return devm_iio_device_register() now make sense.

