Return-Path: <SRS0=l0ft=56=lip6.fr=julia.lawall@kernel.org>
Date: Sun, 25 Jun 2017 16:27:16 -0400 (EDT)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Ismail Kose <Ismail.Kose@maximintegrated.com>
cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
    robh+dt@kernel.org, mark.rutland@arm.com, vilhelm.gray@gmail.com,
    linus.walleij@linaro.org, jeff.dagenais@gmail.com, fabrice.gasnier@st.com,
    gwenhael.goavec-merou@trabucayre.com, peda@axentia.se,
    maxime.roussinbelanger@gmail.com, ihkose@gmail.com,
    Ismail.Kose@maximintegrated.com, linux-iio@vger.kernel.org,
    devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
    gwenhael.goavec-merou@trabucayre.com, peda@axentia.se,
    maxime.roussinbelanger@gmail.com, ihkose@gmail.com,
    Ismail.Kose@maximintegrated.com, linux-iio@vger.kernel.org,
    devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
    kbuild-all@01.org
Subject: Re: [PATCH] iio: dac: DS4424: add Maxim DS4422/DS4424 DAC driver
 support (fwd)
Message-ID: <alpine.DEB.2.20.1706251625510.3109@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

Both tests on lines 531-532 are the same.

julia

---------- Forwarded message ----------
Date: Mon, 26 Jun 2017 04:19:55 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: kbuild@01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH] iio: dac: DS4424: add Maxim DS4422/DS4424 DAC driver
    support

Hi Ismail,

[auto build test WARNING on iio/togreg]
[also build test WARNING on v4.12-rc6 next-20170623]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Ismail-Kose/iio-dac-DS4424-add-Maxim-DS4422-DS4424-DAC-driver-support/20170626-020351
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
:::::: branch date: 2 hours ago
:::::: commit date: 2 hours ago

>> drivers/iio/dac/ds4424.c:531:5-41: duplicated argument to && or ||

git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 9f3baa7b21297c1311b902cb3643fb77b7683e05
vim +531 drivers/iio/dac/ds4424.c

9f3baa7b Ismail H. Kose 2017-06-23  515
9f3baa7b Ismail H. Kose 2017-06-23  516  	pr_info("ds4424 max-picoamp: %d, ifs-scale: %d\n",
9f3baa7b Ismail H. Kose 2017-06-23  517  			data->max_picoamp, data->ifs_scale);
9f3baa7b Ismail H. Kose 2017-06-23  518
9f3baa7b Ismail H. Kose 2017-06-23  519  	count = of_property_count_strings(node, "dac-iio-map");
9f3baa7b Ismail H. Kose 2017-06-23  520  	if (count < 0) {
9f3baa7b Ismail H. Kose 2017-06-23  521  		pr_info("dac-iio-map not found in dts\n");
9f3baa7b Ismail H. Kose 2017-06-23  522  		return count;
9f3baa7b Ismail H. Kose 2017-06-23  523  	}
9f3baa7b Ismail H. Kose 2017-06-23  524
9f3baa7b Ismail H. Kose 2017-06-23  525  	ret = of_property_read_string(node, "vcc-supply", &data->vcc_reg_name);
9f3baa7b Ismail H. Kose 2017-06-23  526  	if (ret < 0) {
9f3baa7b Ismail H. Kose 2017-06-23  527  		pr_info("DAC vcc-supply is not available in dts\n");
9f3baa7b Ismail H. Kose 2017-06-23  528  		data->vcc_reg_name = NULL;
9f3baa7b Ismail H. Kose 2017-06-23  529  	}
9f3baa7b Ismail H. Kose 2017-06-23  530
9f3baa7b Ismail H. Kose 2017-06-23 @531  	if (count != DS4424_MAX_DAC_CHANNELS * 3 &&
9f3baa7b Ismail H. Kose 2017-06-23  532  		count != DS4424_MAX_DAC_CHANNELS * 3) {
9f3baa7b Ismail H. Kose 2017-06-23  533  		pr_info("Incorrect dac-iio-map in dts. count: %d\n", count);
9f3baa7b Ismail H. Kose 2017-06-23  534  		return -EINVAL;
9f3baa7b Ismail H. Kose 2017-06-23  535  	}
9f3baa7b Ismail H. Kose 2017-06-23  536
9f3baa7b Ismail H. Kose 2017-06-23  537  	num_ch = count / 3;
9f3baa7b Ismail H. Kose 2017-06-23  538  	for (i = 0; i < num_ch; i++) {
9f3baa7b Ismail H. Kose 2017-06-23  539  		ret = of_property_read_string_index(node,

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
