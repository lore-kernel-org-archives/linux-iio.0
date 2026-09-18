Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BB43112AB
	for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2026 14:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789741595; cv=none; b=I9kMaLySEKLtyC5NAm+sC/XdX46L2qs9SNyohUlz4oD75v84h9DbFza36TmMJK51So5Jx1CPAjv0CSDpim4qQ2vwkHkrVUb08L0mBNANA6R0HkG1r/cgQYfqHJFkmEr7uco4EpMKcX38tSCavZBJajLK2jlLJtMOH6Z/nhX/rtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789741595; c=relaxed/simple;
	bh=V/ao0xgrL052+a77Zs37pNAkv8uUAgXm6H+hU649GVA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:In-Reply-To:Subject:
	 From:To:References; b=ns7a1f/1fC8FU+jCZnAg1nMdsRRUWxa0QEHPUGt228zHT6iv9bA/fSLDf9wR95fnC5EAcziOD8xu/dByCvxS2wa0HXk+QeUi0hiBFjOjeMy/ozqrCvRQwq+avDgAvlOu3NRxIwiSbL8Pe4ZXxP1jtN7IezaGw7eYMFqRPPRxAQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxwelld.cc; spf=pass smtp.mailfrom=maxwelld.cc; dkim=pass (2048-bit key) header.d=maxwelld.cc header.i=@maxwelld.cc header.b=AtF6Oa1s; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=ED4xUpx2; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxwelld.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxwelld.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxwelld.cc header.i=@maxwelld.cc header.b="AtF6Oa1s";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="ED4xUpx2"
DKIM-Signature: a=rsa-sha256; b=AtF6Oa1s/AL2tmQTFwmhbhlh/8MOdpMs8SUG6UZTZYISeQJ/ayQcdGgRWU2djKsKNrX6mMAlvgfsAosXfH0wLl2engdC7HQdXbV90KTqwIjvnZPVZ6uumYWSAEZmidY9fdLKY5po0q4Pq9MOLumlS2IPu0gQhnKTqNw3+cnfimIvRVHkNNUd/TgLWWdIEoRa7aECaQWMvPDdbfABMfHhC3SRAMyTb0Ilbug9LR4+zB+t1NfZQVVPFzIjgGx0RuyuP/Ho6qVURB5rtise/aiF/OXLHgb/mfqNgpPRP4/T0TmFbtT/d22WqTR1X2se8UIkdNLMj/tJKBGYVaanq18HFg==; s=purelymail2; d=maxwelld.cc; v=1; bh=V/ao0xgrL052+a77Zs37pNAkv8uUAgXm6H+hU649GVA=; h=Received:Date:Subject:From:To;
DKIM-Signature: a=rsa-sha256; b=ED4xUpx2J63TAftELukA7kr8PI3mk3R0lFd5SnAegjO9DChMy1EK8tueJw8/fKfMXL5F9MUMGoiYgFjEz2olnsImSCQFk9MUwNq9uIRVkNP46iCxz4FW0vC/lr8JPjxRFbJLsa+Hb/28BABjghUEt0kmocrayQXg4lvXxeIHeRa2gyNwY7SPT+gRgNzWifIr8QLw/Z/QHIdT2AFVYLOTWgeZEkcxSDOr0+ZaEPvdxhDzex7wHs8IOck/g98/iChe54dic8yckhX1ZBPOzDtTv9XSPsZ4mNaGaPrFXkMy59ebhlvXZyfnW7hV9NtvtSQ213Qirnn93LtsUVBAu/9rzg==; s=purelymail2; d=purelymail.com; v=1; bh=V/ao0xgrL052+a77Zs37pNAkv8uUAgXm6H+hU649GVA=; h=Feedback-ID:Received:Date:Subject:From:To;
Feedback-ID: 1013395:40550:null:purelymail
X-Pm-Original-To: linux-iio@vger.kernel.org
Authentication-Results: purelymail.com; auth=pass
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -954385832;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 18 Sep 2026 14:26:06 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 18 Sep 2026 09:26:04 -0500
Message-Id: <DLIIFO80EL2F.1KMD8IOGGTS1Y@maxwelld.cc>
Cc: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20260918134019.1101308-2-jmatko@utu.fi>
Subject: Re: [PATCH 1/3] iio: chemical: sgp40: Implement
 get_serial_number-command
