Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0595D2DC791;
	Wed, 29 Apr 2026 18:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777486185; cv=none; b=jHUKC+u+HoYoH1XncJ4pSpWSlvTmFCt+T95FdbuEsCXZIehBak2EAxJjr0HPNsUi6vsxJD2MKsvYwpQMV8qE7O0iQIEvenCHLuGjRwvR48gnDKYPdRw24Ih/rB8ZZeLcrkEO6pBeu75s7ZemnU3a1ELq/o6KjUaMJsJruIBvQ2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777486185; c=relaxed/simple;
	bh=YS3YgWRSz3h3IpDYl8ezftLA1YN7jKbBXvEdnK7qavg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qwkqDl1sbaeTRRtb23DIxT8qKDPV3PPh3W+ZeXMOCGLYzcZAQam+Cv/QlCYb2MQzan3V3a5J5zWOBjQVWW3+NC+ylRMKOVkJfvQOpic9D0MmwRLdkNRvv8haTswTCTnvBXr/uX2NZrPKzZT9HSuZjJKSx9p6R/LKnRLXJr2nAQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7YoqfFi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7YoqfFi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 364BBC19425;
	Wed, 29 Apr 2026 18:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777486184;
	bh=YS3YgWRSz3h3IpDYl8ezftLA1YN7jKbBXvEdnK7qavg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F7YoqfFiRt1ajjQSA6QiKsDvSxpiFdwKQEU4rcH6BNcf9iFlhFnfJ0ovULQk67fmv
	 EESVd7bk9zvCUg6mmXCZ6+uv1zI9YCr1bmnygg9M6kktyuWLzhI2XIhU8RX9CgmM6s
	 xC2HOnlCt1kaJWnw3KVzEqNhMTiC6zmJNCXLiN+PusVSFxnS7Tx7dH42+7w4lpnClZ
	 Th4PZRkD+yBKies+OhEJDE7PDa2KsgZt2OpsuPPWBBkc5FS626w57zO4/jKcGd9Jsp
	 cFLutCVVqPxk64LbCGcVcS0lrmXfW3vhegciLPXf9RRUpwucYRnbzNw+X+RR02TLYe
	 XQ3i0n9j7xYew==
Date: Wed, 29 Apr 2026 19:09:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 mingo@kernel.org, christophe.jaillet@wanadoo.fr,
 nabijaczleweli@nabijaczleweli.xyz, kees@kernel.org,
 kyungmin.park@samsung.com, k.wrona@samsung.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/9] iio: ssp_sensors: cancel delayed work_refresh on
 remove
Message-ID: <20260429190934.4fb63bcb@jic23-huawei>
In-Reply-To: <952B333C-55B0-4E76-8685-DA9874BE1447@gmail.com>
References: <20260426091710.3722035-1-sanjayembedded@gmail.com>
	<20260426091710.3722035-4-sanjayembedded@gmail.com>
	<20260426150912.765d5985@jic23-huawei>
	<952B333C-55B0-4E76-8685-DA9874BE1447@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 29 Apr 2026 23:36:24 +0530
Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

> On 26 April 2026 7:39:12=E2=80=AFpm IST, Jonathan Cameron <jic23@kernel.o=
rg> wrote:
> >On Sun, 26 Apr 2026 14:47:04 +0530
> >Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:
> > =20
> >> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> >>=20
> >> The work_refresh may still be pending or running when the device is
> >> removed, cancel the delayed work_refresh in remove path.
> >>=20
> >> Fixes: 50dd64d57eee ("iio: common: ssp_sensors: Add sensorhub driver")=
 =20
> >
> >Fixes at start of patch series not after some refactors of unrelated
> >code. =20
>=20
> Hi Jonathan,
>=20
> Thank you for input, I will make sure to take care of this in future.
>=20
> Additionally, this change is independent to the initial two changes. If t=
his change is good for the iio subtree then this would help to reduce overh=
ead in next series.
Fair enough. Applied to the fixes-togreg branch of iio.git and
marked for stable.

Thanks,

Jonathan

>=20
> > =20
> >> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> >> ---
> >>  drivers/iio/common/ssp_sensors/ssp_dev.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>=20
> >> diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/co=
mmon/ssp_sensors/ssp_dev.c
> >> index 7d07fae295fd..51730dae5871 100644
> >> --- a/drivers/iio/common/ssp_sensors/ssp_dev.c
> >> +++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
> >> @@ -590,6 +590,7 @@ static void ssp_remove(struct spi_device *spi)
> >>  	ssp_clean_pending_list(data);
> >> =20
> >>  	free_irq(data->spi->irq, data);
> >> +	cancel_delayed_work_sync(&data->work_refresh);
> >> =20
> >>  	timer_delete_sync(&data->wdt_timer);
> >>  	cancel_work_sync(&data->work_wdt); =20
> > =20

