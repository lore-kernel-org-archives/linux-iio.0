Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9668A1F09AD;
	Thu,  7 May 2026 16:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778171955; cv=none; b=t2rBKXCshRBcJUmKqbPoKe0V9dF8XcaNH7b6v/AQuMpnEPrM92/fa4uo8LTEL21SkWtCtrxwCHEvIg5Zpm5v8w6FdEAU+oRSFiD9JcG6weaJixovGwBI5lAhwo6TDxFozZJEPv+D0qK5oSwVW/iIKBHz1JzUXv1Apza8Gt02KAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778171955; c=relaxed/simple;
	bh=IGYwgKCEnKjosX8LdPAuV5GDyOacl4O+EZdNZbZeh1A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bDpgzTwTiRAmIazTIrhMmZovVOKy9d4dStfgRph82LIbn9fitGZvH7IxRtlCMUyVHP02dO8acDCnilgjIUtZwjy/0gjhJq6/BSQ0CU/MPeO6n4qk0JzwC1nylFnby/IZx0kQeuZkqHi/XlzYw8ju2sQ8yniiuDqur56qQL2QpK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSLcLIPW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSLcLIPW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9506AC2BCB2;
	Thu,  7 May 2026 16:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778171955;
	bh=IGYwgKCEnKjosX8LdPAuV5GDyOacl4O+EZdNZbZeh1A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BSLcLIPW8aNagEHOd8nCTBE85lg97kCBAWdP3y1cU2XtQy+au/voqKsvOPqB6A0xH
	 wOV1x1IeHWGdEiT+Rj3ko3qfgwS0hIpiqtX6fujzEAGodshW+74Sgu3/lAze40gfTJ
	 b2iu3KNQyvl6ne5XZoYjANdfGFe8JRG33tltfIXSbzcHGY0RSDbI9JlpyeNegsk3nd
	 s3f3W5I+GLoEL/JdkanzsN6RkU42maVRNLLHyDsGvJ5qH/IB5PKAArRE2W4j05q0ZT
	 30fD9KHaoC7oIhcnFl/rr2CMDF4nEsEbppbIxbocuIMLCXVU6L7MDRpCCANPxHzXCZ
	 q96/LFuqhI/RA==
Date: Thu, 7 May 2026 17:39:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Salah Triki <salah.triki@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] iio: humidity: ens210: Simplify I2C functionality
 check
Message-ID: <20260507173907.236460de@jic23-huawei>
In-Reply-To: <20260507092133.8810-1-salah.triki@gmail.com>
References: <20260507092133.8810-1-salah.triki@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  7 May 2026 10:21:33 +0100
Salah Triki <salah.triki@gmail.com> wrote:

> Simplify the I2C functionality check by checking for I2C_FUNC_SMBUS_EMUL,
> which encompasses the SMBus operations required by the driver.
> 
> Signed-off-by: Salah Triki <salah.triki@gmail.com>

No.  Please reread my comments on the previous. No I2C client
driver should ever use I2C_FUNC_SMBUS_EMUL.  If you are unsure
what I am referring to then ask on that thread.

Jonathan


> ---
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
>  drivers/iio/humidity/ens210.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/humidity/ens210.c b/drivers/iio/humidity/ens210.c
> index 77418d97f30d..91c2f69fb6bf 100644
> --- a/drivers/iio/humidity/ens210.c
> +++ b/drivers/iio/humidity/ens210.c
> @@ -201,10 +201,7 @@ static int ens210_probe(struct i2c_client *client)
>  	uint16_t part_id;
>  	int ret;
>  
> -	if (!i2c_check_functionality(client->adapter,
> -				     I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
> -				     I2C_FUNC_SMBUS_WRITE_BYTE |
> -				     I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_EMUL)) {
>  		return dev_err_probe(&client->dev, -EOPNOTSUPP,
>  			"adapter does not support some i2c transactions\n");
>  	}

