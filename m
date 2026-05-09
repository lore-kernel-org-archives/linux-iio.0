Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D846390C8A
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 09:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778317414; cv=none; b=MKrv4FdRoxQOZKp/xpZf1diO/89x6plcXNKbmoVx/X4/edO+v4ReZughyok1d5NKBXuhSOoZS2c/eWaFLNQRtbpibNADudshXUXruTgzzGIZO2shPYe9QMCLRCHTAAAZMMOosYqUxck45cVRIrrBzAUhxk144KTNZCSNBGBzW3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778317414; c=relaxed/simple;
	bh=YBQ97H7F537ogRwncybg2jFdGyfQpy6+6xWxR8HKQyw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QxvnwoElChnWvV3SjAv4RNJHJOvZGyO5Yy3TYMdaTSdFoUs36gdvONvj4f+GZWWlzuteDoeyfJcWOoGEqU3q1nJrNFRhhCxaNkOwHvK5/7EmpAz5p2jD3xclrNbHUPENVRTYttZok87hgP0Tr1RnqkmCXiI2YFATH8MrHX13yDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+DP85rp; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+DP85rp"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so24554885e9.2
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 02:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778317412; x=1778922212; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vYBAUvVamdQwcj7gPIsH6IM/KtSO86zd1Ue5Q4vjrNM=;
        b=W+DP85rpf9gXI/nyR9KlUd5n2OpwQOsM+d65nTa4af7ucfqz3Xpbo/VTrCG36seNcD
         wcm9FzRyxFjeZWFBkU6ISas4nZYTY/ElV3Dz3q98zSVTpCFm3s9WQJAjnpoCdgSP8Ppq
         uMn5RaJK3p3z9rrTZFxd/FpTfejUl2AFHugxgdJi739/OUmbytFlQstvnfm3p5jBG1nQ
         HvX3rbEuFCEIc6JJy4oX+DmJIZQs+VVPl1MxdLxLKme47oCrsfGfUmJHl2cStluwhM3m
         KHyfERb3S3pFx+mS0ovlMT6Ej33hKG0tLFfuYaQCqUUoZli4KeQ3SC+smJginqidE8PX
         BCbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778317412; x=1778922212;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vYBAUvVamdQwcj7gPIsH6IM/KtSO86zd1Ue5Q4vjrNM=;
        b=DtxS/2vTHFzJWRORkXd94m7eyJ78AH9HqhnV6wSrVZCy/zoarQjeeYpDAL9a0kbmtW
         3pxZ0/5AfHpbGIDgHdqDVScrvsVrK1r1G/RIdnukjeGCC4AUBhryeeIpf1el7Vq7KyVV
         Um9fq6LDADawd70Ba2PBCBWbQFPvSBiSwuk8eDZysKfsofJZvXlV33b3VbueMbaXHZLE
         79yU+HO0+BYwTBCOV5Zp4EjzCQv9kgGhwdqL6rrtURgqkoK1pmbcwj0SPskuVv2x1La4
         KHDu/dV3Tlw8tzlT+vtOgGy1W/HV+jTIBsCKXLKNEWJiEDACSN9Pvy+s5kSc5gE36TX8
         3Mig==
X-Gm-Message-State: AOJu0Yyle4e+xFluMhanBZ9AbEtA9ETbcnG34GhEDEiYX+2SCF5Tv7Em
	eYMl/BveZPEfzA0KX/7TUP3k+wnbc9AUBUnZiHWFkLwJ2DDa87/fKnlx
X-Gm-Gg: Acq92OF44TK/hvDKmZPBwqcZWOsL2YYeYAhBQZ66rMiNPTT1ySKaM5lMct6tKSvhhuv
	lnCqvuAhIXRqGKhP5DHdlaJhdBQZ5qq5CXu4i40X2eKYsMrkjR4qwhTMQFMaE+O9GQufgOC97O5
	uEy+jeNfxuGNT4eNOwoMHjXIlLu70eqDzcqy7jgXzgg774KUey8NJpmF51P9sd/cmbKweyhiqJp
	Jd6NPZhbEqWCMOZHmkZIE6uWZHG8B1F5CNgtBdlWAtLLjA71Rzs1zgeZle3EQqiADE16l8+x3YH
	OylQ+y1P3+S1uSJSbQMgAdgPMt3V7pc+B9whMvZe7tuwodkx5CFaY6AGQRIc5J+U/ZfpcbZeEBO
	8+x92PnmkDUwNui3yu/cVJMEzaOrHF2ZyFBtwG/RHLyqVd6Lb2kWhmF1c2G4ybzEIbwB+rJq4ag
	1RfFLBOeaXyAwrMn7y8e5v4qxsFYLgBjTyCyfDe7kPCg5RTCWecnWxXsRxrlPlPBEgceBIBkX98
	Q==
X-Received: by 2002:a05:600c:c107:b0:48a:52d4:888c with SMTP id 5b1f17b1804b1-48e51e0bb23mr185814845e9.3.1778317411629;
        Sat, 09 May 2026 02:03:31 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e7041defesm36007405e9.15.2026.05.09.02.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 02:03:31 -0700 (PDT)
