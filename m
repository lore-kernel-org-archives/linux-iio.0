Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794995657;
	b=QQGOEqwmapN+5i/1guOfW90r7/ajrcZ/j5fNTOsJp/fh8zW+0SU2pJwJEGm0kfD2CFtz
	 iYT+3UHKIJ+ZvrWgiel+jBf6GkiAX9qZiVGibKRc9IfYdams9JRdeC0bSI7vjamsroSJ8
	 GyqPz+JTltSff6W78i83pkEA7SWn0Yht8FUw0O3OmdkPDD9/0BrNnJOF8wNcKuT7dP4ud
	 e9lWFy8Wql2XdRNwiV9WhWV1t6y5L+gI/rRFhDv9bLBafWF5Dzjgn2BjQdup9QsokYU3W
	 cdmK3jHnnfg7U3qaAjrR7EP6JWC81ZSgRwDuJDs75PSoTwlr7gq1jJaCxkKQUrNb1kg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794995657;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=jrHImS6SHFxEvgyllHNHiRZqjIpVpWkFh/6yzStVAp8=;
	b=JkM66/qHlJGmWV8y51Nmp5gxhATliTmEWfDF77Og7VieT2BEMaKTo8U+6L34rZixFRLF
	 jFt7maU83v3gHjlkVzuqCzFpRYZPMwIyoIqhxIl9oxeQWwvZCx5sAGdxZDvvdCd8whyS3
	 NTAVog1AswdbszE5xKva1qqiRF3XQOk737PpA4sn6T1s22tKUxbKB8xVyGeCJXbHwU6/E
	 Jz5+llnOHUdT8kMmRWyDKi912pYsSwIGcAo/USm3y0qyYxCxNL5Iz+gvm3vqxFL41Bs27
	 pzbVoxNs/QrB0IFLeRldsZTFxoK58RO/LssMxNTOXSz9nL8FHks6nxZ2DQ4b7vdNHDQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ggAreje6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9373C606A31C;
	Wed, 18 Nov 2026 09:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ggAreje6
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794995657;
	b=M7mlOdMvJVSz6jkGQQI71D3Ph9xg1c/3dzx/P4IA+RkRPJ0hrPXYeSNVuI1Euh9Nz+wS
	 D0hkNG0QBe3JmEAkaE2gsAT6VAJEmi1Gssp1gXuS1u1uUeIN66PCREcfXe0VWShY1X/oz
	 3HT+fL1hoa4RTXbKeaSUjLO6+QS09nW9fyy9JAmlPaSoAW1djMcj/jAfpcMPfQ21U14wG
	 TX6+kdluzXC3LhMgM986kD+zG6ezMYDSbqBuGfP+yX+Nx4e2u6KZU/c6fu/6b//CU3fXx
	 plAaBAigogbhQg8P4I1dGZ64o3dABqerKKAO1CT8J5DvVtYPwdBiFkk+DvWuNZm90/Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794995657;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=jrHImS6SHFxEvgyllHNHiRZqjIpVpWkFh/6yzStVAp8=;
	b=xOGtPT951aU0ojFGi4S1HY1kqswmFLkcHvFiL+F1MvjTPS3U1N2z4UBrrY4BrC62Ic77
	 G7EZQTIiwCmUFrevV5qlfAR3tXRAKNUJ1Dve4oZPnTW1D1f9kcBPUc3Vl42lyHL/wKxfZ
	 NQQxYa5IacK2aSPuuIstBMiEqrxmh+6aGyjo/SBhTXy1VT8kR4dswy7EYvXKzoDgmK5Rt
	 YJf5Zz+uZ5RkdtVGc2Tr6/HnX/dpf7DlMWtABT7Iv/zTM2gjGLbkBDg9lku/w/8ikKrro
	 0Jsd/VGndEqZ2h+Cd9FV/98mZ5kxwKqO9pqPwRpuuIVzjjTJo8LQcZ/ntgbdLSlfI7g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id 2D6AA1F000C4;
	Wed, 18 Nov 2026 09:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794995657;
	bh=jrHImS6SHFxEvgyllHNHiRZqjIpVpWkFh/6yzStVAp8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ggAreje69HeKmUNj7QLYnWTcM1DRY0614y63fRvhzs/73o7AklVKRspSRVaDh/X9Q
	 ClU9yIXu7Nb1eT0KjLstTb7h9OKIKINscabKoP5GqyJGibsbK8nT88qW7Cb9qeYpZl
	 nviC+XD6spTUENFNBphnZNQ/3zCgZF7VYw9DAgtDYOrCw2KJWB3W0F30cl1q5I0Jo8
	 sKJnBChlQd7yC0dDlNJ0zGL5BDmB77AMgAPnBlnyURhiGoL7icawZ6CndaJurDmhsX
	 muXZqrlct9+5nhpO9k7NZmZwjjeiSiaqzlZF1vqZv1cXiBXwTMRY+SuTyraCDlOOLX
	 V1myAQzCMaEww==
