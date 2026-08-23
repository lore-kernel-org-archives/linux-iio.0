Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B972C87F;
	Sun, 23 Aug 2026 00:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787445255; cv=none; b=jeYV5vZhSHhzh1YtjGi9neRluKeM1Un4hqB00z+PzC3inDU/YI37bde/oN/8TppEvaoHaP0vSN2kgxpsHMTto8d5xJl/L2sWa7OVWqibBlCAhNGWaPBmi/YJHviC5eTojhAzX8CFIRL+R2XY9W8a5szpVuPgtQBAOvAxX3662LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787445255; c=relaxed/simple;
	bh=gFUze5uEBAm5fqdDHUH0IEpjLrxNBcmKb2TbdCD/+0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iX/fL2ZDS5IfTD/ojplG+j17iRtr1s8VLPWHqbhqeX+zjYRq0NLQYaL8InjKxDYhT+2/VtmxXvohGvRjK99V3DcnwR89uz8uCqAi4Slles9244lELaoMn7IhQXNYOLU6ru+shwTOsD3u+mWXbzj8wHrhtMuXT9ynQz4akpNs13o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCs+jXyg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCs+jXyg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB541F000E9;
	Sun, 23 Aug 2026 00:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787445253;
	bh=n2QZUG/r1xFIH/LaGrIcVEmh0wRvQYu6opE8GrFRIac=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XCs+jXygFR6RPlIUg6HjH9nisyDFbINwYGP3JlQJ2yvTkMARlY0237Oplj4hz+FDx
	 4ukGtOggCTpQENaZoUCnR+CUzKJWp3eADRpQsYuSiZdaH+CthoCc+r5Us8JJB8YQ/h
	 S99AnWKvWbKu+7aM4mNtYAQMRSnYFGSdqCm0hy2dwxxwwDgM9UH8izjxQdWm2JYUjz
	 CiFjV4PqJePiHcSSDRiz6d7jkYVT2YO+yXQCt092Aox4d29FcpiIpvWNSZECt+s8XT
	 jXaQSRNF52iPBqSwxHBik4VZQq+dSBLdX61fX+qO7VauQlCGQKSPsq4EpcQEsrjSH5
	 9ZIrlmMZUZX1g==
Date: Sun, 23 Aug 2026 01:34:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Salah Triki <salah.triki@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Stepan Ionichev
 <sozdayvek@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8] iio: humidity: ens210: Extend I2C functionality
 check
Message-ID: <20260823013407.434a2247@jic23-huawei>
In-Reply-To: <20260819103110.25718-1-salah.triki@gmail.com>
References: <20260819103110.25718-1-salah.triki@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Aug 2026 11:31:09 +0100
Salah Triki <salah.triki@gmail.com> wrote:

> The ENS210 driver uses byte data read/write, word data read, and block
> data read transactions. However, the probe function checks for
> I2C_FUNC_SMBUS_WRITE_BYTE (which is unused) and misses the check for word
> data reads.
> 
> Update the functionality check to strictly match the transactions used by
> the driver by removing the unused flag and adding the missing byte and word
> read capabilities.
> 
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
I am a bit curious about whether any modern smbus capable controllers actually
support only a subset and without that info I don't want to see lots
of patches adding these checks

In this case there was a wrong check though so I'm very happy to see
that tidied!

Applied to the testing branch of iio.git

Thanks

Jonathan

> ---
> Changes since v7:
> - Fixed functionality mask based on code analysis by Stepan Ionichev and
>   Jonathan Cameron:
>   - Removed unused I2C_FUNC_SMBUS_WRITE_BYTE.
>   - Replaced I2C_FUNC_SMBUS_WRITE_BYTE_DATA with I2C_FUNC_SMBUS_BYTE_DATA.
>   - Used I2C_FUNC_SMBUS_READ_WORD_DATA
> 
> Changes since v6:
> - Replaced the incorrect use of I2C_FUNC_SMBUS_EMUL with an explicit
>   list of required SMBus functionalities as requested by Jonathan Cameron.
> - Used combined macros (BYTE_DATA, WORD_DATA) to simplify the check.
> 
> Changes since v5:
> - Changed patch title from "Fix missing I2C functionality checks" to
>   "Simplify I2C functionality check" to reflect the new approach.
> - Dropped the Fixes tag as the change is now considered hardening rather
>   than a bug fix.
> - Replaced individual functionality checks with a single check for
>   I2C_FUNC_SMBUS_EMUL as suggested by Jonathan Cameron.
> 
> Changes since v4:
> - Fixed the alignment and indentation of the I2C functionality check
>   per Andy's review.
> 
> Changes since v3:
> - Fixed the alignment and indentation of the I2C functionality check
>   per Andy's review.
> 
> Changes since v2:
> - Fixed the alignment and indentation of the I2C functionality check
>   per Maxime's review.
> 
> Changes since v1:
> - Updated the I2C functionality test to check for both required native
>   operations and SMBus emulation (`I2C_FUNC_SMBUS_EMUL`)
> 
>  drivers/iio/humidity/ens210.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/humidity/ens210.c b/drivers/iio/humidity/ens210.c
> index 81276195152b..4bdd37e7227b 100644
> --- a/drivers/iio/humidity/ens210.c
> +++ b/drivers/iio/humidity/ens210.c
> @@ -202,8 +202,8 @@ static int ens210_probe(struct i2c_client *client)
>  	int ret;
>  
>  	if (!i2c_check_functionality(client->adapter,
> -				     I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
> -				     I2C_FUNC_SMBUS_WRITE_BYTE |
> +				     I2C_FUNC_SMBUS_BYTE_DATA |
> +				     I2C_FUNC_SMBUS_READ_WORD_DATA |
>  				     I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
>  		return dev_err_probe(&client->dev, -EOPNOTSUPP,
>  			"adapter does not support some i2c transactions\n");

