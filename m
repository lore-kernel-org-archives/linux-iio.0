Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCC6136351;
	Sun, 20 Sep 2026 01:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789868417; cv=none; b=u4xkD1v57kD4jDFecPmGRobfxa1oKpyCJHkebwJq3TD2xKDW3j7WN+ZrsWQrT+kLjPDJDQRhUbiT0X7s25aNkfiLsNH07t1u2tR/0BXltrRfIPyjbDhrAIg4Fy8Fd2qC3zpGaN+hrKp63gQiePD8yNUkwRAU5Ii5ig3Q5UMB7gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789868417; c=relaxed/simple;
	bh=xUcEWe049ke4KcavZ4gwPrM7iE6GiRw9jdweB9FUhes=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VO0HAPwyGfyguVbi+92PKmepF4Ta92mwYr81G4A0sqhwcb+biaXlJbvR4QRmAIfoDpJU9iesI/Tz6YXdcHzsat1hNz92y9MvRRPdHu3zXqA90lnIfeOJYKNbO+2nMiesQa7XzheICb0fgqVWqxn/cwsJc/xVCEMJztRH7bC/NvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aF6IwBGO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aF6IwBGO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B50231F000FF;
	Sun, 20 Sep 2026 01:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789868416;
	bh=bXeR4YyKo+THSV6BScARSO4BJ6RlNj/xo4JGfjxdJhg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aF6IwBGOUxdCMKV+NAHknZGk8SMT2rYIR+Vby4EhP5dFycvLcqWGmslb5JDzgiPXC
	 ePWbVoXdYzO7t8R5NpGdoKqd6m4m4ak56+rj2lUvFLC9TD+tRsmbjMoDrmoBRMGz6S
	 DiGEQA8MCI9IKFwN08jEdZhw+kjJbELUVRYLxbzQSCwZfCPKTL+Qlw3Kgw+a6viZp0
	 vDdYSFzR7RAUQ6IWxCfkf4RnKfAnoaYw3JzmztQNef3UXlvHoP+TqLyQ94mQnuaoLw
	 25T5lg5W3UZhG8GChscGxDq6tfJRVs98DMHdX3SrTruhiVOfSc46pPksaObiDt+kRM
	 JWYWZcom+I9GA==
Date: Sun, 20 Sep 2026 02:40:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jinseob Kim <kimjinseob88@gmail.com>
Cc: linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andriy.shevchenko@intel.com, linux-kernel@vger.kernel.org,
 rdunlap@infradead.org, joshua.crofts1@gmail.com,
 u.kleine-koenig@baylibre.com, julianbraha@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 corbet@lwn.net, skhan@linuxfoundation.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v10 5/8] iio: osf: add UART transport and core receive
 path
Message-ID: <20260920024008.369c21f1@jic23-hlaptop>
In-Reply-To: <5eaeefa79fc2ba956bf34f691c0dc65592e5c4c8.1789753020.git.kimjinseob88@gmail.com>
References: <cover.1789753020.git.kimjinseob88@gmail.com>
	<5eaeefa79fc2ba956bf34f691c0dc65592e5c4c8.1789753020.git.kimjinseob88@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Sep 2026 03:24:43 +0900
Jinseob Kim <kimjinseob88@gmail.com> wrote:

> Connect the stream parser to a serdev receiver and add core frame dispatch
> with an owned device-status cache. Preserve the distinction between
> unvalidated candidates and validated application rejections, so
> malformed status payloads do not cause byte-wise resynchronization.
> 
> Open and configure the UART before enabling the supply. A managed release
> action closes and drains the receive producer before resetting the parser
> and disabling a successfully enabled supply.
> 
> This transport base processes device-status frames and ignores message
> types without an application handler. It does not register IIO sensor
> devices. The following patch adds capability discovery and sample
> publication to IIO, including the publication gate and IIO teardown.
> 
> Assisted-by: LLM
> Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
One question for Uwe if they see it about whether device-id/of.h should
be included or we can assume it for serial drivers.

Otherwise, just a couple of minor things inline.

Thanks,

Jonathan

> ---
>  MAINTAINERS                               |   3 +-
>  drivers/iio/Kconfig                       |   1 +
>  drivers/iio/Makefile                      |   1 +
>  drivers/iio/opensensorfusion/Kconfig      |  12 ++
>  drivers/iio/opensensorfusion/Makefile     |   5 +
>  drivers/iio/opensensorfusion/osf_core.c   | 101 +++++++++++++++
>  drivers/iio/opensensorfusion/osf_core.h   |  29 +++++
>  drivers/iio/opensensorfusion/osf_serdev.c | 143 ++++++++++++++++++++++
>  8 files changed, 293 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/iio/opensensorfusion/Kconfig
>  create mode 100644 drivers/iio/opensensorfusion/Makefile
>  create mode 100644 drivers/iio/opensensorfusion/osf_core.c
>  create mode 100644 drivers/iio/opensensorfusion/osf_core.h
>  create mode 100644 drivers/iio/opensensorfusion/osf_serdev.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bad05db854cf..fbbf5f06f1a5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20516,8 +20516,7 @@ M:	Jinseob Kim <kimjinseob88@gmail.com>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml
>  F:	Documentation/iio/open-sensor-fusion.rst
> -F:	drivers/iio/opensensorfusion/osf_protocol.*
> -F:	drivers/iio/opensensorfusion/osf_stream.*
> +F:	drivers/iio/opensensorfusion/

Push that back to earlier patches.

>  K:	opensensorfusion

