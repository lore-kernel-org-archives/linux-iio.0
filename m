Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC84B27456;
	Sun, 14 Jun 2026 18:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781462359; cv=none; b=LsKxcpNI+Q2RR/twcXvPrZkNQI/e96Z98pzJAi8tIlij75judlvuUduQaPbl+VojbNs8aH8x8VnrISZxZywOJWCh7JjEw18LuJwyaGXtJc89nlYVGFplTAVo8dmyo7ecqgU97692LqRTntI40nW86ebUAhgo7QJNuNdRLHKHk5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781462359; c=relaxed/simple;
	bh=RvjanMXVdoCHU+sEKBQhBXK5YAKZqCB8TNkccJmoPSs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kHc5BKwVvymzwdlDgeWwITtVEzP3xe57YBwZUJzgkIACG7jN1KoRql10owoJ/EdNqxs7k4+O1lkNBiC4brzssN6VKsxl7fisdp06vrD/OP8i9KK/hj7MqQukFxnD8rs//cpp1RG8NnBoWqmUOVO5EDm9YDcceRVb1M5t+u6hzRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZiKpEf5O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZiKpEf5O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C1B1F000E9;
	Sun, 14 Jun 2026 18:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781462358;
	bh=hnZfNV60rAigRH3hQ4LjU7AzmRwytb/8rJxqwv+6ofY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZiKpEf5OxsPd1Nkh+F1JJalGQKKc/kPNvOXtqEtqkPYirZzUpPNO7nilaZ5zVcI8I
	 RBunmijVI/1d0WJUoFsc5JAjhZdHfjSxCxRhnljCPf6E8mgIwZOIn/Aed124K3iP8f
	 Y8yWeQmtOzrIqi03ZvXqohbRUU/IeFNzVfP6Q4uydjckpbYjflDVkdWCZrOJDr9NjN
	 rgFiXDxfgJlARjntwvNCeSPXys05bLRdcAB2sm4YEc32qhthGKRe9f9ZufPaBqQZ/6
	 2DiN/rpevR2R7qPWTHyb7sW2yhwVMsuaNPSef7llnrk1Tg/DOiqduzu7vyinJWURNP
	 QDiuUOehFWIlg==
Date: Sun, 14 Jun 2026 19:39:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Herman van Hazendonk <github.com@herrie.org>
Cc: linusw@kernel.org, denis.ciocca@st.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, sanjayembeddedse@gmail.com,
 maudspierings@gocontroll.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: common: st_sensors: honour channel endianness
 in read_axis_data
Message-ID: <20260614193908.522272ed@jic23-huawei>
In-Reply-To: <0dac8e8e2872dc180b138923b5cd4fd18eee047b.1780652883.git.github.com@herrie.org>
References: <cover.1780652883.git.github.com@herrie.org>
	<0dac8e8e2872dc180b138923b5cd4fd18eee047b.1780652883.git.github.com@herrie.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri,  5 Jun 2026 12:08:41 +0200
Herman van Hazendonk <github.com@herrie.org> wrote:

> st_sensors_read_axis_data() unconditionally decoded multi-byte
> results with get_unaligned_le16() / get_unaligned_le24() regardless
> of the channel's declared scan_type.endianness.
>=20
> For every ST sensor that has used this helper since it was introduced
> this happened to be fine because the ST IMU/accel/gyro/pressure
> families publish their data registers as little-endian and the
> channel specs in those drivers declare IIO_LE accordingly.
>=20
> The LSM303DLH magnetometer however publishes its X/Y/Z output as a
> pair of big-endian bytes (the H register sits at the lower address,
> 0x03/0x05/0x07, and the L register immediately after), and its
> channel specs in st_magn_core.c correctly declare IIO_BE -- but
> read_axis_data() ignored that and decoded as little-endian, swapping
> the high and low bytes of every magnetometer sample.
>=20
> The bug is most visible on a stationary chip: in earth's field the
> true X reading is small and the high byte sits at 0x00, so swapping
> the bytes pins sysfs X at exactly the low byte's pattern (e.g. 0x00F0
> =3D 240). Y and Z still appear "to vary" because their magnitudes are
> larger and the noise in the low byte produces big swings in the
> swapped high byte:
>=20
>   before (chip flat, sysfs in_magn_*_raw):
>       X=3D240 (stuck), Y=3D 12032..23296, Z=3D-16128..-9728
>=20
>   after (direct i2c-dev big-endian decode, same chip same orientation):
>       X=E2=89=88-4096, Y=E2=89=88210, Z=E2=89=8880     (sensible values r=
eflecting earth's
>                                 ambient field at low gauss range)
>=20
> Fix read_axis_data() to dispatch on ch->scan_type.endianness and
> call get_unaligned_be16() / get_unaligned_be24() when the channel
> declares IIO_BE. Existing IIO_LE consumers (st_accel, st_gyro,
> st_pressure, st_lsm6dsx and others) are unaffected because their
> channel specs already declare IIO_LE and the LE path is unchanged.
>=20
Hi Herman,

Fixes tag please.   We want to know how far to backport and provide
info to those trying to work out if the bug affects their kernel
trees.

Thanks

Jonathan

> Signed-off-by: Herman van Hazendonk <github.com@herrie.org>

