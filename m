Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795315504;
	b=fGPmhkat0rQBnDnJvhS8Ye+2/HR3BWINQWm+qOFPfYruT/CzIFevNPujqBJnkUSGyh4D
	 kbHHd+eTF4OFGtjft68WXdc02eAvemk3vl4VnfkCKHNlfGZR4ZhQoaiWKkI/Q0qXEbsoM
	 rtJoTq7xF+K0WfWRqhmjPW6gXcPEsh0Hef3Jt6Y/iMFrhMGbM2IAwbG6e/kgsby/cZYOA
	 kLpU63+rRLhdE9X/dQjOrt5DHQTMAnJuX63ycFG33JX5C6L+tkrcEFUKF1A2ZjsflP3q2
	 G5ImuelLyTlkW7GiB7ZKcgmJrVdJsV/6KONXCtXmN5WyEoJcF64qJAFlUBQpWQac7HA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795315504;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=V3IcCafJlwMIKHv8Mvh6bASz8NC02lgNv+jr/2z8S5c=;
	b=nTPMqCkPFMFkYZDtnr7cI/bYLJ50xv5uKNbWlmH8jNiLa1WMZqSNbjYhLvnsUmz2ENpK
	 dmUPycTpRUjYYgPRUxAj/31Yr3iQl2RmxWaqyWtpDaxNl3p/9CgQNpof2mZTpYHCG16/Y
	 UFz2pGYYEMVvK+7kSFkvydqOvFxZtLtnT6VuA+OKufm5p6tKn5Kk+LdKn7gBUBIcU/NWa
	 VsWEnWz/mg9+JQzGxUdRfqs2U18oHpe67BIaenpGfKgp7Cre7pTsME0aiS4r5xgFzof2l
	 sMa/vpJbzdTgZ+MgaaJN+sJhb4r2kuVY0DvLZODyE5rXqfKWb8mrI8WMxCC4qRNng4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iJgh+biW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8388606A320;
	Sun, 22 Nov 2026 02:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iJgh+biW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 181691F000C6;
	Sun, 22 Nov 2026 02:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795315504;
	bh=V3IcCafJlwMIKHv8Mvh6bASz8NC02lgNv+jr/2z8S5c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iJgh+biWRllbQOWKHL0gpfmUwtVnT7UowOMlCGOnCt5VxreWR1QUk/K5zwdS2VGpS
	 LcuRiKUaprG1bHi94LKYggjwAuA9hoUk3AX+jl2q3d8Pw3Xu+qzH3ReEjvS6LIp44g
	 nkLZQf8f1LaC0v4at7UpFxPo+79D3tpU+XiSlfrkgrtQhltshWNG/ykLeFnAcVGCeY
	 T7I1Kvpkx5uZuquYP8xD8rUR/fWnDe4bLCOiZuckNPhIrs1PMM69LdlF1/zg0E13a3
	 SOuqAxxq5eJEVKZIa+4ppPvRvqNM2sAfX2K3vUNTqbuKtBN/x9+Dx5l9aNSFA3EnWq
	 tjjF/xUeJnAeA==
Date: Sun, 22 Nov 2026 02:44:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Adil =?UTF-8?B?SMO8c3Jldg==?= Tepe <tadilhusrev@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: proximity: add Imagis ISG5320A SAR sensor
 driver
Message-ID: <20261122024459.2c30cf99@jic23-hlaptop>
In-Reply-To: <20261117173333.1853986-3-tadilhusrev@gmail.com>
References: <20261116074013.355363-1-tadilhusrev@gmail.com>
	<20261117173333.1853986-1-tadilhusrev@gmail.com>
	<20261117173333.1853986-3-tadilhusrev@gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 17 Nov 2026 20:33:33 +0300
Adil H=C3=BCsrev Tepe <tadilhusrev@gmail.com> wrote:

