Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B56366567
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 09:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778317361; cv=none; b=ek93C4Od6KRN1YiV7a8QRVxOEp/kDnl3SBUYVXZoLJ9Rz0uXp1GCgILILUS0KjHewOkTXYxE93/TvisIhxZajUL1xnfxwbC9qizpOgl2ITcPhlvJlouDJWBCjoZzsfP80ruxmtjRk49V//UDxDvB1JPPGbiG15sWLtykbFRSrww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778317361; c=relaxed/simple;
	bh=ZEIe098JU/cN6KWi4bBw6JgjToaEYEODR5WyDDnWOv8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PTMq/sctWSKEAvWz5yMy2m1xciYDb8DJv7QNHCkaCRu4HcNjyfZkCPNAoI1ZvRscVOSUKrDbmSeyLwZpBzLpKy4+vptqPEB5F7jF4D0RRNogLXKWNCdVo235clT61UMFP6LdlzZQIG35JoB1bD+yJ23snlTdSLMbDQ9YvMrOL8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eb03cf+o; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eb03cf+o"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4526a8170ceso1509876f8f.2
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 02:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778317358; x=1778922158; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kVp/5ZTF3SBJHikTRVw2b70i5WMc3dE23bQa2Qhj2h0=;
        b=Eb03cf+ohLKhgNLYU2Syr0fZmk+2vaNDA7ssl9rY4PqeZU1nHOz9BAmBdaiY7x4Qhm
         nn3ZBHoyvAY97rmXx/f0OgFrSAkIS/0J+Jgka3ZXNcRj5O9BVzfBrq0TJPuncbSvPe6D
         fDFq8QtkPyH5sIx0zGT4l4LTuGjlOegSNXZVSOvI1REa0IGefBm45yJ/ioYmzlx00ApQ
         yRFBXvrHd/cNXVk7obOW0DhEpMSa0EOFK45NfJsgDZBGGgXTSgZI33Lj9dvhIbIZAAUt
         MPK28tggVrle5OUU4QBOwOeieXUF50JuO7zatdxLd9QJuzaLyGrQ5Oux3ReR/PEJ+5bQ
         xGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778317358; x=1778922158;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kVp/5ZTF3SBJHikTRVw2b70i5WMc3dE23bQa2Qhj2h0=;
        b=ssL8Dzv4LZyK7Rw8c6NMwrm/XXfcsrRShGEoQxpEIH+QnpqcYwi0ZLJJtmBTJhN9L9
         auhusI2s083EvwaMUx4g6sNU27G6li477uRKr3RzO/9k6kzxE/7waq1zFMholmvH+ptO
         8IT6n8IPqMqF1C8cs4r1cfF+T4wugFvR23bbZI0xHq58CBX93/Als40uyL1TjMT/lokk
         w51FnDFS7aIivFywfNBqX32O0OSpTB2cNFol8bvVq2viXy1r65teeU3tRZdqw2SLyer6
         eQqxL7UArCO7ApO30zP1LE+uqStL6oug0dcy+w+mj2zKSUk5596dVahcsQ5gO2xK/qQs
         ACjQ==
X-Gm-Message-State: AOJu0YyiOJSghwG3MWAcxSjIV9VfTqVLrL+DG/nGI6sDHOrXRaqI8TBY
	FksJbt8vYUqkf3z6B2PA/Lc0R4UdrBBVDPmSZ8X8p6Uyhe60DF0aRFEg
X-Gm-Gg: Acq92OEuX7f+13G72tuLLeNCwJnQzkubVnsDpa1JVUtVvOsxxM5iyatmGQgKt8ulHnL
	gyxS2Gm9Xd1q5JeXMlb+7YBHk6Zb9XGXbZ6em0IW8jAM7gYTJyF1u1wAqbhOou14lTgtAFvT8+z
	4ryTuer++PbcPYIF2Lbz5Z8gDpzZY3iudPUFSCaSXZncc+5N1sXuwas772rtpRsEV6cBXsTjKzV
	h+OKEATxoCvuA5fUVuy4eYSse+sWjAfNcWHgov29PDAcwUJWGluTXY9qf1kV+dc7s+CUbWs6EfB
	UDFwsz+O2xemHx9QBDD9m16BB3vREZFY6FqBDxxJAGoSNKXpMIzWlo66g7D94XlAoLiZl8Bk4jE
	7RbOuCTu+cIGuebI8hnTUylIhp2ZtaawC5jhndkO3VykQLFbv1TRDK9ci2PIIQv04B6YGDf6dfs
	hWzBpoDHkwkZZk17eU/O4hEpTKlbHprv4/BSVRKSwWAROp9UopIZPJqdLFoOUL67f3klTqny4Q6
	g==
