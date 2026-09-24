Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EB341F5D1;
	Thu, 24 Sep 2026 08:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790237796; cv=none; b=YAFBb3mxRw45C4B26nflVUsHQC3QKgngmH5Rk/tQRgDtypCOtr1FtyPyN80erHXu8bIvLW+b5scJDhW/biQy1pkWMtzVLvQ8B5u91hRaE8zu2CYEgQK63U5QtUH3XccDQE0Y7s/xBdf5mHgU2CgDdrQlp/NqXnxLspqIhEfZalc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790237796; c=relaxed/simple;
	bh=yPnp7B3hOqvo2b228x3b4tm6Zdv55lWTN9sWUZ8xcF4=;
	h=MIME-Version:Content-Type:Date:Message-ID:To:CC:Subject:From:
	 References:In-Reply-To; b=RCIc9buHljNa3XddBPiy25tabq77lo3OD87AyDwOd87iaL9CDhRO6hkPq0lDfB2q5VY3yqYmeW8VgBo/EQmchIYRrtOcexbXx4vm4M+jWKy3nEiINtJ99cOKa4uAmV78n8zM9V/FhYRRHZRRFk88rMRyIuTjQQcCIwc6RsJQJ5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=ZRBi6It5; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="ZRBi6It5"
Received: from smtp-03.utu.fi (smtp-03.utu.fi [130.232.207.30])
	by fortymile.utu.fi  with ESMTPS id 68O8G9tJ032115-68O8G9tL032115
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 24 Sep 2026 11:16:09 +0300
Received: from ex19-16.utu.fi ([130.232.247.56])
	by smtp-03.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <jaakko.ma.koivisto@utu.fi>)
	id 1x9ecj-00ElSb-IV;
	Thu, 24 Sep 2026 11:16:09 +0300
Received: from localhost (91.145.105.139) by ex19-16.utu.fi (130.232.247.56)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 11:16:09 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 24 Sep 2026 11:16:09 +0300
Message-ID: <DLNEBPFBUOM0.3GKQ8FDOU8YM4@utu.fi>
To: Jonathan Cameron <jic23@kernel.org>, Jaakko Koivisto <jmatko@utu.fi>
CC: Andreas Klinger <ak@it-klinger.de>, David Lechner <dlechner@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] iio: chemical: sgp40: Implement
 execute_self_test-command
From: Jaakko Koivisto <jmatko@utu.fi>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260918134019.1101308-1-jmatko@utu.fi>
 <20260918134019.1101308-3-jmatko@utu.fi>
 <20260920184837.2b2ca5dd@jic23-hlaptop>
In-Reply-To: <20260920184837.2b2ca5dd@jic23-hlaptop>
X-ClientProxiedBy: ex19-13.utu.fi (130.232.247.53) To ex19-16.utu.fi
 (130.232.247.56)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFpdSAIJCQMDB0YFCUYDBwEeARscBygdHB1GDgFIWUhZXkgCAQta
 WygDDRoGDQRGBxoPSFhIWkhZXEhZW1hGWltaRlpYX0ZbWEhQSFhIWEhdSFhIWEhYSFleSAkDKAEcRQMEAQYPDRpGDA1IWEhZXUgJBgwRKAMNGgYNBEYHGg9IWEhaWUgM
 BA0LAAYNGigKCREEAQoaDUYLBwVIWEhaXUgEAQYdEEUBAQcoHg8NGkYDDRoGDQRGBxoPSFhIWVBIBh0GB0YbCSgJBgkEBw9GCwcFSFg=
X-FEAS-Client-IP: 130.232.207.30
X-FE-Last-Public-Client-IP: 130.232.207.30
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=mime-version:content-type:date:message-id:to:cc:subject:from:references;
 bh=udUcuvZYloJrQ68cwrp1WYgft+Rk6ZsfnF3cvtHDUjQ=;
 b=ZRBi6It5D8nC/kKFKvjTTw9PWSRuquKIchGPfLsb5NdMrGEkIvU1yrj/FNtVoUup3fJ6iVjkseIb
	GIFsV1V6C6YbOLNSKAk+/aCOwoJ08AdLqENUIjJPowIhn5w0IMFEVHnpqpuGQNf7s0+cc6GMMA/r
	tl/FgYrOV+dLQg/h///nSATARtKduYGv4vMtaz4LlY2+reXApmCiNNM5tGfEuxy5a1O3NjMqMD6Y
	+w5V46dza0lFEyEibjWrQH+Dv8X+CLOMP8Un4ByvFJGAy9srRbcJbCB6S4q/mZIxZMLxwY2ZKBIc
	iS99+NoYATA2+0SexZ5uungOolM+htwr/5l4rA==

