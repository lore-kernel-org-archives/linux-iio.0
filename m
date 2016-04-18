Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:56147 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752165AbcDRMQL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 18 Apr 2016 08:16:11 -0400
Subject: Re: [PATCH 1/5] max44000: Initial commit
To: Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
References: <cover.1460045763.git.leonard.crestez@intel.com>
 <5dbbd82290c575f595ae0907aaf8e03117a6d017.1460045763.git.leonard.crestez@intel.com>
 <alpine.DEB.2.02.1604072142510.26969@pmeerw.net>
 <570A513A.4020106@kernel.org> <570BBDFC.6010601@intel.com>
 <57134AFA.3040406@kernel.org> <20160418103212.GQ3217@sirena.org.uk>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Daniel Baluta <daniel.baluta@intel.com>
From: Crestez Dan Leonard <leonard.crestez@intel.com>
Message-ID: <5714CFFA.2080309@intel.com>
Date: Mon, 18 Apr 2016 15:15:54 +0300
MIME-Version: 1.0
In-Reply-To: <20160418103212.GQ3217@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/18/2016 01:32 PM, Mark Brown wrote:
> On Sun, Apr 17, 2016 at 09:36:10AM +0100, Jonathan Cameron wrote:
>> On 11/04/16 16:08, Crestez Dan Leonard wrote:
>>> I used REGCACHE_FLAT because my device has a very small number of
>>> registers and I assume it uses less memory. Honestly it would make
>>> sense for regmap to include a REGCACHE_AUTO cache_type and pick the
>>> cache implementation automatically based on number of registers.
> 
>> I've fallen for that one in the past as well.  AUTO would indeed
>> be good if it was easy to do.
> 
> It's extremely easy to do.  Unless you've got a good reason to do
> anything else you should always be using an rbtree.  The core would
> never select anything else.

Ok, I will remember this.

>>> Yes. It would not work otherwise since the regmap cache is explicitly
>>> initialized with my listed defaults.
>>> As far as I can tell regmap_write will always write to the hardware.
> 
>> Interesting and counter intuitive if true...
> 
> No, if the driver asked to write then we write.  If the driver wants to
> do a read/modify/write cycle it should use regmap_update_bits().

As a further clarification: regmap_write will write to hardware even if
the cache is known to be up-to-date and no matter the regcache_type. Did
I understand this correctly?

I'm basing this on reading the code, it seems to me that map->reg_write
is only avoided on error paths or if map->cache_only is set to true.

This always-write guarantee is not obvious and if it's OK for drivers to
rely on it perhaps it should be explicitly documented on regmap_write.
Otherwise for my device I would need some way to mention that the device
starts in an undefined state, not what is specified in reg_defaults.

For simplicity I will drop regmap_config.reg_defaults completely and
just setup the few parameters I need explicitly. This will be in v3.

--
Regards,
Leonard

