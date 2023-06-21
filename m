Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269EEEB64D8
	for <linux-iio@archiver.kernel.org>; Wed, 21 Jun 2023 14:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjFUOIO (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 21 Jun 2023 10:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjFUOIN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Jun 2023 10:08:13 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F3818C;
        Wed, 21 Jun 2023 07:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687356492; x=1718892492;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TZipVQx34qmoVG1MjtaxYWtXx0xWNWvBS+tqILr8eUs=;
  b=GVFkoiQM0JKyM2MnvZiCAOVmrfGJtjkeKnOSiEnqfT8kl7GbluAu6pvL
   pYaBjeSMAElIK8263/22RzvXLC2vt8RA2IqvE3r0bDFuN5ivpPu15qCr1
   Prb9TiSkZBKtngSjIMjKQW3hkB+ZO4b5aVOFAWlLiHFhjHNplAWpRDAr6
   YRdIhu4XCjw02/68wA/5ENVyiUROL6yUZWkT0Axz29yhBtfPsrryUHg2q
   r/KWd7BaEnw9a6PBORIJ73BKqSLTdKKX2KKhygV9bE9RQmYNwxeleszoN
   RvoYZC+ewQU2fMKaI2llCSByUcimj65lsQWvpZMk2pZdwBSRFRFqPbL+q
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="363603523"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="363603523"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 07:08:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="744185238"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="744185238"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 21 Jun 2023 07:08:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qByVC-005Vvy-1J;
        Wed, 21 Jun 2023 17:08:06 +0300
Date:   Wed, 21 Jun 2023 17:08:06 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     George Stark <gnstark@sberdevices.ru>
Cc:     jic23@kernel.org, lars@metafoo.de, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, nuno.sa@analog.com,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        kernel@sberdevices.ru
Subject: Re: [PATCH v1 2/3] meson saradc: add channel labels
Message-ID: <ZJMERuXDtKi4wjR/@smile.fi.intel.com>
References: <20230621062715.455652-1-gnstark@sberdevices.ru>
 <20230621062715.455652-3-gnstark@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621062715.455652-3-gnstark@sberdevices.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jun 21, 2023 at 09:26:09AM +0300, George Stark wrote:
> patch adds channel attribute 'label' with channel name

Please update commit message in accordance with English grammar and
Submitting Patches document (e.g. imperative mode should be used).

-- 
With Best Regards,
Andy Shevchenko