Message-ID: <b64a38258dcd5bd8dae212938da0475b3894240f.camel@gmail.com>
Subject: Re: [PATCH 4/8] iio: magnetometer: ak8975: consistently use 'data'
 parameter
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: joshua.crofts1@gmail.com, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko	 <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko
	 <andriy.shevchenko@linux.intel.com>
Date: Sat, 09 May 2026 10:04:32 +0100
In-Reply-To: <20260507-magnetometer-fixes-post-pickup-v1-4-37827ca68fb3@gmail.com>
References: 
	<20260507-magnetometer-fixes-post-pickup-v1-0-37827ca68fb3@gmail.com>
	 <20260507-magnetometer-fixes-post-pickup-v1-4-37827ca68fb3@gmail.com>
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
> Some of the functions use 'client', some use 'data', and some use both.
> Refactor the driver to consistently use 'data' in all cases.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/magnetometer/ak8975.c | 25 +++++++++++++------------
> =C2=A01 file changed, 13 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer=
/ak8975.c
> index
> 1d8f448d5179fe9b33af989cc2f456ac91bc2f17..e575d252076acc3639cfbb718a76811=
636fe56d2
> 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -474,9 +474,10 @@ static void ak8975_power_off(const struct ak8975_dat=
a *data)
> =C2=A0 * Return 0 if the i2c device is the one we expect.
> =C2=A0 * return a negative error number otherwise
> =C2=A0 */
> -static int ak8975_who_i_am(struct i2c_client *client,
> +static int ak8975_who_i_am(const struct ak8975_data *data,
> =C2=A0			=C2=A0=C2=A0 enum asahi_compass_chipset type)
> =C2=A0{
> +	struct i2c_client *client =3D data->client;
> =C2=A0	u8 wia_val[2];
> =C2=A0	int ret;
> =C2=A0
> @@ -598,10 +599,9 @@ static int ak8975_setup_irq(struct ak8975_data *data=
)
> =C2=A0 * Perform some start-of-day setup, including reading the asa calib=
ration
> =C2=A0 * values and caching them.
> =C2=A0 */
> -static int ak8975_setup(struct i2c_client *client)
> +static int ak8975_setup(struct ak8975_data *data)
> =C2=A0{
> -	struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
> -	struct ak8975_data *data =3D iio_priv(indio_dev);
> +	struct i2c_client *client =3D data->client;
> =C2=A0	int ret;
> =C2=A0
> =C2=A0	/* Write the fused rom access mode. */
> @@ -706,12 +706,13 @@ static int wait_conversion_complete_interrupt(struc=
t
> ak8975_data *data,
> =C2=A0	return ret > 0 ? 0 : -ETIMEDOUT;
> =C2=A0}
> =C2=A0
> -static int ak8975_start_read_axis(struct ak8975_data *data,
> -				=C2=A0 const struct i2c_client *client)
> +static int ak8975_start_read_axis(struct ak8975_data *data)
> =C2=A0{
> -	/* Set up the device for taking a sample. */
> -	int ret =3D ak8975_set_mode(data, MODE_ONCE);
> +	struct i2c_client *client =3D data->client;
> +	int ret;
> =C2=A0
> +	/* Set up the device for taking a sample. */
> +	ret =3D ak8975_set_mode(data, MODE_ONCE);
> =C2=A0	if (ret < 0) {
> =C2=A0		dev_err(&client->dev, "Error in setting operating mode\n");
> =C2=A0		return ret;
> @@ -744,7 +745,7 @@ static int ak8975_read_axis(struct iio_dev *indio_dev=
, int
> index, int *val)
> =C2=A0
> =C2=A0	mutex_lock(&data->lock);
> =C2=A0
> -	ret =3D ak8975_start_read_axis(data, client);
> +	ret =3D ak8975_start_read_axis(data);
> =C2=A0	if (ret)
> =C2=A0		goto exit;
> =C2=A0
> @@ -856,7 +857,7 @@ static void ak8975_fill_buffer(struct iio_dev *indio_=
dev)
> =C2=A0
> =C2=A0	mutex_lock(&data->lock);
> =C2=A0
> -	ret =3D ak8975_start_read_axis(data, client);
> +	ret =3D ak8975_start_read_axis(data);
> =C2=A0	if (ret)
> =C2=A0		goto unlock;
> =C2=A0
> @@ -994,7 +995,7 @@ static int ak8975_probe(struct i2c_client *client)
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	ret =3D ak8975_who_i_am(client, data->def->type);
> +	ret =3D ak8975_who_i_am(data, data->def->type);
> =C2=A0	if (ret) {
> =C2=A0		dev_err(&client->dev, "Unexpected device\n");
> =C2=A0		return ret;
> @@ -1002,7 +1003,7 @@ static int ak8975_probe(struct i2c_client *client)
> =C2=A0	dev_dbg(&client->dev, "Asahi compass chip %s\n", name);
> =C2=A0
> =C2=A0	/* Perform some basic start-of-day setup of the device. */
> -	ret =3D ak8975_setup(client);
> +	ret =3D ak8975_setup(data);
> =C2=A0	if (ret) {
> =C2=A0		dev_err(&client->dev, "%s initialization fails\n", name);
> =C2=A0		return ret;
