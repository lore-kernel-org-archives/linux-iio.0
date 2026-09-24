Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB353BD653;
	Thu, 24 Sep 2026 08:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790237085; cv=none; b=HItSLW0gUrpIXMPOAD2HHK/ARwtimBQ5OSoByDPky0+LyFsiEOnf8pv45KrWexUXPhUaxD8Qym3M7ipktcOpGz08CkbhQtmhfrC0KYnw8a1pTeY/9zN7Yv01Q/o5Rj7Sa4nXFzkaIw5jJohteG4O8ivrEC866avtbX3v8zElOJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790237085; c=relaxed/simple;
	bh=rdiaA4TqP8I5f98L4oqxFaQKsBcwi5g4iH4mJf3G5as=;
	h=MIME-Version:Content-Type:Date:Message-ID:To:CC:Subject:From:
	 References:In-Reply-To; b=Sl7EAgIb/KZGrv3d8AzErrMlLB2hjulXVgCv0gV+RKs496vSK3pam3KS4MS01/MX2MaaWZlOGHhjkGlJ0Gvh9OVk81UsKXAnKbmEqCxPeyvEpAJ00miYtO2kp8NwCwNy8Qmk4FmTz2TR9WYBE4VenvCuw2A7H+FRla39QgcGIc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=T0Uo+zJK; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="T0Uo+zJK"
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 68O84Mlr018235-68O84Mlt018235
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 24 Sep 2026 11:04:22 +0300
Received: from ex19-16.utu.fi ([130.232.247.56])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <jaakko.ma.koivisto@utu.fi>)
	id 1x9eRJ-00EfzB-W0;
	Thu, 24 Sep 2026 11:04:21 +0300
Received: from localhost (91.145.105.139) by ex19-16.utu.fi (130.232.247.56)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 11:04:21 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 24 Sep 2026 11:04:21 +0300
Message-ID: <DLNE2OD7OJ8Y.HONYZ4LYDTQM@utu.fi>
To: Jonathan Cameron <jic23@kernel.org>, Andreas Klinger <ak@it-klinger.de>
CC: Jaakko Koivisto <jmatko@utu.fi>, David Lechner <dlechner@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] iio: chemical: sgp40: Implement
 turn_heater_off-command
From: Jaakko Koivisto <jmatko@utu.fi>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260918134019.1101308-1-jmatko@utu.fi>
 <20260918134019.1101308-4-jmatko@utu.fi>
 <aq3LDTnLuJm6vjFt@mail.your-server.de>
 <20260920185201.5a25dc05@jic23-hlaptop>
In-Reply-To: <20260920185201.5a25dc05@jic23-hlaptop>
X-ClientProxiedBy: ex19-06.utu.fi (130.232.247.46) To ex19-16.utu.fi
 (130.232.247.56)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFpdSAIJCQMDB0YFCUYDBwEeARscBygdHB1GDgFIWUhZXkgCAQta
 WygDDRoGDQRGBxoPSFhIWkhZXEhZW1hGWltaRlpYX0ZcX0hQSFhIWEhdSFhIWEhYSFleSAkDKAEcRQMEAQYPDRpGDA1IWEhZXUgJBgwRKAMNGgYNBEYHGg9IWEhaWUgM
 BA0LAAYNGigKCREEAQoaDUYLBwVIWEhaXUgEAQYdEEUBAQcoHg8NGkYDDRoGDQRGBxoPSFhIWVBIBh0GB0YbCSgJBgkEBw9GCwcFSFg=
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=mime-version:content-type:date:message-id:to:cc:subject:from:references;
 bh=mS0d/yaoz/22xNWzvHTFnkl1xVX6jWhArC8hOuPzmzg=;
 b=T0Uo+zJKfsucJyYGPG8U49lh8qXarUcqSkxvNGGOLKTisXJOJjGCjhpLV+hhSMY+PszeHCczjyXr
	PccfXXPNErY9nw9SBUXZS6BFiqqEtXvuRSv+OCmNcXsi/3zeJYYS3xFLFW8FhkGzhjYIpVS4dAru
	wP1OyiJmZzld9H5b9ZcHy8grz9O0FUqKntIK0NgCVvzSfgKimGTZQfBRfM56bnrpXk7YeWPnkykI
	v53c69upKiNUe53wYTf2dXs5e8xYGSr6ULNu4bJGiA/xb+4f/flSzZIdHCSsVEp2DqOG3vtzyCwT
	JuFNr44sTaOgMQ28E6wEJGEQ3t8gFAzeRDMreA==

