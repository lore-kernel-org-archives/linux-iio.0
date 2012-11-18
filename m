Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34400 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752093Ab2KRSsF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 18 Nov 2012 13:48:05 -0500
Message-ID: <50A92D62.3060009@kernel.org>
Date: Sun, 18 Nov 2012 18:48:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: kbuild test robot <fengguang.wu@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [iio:togreg 24/24] drivers/iio/adc/ad7298.c:125:23: sparse: incorrect
 type in assignment (different base types)
References: <50a787d6.NK04zL7PgCPbLOrx%fengguang.wu@intel.com> <50A8E5DF.7000607@kernel.org> <50A8EE71.8090302@metafoo.de> <50A92AB4.3050707@kernel.org>
In-Reply-To: <50A92AB4.3050707@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/18/2012 06:36 PM, Jonathan Cameron wrote:
> On 11/18/2012 02:19 PM, Lars-Peter Clausen wrote:
>> On 11/18/2012 02:42 PM, Jonathan Cameron wrote:
>>> Hi Lars-Peter
>>>
>>> Hmm. currious. I'd not normally have that check on - for reference
>>> this only happens for me with CF="-D__CHECK_ENDIAN__" appeneded to my
>>> normal make for the kernel.
>>>
>>> Anyhow, initial thought was to change rx_buf and tx_buf to __be16.
>>> Can you see any issues with that?
>>>
>>
>> I actually had such a patch initially in my series, but removed it again, since
>> we are using the buffer as non __be16 in some places.
>>
>>> It clears the warnings out.
>>
>> But if sparse doesn't complain about those we are better of with the change I
>> guess.
> Hmm. I wonder if there is any marking for no endianness specified?
> Either that or we'll need to play games with a union to pull this off
> cleanly.
>
> For anyone reading this without the background.  This bit of code is filling
> a buffer with a mixture of big and cpu endian elements.  This buffer is described
> to userspace which can then do the conversions as necessary.
>
> For now I'm going to hold the patch I sent out as it's not a real fix, but
> rather a nasty work around of the problem.

As a quick stab at it, how about something like...

diff --git a/drivers/iio/adc/ad7298.c b/drivers/iio/adc/ad7298.c
index 441a9a2..258ba97 100644
--- a/drivers/iio/adc/ad7298.c
+++ b/drivers/iio/adc/ad7298.c
@@ -54,8 +54,11 @@ struct ad7298_state {
 	 * DMA (thus cache coherency maintenance) requires the
 	 * transfer buffers to live in their own cache lines.
 	 */
-	unsigned short			rx_buf[12] ____cacheline_aligned;
-	unsigned short			tx_buf[2];
+	union {
+		__be16                  rx_buf[12];
+		s64                     rx_ts[3];
+	} ____cacheline_aligned;
+	__be16			tx_buf[2];
 };

 #define AD7298_V_CHAN(index)						\
@@ -159,18 +162,15 @@ static irqreturn_t ad7298_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ad7298_state *st = iio_priv(indio_dev);
-	s64 time_ns = 0;
 	int b_sent;

 	b_sent = spi_sync(st->spi, &st->ring_msg);
 	if (b_sent)
 		goto done;

-	if (indio_dev->scan_timestamp) {
-		time_ns = iio_get_time_ns();
-		memcpy((u8 *)st->rx_buf + indio_dev->scan_bytes - sizeof(s64),
-			&time_ns, sizeof(time_ns));
-	}
+	if (indio_dev->scan_timestamp)
+		st->rx_ts[(indio_dev->scan_bytes + sizeof(s64) - 1) / sizeof(s64)]
+			= iio_get_time_ns();

 	iio_push_to_buffers(indio_dev, (u8 *)st->rx_buf);

