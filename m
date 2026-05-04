Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC8812E1E9;
	Mon,  4 May 2026 18:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777918248; cv=none; b=Zvmphbn6pQnQOoAJuWACVVwkyDXqgDuZ4Mfn59fQdPww7U+C1e1CzCEhrY/rTpNLt2gXr39wlDKhLTd/+D2xu8dEIqcMoWhqK4bPhAtBX1GconBXiI7/vEoyvWcWmLHHWDSBCDTh9ZBKZxylGpCvo3D00RLxo5JNLN62h+14PEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777918248; c=relaxed/simple;
	bh=Ot8FniqfDPz5oZ/7H+hutNp2IgDv/CEbdHWn5N6cuvo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MOYS9bTXvgjuU9gWOmo2tKnVcu8BPGaMkTqe77XCD/Fef4XlIcuWaUcdHb6PfNF+LXTi+zbyqFHmis7pWccZosZ36r3KKzVl1iOKSNAvz3ABbNWNiLS6J/UOF+XodffRoAgKxvCNmWNiSNAgJT3x81Ck7J4CiOFBNJb9fmyAUno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObExWsKp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObExWsKp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4CE9C2BCB8;
	Mon,  4 May 2026 18:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777918247;
	bh=Ot8FniqfDPz5oZ/7H+hutNp2IgDv/CEbdHWn5N6cuvo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ObExWsKpI9YiegksedZIU7/TqpjCqPfm4m3syfpyvftpAlhPqT1hyTeo/PB4w51me
	 QloCNc1b/ysYoxj11eBteCK6iF3nTqLj4iJS2hJpmyumkDsC4nmuku2mS3A4tnNu3Z
	 vggpmcCE5o8Jg4PkRwSolDRw8ZCOlwNWKDwH6YVIdPV7aC/O8BtOthxpnjb+aXly4l
	 WqLvPyzZ///bPwgaqTtGWIyO6z7yB5p2F9K8jOC4cmIGkE5ttmtT40iy7evHqF/UAg
	 Jt4NA84gCj/3hAxTIUNRzzATuCJm88O4xgeXyBTIUeSSpXhUkwW0p4BEB1uaBEy+rt
	 dBgWI5U2u9brg==
Date: Mon, 4 May 2026 19:10:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, jean-baptiste.maneyrol@tdk.com,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 andriy.shevchenko@intel.com, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V4 02/10] iio: imu: inv_icm42607: Add inv_icm42607 Core
 Driver
Message-ID: <20260504191037.13b234fe@jic23-huawei>
In-Reply-To: <20260501221152.194251-3-macroalpha82@gmail.com>
References: <20260501221152.194251-1-macroalpha82@gmail.com>
	<20260501221152.194251-3-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  1 May 2026 17:11:41 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add the core component of a new inv_icm42607 driver. This includes
> a few setup functions and the full register definition in the
> header file.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Hi Chris. A few comments inline.
Biggest one is probably to shuffle when you introduce structures and
elements in other structures so they only turn up when they are used
in later patches.  You can do that with enums etc as well. I don't mind
the register defines all in the first patch but the other stuff would
ideally come later.

Thanks

Jonathan

> ---
>  drivers/iio/imu/inv_icm42607/inv_icm42607.h   | 400 ++++++++++++++++++
>  .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 303 +++++++++++++
>  2 files changed, 703 insertions(+)
>  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607.h
>  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> 
> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> new file mode 100644
> index 000000000000..f6b3cad8064a
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h

> +
> +struct inv_icm42607_apex {
> +	unsigned int on;
> +	struct {
> +		u64 value;
> +		bool enable;
> +	} wom;
> +};

These structures that are only used in later patches, should only
be brought in as part of those patches.