On Sun Sep 20, 2026 at 8:48 PM EEST, Jonathan Cameron wrote:
> On Fri, 18 Sep 2026 16:40:18 +0300
> Jaakko Koivisto <jmatko@utu.fi> wrote:
>
>> -Run the chip self test routine testing heater and MOX -material.
>> -Log error if the test fails.
>>=20
>> Datasheet does not clearly state if the chip is completely unusable if
>> the test fails. Because of this the driver will try to use the chip
>> normally even if the self-test has failed.
>>=20
>> Signed-off-by: Jaakko Koivisto <jmatko@utu.fi>
> Hi Jaakko,
>
> A few things inline,
>
> Thanks,
>
> Jonathan
>
>> ---
>>  drivers/iio/chemical/sgp40.c | 53 ++++++++++++++++++++++++++++++++++++
>>  1 file changed, 53 insertions(+)
>>=20
>> diff --git a/drivers/iio/chemical/sgp40.c b/drivers/iio/chemical/sgp40.c
>> index c1e2a992ec2a..28d5e737d1dc 100644
>> --- a/drivers/iio/chemical/sgp40.c
>> +++ b/drivers/iio/chemical/sgp40.c
>> @@ -84,6 +84,19 @@ struct sgp40_serial_number_result {
>>  	u8	C_crc;
>>  } __packed;
>> =20
>> +/*
>> + * Datasheet table 13.
>> + */
>> +#define SGP40_SELF_TEST_PASS 0xD4
>> +#define SGP40_SELF_TEST_FAIL 0x4B
>> +
>> +struct sgp40_self_test_result {
>> +	u8	data;
>> +	u8	_ignore;
>> +	u8	crc;
>> +} __packed;
>> +
>> +
>>  static const struct iio_chan_spec sgp40_channels[] =3D {
>>  	{
>>  		.type =3D IIO_CONCENTRATION,
>> @@ -210,6 +223,42 @@ static int sgp40_get_serial_number(struct sgp40_dat=
a *data)
>>  	return 0;
>>  }
>> =20
>> +static int sgp40_execute_self_test(struct sgp40_data *data)
>> +{
>> +	int ret;
>> +	struct i2c_client *client =3D data->client;
>> +	struct sgp40_command run_test =3D {.command =3D {0x28, 0x0E}};
>> +	struct sgp40_self_test_result res;
>> +
>> +	ret =3D i2c_master_send(client, (char*)&run_test, sizeof(run_test.comm=
and));
>> +	if (ret !=3D sizeof(run_test.command)) {
>> +		dev_err(data->dev, "i2c_master_send ret: %d, expected %zu", ret, size=
of(run_test.command));
>> +		return -EIO;
> Only called from problem so prefer use of
>
> 		return dev_err_probe().
>
> Also don't eat the error if it returns on (rather than a short access).
>

I will change it, thanks.

>
>> +	}
>> +	msleep(320);
>
> Spec reference needed for any sleep times.
>

It's the maximum time the chip takes to execute the self-test. All
command times are found in datasheet table 8. I'll add a comment here.

>> +
>> +	ret =3D i2c_master_recv(client, (char*)&res, sizeof(res));
>> +	if (ret < 0)
>> +		return ret;
>> +	if (ret !=3D sizeof(res)) {
>> +		dev_err(data->dev, "i2c_master_recv ret: %d, expected: %zu", ret, siz=
eof(res));
>> +		return -EIO;
>
> return dev_err_probe() and don't eat the error return if there is one.

Will change.

>> +	}
>> +
>> +	if (crc8(sgp40_crc8_table, (u8*)&res, 2, SGP40_CRC8_INIT) !=3D res.crc=
) {
>> +		dev_warn(data->dev, "CRC error in execute_self_test");
>
> CRC fail indicates broken comms. I'd fail hard on this one.
>
Ditto.

>> +	}
>> +
>> +	dev_dbg(data->dev, "self test result: 0x%x", res.data);
>> +	switch (res.data) {
>> +		case SGP40_SELF_TEST_PASS:
>> +			return 0;
>> +		case SGP40_SELF_TEST_FAIL:
>> +		default:
>> +			return res.data;
>> +	}
>> +}
>> +
>>  static int sgp40_measure_resistance_raw(struct sgp40_data *data, u16 *r=
esistance_raw)
>>  {
>>  	int ret;
>> @@ -421,6 +470,10 @@ static int sgp40_probe(struct i2c_client *client)
>>  	if (ret)
>>  		dev_warn(dev, "failed to retrieve device serial number\n");
>> =20
>> +	ret =3D sgp40_execute_self_test(data);
>> +	if (ret)
>> +		dev_warn(dev, "device self test failed: ret 0x%x", ret);
>
> There should be a distinction between the test failed to run and failed t=
o pass.
> For failing to run (e.g. comms error) then fail the probe.  Failing to pa=
ss
> the test is what you might choose to carry on from.

I'll change it to include failing to run the test.

>
>> +
>>  	ret =3D devm_iio_device_register(dev, indio_dev);
>>  	if (ret)
>>  		dev_err(dev, "failed to register iio device\n");


