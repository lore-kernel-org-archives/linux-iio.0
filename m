Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F839C7EE24
	for <linux-iio@archiver.kernel.org>; Tue,  6 Jun 2023 14:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238549AbjFFO6Q (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 6 Jun 2023 10:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238555AbjFFO5S (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Jun 2023 10:57:18 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517AA1711;
        Tue,  6 Jun 2023 07:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686063428; x=1717599428;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MQEsBJHaYbXDRD+nEVDnWSxOpbHnEjtxUPCk18s4my8=;
  b=mhRx996Y0dMsCdHI79p6fnvbYPMGyGdrtjarOQHsLMbyJlg2048kBsPA
   RUPa7gqnVwNFKARBK0f9ir7yJs6VWouciReqhrJXe9gHnkM4YbhSykCsc
   7lBp7epFodQWNjuuXjtj7NSicyOxJVqp1cqt2aLCW9uHEioeUcM7/RxjY
   xDfmdTt9HQLFfOm1bQNWtROPWSwo8UXzOrQPl5dQt/vvUj07bkef8Fcmt
   VScuRLBfuzP6TWNpfxMTPZwjgNw2YKcUVBvT00h0/YnAQLwhPrQTNyYqT
   o6o3zktaerPLxpMxCPX6o7dDQBRKq8RxChCLmRIv946hoNWqxIE68YzW2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="336323090"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="336323090"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 07:56:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="774156290"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="774156290"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 06 Jun 2023 07:56:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q6Y74-001gNE-2K;
        Tue, 06 Jun 2023 17:56:46 +0300
Date:   Tue, 6 Jun 2023 17:56:46 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     George Stark <gnstark@sberdevices.ru>
Cc:     jic23@kernel.org, lars@metafoo.de, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, nuno.sa@analog.com,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        kernel@sberdevices.ru
Subject: Re: [PATCH v2] meson saradc: fix clock divider mask length
Message-ID: <ZH9JLtnlvEbgh+wD@smile.fi.intel.com>
References: <20230606135017.4141617-1-gnstark@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606135017.4141617-1-gnstark@sberdevices.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jun 06, 2023 at 04:50:17PM +0300, George Stark wrote:
> According to datasheets of supported meson SOCs
> length of ADC_CLK_DIV field is 6 bits long.
> Although all supported SOCs have the register with the
> field ADC_CLK_DIV documented later SOCs use external clock
> rather than ADC internal clock so
> this patch affects only meson8 family (S8* SOCs)

The longest line above has 60 characters, isn't it too wasteful?
Can you make it ~72?

Code wise looks good to me.

-- 
With Best Regards,
Andy Shevchenko


