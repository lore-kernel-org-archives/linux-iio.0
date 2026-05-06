Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DFC40DFC9;
	Wed,  6 May 2026 16:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778084358; cv=none; b=Ouzls9vrUW96Fi+R9bOKaAsMUC8tBHiRThJ594qGuUU7r8tesX8Ve6lLh00iBLS1kbZxKyKKIV4LzyxbBVbb+h7dhXqpEhCalr1qOkjULC44HlYr5JT4sc6tHp/2kk2oERt0fGMmrjicm0MfzneM4NfrI21BSA+l5ymMoV/v/+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778084358; c=relaxed/simple;
	bh=YLzbTdBBZESgPrz2MARNuyLiuGStZPGVrVj7DcDUBpc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nWMKLGo0q/y8tORiLsK+GjOpncHbHK6j0gmRy1eIuxDrVO/7zUzqlqz56ErGpWRjGAYEdR4468ScgZBuAYwStKKhGnTSiSXPwiuEI0TxbUnqtF+ymdtSH1nYFBZcsv3itCSfM9g8AScVngpCtcPFKf01KvBi8TzH40hT/ZY3dJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdniE/JV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdniE/JV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43AC5C2BCC7;
	Wed,  6 May 2026 16:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778084357;
	bh=YLzbTdBBZESgPrz2MARNuyLiuGStZPGVrVj7DcDUBpc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mdniE/JVgrdey1K2Az7HvfN0YfPK6Xf45lwkDjSlaV2zg796NGWwf0ZsJkjecnCsD
	 SKJB092k/YabvPH4ux6ABJ8yIFkb8WYhoqaaCB1enX96WJYNzDDgWtciz97tZ5by0L
	 xp6FuV1brsmMxFn9WJAP2PnXvrJdT8qAbpB3qB++TfnZFt+A+KNwXCJh6AGsQuq8Af
	 eAOUBJffOak5uuxGAjlXS9OxOsqZr7ApvOWOmQ7/ywWclJd5TB81b656Cxu67LYiSv
	 TBK+YJEd5I0lc7W5ZGiSJwEnM9hceQHetB1Xji4hNS7Uoindz5TpbdWJ94iYXMkhqg
	 hWpzAAOHAWNLQ==
Date: Wed, 6 May 2026 17:19:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Salah Triki <salah.triki@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] iio: humidity: ens210: Fix missing I2C functionality
 checks
Message-ID: <20260506171910.533a3e74@jic23-huawei>
In-Reply-To: <20260506095835.10112-1-salah.triki@gmail.com>
References: <20260506095835.10112-1-salah.triki@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  6 May 2026 10:58:35 +0100
Salah Triki <salah.triki@gmail.com> wrote:

> The ENS210 driver uses SMBus transactions (such as byte, word, and block
> data reads/writes) during the probe and measurement phases. However, the
> initial functionality check only validated a subset of these capabilities,
> which could lead to loading failures on adapters requiring SMBus
> emulation or native-only controllers.
> 
> To ensure compatibility across a wide range of I2C adapters, modify the
> functionality check to verify if the adapter supports the required native
> operations or, failing that, supports the SMBus emulation layer.
> 
> Fixes: c524fbca672e ("iio: humidity: Add support for ENS210")
Are there any known i2c adapters that this actually applies to?
Feels to me like hardening against unexpected results rather than a
real fix.  So probably drop the tag.
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> ---
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
>   operations and SMBus emulation (`I2C_FUNC_SMBUS_EMUL`) to prevent
>   loading issues on controllers lacking the emulation flag.
That one is spurious. See below. A device on a bus doesn't care
how these bus operations are occurring so should never be messing
with that define.

> 
>  drivers/iio/humidity/ens210.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/humidity/ens210.c b/drivers/iio/humidity/ens210.c
> index 77418d97f30d..159a3c158c9f 100644
> --- a/drivers/iio/humidity/ens210.c
> +++ b/drivers/iio/humidity/ens210.c
> @@ -204,7 +204,10 @@ static int ens210_probe(struct i2c_client *client)
>  	if (!i2c_check_functionality(client->adapter,
>  				     I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
>  				     I2C_FUNC_SMBUS_WRITE_BYTE |
> -				     I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
> +				     I2C_FUNC_SMBUS_READ_BYTE_DATA |
> +				     I2C_FUNC_SMBUS_READ_WORD_DATA |
> +				     I2C_FUNC_SMBUS_READ_I2C_BLOCK) &&
Look at definitions of:
I2C_FUNC_SMBUS_BYTE_DATA and I2C_FUNC_SMUS_WORD_DATA

As you might imagine it's common to want the pairs or read and write
so there are macros for it.


> +	    !i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_EMUL)) {
I don't follow the point in this check. See how I2C_FUNC_SMBUS_EMUL is defined
#define I2C_FUNC_SMBUS_EMUL		(I2C_FUNC_SMBUS_QUICK | \
					 I2C_FUNC_SMBUS_BYTE | \
					 I2C_FUNC_SMBUS_BYTE_DATA | \
					 I2C_FUNC_SMBUS_WORD_DATA | \
					 I2C_FUNC_SMBUS_PROC_CALL | \
					 I2C_FUNC_SMBUS_WRITE_BLOCK_DATA | \
					 I2C_FUNC_SMBUS_I2C_BLOCK | \
					 I2C_FUNC_SMBUS_PEC)


So if that passes the earlier one already passed as it's a subset.


>  		return dev_err_probe(&client->dev, -EOPNOTSUPP,
>  			"adapter does not support some i2c transactions\n");
>  	}

