Return-Path: <Fabien.Proriol@jdsu.com>
From: Fabien Proriol <Fabien.Proriol@jdsu.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michal Simek <michal.simek@xilinx.com>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
Subject: Re: [PATCH] 0001-xilinx-xadc-core-Fix-voltage-offset.patch
Date: Fri, 5 Dec 2014 16:12:13 +0000
Message-ID: <5481D8F1.7040703@jdsu.com>
References: <545B9479.5030700@jdsu.com> <545B976D.4080303@metafoo.de>
 <545B9EF1.8000606@jdsu.com> <545BA105.70105@metafoo.de>
 <545BA802.5090206@jdsu.com> <54690AE5.4050900@metafoo.de>
 <5469B725.8080908@jdsu.com> <5469B7FF.6050500@metafoo.de>
 <54707707.5040200@kernel.org>
In-Reply-To: <54707707.5040200@kernel.org>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On 22/11/2014 12:44, Jonathan Cameron wrote:
> Hi
>
> This patch appears to be against a relatively ancient kernel.
> Would you mind rebasing it on linus' current tree?
>
> Thanks,
>
> Jonathan

Ok, this is the patch rebase on Linus Trovald master


>From 8833373032c2c4a48569137e0d10804131b98f1d Mon Sep 17 00:00:00 2001
From: Fabien Proriol <fabien.proriol@jdsu.com>
Date: Mon, 17 Nov 2014 09:46:02 +0100
Subject: [PATCH] iio: Fix iio_channel_read return if channel havn't info

iio_channel_read must return an error to avoid offset for channel
without IIO_CHAN_INFO_OFFSET property

Signed-off-by: Fabien Proriol <fabien.proriol@jdsu.com>
---
 drivers/iio/inkern.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index f084610..d33590e 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -426,6 +426,9 @@ static int iio_channel_read(struct iio_channel *chan, i=
nt *val, int *val2,
        if (val2 =3D=3D NULL)
                val2 =3D &unused;
=20
+       if(!iio_channel_has_info(chan->channel, info))
+               return -EINVAL;
+
        if (chan->indio_dev->info->read_raw_multi) {
                ret =3D chan->indio_dev->info->read_raw_multi(chan->indio_d=
ev,
                                        chan->channel, INDIO_MAX_RAW_ELEMEN=
TS,
--=20
2.0.4
