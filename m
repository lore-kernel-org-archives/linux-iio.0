Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from h1.radempa.de ([176.9.142.194]:38713 "EHLO mail.cosmopool.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751480AbcBVTOb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 22 Feb 2016 14:14:31 -0500
From: Harald Geyer <harald@ccbib.org>
To: Gregor Boirie <gregor.boirie@parrot.com>
cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Matt Ranostay <mranostay@gmail.com>,
	Irina Tirdea <irina.tirdea@intel.com>,
	Darshana Padmadas <darshanapadmadas@gmail.com>,
	Martin Fuzzey <mfuzzey@parkeon.com>,
	Octavian Purdila <octavian.purdila@intel.com>,
	Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
	Crt Mori <cmo@melexis.com>,
	"Masanari Iida" <standby24x7@gmail.com>
Subject: Re: [PATCH v3 1/1] iio:core: timestamping clock selection support
In-reply-to: <be5ff3a84a721d539414f81520bbce9c7c561fe1.1456153753.git.gregor.boirie@parrot.com>
References: <cover.1456153753.git.gregor.boirie@parrot.com> <be5ff3a84a721d539414f81520bbce9c7c561fe1.1456153753.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 22 Feb 2016 20:14:25 +0100
Message-Id: <E1aXvw9-0000bL-Gj@stardust.g4.wien.funkfeuer.at>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Gregor!

Gregor Boirie writes:
> Adds a new per-device sysfs attribute "current_timestamp_clock" to allow
> userspace to select a particular POSIX clock for buffered samples and
> events timestamping.

>  drivers/iio/humidity/dht11.c                      |  16 +-

The dht11 driver only uses timestamps internally. AFAICT they are not
exported to user space, so there is little point in making the clock
selectable.

What's more important: The timestamps are used to decide the validity
of cached values. I think your change introduces a bug where the driver
could report outdated (or even uninitialized) values to user space.

(Actually we switched the driver to monotonic time just recently to fix
this.)

HTH,
Harald

> diff --git a/drivers/iio/humidity/dht11.c b/drivers/iio/humidity/dht11.c
> index 20b500d..a9b1b87 100644
> --- a/drivers/iio/humidity/dht11.c
> +++ b/drivers/iio/humidity/dht11.c
> @@ -110,7 +110,8 @@ static unsigned char dht11_decode_byte(char *bits)
>  	return ret;
>  }
>  
> -static int dht11_decode(struct dht11 *dht11, int offset)
> +static int dht11_decode(const struct iio_dev *iio_dev, struct dht11 *dht11,
> +			int offset)
>  {
>  	int i, t;
>  	char bits[DHT11_BITS_PER_READ];
> @@ -133,7 +134,7 @@ static int dht11_decode(struct dht11 *dht11, int offset)
>  	if (((hum_int + hum_dec + temp_int + temp_dec) & 0xff) != checksum)
>  		return -EIO;
>  
> -	dht11->timestamp = ktime_get_boot_ns();
> +	dht11->timestamp = iio_get_time_ns(iio_dev);
>  	if (hum_int < 20) {  /* DHT22 */
>  		dht11->temperature = (((temp_int & 0x7f) << 8) + temp_dec) *
>  					((temp_int & 0x80) ? -100 : 100);
> @@ -161,7 +162,7 @@ static irqreturn_t dht11_handle_irq(int irq, void *data)
>  
>  	/* TODO: Consider making the handler safe for IRQ sharing */
>  	if (dht11->num_edges < DHT11_EDGES_PER_READ && dht11->num_edges >= 0) {
> -		dht11->edges[dht11->num_edges].ts = ktime_get_boot_ns();
> +		dht11->edges[dht11->num_edges].ts = iio_get_time_ns(iio);
>  		dht11->edges[dht11->num_edges++].value =
>  						gpio_get_value(dht11->gpio);
>  
> @@ -180,8 +181,9 @@ static int dht11_read_raw(struct iio_dev *iio_dev,
>  	int ret, timeres, offset;
>  
>  	mutex_lock(&dht11->lock);
> -	if (dht11->timestamp + DHT11_DATA_VALID_TIME < ktime_get_boot_ns()) {
> -		timeres = ktime_get_resolution_ns();
> +	if (dht11->timestamp + DHT11_DATA_VALID_TIME <
> +	    iio_get_time_ns(iio_dev)) {
> +		timeres = iio_get_time_res(iio_dev);
>  		if (timeres > DHT11_MIN_TIMERES) {
>  			dev_err(dht11->dev, "timeresolution %dns too low\n",
>  				timeres);
> @@ -231,7 +233,7 @@ static int dht11_read_raw(struct iio_dev *iio_dev,
>  		offset = DHT11_EDGES_PREAMBLE +
>  				dht11->num_edges - DHT11_EDGES_PER_READ;
>  		for (; offset >= 0; --offset) {
> -			ret = dht11_decode(dht11, offset);
> +			ret = dht11_decode(iio_dev, dht11, offset);
>  			if (!ret)
>  				break;
>  		}
> @@ -302,7 +304,7 @@ static int dht11_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	dht11->timestamp = ktime_get_boot_ns() - DHT11_DATA_VALID_TIME - 1;
> +	dht11->timestamp = iio_get_time_ns(iio) - DHT11_DATA_VALID_TIME - 1;
>  	dht11->num_edges = -1;
