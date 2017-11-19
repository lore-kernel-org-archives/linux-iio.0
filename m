Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750807AbdKSMbV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Nov 2017 07:31:21 -0500
Date: Sun, 19 Nov 2017 12:31:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: Re: [PATCH v4 02/12] docs: driver-api: add iio hw consumer section
Message-ID: <20171119123115.06eb6d63@archlinux>
In-Reply-To: <1510222354-15290-3-git-send-email-arnaud.pouliquen@st.com>
References: <1510222354-15290-1-git-send-email-arnaud.pouliquen@st.com>
        <1510222354-15290-3-git-send-email-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 9 Nov 2017 11:12:24 +0100
Arnaud Pouliquen <arnaud.pouliquen@st.com> wrote:

> This adds a section about the Hardware consumer
> Api of the IIO subsystem to the driver API
> documentation.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>

Good little bit of docs.  A couple of minor formatting
comments inline.

Jonathan

> ---
>  Documentation/driver-api/iio/hw-consumer.rst | 50 ++++++++++++++++++++++++++++
>  Documentation/driver-api/iio/index.rst       |  1 +
>  2 files changed, 51 insertions(+)
>  create mode 100644 Documentation/driver-api/iio/hw-consumer.rst
> 
> diff --git a/Documentation/driver-api/iio/hw-consumer.rst b/Documentation/driver-api/iio/hw-consumer.rst
> new file mode 100644
> index 0000000..b777133
> --- /dev/null
> +++ b/Documentation/driver-api/iio/hw-consumer.rst
> @@ -0,0 +1,50 @@
> +===========
> +HW consumer
> +===========
> +An IIO device can be directly connected to another device in hardware. in this
> +case the buffers between IIO provider and IIO consumer are handled by hardware.
> +The Industrial I/O hw consumer offers a way to bond these IIO devices without
> +software buffer for data. The implementation can be found under
> +:file:`drivers/iio/buffer/hw-consumer.c`
> +
> +
> +* struct :c:type:`iio_hw_consumer` — Hardware consumer structure
> +* :c:func:`iio_hw_consumer_alloc` — Allocate IIO hardware consumer
> +* :c:func:`iio_hw_consumer_free` — Free IIO hardware consumer
> +* :c:func:`iio_hw_consumer_enable` — Enable IIO hardware consumer
> +* :c:func:`iio_hw_consumer_disable` — Disable IIO hardware consumer
> +
> +
> +HW consumer setup
> +=================
> +
> +As standard IIO device the implementation is based on IIO provider/consumer.
> +A typical IIO Hw conumer setup looks like this::

HW

> +
> +	static struct iio_hw_consumer *hwc;
> +
> +	static const struct iio_info adc_info = {
> +		.read_raw = adc_read_raw,
> +	};
> +
> +	static int adc_read_raw(struct iio_dev *indio_dev,
> +				struct iio_chan_spec const *chan, int *val,
> +				int *val2, long mask)
> +	{
> +		ret = iio_hw_consumer_enable(hwc);
> +
> +		/* Acquire data */

Blank line here to make it clear the Acquire data doesn't apply to
the line below but is representing a missing block.

> +		ret = iio_hw_consumer_disable(hwc);
> +	}
> +
> +	static int adc_probe(struct platform_device *pdev)
> +	{
> +		hwc = devm_iio_hw_consumer_alloc(&iio->dev);
> +	}
> +
> +More details
> +============
> +.. kernel-doc:: include/linux/iio/hw-consumer.h
> +.. kernel-doc:: drivers/iio/buffer/industrialio-hw-consumer.c
> +   :export:
> +
> diff --git a/Documentation/driver-api/iio/index.rst b/Documentation/driver-api/iio/index.rst
> index e5c3922..7fba341 100644
> --- a/Documentation/driver-api/iio/index.rst
> +++ b/Documentation/driver-api/iio/index.rst
> @@ -15,3 +15,4 @@ Contents:
>     buffers
>     triggers
>     triggered-buffers
> +   hw-consumer