X-Received: by 2002:a05:6000:2411:b0:446:38ec:b35b with SMTP id ffacd0b85a97d-4568e707e2amr2681258f8f.40.1778317358273;
        Sat, 09 May 2026 02:02:38 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4549130549bsm10922065f8f.18.2026.05.09.02.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 02:02:38 -0700 (PDT)
Message-ID: <0a3e455c86cef14fe3481019031ebf04f98470f7.camel@gmail.com>
Subject: Re: [PATCH 3/8] iio: magnetometer: ak8975: switch to using managed
 resources
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: joshua.crofts1@gmail.com, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko	 <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko
	 <andriy.shevchenko@linux.intel.com>
Date: Sat, 09 May 2026 10:03:38 +0100
In-Reply-To: <20260507-magnetometer-fixes-post-pickup-v1-3-37827ca68fb3@gmail.com>
References: 
	<20260507-magnetometer-fixes-post-pickup-v1-0-37827ca68fb3@gmail.com>
	 <20260507-magnetometer-fixes-post-pickup-v1-3-37827ca68fb3@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-05-07 at 16:35 +0200, Joshua Crofts via B4 Relay wrote:
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20
> Switch the driver to use managed resources (devm_*) which simplifier
> error handling and allows removing ak8975_remove() method from
> the driver.
>=20
> Note, on error path we now also set mode to POWER_DOWN state which is
> fine. Even if the device is in that mode, there is no problem to set
> that mode again, it should be no-op.
>=20
> Additionally, remove any pm_runtime_get/put*() function calls that
> dummy cycled the counter to autosuspend the device.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Co-developed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---
> =C2=A0drivers/iio/magnetometer/ak8975.c | 74 ++++++++++++++++++++++------=
-----------
> =C2=A01 file changed, 41 insertions(+), 33 deletions(-)
>=20
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer=
/ak8975.c
> index
> 63b6e8465f5f3873841550a1cd03ce86b95d1d67..1d8f448d5179fe9b33af989cc2f456a=
c91bc2f17
> 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -898,9 +898,24 @@ static irqreturn_t ak8975_handle_trigger(int irq, vo=
id *p)
> =C2=A0	return IRQ_HANDLED;
> =C2=A0}
> =C2=A0
> +static void devm_ak8975_power_off(void *data)
> +{
> +	struct ak8975_data *ak =3D data;
> +	struct device *dev =3D &ak->client->dev;
> +
> +	/* Only power down if currently active */
> +	if (pm_runtime_status_suspended(dev))
> +		return;
> +
> +	/* Soft-stop the chip before hard-stopping the regulators */
> +	ak8975_set_mode(data, POWER_DOWN);
> +	ak8975_power_off(data);
> +}
> +
> =C2=A0static int ak8975_probe(struct i2c_client *client)
> =C2=A0{
> =C2=A0	const struct i2c_device_id *id =3D i2c_client_get_device_id(client=
);
> +	struct device *dev =3D &client->dev;
> =C2=A0	struct ak8975_data *data;
> =C2=A0	struct iio_dev *indio_dev;
> =C2=A0	struct gpio_desc *eoc_gpiod;
> @@ -968,10 +983,21 @@ static int ak8975_probe(struct i2c_client *client)
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> +	/*
> +	 * Set device as active early so pm_runtime_status_suspended() works
> +	 * correctly if probe fails before pm_runtime is enabled. Do not attemp=
t
> +	 * to move this line lower.
> +	 */
> +	pm_runtime_set_active(dev);
> +
> +	ret =3D devm_add_action_or_reset(dev, devm_ak8975_power_off, data);
> +	if (ret)
> +		return ret;

This looks a bit hackish to me. Why don't we just register this powerdown a=
ction
after enabling PM?
> +
> =C2=A0	ret =3D ak8975_who_i_am(client, data->def->type);
> =C2=A0	if (ret) {
> =C2=A0		dev_err(&client->dev, "Unexpected device\n");
> -		goto power_off;
> +		return ret;
> =C2=A0	}
> =C2=A0	dev_dbg(&client->dev, "Asahi compass chip %s\n", name);
> =C2=A0
> @@ -979,10 +1005,13 @@ static int ak8975_probe(struct i2c_client *client)
> =C2=A0	ret =3D ak8975_setup(client);
> =C2=A0	if (ret) {
> =C2=A0		dev_err(&client->dev, "%s initialization fails\n", name);
> -		goto power_off;
> +		return ret;
> =C2=A0	}
> =C2=A0
> -	mutex_init(&data->lock);
> +	ret =3D devm_mutex_init(dev, &data->lock);
> +	if (ret)
> +		return ret;
> +
> =C2=A0	indio_dev->channels =3D ak8975_channels;
> =C2=A0	indio_dev->num_channels =3D ARRAY_SIZE(ak8975_channels);
> =C2=A0	indio_dev->info =3D &ak8975_info;
> @@ -990,52 +1019,32 @@ static int ak8975_probe(struct i2c_client *client)
> =C2=A0	indio_dev->modes =3D INDIO_DIRECT_MODE;
> =C2=A0	indio_dev->name =3D name;
> =C2=A0
> -	ret =3D iio_triggered_buffer_setup(indio_dev, NULL, ak8975_handle_trigg=
er,
> -					 NULL);
> +	ret =3D devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ak8975_handle_trigger, NULL);
> =C2=A0	if (ret) {
> =C2=A0		dev_err(&client->dev, "triggered buffer setup failed\n");
> -		goto power_off;
> +		return ret;
> =C2=A0	}
> =C2=A0
> -	ret =3D iio_device_register(indio_dev);
> +	ret =3D devm_iio_device_register(dev, indio_dev);
> =C2=A0	if (ret) {
> =C2=A0		dev_err(&client->dev, "device register failed\n");
> -		goto cleanup_buffer;
> +		return ret;
> =C2=A0	}
> =C2=A0
> =C2=A0	/* Enable runtime PM */
> -	pm_runtime_get_noresume(&client->dev);
> -	pm_runtime_set_active(&client->dev);
> -	pm_runtime_enable(&client->dev);
> +	ret =3D devm_pm_runtime_enable(dev);
> +	if (ret)
> +		return ret;

