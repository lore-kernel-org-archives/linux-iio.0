Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66CE3E6DC1;
	Tue, 14 Apr 2026 12:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776171407; cv=none; b=pDEOnCEPEsS52wtjSEWNKqlviKGv9uM179T0Axm8vLDdpEM5pCaiPiRSXdiGJRusDc/yLCEg5Ykfy0T4Ka2LPl7wBQ8/kIJ6ruXohRnLUi5vWUP1/qxnORX2uuQcL6OYS6ssWopo3ek/hyfupinI7HXR9+IrKiMc+soIhrmJepo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776171407; c=relaxed/simple;
	bh=ZrXbyEyBK+P/hkY0BifiDpyfiYT2v++6HGybHpXFRBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLCPv9r1aKn8rDkhvwpuhMLMU3FX8cuAoRkGucTtNxRrdH7BBZtNC3ehhc5fqA9EkCFbEJCTtiXJz/dN6hIj2Y5XQgPZV0lx8d0OTmGvFBoMnv4Jsovpiplq6TmjC1gFvRKX/5qc6+XJe8kNkKvCdjTFRypyiJoHcbWPGztvvxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RkCX86tv; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RkCX86tv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776171404; x=1807707404;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZrXbyEyBK+P/hkY0BifiDpyfiYT2v++6HGybHpXFRBA=;
  b=RkCX86tvO2gw1czTx1YX7paz66PB7AVycnjupiIy6vfm1R1KmF4dx6E0
   GPEVDWEhCgx2af6O9598aZ+sN8G9UBPZpqspdsuMbhRH1P9F3SZ6MIPCK
   O+QMyG4wzN+3+25h/bQgvTdpxI/Ca9+wJADRdPhZIKQxEckjig9Hzi24F
   JSKxYtzUh6JrZ+qZqJYI0VdpkGik8N0GJhPlX/EMqvIBFtJohnHqTFgcG
   WB2ecSXhFzjD7oZXjjETAKyOwE972AzbDKeFZ3Y4cM3uNd7C64nOFLA99
   m0uPpl74uf6YY8H5FowaWCmir9a0smBMNbdd/97mCk+zNV6SRNwHi7OIM
   w==;
X-CSE-ConnectionGUID: V7UG98WQTDOSJbRSRPNLig==
X-CSE-MsgGUID: HYZC4w2BS+qJOTnCNHtYPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="87431734"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="87431734"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 05:56:43 -0700
X-CSE-ConnectionGUID: h2XqyPqIQkO2eSid3phC1w==
X-CSE-MsgGUID: 9PPFWa7hSueoq7R3FaTvfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="229214424"
Received: from lkp-server01.sh.intel.com (HELO 7b0b59b3a0d4) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 14 Apr 2026 05:56:40 -0700
Received: from kbuild by 7b0b59b3a0d4 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wCdJl-000000001ST-3s18;
	Tue, 14 Apr 2026 12:56:37 +0000
Date: Tue, 14 Apr 2026 20:55:41 +0800
From: kernel test robot <lkp@intel.com>
To: Advaith Neelacantan <advaith.neelacantan@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Advaith Neelacantan <advaith.neelacantan@gmail.com>
Subject: Re: [PATCH] staging: iio: frequency: ad9832:  use guard(mutex) for
 locking
Message-ID: <202604142016.fnd3WPI1-lkp@intel.com>
References: <20260411072503.106621-2-advaith.neelacantan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260411072503.106621-2-advaith.neelacantan@gmail.com>

Hi Advaith,

