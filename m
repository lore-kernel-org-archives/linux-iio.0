Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.232.247.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794818391;
	b=HxTeJqGr/rGBgYxqgobs3d/0BOJy+NdFBoGQRBi/c8rBsXiqdaR/JiBfO+2ZWvhtymNf
	 9LcOuG8fg+fUfroArpnHvsn0PRG8PyFnG0IoLw+RlMrhgaVDD2ykHLzhcmDpnK+qrHfVT
	 lRamEC7AbmM2bYOmIF1sWoul8ZyXEDe8H3UbV+6/MM2wmE/g6B5ixbG6Ejvttg+alEuak
	 N3VHu0gVF/j1Bp3xH6Xfs6/9THBSzoq94HTO7R+lSfLgP0J3nKnjxYbL6ubSHdD2bWeJz
	 GFMbU04mOwHJumlg96uS+umyIFPCY/iwjFj+L09DeV9MJfmA9Og2gAAerj5IQmTT68A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794818391;
	h=DMARC-Filter:Received:Received:Received:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-ID:Subject:From:
	 To:CC:X-Mailer:References:In-Reply-To:X-Originating-IP:
	 X-ClientProxiedBy:X-FEAS-BEC-Info:X-FEAS-Client-IP:
	 X-FE-Last-Public-Client-IP:X-FE-Policy-ID:X-FE-Hostname:
	 DKIM-Signature;
	bh=jk8S6zm+nkol5uqf/eF0yM1FdYjVHlezq8oEpC2nPXM=;
	b=poSyImHq5m9oTbT7CiimKcOZkIq6CCpCMY2WZwmPVXbIU8T+AuoJRPqOLN9kq+18mtG3
	 G4eEXmNUyUOCpcXWnOvhCCadTCfig6Oa7yUgHEPzdi2dnLD92SLZe0wGhKEW+cPe3mlYy
	 Q+iO//5vkHp7d68+I2yocQ+ygR37DbfsJ4eLhZhh+1jzaAoFnS/gHUzmKwoCCvNodpz+A
	 gUy+AsxCCBaeWO+UHxrpbVRjKmPtAUTwJ7PNsRpC6JUKB2d2gpsgS9Kt8DKxKobyCHwC5
	 1TAoOStjWUatQlWw7NijDeiO9dlzNcJ4o6NBR06ip888DsjoOt1XuynnlNzjJbeYxrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=utu.fi;
	spf=pass smtp.mailfrom=utu.fi;
	dkim=pass header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=O0PG8EOo;
	arc=none smtp.remote-ip=130.232.247.4
Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FF9606A31C;
	Mon, 16 Nov 2026 08:39:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04FF9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=O0PG8EOo
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 6AG8dCRx023350-6AG8dCS1023350
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 16 Nov 2026 10:39:12 +0200
Received: from ex19-16.utu.fi ([130.232.247.56])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <jaakko.ma.koivisto@utu.fi>)
	id 1xSsF6-00HaY6-2w;
	Mon, 16 Nov 2026 10:39:12 +0200
Received: from localhost (91.145.105.139) by ex19-16.utu.fi (130.232.247.56)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 10:39:11 +0200
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 16 Nov 2026 10:39:11 +0200
Message-ID: <DMWI07YONKKS.1UI59C2I60ONX@utu.fi>
Subject: Re: [PATCH v2 3/5] iio: chemical: sgp40: Implement
 get_serial_number-command
From: Jaakko Koivisto <jmatko@utu.fi>
To: Joshua Crofts <crofts@kernel.org>, Jaakko Koivisto <jmatko@utu.fi>
CC: Andreas Klinger <ak@it-klinger.de>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261102091258.247402-1-jmatko@utu.fi>
 <20261102091258.247402-4-jmatko@utu.fi>
 <20261102112020.00007167@kernel.org>
In-Reply-To: <20261102112020.00007167@kernel.org>
X-ClientProxiedBy: ex19-15.utu.fi (130.232.247.55) To ex19-16.utu.fi
 (130.232.247.56)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFpdSAIJCQMDB0YFCUYDBwEeARscBygdHB1GDgFIWUhZX0gLGgcO
 HBsoAw0aBg0ERgcaD0hYSFpIWVxIWVtYRlpbWkZaWF9GXF9IUEhYSFhIXUhYSFhIWEhZXkgJAygBHEUDBAEGDw0aRgwNSFhIWV1ICQYMESgDDRoGDQRGBxoPSFhIWllI
 DAQNCwAGDRooCgkRBAEKGg1GCwcFSFhIWl1IBAEGHRBFAQEHKB4PDRpGAw0aBg0ERgcaD0hYSFlQSAYdBgdGGwkoCQYJBAcPRgsHBUhY
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=mime-version:content-type:date:message-id:subject:from:to:cc:references;
 bh=jk8S6zm+nkol5uqf/eF0yM1FdYjVHlezq8oEpC2nPXM=;
 b=O0PG8EOoKTeJWxDYchUMhjRD0eoRGjvJ9tJBfgt8Kp7Y7Pe0L2lBB2KVnWe2MiXdN5P2A0rchE3k
	3bflUoGg+z74TLKqPtVVlGx+rOpWErF8pwIo4iJ7x96Iy4qfjg5M+uqbQFkYsKnJNI7f09TRpPNq
	cM1+YZuKbMtLWNWqIiojCU5mSM6cFjqwPD1MJDAJ4o0Pxi2Q9/w0tJkoClUNq0EBqlJ3BbBM+gzv
	dmKRmTme5Q8EyYPg4golg07Sl0TUubFP939DiAlpUd3nQxqM4OG+W716N7YOMwrr1fyQvmmcNt4U
	R5z09ih2l0dJA87ZSWDz9rusj1107taMj/jvxQ==

