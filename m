Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793571760;
	b=CKRPIlEtvAavr8gDywFfMql6tsxPdkFnYhW0fU2UHgOK2NdDLeQnJw40eqmgQrUjyYG6
	 mr45tp/uvT4wSIbkYyHCCKQ6YlZnQrrRtqJy7k61l19dmXptlO9oJm7TtxYT8rQlOE3/b
	 JsuCFXe+KIA/WE+/t55X3dukEPGY97L4JT+1eAD0nf4NHr+R15tKJtflfTkGoEbVryPXq
	 Apj5uTX/RRFjuIh814HLPtksNLd0O0LsEXUhqkjDiUZcbFHAKz1+Xr7BuAq2Q+J4vEVhj
	 ie7ymW2RPb0dVf6LxaD6G1RvXfTY4MYOFZEJ2RRAQEwE5D6rAEmyDGIo9vvJ7h3JupA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793571760;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Mv6Yvyb3o++b8fZoh1Htp11ocQGypTu1H88aSpWkzgo=;
	b=3poGTtd5uteMWuZEZY83hIrIJCI6B9cvW6e4ygumzP2JylC2dv044NeFPJarZXIaNSLr
	 zhqSqohe+bZFIb0d7NY4Kn0QfU2AawlXTCyf2+XfqJ3nadf8whp+txKUuFEbEt48dLi0k
	 eKkyB9fEpTkCRt03QGte8jkDv7LZbAbjvJ2S/RrrtV4jsXyl20RBf75QYTCFQ3znHbQzX
	 YROfAFVEMu1b5LKdsWH6E5RRp+zrCCGJLQxwMgEghpsEvsdVBMsvSY4eiBZXlbSCuCbb9
	 2726D4mHciS7vBidYzieHjXOKIglvISYKXIRfI4zeLwBwzz9FNxqUZ8FQCsbvIU4W/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XZd5foMj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2085360701CA;
	Sun,  1 Nov 2026 22:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XZd5foMj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3FA21F000C1;
	Sun,  1 Nov 2026 22:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793571759;
	bh=Mv6Yvyb3o++b8fZoh1Htp11ocQGypTu1H88aSpWkzgo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XZd5foMjVBkJ/7MBgbpDRFvOnYQEFOC8IJtihhFIxA6k3WX93NwNjINFTdG89cxnF
	 fe8yECbSClebrIt5L7ppeJWR6ZS5Hvo64HainRWXwx9U+bPL0BJMJAy3z258DcW1HB
	 TcFRssJdUzTp4ZVppY5ojfAOu8tVg3ESf/dcXJf7UIqZ1nvnuC7jhqQyE99P7O2Ju0
	 6b+4Fi6yv5GXAtvxMMtVDTG4KpRC8U7ymPcYA1WVinx3oLm1p+vJbgioXu1PhPXSY+
	 9py6dMJBRht3yot0O/Q8u0oki3eGGvUNwUVuZVV/qfOjkyH/tzQV9Mj5fkIbE7eJYg
	 ZDGpa91IzdGXw==
Date: Sun, 1 Nov 2026 22:22:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Kanak Shilledar <kanak.shilledar@axis.com>
Cc: Henrik Grimler <henrik.grimler@axis.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 "Jean-Baptiste Maneyrol" <jean-baptiste.maneyrol@tdk.com>, Joshua Crofts
 <joshua.crofts1@gmail.com>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>, <kernel@axis.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Jonathan Cameron
 <jonathan.cameron@oss.qualcomm.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v7 6/7] iio: imu: inv_icm42607: Implement MREGx register
 access
Message-ID: <20261101222230.2ce697cf@jic23-hlaptop>
In-Reply-To: <20261026-b4-inv_icm42370p-v7-6-222e296ac1e0@axis.com>
References: <20261026-b4-inv_icm42370p-v7-0-222e296ac1e0@axis.com>
	<20261026-b4-inv_icm42370p-v7-6-222e296ac1e0@axis.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 26 Oct 2026 12:02:54 +0100
Kanak Shilledar <kanak.shilledar@axis.com> wrote:

> The device supports indirect register access to different banks. A
> specific routine needs to be followed when accessing the registers in
> another bank as documented in the datasheet (section 13). This is
> required for accessing registers configured via the user and
> implementing buffer support. The implementation is inspired from the
> icm45600 driver.
>=20
> The banks are defined based on their initial bank access code which are
> written to the BLK_SEL_* regs. However, there is a variation for MREG1
> as User Bank 0 and MREG1 both share the same 0x00, so User Bank 1 has
> 0x00 and MREG1 has 0x01. When MREG1 register is accessed, then BLK_SEL_*
> is written with 0x00 instead of 0x01. All the register access goes
> through the 16 bit virtual regmap layered on top of the 8bit bus regmap.
> Bank id in the upper byte and the register address in the lower byte.
> Bank 0 accesses are forwarded to the bus regmap with the bank field
> stripped, while MREG accesses are forwarded to bank switching sequence.
>=20
> Due to the specific bank switching routine, it is not possible to use
> regmap-ranges. Only User Bank 0 supports bulk read/writes whereas other
> banks can only be accessed serially. Each time some data in the other
> bank needs to be accessed, it should go through the complete bank
> switching sequence.
>=20
> Datasheet: https://www.invensense.tdk.com/en-us/products/3-axis/icm-42370=
-p
> Datasheet: https://www.lcsc.com/product-detail/C5129967.html
> Assisted-by: LLM