kernel test robot noticed the following build errors:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Advaith-Neelacantan/staging-iio-frequency-ad9832-use-guard-mutex-for-locking/20260414-074602
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20260411072503.106621-2-advaith.neelacantan%40gmail.com
patch subject: [PATCH] staging: iio: frequency: ad9832:  use guard(mutex) for locking
config: i386-buildonly-randconfig-002-20260414 (https://download.01.org/0day-ci/archive/20260414/202604142016.fnd3WPI1-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260414/202604142016.fnd3WPI1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604142016.fnd3WPI1-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/staging/iio/frequency/ad9832.c:182:3: error: cannot jump from this goto statement to its label
     182 |                 goto error_ret;
         |                 ^
   drivers/staging/iio/frequency/ad9832.c:184:2: note: jump bypasses initialization of variable with __attribute__((cleanup))
     184 |         guard(mutex)(&st->lock);
         |         ^
   include/linux/cleanup.h:419:2: note: expanded from macro 'guard'
     419 |         CLASS(_name, __UNIQUE_ID(guard))
         |         ^
   include/linux/cleanup.h:300:3: note: expanded from macro 'CLASS'
     300 |                 class_##_name##_constructor
         |                 ^
   <scratch space>:16:1: note: expanded from here
      16 | class_mutex_constructor
         | ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:16:23: note: expanded from macro '__PASTE'
      16 | #define __PASTE(a, b) ___PASTE(a, b)
         |                       ^
   include/linux/compiler_types.h:15:24: note: expanded from macro '___PASTE'
      15 | #define ___PASTE(a, b) a##b
         |                        ^
   <scratch space>:22:1: note: expanded from here
      22 | __UNIQUE_ID_unlock_451
         | ^
   drivers/staging/iio/frequency/ad9832.c:184:2: note: jump bypasses initialization of variable with __attribute__((cleanup))
   include/linux/cleanup.h:419:15: note: expanded from macro 'guard'
     419 |         CLASS(_name, __UNIQUE_ID(guard))
         |                      ^
   include/linux/compiler.h:168:2: note: expanded from macro '__UNIQUE_ID'
     168 |         __PASTE(__UNIQUE_ID_,                                   \
         |         ^
   include/linux/compiler_types.h:16:23: note: expanded from macro '__PASTE'
      16 | #define __PASTE(a, b) ___PASTE(a, b)
         |                       ^
   include/linux/compiler_types.h:15:24: note: expanded from macro '___PASTE'
      15 | #define ___PASTE(a, b) a##b
         |                        ^
   <scratch space>:10:1: note: expanded from here
      10 | __UNIQUE_ID_guard_450
         | ^
   1 error generated.


vim +182 drivers/staging/iio/frequency/ad9832.c

4a8e6c33e88b09a drivers/staging/iio/dds/ad9832.c       Cliff Cai           2010-10-27  170  
f1b07cdf6ba396d drivers/staging/iio/frequency/ad9832.c Federico Di Pierro  2014-06-29  171  static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
f1b07cdf6ba396d drivers/staging/iio/frequency/ad9832.c Federico Di Pierro  2014-06-29  172  			    const char *buf, size_t len)
4a8e6c33e88b09a drivers/staging/iio/dds/ad9832.c       Cliff Cai           2010-10-27  173  {
b671bb3bf0d0165 drivers/staging/iio/frequency/ad9832.c Lars-Peter Clausen  2012-05-12  174  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
638e59fc8c867b4 drivers/staging/iio/dds/ad9832.c       Jonathan Cameron    2011-10-06  175  	struct ad9832_state *st = iio_priv(indio_dev);
ea707584bac187c drivers/staging/iio/dds/ad9832.c       Michael Hennerich   2011-02-09  176  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
4a8e6c33e88b09a drivers/staging/iio/dds/ad9832.c       Cliff Cai           2010-10-27  177  	int ret;
e5e26dd5bb740c3 drivers/staging/iio/frequency/ad9832.c Jingoo Han          2013-08-20  178  	unsigned long val;
ea707584bac187c drivers/staging/iio/dds/ad9832.c       Michael Hennerich   2011-02-09  179  
e5e26dd5bb740c3 drivers/staging/iio/frequency/ad9832.c Jingoo Han          2013-08-20  180  	ret = kstrtoul(buf, 10, &val);
4a8e6c33e88b09a drivers/staging/iio/dds/ad9832.c       Cliff Cai           2010-10-27  181  	if (ret)
4a8e6c33e88b09a drivers/staging/iio/dds/ad9832.c       Cliff Cai           2010-10-27 @182  		goto error_ret;
4a8e6c33e88b09a drivers/staging/iio/dds/ad9832.c       Cliff Cai           2010-10-27  183  
baf560e48a75741 drivers/staging/iio/frequency/ad9832.c Advaith Neelacantan 2026-04-11  184  	guard(mutex)(&st->lock);
e15fbc91a4304a9 drivers/staging/iio/dds/ad9832.c       Michael Hennerich   2011-10-25  185  	switch ((u32)this_attr->address) {
ea707584bac187c drivers/staging/iio/dds/ad9832.c       Michael Hennerich   2011-02-09  186  	case AD9832_FREQ0HM:
ea707584bac187c drivers/staging/iio/dds/ad9832.c       Michael Hennerich   2011-02-09  187  	case AD9832_FREQ1HM:
ea707584bac187c drivers/staging/iio/dds/ad9832.c       Michael Hennerich   2011-02-09  188  		ret = ad9832_write_frequency(st, this_attr->address, val);
ea707584bac187c drivers/staging/iio/dds/ad9832.c       Michael Hennerich   2011-02-09  189  		break;
ea707584bac187c drivers/staging/iio/dds/ad9832.c       Michael Hennerich   2011-02-09  190  	case AD9832_PHASE0H:
ea707584bac187c drivers/staging/iio/dds/ad9832.c       Michael Hennerich   2011-02-09  191  	case AD9832_PHASE1H:
ea707584bac187c drivers/staging/iio/dds/ad9832.c       Michael Hennerich   2011-02-09  192  	case AD9832_PHASE2H:
ea707584bac187c drivers/staging/iio/dds/ad9832.c       Michael Hennerich   2011-02-09  193  	case AD9832_PHASE3H:
ea707584bac187c drivers/staging/iio/dds/ad9832.c       Michael Hennerich   2011-02-09  194  		ret = ad9832_write_phase(st, this_attr->address, val);
ea707584bac187c drivers/staging/iio/dds/ad9832.c       Michael Hennerich   2011-02-09  195  		break;
ea707584bac187c drivers/staging/iio/dds/ad9832.c       Michael Hennerich   2011-02-09  196  	case AD9832_PINCTRL_EN:
ea707584bac187c drivers/staging/iio/dds/ad9832.c       Michael Hennerich   2011-02-09  197  		st->ctrl_ss &= ~AD9832_SELSRC;
85c9e6d592e1c17 drivers/staging/iio/frequency/ad9832.c Siddharth Menon     2025-04-16  198  		st->ctrl_ss |= FIELD_PREP(AD9832_SELSRC, val ? 0 : 1);
85c9e6d592e1c17 drivers/staging/iio/frequency/ad9832.c Siddharth Menon     2025-04-16  199  
85c9e6d592e1c17 drivers/staging/iio/frequency/ad9832.c Siddharth Menon     2025-04-16  200  		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_SYNCSELSRC) |
ea707584bac187c drivers/staging/iio/dds/ad9832.c       Michael Hennerich   2011-02-09  201  						  st->ctrl_ss);
ea707584bac187c drivers/staging/iio/dds/ad9832.c       Michael Hennerich   2011-02-09  202  		ret = spi_sync(st->spi, &st->msg);
ea707584bac187c drivers/staging/iio/dds/ad9832.c       Michael Hennerich   2011-02-09  203  		break;
ea707584bac187c drivers/staging/iio/dds/ad9832.c       Michael Hennerich   2011-02-09  204  	case AD9832_FREQ_SYM:
85c9e6d592e1c17 drivers/staging/iio/frequency/ad9832.c Siddharth Menon     2025-04-16  205  		if (val == 1 || val == 0) {
ea707584bac187c drivers/staging/iio/dds/ad9832.c       Michael Hennerich   2011-02-09  206  			st->ctrl_fp &= ~AD9832_FREQ;
85c9e6d592e1c17 drivers/staging/iio/frequency/ad9832.c Siddharth Menon     2025-04-16  207  			st->ctrl_fp |= FIELD_PREP(AD9832_FREQ, val ? 1 : 0);
f1b07cdf6ba396d drivers/staging/iio/frequency/ad9832.c Federico Di Pierro  2014-06-29  208  		} else {
ea707584bac187c drivers/staging/iio/dds/ad9832.c       Michael Hennerich   2011-02-09  209  			ret = -EINVAL;
ea707584bac187c drivers/staging/iio/dds/ad9832.c       Michael Hennerich   2011-02-09  210  			break;
ea707584bac187c drivers/staging/iio/dds/ad9832.c       Michael Hennerich   2011-02-09  211  		}
85c9e6d592e1c17 drivers/staging/iio/frequency/ad9832.c Siddharth Menon     2025-04-16  212  		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_FPSELECT) |
ea707584bac187c drivers/staging/iio/dds/ad9832.c       Michael Hennerich   2011-02-09  213  						  st->ctrl_fp);
ea707584bac187c drivers/staging/iio/dds/ad9832.c       Michael Hennerich   2011-02-09  214  		ret = spi_sync(st->spi, &st->msg);
ea707584bac187c drivers/staging/iio/dds/ad9832.c       Michael Hennerich   2011-02-09  215  		break;
ea707584bac187c drivers/staging/iio/dds/ad9832.c       Michael Hennerich   2011-02-09  216  	case AD9832_PHASE_SYM:
260974704ea4c01 drivers/staging/iio/frequency/ad9832.c Sachin Kamat        2014-03-07  217  		if (val > 3) {
ea707584bac187c drivers/staging/iio/dds/ad9832.c       Michael Hennerich   2011-02-09  218  			ret = -EINVAL;
ea707584bac187c drivers/staging/iio/dds/ad9832.c       Michael Hennerich   2011-02-09  219  			break;
ea707584bac187c drivers/staging/iio/dds/ad9832.c       Michael Hennerich   2011-02-09  220  		}
ea707584bac187c drivers/staging/iio/dds/ad9832.c       Michael Hennerich   2011-02-09  221  
85c9e6d592e1c17 drivers/staging/iio/frequency/ad9832.c Siddharth Menon     2025-04-16  222  		st->ctrl_fp &= ~AD9832_PHASE_MASK;
85c9e6d592e1c17 drivers/staging/iio/frequency/ad9832.c Siddharth Menon     2025-04-16  223  		st->ctrl_fp |= FIELD_PREP(AD9832_PHASE_MASK, val);
ea707584bac187c drivers/staging/iio/dds/ad9832.c       Michael Hennerich   2011-02-09  224  
85c9e6d592e1c17 drivers/staging/iio/frequency/ad9832.c Siddharth Menon     2025-04-16  225  		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_FPSELECT) |
ea707584bac187c drivers/staging/iio/dds/ad9832.c       Michael Hennerich   2011-02-09  226  						  st->ctrl_fp);
ea707584bac187c drivers/staging/iio/dds/ad9832.c       Michael Hennerich   2011-02-09  227  		ret = spi_sync(st->spi, &st->msg);
ea707584bac187c drivers/staging/iio/dds/ad9832.c       Michael Hennerich   2011-02-09  228  		break;
ea707584bac187c drivers/staging/iio/dds/ad9832.c       Michael Hennerich   2011-02-09  229  	case AD9832_OUTPUT_EN:
ea707584bac187c drivers/staging/iio/dds/ad9832.c       Michael Hennerich   2011-02-09  230  		if (val)
85c9e6d592e1c17 drivers/staging/iio/frequency/ad9832.c Siddharth Menon     2025-04-16  231  			st->ctrl_src &= ~(AD9832_RESET | AD9832_SLEEP | AD9832_CLR);
ea707584bac187c drivers/staging/iio/dds/ad9832.c       Michael Hennerich   2011-02-09  232  		else
85c9e6d592e1c17 drivers/staging/iio/frequency/ad9832.c Siddharth Menon     2025-04-16  233  			st->ctrl_src |= FIELD_PREP(AD9832_RESET, 1);
ea707584bac187c drivers/staging/iio/dds/ad9832.c       Michael Hennerich   2011-02-09  234  
85c9e6d592e1c17 drivers/staging/iio/frequency/ad9832.c Siddharth Menon     2025-04-16  235  		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_SLEEPRESCLR) |
ea707584bac187c drivers/staging/iio/dds/ad9832.c       Michael Hennerich   2011-02-09  236  						  st->ctrl_src);
ea707584bac187c drivers/staging/iio/dds/ad9832.c       Michael Hennerich   2011-02-09  237  		ret = spi_sync(st->spi, &st->msg);
ea707584bac187c drivers/staging/iio/dds/ad9832.c       Michael Hennerich   2011-02-09  238  		break;
ea707584bac187c drivers/staging/iio/dds/ad9832.c       Michael Hennerich   2011-02-09  239  	default:
ea707584bac187c drivers/staging/iio/dds/ad9832.c       Michael Hennerich   2011-02-09  240  		ret = -ENODEV;
ea707584bac187c drivers/staging/iio/dds/ad9832.c       Michael Hennerich   2011-02-09  241  	}
ea707584bac187c drivers/staging/iio/dds/ad9832.c       Michael Hennerich   2011-02-09  242  
ea707584bac187c drivers/staging/iio/dds/ad9832.c       Michael Hennerich   2011-02-09  243  error_ret:
4a8e6c33e88b09a drivers/staging/iio/dds/ad9832.c       Cliff Cai           2010-10-27  244  	return ret ? ret : len;
4a8e6c33e88b09a drivers/staging/iio/dds/ad9832.c       Cliff Cai           2010-10-27  245  }
4a8e6c33e88b09a drivers/staging/iio/dds/ad9832.c       Cliff Cai           2010-10-27  246  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
