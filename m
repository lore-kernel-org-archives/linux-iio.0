Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795083354;
	b=1J73ZmJaOGchG6MpiOwoWnJzKCrqHyKneRByiXpMYL/uCVnD58R/BKJ5V3+CitQKKPH1
	 GUVS/xezos6xTpLLe1icuy48zHjnQfAmPbTQZLxHohvXkxofk7PZLujGcSJLTKZrlMuJ2
	 G6cfpc0pUXPqRfmsD4I0019btggcsIznx3WizS+A+MAUJPIwZRoVP4KuhJP7lJZjaw3Aa
	 CeDcODTWGuqnFFxmwA52e8YoDKJfUPizm2UtrpM6qFdKFEXfcG912PcmJ6L15LxpsRK+r
	 sgh37HfUiebUrhkGEnO/YmA8cUXkK7hRGNjPPl9J+0eJ67FBhk+WcivWUM+lff0D1DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795083354;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=PEa+TiB4bDPS7/DsTFWBrrG3Cs+fHxHFieRwrFs+kFM=;
	b=Qkn78HSF9TQKb3hZbDE68iTi0NhAoJBlAJDMaS6QPtUWseNBUeB6IfmCXk7TTalmwhb7
	 /Xb88YbtbtlTESWFxnZpR7gP9WAT2qweEhPwCnXBckOplz1D0k2VZ1ybkc3et0qjP1Q53
	 zAr00hjfTqi/Me/3rp7btZZdFC0uRG6ZG6T8T8HqTVhfouzKG27nPW1Ue48xDPMGGlVyD
	 ywMBFie36htILOnCkgRi4LkcGdKNo1xiEoJh7WOhcMLeLWmW2OCPH0uDY2+c/mOi25OOA
	 k0YvXLtQGdIXlz70rCfo4GapmHUK316dCll+DVshm0BM3FL9qy0H6B9Q66j3i8J1QHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IV2BTjvJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C51606A320;
	Thu, 19 Nov 2026 10:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IV2BTjvJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C13FE1F000C4;
	Thu, 19 Nov 2026 10:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795083354;
	bh=PEa+TiB4bDPS7/DsTFWBrrG3Cs+fHxHFieRwrFs+kFM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=IV2BTjvJOeDxHGjnzhdGNIYg4qOpe4Rgs/6H4dkFbvzZe5Jamw/gM42EZ3bUBewPL
	 tKj/301fx3iLgCn4aerr7yn6YhYysGaPu22sw7ifGNnK/hnolZlv3Tp58QRfO5aiTr
	 L4U/AkTT02uJsL2ylGFX5v9GFFhn9YFU6nlPalTNChKgs/JbrV9o8oNGY04KeE8XKO
	 yh2BALF4Dx3P2rFsbuLWWEbU9GN5AKsPw21rScLwQd+NX7JyqEuf8pG91U77vCsr6W
	 YeQLHJx0qt2/q9uM2VKIBNsyoE4VRubAcm8CdeBPJcoGqEg/2q2+aCH1Qdg/SaGcY4
	 pxxlw5BU9jrPg==
Message-ID: <f148128d-7921-4836-b9d4-72788293215b@kernel.org>
Date: Thu, 19 Nov 2026 11:15:51 +0100
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Subject: Re: [PATCH] iio: gyro: adxrs290: propagate chip ID read errors
To: Siqi Chen <chensiqi@uniontech.com>, nish.malpani25@gmail.com,
 jic23@kernel.org
Cc: nuno.sa@analog.com, Michael.Hennerich@analog.com, dlechner@baylibre.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux@analog.com,
 linux-kernel@vger.kernel.org
References: <20261119030709.3792433-1-chensiqi@uniontech.com>
Content-Language: en-US
From: Joshua Crofts <crofts@kernel.org>
In-Reply-To: <20261119030709.3792433-1-chensiqi@uniontech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19-Nov-26 4:07, Siqi Chen wrote:
> spi_w8r8() returns either an unsigned 8-bit value or a negative error.
> The probe function stores its return value in a u8, truncating errors and
> treating them as unexpected chip IDs. Consequently, an SPI transfer failure
> is reported as -ENODEV instead of the actual error.
> 
> Store each result in an int and return negative errors before validating
> the chip IDs.
> 
> OpenCode was used to identify the issue and draft the code and changelog.
> 
> Compile-tested with CONFIG_ADXRS290=m using:
> 
>   make O=/tmp/opencode/linux-build-adxrs290 W=1 \
>        drivers/iio/gyro/adxrs290.o
> 
> No hardware or SPI fault-injection testing was performed.

Remove the testing info from the commit message and put it under the ---.
Unless you tested the patch on specific hardware then no need to immortalize
it in the git log.

Side note: one would expect that patches sent to the mailing list are at
least compile tested :)

> 
> Fixes: 2c8920fff145 ("iio: gyro: Add driver support for ADXRS290")
> Signed-off-by: Siqi Chen <chensiqi@uniontech.com>
> ---
>  drivers/iio/gyro/adxrs290.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/gyro/adxrs290.c b/drivers/iio/gyro/adxrs290.c
> index b61cc81122a6..eb3306215217 100644
> --- a/drivers/iio/gyro/adxrs290.c
> +++ b/drivers/iio/gyro/adxrs290.c
> @@ -604,7 +604,7 @@ static int adxrs290_probe(struct spi_device *spi)
>  	struct iio_dev *indio_dev;
>  	struct adxrs290_state *st;
>  	u8 val, val2;
> -	int ret;
> +	int id, ret;

Why a new variable? ret should be sufficient in this case.

>  
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
>  	if (!indio_dev)
> @@ -622,21 +622,27 @@ static int adxrs290_probe(struct spi_device *spi)
>  
>  	mutex_init(&st->lock);
>  
> -	val = spi_w8r8(spi, ADXRS290_READ_REG(ADXRS290_REG_ADI_ID));
> -	if (val != ADXRS290_ADI_ID) {
> -		dev_err(&spi->dev, "Wrong ADI ID 0x%02x\n", val);
> +	id = spi_w8r8(spi, ADXRS290_READ_REG(ADXRS290_REG_ADI_ID));
> +	if (id < 0)
> +		return dev_err_probe(&spi->dev, id, "failed to read ADI ID\n");
> +	if (id != ADXRS290_ADI_ID) {
> +		dev_err(&spi->dev, "Wrong ADI ID 0x%02x\n", id);
>  		return -ENODEV;

Not sure how this device works, but better to just call dev_info() to
ensure that any potential compatible fallback can be matched.

Also, why not just use dev_err_probe() if the previous if check uses
it? Style unification is a good idea.

-- 
Kind regards,
Joshua Crofts

