Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF669317171;
	Thu, 28 May 2026 14:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779977207; cv=none; b=Dr812knkaaJ43BQLnhMNhDODMTePWCnAIxlYGC/rxrX+nkBfb79HDwZ384A0I1NtjNpFseDuXp+Wo5fOsbXgvyrh7XBKYZk0Y/IJ6GFewsXBw6Ws2UppF4j8dXipnz47SqBPFok2DtGeij/N5YFoKvpPxvq+/uy/lQt9kJho3Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779977207; c=relaxed/simple;
	bh=PumwfX3ZSkSKAXww/WfwB8bOJ7+lpDsvlTayOnhJeU0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TDw2Kcs/WNSy47IaGOTxMKqm84UYKR6nH7A0zg8TAesl/5BurfvJGfNPIjQ9/8EkHt7OHF5nGpZMaIe5Uv97bXkSio6x7WdQwGaSUKxGWzn/uCxF8tlIHsxTXwV11ovoV5t5j96WhCGCbDQGAiayyyE5j4XxLF0V1Uf7S1H0C/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLsrV9Yg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLsrV9Yg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8F391F000E9;
	Thu, 28 May 2026 14:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779977205;
	bh=RKvz/4EOqIVhSz/IJ4p06G8eVomZ5XVVmZ7JKCeU/1I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZLsrV9YggTuXZNpn1NshPzPLAnvyndxAL5vPrrinh8KwJukW6nQSAN041PV0SdrPW
	 eCcNfeq70QZ8KbLLICZXuLZUrFJA0kEerPC75p0LHdn93ZUR1O2BdS3p4vok58Es7D
	 WTpa7tZbyMIIPqqn7xp+0NccxawIrHxn8Web3MkS7O/ZEyZKJ6RzfpKVq0LFSwi831
	 ntonJIXh3JeeaWbmZpPmvZoPcEKs59NHR+QRVgiDh2srF1OYX0Sdi54y2DvrI6vL3M
	 U2yvq3LUNzkUI5ZZ6ObgngPYFs/saQyYKm7i0/WGQH64Ey/GRJ4VQAlWRu5o9Owbnb
	 Lg7a1qqmz4qjw==
Date: Thu, 28 May 2026 15:06:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jinseob Kim <kimjinseob88@gmail.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 5/7] iio: osf: add UART serdev transport
Message-ID: <20260528150636.38d8e091@jic23-huawei>
In-Reply-To: <20260524085312.15369-6-kimjinseob88@gmail.com>
References: <20260524085312.15369-1-kimjinseob88@gmail.com>
	<20260524085312.15369-6-kimjinseob88@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 24 May 2026 17:53:10 +0900
Jinseob Kim <kimjinseob88@gmail.com> wrote:

> Add the serdev receive path that feeds decoded OSF0 frames to the core.
> 
> Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
Various things inline.

> diff --git a/drivers/iio/opensensorfusion/Kconfig b/drivers/iio/opensensorfusion/Kconfig
> new file mode 100644
> index 000000000..360f25b4f
> --- /dev/null
> +++ b/drivers/iio/opensensorfusion/Kconfig
> @@ -0,0 +1,15 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config OPEN_SENSOR_FUSION
> +	tristate "Open Sensor Fusion UART IIO driver"
> +	depends on IIO
> +	depends on SERIAL_DEV_BUS
> +	select CRC32
> +	help
> +	  Build the Open Sensor Fusion UART receive path.
> +
> +	  The driver receives OSF0 frames over a serdev UART.
> +	  Frames are decoded and validated before being passed to the
> +	  driver core.
> +	  This patch only adds the transport path.
> +	  IIO device registration is added separately.

Why is help text talking about a patch?

> diff --git a/drivers/iio/opensensorfusion/osf_core.c b/drivers/iio/opensensorfusion/osf_core.c
> new file mode 100644
> index 000000000..c867b3158
> --- /dev/null
> +++ b/drivers/iio/opensensorfusion/osf_core.c
> @@ -0,0 +1,107 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/errno.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
> +
> +#include "osf_core.h"
> +#include "osf_protocol.h"
> +
> +#define OSF_RESERVED_MSG_FIRST		0x7f00
> +#define OSF_RESERVED_MSG_LAST		0x7fff
> +#define OSF_VENDOR_PRIVATE_FIRST	0x8000
> +
> +void osf_core_init(struct osf_device *osf, struct device *dev)
> +{
> +	memset(osf, 0, sizeof(*osf));

You zero them memory before passing to this.  That seems like a sensible
pattern in which case this memset is unneeded.

> +	osf->dev = dev;
> +}

