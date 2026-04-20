Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE493A873A;
	Mon, 20 Apr 2026 14:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776695144; cv=none; b=OniLvSlZu83eWENF8v/HHqC8G7872/KZsA9VBsD4bRTrXdtNEH60545GoJa28W+G4kih5rWr9iplaAWQnFvZoPiOPBfZacqUdWNZEQqm7O+5INnTRxWhtuSOAlGuW5XjoWUrzgL7quQvpvLjxJlzopctRGA3NKNuBDtazpgvHiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776695144; c=relaxed/simple;
	bh=kZ+s/Nwn78KcaXqnaXAIyBNa6oHj1Fx+ThsDHANH3S4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N2YA+NNHfOklX5G7FzT8snvRt26EqBNz7UpMT5yvh0F2/WAi6DoeycVvpRxvYk0gZXOoGgCMi3zOWrRZ/KnGs+Py9gSVVKmUqSSsbPfuk1+fQSlrhrLipojDDgzKIosfvty7eS/QlTbidUTr+ZKbialMr+SCd4IgZRMU/8RZyoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ExUiQqn6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ExUiQqn6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50395C2BCB4;
	Mon, 20 Apr 2026 14:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776695144;
	bh=kZ+s/Nwn78KcaXqnaXAIyBNa6oHj1Fx+ThsDHANH3S4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ExUiQqn6lWdhD1k+6jDbIp2sUKTEj4P9z0/Ceq2imfVx1rWY1QAjLXql81bL8MBKV
	 fiQ4oUWTjK+R7YJly+RYfcD/BALXQ1q4r0+i6BIoJfaNhjVP9oGruvXvqzPEwf5spx
	 sPaGHBIuZ7woa1TX9jgRZaCGDE19Gk/OOZbstE7q2WSrpgP081UmbD8Zl1cT6vyruZ
	 3VdtlCTNNcDV9KRIYDsVRZtY9OQQ5bmm4LbBM9eTzE+ZUS0INU4i/NRV/aid2MPiuG
	 bZAGEXt94eQYPyZEwukX/jtX233jyjsWjbu8bdZgFlefNLWxmGkvSCyBGEINfbC2VD
	 Ychp7N4EvbZww==
Date: Mon, 20 Apr 2026 15:25:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Hardik Phalet <hardik.phalet@pm.me>
Cc: gregkh@linuxfoundation.org, andy@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, dlechner@baylibre.com, krzk+dt@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-staging@lists.linux.dev, me@brighamcampbell.com, nuno.sa@analog.com,
 robh@kernel.org, skhan@linuxfoundation.org, Hardik Phalet
 <hardik.phalet@gmail.com>
Subject: Re: [PATCH v3 4/5] iio: magnetometer: qmc5883p: add oversampling
 ratio support
Message-ID: <20260420152533.060c8f9a@jic23-huawei>
In-Reply-To: <20260420-qmc5883p-driver-v3-4-da1e97088f8b@pm.me>
References: <20260420-qmc5883p-driver-v3-0-da1e97088f8b@pm.me>
	<20260420-qmc5883p-driver-v3-4-da1e97088f8b@pm.me>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 19 Apr 2026 22:32:56 +0000
Hardik Phalet <hardik.phalet@pm.me> wrote:

> Expose the CTRL_1 OSR field through IIO_CHAN_INFO_OVERSAMPLING_RATIO so
> userspace can select among the four oversampling settings (1, 2, 4, 8)
> supported by the device. Read, write and available handlers mirror the
> existing SAMP_FREQ plumbing and use the already-present rf.osr regmap
> field.
> 
> Signed-off-by: Hardik Phalet <hardik.phalet@pm.me>
> ---

> @@ -306,6 +320,18 @@ static int qmc5883p_write_odr(struct qmc5883p_data *data, int val)
>  	return -EINVAL;
>  }
>  
> +static int qmc5883p_write_osr(struct qmc5883p_data *data, int val)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(qmc5883p_osr); i++) {

Whilst a fairly recent thing, it is now considered fine to do
	for (int i = 0; i < ... 

> +		if (qmc5883p_osr[i] == val)
> +			return regmap_field_write(data->rf.osr, i);
> +	}
> +
> +	return -EINVAL;
> +}


