Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143CD405C4D;
	Sat, 16 May 2026 16:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778949117; cv=none; b=mj97pITmiGrFuLQ0KI4G6+RnuzjViDMTWgXWExMSsQtHbFs6ddx04y1eH5qNu3UPrJr4Puqyspuuvke/7/euOksMlY/Np0znvDsI4BB2g3yg/VYBJ0iXLCisHcBWsq0DNEKpcC3t2BUG8TU+slKzVkDokl8wPJIHd5pas039gk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778949117; c=relaxed/simple;
	bh=j4vqzbY3WAULsQzWfPtZ8wMb5grWKbU4OvFgi8nAiRo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ttjmMuVmhnAbmIIV2FAqigiTsir2V+EokQkTqkoBkw+9E+oFSF/ckJDdO6WGQJEN1MwB7OGfoDi1U50NtYbvvvAlAD0dDKRT7h1Y7O4IISADIWjGegc2zen/NMud9+ukz6pO2w5rLBUwzqaU9mJU44exwiX+sAE7KprbOwDvV0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWRbqlbL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWRbqlbL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8766C19425;
	Sat, 16 May 2026 16:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778949116;
	bh=j4vqzbY3WAULsQzWfPtZ8wMb5grWKbU4OvFgi8nAiRo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fWRbqlbL1BPIrCFSG8oZzeegMlr6qCokpuAJ+DBEv1O6DBqD3zy3Lu5f1NXj7E8dQ
	 X4oP6t9izcTQbsCb46fwLJCY4O0FG4TweOzlyrKo/klvC0cZi2bC/U3pj3FNLCK8HW
	 UYS2p+FGvPKyouUKJ3lsytkkqZvcdF4QGEJ11jpFzgBYrdZlqwYlEQsZD4CuLpblf8
	 ttX9FtKxr7EEyOjPxAEJTyNNsfwT+a3P9HE6qFfR2Wr/gLOVRNIzfv2/+8KhHZBs3a
	 77JFcAxH3+QDtquEDLvVyJIbUl9df7WerWIfdo+zqItBIVUl96huUT69ApNvSTPajL
	 O3OezqMU/hozA==
Date: Sat, 16 May 2026 17:31:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Salah Triki <salah.triki@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] iio: humidity: ens210: Extend I2C functionality
 check
Message-ID: <20260516173148.3209f7fe@jic23-huawei>
In-Reply-To: <20260514084154.298154-1-salah.triki@gmail.com>
References: <20260514084154.298154-1-salah.triki@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 May 2026 09:41:54 +0100
Salah Triki <salah.triki@gmail.com> wrote:

> The ENS210 driver requires several specific SMBus protocols to operate:
> - WRITE_BYTE for sending commands.
> - BYTE_DATA and WORD_DATA for register access.
> - I2C_BLOCK_DATA for reading humidity/temperature results.
> 
> Update the probe function to explicitly check for these required
> functionalities using standard macros. This ensures the driver only
> binds to adapters that support the necessary transaction types.
> 
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> ---
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
>  drivers/iio/humidity/ens210.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/humidity/ens210.c b/drivers/iio/humidity/ens210.c
> index 77418d97f30d..d209f30d61ed 100644
> --- a/drivers/iio/humidity/ens210.c
> +++ b/drivers/iio/humidity/ens210.c
> @@ -204,6 +204,8 @@ static int ens210_probe(struct i2c_client *client)
>  	if (!i2c_check_functionality(client->adapter,
>  				     I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
Sashiko pointed this out... Take a look at definition of I2C_FUNC_SMBUS_BYTE_DATA
and consider if the line above makes sense.  Check for other instances of
this.
>  				     I2C_FUNC_SMBUS_WRITE_BYTE |
> +				     I2C_FUNC_SMBUS_BYTE_DATA |
> +				     I2C_FUNC_SMBUS_WORD_DATA |
Sashiko suggests this one is tighter than needed.  Might be right - I didn't check!
https://sashiko.dev/#/patchset/20260514084154.298154-1-salah.triki%40gmail.com
>  				     I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
>  		return dev_err_probe(&client->dev, -EOPNOTSUPP,
>  			"adapter does not support some i2c transactions\n");