> +
> +/**
> + *  struct inv_icm42607_state - driver state variables
> + *  @lock:		lock for serializing multiple registers access.
> + *  @chip:		chip identifier.
> + *  @name:		chip name.
> + *  @map:		regmap pointer.
> + *  @vddio_supply:	I/O voltage regulator for the chip.
> + *  @irq:		chip irq, required to enable/disable and set wakeup
> + *  @orientation:	sensor chip orientation relative to main hardware.
> + *  @conf:		chip sensors configurations.
> + *  @suspended:		suspended sensors configuration.
> + *  @indio_gyro:	gyroscope IIO device.
> + *  @indio_accel:	accelerometer IIO device.
> + *  @timestamp:         interrupt timestamps.
> + *  @apex:		APEX (Advanced Pedometer and Event detection) management
> + *  @buffer:		data transfer buffer aligned for DMA.
> + */
> +struct inv_icm42607_state {
> +	struct mutex lock;
> +	enum inv_icm42607_chip chip;
> +	const char *name;
> +	struct regmap *map;
> +	struct regulator *vddio_supply;
> +	int irq;
> +	struct iio_mount_matrix orientation;
> +	struct inv_icm42607_conf conf;
> +	struct inv_icm42607_suspended suspended;
> +	struct iio_dev *indio_gyro;
> +	struct iio_dev *indio_accel;

Even these should only be added when you add something that uses them.

> +	struct {
> +		s64 gyro;
> +		s64 accel;
> +	} timestamp;
> +	struct inv_icm42607_apex apex;
> +	__be16 buffer[3] __aligned(IIO_DMA_MINALIGN);
> +};

> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> new file mode 100644
> index 000000000000..a0bbd8a7ea4b
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c

> +/**
> + *  inv_icm42607_setup() - check and setup chip
> + *  @st:	driver internal state
> + *  @bus_setup:	callback for setting up bus specific registers
> + *
> + *  Returns 0 on success, a negative error code otherwise.
> + */
> +static int inv_icm42607_setup(struct inv_icm42607_state *st,
> +			      inv_icm42607_bus_setup bus_setup)
> +{
> +	const struct inv_icm42607_hw *hw = &inv_icm42607_hw[st->chip];
> +	const struct device *dev = regmap_get_device(st->map);
> +	unsigned int val;
> +	int ret;
> +
> +	ret = regmap_read(st->map, INV_ICM42607_REG_WHOAMI, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val != hw->whoami)
> +		dev_warn_probe(dev, -ENODEV,
> +			       "invalid whoami %#02x expected %#02x (%s)\n",
> +			       val, hw->whoami, hw->name);
> +
> +	st->name = hw->name;
> +
> +	ret = regmap_write(st->map, INV_ICM42607_REG_SIGNAL_PATH_RESET,
> +			   INV_ICM42607_SIGNAL_PATH_RESET_SOFT_RESET);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read_poll_timeout(st->map, INV_ICM42607_REG_INT_STATUS,
> +				       val, val & INV_ICM42607_INT_STATUS_RESET_DONE,
> +				       INV_ICM42607_RESET_TIME_MS * 100,
> +				       INV_ICM42607_RESET_TIME_MS * 1000);
> +

No blank line here. Keep the error check tightly coupled with the source
of errors.

> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "reset error, reset done bit not set\n");
> +
> +	ret = bus_setup(st);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_set_bits(st->map, INV_ICM42607_REG_INTF_CONFIG0,
> +			      INV_ICM42607_INTF_CONFIG0_SENSOR_DATA_ENDIAN);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(st->map, INV_ICM42607_REG_INTF_CONFIG1,
> +				 INV_ICM42607_INTF_CONFIG1_CLKSEL_MASK,
> +				 INV_ICM42607_INTF_CONFIG1_CLKSEL_PLL);
> +	if (ret)
> +		return ret;
> +
> +	return inv_icm42607_set_conf(st, hw->conf);
> +}

> +
> +int inv_icm42607_core_probe(struct regmap *regmap, int chip,
> +			    inv_icm42607_bus_setup bus_setup)
> +{
> +	struct device *dev = regmap_get_device(regmap);
> +	struct fwnode_handle *fwnode = dev_fwnode(dev);
> +	struct inv_icm42607_state *st;
> +	int irq;
> +	bool open_drain;
> +	int ret;
> +
> +	/*
> +	 * Keep bounds checking in case more chips are added, for now only
> +	 * 2 are supported.
> +	 */
> +	if (chip < INV_CHIP_INVALID || chip >= INV_CHIP_NB)

Is INV_CHIP_INVALID valid in any sense?  If it is add a comment to the enum.
If it's not <= INV_CHIP_INVALID though I would be tempted to just make chip
unsigned and not worry about the bottom - if anyone passes a negative wrap
around will make it fail the other check.  I'm not immediately spotting any
way we can end up with an invalid chip id.


> +		dev_warn_probe(dev, -ENODEV, "Invalid chip = %d\n", chip);

We allow for fallback compatibles and hence WHOAMI reg mismatches but not for
bugs and I can't see how this is any thing other than a bug? If it's for
legacy probe paths we still want to know what it is.

> +
