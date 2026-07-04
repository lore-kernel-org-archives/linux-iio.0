Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0476E2FE0F;
	Sat,  4 Jul 2026 22:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783205757; cv=none; b=OP7/rIxWJ4q6zt1V/9QMLLmYsxUVBv0SNr5b4GzuZSk67FhnqHmY6eTh7ODb1OZLiPACP3p4KzWGU5O5xlg+z92vCUPT8Y6ku2hMBqqnC9EtL14+/cuiWLSwHghbYkm/xTHXR3K+P1HbMp8wAQOeYoxppy5blMBeTXX0ykYeJKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783205757; c=relaxed/simple;
	bh=gMOxAOTiDMcgqglffRhUaolpVhS+TkbZGqcKc3iaPTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oUgBq5xaqaNy8NYfan3BpXntztbQY+UA6x1Ou2RQYKVB2C1MsLXRp9Ts/6S3m4zZrsyA1bUQahED/UPsPdeiJEiZ2ESiMlO8TgW4RSbEy6aL0n3VgXPP2hQ+f6qGmG0vGLRlD/anWWk5zNotVLvk8Voze00dpUT9fzaILDZUNvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQcTvk/k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQcTvk/k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D241F000E9;
	Sat,  4 Jul 2026 22:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783205755;
	bh=i/2O/N7A6uIJDSLi7zuTvGsSOCZodge8KzeuNgDZtmM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mQcTvk/k3YXzrOVW66tSxSsnMrAzbPgxCLwFUCjmSKg1cnnWCUQJcBWu0Ubi2Gnpu
	 HRWMVm63ZPN4qzLxtmnkXREC4BSgWm9+aZLin2lsGVh/r06BdrwYz8H58arZvXXlER
	 5SCS/IkjUtnD8YxgW0JyvWn02Zkkc3pojI/JdVIWgoFtCQ91dKNgKGXUcJCtzTZnog
	 WriDZDd1HtwwjO0eM4XUZd1VWQZNzRKYW6bNFUamaT8VRAcDBz+hnfALy0JTtsv26L
	 ru1epyX0eS1tfynDMynGYWVSAPGtLho7OcrUZmHvwwCegKRkr/ebd5DQDpX4o0CVcx
	 5ZV07pWobpdsg==
Date: Sat, 4 Jul 2026 23:55:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, Rodrigo Alencar via B4
 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>,
 rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v6 12/16] iio: frequency: ad9910: add RAM mode support
Message-ID: <20260704235546.4bd66480@jic23-huawei>
In-Reply-To: <1493eed5-5bb8-4a2c-8f2d-8b4bc5dde157@baylibre.com>
References: <20260618-ad9910-iio-driver-v6-0-79125ffbe430@analog.com>
	<20260618-ad9910-iio-driver-v6-12-79125ffbe430@analog.com>
	<20260703040544.08a8ea5e@jic23-huawei>
	<ake_YWfvVC9RQ3wu@nsa>
	<1493eed5-5bb8-4a2c-8f2d-8b4bc5dde157@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 4 Jul 2026 11:50:35 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 7/3/26 9:09 AM, Nuno S=C3=A1 wrote:
> > On Fri, Jul 03, 2026 at 04:05:44AM +0100, Jonathan Cameron wrote: =20
> >> On Thu, 18 Jun 2026 14:27:28 +0100
> >> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kerne=
l.org> wrote:
> >> =20
> >>> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> >>>
> >>> Add RAM control channel, which includes:
> >>> - RAM data loading via firmware upload interface;
> >>> - Per-profile configuration and DDS core parameter destination as fir=
mware
> >>>   metadata;
> >>> - Profile switching relying on profile channels;
> >>> - Sampling frequency control of the active profile;
> >>> - ram-enable-aware read/write paths that redirect single tone
> >>>   frequency/phase/amplitude access through reg_profile cache when RAM=
 is
