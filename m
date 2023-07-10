Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C89EB64D9
	for <linux-iio@archiver.kernel.org>; Mon, 10 Jul 2023 09:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbjGJJ1I (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 10 Jul 2023 05:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjGJJ1G (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Jul 2023 05:27:06 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0078C8E;
        Mon, 10 Jul 2023 02:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688981225; x=1720517225;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I/WgV0sJEPaUA+jyYm6Sf1+ATnzrq8IVU5O5blbvl3Q=;
  b=k4UFKwuJ9sRKpY06jis67SyzdqjBOe3vvYtY1atWBhmxQTWaYUQLEZYv
   eYXb8dw9kran3Ti8SrAf7v6xGO1RUzpvwMz7foJjAumkG1MAaUiq6XVXE
   y4y2OhPY1wI+NcM826mchiN+X+jGeE+0xMtFUg1lJoIU9RKglpSh8vnUA
   XAZNtLGkZS7ZVQtsgZvyfTnNf4M/ef36eJFkATmrrBmBIdSXCkFMaP6ur
   kReC7dg3gXrdoC5wK6kN+Hp/lJm6lBhVl9k2d1ZEw9T8XKZdcYousg3Ht
   2q4S+9RvXy+jC11F6zUsmlBOfq8A8u2ATvvZoJP46rlnCLeWksSrY9iC9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="364334369"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="364334369"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 02:26:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="697936671"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="697936671"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 10 Jul 2023 02:26:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qInAO-001VsZ-1g;
        Mon, 10 Jul 2023 12:26:48 +0300
Date:   Mon, 10 Jul 2023 12:26:48 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     George Stark <gnstark@sberdevices.ru>
Cc:     jic23@kernel.org, lars@metafoo.de, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, nuno.sa@analog.com,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        kernel@sberdevices.ru
Subject: Re: [PATCH v4 2/6] iio: adc: meson: move enums declaration before
 variables declaration
Message-ID: <ZKvO2Fm2PL/Fsb+0@smile.fi.intel.com>
References: <20230707153322.114302-1-gnstark@sberdevices.ru>
 <20230707153322.114302-3-gnstark@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707153322.114302-3-gnstark@sberdevices.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jul 07, 2023 at 06:27:39PM +0300, George Stark wrote:
> Allow to use enum items for variables initialization.

"For this, move enums upper in the code."
?

-- 
With Best Regards,
Andy Shevchenko


