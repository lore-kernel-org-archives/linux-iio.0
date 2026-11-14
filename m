Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794619757;
	b=pz9H2nY56Rq623S2ef4NCYWS3OEOEnlLL1TCxhGC/6E4vxU3SsMQNAK3q7JQU3z8UybH
	 ob9sUGeTpZmH9kUmOL4mYhOP0yy4BaURFSsR64tml4XIhEybJlAePfrIQC/i+xga2qoNJ
	 cEd9VArd7/6qSHAnXVicZK/5NTluJKQHYs1IbbsLZHhiPOhY/p4HtdHzKDUUMIV87xuWg
	 mHR4aC76saqFPetlq3lZd9s+HEMAL9RHOIC/b+Fisj1RDtTA77sjHMcJQG67L0inLBjQ7
	 FR6SWSebRPDQiWPJdYxFIVwoSnv/IIUHSfAxbSTE06svm2N5Ditd1YUdqElYc4fd00A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794619757;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=61mDStsFc8kSAWnJYD+aidfsOroTTCmzZpuk8Z8MBn0=;
	b=ObVEyTPkX88ETqTuPO/vEjrBzeG3MyIuNpyVlm/tW8WMzwkm2vLC8vV5aF5eSX/se/9s
	 O7TzdULFjbxWChWKlXZNhM6xt8OsIynztmg7+QGgrmkAqo64OVdWHA7Qaj8cQFHxT1bYE
	 7wZRy4n1acWrwA61e1h2yuQb39P5lhJ72Bf0TZO0P60HrJHTxqSl4P3eDmzrI4f6hPoz3
	 sIxq48PWFmor3ivmPbMI1NgXTrUHzhiJX7KwOEyisj/EGe5BC1xT5krdNBG7BTJb48fE2
	 pS7YBORcuJ8quDKzXCcK523QqzkDewWIZmkq3lLwLSnj5uNJtlDMbrkDvJt567wPAYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Emk4Q9PJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFE1606A323;
	Sat, 14 Nov 2026 01:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Emk4Q9PJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D3B51F000C4;
	Sat, 14 Nov 2026 01:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794619756;
	bh=61mDStsFc8kSAWnJYD+aidfsOroTTCmzZpuk8Z8MBn0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Emk4Q9PJhTQw1cheHmtHaaOVxNyXVrRsGDpCbt0SzzBSWJAFIPRnEieLY6Xxt+ulE
	 EpNkksHVRRiPizOpXpSm2k0v68fACSB+30dQGn5zUosjSKePbR+AH//J5z7kUu+mDh
	 JAlrKIlPQNZ6ImtqabIhwf9bNqy/pGhXzo7wTQtwSFWBPbliKnMOT3GP32Idl2ig9E
	 YNQ7wJ1oDTeB94lqTg3hfglggHPcJsqBHc9uZyxNFz3B4vUN8KGacLxkXqmSwCntKv
	 K+/yKRq+c1TKPJiue0mHdNKJE+t6lnNduy9p+wwd1YkoLIA/L3Os8qncjIa8+U4yhK
	 GwxuxWvrilLcQ==
Date: Sat, 14 Nov 2026 01:29:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Patrick Fischer via B4 Relay
 <devnull+admin.tsv-stahl-riesa.de@kernel.org>
Cc: admin@tsv-stahl-riesa.de, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Kevin Tsai
 <ktsai@capellamicro.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: light: Add Capella CM3217 ambient light
 sensor driver
Message-ID: <20261114012906.6f66edce@jic23-hlaptop>
In-Reply-To: <20261113-upstream-iio-cm3217-v3-2-c4d5b2485dff@tsv-stahl-riesa.de>
References: <20261113-upstream-iio-cm3217-v3-0-c4d5b2485dff@tsv-stahl-riesa.de>
	<20261113-upstream-iio-cm3217-v3-2-c4d5b2485dff@tsv-stahl-riesa.de>
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
Content-Transfer-Encoding: 7bit

On Fri, 13 Nov 2026 20:59:00 +0100
Patrick Fischer via B4 Relay <devnull+admin.tsv-stahl-riesa.de@kernel.org> wrote:

> From: Patrick Fischer <admin@tsv-stahl-riesa.de>
> 
> The CM3217 has no registers and no ID. Writing a byte to address 0x10
> or 0x11 sets command byte 1 or 2, reading a byte from 0x10 or 0x11
> returns the high or low byte of the 16-bit light count. The driver
> takes the second address from the second reg entry and falls back to
> 0x11 when there is no firmware node, as with new_device.
> 
> Command byte 1 holds the shutdown bit and the IT_T field (1/2 T, 1 T,
> 2 T or 4 T), command byte 2 the FD_IT field (800 ms down to 66 ms). The
> count scales linearly with both. The driver exposes FD_IT as the
> integration time and IT_T through the scale, so the scale list offers
> four ranges for each integration time.
> 
> The datasheet is not public. The bit fields, the reserved bits that are
> written as 1 and the startup setting of 2 T and 100 ms come from NVIDIA's
> downstream drivers (drivers/staging/iio/light/cm3217.c in the 3.4 kernel
> rel-tegranote-r8 and the 3.10 kernel
> android-tegra-flounder-3.10-nougat-mr1.1). One value differs: the vendor
> header defines 4 T as 4 << 2, which is outside the two-bit field. On a
> Tegra Note 7 field value 3 gave four times the 1 T count, so the driver
> uses that. For the resolution, Capella
> gives a range of 0.01875 to 119156 lux. The driver takes 0.01875 lux
> per count at 4 T and 800 ms. This matches both the upper end (65535
> counts at 1/2 T and 66 ms) and the 0.3 lux per count that the NVIDIA
> 3.4 driver uses at 2 T and 100 ms.
> 
> The sensor has no data-ready flag, and a new setting only takes effect
> when the conversion in progress ends. A conversion takes IT_T times
> FD_IT, up to 3.2 s. Leaving shutdown starts a new one at once, so the
> driver passes through shutdown on every change and waits one conversion
> period plus a margin before it reads the count. The timing was measured
> on a Tegra Note 7.
> 
> Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Tegratab P1988
> Signed-off-by: Patrick Fischer <admin@tsv-stahl-riesa.de>
Hi Patrick

One small thing about how you are handling the firmware absent case.

Thanks,

Jonathan

> diff --git a/drivers/iio/light/cm3217.c b/drivers/iio/light/cm3217.c
> new file mode 100644
> index 000000000000..0c2c7f9d7d69
> --- /dev/null
> +++ b/drivers/iio/light/cm3217.c
> @@ -0,0 +1,419 @@

> +
> +static int cm3217_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct cm3217_data *data;
> +	struct iio_dev *indio_dev;
> +	u16 addr_lsb = CM3217_ADDR_CMD2_LSB;
> +	u32 reg[2];
> +	u8 cmd1, cmd2;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	data->client = client;
> +	i2c_set_clientdata(client, indio_dev);
> +
> +	ret = devm_mutex_init(dev, &data->lock);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to enable vdd supply\n");
> +
> +	/* Without a firmware node (e.g. sysfs new_device) use the fixed one */

I'd rather we handled that explicitly.

	if (dev_fwmode(dev))

That way we can return an error if there is firmware but it's broken.

> +	if (!device_property_read_u32_array(dev, "reg", reg, ARRAY_SIZE(reg)))
> +		addr_lsb = reg[1];

