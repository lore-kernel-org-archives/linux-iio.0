Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792960913;
	b=QvHiB4lKxMefCmx+f+iC+tL6odI7VBILy87FzcACRNi+rXqPv6MOL8XXBUuBrrXsYt9X
	 8FXfgmUAjYuApYUtJ+JxhmVRi9AY9sUPSgs/NQlj19RZiMscyPxrYORjhmRMUPgPnrUeE
	 IKEEzfpXvqb3+0Tw/n11XQPw8jE0CeyL8zVDLKWbTItAjrV1ewPzGv8std7rBgYoudTuI
	 A891p49uXY5W7s1NThKYLlmBtCtoqCH54kcbM0PLBtju/XZSRraMT7bEGe8lYQVa+EEHv
	 wnTc2YghMIkMOv03iEoCpyPGzDHr0B8NNvwD/A2Gmwrslw1t2gYs2RvWs2j6jiLzEFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792960913;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=3CcZDuPFATvQ2ExU1c9yUD5sEliMrlWJl5jzTcVoGa4=;
	b=hcTH6KIDrG68ZrSqz6SAbMgVAa6wYqlvPYW5sTHp2lKlMRcWOZgQwnfT+gSF15z/j2JO
	 Grt7g/lTf1p+TmI9+wdt8ad9g0SQAh1RQDgenSofJEL7XRh0pstg0YTUvqw/5kuMFdc9x
	 /Gwc5ZUzf0kAefsgALI7b5PdYb3uQWbUEsjxFa2oLmvD6GdEOtg/d7LycHEhnuXsyF5ou
	 L/JrUs6350vSOHDdfkieRO0DqmU8ZxsUGuSwI6vOoAhfrfUDWozo6t3p0+8stM+ofbw3T
	 Rp3NHmsSrhRnq0jX/2Vz60ojgFEhSDcayNyvJotsx700SKaRvd7oGd5YiMPWVVaqEyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=i6inozXc;
	arc=none smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A60606A31B;
	Sun, 25 Oct 2026 20:41:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04A60606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=i6inozXc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792960912; x=1824496912;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8KxctUHP4pWWDpHfQ9QOIlxQinkrh6vqlKGrAnUe08I=;
  b=i6inozXcl8W60maqfWGXYOoPjCWlczyUzicQuliy3SiOEZFmldTC+5MH
   jMXIudybOCTb4tvhNYrqjokyrQaUpoGmvhnEBrcouH07Lrp2ovwcmvIgM
   jrDSA4WYNyV5Zjo+4a1XIy1+3PQGWOgz1bRaa3HrHp289bi8S2jVhXiuG
   26otn2TCTNgvsq7xMygzs/8mviLjHRzp9C8NzaTd+d2NrssiWkRSOvjXO
   JoTeLK1esYpGzf3KwYQOF5J6kiEGuRkmS31lw9ICvgXY7eH5I4W7vtZmk
   iQuWkw+Ov2W4AY3TFFhZD6cq8K7LivvH2UpMn2BBDT8HctQkKDjg/bQvU
   Q==;
X-CSE-ConnectionGUID: 2gPDk1uFTGC9ECwfh57uJg==
X-CSE-MsgGUID: PhWN1ZC9TzSJ68zaTl2EFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1529916"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1529916"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 13:41:51 -0700
X-CSE-ConnectionGUID: iX+M+mzCTFWj+QaEcNGGQQ==
X-CSE-MsgGUID: 0+SCQi1sRE2Dbg3RSzUD5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="4130758"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 25 Oct 2026 13:41:49 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xL52I-00000000V8c-1EwL;
	Sun, 25 Oct 2026 20:41:46 +0000
Date: Mon, 26 Oct 2026 04:41:39 +0800
From: kernel test robot <lkp@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Nikhil Gautam <nikhilgtr@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jesper X Nilsson <jesper.x.nilsson@axis.com>
Subject: Re: [PATCH v1 1/1] iio: light: opt4001: Re-use generic struct
 s32_fract
Message-ID: <202610260406.ghXhpqoZ-lkp@intel.com>
References: <20261023090802.1957593-1-andriy.shevchenko@linux.intel.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023090802.1957593-1-andriy.shevchenko@linux.intel.com>

Hi Andy,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on linus/master v7.3 next-20261023]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/iio-light-opt4001-Re-use-generic-struct-s32_fract/20261023-110802
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20261023090802.1957593-1-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v1 1/1] iio: light: opt4001: Re-use generic struct s32_fract
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20261026/202610260406.ghXhpqoZ-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 186e70f4e6a1521991d2340d3d49b23b1beff11f)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261026/202610260406.ghXhpqoZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610260406.ghXhpqoZ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iio/light/opt4001.c:90:2: error: expected expression
      90 |         ,ratio = { .numerator = 4375, .denominator = 10000000 },
         |         ^
>> drivers/iio/light/opt4001.c:90:3: error: use of undeclared identifier 'ratio'
      90 |         ,ratio = { .numerator = 4375, .denominator = 10000000 },
         |          ^~~~~
   drivers/iio/light/opt4001.c:90:11: error: expected expression
      90 |         ,ratio = { .numerator = 4375, .denominator = 10000000 },
         |                  ^
   drivers/iio/light/opt4001.c:95:2: error: expected expression
      95 |         ,ratio = { .numerator = 3125, .denominator = 10000000 },
         |         ^
   drivers/iio/light/opt4001.c:95:3: error: use of undeclared identifier 'ratio'
      95 |         ,ratio = { .numerator = 3125, .denominator = 10000000 },
         |          ^~~~~
   drivers/iio/light/opt4001.c:95:11: error: expected expression
      95 |         ,ratio = { .numerator = 3125, .denominator = 10000000 },
         |                  ^
   6 errors generated.


vim +90 drivers/iio/light/opt4001.c

    88	
    89	static const struct opt4001_chip_info opt4001_sot_5x3_info = {
  > 90		,ratio = { .numerator = 4375, .denominator = 10000000 },
    91		.name = "opt4001-sot-5x3"
    92	};
    93	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
