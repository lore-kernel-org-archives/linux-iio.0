Return-Path: <amsfield22@gmail.com>
Date: Fri, 2 Sep 2016 10:10:31 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: jic23@kernel.org, mranostay@gmail.com, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: humidity: hdc100x: add triggered buffer support
 for HDC100X
Message-ID: <20160902171030.GA12497@d830.WORKGROUP>
References: <alpine.DEB.2.10.1609020729020.3923@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.10.1609020729020.3923@hadrien>
List-ID: <linux-iio@vger.kernel.org>

On Fri, Sep 02, 2016 at 07:30:38AM +0100, Julia Lawall wrote:
> Please check on the lines marked with @.  An unlock may be needed at line
> 210.
> 
> julia

Yes, needs unlock. Thanks!
alisons

> 
> ---------- Forwarded message ----------
> Date: Fri, 2 Sep 2016 07:19:23 +0800
> From: kbuild test robot <fengguang.wu@intel.com>
> To: kbuild@01.org
> Cc: Julia Lawall <julia.lawall@lip6.fr>
> Subject: Re: [PATCH v3] iio: humidity: hdc100x: add triggered buffer support for
>      HDC100X
> 
> Hi Alison,
> 
> [auto build test WARNING on next-20160825]
> [also build test WARNING on v4.8-rc4]
> [cannot apply to iio/togreg v4.8-rc4 v4.8-rc3 v4.8-rc2]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> [Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
> [Check https://git-scm.com/docs/git-format-patch for more information]
> 
> url:    https://github.com/0day-ci/linux/commits/Alison-Schofield/iio-humidity-hdc100x-add-triggered-buffer-support-for-HDC100X/20160902-055115
> :::::: branch date: 88 minutes ago
> :::::: commit date: 88 minutes ago
> 
> >> drivers/iio/humidity/hdc100x.c:210:4-10: preceding lock on line 203
>    drivers/iio/humidity/hdc100x.c:345:1-7: preceding lock on line 325
> 
> git remote add linux-review https://github.com/0day-ci/linux
> git remote update linux-review
> git checkout f6862a537522f8d668f7daec0aa0817f87706017
> vim +210 drivers/iio/humidity/hdc100x.c
> 
> 4839367d9 Matt Ranostay    2015-09-06  197  	struct hdc100x_data *data = iio_priv(indio_dev);
> 4839367d9 Matt Ranostay    2015-09-06  198
> 4839367d9 Matt Ranostay    2015-09-06  199  	switch (mask) {
> 4839367d9 Matt Ranostay    2015-09-06  200  	case IIO_CHAN_INFO_RAW: {
> 4839367d9 Matt Ranostay    2015-09-06  201  		int ret;
> 4839367d9 Matt Ranostay    2015-09-06  202
> 4839367d9 Matt Ranostay    2015-09-06 @203  		mutex_lock(&data->lock);
> 4839367d9 Matt Ranostay    2015-09-06  204  		if (chan->type == IIO_CURRENT) {
> 4839367d9 Matt Ranostay    2015-09-06  205  			*val = hdc100x_get_heater_status(data);
> 4839367d9 Matt Ranostay    2015-09-06  206  			ret = IIO_VAL_INT;
> 4839367d9 Matt Ranostay    2015-09-06  207  		} else {
> f6862a537 Alison Schofield 2016-09-01  208  			ret = iio_device_claim_direct_mode(indio_dev);
> f6862a537 Alison Schofield 2016-09-01  209  			if (ret)
> f6862a537 Alison Schofield 2016-09-01 @210  				return ret;
> f6862a537 Alison Schofield 2016-09-01  211
> 4839367d9 Matt Ranostay    2015-09-06  212  			ret = hdc100x_get_measurement(data, chan);
> f6862a537 Alison Schofield 2016-09-01  213  			iio_device_release_direct_mode(indio_dev);
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