From: "Maxwell Doose" <maxwell@maxwelld.cc>
To: "Jaakko Koivisto" <jmatko@utu.fi>, "Andreas Klinger" <ak@it-klinger.de>,
 "Jonathan Cameron" <jic23@kernel.org>, "David Lechner"
 <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260918134019.1101308-1-jmatko@utu.fi>
 <20260918134019.1101308-2-jmatko@utu.fi>

Hi there Jaakko,

Firstly a (rather important) question I have is what's the point? I'm
not sure that anyone will need the serial number on the fly (assuming a
business would be using this, they will likely keep records of their
parts). Though maybe I could be wrong (so feel free to prove me wrong).

On Fri Sep 18, 2026 at 8:40 AM CDT
Jaakko Koivisto <jmatko@utu.fi> wrote:

> -Retrieve the chip serial number.
> -Present the serial number to userspace as device attribute.
> -Rename the tg_measure -struct now that is is used for multiple
> commands.
>

Last one should be left out and put in a separate patch.

Also, commit message needs a bit of work, something like:
	"Add support to the SGP40 driver to enable retrieval of the
	serial number from the chip and add new sysfs attribute to
	expose the serial number to userspace."

> Signed-off-by: Jaakko Koivisto <jmatko@utu.fi>
> ---
>  drivers/iio/chemical/sgp40.c | 78 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 76 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/chemical/sgp40.c b/drivers/iio/chemical/sgp40.c
> index b2b5e32a9eb2..c1e2a992ec2a 100644
> --- a/drivers/iio/chemical/sgp40.c
> +++ b/drivers/iio/chemical/sgp40.c
> @@ -35,6 +35,7 @@
>  #include <linux/mutex.h>
>  #include <linux/i2c.h>
>  #include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> =20
>  /*
>   * floating point calculation of voc is done as integer
> @@ -53,11 +54,12 @@ struct sgp40_data {
>  	int			rht;
>  	int			temp;
>  	int			res_calibbias;
> +	u64			serial_number;
>  	/* Prevent concurrent access to rht, tmp, calibbias */
>  	struct mutex		lock;
>  };
> =20
> -struct sgp40_tg_measure {
> +struct sgp40_command {
>  	u8	command[2];
>  	__be16	rht_ticks;
>  	u8	rht_crc;
> @@ -70,6 +72,18 @@ struct sgp40_tg_result {
>  	u8	res_crc;
>  } __packed;
> =20

Name change should be put in a different patch or just left out
entirely.

> +/*
> + * Datasheet table 16. Serial number is given as 48-bit value 0xAAAABBBB=
CCCC.
> + */
> +struct sgp40_serial_number_result {
> +	__be16	A;
> +	u8	A_crc;
> +	__be16	B;
> +	u8	B_crc;
> +	__be16	C;
> +	u8	C_crc;
> +} __packed;
> +

Perhaps this but maybe this could be implemented as an
annonymous struct instead.

>  static const struct iio_chan_spec sgp40_channels[] =3D {
>  	{
>  		.type =3D IIO_CONCENTRATION,
> @@ -162,6 +176,40 @@ static int sgp40_calc_voc(struct sgp40_data *data, u=
16 resistance_raw, int *voc)
>  	return 0;
>  }
> =20
> +static int sgp40_get_serial_number(struct sgp40_data *data)
> +{
> +	int ret;
> +	struct i2c_client *client =3D data->client;
> +	struct sgp40_command get_sn =3D {.command =3D {0x36, 0x82}};
> +	struct sgp40_serial_number_result res;
> +
> +	ret =3D i2c_master_send(client, (char*)&get_sn, sizeof(get_sn.command))=
;
> +	if (ret !=3D sizeof(get_sn.command)) {
> +		dev_err(data->dev, "i2c_master_send ret: %d, expected %zu", ret, sizeo=
f(get_sn.command));

Missing '\n' here (sashiko).

> +		return -EIO;
> +	}
> +	msleep(1);
> +	ret =3D i2c_master_recv(client, (char*)&res, sizeof(res));
> +	if (ret < 0)
> +		return ret;
> +	if (ret !=3D sizeof(res)) {
> +		dev_err(data->dev, "i2c_master_recv ret: %d, expected: %zu", ret, size=
of(res));
> +		return -EIO;
> +	}
> +
> +	if (crc8(sgp40_crc8_table, (u8*)&res.A, 2, SGP40_CRC8_INIT) !=3D res.A_=
crc ||
> +	    crc8(sgp40_crc8_table, (u8*)&res.B, 2, SGP40_CRC8_INIT) !=3D res.B_=
crc ||
> +	    crc8(sgp40_crc8_table, (u8*)&res.C, 2, SGP40_CRC8_INIT) !=3D res.C_=
crc)
> +	{
> +		dev_warn(data->dev, "CRC error in get_serial_number");

Probably should return either -EIO or -EREMOTEIO here (sashiko).

> +	}
> +
> +	data->serial_number =3D 0LL | ((u64)be16_to_cpu(res.A) << 32) | ((u64)b=
e16_to_cpu(res.B) << 16) | (u64)be16_to_cpu(res.C);
> +	dev_dbg(data->dev, "serial number: %llu", data->serial_number);
> +
> +	return 0;
> +}
> +
>  static int sgp40_measure_resistance_raw(struct sgp40_data *data, u16 *re=
sistance_raw)
>  {
>  	int ret;
> @@ -169,7 +217,7 @@ static int sgp40_measure_resistance_raw(struct sgp40_=
data *data, u16 *resistance
>  	u32 ticks;
>  	u16 ticks16;
>  	u8 crc;
> -	struct sgp40_tg_measure tg =3D {.command =3D {0x26, 0x0F}};
> +	struct sgp40_command tg =3D {.command =3D {0x26, 0x0F}};
>  	struct sgp40_tg_result tgres;
> =20
>  	mutex_lock(&data->lock);
> @@ -311,9 +359,31 @@ static int sgp40_write_raw(struct iio_dev *indio_dev=
,
>  	return -EINVAL;
>  }
> =20
> +static ssize_t serial_number_show(struct device *dev,
> +				  struct device_attribute *attr,
> +				  char *buf)
> +{
> +	struct sgp40_data *data =3D iio_priv(dev_to_iio_dev(dev));
> +
> +	return sysfs_emit_at(buf, 0, "%llu\n", data->serial_number);
> +}
> +
> +static IIO_DEVICE_ATTR_RO(serial_number, 0);
> +
> +static struct attribute *sgp40_attributes[] =3D {
> +	&iio_dev_attr_serial_number.dev_attr.attr,
> +	NULL
> +};
> +
> +static struct attribute_group sgp40_attribute_group =3D {
> +	.attrs =3D sgp40_attributes,
> +};
> +
> +
>  static const struct iio_info sgp40_info =3D {
>  	.read_raw	=3D sgp40_read_raw,
>  	.write_raw	=3D sgp40_write_raw,
> +	.attrs		=3D &sgp40_attribute_group,
>  };
> =20
>  static int sgp40_probe(struct i2c_client *client)
> @@ -347,6 +417,10 @@ static int sgp40_probe(struct i2c_client *client)
>  	indio_dev->channels =3D sgp40_channels;
>  	indio_dev->num_channels =3D ARRAY_SIZE(sgp40_channels);
> =20
> +	ret =3D sgp40_get_serial_number(data);
> +	if (ret)
> +		dev_warn(dev, "failed to retrieve device serial number\n");
> +
>  	ret =3D devm_iio_device_register(dev, indio_dev);
>  	if (ret)
>  		dev_err(dev, "failed to register iio device\n");

