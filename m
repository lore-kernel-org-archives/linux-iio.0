Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C7A171B1;
	Sun,  2 Aug 2026 17:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785692849; cv=none; b=qM3NSXYekAGHxgxm/iOcRywFrzZ88fE3gidanR5qaJL4iNsytJFZRNtKo2s8tBndHpz8U0ytXr0zSuKPBGbzjMA6X1VbbnihFWeB8pDZcc+ywXBy7Rh7D+ul7MJAbOyg/A7hgys5jCg+Qxw77IuIq03FzPaai96siXpOZ2DL0VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785692849; c=relaxed/simple;
	bh=NclItMCXjIgaGQFlkICOFJ5jUjp2/Gnh46YGf2wHxks=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fzcRHO9oJ1PYA5JDfpmKkuRVhJ9pb/SBqwc/zxDs/1bwB/sYINeSphHzzhzkmCpewwMxWzD0QSwyTXTVkoSdCRaKDWxIJWcsV39nWMnDas3nQ5S16Hb1SH4Wirh9JNrMJsWJdnwa/g/1pdnpzbEQX0OFRAP/GHUzFYxQ2NT9Hwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VEcTTHp7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VEcTTHp7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB191F00A3A;
	Sun,  2 Aug 2026 17:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785692847;
	bh=yYQpMZ3qvpTy6KFrEhfc2zOB7rWztkLMQAcvZ3JlAhM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VEcTTHp7UZVWjKQqoSljn18pRdkD/SMmO70k9YisFboXaRMTYk2TV0fSOJkL0E0lF
	 i3r9p+lc+ySZkwHYxA4X3W1g7Lik7G20pfmatfHL8gk6vX2YYVQoXsQaLbxaaVF2je
	 7d9cSWmPwpFLc8zrWSIihbJIurPdkZJgCb63n1AUlvL2C04nfgo6E8C9pn17Igbvp8
	 kP9taQFJdaLSQ823a8S59BMg+iw7A8jFzrazYF3A7r5rQUD1mXE3+dE4ZAlOP3aFUo
	 brHoi7TFS6XWLVEWwSymCKBwkpReYk5l7GpLhJxkj7z1YL9SDkDWOAiiTzZogABj8i
	 QlF4afeVuAM5Q==
Date: Sun, 2 Aug 2026 18:47:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Philip Mueller <philm@manjaro.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Alex Lanzano
 <lanzano.alex@gmail.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] iio: imu: bmi270: Match PNP ID found on OrangePi
 Neo 2026
Message-ID: <20260802184723.22554361@jic23-huawei>
In-Reply-To: <20260731195325.44453-2-philm@manjaro.org>
References: <20260731195325.44453-1-philm@manjaro.org>
	<20260731195325.44453-2-philm@manjaro.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Jul 2026 21:53:22 +0200
Philip Mueller <philm@manjaro.org> wrote:

> OrangePi Neo devices use BMI260 sensors in their hardware.
> In older firmware they used "BMI0260" as their ID. In newer firmware
> however they switched to "BOSC0260" as their ID for the sensors.
> This change is also seen DSDT tables within newer device firmware.
> 
> Adding the PNP ID to bmi270 driver will load the driver properly on the device.

Hi Philip

The new one is not a PNP ID.  Those only have 3 letters.
They have switched over to using an ACPI ID - which is the other thing you
are allowed to put in _HID in ACPI.

Good to see they are using a valid format at least and hopefully Bosch
have indeed allocated that code to this device.  So rare case of a correct
update.

FWIW BMI was the PNP ID of the Benson medical instruments company.


So with a minor commit text update to reflect that I'll be happy to pick
this one up.

Thanks

Jonathan

> 
> Cc: stable@vger.kernel.org # 6.18+
> Signed-off-by: Philip Mueller <philm@manjaro.org>
> ---
>  drivers/iio/imu/bmi270/bmi270_i2c.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/imu/bmi270/bmi270_i2c.c b/drivers/iio/imu/bmi270/bmi270_i2c.c
> index 7c035e82e6e9..036c6f0f7cd4 100644
> --- a/drivers/iio/imu/bmi270/bmi270_i2c.c
> +++ b/drivers/iio/imu/bmi270/bmi270_i2c.c
> @@ -43,6 +43,8 @@ static const struct acpi_device_id bmi270_acpi_match[] = {
>  	{ "BMI0160",  (kernel_ulong_t)&bmi260_chip_info },
>  	/* GPD Win Max 2 2023(sincice BIOS v0.40), etc. */
>  	{ "BMI0260",  (kernel_ulong_t)&bmi260_chip_info },
> +	/* OrangePi Neo 2026 (since BIOS BCPH01_V1.20), etc. */
> +	{ "BOSC0260", (kernel_ulong_t)&bmi260_chip_info },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(acpi, bmi270_acpi_match);

