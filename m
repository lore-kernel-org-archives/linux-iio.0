Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540BF372B25;
	Sun, 31 May 2026 11:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780226609; cv=none; b=khMH1y/riqj+WWnOWRdApoA8qmww3TMwPGH/T71DtB+br1opgAXbXjeavhn8P1EhE8vYmnTRHVFvL2ybjWRFMmcAUXJsoYPbp22WKAPl4pSMU0AEx3B/YEoXODoNnktnNl1zzsEgHMHvHFozZJ/4RiWCCGytjWofseKM4oQ2uyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780226609; c=relaxed/simple;
	bh=r+pGOm00sw2+ww5RqaL5SIcQtwCaGfXvIQvULfl0S6k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ljt+Wp211TahbTFFR/YYFlq7rxuSiXOElE7LxWcg816LAuYQhzCLVgMEtqZwgkksiYf4ot5ThINrH4Q5MlHw0wOZtYYaRFGQjVPD+3pRrztIiYt4KeGrArlYasVnW6y+XWNiqcTgvm1RsFXoTXenlBJa7hNI8fcz7f0YajBcyqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DG1ur1nX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DG1ur1nX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E88361F00893;
	Sun, 31 May 2026 11:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780226607;
	bh=rA/Yuj9nIfmQaIdr3i96/J7WeUSOPMEe0JA70MiGt3s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DG1ur1nXBBIs0p7oI5o6ReapQPqeA5mB2Pe0d7QWC0K8OPAPRt382DUTA8GiyWejM
	 23Q5dgjVm3LRtbpqXin13uTWfM759Krbr0+T9QOuCARCptTUENF0PvtkuLoribLLLN
	 erq5AnQWT3DYMbUj7/u6IaiTpKLi2dIPID6QH3nyrHE+Rg3WqeZn2pPfKcedaxwj+h
	 rUMTCMBmxlP+zvNLNv3obnyS643qJuLLNajklhxA8IROsDkZHkX2hH/u8M5HDlQHMz
	 gzfK/etQ7nIzFfud3PWvNd8pZIXbKLgJ0xTcA/psJ7lru53N92e/XXlQ4ZDifmtH4C
	 /ZtEhJqoJILdQ==
Date: Sun, 31 May 2026 12:23:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jinseob Kim <kimjinseob88@gmail.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 Sa <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v3 5/6] iio: osf: add UART serdev transport
Message-ID: <20260531122319.75e18062@jic23-huawei>
In-Reply-To: <20260529121005.1470-6-kimjinseob88@gmail.com>
References: <20260529121005.1470-1-kimjinseob88@gmail.com>
	<20260529121005.1470-6-kimjinseob88@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 May 2026 21:10:04 +0900
Jinseob Kim <kimjinseob88@gmail.com> wrote:

> Register the OSF serdev driver.
> 
> Pass received bytes into the OSF0 stream parser.
> 
> Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>

A few minor things inline.

> diff --git a/drivers/iio/opensensorfusion/osf_core.c b/drivers/iio/opensensorfusion/osf_core.c
> new file mode 100644
> index 000000000..c867b3158
> --- /dev/null
> +++ b/drivers/iio/opensensorfusion/osf_core.c

> +void osf_core_init(struct osf_device *osf, struct device *dev)
> +{
> +	memset(osf, 0, sizeof(*osf));

Looks to me like it's is already guaranteed to be zero. If so don't
clear it again here.

> +	osf->dev = dev;
> +}

> +
> +static int osf_core_validate_capability_report(const struct osf_frame *frame)
> +{
> +	struct osf_capability_entry entry;
> +	struct osf_capability_report report;
> +	unsigned int i;
> +	int ret;
> +
> +	ret = osf_protocol_decode_capability_report(frame, &report);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < report.capability_count; i++) {

	for (unsigned int i = 0;

Is now acceptable in the kernel so use it where appropriate


> +		ret = osf_protocol_decode_capability_entry(&report, i, &entry);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
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
> +		break;
> +	default:
> +		if (frame.message_type >= OSF_RESERVED_MSG_FIRST &&
> +		    frame.message_type <= OSF_RESERVED_MSG_LAST)
> +			ret = 0;
> +		else if (frame.message_type >= OSF_VENDOR_PRIVATE_FIRST)
> +			ret = 0;
> +		else
> +			ret = -EOPNOTSUPP;
I'd return early on error cases so...
> +		break;
> +	}
> +
> +	if (!ret)

.. you can drop this check as you know if you reach here we are in
good path.

It will mean adding a few 
if (ret)
	return ret;
above, but will give a simpler code flow.  Generally, I'd split
the bad path from the good as soon as possible.

> +		osf->last_sequence = frame.sequence;
> +
> +	return ret;
> +}


> +static struct serdev_device_driver osf_serdev_driver = {
> +	.probe = osf_serdev_probe,
> +	.remove = osf_serdev_remove,
> +	.driver = {
> +		.name = "open-sensor-fusion-uart",
> +		.of_match_table = osf_serdev_of_match,
> +	},
> +};
> +

Common convention to have no blank line here to keep that macro
tightly coupled with the structure.

> +module_serdev_device_driver(osf_serdev_driver);
> +
> +MODULE_DESCRIPTION("Open Sensor Fusion IIO driver");
> +MODULE_LICENSE("GPL");

