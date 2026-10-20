Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792481001;
	b=3ut4rgDnHPK2vsBLJ/orplKMwboI3QImFgDJ5lKJHbnQ0hjVQK7XyTCHTccPR5vIVnaf
	 m4pvqdO7h8wfk3MZdZ673GQKB0bIJvFdXuIJGoreP3wnlM+X7+JqrPE/3F5pEV4qEO9sN
	 H5HqeDjCXYxJNyn2p6U1CknjF98NcIRfhbOKHXe7B4gZsjKm+xEExUoE4axigm7+xUOUx
	 C5zLOutAbfiB8T2GN8tLw/hWX7XE9yejq82CCQoabouuL4FRSMTfZAB4TDzJcaaPB5FmI
	 O5PQ8D66Mt2NnhN0abJzJvkWfebJuMsKnDy18asUcW2ZTy3/zi0Mo3f4yI8u4uGr4qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792481001;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=RHUiUEHREUeEh5je+5lV75Z/l5w+EUxJwFLE25lJoH8=;
	b=b78QaoISbTszmiV8fAe6qeEgYkBlGEN7Z+H7yztDrt6F01/ucx1bzBR13txaw8Awl8Qk
	 IWEu/syomztgvvi+/2sy8vPRzoqRuBIIgD98xElNYpvKLfWypxvzioP87VDcDSI2p/ZX5
	 FnRqnRI1iYI89akyzo2R9Op0ZqHrvekfssrba4RFZj3Sgn+9RsFVkljd6L9XVX2VGqh4t
	 /P0/0Ghz/nj2vXgwYA7MIwPRByjOlWCdAchZd8nU9Y59UZM7LFe5d3BpyRP72ebsXCyL6
	 Jvy0TOpb0qtEYejGYT2mVG1Gq87LmIkdF7W7Hes4p8spUg8PJCmxLAeFidoJBlwpCSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EdnIsuwq;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB04606A31D
	for <linux-iio@vger.kernel.org>; Tue, 20 Oct 2026 07:23:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCB04606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EdnIsuwq
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a1ec92f655so3929695e9.0
        for <linux-iio@vger.kernel.org>; Tue, 20 Oct 2026 00:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792480999; x=1793085799; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RHUiUEHREUeEh5je+5lV75Z/l5w+EUxJwFLE25lJoH8=;
        b=EdnIsuwqI7NQKvCjzojPTT0RDLLN547WJUEvCt4bJznPoyINqzTvVLhEf3tH9Se4jt
         grslrI3wq1Wn4jN7ZZctYegJUcwgAohvax2PLd3FxS+t3ZStnnOeb9yujfGcDV/FBCI+
         mSmnM9plppXbJeZemMkLZoYraOZM3ER2+HwA1eFLU4NZvgCoZibaQlWfVilrR/AAQlo5
         T3qv7q82p5Yv7JjMQmz9tiLuAl8vrXgyjDYCsPI4XMv9aHUw5lR67wxKDteStiVTYWvd
         nztWJD2GenTB1wHYYsoSQFWmx+h8+qmz3L7gwrNAYmjDGz1ovD2BoAp1kWXMp1n69nY1
         9ThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792480999; x=1793085799;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RHUiUEHREUeEh5je+5lV75Z/l5w+EUxJwFLE25lJoH8=;
        b=rryQ0jU5zQMr20E8e5xSVDd+nc6kO+xbTwksc+O582VTIZ5phIJguNOx2S4WEZ6C0V
         TcDMgBVrc4seMKsLVp+M9lWgKcAPGN08laXlZEf0sCoDEPLnPM0gOKNxQhHOmKlSVZG9
         LsDe8bNPFCgRT5b6ZLpAuqzo0IEueIfeMSHLuKp2m1mp9VemERcbA7SDPriOFy6YQuG7
         EUuH8r7oSIDFhm6c3xdHhKLUWtnlgD2E2xoAmoDeQqrD3wUQ80Dhg5RebtAHJa4QJu3D
         EdmUO/mQQQzHyNv+J78hUV6QWBtu/nV06KZDLNQAQ8CbkZ1SH4hddWq3/kbvzmmGIkh8
         ldNA==
