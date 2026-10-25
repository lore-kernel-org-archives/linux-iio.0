Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792972353;
	b=JK14gDhcOsple5gyrEFc1Pci+H0hL2X/9+mEHlSm+7QIr/YBEJ4aMIuN1Q/pUQFMdJWZ
	 GCpvROBWjhNvzKVa28gF/y6V35toGkDaRJU3X+FgBNlngA8ub3qDiMqCh0brVWAeaXf9B
	 m21IR/al+qLJmXtSjiYG5QZ/Eb9zCZRhc/+OXHRSPXYMhzjYTKr3SvrJhA7rDB+z8DloR
	 KGW0EBqQ9NqFW4pyOHMIMeNnMzS9HWJcNoRvb0PVTzgZ2np6a0IhTMel3Gx8czwNunERv
	 EycxROJx0kc2fEG2WW6Ap+Xjm62fEM6sLP2eO+7c7F684yEmjsM9TGgtUJTuzYv09LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792972353;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=fPIhY56A0lJsANT23ZtFsSMJWb8Ef6EXLkwShBN+wJM=;
	b=Jnq3MIgGgkfm7lCKfb1a2fMOMbTstsCrnuk/LpF/u6chdl5p3fOXqaaA/RCXaKEs4mT8
	 galMASCUtUEgO21I5Raweq/Tb6BmRSP2GOPo1De+kyueME01UlGKxURmLSNtMV5fBg97G
	 AqfShjrygLW4Au1G+K5IbW5EqPxsD2X31AM2S8sYPm7UJ1mp7xm0EJvfXMKCI9iTD6zHd
	 fL9fJ4L73bu9Jq2O+Ax+UucUp1ObYjCvsGVFepLQOEvo1ThmctBehvIlS0CehD4xA10la
	 77whvLHkR4CO1j5hpf1AnYeeUECkISL9Gj+kDUlXzFjYpW+6sRx0hlaEgxhEQ8tbvlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ieEvz06I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13603606A31A;
	Sun, 25 Oct 2026 23:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ieEvz06I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4481F01825;
	Sun, 25 Oct 2026 23:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792972352;
	bh=fPIhY56A0lJsANT23ZtFsSMJWb8Ef6EXLkwShBN+wJM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ieEvz06IokA3lDxjWWPO/S8Y0W/hAndSRfvEKhMmARdaRm3xyXEBBbi98gc+ll0Mr
	 9OXC2dwU7R5XWR3DqZpMH3worKu9XnuOBKrcqhf5XecQwwBMMszcVjA2A6tgtX/do0
	 QCK05k0Q3BIAzCvdLa4nXvUBnr/yr4lTFJHR0FeMQ5DyWys7224xzVGbvP2wFDKYTh
	 bzfFM+jPrdDlDaW1h2wF6zJVlJLk1XxlaLSz/g52lDw687GS1CdXIJiXpULu80pbea
	 NEwKrQsYI3KKnMig1WoqMS7OOv6MlVWxFkydgCTn4wlj7GfWhg7yPqkFALHcW7wKvK
	 7q4qrxJE4ocoA==
Date: Sun, 25 Oct 2026 23:52:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Cc: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Alexandru Ardelean <alexandru.ardelean@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux@analog.com
Subject: Re: [PATCH v4 3/8] iio: imu: adis: Add optional post_reset_setup
 callback
Message-ID: <20261025235226.1f0fc87a@jic23-hlaptop>
In-Reply-To: <20261023-adis16607-v4-3-a4d541ebfd13@analog.com>
References: <20261023-adis16607-v4-0-a4d541ebfd13@analog.com>
	<20261023-adis16607-v4-3-a4d541ebfd13@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Oct 2026 12:30:20 +0300
Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org> wrote:

> From: Radu Sabau <radu.sabau@analog.com>
> 
> Add an optional post_reset_setup callback to struct adis_data, called
> right after reset and before self-test. Not all ADIS devices need
> extra bring-up between reset and self-test (SPI mode locking, status
> or bootloader checks, pin or burst-mode configuration, etc.) - purely
> additive: defaults to NULL, no change for existing drivers.
> 
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
Hi Radu,

As it seems you will be doing a v5 for other feedback, time to
argue about the bikeshed colour.

> diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
> index c09b381eb619..3d7c7febaec6 100644
> --- a/include/linux/iio/imu/adis.h
> +++ b/include/linux/iio/imu/adis.h
> @@ -52,6 +52,12 @@ struct adis_timeout {
>   * @self_test_mask: Bitmask of supported self-test operations
>   * @self_test_reg: Register address to request self test command
>   * @self_test_no_autoclear: True if device's self-test needs clear of ctrl reg
> + * @post_reset_setup: Optional device-specific hook called after reset,
> + *		before self-test. Not all ADIS devices need extra bring-up
> + *		between reset and self-test (SPI mode locking, status or
> + *		bootloader checks, pin or burst-mode configuration, etc.) -
> + *		only called when set. Must return 0 on success, a negative
> + *		error code otherwise.

Trivial but I wonder if this naming focuses unnecessarily on bit being
after reset.  Maybe simply calling it init() would be enough with
assumption that any intialization is always after reset if there
is one done?

>   * @self_test: Optional device-specific self-test override. When set,
>   *		it is called instead of the generic mask-write/sleep/
>   *		check-status sequence. The callback owns its own pass/fail
> @@ -88,6 +94,7 @@ struct adis_data {
>  	unsigned int self_test_mask;
>  	unsigned int self_test_reg;
>  	bool self_test_no_autoclear;
> +	int (*post_reset_setup)(struct adis *adis);
>  	int (*self_test)(struct adis *adis);
>  	const struct adis_timeout *timeouts;
>  
> 

