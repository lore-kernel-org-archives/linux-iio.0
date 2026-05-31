Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107BA1EDA0F;
	Sun, 31 May 2026 10:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780225004; cv=none; b=JXmWaU58aty6AInqk+v3MKPvTG7K+5E6/uO1EKQyGfBOI8mk7bmB1Yz60ulCKTdRIGjvxXQjlG5hrnD6YzUVZpf9pXkhEcjTzJphSYebwgTRK1+Vs2FVnrqdMdZy0P+e9nyvAejzSccojWVrlol4icqakiD31q30tKzUkhsxEuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780225004; c=relaxed/simple;
	bh=IFwQ3ciCWmfvvhOfuesU+o7xVhtZduP60t5XNBtLOVA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cx1riSfYo9vO8FPbKFGpVqCQ8KxRa5owA3NxpdiMRZeW0GbZhc5mnMi0fguFhTqU8THJVReVqw040XrvqhVuK5/JJHLgkARh+kqSD6WxeGc5ZDuHjCxqZmxRWmK6Z9BAo/xbLF/B4DIXKhrqYiY3A3dUoZRz6QjY50ziWT+Izqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9crzifl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9crzifl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD64C1F00893;
	Sun, 31 May 2026 10:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780225002;
	bh=HXU1JtpzpXVGRLWIV+L+tgxdEVMq/LK8ZMB5gNnUkG4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=f9crzifl0M4CJBl7IOk2Hd3GvJarSoGxCmQqKugBHOYb4R1fWsScjOcLEGf2ooB0X
	 zmM9Hd94Nz07GzmCr5Z1zOuV6ZcSPbBJYgqAFTA0GhEVaAxn6Hkp2LhNLy4w/qPRIP
	 F1GoVameHyq0EzMpga7oqw8H/8dvk0Yz3biHCRKd6SOgJI+j0kh2k3NAuPhcZZQa32
	 w3Wai/EFrCL1AWYTKp7Weg5MkBIrr8O3mfnQY9Lxf3KNEUR5cz0yPwe6M7vcDeAWLh
	 N7ZNu6FdgOqX7VZ5J7FY6Ion2y8gU2b0WwLZ8NIDPdIUmkuEn9kWHHmXqAapOvY7kj
	 k2bECrdv2BH9A==
Date: Sun, 31 May 2026 11:56:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jinseob Kim <kimjinseob88@gmail.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 Sa <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v3 3/6] iio: osf: add protocol v0 decoding
Message-ID: <20260531115633.4ce69e04@jic23-huawei>
In-Reply-To: <20260529121005.1470-4-kimjinseob88@gmail.com>
References: <20260529121005.1470-1-kimjinseob88@gmail.com>
	<20260529121005.1470-4-kimjinseob88@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 29 May 2026 21:10:02 +0900
Jinseob Kim <kimjinseob88@gmail.com> wrote:

> Add OSF0 frame validation and payload decoders.
>=20
> Extend MAINTAINERS to cover the protocol decoder.
>=20
> Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>

I've commented on a few things inline. Some of them apply in multiple
places. Biggest thing is asking for rules on how this 'specification'
handled backwards compatibility.

Jonathan

> diff --git a/drivers/iio/opensensorfusion/osf_protocol.c b/drivers/iio/op=
ensensorfusion/osf_protocol.c
> new file mode 100644
> index 000000000..ed91d3dd5
> --- /dev/null
> +++ b/drivers/iio/opensensorfusion/osf_protocol.c

> +
> +int osf_protocol_decode_capability_report(const struct osf_frame *frame,
> +					  struct osf_capability_report *report)
> +{
> +	u16 capability_count;
> +	size_t expected_len;
> +	const u8 *payload;
> +
> +	if (!frame || !report || !frame->payload)
> +		return -EINVAL;
> +
> +	if (frame->message_type !=3D OSF_MSG_CAPABILITY_REPORT)
> +		return -EPROTO;
> +
> +	if (frame->payload_len < OSF_CAP_REPORT_BASE_LEN)
> +		return -EMSGSIZE;
> +
> +	payload =3D frame->payload;
> +	capability_count =3D get_unaligned_le16(payload);
> +
> +	if (get_unaligned_le16(payload + 2))

As below - these zero checks to me look like a protocol design bug.
If you can I'd encourage adding something on rules for backward compatibili=
ty
to your initial spec docs.

> +		return -EPROTO;
> +
> +	if (capability_count > (SIZE_MAX - OSF_CAP_REPORT_BASE_LEN) /
> +	    OSF_CAP_SENSOR_ENTRY_LEN)

Alignment can be easier to read.

	if (capability_count >
	    (SIZE_MAX - OSF_CAP_REPORT_BASE_LEN) / OSF_CAP_SENSOR_ENTRY_LEN)

> +		return -EOVERFLOW;
> +
> +	expected_len =3D OSF_CAP_REPORT_BASE_LEN +
> +		       capability_count * OSF_CAP_SENSOR_ENTRY_LEN;
> +	if (frame->payload_len !=3D expected_len)
> +		return -EMSGSIZE;
> +
> +	report->capability_count =3D capability_count;
> +	report->entries =3D payload + OSF_CAP_REPORT_BASE_LEN;
> +
> +	return 0;
> +}
> +
> +int osf_protocol_decode_capability_entry(const struct osf_capability_rep=
ort *report,
> +					 unsigned int index,
> +					 struct osf_capability_entry *entry)
> +{
> +	u16 sample_format;
> +	u16 sensor_type;
> +	u32 flags;
> +	const u8 *payload;

If no other reason for order, use reverse xmas tree. Also fine to combine e=
ntries of
same type as long as non assign values. Up to you if you'd prefer not to.

	u16 sample_format, sensor_type;
	const u8 *payload;
	u32 flags;
> +
> +	if (!report || !report->entries || !entry)
> +		return -EINVAL;
> +
> +	if (index >=3D report->capability_count)
> +		return -ERANGE;
> +
> +	payload =3D report->entries + index * OSF_CAP_SENSOR_ENTRY_LEN;
> +	sensor_type =3D get_unaligned_le16(payload);
> +	sample_format =3D get_unaligned_le16(payload + 6);
> +	flags =3D get_unaligned_le32(payload + 12);
> +
> +	if (!osf_sensor_type_valid(sensor_type))
> +		return -EPROTO;
> +
> +	if (sample_format !=3D OSF_SAMPLE_FORMAT_S32)
> +		return -EPROTO;
> +
> +	if (flags & ~OSF_CAPABILITY_FLAGS_MASK)
> +		return -EPROTO;
> +
> +	if (get_unaligned_le32(payload + 16))

That needs more info. I guess it's check reserved is 0?
In an extensible protocol design there should be no need to check
that.  If a future version adds stuff in there then there are rules
on how it is done.

1) Not by default, needs to be enabled be aware software.
2) If by default, can be ignored, but must be discoverable - i.e.
   we must know if 0 means the value 0 or reserved0