X-Forwarded-Encrypted: i=1; AKwUvBwM+E80i5ZV4mEmYsG2BPizGkRvoRWknuedGq6T8Z01b0/pCfxlvJgql+JMoGm3OJU/2hYedingz1g=@vger.kernel.org
X-Gm-Message-State: AFq9FYK5eobVYaAOlZj13AEstx6sRi91J3Oj8uy7jDJJgPdnmqqfb5fR
	oDEUm0vH8EKhmoQshQ4J3Tb+p9QE0m7INvQ8YzjshZ7ancm4JMaiblXY
X-Gm-Gg: AYBFou1VMYLMVBmBAG6XZreNZ+OVjZJwR4rmE6JS6SZm71A2xmBEIsJ7zcB0rdLDm74
	nWmYLFn5NMhsE4qTHnfPSWraODjgPAQixkYi5JZvst1uqwo/td+h73kooBFBT4/dTH7CFi1lTkX
	eftwf/mMk1npMVSzvd+c+0M3sUgvkHWUQh994c2zrWKqJGmd+pEMVSeSDviZ7VRBD0O9WuoVlra
	Sab+fvfx65FDVbMtggRk0LYdu6QRbq2jsZNURc4FG3X871Whpj0wNbVez5G8kMGckSKQOwuo2hg
	KvfBREHo82Aj35OOmzSvkRWBcucJIEWuFH0wDZPPZobeeE0ZpTtSXO9LQJnOAJCEWrM2GkLGj1Q
	6R6RWqe7yB2cRzYQFw5G+4/Ur2h4YZy4gdGZ1X2sLXDyl5Bg/4R+cehbRd9lgecczc76S34MhmN
	Yi1XqEceS5Hzwo985MPRwPAnUg7hzsIdSlyCfNMWYEUkP6twKl2zez4HxAKeOTZ/G+N4Mo0qS1/
	m5KLeU1rWMUZaC6D570Msi6VzC0+miNIny18GZMB0FU5mIYPDqNharkI0V5CTmFXunzN54vUmhx
	nIvJEBDdOS6sdSqUA8CeiZj97WVjoONCjl5o3TuUnGnQFognMslRtmuVsHTS4Bk2QKcquukVl1i
	RNmP/O61IOpH42Kw7vWuTTm20LkDh44fcgyIhr77UhTKesJuCXTLlaOfhDnfCXU9KpooiouhDEt
	G+hEud
X-Received: by 2002:a05:600c:80c3:b0:49c:ff66:7d88 with SMTP id 5b1f17b1804b1-4a1f52b9d52mr17422595e9.7.1792480998747;
        Tue, 20 Oct 2026 00:23:18 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d6dc034sm3958956f8f.3.2026.10.20.00.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 00:23:18 -0700 (PDT)
Date: Tue, 20 Oct 2026 09:23:16 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Vidhu Sarwal via B4 Relay <devnull+vidhu.linux.gmail.com@kernel.org>
Cc: vidhu.linux@gmail.com, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, Shuah Khan
 <skhan@linuxfoundation.org>
Subject: Re: [PATCH 3/3] iio: proximity: Add Benewake TF-Luna LiDAR driver
Message-ID: <20261020092316.00003339@gmail.com>
In-Reply-To: <20261020-tf-luna-v1-3-53a88f93db24@gmail.com>
References: <20261020-tf-luna-v1-0-53a88f93db24@gmail.com>
	<20261020-tf-luna-v1-3-53a88f93db24@gmail.com>
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Oct 2026 00:03:43 +0530
Vidhu Sarwal via B4 Relay <devnull+vidhu.linux.gmail.com@kernel.org> wrote:

> From: Vidhu Sarwal <vidhu.linux@gmail.com>
> 
> Add a driver for the Benewake TF-Luna, a single-point time-of-flight
> LiDAR distance sensor with a range of 0.2 m to 8 m, connected over I2C.
> 
> The sensor is run in trigger mode. Each read starts one measurement and
> waits for the timestamp register to change before reading the result.
> In continuous mode a read can catch the sensor in the middle of updating
> its result registers unless it is synchronised to the data ready output,
> which this driver does not use yet.
> 
> When the signal strength is too low the sensor reports a dummy distance
> of 0, so such readings, as well as overexposed ones, return -ENODATA
> instead of a distance.
> 
> The datasheet is available at:
> https://en.benewake.com/uploadfiles/2025/04/20250430174501874.pdf
> 
> Signed-off-by: Vidhu Sarwal <vidhu.linux@gmail.com>
> ---

