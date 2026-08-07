Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAEB277CA5;
	Fri,  7 Aug 2026 23:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786145289; cv=none; b=ouGvtccZf/5idH1WbdqscGBn9ESEovHF2w4Qd28Ubl25rsMXWeN1F+PD/Bj9UYTw0hFM77hJap9eZK936ahmerxShoHzImPJDqrslJJKdqtIst9oY/3RoAPivYFNFBj02r6+JgmPeHlfagWwDA6RkN7EmXL2ITjzsxcuDtOgu78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786145289; c=relaxed/simple;
	bh=KreV5seEJEF7mbQYtzownykfdDBT9TriOXz0qsEmNF8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VDeK8pnlFPLPgqescAL998aquWwf9YbOFJFY4v+hLIqec9hqIfiB5dbx/5UAYaX0sO//wXtdzNqPsctlnc4vsUdxtnGkLvJ222SFGYOYxHikWqXWjHCro1kAJ179OoSgeX41luYGAaeH91HOfh5GdlLLtDjFSW6RaXpmQRMYD6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbWI9qEq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbWI9qEq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8230D1F000E9;
	Fri,  7 Aug 2026 23:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786145287;
	bh=cRICx2/0WpR2orxh8oFGT0+XevOD5ua1/yX37Xwa0wc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dbWI9qEqHgzac6fSui5zQt582QYxemRGq1DByiRJ2r7G0qFk6zpo60D99Kb7rVx0I
	 OqvJI3DY9h7g1nZaSkgm5U83TlwMubX/A2i8ZUS3CpomywGSmyHIjPIq51LDaaw8Wf
	 G32rsDUIf2mO0InHcgwQ50Z6oztnfoApSyveIjqYc3buW3W4ZJkdzs0vhOkd5MWnYs
	 oi7LmHHiul4fcX+lCU92TFfTTHGPX8PpHAveQ5RlJ98QEXrPgCtzp0UpL7tiHBgVtL
	 yrTK/t0c7MVGvuZgk8aV/2p61yhQbhmEPj60hXlZj2RPvmgCgPg18Vfwloito7AsE7
	 RPxiYk5KFN0lw==
Date: Sat, 8 Aug 2026 00:28:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Danil Sirin <danilsirin24@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: accel: mma8452: add ACPI match table
Message-ID: <20260808002802.29416349@jic23-huawei>
In-Reply-To: <20260807171326.1137-1-danilsirin24@gmail.com>
References: <CALoEA-zR7Z75k3uNRD_Swqf7G0+mYmFkPfXTJ5O-mBr6_iu8qA@mail.gmail.com>
	<20260807171326.1137-1-danilsirin24@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Aug 2026 20:13:25 +0300
Danil Sirin <danilsirin24@gmail.com> wrote:

> The mma8452 driver supports obtaining chip-specific data through
> i2c_get_match_data(), but only provides Device Tree and I2C match
> tables.
> 
> On ACPI-based x86 systems, compatible devices such as the MMA8653 are
> enumerated via ACPI, preventing the driver from binding.
> 
> Add an ACPI match table mapping the supported devices to the existing
> chip information structures.
> 
> Tested on a Bay Trail tablet exposing an MMA8653 device via ACPI. With
> this change the driver successfully probes, reads the expected chip ID
> (0x5a), and registers an IIO device.
These unfortunately are not ACPI spec complaint IDs. 
Given it is a 3 letter prefix it is the format of a PNP ID.
So to see who owns that space, need to look here:
https://uefi.org/pnp_id_list

Micromedia AG	MMA	1997-04-24

Which is not who made this part :( or I'd assume the the tablet you have.
They make nice looking audio interfaces it seems: https://www.micromedia.ch/

Fingers crossed they don't have a device with this ID sat on a relevant
bus type.

FWIW the ID should either have been one provided by the accelerometer
manufacturer, or one provided by the integrator (intel ones are fairly
common as they do this stuff right and produce reference designs that get
copied)

Anyhow, with all this in mind we are a bit flexible
on accepting them anyway, but needs to do a few things.

1. Name (and shame) the actual device that is shipping with this ID
   as a comment along side the ID table entry.  This stops us deleting
   it in future.
2. Keep the change tightly scoped, I don't want to see any invalid
   IDs without a comment next to them providing an example device
   that contains that part and uses the relevant wrong ID.
3. If you happen to have a contact with or can dig one out for the
   tablet manufacturers, please forward on the request that they stop
   doing this for future products. It is rare, but we have gotten a
   few firms to switch to doing it right!

> 
> Signed-off-by: Danil Sirin <danilsirin24@gmail.com>
> ---
> v2:
> - Update Signed-off-by tag with real name

Please don't send new versions in reply to old ones. It leads to
very confusing threads after a few versions and generally makes it
less likely anyone will notice the new version.

> 
>  drivers/iio/accel/mma8452.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index cefc7cf4b..8cb78e4cf 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -1822,6 +1822,17 @@ static const struct dev_pm_ops mma8452_pm_ops = {
>  			   mma8452_runtime_resume, NULL)
>  };
> 
> +static const struct acpi_device_id mma8452_acpi_id[] = {
> +	{ "FXLS8471", (kernel_ulong_t)&mma_chip_info_table[fxls8471] },

What fun. That's an ACPI ID - I was briefly hoping a valid one.  But nope
	https://uefi.org/ACPI_ID_List?acpi_search=freescale
gives freescales ID as FRSC so it should have that prefix.

> +	{ "MMA8451", (kernel_ulong_t)&mma_chip_info_table[mma8451] },
> +	{ "MMA8452", (kernel_ulong_t)&mma_chip_info_table[mma8452] },
> +	{ "MMA8453", (kernel_ulong_t)&mma_chip_info_table[mma8453] },
> +	{ "MMA8652", (kernel_ulong_t)&mma_chip_info_table[mma8652] },
> +	{ "MMA8653", (kernel_ulong_t)&mma_chip_info_table[mma8653] },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, mma8452_acpi_id);
> +
>  static const struct i2c_device_id mma8452_id[] = {
>  	{ "fxls8471", (kernel_ulong_t)&mma_chip_info_table[fxls8471] },
>  	{ "mma8451", (kernel_ulong_t)&mma_chip_info_table[mma8451] },
> @@ -1837,6 +1848,7 @@ static struct i2c_driver mma8452_driver = {
>  	.driver = {
>  		.name	= "mma8452",
>  		.of_match_table = mma8452_dt_ids,
> +		.acpi_match_table = mma8452_acpi_id,
>  		.pm	= &mma8452_pm_ops,
>  	},
>  	.probe = mma8452_probe,
> --
> 2.55.0
> 

