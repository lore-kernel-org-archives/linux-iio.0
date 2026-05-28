Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1673EFD04;
	Thu, 28 May 2026 13:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779973800; cv=none; b=ddkSLMQ58WWRb3gD1Q0RUP8u35R7eoMOggHj4xxCjCT7JeZ+02aAuLibxy/E9ZZtOyesD5uMprAT1KJT069gn42D6wxu342SqGJpqHiiG75o43oQv9xCynOmMFAcYITzL7ZV2JhILsLhUYn+GwThHs5JO7BaYx1Gs/mHpDcwSY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779973800; c=relaxed/simple;
	bh=M4GHMGyh8NthM4VVBxzPmfqsz7fLmnq5IxpVMD3tP0I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p2/Zl0M2f2+EVq0Qf2+Bzq/Ol0G7E/ldZi1RnJZtVriK5nzHyFsJH45XD6UfJ0afUpcPvcSl6hXXRbKx161VwvCgdjgUG+jX3WzZ78l6wu8R2RXa9Piv8PiS/iVCEiw2ct+wgAR4Y8RGbxNf8VvaOzDkXa4qYLF+GVHY231jsJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FScYaL+n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FScYaL+n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A771F000E9;
	Thu, 28 May 2026 13:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779973798;
	bh=r0QrpkQCV7e0TWVW6fG/E9wzE1TJ4SiymmotkEZ+8oA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FScYaL+nQtn59lt3XFAAA9o4Yg6kEl4brpFw1LEWS7IHxDUz4mtHZtTtzkom60O/I
	 CkE+aQiTiJHwB3PdgrJ3kjmvauHOSobrvqXYrhhhhXyK7BA+MkznIG/BU2DyQtkFKR
	 Lr3Y8UgujM5kp9B11rrCi5LFCc+kWInO+/aNjtG5B2Aa7xo7HyNgXnEwbxFJn4SEnS
	 x31KCBgSewijLLjX6s4w2feHYNefrNyuvrdKt1sntsxdpMpZYXUpgPDDrqVfW55S0B
	 r6eF+hFt6UGOJqgXbtviEa1MkTylc8TVYTV+kTRSYpzYCirZM9pbLqd5MBhHhNC7g8
	 qAonuPStPCxVA==
Date: Thu, 28 May 2026 14:09:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: David Lechner <dlechner@baylibre.com>, Jyoti Bhayana
 <jbhayana@google.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Benson Leung
 <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
 oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, chrome-platform@lists.linux.dev
Subject: Re: [PATCH] iio: pressure: cros_ec_baro: simplify timestamp channel
 definition
Message-ID: <20260528140947.12c73152@jic23-huawei>
In-Reply-To: <202605281432.a64fe4iY-lkp@intel.com>
References: <20260525014654.2399354-1-dlechner@baylibre.com>
	<202605281432.a64fe4iY-lkp@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 May 2026 14:40:51 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi David,
> 
> kernel test robot noticed the following build errors:
> 
For the record, this is a side effect of some email trouble David had.
It's meant to be in a series with the patch that makes that macro
a compound literal.

> [auto build test ERROR on jic23-iio/togreg]
> [also build test ERROR on linus/master v7.1-rc5 next-20260527]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/David-Lechner/iio-pressure-cros_ec_baro-simplify-timestamp-channel-definition/20260525-134550
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> patch link:    https://lore.kernel.org/r/20260525014654.2399354-1-dlechner%40baylibre.com
> patch subject: [PATCH] iio: pressure: cros_ec_baro: simplify timestamp channel definition
> config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20260528/202605281432.a64fe4iY-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 15.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260528/202605281432.a64fe4iY-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202605281432.a64fe4iY-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from include/linux/iio/buffer.h:10,
>                     from drivers/iio/pressure/cros_ec_baro.c:9:
>    drivers/iio/pressure/cros_ec_baro.c: In function 'cros_ec_baro_probe':
> >> include/linux/iio/iio.h:356:38: error: expected expression before '{' token  
>      356 | #define IIO_CHAN_SOFT_TIMESTAMP(_si) {                                  \
>          |                                      ^
>    drivers/iio/pressure/cros_ec_baro.c:174:20: note: in expansion of macro 'IIO_CHAN_SOFT_TIMESTAMP'
>      174 |         *channel = IIO_CHAN_SOFT_TIMESTAMP(1);
>          |                    ^~~~~~~~~~~~~~~~~~~~~~~
> 
> 
> vim +356 include/linux/iio/iio.h
> 
> 00c5f80c2fad53 include/linux/iio/iio.h   Peter Rosin      2016-11-08  355  
> 07d4655b410a4d include/linux/iio/iio.h   Jonathan Cameron 2013-11-12 @356  #define IIO_CHAN_SOFT_TIMESTAMP(_si) {					\
> 07d4655b410a4d include/linux/iio/iio.h   Jonathan Cameron 2013-11-12  357  	.type = IIO_TIMESTAMP,						\
> 07d4655b410a4d include/linux/iio/iio.h   Jonathan Cameron 2013-11-12  358  	.channel = -1,							\
> 07d4655b410a4d include/linux/iio/iio.h   Jonathan Cameron 2013-11-12  359  	.scan_index = _si,						\
> 07d4655b410a4d include/linux/iio/iio.h   Jonathan Cameron 2013-11-12  360  	.scan_type = {							\
> 07d4655b410a4d include/linux/iio/iio.h   Jonathan Cameron 2013-11-12  361  		.sign = 's',						\
> 07d4655b410a4d include/linux/iio/iio.h   Jonathan Cameron 2013-11-12  362  		.realbits = 64,					\
> 07d4655b410a4d include/linux/iio/iio.h   Jonathan Cameron 2013-11-12  363  		.storagebits = 64,					\
> 07d4655b410a4d include/linux/iio/iio.h   Jonathan Cameron 2013-11-12  364  		},							\
> 07d4655b410a4d include/linux/iio/iio.h   Jonathan Cameron 2013-11-12  365  }
> 1d892719e70e47 drivers/staging/iio/iio.h Jonathan Cameron 2011-05-18  366  
> 
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

