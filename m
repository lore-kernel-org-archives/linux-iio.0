Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A759455628;
	Thu, 24 Sep 2026 08:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790240356; cv=none; b=PpH4DM5J+60J+575Lnxi7i3gfVsannTleKLVy2vje0F2FftF10fyOlmx2bNvst7xMvJmiv9F00t1NrymTXP2tfwV8OZKkEBBM45PyKt7JaM1KPS43JXAXgVk2Z3UL31R5by8soVH6/KHMhBhpd1JDQKeS5hqVHIMSlhaozb8Ue0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790240356; c=relaxed/simple;
	bh=VHibqWlf+1wve5bTObRNFDyfjCnxWeMVO5li8BQcMCw=;
	h=MIME-Version:Content-Type:Date:Message-ID:Subject:From:To:CC:
	 References:In-Reply-To; b=tpXfu8QtNocsWUOb0YHEt+NromzxyyzWGspSbyeTBCspONQbUWZzA7IlfKA3BG05bBLw+zPwTb6HfSO8qcehinsFMYmDWbf/oFqruKOMY2pbhag7fSTI17eqlQVVYLkJKwhKCiwK7uuRAE+MS7+r15LMvpFZch2SOpK9bywMAAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=AUn45MSR; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="AUn45MSR"
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 68O8wmKP032540-68O8wmKR032540
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 24 Sep 2026 11:58:48 +0300
Received: from ex19-16.utu.fi ([130.232.247.56])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <jaakko.ma.koivisto@utu.fi>)
	id 1x9fI0-00ElVB-LL;
	Thu, 24 Sep 2026 11:58:48 +0300
Received: from localhost (91.145.105.139) by ex19-16.utu.fi (130.232.247.56)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 11:58:48 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 24 Sep 2026 11:58:48 +0300
Message-ID: <DLNF8D1XG692.1R39DIMKT9QUB@utu.fi>
Subject: Re: [PATCH 1/3] iio: chemical: sgp40: Implement
 get_serial_number-command
From: Jaakko Koivisto <jmatko@utu.fi>
To: Maxwell Doose <maxwell@maxwelld.cc>, Jaakko Koivisto <jmatko@utu.fi>,
	Andreas Klinger <ak@it-klinger.de>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260918134019.1101308-1-jmatko@utu.fi>
 <20260918134019.1101308-2-jmatko@utu.fi>
 <DLIIFO80EL2F.1KMD8IOGGTS1Y@maxwelld.cc>
In-Reply-To: <DLIIFO80EL2F.1KMD8IOGGTS1Y@maxwelld.cc>
X-ClientProxiedBy: ex19-11.utu.fi (130.232.247.51) To ex19-16.utu.fi
 (130.232.247.56)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFpdSAIJCQMDB0YFCUYDBwEeARscBygdHB1GDgFIWUhZUUgFCRAf
 DQQEKAUJEB8NBAQMRgsLSFhIWkhZXEhZW1hGWltaRlpYX0ZcX0hQSFhIWEheSFhIWEhYSFleSAkDKAEcRQMEAQYPDRpGDA1IWEhZXUgJBgwRKAMNGgYNBEYHGg9IWEha
 WUgMBA0LAAYNGigKCREEAQoaDUYLBwVIWEhaXUgEAQYdEEUBAQcoHg8NGkYDDRoGDQRGBxoPSFhIWVFIBQkQHw0EBCgFCRAfDQQEDEYLC0hYSFlQSAYdBgdGGwkoCQYJ
 BAcPRgsHBUhY
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=mime-version:content-type:date:message-id:subject:from:to:cc:references;
 bh=Yl3tknpyvbkMt8BInGbwUZsKtOz7bMcJph80YKlZ9EA=;
 b=AUn45MSRFL7bAp4KMj0YLbfEgtMUTcySqBtWoq9UnwygNjbFfZCRqhWucixn9wUu7TkcIB/5hnep
	cxACZI4GIsePRYsgBuWTBUFO7phxm17y/h5vn0usvxb0gsMOn7tEorhRoA28kRdcVkkgspdTRdxd
	LI9kIEU3esdhtD9yUMlevuxJ21xZZyv8RbBRsbqHLFCLPVXb6DTrmCV9c9rGHuVoYLbn+CuuPoWt
	4rcc0xyfRiIBXcrOJzTo5ux7aeezs9JUV4vkPxstu7V/dugbuuJH4GQk/kahZ7/hxwQS037JMxJL
	smi3ANg026U6wolXGpbHQhzN59l/p7QY3XBlRw==

