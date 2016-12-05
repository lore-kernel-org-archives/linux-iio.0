Return-Path: <SRS0=U0ul=XU=lwn.net=corbet@kernel.org>
Date: Mon, 5 Dec 2016 14:31:43 -0700
From: Jonathan Corbet <corbet@lwn.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
 daniel.baluta@intel.com
Subject: Re: [PATCH] docs: IIO documentation
Message-ID: <20161205143143.177a9570@lwn.net>
In-Reply-To: <20161204204906.27327-2-jic23@kernel.org>
References: <20161204204906.27327-1-jic23@kernel.org>
	<20161204204906.27327-2-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sun,  4 Dec 2016 20:49:06 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> This is a manual conversion of the existing DocBook documentation
> for IIO.  The intent is not to substantially change any of the
> content in this patch, but to give a base to build upon.

Looks mostly good, a couple of brief notes below.

> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  Documentation/driver-api/iio/buffers.rst           | 127 +++++++++++++++
>  Documentation/driver-api/iio/core.rst              | 180 +++++++++++++++++++++
>  Documentation/driver-api/iio/index.rst             |  15 ++
>  Documentation/driver-api/iio/intro.rst             |  23 +++
>  Documentation/driver-api/iio/triggered-buffers.rst |  70 ++++++++
>  Documentation/driver-api/iio/triggers.rst          |  78 +++++++++
>  Documentation/driver-api/index.rst                 |   1 +
>  7 files changed, 494 insertions(+)

Please go ahead and remove iio.tmpl when you do this conversion, there's no
reason to keep it around afterward.

> diff --git a/Documentation/driver-api/iio/buffers.rst b/Documentation/driver-api/iio/buffers.rst
> new file mode 100644
> index 000000000000..559256b8e607
> --- /dev/null
> +++ b/Documentation/driver-api/iio/buffers.rst
> @@ -0,0 +1,127 @@
> +======================
> +Industrial I/O Buffers
> +======================
> +
> +* struct :c:type:`iio_buffer` — general buffer structure
> +* :c:func:`iio_validate_scan_mask_onehot` — Validates that exactly one channel
> +  is selected
> +* :c:func:`iio_buffer_get` — Grab a reference to the buffer
> +* :c:func:`iio_buffer_put` — Release the reference to the buffer
> +
> +The Industrial I/O core offers a way for continuous data capture based on a
> +trigger source. Multiple data channels can be read at once from
> +*/dev/iio:deviceX* character device node, thus reducing the CPU load.
> +
> +IIO buffer sysfs interface
> +==========================
> +An IIO buffer has an associated attributes directory under
> +*/sys/bus/iio/iio:deviceX/buffer/*. Here are the existing attributes:
> +
> +* *length*, the total number of data samples (capacity) that can be stored by
> +  the buffer.
> +* *enable*, activate buffer capture.
> +
> +IIO buffer setup
> +================
> +
> +The meta information associated with a channel reading placed in a buffer is
> +called a scan element . The important bits configuring scan elements are
> +exposed to userspace applications via the
> +*/sys/bus/iio/iio:deviceX/scan_elements/* directory. This file contains
> +attributes of the following form:
> +
> +* *enable*, used for enabling a channel. If and only if its attribute is non
> +  *zero*, then a triggered capture will contain data samples for this channel.
> +* *type*, description of the scan element data storage within the buffer and
> +  hence the form in which it is read from user space.
> +  Format is [be|le]:[s|u]bits/storagebitsXrepeat[>>shift] .
> +  * *be* or *le*, specifies big or little endian.
> +  * *s* or *u*, specifies if signed (2's complement) or unsigned.
> +  * *bits*, is the number of valid data bits.
> +  * *storagebits*, is the number of bits (after padding) that it occupies in the
> +  buffer.
> +  * *shift*, if specified, is the shift that needs to be applied prior to
> +  masking out unused bits.
> +  * *repeat*, specifies the number of bits/storagebits repetitions. When the
> +  repeat element is 0 or 1, then the repeat value is omitted.
> +
> +For example, a driver for a 3-axis accelerometer with 12 bit resolution where data is stored in two 8-bits registers as follows:
> +
> +::

It would be nice to break the really long lines for future editing comfort.

Also worth noting: you can put the double colon at the end of the leading
line, i.e.:

      data is stored in two 8-bit registers as follows::

        <ascii art here>

Doing it that way makes the RST file a bit more readable, IMO.

Thanks for doing this,

jon