Drop this assisted by. The rules changes again :(  Now the plan is
just to have the LLM usage bit you have below the --- and
keep nothing in the git log.

> Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
> ---
> LLM was used to implement the mreg back switching support.
> ---
>  drivers/iio/imu/inv_icm42607/inv_icm42607.h      | 166 ++++++++++------
>  drivers/iio/imu/inv_icm42607/inv_icm42607_core.c | 242 +++++++++++++++++=
++++--
>  2 files changed, 329 insertions(+), 79 deletions(-)
>=20
> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/im=
u/inv_icm42607/inv_icm42607.h
> index 674a9896fabb3..eecf4c46cbdb0 100644
> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h


> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/i=
io/imu/inv_icm42607/inv_icm42607_core.c
> index 018a7506ad50c..414642f8ec930 100644
> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c

> -	return false;
> +static int inv_icm42607_mreg_read(struct regmap *map, unsigned int reg,
> +				  u8 *data, size_t count)
> +{
> +	int ret, ret2, ret3;
> +	unsigned int val;
> +	bool idle_set;
> +	u8 blk_sel;
> +
> +	/* MREG access is one byte per transaction, no burst support. */
> +	if (count !=3D 1)
> +		return -EINVAL;
> +
> +	ret =3D inv_icm42607_blk_sel(reg, &blk_sel);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D inv_icm42607_mclk_get(map, &idle_set);
> +	if (ret)
If this fails, why don't we need to undo the blk select?
> +		return ret;
> +
> +	ret =3D regmap_write(map, INV_ICM42607_REG_BLK_SEL_R, blk_sel);
> +	if (ret)
> +		goto out;
> +
> +	ret =3D regmap_write(map, INV_ICM42607_REG_MADDR_R,
> +			   FIELD_GET(INV_ICM42607_REG_ADDR_MASK, reg));
> +	fsleep(INV_ICM42607_MREG_ACCESS_DELAY_US);
> +	if (ret)
> +		goto out;
> +
> +	ret =3D regmap_read(map, INV_ICM42607_REG_M_R, &val);
> +	fsleep(INV_ICM42607_MREG_ACCESS_DELAY_US);
> +	if (ret)
> +		goto out;
> +
> +	*data =3D val;
> +out:
> +	/* Restore direct access. */
> +	ret2 =3D regmap_write(map, INV_ICM42607_REG_BLK_SEL_R, 0);
> +	ret3 =3D inv_icm42607_mclk_put(map, idle_set);
> +
> +	return ret ?: ret2 ?: ret3;
=46rom a readability point of view, this is getting a bit too creative.
I think I'd just separate the good and bad paths and burn a few more
lines to do it.  The lack of balance between get and release also
concerns me.

If we to do blk select then mclk manipulation in the same order for
both, then break it out to helpers where you can easily document why.

static int inv_icm42607_switch_to_mreg()
{
	int ret;

	ret =3D inv_icm42607_blk_sel(reg, &blk_sel);
	if (ret)
		return ret;

	ret =3D inv_icm42607_mclk_get(map, &idle_set);
	if (ret)
		//Can't undo the blk select?   Add comment here.
		return ret;

	return 0;
}

static int inv_icm42607_switch_from_mreg()
{
	int ret;

	/* Restore direct access - Say why ordering */
	ret =3D regmap_write(map, INV_ICM42607_REG_BLK_SEL_R, 0);
	if (ret) {
		inv_icm42607_mclk_put(map, idle_set);
		return ret;
	}
	return inv_icm42607_mclk_put(map, idle_set);
}

Even with this, split the inv_icm42607_mreg_read()
ending into a good path and error path to avoid the ret2 type
dance.



> =20
> +static int inv_icm42607_mreg_write(struct regmap *map, unsigned int reg,
> +				   const u8 *data, size_t count)
> +{
> +	int ret, ret2, ret3;
> +	bool idle_set;
> +	u8 blk_sel;
> +
> +	/* MREG access is one byte per transaction, no burst support. */
> +	if (count !=3D 1)
> +		return -EINVAL;
> +
> +	ret =3D inv_icm42607_blk_sel(reg, &blk_sel);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D inv_icm42607_mclk_get(map, &idle_set);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_write(map, INV_ICM42607_REG_BLK_SEL_W, blk_sel);
> +	if (ret)
> +		goto out;
> +
> +	ret =3D regmap_write(map, INV_ICM42607_REG_MADDR_W,
> +			   FIELD_GET(INV_ICM42607_REG_ADDR_MASK, reg));
> +	if (ret)
> +		goto out;
> +
> +	ret =3D regmap_write(map, INV_ICM42607_REG_M_W, *data);
> +	fsleep(INV_ICM42607_MREG_ACCESS_DELAY_US);
> +
> +out:
> +	/* Restore direct access. */
> +	ret2 =3D regmap_write(map, INV_ICM42607_REG_BLK_SEL_W, 0);
> +	ret3 =3D inv_icm42607_mclk_put(map, idle_set);
> +
> +	return ret ?: ret2 ?: ret3;

As above.

> +}
> +

