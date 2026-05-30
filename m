Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D5832B9A9;
	Sat, 30 May 2026 15:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780155796; cv=none; b=LFATAfLoxexv0KszcqqzGIrKuMFKI2IG6wLLpDMNjio+ATzWHC361zj5jRIOQaOcwK7TvpJENzXi8NuZkMAAmcx30uRsFcoFu0v4HroHFaoi/wQGa4Wf66CVTKqjXYcpAhiviFUJbUhReW9RcZ9nNKlujPpJlUa2dKtHQg/pZkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780155796; c=relaxed/simple;
	bh=nxLYD9KhvPW3H69Y0B8IqeVLU/JDCT04MjHsZeZgECs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZgQhOr7N3WSQLfQ3Q2h2l8dZdwo07VMZmfN17qGbnjAc5CgC7M8DTtO0d6dFzhuP9Dfm4AiVF2aftQSlDMVlXaHQZ1e6uGs8hugCBbM84hsXTZhuRZ40xYGsoOlHOvmzm3KblBPjleySOGf2rys8gfdYcVXB1AcJn93Ntc8NA+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nB1pXA8q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nB1pXA8q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF711F00898;
	Sat, 30 May 2026 15:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780155795;
	bh=oxvtRYC56NYeBoaIURSerBZps2NHs8hgK/5O3AhG+tU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nB1pXA8qkwjxlr2nR1jyjCcrBmYPnygfTVQCjMcHTu8jE/veZ1jufSx3tWFJtcjm1
	 JfSfk45mAMOW9fZlXW9rWGaipSuaih9R0UwH1+/qiKkV8mTo9fxNlHAC959KgdKJ2Z
	 4ifelk883FuZw2s113XlOHDAin3hTtzRM5VGpKnnlJ9SxiWfMzuHzvwpPhDtA6v6Yu
	 Jdy0DcymMMWRgTWvLrVLmnHF/rDGMZDSiyn5v/GdBg3wsSx0COnD3nmhJ0fmoC+Tdl
	 z4lTpMwGJmeKEdOy0DnI0MVzCCWdwmWxOOCJL6a5/BoqgpTW+SS+6Kl+TEgDVNKY+g
	 KQCiu64DmYSoQ==
Date: Sat, 30 May 2026 16:43:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: SeungJu Cheon <suunj1331@gmail.com>, linux-iio@vger.kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 apokusinski01@gmail.com, me@brighamcampbell.com, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH 4/4] iio: pressure: mpl3115: add hardware FIFO support
Message-ID: <20260530164306.70c9ac71@jic23-huawei>
In-Reply-To: <CAHp75VcN7B5BdKZGBiw5cbhYesGsO_tStcN3cKgggiHiuSnJ7w@mail.gmail.com>
References: <20260530113938.171540-1-suunj1331@gmail.com>
	<20260530113938.171540-5-suunj1331@gmail.com>
	<CAHp75VcN7B5BdKZGBiw5cbhYesGsO_tStcN3cKgggiHiuSnJ7w@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 30 May 2026 15:32:23 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sat, May 30, 2026 at 1:40=E2=80=AFPM SeungJu Cheon <suunj1331@gmail.co=
m> wrote:
> >
> > Add support for the MPL3115A2 hardware FIFO.
> >
> > The device provides a 32-sample FIFO with configurable
> > watermark interrupts, allowing buffered data acquisition
> > with reduced interrupt and CPU overhead.
> >
> > Use a kfifo-backed IIO buffer when a DRDY interrupt and
> > SMBus block reads are available, falling back to the
> > existing triggered buffer implementation otherwise.
> >
> > When enabled, the driver configures the FIFO in circular
> > mode and drains accumulated samples on watermark
> > interrupts.
> >
> > Overflow conditions are handled by flushing available
> > samples before resetting the FIFO, avoiding unnecessary
> > data loss.
> >
> > The hardware always captures pressure and temperature
> > samples together, so FIFO operation requires both channels
> > to be enabled.
> >
> > Register cache updates are performed only after successful
> > I2C writes to keep cached and hardware state consistent.
> >
> > No functional change for non-buffered operation. =20
>=20
Some fun stuff that Andy has picked out here, so a few comment on top
(I was wondering some of the same things!)
> ...
>=20
> > +       u8 fifo_buf[MPL3115_FIFO_SIZE * MPL3115_FIFO_SAMPLE_SIZE]
> > +               __aligned(IIO_DMA_MINALIGN); =20
>=20
> We have a macro for this,
Which one?  We have the buffer + timestamp ones for IIO but that' not
relevant here.
>=20
> ...
>=20
> > +static int mpl3115_fifo_flush(struct iio_dev *indio_dev)
> > +{
> > +       struct mpl3115_data *data =3D iio_priv(indio_dev);
> > +       u8 buffer[MPL3115_BUF_SIZE] __aligned(sizeof(s64)) =3D { }; =20
>=20
> Don't we have a macro for this?
This one seems more likely to be one we cover IIO_DECLARE_BUFFER_WITH_TS()

However, looks like the ts is always in the same place and all channels are
captured so I'd prefer this as something like

	struct {
		__be32 pressure;
		__be16 temp;
//there is a gap here hence need to force initialization to avoid stack con=
tent leaking.
		aligned_s64 ts;
	} scan =3D { };

>=20
> > +       unsigned int sample_count, i;
> > +       int ret;
> > +       bool overflow;
> > +       s64 ts;
> > +
> > +       ret =3D i2c_smbus_read_byte_data(data->client, MPL3115_F_STATUS=
);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       overflow =3D FIELD_GET(MPL3115_F_STATUS_F_OVF, ret);
> > +       sample_count =3D FIELD_GET(MPL3115_F_STATUS_F_CNT, ret);
> > +       if (sample_count =3D=3D 0)
> > +               return overflow ? mpl3115_fifo_reset(data) : 0;
> > +
> > +       ret =3D mpl3115_fifo_transfer(data, sample_count);
> > +       if (ret)
> > +               return ret;
> > +
> > +       ts =3D iio_get_time_ns(indio_dev);
> > +       for (i =3D 0; i < sample_count; i++) { =20
>=20
>   for (unsigned int i =3D 0; ...) {
>=20
> > +               u8 *sample =3D &data->fifo_buf[i * MPL3115_FIFO_SAMPLE_=
SIZE]; =20
>=20
> > +               memcpy(&buffer[MPL3115_BUF_PRESS_OFFSET], &sample[0], 3=
);
> > +               memcpy(&buffer[MPL3115_BUF_TEMP_OFFSET], &sample[3], 2)=
; =20
>=20
> These two sound to me like something which might require endianness
> handling, but if you put this as CPU native one and leave user space
> to take care of, it may be okay.

They are big endian channels so this 'should' be fine but we should make th=
at explicit.
Not the chan_spec for the 20 bit read has a shift of 12 to get around the l=
ast byte
not being filled by this memcpy.

(other stuff Andy pointed out cropped)

J