> >>>   active;
> >>>
> >>> When RAM is enabled, the DDS profile parameters (frequency, phase,
> >>> amplitude) for the single tone mode are sourced from a shadow register
> >>> cache (reg_profile[]) since the profile registers are repurposed for =
RAM
> >>> control.
> >>>
> >>> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com> =20
> >> =20
> >>> diff --git a/drivers/iio/frequency/ad9910.c b/drivers/iio/frequency/a=
d9910.c
> >>> index 3fe97aa887c3..c4e179dda715 100644
> >>> --- a/drivers/iio/frequency/ad9910.c
> >>> +++ b/drivers/iio/frequency/ad9910.c =20
> >> =20
> >>> +static enum fw_upload_err ad9910_ram_fwu_write(struct fw_upload *fw_=
upload,
> >>> +					       const u8 *data, u32 offset,
> >>> +					       u32 size, u32 *written)
> >>> +{
> >>> +	const struct ad9910_ram_fw *fw_data =3D (const struct ad9910_ram_fw=
 *)data;
> >>> +	struct ad9910_state *st =3D fw_upload->dd_handle;
> >>> +	int ret, ret2, idx, wcount;
> >>> +	u64 tmp64, backup;
> >>> +
> >>> +	if (offset !=3D 0)
> >>> +		return FW_UPLOAD_ERR_INVALID_SIZE;
> >>> +
> >>> +	guard(mutex)(&st->lock);
> >>> +
> >>> +	if (st->ram_fwu_cancel)
> >>> +		return FW_UPLOAD_ERR_CANCELED;
> >>> +
> >>> +	if (AD9910_RAM_ENABLED(st))
> >>> +		return FW_UPLOAD_ERR_HW_ERROR;
> >>> +
> >>> +	for (idx =3D 0; idx < AD9910_NUM_PROFILES; idx++)
> >>> +		st->reg_profile[idx] =3D get_unaligned_be64(&fw_data->profiles[idx=
]) |
> >>> +				       AD9910_PROFILE_RAM_OPEN_MSK;
> >>> +
> >>> +	ret =3D ad9910_reg32_update(st, AD9910_REG_CFR1,
> >>> +				  AD9910_CFR1_RAM_PLAYBACK_DEST_MSK |
> >>> +				  AD9910_CFR1_INT_PROFILE_CTL_MSK,
> >>> +				  get_unaligned_be32(&fw_data->cfr1), true);
> >>> +	if (ret)
> >>> +		return FW_UPLOAD_ERR_RW_ERROR;
> >>> +
> >>> +	wcount =3D get_unaligned_be16(&fw_data->wcount);
> >>> +	if (!wcount) {
> >>> +		*written =3D size;
> >>> +		return FW_UPLOAD_ERR_NONE; /* nothing else to write */
> >>> +	}
> >>> +
> >>> +	ret =3D ad9910_profile_set(st, st->profile);
> >>> +	if (ret)
> >>> +		return FW_UPLOAD_ERR_HW_ERROR;
> >>> +
> >>> +	/* backup profile register and update it with required address rang=
e */
> >>> +	backup =3D st->reg[AD9910_REG_PROFILE(st->profile)].val64;
> >>> +	tmp64 =3D AD9910_PROFILE_RAM_STEP_RATE_MSK |
> >>> +		FIELD_PREP(AD9910_PROFILE_RAM_START_ADDR_MSK, 0) |
> >>> +		FIELD_PREP(AD9910_PROFILE_RAM_END_ADDR_MSK, wcount - 1);
> >>> +	ret =3D ad9910_reg64_write(st, AD9910_REG_PROFILE(st->profile), tmp=
64, true);
> >>> +	if (ret)
> >>> +		return FW_UPLOAD_ERR_RW_ERROR;
> >>> +
> >>> +	memcpy(&st->tx_buf[1], fw_data->words, wcount * AD9910_RAM_WORD_SIZ=
E);
> >>> +
> >>> +	/* write ram data and restore profile register */
> >>> +	ret =3D ad9910_spi_write(st, AD9910_REG_RAM,
> >>> +			       wcount * AD9910_RAM_WORD_SIZE, false);
> >>> +	ret2 =3D ad9910_reg64_write(st, AD9910_REG_PROFILE(st->profile), ba=
ckup, true);
> >>> +	if (ret || ret2)
> >>> +		return FW_UPLOAD_ERR_RW_ERROR;
> >>> +
> >>> +	*written =3D size; =20
> >>
> >> I'd like a blank line here. Mostly to make that 'good' return more obv=
ious.
> >> =20
> >>> +	return FW_UPLOAD_ERR_NONE;
> >>> +} =20
> >> =20
> >>> =20
> >>> +static inline void ad9910_debugfs_init(struct ad9910_state *st,
> >>> +				       struct iio_dev *indio_dev)
> >>> +{
> >>> +	struct dentry *d =3D iio_get_debugfs_dentry(indio_dev);
> >>> +	char buf[64];
> >>> +
> >>> +	/*
> >>> +	 * symlinks are created here so iio userspace tools can refer to th=
em
> >>> +	 * as debug attributes. =20
> >>
> >> Maybe worth a reference to appropriate ABI doc here (even if it is int=
roduced
> >> in a later patch) =20
> >=20
> > I'm not so sure about these links. I mean, I definitely agree we should
> > make it easy for userspace tools like libiio to be able to handle
> > these kind of attributes but using debugfs is questionable to me. Pretty
> > much because this is not a debug thing. It is a real setting for the
> > driver so ideally we would be able to control it (using the existent
> > tools) without enforcing one to mount debugfs (I know that most of the
> > times it's always mounted but still feels wrong to tie "real
> > functionality" to debugfs).=20
> >=20
> > Having said the above, some suggestions:
> >=20
> > 1. Make the iio_dev the parent so that the attr name is just "ram" and
> > it will be a subdir /sys/bus/iio/iio:deviceN/ram/.
> > 2. Propose a new helper for the firmware_loader code so we can get
> > struct device from struct fw_upload then we can easily create a sysfs
> > symlink.
> > 3. Name the attr as dev_name(iio_dev):attr so that it becomes
> > iio:deviceN:attr_name.
> >=20
> > Now that I think about it, 2. does not make much sense when compared to
> > 1. And If I'm not missing anything both 1. and 3. can be sanely parsable
> > from userspace (being 3. maybe a bit more reliable). And yes, both requ=
ire
> > user space tools (in this case libiio) to support a new type of
> > attribute (firmware) but that is another problem. =20
>=20
> I would say that udev should be used to find the firmware device from
> userspace rather than creating symlinks. And you probably don't even
> need udev if you already have the `iio-device:<ID>` value. The path
> is always going to be `/sys/class/firmware/iio-device:<ID>:ram/`. It
> seems like the same amount of work for usespace to computer the path
> either way, so might as well keep it simple and leave out the symlink
> stuff.
>=20
Seems reasonable.  We can always come back and add stuff later if a
strong usecases emerges.  Much easier than ripping it out!

Jonathan

> >=20
> > - Nuno S=C3=A1 =20
> >> =20
> >>> +	 */
> >>> +	snprintf(buf, sizeof(buf), "/sys/class/firmware/%s/loading", st->ra=
m_fwu_name);
> >>> +	debugfs_create_symlink("ram_loading", d, buf);
> >>> +
> >>> +	snprintf(buf, sizeof(buf), "/sys/class/firmware/%s/data", st->ram_f=
wu_name);
> >>> +	debugfs_create_symlink("ram_data", d, buf);
> >>> +}
> >>> +
> >>>  static int ad9910_probe(struct spi_device *spi)
> >>>  {
> >>>  	static const char * const supplies[] =3D {
> >>> @@ -1561,7 +1876,25 @@ static int ad9910_probe(struct spi_device *spi=
) =20
> >> ...
> >> =20
> >>> +	ad9910_debugfs_init(st, indio_dev); =20
> >>
> >> Blank line preferred before a simple return like this one.
> >> =20
> >>> +	return 0;
> >>>  }
> >>> =20
> >>>  static const struct spi_device_id ad9910_id[] =3D {
> >>> =20
> >> =20
>=20
>=20

