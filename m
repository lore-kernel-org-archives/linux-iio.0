Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A05A2D2381;
	Sun,  1 Mar 2026 11:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772364902; cv=none; b=ZpzMet9wMSya/Zpi8YFJL5rVlC3mP11f7l1lz0HLQ3HMKaMQFFFg8K4b43+tkKSbKJU2N2v4UaVR/NoFmqk5DyURFl/vN97jSQMRSBVDegxzzIMEeza/FkOsKekCMZu4Aq3yXzZ1HtQSuKzKjEABLWb2aKat6ZQy7GDHLB9jN2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772364902; c=relaxed/simple;
	bh=g56QlBsEqDGHbBsfa7b1Js1GTIi9xHOtT1n3MWRbJsg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i88deXdaJiuPNIGk5pq/WigoIdOqW8A1utVOkMnthzQIFi1q3D7JDSa1QSfAlbmrOG0YpfA8XySCaHkvh3L8PSanFILbyiiB/BeVHXI1vmKQGakqcCL3ZFIpCp+xlRJI7oApFMFzP7PKXTvvlIioS6vPYDfdwgfsSKoeupAzp7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hj5XgNmR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hj5XgNmR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F79BC116C6;
	Sun,  1 Mar 2026 11:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772364901;
	bh=g56QlBsEqDGHbBsfa7b1Js1GTIi9xHOtT1n3MWRbJsg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hj5XgNmRCPV1LVU7KvF1aqm5o8cmXeA5kimRlL+tsAdeyjyO+DNeLun0Vb7w6B4e0
	 tZcuhyqeVquwCtnMv2QyQyQQOHIP6V2G+HqbHa7ARmVi4ZeavenwRlTTj8TgSxi3X3
	 JIRREes4iWpNHRkvGecGhIM0q+Deh9dZY13xSmIoUtvr/D1hXw/CvkM9RoUg6mTNXT
	 nSMsJymvR9RI6fRYioUbG4vc7rnDeUv6M7rXjcMVhsxgsahOU8UIIhvBm7/fpIFLom
	 O0nAJx8Ovgc5eN3k4baOH7GxZUebH5Mc7sEI+YNHnWWS1WS30drmuPsnE+WQn9N3rb
	 fqjvQ3Njjs3DQ==
Date: Sun, 1 Mar 2026 11:34:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Archit Anant <architanant5@gmail.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad799x: use devm_iio_device_register and devm
 buffer setup
Message-ID: <20260301113452.7e1f95ee@jic23-huawei>
In-Reply-To: <00ee6df6-422e-40db-8494-3f9da4ccb227@baylibre.com>
References: <20260228154515.16639-1-architanant5@gmail.com>
	<641c4d59-4cfd-49b6-b6de-692db48db1c7@baylibre.com>
	<CADJHxWA6QT9LqAR4n3UUHsr73X1S=SvwWCtO=M220SBUD91p-Q@mail.gmail.com>
	<00ee6df6-422e-40db-8494-3f9da4ccb227@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 28 Feb 2026 11:35:15 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 2/28/26 11:19 AM, Archit Anant wrote:
> > Hi David,
> >=20
> > On Sat, Feb 28, 2026 at 10:06=E2=80=AFPM David Lechner <dlechner@baylib=
re.com> wrote: =20
> >>
> >> On 2/28/26 9:45 AM, Archit Anant wrote: =20
> >>> Convert the driver to use the device-managed versions of
> >>> iio_device_register() and iio_triggered_buffer_setup().
> >>>
> >>> This simplifies the error handling in ad799x_probe() by removing the
> >>> 'error_cleanup_ring' goto label. It also removes the need to manually
> >>> call iio_device_unregister() and iio_triggered_buffer_cleanup() in
> >>> ad799x_remove().
> >>> =20
> >> Since we are doing this, why not also handle the regulators and
> >> rx_buf so that we can drop the remove() function completely? =20
> >=20
> > I completely agree that dropping the remove() function is the
> > ideal end state but I initially stopped short of doing that because of =
two
> > hurdles:
> >=20
> > 1. regulators: since ad799x_read_raw() needs the regulator pointers
> > to call regulator_get_voltage(), I couldn't simply use
> > devm_regulator_get_enable(). =20
>=20
> In this case, we can use devm_add_action_or_reset() to register the
> disable callbacks.

It is vanishingly rare for for the voltages to change after driver probe,
so an alternative that is almost certainly fine is to read and cache the
voltage at probe.

>=20
> >=20
> > 2. rx_buf: st->rx_buf is dynamically re-allocated (kfree then kmalloc)
> > inside ad799x_update_scan_mode() based on the scan mask. If I use
> > devm_kmalloc there, it would leak memory on every mask change.
> >=20
> > To drop remove() completely, would you prefer I use devm_add_action_or_=
reset()
> > to register custom disable & free callbacks for the regulators and the
> > final state of rx_buf?
> >=20
> > If that approach sounds good to you, I will gladly prepare a v2 that
> > eliminates the remove() function entirely.
> >=20
> >  =20
>=20
> Here, we could also use devm_add_action_or_reset() or we could drop
> the dynamic allocation altogether and make rx_buf large enough for
> the largest transfer. The latter would be preferred as that is how
> we usually do it in general.

Agreed.

>=20
> #define AD799X_MAX_CHANNELS 8
>=20
> ...
>=20
> struct ad799x_state {
> 	...
> 	unsigned int			transfer_size;
> 	IIO_DECLARE_DMA_BUFFER_WITH_TS(__be16, rx_buf, AD799X_MAX_CHANNELS);
> };
>=20
> Note, it is important for this to be the last field in the struct
> for DMA alignment purposes.
>=20
I2C driver, so no need. I2C by default bounce buffers everything anyway so =
we don't
need an aligned buffer (or the padding that results in at the end of the st=
ructure).

Jonathan