3) If we can't ignore it then 0 must be natural default.  I.e.
   future capability bits, 0 means not supported.

Upshot, unless the protocol design for future versions is broken
there should never be a reason to check reserved values are 0
other than debug.

If you really need to keep this because the protocol design is
not backwards compatible, then add a comment on what that check is.


> +		return -EPROTO;
> +
> +	entry->sensor_type =3D sensor_type;
> +	entry->sensor_index =3D get_unaligned_le16(payload + 2);
> +	entry->channel_count =3D get_unaligned_le16(payload + 4);
> +	entry->sample_format =3D sample_format;
> +	entry->scale_nano =3D get_unaligned_le32(payload + 8);
> +	entry->flags =3D flags;
> +
> +	return 0;
> +}
> diff --git a/drivers/iio/opensensorfusion/osf_protocol.h b/drivers/iio/op=
ensensorfusion/osf_protocol.h
> new file mode 100644
> index 000000000..4b6fb131a
> --- /dev/null
> +++ b/drivers/iio/opensensorfusion/osf_protocol.h
> @@ -0,0 +1,95 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef _OSF_PROTOCOL_H
> +#define _OSF_PROTOCOL_H
> +
> +#include <linux/types.h>
> +
> +#define OSF_PROTOCOL_MAJOR		0
> +#define OSF_PROTOCOL_MINOR		0
> +#define OSF_FRAME_HEADER_LEN		38
> +#define OSF_FRAME_CRC_LEN		4
> +#define OSF_FRAME_MIN_LEN		(OSF_FRAME_HEADER_LEN + OSF_FRAME_CRC_LEN)
> +
> +#define OSF_SENSOR_SAMPLE_BASE_LEN	16
> +#define OSF_DEVICE_STATUS_LEN		20
> +#define OSF_CAP_REPORT_BASE_LEN		4
> +#define OSF_CAP_SENSOR_ENTRY_LEN		20
> +#define OSF_CAPABILITY_FLAGS_MASK	0x00000003U
> +
> +enum osf_message_type {

Ideally each of these blocks would have a reference to a spec document sect=
ion.
=46rom website I guess that doc is a work in progress?

> +	OSF_MSG_SENSOR_SAMPLE		=3D 0x0001,
> +	OSF_MSG_DEVICE_STATUS		=3D 0x0002,
> +	OSF_MSG_CAPABILITY_REPORT	=3D 0x0003,
> +};
> +
> +enum osf_sensor_type {
> +	OSF_SENSOR_ACCELEROMETER		=3D 0x0001,
> +	OSF_SENSOR_GYROSCOPE		=3D 0x0002,
> +	OSF_SENSOR_MAGNETOMETER		=3D 0x0003,
> +	OSF_SENSOR_BAROMETER		=3D 0x0004,
> +	OSF_SENSOR_TEMPERATURE		=3D 0x0005,
> +	OSF_SENSOR_HUMIDITY		=3D 0x0006,
> +	OSF_SENSOR_AMBIENT_LIGHT		=3D 0x0007,
> +	OSF_SENSOR_PROXIMITY		=3D 0x0008,
> +};
> +
> +enum osf_sample_format {
> +	OSF_SAMPLE_FORMAT_S32		=3D 0x0001,
> +};
> +

> +struct osf_frame {
> +	u8 protocol_minor;
> +	u16 message_type;
> +	u32 payload_len;
> +	u64 sequence;
> +	u64 timestamp_us;
> +	u32 flags;
> +	const u8 *payload;
#
__counted_by_ptr(payload_len); ?

> +	u32 crc;
> +};
> +
> +struct osf_sensor_sample {
> +	u16 sensor_type;
> +	u16 sensor_index;
> +	u16 channel_count;
> +	u16 sample_format;
> +	u32 scale_nano;
> +	const u8 *samples;

I guess we don't know the alignement so can't
type this and that also stops use doing __counted_by_ptr() which
is annoying.

> +};
> +
> +struct osf_device_status {
> +	u32 uptime_s;
> +	u32 status_flags;
> +	u32 error_flags;
> +	u32 dropped_frames;
> +};
> +
> +struct osf_capability_report {
> +	u16 capability_count;
> +	const u8 *entries;
> +};
> +
> +struct osf_capability_entry {
> +	u16 sensor_type;
> +	u16 sensor_index;
> +	u16 channel_count;
> +	u16 sample_format;
> +	u32 scale_nano;
> +	u32 flags;
> +};