On Fri Sep 18, 2026 at 5:26 PM EEST, Maxwell Doose wrote:
> Hi there Jaakko,
>
> Firstly a (rather important) question I have is what's the point? I'm
> not sure that anyone will need the serial number on the fly (assuming a
> business would be using this, they will likely keep records of their
> parts). Though maybe I could be wrong (so feel free to prove me wrong).

I agree that everybody should keep accurate records. Whether or not they
do, and those records are fast and easy to access, is another question.
Stuff like this gets lost in company mergers, or the records are
buried somewhere in manufacturing department archives.
I don't see the downside in having fast and easy way to, for example,
check that the records are in fact correct.

You are probably correct that it won't be called for often. Saving the
serial number to driver data is probably overkill, and better to just
read it when requested. Would remove one variable and less code in
probe()-function.

>
> On Fri Sep 18, 2026 at 8:40 AM CDT
> Jaakko Koivisto <jmatko@utu.fi> wrote:
>
>> -Retrieve the chip serial number.
>> -Present the serial number to userspace as device attribute.
>> -Rename the tg_measure -struct now that is is used for multiple
>> commands.
>>
>
> Last one should be left out and put in a separate patch.
>

Probably best to leave it out, not strictly necessary.

>
> Also, commit message needs a bit of work, something like:
> 	"Add support to the SGP40 driver to enable retrieval of the
> 	serial number from the chip and add new sysfs attribute to
> 	expose the serial number to userspace."
>

Thanks, I'll improve it for v2.

