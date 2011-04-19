Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from nwd2mail10.analog.com ([137.71.25.55]:38627 "EHLO
	nwd2mail10.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754201Ab1DSNKA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 19 Apr 2011 09:10:00 -0400
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Drivers <Drivers@analog.com>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Date: Tue, 19 Apr 2011 14:09:53 +0100
Subject: RE: [PATCH 2/2] IIO-onwards: ADC: AD7298: Use private data space
 from iio_allocate_device
Message-ID: <544AC56F16B56944AEC3BD4E3D591771375475EC50@LIMKCMBX1.ad.analog.com>
References: <1303214170-10379-1-git-send-email-michael.hennerich@analog.com>
 <1303214170-10379-2-git-send-email-michael.hennerich@analog.com>
 <4DAD889F.9060408@cam.ac.uk>
In-Reply-To: <4DAD889F.9060408@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Jonathan Cameron wrote on 2011-04-19:
> On 04/19/11 12:56, michael.hennerich@analog.com wrote:
>> From: Michael Hennerich <michael.hennerich@analog.com>
>>
>> Use private data space from iio_allocate_device
> This is fine as is, but what about the following additional patch..
> At some point I'd like to get rid of the explicit dev_data pointer
> entirely.  Now I 'think' I've cleaned out all the uses of it in here,
> but please do check it still works!
>
> If you are happy with this, shall I just merge this one into your patch?

Sure - Looks good.

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> [PATCH] staging:iio:ad7298: remove use of iio_dev->dev_data.
>
> Also one small cleanup to avoid jumping backwards and forwards between
> iio_dev and ad7298_state for no particular reason.
>
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/adc/ad7298.h      |    4 ++--
>  drivers/staging/iio/adc/ad7298_core.c |    5 ++---
>  drivers/staging/iio/adc/ad7298_ring.c |    8 ++++----
>  3 files changed, 8 insertions(+), 9 deletions(-)
> diff --git a/drivers/staging/iio/adc/ad7298.h
> b/drivers/staging/iio/adc/ad7298.h index 7eb2c3b..628f5ad 100644 ---
> a/drivers/staging/iio/adc/ad7298.h +++
> b/drivers/staging/iio/adc/ad7298.h @@ -54,11 +54,11 @@ struct
> ad7298_state {  };
>
>  #ifdef CONFIG_IIO_RING_BUFFER
> -int ad7298_scan_from_ring(struct ad7298_state *st, long ch);
> +int ad7298_scan_from_ring(struct iio_dev *indio_dev, long ch);
>  int ad7298_register_ring_funcs_and_init(struct iio_dev *indio_dev);
> void ad7298_ring_cleanup(struct iio_dev *indio_dev);  #else /*
> CONFIG_IIO_RING_BUFFER */ -static inline int
> ad7298_scan_from_ring(struct ad7298_state *st, long ch) +static inline
> int ad7298_scan_from_ring(struct iio_dev *indio_dev, long +ch)
>  {
>       return 0;
>  }
> diff --git a/drivers/staging/iio/adc/ad7298_core.c
> b/drivers/staging/iio/adc/ad7298_core.c index 8c0792b..442f48b 100644
> --- a/drivers/staging/iio/adc/ad7298_core.c +++
> b/drivers/staging/iio/adc/ad7298_core.c @@ -117,7 +117,7 @@ static int
> ad7298_read_raw(struct iio_dev *dev_info,
>                          long m)
>  {
>       int ret;
> -     struct ad7298_state *st = dev_info->dev_data;
> +     struct ad7298_state *st = iio_priv(dev_info);
>       unsigned int scale_uv;
>
>       switch (m) {
> @@ -127,7 +127,7 @@ static int ad7298_read_raw(struct iio_dev
> *dev_info,
>                       if (chan->address == AD7298_CH_TEMP)
>                               ret = -ENODEV;
>                       else
> -                             ret = ad7298_scan_from_ring(st, chan->address);
> +                             ret = ad7298_scan_from_ring(dev_info, chan-
>> address);
>>              } else {
>>                      if (chan->address == AD7298_CH_TEMP)
>>                              ret = ad7298_scan_temp(st, val);
> @@ -181,7 +181,6 @@ static int __devinit ad7298_probe(struct spi_device
> *spi)
>
>       indio_dev->name = spi_get_device_id(spi)->name;         indio_dev->dev.parent
>  = &spi->dev; -       indio_dev->dev_data = (void *)(st);
>       indio_dev->driver_module = THIS_MODULE;         indio_dev->modes =
>  INDIO_DIRECT_MODE;   indio_dev->channels = ad7298_channels; diff --git
> a/drivers/staging/iio/adc/ad7298_ring.c
> b/drivers/staging/iio/adc/ad7298_ring.c index ad1f5b7..d0a0aeaaf 100644
> --- a/drivers/staging/iio/adc/ad7298_ring.c +++
> b/drivers/staging/iio/adc/ad7298_ring.c @@ -21,9 +21,9 @@
>
>  #include "ad7298.h"
> -int ad7298_scan_from_ring(struct ad7298_state *st, long ch)
> +int ad7298_scan_from_ring(struct iio_dev *dev_info, long ch)
>  {
> -     struct iio_ring_buffer *ring = iio_priv_to_dev(st)->ring;
> +     struct iio_ring_buffer *ring = dev_info->ring;
>       int ret;
>       u16 *ring_data;
> @@ -59,7 +59,7 @@ error_ret:
>   **/
>  static int ad7298_ring_preenable(struct iio_dev *indio_dev)  {
> -     struct ad7298_state *st = indio_dev->dev_data;
> +     struct ad7298_state *st = iio_priv(indio_dev);
>       struct iio_ring_buffer *ring = indio_dev->ring;
>       size_t d_size;
>       int i, m;
> @@ -121,7 +121,7 @@ static irqreturn_t ad7298_trigger_handler(int irq,
> void *p)  {
>       struct iio_poll_func *pf = p;
>       struct iio_dev *indio_dev = pf->private_data;
> -     struct ad7298_state *st = iio_dev_get_devdata(indio_dev);
> +     struct ad7298_state *st = iio_priv(indio_dev);
>       struct iio_ring_buffer *ring = indio_dev->ring;
>       s64 time_ns;
>       __u16 buf[16];

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret Seif