> Add an IIO driver for the Imagis ISG5320A capacitive SAR/grip sensor
> (I2C), as fitted on the Samsung Galaxy XCover5. It exposes one
> IIO_PROXIMITY channel (the B-channel signal minus its baseline) and a
> rising/falling threshold proximity event.
>=20
> Tested on a Samsung Galaxy XCover5 (re-confirmed 2026-11-17, kernel
> 7.4.0-rc1-00023-gdcb8b91fb779+ #30): the driver binds, registers as
> iio:device4 "isg5320a", and in_proximity0_raw tracked a live
> hand-proximity test (baseline ~0, swinging to -12817/9748/10759 as a
> hand approached/withdrew the sensor).
>=20
> Signed-off-by: Adil H=C3=BCsrev Tepe <tadilhusrev@gmail.com>
Hi Adil,

Welcome to IIO.

Unfortunately this looks a bit too much like an aged vendor driver.
I've called out a few things but Andy's earlier comment about
making sure you read other recent drivers and threads will get you
a long way.

+ as others have mentioned, for a new driver at least 1 week is
appropriate between versions whether or sashiko is making noise.
Feel free to reply to the patches if you disagree with anything
sashiko says, otherwise just fix it for v2.

Various comments inline.

> diff --git a/drivers/iio/proximity/isg5320a.c b/drivers/iio/proximity/isg=
5320a.c
> new file mode 100644
> index 000000000..4df0e09d3
> --- /dev/null
> +++ b/drivers/iio/proximity/isg5320a.c
> @@ -0,0 +1,848 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Imagis ISG5320A capacitive SAR/grip sensor.
> + *
> + * Register map, init table and every write sequence below come from the
> + * Samsung vendor driver (drivers/sensors/isg5320a.c + isg5320a_reg.h,
> + * Galaxy XCover5 5.10 tree, Copyright (C) Imagis Technology). Citations=
 of
> + * the form "vendor :NNN" refer to lines in that isg5320a.c. This driver
> + * writes no register the vendor driver does not write, and only with the
> + * values the vendor writes; regmap enforces that through writeable_reg.

Don't do this referencing to specific places. Just a general reference is
enough.  Current style makes a mess of this driver to gain info most
readers don't need.  If there are non obvious things that are drawn from
the vendor driver then add a comment just for those.

> + *
> + * The chip is used as one proximity channel: the vendor's "diff" value
> + * (CDC16_T - BSL16_B, i.e. the B-channel signal minus its baseline) is
> + * exposed as in_proximity0_raw, and the chip's CLOSE/FAR interrupt is
> + * exposed as IIO threshold events (rising =3D grip, falling =3D release=
).
> + */


> +struct isg5320a_reg_data {
> +	u8 addr;
> +	u8 val;
> +};
> +
> +/*
> + * Vendor setup_reg[] for "XCOVER5 ALL" (isg5320a_reg.h :283-435). The o=
ther
> + * table (:130-282) is under CONFIG_SENSORS_ISG5320A_XCOVER5_KOR, which =
the
> + * stock exynos850-xcover5xx_defconfig leaves unset; it differs only in
> + * 0x9C (threshold low byte), 0xA0 (far hysteresis low byte) and 0xBA.
> + */
> +static const struct isg5320a_reg_data isg5320a_setup_reg[] =3D {
Ah what fun. Might be worth checking if any of these are the reset
defaults and hence we can rely on reset and cut down on what is written.


> +	{ 0x05, 0xFC }, { 0x06, 0xF1 }, { 0x07, 0x13 }, { 0x08, 0x01 },
> +	{ 0x09, 0x80 }, { 0x0A, 0x20 }, { 0x0B, 0x00 }, { 0x0C, 0x00 },
> +	{ 0x12, 0x89 }, { 0x19, 0x8A }, { 0x1B, 0x28 }, { 0x1D, 0x20 },
> +	{ 0x1E, 0x00 }, { 0x1F, 0x18 }, { 0x20, 0x05 }, { 0x21, 0x10 },
> +	{ 0x22, 0x10 }, { 0x23, 0x00 }, { 0x24, 0x00 }, { 0x25, 0x05 },
> +	{ 0x26, 0x05 }, { 0x27, 0x10 }, { 0x28, 0x20 }, { 0x29, 0x00 },
> +	{ 0x2A, 0x20 }, { 0x2B, 0x00 }, { 0x2C, 0x00 }, { 0x2D, 0x20 },
> +	{ 0x2F, 0x18 }, { 0x30, 0xC0 }, { 0x41, 0x11 }, { 0x60, 0xF0 },
> +	{ 0x61, 0x8F }, { 0x62, 0x0C }, { 0x63, 0x00 }, { 0x64, 0x00 },
> +	{ 0x65, 0x44 }, { 0x66, 0x3C }, { 0x67, 0x01 }, { 0x68, 0x00 },
> +	{ 0x69, 0x00 }, { 0x6A, 0x10 }, { 0x6B, 0x00 }, { 0x6C, 0x10 },
> +	{ 0x6D, 0x40 }, { 0x6E, 0x22 }, { 0x6F, 0x00 }, { 0x70, 0x01 },
> +	{ 0x71, 0x60 }, { 0x72, 0xFF }, { 0x73, 0xFF }, { 0x74, 0xFF },
> +	{ 0x7B, 0x08 }, { 0x7C, 0x00 }, { 0x7D, 0x0C }, { 0x7E, 0x00 },
> +	{ 0x7F, 0xF8 }, { 0x80, 0xF8 }, { 0x81, 0x00 }, { 0x82, 0xF0 },
> +	{ 0x83, 0xF0 }, { 0x84, 0xF0 }, { 0x85, 0xF0 }, { 0x86, 0xF0 },
> +	{ 0x87, 0xF0 }, { 0x88, 0x00 }, { 0x89, 0x00 }, { 0x8A, 0x08 },
> +	{ 0x8B, 0x00 }, { 0x8C, 0x02 }, { 0x8D, 0x00 }, { 0x99, 0x21 },
> +	{ 0x9A, 0x3C }, { 0x9B, 0x01 }, { 0x9C, 0x2C }, { 0x9D, 0x00 },
> +	{ 0x9E, 0x00 }, { 0x9F, 0x00 }, { 0xA0, 0x96 }, { 0xA1, 0xC0 },
> +	{ 0xA2, 0x22 }, { 0xA3, 0x00 }, { 0xA4, 0x08 }, { 0xA5, 0x60 },
> +	{ 0xA6, 0xFF }, { 0xA7, 0xFF }, { 0xA8, 0xFF }, { 0xA9, 0x00 },
> +	{ 0xAF, 0x40 }, { 0xB0, 0x00 }, { 0xB1, 0x60 }, { 0xB2, 0x00 },
> +	{ 0xB3, 0xD0 }, { 0xB4, 0x10 }, { 0xB5, 0x28 }, { 0xB6, 0xF0 },
> +	{ 0xB7, 0xF6 }, { 0xB8, 0xFD }, { 0xB9, 0xDE }, { 0xBA, 0xFD },
> +	{ 0xBB, 0xF0 }, { 0xBC, 0x00 }, { 0xBD, 0xFF }, { 0xBE, 0x01 },
> +	{ 0xBF, 0x5E }, { 0xC0, 0x00 }, { 0xC1, 0x69 }, { 0xC2, 0xF0 },
> +	{ 0xC3, 0x00 }, { 0xC4, 0x00 }, { 0xC5, 0x00 }, { 0x13, 0x3A },
> +	{ 0x18, 0xF1 }, /* A ch : CS0, B ch : CS1 */
> +	{ 0x1C, 0x18 }, { 0x35, 0x00 }, { 0x36, 0x00 }, { 0x3A, 0x0A },
> +	{ 0x3B, 0x50 }, { 0x3C, 0x0A }, { 0x3D, 0x50 }, { 0x3E, 0x60 },
> +	{ 0x94, 0x10 }, { 0x95, 0xA9 }, { 0x96, 0x11 }, { 0x2E, 0x14 },
> +	{ 0x0E, 0xE0 }, { 0x0F, 0x1E }, { 0x10, 0xC0 }, { 0x11, 0xC1 },
> +	{ 0xD0, 0xE0 }, { 0xD1, 0x08 }, { 0xD2, 0x00 }, { 0xD3, 0xFF },
> +	{ 0xD4, 0xFF }, { 0xD5, 0x1E }, { 0xD6, 0x32 }, { 0xD7, 0xFF },
> +	{ 0xD8, 0x20 }, { 0xD9, 0x70 }, { 0xDA, 0x7F }, { 0xDB, 0xE0 },
> +	{ 0xDC, 0x00 }, { 0x76, 0x08 }, { 0x77, 0x00 }, { 0x79, 0x02 },
> +	{ 0x7A, 0x00 }, { 0xAA, 0x36 }, { 0xAB, 0xB0 }, { 0xAD, 0x04 },
> +	{ 0xAE, 0x00 },
> +};
> +
> +struct isg5320a_data {
> +	struct device *dev;
> +	struct regmap *regmap;

You can trivially retrieve the dev from regmap and they are always the
same one.

> +	int irq;
> +	/* Serialises multi-register chip sequences and the cached sample. */
> +	struct mutex lock;
> +	/* Serialises event enable/disable (sleeps in disable_irq()). */
> +	struct mutex ev_lock;
> +	bool ev_enabled;
> +	bool irq_wake_enabled;
> +	bool close;
> +	u16 cdc;
> +	u16 base;
> +	u16 thresh;
> +	u16 close_hyst;
> +	u16 far_hyst;
> +	u32 cfcal_th;
> +};
> +
> +static bool isg5320a_writeable_reg(struct device *dev, unsigned int reg)
> +{
> +	unsigned int i;
> +
> +	switch (reg) {
> +	case ISG5320A_REG_OSCCON:
> +	case ISG5320A_REG_IRQFUNC:
> +	case ISG5320A_REG_BS_ON_WD:
> +	case ISG5320A_REG_SCANCTRL1:
> +	case ISG5320A_REG_SCANCTRL2:
> +	case ISG5320A_REG_PROTECT:
> +	case ISG5320A_REG_SOFTRESET:
> +		return true;
> +	}
> +
> +	for (i =3D 0; i < ARRAY_SIZE(isg5320a_setup_reg); i++)

for (unsigned int i =3D 0;...

> +		if (isg5320a_setup_reg[i].addr =3D=3D reg)
> +			return true;
> +
> +	return false;
> +}
> +
> +static bool isg5320a_precious_reg(struct device *dev, unsigned int reg)
> +{
> +	/* Reading IRQSRC acknowledges the interrupt; keep debugfs off it. */
> +	return reg =3D=3D ISG5320A_REG_IRQSRC;
> +}
> +
> +static const struct regmap_config isg5320a_regmap_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +	.max_register =3D ISG5320A_MAX_REG,
> +	.writeable_reg =3D isg5320a_writeable_reg,
> +	.precious_reg =3D isg5320a_precious_reg,
> +	.cache_type =3D REGCACHE_NONE,

Why?  I'd expect a brief note if caching can't be used for some reason.

> +};
> +
> +/* vendor isg5320a_reset(), :247-292, plus a CHIPID read the vendor neve=
r does */
> +static int isg5320a_reset(struct isg5320a_data *data)
> +{
> +	struct device *dev =3D data->dev;
> +	unsigned int val;
> +	int ret;
> +
> +	usleep_range(5000, 5100);				/* :255-256 */

fsleep()

> +
> +	ret =3D regmap_read(data->regmap, ISG5320A_REG_IRQSRC, &val);	/* :258 */
> +	if (ret)
> +		return dev_err_probe(dev, ret, "no response at IRQSRC\n");
> +
> +	ret =3D regmap_read(data->regmap, ISG5320A_REG_CHIPID, &val);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "CHIPID read failed\n");
> +	if (val =3D=3D ISG5320A_VENDOR_CHIP_ID)
> +		dev_info(dev, "CHIPID 0x%02x\n", val);

Too much.  Check other drivers, we never print this.

> +	else
> +		dev_warn(dev, "CHIPID 0x%02x (vendor header says 0x%02x; not enforced)=
\n",
> +			 val, ISG5320A_VENDOR_CHIP_ID);
> +
> +	msleep(50);						/* :262-266 */
> +
> +	ret =3D regmap_write(data->regmap, ISG5320A_REG_PROTECT,	/* :268-271 */
> +			   ISG5320A_PROTECT_UNLOCK);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "unlock protect failed\n");
> +
> +	ret =3D regmap_write(data->regmap, ISG5320A_REG_SOFTRESET,	/* :273-276 =
*/
> +			   ISG5320A_SOFTRESET_VAL);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "soft reset write failed\n");
> +
> +	usleep_range(1000, 1100);				/* :278 */

