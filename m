Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from aserp2130.oracle.com ([141.146.126.79]:42982 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727501AbeHJJuZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Aug 2018 05:50:25 -0400
Date: Fri, 10 Aug 2018 10:20:54 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: kbuild@01.org, Stefan Popa <stefan.popa@analog.com>
Cc: kbuild-all@01.org, jic23@kernel.org, broonie@kernel.org,
        Stefan Popa <stefan.popa@analog.com>, lars@metafoo.de,
        Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        mark.rutland@arm.com, davem@davemloft.net,
        mchehab+samsung@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, robh+dt@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/6] iio:adxl372: Add FIFO and interrupts support
Message-ID: <20180810072054.vemdubi6kna3bx2k@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1533557087-10401-5-git-send-email-stefan.popa@analog.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Stefan,

I love your patch! Perhaps something to improve:

url:    https://github.com/0day-ci/linux/commits/Stefan-Popa/iio-accel-Add-adxl372-driver/20180807-050955
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg

smatch warnings:
drivers/iio/accel/adxl372.c:704 adxl372_buffer_postenable() error: buffer overflow 'adxl372_axis_lookup_table' 7 <= 7 (assuming for loop doesn't break)

# https://github.com/0day-ci/linux/commit/021923033c19a85fa8f99993de6591691ee67b1a
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 021923033c19a85fa8f99993de6591691ee67b1a
vim +704 drivers/iio/accel/adxl372.c

02192303 Stefan Popa 2018-08-06  686  
02192303 Stefan Popa 2018-08-06  687  static int adxl372_buffer_postenable(struct iio_dev *indio_dev)
02192303 Stefan Popa 2018-08-06  688  {
02192303 Stefan Popa 2018-08-06  689  	struct adxl372_state *st = iio_priv(indio_dev);
02192303 Stefan Popa 2018-08-06  690  	unsigned int mask;
02192303 Stefan Popa 2018-08-06  691  	int i, ret;
02192303 Stefan Popa 2018-08-06  692  
02192303 Stefan Popa 2018-08-06  693  	ret = adxl372_set_interrupts(st, ADXL372_INT1_MAP_FIFO_FULL_MSK, 0);
02192303 Stefan Popa 2018-08-06  694  	if (ret < 0)
02192303 Stefan Popa 2018-08-06  695  		return ret;
02192303 Stefan Popa 2018-08-06  696  
02192303 Stefan Popa 2018-08-06  697  	mask = *indio_dev->active_scan_mask;
02192303 Stefan Popa 2018-08-06  698  
02192303 Stefan Popa 2018-08-06  699  	for (i = 0; i < ARRAY_SIZE(adxl372_axis_lookup_table); i++) {
02192303 Stefan Popa 2018-08-06  700  		if (mask == adxl372_axis_lookup_table[i].bits)
02192303 Stefan Popa 2018-08-06  701  			break;
02192303 Stefan Popa 2018-08-06  702  	}
02192303 Stefan Popa 2018-08-06  703  
02192303 Stefan Popa 2018-08-06 @704  	st->fifo_format = adxl372_axis_lookup_table[i].fifo_format;
02192303 Stefan Popa 2018-08-06  705  	st->fifo_set_size = bitmap_weight(indio_dev->active_scan_mask,
02192303 Stefan Popa 2018-08-06  706  					  indio_dev->masklength);
02192303 Stefan Popa 2018-08-06  707  	/*
02192303 Stefan Popa 2018-08-06  708  	 * The 512 FIFO samples can be allotted in several ways, such as:
02192303 Stefan Popa 2018-08-06  709  	 * 170 sample sets of concurrent 3-axis data
02192303 Stefan Popa 2018-08-06  710  	 * 256 sample sets of concurrent 2-axis data (user selectable)
02192303 Stefan Popa 2018-08-06  711  	 * 512 sample sets of single-axis data
02192303 Stefan Popa 2018-08-06  712  	 */
02192303 Stefan Popa 2018-08-06  713  	if ((st->watermark * st->fifo_set_size) > ADXL372_FIFO_SIZE)
02192303 Stefan Popa 2018-08-06  714  		st->watermark = (ADXL372_FIFO_SIZE  / st->fifo_set_size);
02192303 Stefan Popa 2018-08-06  715  
02192303 Stefan Popa 2018-08-06  716  	st->fifo_mode = ADXL372_FIFO_STREAMED;
02192303 Stefan Popa 2018-08-06  717  
02192303 Stefan Popa 2018-08-06  718  	ret = adxl372_configure_fifo(st);
02192303 Stefan Popa 2018-08-06  719  	if (ret < 0) {
02192303 Stefan Popa 2018-08-06  720  		st->fifo_mode = ADXL372_FIFO_BYPASSED;
02192303 Stefan Popa 2018-08-06  721  		adxl372_set_interrupts(st, 0, 0);
02192303 Stefan Popa 2018-08-06  722  		return ret;
02192303 Stefan Popa 2018-08-06  723  	}
02192303 Stefan Popa 2018-08-06  724  
02192303 Stefan Popa 2018-08-06  725  	return iio_triggered_buffer_postenable(indio_dev);
02192303 Stefan Popa 2018-08-06  726  }
02192303 Stefan Popa 2018-08-06  727  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
