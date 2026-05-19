Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613173DCDB5
	for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 07:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779177547; cv=none; b=oIg5pU8lWwGTtS9X4m2wqwJRec5itH+V6RAsP6uu8HV6+n1KHViCBDc624yQA59yLqKwKrcBN6mzMgOESW+lR288++QQNqmq40EV/8AES1TrHRXPGfi3LvKyz1WAG3JPA2SfNShqGcAR9nr5DhH6wpOhX5b8RvyFrEShh6FtfVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779177547; c=relaxed/simple;
	bh=dDe5ISZtdomf+hnyNFOgzEv6n1mbjYqwSsrmVrOVxHY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ua1P/0s2ol5yxTz7nNc1/NWXEwBvo2KxvnMeVxnsfUM9/DBcvxV62eFt2o+7qrBfa3afCV2AqcTT8Y2WoAebbPIY+woumkapR3MuLRN91mkrD7kTZoRViEGyvQdq2wczOc0NQqxZMLDgpw9VFj3AnK1dTbDPa5BlW96NarhzcHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LIWK/DzL; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIWK/DzL"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso19315115e9.0
        for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 00:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779177545; x=1779782345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qIaDQb61nFaJysAgVO0hYea1n6OBZz1pXSKqoKiGMyA=;
        b=LIWK/DzL4zkfzBOWOKvBzq4+x4+q+/BIRAQCb3//LcZo5gNr+/EAl10gzO506DvQu/
         wzo4e8sJ2SR2gbmPuBkzsAZyZaCm4yvI2Ex18oiQNwC0L1Fb/hi7lQ/HwpOCxnNnk/Jt
         sCu3Z3s8lSMxg3y2gvqHe/TF0hxs+rtw/UqA1GwEmutIX2YSfvrg/MdEwBE1q+F7XUXa
         ddno21Ah0CQBzyQenNHyJTRFGzRCiGODDLrUJ8ECKjSC/W0MxlaISSlHWbdXy/f09HCz
         ghl/CKUiEP+l992g1fmb2HPTDk2GukOq8hI+djpkAF1Z4FEq6SP8bTH4j0mXXzOaWw/9
         6jug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779177545; x=1779782345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qIaDQb61nFaJysAgVO0hYea1n6OBZz1pXSKqoKiGMyA=;
        b=SgYQlRIxdszzYeIaMx/YeThCbey6TVUGvbIBXGCs4ZVmColyt0Fd4kEpaOzAqD9bq7
         lX1YjuuJCmZyIegOi1WbbEoo1YkuYpWV0KeSGWkZXIg1HJy6USmLDIegIlMqQFJF4qfW
         dAnMSrc+OuoHEviKdf1RawX05xzaDIWMToraFjuYTmgX8YKXH6ttCOsN9Y9R1xO/9giI
         8tdcqrWHCnmfNsj+yxXvSsYlyyw819FJQ/IxuiezfjoLSMrCoCnwEqYzRXn+EhM4tnNU
         HK3HcUaOlg2QtRU/mM215VZbMS0fbArZmWLI8raH4ySNA7Of1CuNX3HvJd2ftjbK9wPU
         UfWw==
X-Forwarded-Encrypted: i=1; AFNElJ+VKhq5K0KB4UB0P36PIlGUzzW4IJWPPRt+dOiPb4SnZkIv7TkJE2eYgEvC9+6D5J4T06lomHbKFsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhhTjmYbqvCRwpWrlsLH4rzGTy5+iB5IWhl3f8E1o56Dxuuu6D
	V68ZkQCVK5TuZzGQprwUrl2xqyEzMlYupIoCwKmxgRYKhEG2C+rHC84z
X-Gm-Gg: Acq92OEnd/6TKjfw/IhLShckyddjfAwndK3+Td+wN9ujEkSyeJUGxNhb+eWAYv8jLIe
	JqxtLHSVq6XYIS1MRkmV+vPGvm4Y1ujSKGVbqnkUvGUK+Oq2aFg3cPKyLOrgv3cwCs9KyNMqHnD
	CB8HM0lBBFNlq8x0CY4Zrk71AlU2I2UZZN/ohdgBbn+oZFRcJeTDp5I8H8ADEsRR7POBNxOAbuA
	ALZHuml2jEojVFNdFX/y+yTve1qUZuh8NpUWskfWTZovgzqmMeq4y8zBw2gMml62KwXAUCb8mTq
	gNxt/6sIarIhjRhepbqwUOOoDbKKjQNo42u72qcGuVZDKHLU5dKWEDV6sS4RlG1+Dbuvp4XKvrq
	3yU+2ayOJPHENUSz8Idkyy21tP/6riQfO0t8OhT/N40q/D5k79RePqYdr9lV8q95wJQf/b3nvT5
	H5imFMbL95/obY3Y202teE7KqEn8+XGcLj3QcJhs1a3aOV7Yfx9Yhl8pxWRQetrOwS
X-Received: by 2002:a05:600c:4685:b0:48e:5d91:cfe3 with SMTP id 5b1f17b1804b1-48fe5fd494dmr283200195e9.1.1779177544506;
        Tue, 19 May 2026 00:59:04 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490225bf8d6sm1893155e9.13.2026.05.19.00.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 00:59:04 -0700 (PDT)
Date: Tue, 19 May 2026 08:59:02 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: kernel test robot <lkp@intel.com>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v0 1/1] iio: Convert IIO_CHAN_SOFT_TIMESTAMP() to be
 compound literal
Message-ID: <20260519085902.28b1730a@pumpkin>
In-Reply-To: <agtXwmSPs8iARJ_e@ashevche-desk.local>
References: <20260518071349.469748-1-andriy.shevchenko@linux.intel.com>
	<202605190130.oWitiRzG-lkp@intel.com>
	<agtXwmSPs8iARJ_e@ashevche-desk.local>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 May 2026 21:17:38 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Tue, May 19, 2026 at 01:32:51AM +0800, kernel test robot wrote:
> 
> > kernel test robot noticed the following build warnings:
> > 
> > [auto build test WARNING on jic23-iio/togreg]
> > [also build test WARNING on linus/master v7.1-rc4 next-20260518]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/iio-Convert-IIO_CHAN_SOFT_TIMESTAMP-to-be-compound-literal/20260518-151541
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> > patch link:    https://lore.kernel.org/r/20260518071349.469748-1-andriy.shevchenko%40linux.intel.com
> > patch subject: [PATCH v0 1/1] iio: Convert IIO_CHAN_SOFT_TIMESTAMP() to be compound literal
> > config: sparc64-randconfig-r132-20260518 (https://download.01.org/0day-ci/archive/20260519/202605190130.oWitiRzG-lkp@intel.com/config)
> > compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 5bac06718f502014fade905512f1d26d578a18f3)
> > sparse: v0.6.5-rc1
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260519/202605190130.oWitiRzG-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202605190130.oWitiRzG-lkp@intel.com/
> > 
> > sparse warnings: (new ones prefixed by >>)  
> > >> drivers/iio/adc/max11410.c:807:31: sparse: sparse: cast to non-scalar
> > >> drivers/iio/adc/max11410.c:807:31: sparse: sparse: cast from non-scalar  
> 
> Thanks, the sparks were expected exactly in this and one more driver.
> I mentioned that in my reply to my own patch already.
> 

Can you just remove then cast from:
a44ef7c4609724e Ibrahim Tilki    2022-10-03 @807 \
  	channels[chan_idx] = (struct iio_chan_spec)IIO_CHAN_SOFT_TIMESTAMP(chan_idx);
since it is no longer needed?

-- David
