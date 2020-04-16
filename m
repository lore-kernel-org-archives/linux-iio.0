Return-Path: <SRS0=XMpF=6A=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E22C2BB55
	for <linux-iio@archiver.kernel.org>; Thu, 16 Apr 2020 20:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52E74221F7
	for <linux-iio@archiver.kernel.org>; Thu, 16 Apr 2020 20:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgDPUu1 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 16 Apr 2020 16:50:27 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:34979 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgDPUu1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Apr 2020 16:50:27 -0400
X-Originating-IP: 86.202.105.35
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 866F0C0007;
        Thu, 16 Apr 2020 20:50:23 +0000 (UTC)
Date:   Thu, 16 Apr 2020 22:50:23 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, kbuild-all@lists.01.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: adc: ti-ads8344: properly byte swap value
Message-ID: <20200416205023.GA437042@piout.net>
References: <20200415212257.161238-2-alexandre.belloni@bootlin.com>
 <202004161449.NY5hL54S%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202004161449.NY5hL54S%lkp@intel.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 16/04/2020 14:22:03+0800, kbuild test robot wrote:
> Hi Alexandre,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on iio/togreg]
> [also build test ERROR on v5.7-rc1 next-20200415]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Alexandre-Belloni/iio-adc-ti-ads8344-improve-the-driver/20200416-073357
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> config: c6x-allyesconfig (attached as .config)
> compiler: c6x-elf-gcc (GCC) 9.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day GCC_VERSION=9.3.0 make.cross ARCH=c6x 
> 

I spent some time to reproduce and this is actually not that trivial
because your toolchains are linked with libisl22 and most distributions
still ship an older version. Maybe you can do something about that?

> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> 
> vim +/302 +96 drivers/iio/adc/ti-ads8344.c
> 
>     72	
>     73	static int ads8344_adc_conversion(struct ads8344 *adc, int channel,
>     74					  bool differential)
>     75	{
>     76		struct spi_device *spi = adc->spi;
>     77		int ret;
>     78		u8 buf[3];
>     79	
>     80		adc->tx_buf = ADS8344_START;
>     81		if (!differential)
>     82			adc->tx_buf |= ADS8344_SINGLE_END;
>     83		adc->tx_buf |= ADS8344_CHANNEL(channel);
>     84		adc->tx_buf |= ADS8344_CLOCK_INTERNAL;
>     85	
>     86		ret = spi_write(spi, &adc->tx_buf, 1);
>     87		if (ret)
>     88			return ret;
>     89	
>     90		udelay(9);
>     91	
>     92		ret = spi_read(spi, buf, sizeof(buf));
>     93		if (ret)
>     94			return ret;
>     95	
>   > 96		return buf[0] << 9 | buf[1] << 1 | buf[2] >> 7;
>     97	}
>     98	
> 

I take it this is a false positive as I don't get any errors when
building this driver with the provided toolchain. However, I see a few
"internal compiler error: in priority, at haifa-sched.c:1599"

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