fsleep() though following it with an msleep is odd.

> +
> +	msleep(50);						/* :280-289 */
> +	dev_dbg(dev, "reset done\n");

That is too much even for debug in a driver to be upstreamed.
We have a rich set of tracing tools for when we need info on this sort
of thing.

> +
> +	return 0;
> +}
> +
> +/* vendor isg5320a_initialize(), :614-660, without the /sdcard override =
*/
> +static int isg5320a_initialize(struct isg5320a_data *data)
> +{
> +	struct device *dev =3D data->dev;
> +	unsigned int i, val, mismatch =3D 0;
> +	u8 buf[6];
> +	int ret;
> +
> +	guard(mutex)(&data->lock);
> +
> +	ret =3D regmap_read(data->regmap, ISG5320A_REG_IRQSRC, &val);	/* :625 */
> +	if (ret)
> +		return ret;
> +	ret =3D regmap_write(data->regmap, ISG5320A_REG_SCANCTRL1,	/* :626 */
> +			   ISG5320A_SCAN_STOP);
> +	if (ret)
> +		return ret;
> +	msleep(30);						/* :627 */
> +
> +	for (i =3D 0; i < ARRAY_SIZE(isg5320a_setup_reg); i++) {	/* :631-637 */

	for (unsigned int i =3D 0; i < ...

> +		const struct isg5320a_reg_data *r =3D &isg5320a_setup_reg[i];
> +
> +		ret =3D regmap_write(data->regmap, r->addr, r->val);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "init write 0x%02x failed\n",
> +					     r->addr);
> +		ret =3D regmap_read(data->regmap, r->addr, &val);
> +		if (ret)
> +			return ret;
> +		if (val !=3D r->val) {
> +			mismatch++;
> +			dev_dbg(dev, "reg 0x%02x wrote 0x%02x read 0x%02x\n",
> +				r->addr, r->val, val);
Given that's dead hardware or something else that we should know about (vol=
atile
bits in a register) I'd argue we don't need to check it.  With that in mind
regmap_multi_reg_write() is your friend. You may even be able to use
it for other sequences of constant writes.


> +		}
> +	}
> +	dev_info(dev, "init table: %zu writes, %u read back different\n",
> +		 ARRAY_SIZE(isg5320a_setup_reg), mismatch);