Date: Wed, 18 Nov 2026 10:53:39 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Adil =?ISO-8859-1?Q?H=FCsrev?= Tepe <tadilhusrev@gmail.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: proximity: add Imagis ISG5320A SAR sensor
 driver
Message-ID: <20261118105339.00001bab@kernel.org>
In-Reply-To: <20261117173333.1853986-3-tadilhusrev@gmail.com>
References: <20261116074013.355363-1-tadilhusrev@gmail.com>
	<20261117173333.1853986-1-tadilhusrev@gmail.com>
	<20261117173333.1853986-3-tadilhusrev@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, 17 Nov 2026 20:33:33 +0300
Adil H=FCsrev Tepe <tadilhusrev@gmail.com> wrote:

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
> Signed-off-by: Adil H=FCsrev Tepe <tadilhusrev@gmail.com>
> ---

Hi Adil, some comments inline.

...

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
> + *
> + * The chip is used as one proximity channel: the vendor's "diff" value
> + * (CDC16_T - BSL16_B, i.e. the B-channel signal minus its baseline) is
> + * exposed as in_proximity0_raw, and the chip's CLOSE/FAR interrupt is
> + * exposed as IIO threshold events (rising =3D grip, falling =3D release=
).
> + */
> +
> +#include <linux/array_size.h>
> +#include <linux/bits.h>
> +#include <linux/cleanup.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/errno.h>

+ err.h

> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/mod_devicetable.h>

Remove this, i2c.h includes the correct device tables.

> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/pm.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/pm_wakeup.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/types.h>
> +

Otherwise good to see that IWYU is slowly catching on in new
submissions :)

> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +

...

> +
> +struct isg5320a_data {
> +	struct device *dev;
> +	struct regmap *regmap;
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

I ran pahole and found this layout to be optimal without any holes:

        struct device *            dev;                  /*     0     8 */
        struct regmap *            regmap;               /*     8     8 */
        struct mutex               lock __attribute__((__aligned__(8))); /*=
    16    24 */
        struct mutex               ev_lock __attribute__((__aligned__(8)));=
 /*    40    24 */
        /* --- cacheline 1 boundary (64 bytes) --- */
        int                        irq;                  /*    64     4 */
        u32                        cfcal_th;             /*    68     4 */
        u16                        cdc;                  /*    72     2 */
        u16                        base;                 /*    74     2 */
        u16                        thresh;               /*    76     2 */
        u16                        close_hyst;           /*    78     2 */
        u16                        far_hyst;             /*    80     2 */
        bool                       ev_enabled;           /*    82     1 */
        bool                       irq_wake_enabled;     /*    83     1 */
        bool                       close;                /*    84     1 */

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

for (unsigned int i =3D 0; ...

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

fsleep() would be better. Same goes for other usleep_range() calls.

> +
> +	ret =3D regmap_read(data->regmap, ISG5320A_REG_IRQSRC, &val);	/* :258 */
> +	if (ret)
> +		return dev_err_probe(dev, ret, "no response at IRQSRC\n");

Do we need these dev_err_probe() calls at each regmap operation? return ret=
 is good
enough.

> +
> +	ret =3D regmap_read(data->regmap, ISG5320A_REG_CHIPID, &val);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "CHIPID read failed\n");
> +	if (val =3D=3D ISG5320A_VENDOR_CHIP_ID)
> +		dev_info(dev, "CHIPID 0x%02x\n", val);
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
> +
> +	msleep(50);						/* :280-289 */
> +	dev_dbg(dev, "reset done\n");
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

Blank lines between each function call + if statement group, it improves re=
adability.

> +	ret =3D regmap_write(data->regmap, ISG5320A_REG_SCANCTRL1,	/* :626 */
> +			   ISG5320A_SCAN_STOP);
> +	if (ret)
> +		return ret;
> +	msleep(30);						/* :627 */
> +
> +	for (i =3D 0; i < ARRAY_SIZE(isg5320a_setup_reg); i++) {	/* :631-637 */

unsigned int i =3D 0 as well.

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
> +		}
> +	}
> +	dev_info(dev, "init table: %zu writes, %u read back different\n",
> +		 ARRAY_SIZE(isg5320a_setup_reg), mismatch);
> +
> +	/* :646-650 reads the threshold; :890-897 reads all six bytes */
> +	ret =3D regmap_bulk_read(data->regmap, ISG5320A_REG_B_PROXCTL3, buf,
> +			       sizeof(buf));
> +	if (ret)
> +		return ret;
> +	data->thresh =3D (buf[0] << 8) | buf[1];
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
> +
> +	return 0;
> +}
> +