>> Signed-off-by: Jaakko Koivisto <jmatko@utu.fi>
>> ---
>>  drivers/iio/chemical/sgp40.c | 78 +++++++++++++++++++++++++++++++++++-
>>  1 file changed, 76 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iio/chemical/sgp40.c b/drivers/iio/chemical/sgp40.c
>> index b2b5e32a9eb2..c1e2a992ec2a 100644
>> --- a/drivers/iio/chemical/sgp40.c
>> +++ b/drivers/iio/chemical/sgp40.c
>> @@ -35,6 +35,7 @@
>>  #include <linux/mutex.h>
>>  #include <linux/i2c.h>
>>  #include <linux/iio/iio.h>
>> +#include <linux/iio/sysfs.h>
>> =20
>>  /*
>>   * floating point calculation of voc is done as integer
>> @@ -53,11 +54,12 @@ struct sgp40_data {
>>  	int			rht;
>>  	int			temp;
>>  	int			res_calibbias;
>> +	u64			serial_number;
>>  	/* Prevent concurrent access to rht, tmp, calibbias */
>>  	struct mutex		lock;
>>  };
>> =20
>> -struct sgp40_tg_measure {
>> +struct sgp40_command {
>>  	u8	command[2];
>>  	__be16	rht_ticks;
>>  	u8	rht_crc;
>> @@ -70,6 +72,18 @@ struct sgp40_tg_result {
>>  	u8	res_crc;
>>  } __packed;
>> =20
>
> Name change should be put in a different patch or just left out
> entirely.
>

I'll leave it out.

>
>> +/*
>> + * Datasheet table 16. Serial number is given as 48-bit value 0xAAAABBB=
BCCCC.
>> + */
>> +struct sgp40_serial_number_result {
>> +	__be16	A;
>> +	u8	A_crc;
>> +	__be16	B;
>> +	u8	B_crc;
>> +	__be16	C;
>> +	u8	C_crc;
>> +} __packed;
>> +
>
> Perhaps this but maybe this could be implemented as an
> annonymous struct instead.
>

This I would like to leave as it is in order to have all the command
and result structs follow the same pattern as the already existing
sgp40_tg_result and sgp40_tg_measure.

>>  static const struct iio_chan_spec sgp40_channels[] =3D {
>>  	{
>>  		.type =3D IIO_CONCENTRATION,
>> @@ -162,6 +176,40 @@ static int sgp40_calc_voc(struct sgp40_data *data, =
u16 resistance_raw, int *voc)
>>  	return 0;
>>  }
>> =20
>> +static int sgp40_get_serial_number(struct sgp40_data *data)
>> +{
>> +	int ret;
>> +	struct i2c_client *client =3D data->client;
>> +	struct sgp40_command get_sn =3D {.command =3D {0x36, 0x82}};
>> +	struct sgp40_serial_number_result res;
>> +
>> +	ret =3D i2c_master_send(client, (char*)&get_sn, sizeof(get_sn.command)=
);
>> +	if (ret !=3D sizeof(get_sn.command)) {
>> +		dev_err(data->dev, "i2c_master_send ret: %d, expected %zu", ret, size=
of(get_sn.command));
>
> Missing '\n' here (sashiko).

I'll add this and other missing '\n's.

>> +		return -EIO;
>> +	}
>> +	msleep(1);
>> +	ret =3D i2c_master_recv(client, (char*)&res, sizeof(res));
>> +	if (ret < 0)
>> +		return ret;
>> +	if (ret !=3D sizeof(res)) {
>> +		dev_err(data->dev, "i2c_master_recv ret: %d, expected: %zu", ret, siz=
eof(res));
>> +		return -EIO;
>> +	}
>> +
>> +	if (crc8(sgp40_crc8_table, (u8*)&res.A, 2, SGP40_CRC8_INIT) !=3D res.A=
_crc ||
>> +	    crc8(sgp40_crc8_table, (u8*)&res.B, 2, SGP40_CRC8_INIT) !=3D res.B=
_crc ||
>> +	    crc8(sgp40_crc8_table, (u8*)&res.C, 2, SGP40_CRC8_INIT) !=3D res.C=
_crc)
>> +	{
>> +		dev_warn(data->dev, "CRC error in get_serial_number");
>
> Probably should return either -EIO or -EREMOTEIO here (sashiko).
>

Will change for v2.

>> +	}
>> +
>> +	data->serial_number =3D 0LL | ((u64)be16_to_cpu(res.A) << 32) | ((u64)=
be16_to_cpu(res.B) << 16) | (u64)be16_to_cpu(res.C);
>> +	dev_dbg(data->dev, "serial number: %llu", data->serial_number);
>> +
>> +	return 0;
>> +}
>> +
>>  static int sgp40_measure_resistance_raw(struct sgp40_data *data, u16 *r=
esistance_raw)
>>  {
>>  	int ret;
>> @@ -169,7 +217,7 @@ static int sgp40_measure_resistance_raw(struct sgp40=
_data *data, u16 *resistance
>>  	u32 ticks;
>>  	u16 ticks16;
>>  	u8 crc;
>> -	struct sgp40_tg_measure tg =3D {.command =3D {0x26, 0x0F}};
>> +	struct sgp40_command tg =3D {.command =3D {0x26, 0x0F}};
>>  	struct sgp40_tg_result tgres;
>> =20
>>  	mutex_lock(&data->lock);
>> @@ -311,9 +359,31 @@ static int sgp40_write_raw(struct iio_dev *indio_de=
v,
>>  	return -EINVAL;
>>  }
>> =20
>> +static ssize_t serial_number_show(struct device *dev,
>> +				  struct device_attribute *attr,
>> +				  char *buf)
>> +{
>> +	struct sgp40_data *data =3D iio_priv(dev_to_iio_dev(dev));
>> +
>> +	return sysfs_emit_at(buf, 0, "%llu\n", data->serial_number);
>> +}
>> +
>> +static IIO_DEVICE_ATTR_RO(serial_number, 0);
>> +
>> +static struct attribute *sgp40_attributes[] =3D {
>> +	&iio_dev_attr_serial_number.dev_attr.attr,
>> +	NULL
>> +};
>> +
>> +static struct attribute_group sgp40_attribute_group =3D {
>> +	.attrs =3D sgp40_attributes,
>> +};
>> +
>> +
>>  static const struct iio_info sgp40_info =3D {
>>  	.read_raw	=3D sgp40_read_raw,
>>  	.write_raw	=3D sgp40_write_raw,
>> +	.attrs		=3D &sgp40_attribute_group,
>>  };
>> =20
>>  static int sgp40_probe(struct i2c_client *client)
>> @@ -347,6 +417,10 @@ static int sgp40_probe(struct i2c_client *client)
>>  	indio_dev->channels =3D sgp40_channels;
>>  	indio_dev->num_channels =3D ARRAY_SIZE(sgp40_channels);
>> =20
>> +	ret =3D sgp40_get_serial_number(data);
>> +	if (ret)
>> +		dev_warn(dev, "failed to retrieve device serial number\n");
>> +
>>  	ret =3D devm_iio_device_register(dev, indio_dev);
>>  	if (ret)
>>  		dev_err(dev, "failed to register iio device\n");


