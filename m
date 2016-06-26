Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47926 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265AbcFZRBm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jun 2016 13:01:42 -0400
Subject: Re: [PATCH 3/3] iio: adc: max1363: Add device tree binding
To: kbuild test robot <lkp@intel.com>,
	Florian Vaussard <florian.vaussard@gmail.com>
References: <201606211912.JCmJ2q9D%fengguang.wu@intel.com>
Cc: kbuild-all@01.org, devicetree@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Martin Kepplinger <martink@posteo.de>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Florian Vaussard <florian.vaussard@heig-vd.ch>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <3361d014-96a8-51cc-a799-4c7edc8aa5e0@kernel.org>
Date: Sun, 26 Jun 2016 18:01:37 +0100
MIME-Version: 1.0
In-Reply-To: <201606211912.JCmJ2q9D%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/06/16 12:44, kbuild test robot wrote:
> Hi,
> 
Hi Florian,

Usual way around this is to make the devicetree pointers true pointers by
providing the address of the array member instead of it's index.

Only requires a slight rework of what you have.

Jonathan
> [auto build test WARNING on iio/togreg]
> [cannot apply to v4.7-rc4 next-20160621]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Florian-Vaussard/iio-adc-max1363-Fix-missing-parts-and-add-device-tree/20160621-174542
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> config: x86_64-allmodconfig (attached as .config)
> compiler: gcc-6 (Debian 6.1.1-1) 6.1.1 20160430
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/iio/adc/max1363.c: In function 'max1363_probe':
>>> drivers/iio/adc/max1363.c:1578:11: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>       devid = (int)of_device_get_match_data(&client->dev);
>               ^
> 
> vim +1578 drivers/iio/adc/max1363.c
> 
>   1562	};
>   1563	#endif
>   1564	
>   1565	static int max1363_probe(struct i2c_client *client,
>   1566				 const struct i2c_device_id *id)
>   1567	{
>   1568		int ret;
>   1569		struct max1363_state *st;
>   1570		struct iio_dev *indio_dev;
>   1571		struct regulator *vref;
>   1572		unsigned long devid;
>   1573		const struct of_device_id *match;
>   1574	
>   1575		match = of_match_device(of_match_ptr(max1363_of_match),
>   1576					&client->dev);
>   1577		if (match)
>> 1578			devid = (int)of_device_get_match_data(&client->dev);
>   1579		else
>   1580			devid = id->driver_data;
>   1581	
>   1582		indio_dev = devm_iio_device_alloc(&client->dev,
>   1583						  sizeof(struct max1363_state));
>   1584		if (!indio_dev)
>   1585			return -ENOMEM;
>   1586	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 

