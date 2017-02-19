Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38021 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751279AbdBSONP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Feb 2017 09:13:15 -0500
Subject: Re: [RFC v2 1/7] iio: Add hardware consumer support
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
References: <1487003909-11710-1-git-send-email-arnaud.pouliquen@st.com>
 <1487003909-11710-2-git-send-email-arnaud.pouliquen@st.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        kernel@stlinux.com, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        olivier moysan <olivier.moysan@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <f796e9ec-72b3-85f9-237f-8d19d89a9846@kernel.org>
Date: Sun, 19 Feb 2017 14:13:07 +0000
MIME-Version: 1.0
In-Reply-To: <1487003909-11710-2-git-send-email-arnaud.pouliquen@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/02/17 16:38, Arnaud Pouliquen wrote:
> Hardware consumer's can be used when one IIO device has a direct connection
> to another device in hardware.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Quick process point. If you are 'handling' a patch like this from someone
else you should also sign off on it as well as the original author. We
need to keep track of the path a patch took as well as who originally wrote
it.

Clearly this is an RFC so some of the comments below don't really apply at
this stage. It's easy to note them whilst reading though so I have done
so!

It's interesting to see explicit support in here for multiplexing streams
from different iio_devs.

Anyhow, guess I'd better look at how it is used before drawing too many
conclusions :)
> ---
>  drivers/iio/Kconfig             |   6 ++
>  drivers/iio/Makefile            |   1 +
>  drivers/iio/hw_consumer.c       | 156 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/iio/hw_consumer.h |  12 ++++
>  4 files changed, 175 insertions(+)
>  create mode 100644 drivers/iio/hw_consumer.c
>  create mode 100644 include/linux/iio/hw_consumer.h
> 
> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> index 6743b18..956dd18 100644
> --- a/drivers/iio/Kconfig
> +++ b/drivers/iio/Kconfig
> @@ -30,6 +30,12 @@ config IIO_CONFIGFS
>  	  (e.g. software triggers). For more info see
>  	  Documentation/iio/iio_configfs.txt.
>  
> +config IIO_HW_CONSUMER
> +	tristate
> +	help
> +	  Hardware consumer buffer
Needs some proper help that actually tells us what it is for.
> +
> +
>  config IIO_TRIGGER
>  	bool "Enable triggered sampling support"
>  	help
> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> index 87e4c43..8472b97 100644
> --- a/drivers/iio/Makefile
> +++ b/drivers/iio/Makefile
> @@ -6,6 +6,7 @@ obj-$(CONFIG_IIO) += industrialio.o
>  industrialio-y := industrialio-core.o industrialio-event.o inkern.o
>  industrialio-$(CONFIG_IIO_BUFFER) += industrialio-buffer.o
>  industrialio-$(CONFIG_IIO_TRIGGER) += industrialio-trigger.o
> +obj-$(CONFIG_IIO_HW_CONSUMER) += hw_consumer.o
>  
>  obj-$(CONFIG_IIO_CONFIGFS) += industrialio-configfs.o
>  obj-$(CONFIG_IIO_SW_DEVICE) += industrialio-sw-device.o
> diff --git a/drivers/iio/hw_consumer.c b/drivers/iio/hw_consumer.c
> new file mode 100644
> index 0000000..66f0732
> --- /dev/null
> +++ b/drivers/iio/hw_consumer.c
> @@ -0,0 +1,156 @@
> +#include <linux/err.h>
> +#include <linux/export.h>
> +#include <linux/slab.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +
> +#include <linux/iio/iio.h>
> +#include "iio_core.h"
> +#include <linux/iio/machine.h>
> +#include <linux/iio/driver.h>
> +#include <linux/iio/consumer.h>
> +#include <linux/iio/hw_consumer.h>
> +#include <linux/iio/buffer.h>
> +
> +struct iio_hw_consumer {
> +	struct list_head buffers;
> +	struct iio_channel *channels;
> +};
> +
> +struct hw_consumer_buffer {
> +	struct list_head head;
> +	struct iio_dev *indio_dev;
> +	struct iio_buffer buffer;
> +};
> +
> +static struct hw_consumer_buffer *iio_buffer_to_hw_consumer_buffer(
> +	struct iio_buffer *buffer)
> +{
> +	return container_of(buffer, struct hw_consumer_buffer, buffer);
> +}
> +
> +static void iio_hw_buf_release(struct iio_buffer *buffer)
> +{
> +	struct hw_consumer_buffer *hw_buf =
> +		iio_buffer_to_hw_consumer_buffer(buffer);
> +	kfree(hw_buf->buffer.scan_mask);
> +	kfree(hw_buf);
> +}
> +
> +static const struct iio_buffer_access_funcs iio_hw_buf_access = {
> +	.release = &iio_hw_buf_release,
> +	.modes = INDIO_BUFFER_HARDWARE,
> +};
> +
I would like to see some kernel-doc description here. In particular the
fact that it is only getting buffers if they haven't already been obtained
should be highlighted.
> +static struct hw_consumer_buffer *iio_hw_consumer_get_buffer(
> +	struct iio_hw_consumer *hwc, struct iio_dev *indio_dev)
> +{
> +	struct hw_consumer_buffer *buf;
> +
> +	list_for_each_entry(buf, &hwc->buffers, head) {
> +		if (buf->indio_dev == indio_dev)
> +			return buf;
> +	}
> +
> +	buf = kzalloc(sizeof(*buf), GFP_KERNEL);
> +	if (!buf)
> +		return NULL;
> +
> +	buf->buffer.access = &iio_hw_buf_access;
> +	buf->indio_dev = indio_dev;
> +	buf->buffer.scan_mask = kcalloc(BITS_TO_LONGS(indio_dev->masklength),
> +		sizeof(long), GFP_KERNEL);
> +	if (!buf->buffer.scan_mask)
> +		goto err_free_buf;
> +
> +	iio_buffer_init(&buf->buffer);
> +	list_add_tail(&buf->head, &hwc->buffers);
> +
> +	return buf;
> +
> +err_free_buf:
> +	kfree(buf);
> +	return NULL;
> +}
> +
> +struct iio_hw_consumer *iio_hw_consumer_alloc(struct device *dev)
> +{
> +	struct hw_consumer_buffer *buf;
> +	struct iio_hw_consumer *hwc;
> +	struct iio_channel *chan;
> +	int ret;
> +
> +	hwc = kzalloc(sizeof(*hwc), GFP_KERNEL);
> +	if (!hwc)
> +		return ERR_PTR(-ENOMEM);
> +
> +	INIT_LIST_HEAD(&hwc->buffers);
> +
> +	hwc->channels = iio_channel_get_all(dev);
> +	if (IS_ERR(hwc->channels)) {
> +		ret = PTR_ERR(hwc->channels);
> +		goto err_free_hwc;
> +	}
> +
> +	chan = &hwc->channels[0];
> +	while (chan->indio_dev) {
> +		buf = iio_hw_consumer_get_buffer(hwc, chan->indio_dev);
Chances are these are all from the same provider device so this is a little
interesting at first glance.  Ah, the get_buffer is handling that. Fair enough
though will want comments to make that clear.
> +		if (buf == NULL) {
> +			ret = -ENOMEM;
> +			goto err_put_buffers;
> +		}
> +		set_bit(chan->channel->scan_index, buf->buffer.scan_mask);
> +		chan++;
> +	}
> +
> +	return hwc;
> +
> +err_put_buffers:
> +	list_for_each_entry(buf, &hwc->buffers, head)
> +		iio_buffer_put(&buf->buffer);
This seems to be putting a lot of buffers we don't (at first glance)
seem to have 'gotten' - hence please add a comment saying where they came
from.
> +	iio_channel_release_all(hwc->channels);
> +err_free_hwc:
> +	kfree(hwc);
> +	return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL_GPL(iio_hw_consumer_alloc);
> +
> +void iio_hw_consumer_free(struct iio_hw_consumer *hwc)
> +{
> +	struct hw_consumer_buffer *buf;
> +
> +	iio_channel_release_all(hwc->channels);
> +	list_for_each_entry(buf, &hwc->buffers, head)
> +		iio_buffer_put(&buf->buffer);
> +	kfree(hwc);
> +}
> +EXPORT_SYMBOL_GPL(iio_hw_consumer_free);
> +
> +int iio_hw_consumer_enable(struct iio_hw_consumer *hwc)
> +{
> +	struct hw_consumer_buffer *buf;
> +	int ret;
> +
> +	list_for_each_entry(buf, &hwc->buffers, head) {
> +		ret = iio_update_buffers(buf->indio_dev, &buf->buffer, NULL);
This is interesting.  It will build the demux table etc, but I suppose
that doesn't matter if the very nature of thing is that we don't actually
have any data flowing...
> +		if (ret)
> +			goto err_disable_buffers;
> +	}
> +
> +	return 0;
> +
> +err_disable_buffers:
> +	list_for_each_entry_continue_reverse(buf, &hwc->buffers, head)
> +		iio_update_buffers(buf->indio_dev, NULL, &buf->buffer);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iio_hw_consumer_enable);
> +
> +void iio_hw_consumer_disable(struct iio_hw_consumer *hwc)
> +{
> +	struct hw_consumer_buffer *buf;
> +
> +	list_for_each_entry(buf, &hwc->buffers, head)
> +		iio_update_buffers(buf->indio_dev, NULL, &buf->buffer);
> +}
> +EXPORT_SYMBOL_GPL(iio_hw_consumer_disable);
> diff --git a/include/linux/iio/hw_consumer.h b/include/linux/iio/hw_consumer.h
> new file mode 100644
> index 0000000..f12653d
> --- /dev/null
> +++ b/include/linux/iio/hw_consumer.h
> @@ -0,0 +1,12 @@
> +#ifndef LINUX_IIO_HW_CONSUMER_BUFFER_H
> +#define LINUX_IIO_HW_CONSUMER_BUFFER_H
> +
> +struct device;
> +struct iio_hw_consumer;
> +
> +struct iio_hw_consumer *iio_hw_consumer_alloc(struct device *dev);
> +void iio_hw_consumer_free(struct iio_hw_consumer *hwc);
> +int iio_hw_consumer_enable(struct iio_hw_consumer *hwc);
> +void iio_hw_consumer_disable(struct iio_hw_consumer *hwc);
> +
> +#endif
> 