On Sun Sep 20, 2026 at 8:52 PM EEST, Jonathan Cameron wrote:
> On Sat, 19 Sep 2026 01:36:45 +0200
> Andreas Klinger <ak@it-klinger.de> wrote:
>
>> Hi Jaakko,
>>=20
>> Jaakko Koivisto <jmatko@utu.fi> schrieb am Fr, 18. Sep 16:40:
>> > -Turn the heating element off and enter idle mode.
>> > -Present the functionality as device attribute,
>> >  'echo 1 > turn_heater_off'. =20
>>=20
>> Instead of introducing a device specific attribute couldn't this be impl=
emented
>> as standard power management operations (RUNTIME_PM_OPS)?
>
> May not apply in this case but normally the warm up time of these sorts o=
f
> heaters are in the seconds.  No one wants that latency when they want
> a measurement.  As such normal runtime pm doesn't work - it needs to
> be a specific userspace opt in.

For SGP40 the heater must be on for 60 seconds for reliable data, and up
to 60 minutes to reach all datasheet specs. These are very long times, so I
would not want to turn the heater off automatically.

> We have defined ABI for this though and this isn't it
> See Documentation/ABI/testing/sysfs-bus-iio (and more in -humidity)

Thanks, missed that there was already ABI for heaters. I will change to
use this instead.

While looking at this I noticed this driver is using mutex_lock() and
mutex_unlock(). Recent commits, e.g. eb60a24b35bfb9e85a272e561379833e49a12a=
79,
say using the newer guard() is the preferred way these days. Should this be
updated as well?

>
> Jonathan
>
>>=20
>> Andreas
>>=20
>> > Saves approx. 2.5 mA compared to regular operation. The heating elemen=
t
>> > is automatically turned back on when measurement is performed.
>> >=20
>> > Signed-off-by: Jaakko Koivisto <jmatko@utu.fi>
>> > ---
>> >  drivers/iio/chemical/sgp40.c | 28 ++++++++++++++++++++++++++++
>> >  1 file changed, 28 insertions(+)
>> >=20
>> > diff --git a/drivers/iio/chemical/sgp40.c b/drivers/iio/chemical/sgp40=
.c
>> > index 28d5e737d1dc..a4fc5c778303 100644
>> > --- a/drivers/iio/chemical/sgp40.c
>> > +++ b/drivers/iio/chemical/sgp40.c
>> > @@ -29,6 +29,7 @@
>> >   * by writing to the out values of temp and humidityrelative.
>> >   */
>> > =20
>> > +#include "linux/device.h"
>> >  #include <linux/delay.h>
>> >  #include <linux/crc8.h>
>> >  #include <linux/module.h>
>> > @@ -259,6 +260,21 @@ static int sgp40_execute_self_test(struct sgp40_d=
ata *data)
>> >  	}
>> >  }
>> > =20
>> > +static int sgp40_turn_heater_off(struct sgp40_data *data)
>> > +{
>> > +	int ret;
>> > +	struct i2c_client *client =3D data->client;
>> > +	struct sgp40_command turn_off =3D {.command =3D {0x36, 0x15}};
>> > +
>> > +	ret =3D i2c_master_send(client, (char*)&turn_off, sizeof(turn_off.co=
mmand));
>> > +	if (ret !=3D sizeof(turn_off.command)) {
>> > +		dev_err(data->dev, "i2c_master_send ret: %d, expected %zu", ret, si=
zeof(turn_off.command));
>> > +		return -EIO;
>> > +	}
>> > +	msleep(1);
>> > +	return 0;
>> > +}
>> > +
>> >  static int sgp40_measure_resistance_raw(struct sgp40_data *data, u16 =
*resistance_raw)
>> >  {
>> >  	int ret;
>> > @@ -417,10 +433,22 @@ static ssize_t serial_number_show(struct device =
*dev,
>> >  	return sysfs_emit_at(buf, 0, "%llu\n", data->serial_number);
>> >  }
>> > =20
>> > +static ssize_t turn_heater_off_store(struct device *dev,
>> > +				     struct device_attribute *attr,
>> > +				     const char *buf, size_t len)
>> > +{
>> > +	struct sgp40_data *data =3D iio_priv(dev_to_iio_dev(dev));
>> > +	sgp40_turn_heater_off(data);
>> > +
>> > +	return len;
>> > +}
>> > +
>> >  static IIO_DEVICE_ATTR_RO(serial_number, 0);
>> > +static IIO_DEVICE_ATTR_WO(turn_heater_off, 0);
>> > =20
>> >  static struct attribute *sgp40_attributes[] =3D {
>> >  	&iio_dev_attr_serial_number.dev_attr.attr,
>> > +	&iio_dev_attr_turn_heater_off.dev_attr.attr,
>> >  	NULL
>> >  };
>> > =20
>> > --=20
>> > 2.55.0
>> >  =20
>>=20