...

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
> +}
> +
> +/* vendor isg5320a_set_enable(), :681-742 (minus the work items) */
> +static int isg5320a_events_on(struct isg5320a_data *data)
> +{
> +	struct device *dev =3D data->dev;
> +	unsigned int val;
> +	int ret;
> +
> +	ret =3D pm_runtime_resume_and_get(dev);

You could use PM_RUNTIME_ACQUIRE_AUTOSUSPEND() to ensure the device is susp=
ended
on scope exit. It works on the same cleanup.h magic as guard().

> +	if (ret)
> +		return ret;
> +
> +	scoped_guard(mutex, &data->lock) {
> +		ret =3D regmap_read(data->regmap, ISG5320A_REG_IRQSTS, &val);	/* :700 =
*/
> +		if (ret)
> +			break;

With the macro mentioned above you could just return here and don't need th=
e if (ret)
check below.

> +		data->close =3D val & ISG5320A_IRQSTS_PROX;		/* :708-713 */
> +		isg5320a_read_sample(data);				/* :704 */
> +		ret =3D regmap_read(data->regmap, ISG5320A_REG_IRQSRC, &val);	/* :718 =
*/
> +		if (ret)
> +			break;
> +		ret =3D regmap_write(data->regmap, ISG5320A_REG_IRQFUNC,	/* :719 */
> +				   ISG5320A_IRQFUNC_ENABLE);
> +	}
> +	if (ret) {
> +		pm_runtime_put_autosuspend(dev);
> +		return ret;
> +	}
> +
> +	WRITE_ONCE(data->ev_enabled, true);
> +	enable_irq(data->irq);						/* :721 */
> +	/*
> +	 * Cache the decision: device_may_wakeup(dev) may change before
> +	 * events_off(), and we must only clear a wake enable we actually
> +	 * set, so only mark it enabled if enable_irq_wake() succeeded.
> +	 */
> +	if (device_may_wakeup(dev))
> +		data->irq_wake_enabled =3D !enable_irq_wake(data->irq);	/* :722 */
> +
> +	dev_dbg(dev, "events on, initial state %s\n", data->close ? "close" : "=
far");
> +
> +	return 0;
> +}
> +

...

> +/* vendor isg5320a_remove(), :2030-2033 */
> +static void isg5320a_teardown(void *arg)
> +{
> +	struct isg5320a_data *data =3D arg;
> +	struct device *dev =3D data->dev;
> +
> +	pm_runtime_disable(dev);
> +
> +	if (data->ev_enabled) {
> +		isg5320a_events_off(data);
> +		pm_runtime_put_noidle(dev);
> +	}
> +
> +	if (!pm_runtime_status_suspended(dev))
> +		isg5320a_mode_sleep(data);
> +
> +	pm_runtime_set_suspended(dev);

> +	pm_runtime_dont_use_autosuspend(dev);

No need for this, I've changed the PM runtime core to call this automatical=
ly
on driver exit :)

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

+ blank line

> +	ret =3D devm_mutex_init(dev, &data->ev_lock);
> +	if (ret)
> +		return ret;
> +
> +	/* The vendor node has no supply; the board relies on an always-on LDO.=
 */
> +	ret =3D devm_regulator_get_enable_optional(dev, "vdd");
> +	if (ret && ret !=3D -ENODEV)
> +		return dev_err_probe(dev, ret, "failed to enable vdd\n");
> +	/*
> +	 * If the rail was just switched on, give the chip time to come out
> +	 * of power-on reset. The vendor never switches it, so this value
> +	 * (10 ms) is a guess, not from the vendor source.
> +	 */
> +	if (!ret)
> +		usleep_range(10000, 11000);

fsleep()

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
> +
> +	ret =3D isg5320a_initialize(data);			/* :1620 */
> +	if (ret)
> +		return dev_err_probe(dev, ret, "init failed\n");
> +
> +	ret =3D isg5320a_mode_normal(data);			/* :1621 */
> +	if (ret)
> +		return dev_err_probe(dev, ret, "start failed\n");
> +
> +	/*
> +	 * The chip is already active, so a later failure (e.g. the IRQ
> +	 * request below) must still put it back to sleep instead of leaving
> +	 * it scanning with nothing bound to it.
> +	 */
> +	pm_runtime_set_autosuspend_delay(dev, ISG5320A_AUTOSUSPEND_MS);
> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_set_active(dev);
> +	pm_runtime_get_noresume(dev);
> +	pm_runtime_enable(dev);
> +	pm_runtime_put_autosuspend(dev);
> +
> +	if (data->irq > 0) {
> +		irqflags =3D irq_get_trigger_type(data->irq);
> +		if (!irqflags)
> +			irqflags =3D IRQF_TRIGGER_FALLING;	/* :1932 */
> +
> +		ret =3D devm_request_threaded_irq(dev, data->irq, NULL,
> +						isg5320a_irq_thread,
> +						irqflags | IRQF_ONESHOT |
> +						IRQF_NO_AUTOEN,
> +						"isg5320a", indio_dev);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "irq request failed\n");

Duplicate error call, devm_request_threaded_irq() already does this on fail=
ure.

> +
> +		if (device_property_read_bool(dev, "wakeup-source"))
> +			device_init_wakeup(dev, true);
> +	}
> +
> +	/*
> +	 * Registered after the IRQ request, so devm's LIFO unwind runs this
> +	 * teardown (which may disable_irq()/disable_irq_wake() the IRQ in
> +	 * isg5320a_events_off()) before the IRQ itself is freed, not after.
> +	 */
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

--=20
Kind regards,
Joshua Crofts