> +
> +int osf_core_receive_frame(struct osf_device *osf, const u8 *buf, size_t len)
> +{
> +	struct osf_frame frame;
> +	size_t frame_len;
> +	int ret;
> +
> +	if (!osf || !buf)
> +		return -EINVAL;

If these can happen add a comment on why. If not remove them as overly cautious
checking.

> +
> +	ret = osf_protocol_decode_frame(buf, len, &frame, &frame_len);
> +	if (ret)
> +		return ret;
> +
> +	if (frame_len != len)
> +		return -EMSGSIZE;
> +
> +	switch (frame.message_type) {
> +	case OSF_MSG_SENSOR_SAMPLE:
> +		ret = osf_core_validate_sensor_sample(&frame);
> +		break;
> +	case OSF_MSG_DEVICE_STATUS:
> +		ret = osf_core_validate_device_status(&frame);
> +		break;
> +	case OSF_MSG_CAPABILITY_REPORT:
> +		ret = osf_core_validate_capability_report(&frame);

Perhaps check ret in each of these and return early if set. Then we only
do the shared path below on success.

> +		break;
> +	default:
> +		if (frame.message_type >= OSF_RESERVED_MSG_FIRST &&
> +		    frame.message_type <= OSF_RESERVED_MSG_LAST)
> +			ret = 0;
> +		else if (frame.message_type >= OSF_VENDOR_PRIVATE_FIRST)
> +			ret = 0;
> +		else
> +			ret = -EOPNOTSUPP;

Given there is nothing else to do on error, return -EOPNOTSUPP; perhaps.

> +		break;
> +	}
> +
> +	if (!ret)
> +		osf->last_sequence = frame.sequence;
> +
> +	return ret;
> +}

> diff --git a/drivers/iio/opensensorfusion/osf_serdev.c b/drivers/iio/opensensorfusion/osf_serdev.c
> new file mode 100644
> index 000000000..f121089ed
> --- /dev/null
> +++ b/drivers/iio/opensensorfusion/osf_serdev.c


> +
> +static int osf_serdev_probe(struct serdev_device *serdev)
> +{
> +	struct osf_serdev *osf_uart;
> +	unsigned int baudrate;
> +	int ret;
> +
> +	osf_uart = devm_kzalloc(&serdev->dev, sizeof(*osf_uart), GFP_KERNEL);
> +	if (!osf_uart)
> +		return -ENOMEM;
> +
> +	osf_uart->serdev = serdev;
> +	osf_core_init(&osf_uart->osf, &serdev->dev);
> +	osf_stream_init(&osf_uart->stream, &osf_uart->osf);
> +
> +	serdev_device_set_drvdata(serdev, osf_uart);
> +	serdev_device_set_client_ops(serdev, &osf_serdev_ops);
> +
> +	ret = serdev_device_open(serdev);
> +	if (ret)
> +		return ret;
> +
> +	baudrate = serdev_device_set_baudrate(serdev, OSF_SERDEV_BAUD);
> +	if (baudrate != OSF_SERDEV_BAUD)
> +		dev_warn(&serdev->dev, "requested %u baud, controller set %u\n",
> +			 OSF_SERDEV_BAUD, baudrate);
> +
> +	serdev_device_set_flow_control(serdev, false);
> +
> +	return 0;
> +}
> +
> +static void osf_serdev_remove(struct serdev_device *serdev)
> +{
> +	struct osf_serdev *osf_uart = serdev_device_get_drvdata(serdev);
> +
> +	serdev_device_close(serdev);
> +	osf_stream_reset(&osf_uart->stream);
> +	osf_core_unregister_iio(&osf_uart->osf);

Given these don't match up with things in probe() please add some comments
to explain what they are undoing.

> +}