Maybe it would make sense to move this before devm_iio_device_register(). A=
t the
point we register the device, userspace can start to interact with the devi=
ce where
we have pm calls? Not that it is a problem (I think) but makes sense to me =
to enable
PM before exposing the device.

- Nuno S=C3=A1

> +
> =C2=A0	/*
> =C2=A0	 * The device comes online in 500us, so add two orders of magnitud=
e
> =C2=A0	 * of delay before autosuspending: 50 ms.
> =C2=A0	 */
> =C2=A0	pm_runtime_set_autosuspend_delay(&client->dev, 50);
> =C2=A0	pm_runtime_use_autosuspend(&client->dev);
> -	pm_runtime_put(&client->dev);
> =C2=A0
> =C2=A0	return 0;
> -
> -cleanup_buffer:
> -	iio_triggered_buffer_cleanup(indio_dev);
> -power_off:
> -	ak8975_power_off(data);
> -	return ret;
> -}
> -
> -static void ak8975_remove(struct i2c_client *client)
> -{
> -	struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
> -	struct ak8975_data *data =3D iio_priv(indio_dev);
> -
> -	pm_runtime_get_sync(&client->dev);
> -	pm_runtime_put_noidle(&client->dev);
> -	pm_runtime_disable(&client->dev);
> -	iio_device_unregister(indio_dev);
> -	iio_triggered_buffer_cleanup(indio_dev);
> -	ak8975_set_mode(data, POWER_DOWN);
> -	ak8975_power_off(data);
> =C2=A0}
> =C2=A0
> =C2=A0static int ak8975_runtime_suspend(struct device *dev)
> @@ -1129,7 +1138,6 @@ static struct i2c_driver ak8975_driver =3D {
> =C2=A0		.acpi_match_table =3D ak_acpi_match,
> =C2=A0	},
> =C2=A0	.probe		=3D ak8975_probe,
> -	.remove		=3D ak8975_remove,
> =C2=A0	.id_table	=3D ak8975_id,
> =C2=A0};
> =C2=A0module_i2c_driver(ak8975_driver);