Hi Vidhu,

very good for a v1, even Sashiko reported no issues. Minor style issues from
me.

Josh

> +#include <linux/array_size.h>
> +#include <linux/bits.h>
> +#include <linux/cleanup.h>
> +#include <linux/delay.h>
> +#include <linux/dev_printk.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/iopoll.h>
> +#include <linux/mod_devicetable.h>

Remove this, this is included by i2c.h

> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/string.h>
> +#include <linux/time.h>
> +#include <linux/types.h>
> +
> +#include <asm/byteorder.h>
> +
> +#include <linux/iio/iio.h>
> +
> +#define TF_LUNA_REG_DIST		0x00
> +#define TF_LUNA_REG_TICK		0x06
> +#define TF_LUNA_REG_VERSION		0x0A
> +#define TF_LUNA_REG_MODE		0x23
> +#define TF_LUNA_REG_TRIG_ONE_SHOT	0x24
> +#define TF_LUNA_REG_SIGNATURE		0x3C
> +
> +#define TF_LUNA_MODE_TRIGGER		0x01
> +#define TF_LUNA_TRIG_ONE_SHOT		0x01
> +
> +/* Below this the sensor reports a dummy distance of 0 */
> +#define TF_LUNA_AMP_MIN			100
> +#define TF_LUNA_AMP_OVEREXPOSED		0xFFFF
> +
> +/* A measurement takes 10-20 ms in trigger mode */
> +#define TF_LUNA_POLL_US			(2 * USEC_PER_MSEC)
> +#define TF_LUNA_TIMEOUT_US		(100 * USEC_PER_MSEC)

uS is better instead of US.

> +
> +struct tf_luna_data {
> +	struct regmap *regmap;
> +	/* Serialises the trigger, poll and read of a single measurement */
> +	struct mutex lock;
> +};
> +
> +static const struct regmap_config tf_luna_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = TF_LUNA_REG_SIGNATURE + 3,
> +};
> +
> +static int tf_luna_read_tick(struct tf_luna_data *data, u16 *tick)
> +{
> +	__le16 val;
> +	int ret;
> +
> +	ret = regmap_bulk_read(data->regmap, TF_LUNA_REG_TICK, &val, sizeof(val));
> +	if (ret)
> +		return ret;
> +
> +	*tick = le16_to_cpu(val);
> +	return 0;
> +}
> +
> +static int tf_luna_measure(struct tf_luna_data *data, int *dist)
> +{
> +	__le16 buf[2];	/* distance in cm, signal strength */
> +	u16 old_tick, tick, amp;
> +	int ret, err;
> +
> +	guard(mutex)(&data->lock);
> +
> +	ret = tf_luna_read_tick(data, &old_tick);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(data->regmap, TF_LUNA_REG_TRIG_ONE_SHOT,
> +			   TF_LUNA_TRIG_ONE_SHOT);

Why not have a local variable for regmap? It would allow the previous call
to fit on one line.

...

> +static int tf_luna_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct tf_luna_data *data;
> +	struct iio_dev *indio_dev;
> +	unsigned int mode;
> +	u8 signature[4];
> +	u8 version[3];
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +
> +	ret = devm_mutex_init(dev, &data->lock);
> +	if (ret)
> +		return ret;
> +
> +	data->regmap = devm_regmap_init_i2c(client, &tf_luna_regmap_config);
> +	if (IS_ERR(data->regmap))
> +		return dev_err_probe(dev, PTR_ERR(data->regmap),
> +				     "Failed to initialize regmap\n");
> +
> +	ret = devm_regulator_get_enable(dev, "vcc");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable vcc regulator\n");
> +
> +	/* Boot time is not documented, about 350 ms was measured */
> +	fsleep(500 * USEC_PER_MSEC);

msleep() is fine here, saves you the x * USEC_PER_MSEC format.

-- 
Kind regards,
Joshua Crofts
