Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA773347C7;
	Sun, 14 Jun 2026 16:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781453939; cv=none; b=M6/sjVUGTKwMWhaJYheaa/Vzs/OMbghUoJ6ldlkzhhuorEIIkZBi6+DG0Hgvvj1IQLgKAV0RYO3/PTDkaPyeTCWujfGETZaq4EPvtpTp8Gyw53lWN+tCNCQUggDNiuxHuYVGlDrarsxbV+rH3wcdIuQ4/4lBKbtOPea+F8o6Dpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781453939; c=relaxed/simple;
	bh=mI7F3W7MliVWanCmWsYVmhPFHg5H/GouZ7S8l49FMiY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D49kzbV78JrOickXM7WtrfwRNgzssDAR1xH+WLJEwLxfhmKbANE1JrNkJK9jF+VuNAH6mQ6FiD37ZBSwFYqff+oWVItXaDwvyfgzq7X6OIFptHeiMBJ0pjGHR+a2kY9P9/JhVXZIv2przta9qpIqwqwd8ucQeUxnbzkt0pE0jSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHEPG9D7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHEPG9D7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F0221F000E9;
	Sun, 14 Jun 2026 16:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781453938;
	bh=vfiPIMniAWdC1PsQ0hJ1yVaU8+9W++L3dc25YiOQvD0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LHEPG9D7UVhPmjlJTEDFlmtaX9mhck4/8f++HRh2fIcs01XtbDN9WM88B2KiWeV2G
	 RRy9ienGZS9G8G+5Lw7cBg1D3WIl8ljtp98iFVCn0n/NtJCF5P30pXAqdlCUIlyFqn
	 tzUyWf95LG3cFgZvrFeAlDi7owpawi/hwbx+1J8D4RUd9T1SwNJqUwW3iHX3HziCK9
	 FY3RhToTmtdgFclKDqwjHZ/Rafd2VDQt4O3CGj2+taHZvTvcW+icMFoAhs0UqEtRhe
	 PZ0ZJzURPF+EDFSrmtd66uja+zfC2RA4By4bHIH2G5+CiZ4TS0rZbmeGhLszigZb5U
	 iB6XT0QUJ1WWw==
Date: Sun, 14 Jun 2026 17:18:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, jean-baptiste.maneyrol@tdk.com,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 andriy.shevchenko@intel.com, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V12 3/9] iio: imu: inv_icm42607: Add inv_icm42607 Core
 Driver
Message-ID: <20260614171847.3c412ca3@jic23-huawei>
In-Reply-To: <20260611202607.85376-4-macroalpha82@gmail.com>
References: <20260611202607.85376-1-macroalpha82@gmail.com>
	<20260611202607.85376-4-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jun 2026 15:26:00 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add the core component of a new inv_icm42607 driver. This includes
> a few setup functions and the full register definition in the
> header file, as well as the bits necessary to compile and probe the
> device when used on an i2c bus.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Hi Chris,

Given this is nearly ready to merge I took a look at Sashiko and
seems it has found a few more things.

Other than those, looks good to me.

Jonathan

> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> new file mode 100644
> index 000000000000..c85d3b74166f
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h

> +#define INV_ICM42607_REG_INTF_CONFIG0			0x35
> +#define INV_ICM42607_INTF_CONFIG0_FIFO_COUNT_FORMAT	BIT(6)
> +#define INV_ICM42607_INTF_CONFIG0_FIFO_COUNT_ENDIAN	BIT(5)
> +#define INV_ICM42607_INTF_CONFIG0_SENSOR_DATA_ENDIAN	BIT(4)
> +#define INV_ICM42607_INTF_CONFIG0_UI_SIFS_CFG_MASK	GENMASK(1, 0)
> +#define INV_ICM42607_INTF_CONFIG0_UI_SIFS_CFG_SPI_DIS	\
> +	FIELD_PREP(INV_ICM42607_INTF_CONFIG0_UI_SIFS_CFG_MASK, 2)
Define this as simply 2.

> +#define INV_ICM42607_INTF_CONFIG0_UI_SIFS_CFG_I2C_DIS	\
> +	FIELD_PREP(INV_ICM42607_INTF_CONFIG0_UI_SIFS_CFG_MASK, 3)
and 3
not the FIELD_PREPified version

Sashiko correctly called out that it is field_prepped again at
the callsite.  As the mask includes lowest bit this is will 'work'
but definitely isn't what you intended!


> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> new file mode 100644
> index 000000000000..5d40f1ee53d6
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c

> +static bool inv_icm42607_is_readable_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case INV_ICM42607_REG_MCLK_RDY ... INV_ICM42607_REG_INT_CONFIG:
> +	case INV_ICM42607_REG_TEMP_DATA1 ... INV_ICM42607_REG_TMST_FSYNCL:
> +	case INV_ICM42607_REG_APEX_DATA4 ... INV_ICM42607_REG_INTF_CONFIG1:
> +	case INV_ICM42607_REG_INT_STATUS_DRDY ... INV_ICM42607_REG_FIFO_DATA:
Sashiko pointed out that the WOM_ registers, 4b to 4d are in the defines, but
not readable or writeable which seems like an omission.

So far only matters for debug, but perhaps better to add them from the start.

> +	case INV_ICM42607_REG_WHOAMI:
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static bool inv_icm42607_is_writeable_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case INV_ICM42607_REG_DEVICE_CONFIG ... INV_ICM42607_REG_INT_CONFIG:
> +	case INV_ICM42607_REG_PWR_MGMT0 ... INV_ICM42607_REG_INT_SOURCE4:
> +	case INV_ICM42607_REG_INTF_CONFIG0 ... INV_ICM42607_REG_INTF_CONFIG1:
> +		return true;
> +	}
> +
> +	return false;
> +}