Clean this debug stuff up. dev_dbg() at most.

> +
> +	/* :646-650 reads the threshold; :890-897 reads all six bytes */
> +	ret =3D regmap_bulk_read(data->regmap, ISG5320A_REG_B_PROXCTL3, buf,
> +			       sizeof(buf));
> +	if (ret)
> +		return ret;
> +	data->thresh =3D (buf[0] << 8) | buf[1];

See below on handling big endian values.

> +	data->close_hyst =3D (buf[2] << 8) | buf[3];
> +	data->far_hyst =3D (buf[4] << 8) | buf[5];
> +
> +	ret =3D regmap_read(data->regmap, ISG5320A_REG_DIGITAL_ACC, &val);	/* :=
653-657 */
> +	if (ret)
> +		return ret;
> +	data->cfcal_th =3D ISG5320A_RESET_CONDITION * val / 8;
> +
> +	dev_info(dev, "threshold %u, close hyst %u, far hyst %u, cfcal_th %u\n",
> +		 data->thresh, data->close_hyst, data->far_hyst, data->cfcal_th);

Isn't all that readable from sysfs?  Feels like too much noise to be more t=
han
dev_dbg() maybe.

> +
> +	return 0;
> +}
> +
> +/* vendor isg5320a_set_mode(SLEEP), :749-755 */
> +static int isg5320a_mode_sleep(struct isg5320a_data *data)
> +{
> +	unsigned int val;
> +	int ret;
> +
> +	guard(mutex)(&data->lock);
> +
> +	ret =3D regmap_read(data->regmap, ISG5320A_REG_IRQSRC, &val);
> +	if (ret)
> +		return ret;
> +	ret =3D regmap_write(data->regmap, ISG5320A_REG_SCANCTRL1, ISG5320A_SCA=
N_STOP);
> +	if (ret)
> +		return ret;
> +	ret =3D regmap_write(data->regmap, ISG5320A_REG_OSCCON, ISG5320A_OSC_SL=
EEP);
> +	if (ret)
> +		return ret;
> +	return regmap_write(data->regmap, ISG5320A_REG_BS_ON_WD, ISG5320A_BS_WD=
_OFF);
> +}
> +
> +/*
> + * vendor isg5320a_set_mode(NORMAL), :749 + :757-758, which runs
> + * isg5320a_force_calibration(data, false), :302-321.
> + */
> +static int isg5320a_mode_normal(struct isg5320a_data *data)
> +{
> +	struct regmap *map =3D data->regmap;
> +	unsigned int val;
> +	int ret;
> +
> +	guard(mutex)(&data->lock);
> +
> +	ret =3D regmap_read(map, ISG5320A_REG_IRQSRC, &val);			/* :749 */
> +	if (ret)
> +		return ret;

Unless related clump of registers, add a blank line between them.
Same for other functions.

> +	ret =3D regmap_write(map, ISG5320A_REG_BS_ON_WD, ISG5320A_BS_WD_ON);	/*=
 :757 */
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_write(map, ISG5320A_REG_SCANCTRL1, ISG5320A_SCAN_STOP);	=
/* :303 */
> +	if (ret)
> +		return ret;
> +	msleep(30);

Definitely a blank line after the sleep.

> +	ret =3D regmap_write(map, ISG5320A_REG_BS_ON_WD, ISG5320A_BS_WD_OFF);	/=
* :306 */
> +	if (ret)
> +		return ret;
> +	ret =3D regmap_write(map, ISG5320A_REG_SCANCTRL2, ISG5320A_SCAN2_CLEAR)=
;	/* :307 */
> +	if (ret)
> +		return ret;
> +	msleep(100);
And here
								/* :309 */
> +	ret =3D regmap_write(map, ISG5320A_REG_OSCCON, ISG5320A_OSC_NORMAL);	/*=
 :310 */
> +	if (ret)
> +		return ret;
> +	ret =3D regmap_write(map, ISG5320A_REG_BS_ON_WD, ISG5320A_BS_WD_ON);	/*=
 :312 */
> +	if (ret)
> +		return ret;
> +	ret =3D regmap_write(map, ISG5320A_REG_SCANCTRL2, ISG5320A_SCAN2_RESET)=
;	/* :313 */
> +	if (ret)
> +		return ret;
> +	ret =3D regmap_write(map, ISG5320A_REG_SCANCTRL1, ISG5320A_CFCAL_START)=
;	/* :316 */
> +	if (ret)
> +		return ret;
> +	msleep(500);								/* :318 */
> +	ret =3D regmap_write(map, ISG5320A_REG_SCANCTRL2, ISG5320A_BFCAL_START)=
;	/* :321 */
> +	if (ret)
> +		return ret;
> +
> +	/* The vendor sw_reset path waits 300 ms after BFCAL before reading (:8=
50-852). */
> +	msleep(300);
> +
> +	return 0;
> +}
> +
> +/* vendor isg5320a_get_raw_data(), :445-466; caller holds data->lock */
> +static int isg5320a_read_sample(struct isg5320a_data *data)
> +{
> +	u8 buf[4];
> +	u16 v;
> +	int ret;
> +
> +	lockdep_assert_held(&data->lock);
> +
> +	ret =3D regmap_bulk_read(data->regmap, ISG5320A_REG_CDC16_T_H, buf,
> +			       sizeof(buf));
> +	if (ret)
> +		return ret;
> +
> +	/* 0x0000 and 0xFFFF are discarded and the last value kept (:459-464) */
> +	v =3D (buf[0] << 8) | buf[1];

Those are endian reads so either read into the
write datatype __be16 I think and use be16_to_cpu()
or read into a buffer of u8[] and use get_unaligned_be16().

> +	if (v !=3D 0 && v !=3D 0xFFFF)
> +		data->cdc =3D v;
> +	v =3D (buf[2] << 8) | buf[3];
> +	if (v !=3D 0 && v !=3D 0xFFFF)
> +		data->base =3D v;
> +
> +	return 0;
> +}
> +
> +static int isg5320a_get_sample(struct isg5320a_data *data, u16 *cdc, u16=
 *base)