> diff --git a/drivers/iio/opensensorfusion/osf_core.c b/drivers/iio/opensensorfusion/osf_core.c
> new file mode 100644
> index 000000000000..e6812cef4d8c
> --- /dev/null
> +++ b/drivers/iio/opensensorfusion/osf_core.c
> @@ -0,0 +1,101 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/types.h>
> +
> +#include "osf_core.h"
> +#include "osf_stream.h"
> +
> +#define OSF_RESERVED_MSG_FIRST		0x7f00
> +#define OSF_RESERVED_MSG_LAST		0x7fff
> +#define OSF_VENDOR_PRIVATE_FIRST	0x8000
> +
> +void osf_core_init(struct osf_device *osf, struct device *dev)
> +{
> +	*osf = (struct osf_device) {
> +		.dev = dev,
> +	};
> +}
Unless this gets a lot more complex in later patches, I'd drop
the helper.


> +int osf_core_receive_frame(struct osf_device *osf, const u8 *buf, size_t len)
> +{
> +	struct osf_frame frame;
> +	size_t frame_len;
> +	int ret;
> +
> +	ret = osf_protocol_decode_frame(buf, len, &frame, &frame_len);
> +	if (ret)
> +		return ret;
> +
> +	if (frame_len != len)
> +		return -EMSGSIZE;
> +
> +	if (frame.protocol_major != OSF_PROTOCOL_MAJOR) {
> +		dev_dbg_ratelimited(osf->dev,
> +				    "ignoring unsupported protocol major %u\n",
> +				    frame.protocol_major);
> +		return OSF_STREAM_FRAME_IGNORED;
> +	}
> +
> +	switch (frame.message_type) {
> +	case OSF_MSG_DEVICE_STATUS:
> +		ret = osf_core_handle_device_status(osf, &frame);
> +		break;
> +	default:
> +		if (frame.message_type >= OSF_RESERVED_MSG_FIRST &&
> +		    frame.message_type <= OSF_RESERVED_MSG_LAST) {
> +			dev_dbg_ratelimited(osf->dev,
> +					    "ignoring reserved message type %#x\n",
> +					    frame.message_type);
> +			return OSF_STREAM_FRAME_IGNORED;
> +		}
> +		if (frame.message_type >= OSF_VENDOR_PRIVATE_FIRST) {
> +			dev_dbg_ratelimited(osf->dev,
> +					    "ignoring vendor message type %#x\n",
> +					    frame.message_type);
> +			return OSF_STREAM_FRAME_IGNORED;
> +		}
> +
> +		dev_dbg_ratelimited(osf->dev,
> +				    "ignoring unsupported message type %#x\n",
> +				    frame.message_type);
> +		return OSF_STREAM_FRAME_IGNORED;
> +	}
> +
> +	/*
> +	 * Handler failures are validated application rejections. Keep the
> +	 * trusted frame boundary and let the stream consume the complete frame.
> +	 */
> +	if (ret < 0)
> +		return OSF_STREAM_FRAME_REJECTED;

I think there is only one path to this.  Move the comment and check up there
+ the return.

Then we never leave the switch statement without returning so this last
chunk isn't needed.

> +
> +	return ret;
> +}

> diff --git a/drivers/iio/opensensorfusion/osf_serdev.c b/drivers/iio/opensensorfusion/osf_serdev.c
> new file mode 100644
> index 000000000000..8a747c01ff9d
> --- /dev/null
> +++ b/drivers/iio/opensensorfusion/osf_serdev.c
> @@ -0,0 +1,143 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/cleanup.h>
> +#include <linux/device-id/of.h>

Curious that in all the recent tidying up of this stuff serdev.h
didn't include this one.  Uwe, if you see this, was that intentional?

Doesn't matter though as if it is something that gets tidied up later
then this driver will get covered with any others.

> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/serdev.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>

> +static int osf_serdev_probe(struct serdev_device *serdev)
> +{
> +	struct device *dev = &serdev->dev;
> +	struct osf_serdev *osf_uart;
> +	unsigned int baudrate;
> +	int ret;
> +
> +	osf_uart = devm_kzalloc(dev, sizeof(*osf_uart), GFP_KERNEL);
> +	if (!osf_uart)
> +		return -ENOMEM;
> +
> +	osf_uart->vcc = devm_regulator_get(dev, "vcc");
> +	if (IS_ERR(osf_uart->vcc))
> +		return dev_err_probe(dev, PTR_ERR(osf_uart->vcc),
> +				     "failed to get vcc regulator\n");
> +
> +	mutex_init(&osf_uart->rx_lock);

Can we use devm_mutex_init() here. It doesn't bring huge advantage
but it is a cheap win for some debugging cases.


> +	osf_uart->serdev = serdev;
> +	osf_core_init(&osf_uart->osf, dev);
> +	osf_stream_init(&osf_uart->stream, osf_serdev_receive_frame,
> +			&osf_uart->osf);
> +
> +	serdev_device_set_drvdata(serdev, osf_uart);
> +	serdev_device_set_client_ops(serdev, &osf_serdev_ops);
> +
> +	ret = serdev_device_open(serdev);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(dev, osf_serdev_release, osf_uart);
> +	if (ret)
> +		return ret;
> +
> +	baudrate = serdev_device_set_baudrate(serdev, OSF_SERDEV_BAUD);
> +	if (baudrate != OSF_SERDEV_BAUD)
> +		/* Keep accepting controller rounding after reporting the mismatch. */
> +		dev_warn_probe(dev, -EINVAL, "requested %u baud, controller set %u\n",
> +			       OSF_SERDEV_BAUD, baudrate);
> +
> +	serdev_device_set_flow_control(serdev, false);
> +
> +	ret = regulator_enable(osf_uart->vcc);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to enable vcc regulator\n");
> +	osf_uart->vcc_enabled = true;
> +
> +	return 0;
> +}