On Mon Nov 2, 2026 at 12:20 PM EET, Joshua Crofts wrote:
> On Mon, 2 Nov 2026 11:12:56 +0200
> Jaakko Koivisto <jmatko@utu.fi> wrote:
>
>> Add functionality for retrieving SGP40 sensor serial number
>> and present it to the userspace using serialnumber ABI.
>>=20
>> Signed-off-by: Jaakko Koivisto <jmatko@utu.fi>
>> ---
>> Currently only the bno055 driver uses the serialnumber ABI, and presents
>> the SN in hex. Documentation gives hex output as example format, not har=
d
>> requirement, but should we use the same format here anyway?
>>=20
>>  drivers/iio/chemical/sgp40.c | 76 ++++++++++++++++++++++++++++++++++++
>>  1 file changed, 76 insertions(+)
>>=20
>> diff --git a/drivers/iio/chemical/sgp40.c b/drivers/iio/chemical/sgp40.c
>> index 080d51f9f53c..e0a300720fce 100644
>> --- a/drivers/iio/chemical/sgp40.c
>> +++ b/drivers/iio/chemical/sgp40.c
>> @@ -35,6 +35,7 @@
>>  #include <linux/mutex.h>
>>  #include <linux/i2c.h>
>>  #include <linux/iio/iio.h>
>> +#include <linux/iio/sysfs.h>
>
> Could you add an additional patch to your series adding any
> missing includes? Just looking at this patch I can see that
> types.h, asm/byteorder.h and delay.h are missing.
>

I can do that. Small question, is it ok to leave compiler_attributes.h and =
stddef.h
out? Former one is not included in any IIO drivers and the latter one only
in three drivers.

>>
>>  /*
>>   * floating point calculation of voc is done as integer
>> @@ -70,6 +71,18 @@ struct sgp40_tg_result {
>>  	u8	res_crc;
>>  } __packed;
>> =20
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
>>  static const struct iio_chan_spec sgp40_channels[] =3D {
>>  	{
>>  		.type =3D IIO_CONCENTRATION,
>> @@ -161,6 +174,41 @@ static int sgp40_calc_voc(struct sgp40_data *data, =
u16 resistance_raw, int *voc)
>>  	return 0;
>>  }
>> =20
>> +static int sgp40_get_serial_number(struct sgp40_data *data, u64 *serial=
_number)
>> +{
>> +	int ret;
>> +	struct i2c_client *client =3D data->client;
>> +	struct sgp40_tg_measure get_sn =3D { .command =3D {0x36, 0x82} };
>> +	struct sgp40_serial_number_result res;
>
> Reverse xmas tree order.
>

Will fix for v3.

>> +
>> +	guard(mutex)(&data->lock);
>> +
>> +	ret =3D i2c_master_send(client, (char *)&get_sn, sizeof(get_sn.command=
));
>> +	if (ret < 0)
>> +		return ret;
>> +	if (ret !=3D sizeof(get_sn.command))
>> +		return dev_err_probe(data->dev, -EIO,
>
> Sashiko points out that this function isn't called from probe(),
> therefore it shouldn't use dev_err_probe().
>

From the dev_err_probe() documentation I got the impression that using
it is allowed outside probe() and even if the return is never
-EPROBE_DEFER, just to condense the "dev_err(); return ret;" into single
line and also take advantage of the prettier error formatting of dev_err_pr=
obe().

If this is not the case I can change back to dev_err().

> Also, you can use a local variable for dev.
>

Will fix for v3.

>> +		       "i2c_master_send ret: %d, expected %zu\n", ret, sizeof(get_sn.=
command));
>> +
>> +	fsleep(1000); /* Max duration for get_serial_number command. Datasheet=
 table 8. */
>> +
>> +	ret =3D i2c_master_recv(client, (char *)&res, sizeof(res));
>> +	if (ret < 0)
>> +		return ret;
>> +	if (ret !=3D sizeof(res))
>> +		return dev_err_probe(data->dev, -EIO,
>> +		       "i2c_master_recv ret: %d, expected: %zu\n", ret, sizeof(res));
>> +
>> +	if (crc8(sgp40_crc8_table, (u8 *)&res.A, 2, SGP40_CRC8_INIT) !=3D res.=
A_crc ||
>> +	    crc8(sgp40_crc8_table, (u8 *)&res.B, 2, SGP40_CRC8_INIT) !=3D res.=
B_crc ||
>> +	    crc8(sgp40_crc8_table, (u8 *)&res.C, 2, SGP40_CRC8_INIT) !=3D res.=
C_crc)
>> +		return dev_err_probe(data->dev, -EIO, "CRC error in get_serial_number=
\n");
>> +
>> +	*serial_number =3D ((u64)be16_to_cpu(res.A) << 32) | ((u64)be16_to_cpu=
(res.B) << 16) | (u64)be16_to_cpu(res.C);
>> +	return 0;
>> +}
>> +
>>  static int sgp40_measure_resistance_raw(struct sgp40_data *data, u16 *r=
esistance_raw)
>>  {
>>  	int ret;
>> @@ -306,9 +354,37 @@ static int sgp40_write_raw(struct iio_dev *indio_de=
v,
>>  	return -EINVAL;
>>  }
>> =20
>> +static ssize_t serialnumber_show(struct device *dev,
>> +				  struct device_attribute *attr,
>> +				  char *buf)
>> +{
>> +	int ret;
>> +	u64 serial_number;
>> +	struct sgp40_data *data =3D iio_priv(dev_to_iio_dev(dev));
>
> Reverse xmas tree.
>
> ...