> +{
> +	struct device *dev =3D data->dev;
> +	int ret;
> +
> +	ACQUIRE(pm_runtime_active_auto_try_enabled, pm)(dev);
> +	ret =3D ACQUIRE_ERR(pm_runtime_active_auto_try_enabled, &pm);
> +	if (ret < 0)
> +		return ret;
> +
> +	scoped_guard(mutex, &data->lock) {
Wherever there is not much else going to happen, just hold the guard()
to the end of the function.

	guard(mutex)(&data->lock);

	ret =3D isg5320a_read_sample(data);
	if (ret)
		return ret;

	// don't set anything on error!

> +		ret =3D isg5320a_read_sample(data);
> +		*cdc =3D data->cdc;
> +		*base =3D data->base;
> +	}
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * The vendor cal_work (:1640-1647) force-recalibrates when cdc drops
> +	 * below cfcal_th. That loop is not ported; only report the condition.
> +	 */
> +	if (*cdc < data->cfcal_th)
> +		dev_warn_ratelimited(dev, "cdc %u below cfcal_th %u (vendor would reca=
librate)\n",
> +				     *cdc, data->cfcal_th);
> +
> +	return 0;
> +}
> +
> +static irqreturn_t isg5320a_irq_thread(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev =3D private;
> +	struct isg5320a_data *data =3D iio_priv(indio_dev);
> +	s64 timestamp =3D iio_get_time_ns(indio_dev);
> +	unsigned int src, sts;
> +	bool changed =3D false;
> +	bool close =3D false;
> +	int ret;
> +
> +	scoped_guard(mutex, &data->lock) {

I'd hold it for whole function.  The stuff outside the lock if fairly light.
	guard(mutex)(&data->lock);
should be fine.=20


> +		isg5320a_read_sample(data);				/* :581 */
> +
> +		ret =3D regmap_read(data->regmap, ISG5320A_REG_IRQSRC, &src);	/* :583 =
*/
> +		if (ret)
> +			break;

That relies on a the implementation of scoped_guard() as a hidden for loop.
I'm not a fan as consider these too hard to spot. Just print an error messa=
ge
if you want to and return from in here.


> +		ret =3D regmap_read(data->regmap, ISG5320A_REG_IRQSTS, &sts);	/* :598 =
*/
> +		if (ret)
> +			break;
> +
> +		close =3D sts & ISG5320A_IRQSTS_PROX;			/* :518 */
> +		changed =3D close !=3D data->close;
> +		data->close =3D close;
> +	}
> +
> +	if (ret) {
> +		dev_err_ratelimited(data->dev, "irq status read failed: %d\n", ret);
> +		return IRQ_HANDLED;
> +	}
> +
> +	dev_dbg(data->dev, "irq src 0x%02x sts 0x%02x cdc %u base %u\n",
> +		src, sts, data->cdc, data->base);
> +
> +	if (changed && READ_ONCE(data->ev_enabled)) {

So what is the enabled protecting against?  Sending a stray event in a race
with them being disabled is allowed behavior.  Synchronising the irq and
then check on whether we actually saw an irq should deal with other
cases. This rather wrecks my suggestion below of always taking the ev_lock
+ the guard() one above as they will be in reverse order of elsewhere.

> +		enum iio_event_direction dir;
> +
> +		dir =3D close ? IIO_EV_DIR_RISING : IIO_EV_DIR_FALLING;
> +		iio_push_event(indio_dev,
> +			       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, 0,
> +						    IIO_EV_TYPE_THRESH, dir),
> +			       timestamp);
> +	}
> +
> +	return IRQ_HANDLED;
> +}

