Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:59641 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751954Ab2KROSx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 18 Nov 2012 09:18:53 -0500
Message-ID: <50A8EE71.8090302@metafoo.de>
Date: Sun, 18 Nov 2012 15:19:29 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: kbuild test robot <fengguang.wu@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [iio:togreg 24/24] drivers/iio/adc/ad7298.c:125:23: sparse: incorrect
 type in assignment (different base types)
References: <50a787d6.NK04zL7PgCPbLOrx%fengguang.wu@intel.com> <50A8E5DF.7000607@kernel.org>
In-Reply-To: <50A8E5DF.7000607@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/18/2012 02:42 PM, Jonathan Cameron wrote:
> Hi Lars-Peter
> 
> Hmm. currious. I'd not normally have that check on - for reference
> this only happens for me with CF="-D__CHECK_ENDIAN__" appeneded to my
> normal make for the kernel.
> 
> Anyhow, initial thought was to change rx_buf and tx_buf to __be16.
> Can you see any issues with that?
> 

I actually had such a patch initially in my series, but removed it again, since
we are using the buffer as non __be16 in some places.

> It clears the warnings out.

But if sparse doesn't complain about those we are better of with the change I
guess.

> 
> Jonathan
> 
> On 11/17/2012 12:49 PM, kbuild test robot wrote:
>> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
>> head:   e3e10fa5760709eb9dcc05fc9bfd48f90e2abbd7
>> commit: e3e10fa5760709eb9dcc05fc9bfd48f90e2abbd7 [24/24] staging:iio: Move the ad7298 driver out of staging
>>
>>
>> sparse warnings:
>>
>> + drivers/iio/adc/ad7298.c:125:23: sparse: incorrect type in assignment (different base types)
>> drivers/iio/adc/ad7298.c:125:23:    expected unsigned short [unsigned] [short] <noident>
>> drivers/iio/adc/ad7298.c:125:23:    got restricted __be16 [usertype] <noident>
>> drivers/iio/adc/ad7298.c:186:23: sparse: incorrect type in assignment (different base types)
>> drivers/iio/adc/ad7298.c:186:23:    expected unsigned short [unsigned] [short] <noident>
>> drivers/iio/adc/ad7298.c:186:23:    got restricted __be16 [usertype] <noident>
>> + drivers/iio/adc/ad7298.c:193:16: sparse: cast to restricted __be16
>> + drivers/iio/adc/ad7298.c:193:16: sparse: cast to restricted __be16
>> + drivers/iio/adc/ad7298.c:193:16: sparse: cast to restricted __be16
>> + drivers/iio/adc/ad7298.c:193:16: sparse: cast to restricted __be16
>>
>> vim +125 drivers/iio/adc/ad7298.c
>>
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  119  	command = AD7298_WRITE | st->ext_ref;
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  120  
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  121  	for (i = 0, m = AD7298_CH(0); i < AD7298_MAX_CHAN; i++, m >>= 1)
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  122  		if (test_bit(i, active_scan_mask))
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  123  			command |= m;
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  124  
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15 @125  	st->tx_buf[0] = cpu_to_be16(command);
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  126  
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  127  	/* build spi ring message */
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  128  	st->ring_xfer[0].tx_buf = &st->tx_buf[0];
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  129  	st->ring_xfer[0].len = 2;
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  130  	st->ring_xfer[0].cs_change = 1;
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  131  	st->ring_xfer[1].tx_buf = &st->tx_buf[1];
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  132  	st->ring_xfer[1].len = 2;
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  133  	st->ring_xfer[1].cs_change = 1;
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  134  
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  135  	spi_message_init(&st->ring_msg);
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  136  	spi_message_add_tail(&st->ring_xfer[0], &st->ring_msg);
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  137  	spi_message_add_tail(&st->ring_xfer[1], &st->ring_msg);
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  138  
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  139  	for (i = 0; i < scan_count; i++) {
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  140  		st->ring_xfer[i + 2].rx_buf = &st->rx_buf[i];
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  141  		st->ring_xfer[i + 2].len = 2;
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  142  		st->ring_xfer[i + 2].cs_change = 1;
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  143  		spi_message_add_tail(&st->ring_xfer[i + 2], &st->ring_msg);
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  144  	}
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  145  	/* make sure last transfer cs_change is not set */
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  146  	st->ring_xfer[i + 1].cs_change = 0;
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  147  
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  148  	return 0;
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  149  }
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  150  
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  151  /**
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  152   * ad7298_trigger_handler() bh of trigger launched polling to ring buffer
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  153   *
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  154   * Currently there is no option in this driver to disable the saving of
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  155   * timestamps within the ring.
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  156   **/
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  157  static irqreturn_t ad7298_trigger_handler(int irq, void *p)
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  158  {
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  159  	struct iio_poll_func *pf = p;
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  160  	struct iio_dev *indio_dev = pf->indio_dev;
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  161  	struct ad7298_state *st = iio_priv(indio_dev);
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  162  	s64 time_ns = 0;
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  163  	int b_sent;
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  164  
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  165  	b_sent = spi_sync(st->spi, &st->ring_msg);
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  166  	if (b_sent)
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  167  		goto done;
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  168  
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  169  	if (indio_dev->scan_timestamp) {
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  170  		time_ns = iio_get_time_ns();
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  171  		memcpy((u8 *)st->rx_buf + indio_dev->scan_bytes - sizeof(s64),
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  172  			&time_ns, sizeof(time_ns));
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  173  	}
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  174  
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  175  	iio_push_to_buffers(indio_dev, (u8 *)st->rx_buf);
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  176  
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  177  done:
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  178  	iio_trigger_notify_done(indio_dev->trig);
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  179  
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  180  	return IRQ_HANDLED;
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  181  }
>> 8c4c8ffe drivers/staging/iio/adc/ad7298.c      Lars-Peter Clausen 2012-11-15  182  
>> 7c31b984 drivers/staging/iio/adc/ad7298_core.c Michael Hennerich  2011-02-24  183  static int ad7298_scan_direct(struct ad7298_state *st, unsigned ch)
>> 7c31b984 drivers/staging/iio/adc/ad7298_core.c Michael Hennerich  2011-02-24  184  {
>> 7c31b984 drivers/staging/iio/adc/ad7298_core.c Michael Hennerich  2011-02-24  185  	int ret;
>> 7c31b984 drivers/staging/iio/adc/ad7298_core.c Michael Hennerich  2011-02-24 @186  	st->tx_buf[0] = cpu_to_be16(AD7298_WRITE | st->ext_ref |
>> 7c31b984 drivers/staging/iio/adc/ad7298_core.c Michael Hennerich  2011-02-24  187  				   (AD7298_CH(0) >> ch));
>> 7c31b984 drivers/staging/iio/adc/ad7298_core.c Michael Hennerich  2011-02-24  188  
>> 7c31b984 drivers/staging/iio/adc/ad7298_core.c Michael Hennerich  2011-02-24  189  	ret = spi_sync(st->spi, &st->scan_single_msg);
>> 7c31b984 drivers/staging/iio/adc/ad7298_core.c Michael Hennerich  2011-02-24  190  	if (ret)
>> 7c31b984 drivers/staging/iio/adc/ad7298_core.c Michael Hennerich  2011-02-24  191  		return ret;
>> 7c31b984 drivers/staging/iio/adc/ad7298_core.c Michael Hennerich  2011-02-24  192  
>> 7c31b984 drivers/staging/iio/adc/ad7298_core.c Michael Hennerich  2011-02-24 @193  	return be16_to_cpu(st->rx_buf[0]);
>> 7c31b984 drivers/staging/iio/adc/ad7298_core.c Michael Hennerich  2011-02-24  194  }
>> 7c31b984 drivers/staging/iio/adc/ad7298_core.c Michael Hennerich  2011-02-24  195  
>> 01a99e18 drivers/staging/iio/adc/ad7298_core.c Michael Hennerich  2011-05-18  196  static int ad7298_scan_temp(struct ad7298_state *st, int *val)
>>
>> ---
>> 0-DAY kernel build testing backend         Open Source Technology Center
>> Fengguang Wu, Yuanhan Liu                              Intel Corporation
>>
