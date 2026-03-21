Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9154317D;
	Sat, 21 Mar 2026 17:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774113944; cv=none; b=pi2nK5N/pLTQrYL00AVkD1h7OEi0I7yM+tsrMU/xJ2Z0bQGfgmjyfXYbgfix17ldnVei1GfpPmpNUfy1j6ivy06FIDxYD1BwOjXDthHKE1HH41WxN1s4kaJNHiVz+N9TbkZxHF1dhyBOGFtl67E3GuH4PkFYY05IZzOQIdnB0zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774113944; c=relaxed/simple;
	bh=fwl11kL8Op8XMSdszzWCD76kZNKa2UFglzZhJStW7Ns=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=afGDoCyJVLkJFcK/LJv9Y3PGNuMLYRtNM1TAiHzvTBXrnLV+f8Niraex7yuM3tOT6SnsgoideRncHfAV9xjJfAWWqvc8Wt99fUG9PIX2BuNxRZbUf0OAjErVhuIYUSrIeokSNl/FZr51VDiHop68QReTSPRTE3Z6ykB9nbgkxHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbB+gcBz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbB+gcBz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF62C2BCAF;
	Sat, 21 Mar 2026 17:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774113944;
	bh=fwl11kL8Op8XMSdszzWCD76kZNKa2UFglzZhJStW7Ns=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WbB+gcBz88AqbGHV7m1yNr589Q92lqe2wGWKVU5UUrNfMa3iISrhDQOrkbVhJoQ2T
	 SnDcx1NUsY45DP8JdVW9RPSfarXPjQPQbFgRp9NDUTUMyxQgo8DuO3YJkL8qfbw1Ch
	 VUgEhzRKQYTTwBBGyHrBLUbW2cknO/xy7j85nsp8KAVKaLRp7f1cPESEfViN8sfx4t
	 +cHramp+cChI8wuQxBHVyEkRLFN8n8QA+dnVeY0SfaHufGbkiOmjPrtkzp7/mMng3N
	 bz4A/x4dFwUGAzrAKT6iPN1eS0bq5RGT7auaEELdGaxOTQAfEZbm617Pbhx4jqc5Kk
	 nlD0vVlM8Pv3g==
Date: Sat, 21 Mar 2026 17:25:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, jean-baptiste.maneyrol@tdk.com,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 andriy.shevchenko@intel.com, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V2 3/5] iio: imu: inv_icm42600: Add registers for
 icm42607
Message-ID: <20260321172534.388e71f5@jic23-huawei>
In-Reply-To: <20260319182956.146976-4-macroalpha82@gmail.com>
References: <20260319182956.146976-1-macroalpha82@gmail.com>
	<20260319182956.146976-4-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Mar 2026 13:29:39 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add the register layout for the icm_42607. Most of the registers are
> similar to that of the icm42600, though at different addresses.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Hi Chris,

Just taking a quick look given Jean-Baptiste's concerns
about doing this in the existing driver.

Thanks,

Jonathan

>  
> +/* ICM42607 Specific registers. */
> +
> +/* Virtual register addresses: @bank on MSB (4 upper bits), @address on LSB */
> +
> +/* Register Map for User Bank 0 */
> +#define INV_ICM42607_REG_DEVICE_CONFIG			0x01
> +#define INV_ICM42607_DEVICE_CONFIG_SPI_AP_4WIRE		BIT(2)
> +#define INV_ICM42607_DEVICE_CONFIG_SPI_MODE		BIT(0)
> +
> +#define INV_ICM42607_REG_SIGNAL_PATH_RESET		0x02
> +#define INV_ICM42607_SIGNAL_PATH_RESET_SOFT_RESET	BIT(4)
> +#define INV_ICM42607_SIGNAL_PATH_RESET_FIFO_FLUSH	BIT(2)
> +
> +#define INV_ICM42607_REG_DRIVE_CONFIG1			0x03
> +#define INV_ICM42607_DRIVE_CONFIG1_I3C_DDR_MASK		GENMASK(5, 3)
> +#define INV_ICM42607_DRIVE_CONFIG1_I3C_DDR(_rate)	\
> +FIELD_PREP(INV_ICM42607_DRIVE_CONFIG1_I3C_DDR_MASK, (_rate))

I'd indent the second line of these two line defines to make it easier to
see it's a continuation.

> +#define INV_ICM42607_DRIVE_CONFIG1_I3C_SDR_MASK		GENMASK(2, 0)
> +#define INV_ICM42607_DRIVE_CONFIG1_I3C_SDR(_rate)	\
> +FIELD_PREP(INV_ICM42607_DRIVE_CONFIG1_I3C_SDR_MASK, (_rate))