> +
> +static int isg5320a_read_event_config(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan,
> +				      enum iio_event_type type,
> +				      enum iio_event_direction dir)
> +{
> +	struct isg5320a_data *data =3D iio_priv(indio_dev);
> +
> +	if (type !=3D IIO_EV_TYPE_THRESH || dir !=3D IIO_EV_DIR_EITHER)
> +		return -EINVAL;
> +
> +	return READ_ONCE(data->ev_enabled);

As below - I'd take the ev_lock if this is to avoid theoretical
tearing or other compiler silliness (that almost certainly don't
apply here in any real compiler.)

> +}

> +
> +static void isg5320a_events_off(struct isg5320a_data *data)
> +{
> +	struct device *dev =3D data->dev;
> +	int ret =3D 0;
> +
> +	scoped_guard(mutex, &data->lock)
> +		ret =3D regmap_write(data->regmap, ISG5320A_REG_IRQFUNC,	/* :726 */
> +				   ISG5320A_IRQFUNC_DISABLE);
> +	if (ret)
> +		dev_warn(dev, "IRQFUNC disable failed: %d\n", ret);
> +
> +	WRITE_ONCE(data->ev_enabled, false);

I'd just take the lock where you do the READ_ONCE.

> +	disable_irq(data->irq);=09

You've just written a register that sounds like it is preventing them at so=
urce.
Why do you need to disable the irq?  I haven't checked, but the most I'd ex=
pect
to see here is synchronize_irq() if you need to be very sure one doesn't tu=
rn up
late. That tends to only matter on remove() path were we are about to free =
resources
the irq uses.

> +	if (data->irq_wake_enabled) {
> +		disable_irq_wake(data->irq);				/* :729 */
> +		data->irq_wake_enabled =3D false;
> +	}
> +}
> +
> +static int isg5320a_write_event_config(struct iio_dev *indio_dev,
> +				       const struct iio_chan_spec *chan,
> +				       enum iio_event_type type,
> +				       enum iio_event_direction dir,
> +				       bool state)
> +{
> +	struct isg5320a_data *data =3D iio_priv(indio_dev);
> +
> +	if (type !=3D IIO_EV_TYPE_THRESH || dir !=3D IIO_EV_DIR_EITHER)
> +		return -EINVAL;
> +
> +	guard(mutex)(&data->ev_lock);
> +
> +	if (state =3D=3D data->ev_enabled)
> +		return 0;
> +
> +	if (state)
> +		return isg5320a_events_on(data);
> +
> +	isg5320a_events_off(data);
> +	pm_runtime_put_autosuspend(data->dev);

Why is the get inside events_on, but the put outside events_off?
Aim for consistency for things like this. Either is fine, but
I'm not going to like a mixture!

> +
> +	return 0;
> +}
> +
> +static int isg5320a_read_event_value(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir,
> +				     enum iio_event_info info,
> +				     int *val, int *val2)
> +{
> +	struct isg5320a_data *data =3D iio_priv(indio_dev);
> +
> +	if (type !=3D IIO_EV_TYPE_THRESH || info !=3D IIO_EV_INFO_VALUE)
> +		return -EINVAL;
> +
> +	/* vendor normal_threshold_show, :896-897 */
> +	switch (dir) {
> +	case IIO_EV_DIR_RISING:
> +		*val =3D data->thresh + data->close_hyst;
> +		return IIO_VAL_INT;
> +	case IIO_EV_DIR_FALLING:
> +		*val =3D (int)data->thresh - (int)data->far_hyst;

Does negative make sense?  Any idea what the device does if we
get to that?

> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +
> +#define ISG5320A_CHANNEL(_events, _nevents)			\
> +	{							\
> +		.type =3D IIO_PROXIMITY,				\
> +		.indexed =3D 1,					\
> +		.channel =3D 0,					\
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),	\
> +		.event_spec =3D _events,				\
> +		.num_event_specs =3D _nevents,			\
> +	}
> +
> +static const struct iio_chan_spec isg5320a_channels[] =3D {
> +	ISG5320A_CHANNEL(isg5320a_events, ARRAY_SIZE(isg5320a_events)),

to me that macro looks a bit pointless.  I'd just open code
setting everything as will be more readable and only 4 shared lines.

> +};
> +
> +static const struct iio_chan_spec isg5320a_channels_noirq[] =3D {
> +	ISG5320A_CHANNEL(NULL, 0),
> +};

> +/* vendor isg5320a_remove(), :2030-2033 */
> +static void isg5320a_teardown(void *arg)
> +{
> +	struct isg5320a_data *data =3D arg;
> +	struct device *dev =3D data->dev;
Mentioned below. Split this up.  It is also much more complex
than I'd expect to see.
> +
> +	pm_runtime_disable(dev);
That should be handled via devm_pm_runtime_enable()

> +
> +	if (data->ev_enabled) {
> +		isg5320a_events_off(data);
> +		pm_runtime_put_noidle(dev);
This bit is correct as you do need to turn off events.
> +	}
> +
> +	if (!pm_runtime_status_suspended(dev))
> +		isg5320a_mode_sleep(data);

Basing that on the runtime state tends to hit corner
cases. What happens if you do it unconditionally?

> +
> +	pm_runtime_set_suspended(dev);
You might want one of the variants of devm_pm_runtime_enable()
to sort that for you.
> +	pm_runtime_dont_use_autosuspend(dev);
Check upstream for that.  It actually happened when you
did pm_runtime_disable(). That is a recent change.



> +}
> +
> +static int isg5320a_probe(struct i2c_client *client)
> +{
> +	struct device *dev =3D &client->dev;
> +	struct isg5320a_data *data;
> +	struct iio_dev *indio_dev;
> +	unsigned long irqflags;
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data =3D iio_priv(indio_dev);
> +	data->dev =3D dev;
> +	data->irq =3D client->irq;
> +	i2c_set_clientdata(client, indio_dev);
> +
> +	ret =3D devm_mutex_init(dev, &data->lock);
> +	if (ret)
> +		return ret;
> +	ret =3D devm_mutex_init(dev, &data->ev_lock);
> +	if (ret)
> +		return ret;
> +
> +	/* The vendor node has no supply; the board relies on an always-on LDO.=
 */

No value in that comment.

> +	ret =3D devm_regulator_get_enable_optional(dev, "vdd");

vdd isn't optional.  Devices tend not to work great without power..
Look at what happens if it isn't there in device tree.

> +	if (ret && ret !=3D -ENODEV)
> +		return dev_err_probe(dev, ret, "failed to enable vdd\n");
> +	/*
> +	 * If the rail was just switched on, give the chip time to come out
> +	 * of power-on reset. The vendor never switches it, so this value
> +	 * (10 ms) is a guess, not from the vendor source.
> +	 */
> +	if (!ret)

ah. I guess this is why you are doing the optional. Don't - it complicates
code and you should make not assumptions.  If a sleep is needed for power
on, always do it even if you didn't control the power on.

> +		usleep_range(10000, 11000);

fsleep and do it unconditionally.  Though should only reflect the device
time not the power rail (which the regulator driver should have dealt with
at least near enough that it doesn't matter).


> +
> +	data->regmap =3D devm_regmap_init_i2c(client, &isg5320a_regmap_config);
> +	if (IS_ERR(data->regmap))
> +		return dev_err_probe(dev, PTR_ERR(data->regmap), "regmap init failed\n=
");
> +
> +	ret =3D isg5320a_reset(data);				/* :1915 */
> +	if (ret)
> +		return ret;
> +
> +	msleep(300);			/* vendor runs init_work 300 ms later, :1981 */
This may be worth capturing.  300 msec to match vendor driver. or something=
 like that.
> +
> +	ret =3D isg5320a_initialize(data);			/* :1620 */
> +	if (ret)
> +		return dev_err_probe(dev, ret, "init failed\n");
> +
> +	ret =3D isg5320a_mode_normal(data);			/* :1621 */

Get rid of all these comments You are dealing with upstream not the vendor =
driver.

> +	if (ret)
> +		return dev_err_probe(dev, ret, "start failed\n");
> +
> +	/*
> +	 * The chip is already active, so a later failure (e.g. the IRQ
> +	 * request below) must still put it back to sleep instead of leaving
> +	 * it scanning with nothing bound to it.
> +	 */
As you manually enabled the power (which is fine) one solution is
to add devm_add_action_or_reset() that disables it again. I think
that's idempotent here which makes it simple.

> +	pm_runtime_set_autosuspend_delay(dev, ISG5320A_AUTOSUSPEND_MS);
> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_set_active(dev);
> +	pm_runtime_get_noresume(dev);
> +	pm_runtime_enable(dev);
> +	pm_runtime_put_autosuspend(dev);

What do you think this dance is doing?  Look at what happens if you
take no references at all and enable autosuspend.  There is stuff
in the core that sashiko has recently finally found and stopped putting
out incorrect feedback on this.  Either that or it found the many
emails saying ignore sashiko as it is wrong on this one thing.

Probably also want the devm variant to reduce some other stuff you have
later.

> +
> +	if (data->irq > 0) {
> +		irqflags =3D irq_get_trigger_type(data->irq);
> +		if (!irqflags)
> +			irqflags =3D IRQF_TRIGGER_FALLING;	/* :1932 */

No to doing that in new drivers. That is papering over a DT bug.
We have a few instances of ancient drivers doing this in tree because
we want got it wrong. Not in new code.

> +
> +		ret =3D devm_request_threaded_irq(dev, data->irq, NULL,
> +						isg5320a_irq_thread,
> +						irqflags | IRQF_ONESHOT |
> +						IRQF_NO_AUTOEN,
> +						"isg5320a", indio_dev);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "irq request failed\n");
> +
> +		if (device_property_read_bool(dev, "wakeup-source"))
> +			device_init_wakeup(dev, true);

Good. So you know if is a wakeup source. Make your power saving code aware
of that.  See below.

> +	}
> +
> +	/*
> +	 * Registered after the IRQ request, so devm's LIFO unwind runs this
> +	 * teardown (which may disable_irq()/disable_irq_wake() the IRQ in
> +	 * isg5320a_events_off()) before the IRQ itself is freed, not after.
> +	 */

I'll come back to those disable_irq() (above, I review upwards as code
makes more sense that way around!) That's normally a bad smell in a
driver unless we have a very stupid device where we can't do a more
elegant and controlled disable at source.  Also split this up.
I wouldn't mind even tear down at this point with a similar comment.
There are some corners around that which I'm planning to rework, but
not the stuff changing the mode etc or messing with runtime pm.
For those register stuff immediately after what is being undone.

> +	ret =3D devm_add_action_or_reset(dev, isg5320a_teardown, data);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name =3D "isg5320a";
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +	if (data->irq > 0) {
> +		indio_dev->info =3D &isg5320a_info;
> +		indio_dev->channels =3D isg5320a_channels;
> +		indio_dev->num_channels =3D ARRAY_SIZE(isg5320a_channels);
> +	} else {
> +		indio_dev->info =3D &isg5320a_info_noirq;
> +		indio_dev->channels =3D isg5320a_channels_noirq;
> +		indio_dev->num_channels =3D ARRAY_SIZE(isg5320a_channels_noirq);
> +	}
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +/* vendor isg5320a_shutdown(), :2071-2080, synchronized like isg5320a_te=
ardown() */

Given vendor drivers change too so by all means have a reference
somewhere to it, but I wouldn't call out each path.

> +static void isg5320a_shutdown(struct i2c_client *client)

Why do you care about shutdown?  In vast majority of cases it is
not seen in a IIO driver because it doesn't matter if we turn
off a device when the power is promptly cut. It might matter
for you of course, but I want to know more.

> +{
> +	struct isg5320a_data *data =3D iio_priv(i2c_get_clientdata(client));
> +	struct device *dev =3D data->dev;
> +
> +	guard(mutex)(&data->ev_lock);
> +
> +	if (data->ev_enabled) {
> +		isg5320a_events_off(data);
> +		pm_runtime_put_noidle(dev);
> +	}
> +
> +	if (!pm_runtime_status_suspended(dev))
> +		isg5320a_mode_sleep(data);
> +}

> +
> +/*
> + * Runtime PM only. System sleep leaves the chip as it is, as the vendor
> + * does (its suspend/resume only stop and restart the work items), so an
> + * enabled grip event can still wake the system.

Ignore the vendor driver (which is doing it wrong) and research how
wakeup sources work.  They need to be deliberately registered rather
than just relying on leaving stuff on and hoping right thing happens.
Until that is in place, I would at least use the DEFINE_RUNTIME_DEV_PM_OPS
so we get some power saving on suspend.  It is fine to upstream a driver
without wakeup support.


> + */
> +static const struct dev_pm_ops isg5320a_pm_ops =3D {
> +	RUNTIME_PM_OPS(isg5320a_runtime_suspend, isg5320a_runtime_resume, NULL)
> +};

> +

