Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C160EE4993
	for <linux-iio@archiver.kernel.org>; Wed, 23 Aug 2023 16:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235766AbjHWQMp (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 23 Aug 2023 12:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234317AbjHWQMp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Aug 2023 12:12:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49141EE;
        Wed, 23 Aug 2023 09:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692807163; x=1724343163;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F+JIfj+wR1bPQ5fgehpu4nlo7lbXGYyhptJI4R8nGa0=;
  b=htVDnyIeURg4RyKaGdWl+fVIgS8TZrcEcyKEn5Ds0iTiamy3reNufGKy
   CCSNbqKSR9kIwzyVMdRi3HIKhJUzabSvXkurTs4s46v1hA0n1zKw4rIdB
   5AsgAKmjlVNEJbFL3LsdB9eEj/ZnYcINgdGJLPTodSzUyxUGdGQJS5oHv
   B7DCyDcTOv3oly9v2Y1gqYZLuaCXjK4Y1KGfUpLY8kEwwXC0tk9G0Zfvp
   IhFJNB/ehMOcCYlXMfOA35wLg6avZMWr+404sqJy9+zAMdelnV80hPsSo
   9rpUpIag8rLBPyzBroYhX5b5TtrNyZ7zhhueu+mTJq0Cu7BA4o4k0qPi8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="438132889"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="438132889"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 09:10:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="880456552"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 23 Aug 2023 09:10:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qYqRF-00ElA2-1H;
        Wed, 23 Aug 2023 19:10:33 +0300
Date:   Wed, 23 Aug 2023 19:10:33 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 1/3] iio: pressure: bmp280: Use uint8 to store chip ids
Message-ID: <ZOYveUBg3rKK+ZQ9@smile.fi.intel.com>
References: <cover.1692805377.git.ang.iglesiasg@gmail.com>
 <cf08dd2fab1fd91ca7ed0724d1f50435c8c2914b.1692805377.git.ang.iglesiasg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf08dd2fab1fd91ca7ed0724d1f50435c8c2914b.1692805377.git.ang.iglesiasg@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Aug 23, 2023 at 05:58:05PM +0200, Angel Iglesias wrote:
> Represent the device id reg values using uint8 to optimize memory use.

This doesn't correspond to the code, in the code you used uint8_t.

...

>  struct bmp280_chip_info {
>  	unsigned int id_reg;
> -	const unsigned int chip_id;
> +	uint8_t chip_id;

While this will compile and even work properly in kernel we use uXX types,
here u8.

-- 
With Best Regards,
Andy Shevchenko


