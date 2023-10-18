Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A35CDB47E
	for <linux-iio@archiver.kernel.org>; Wed, 18 Oct 2023 15:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbjJRPuc (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 18 Oct 2023 11:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjJRPub (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Oct 2023 11:50:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A6B11B;
        Wed, 18 Oct 2023 08:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697644229; x=1729180229;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iUWqA3urvNBr4npcinV5L9hti7YX3A4rFGtlJxXUm4M=;
  b=Wys1n9wwf59F9qVkTdoxBF7TTmRMbtI1HOhdzxOK1LnDXXaQ4emagq8J
   bGwO4bv01zUFXwmuSwvqoHRIjUJwXtoYHusTrfsVW4LXde+UAt7TTWM/S
   SxyhZLWDOAwz41UkEEuXt2Z7lPuG1Ho7ZC1Tr6UGKl9b7BX787buW3NkE
   GJjdXZrCMvbxhOCGCJO/MbrQomGkUwFI0tzAlwZweM4TMJCpb77bJs+CY
   XbyL4ZGPGOpbOEdd9jlB+4s3M/ra9vueNrdIPHHgjWaoJuzugz24SMZVN
   vd1eh3spIM+NIuiEN7DrujKt6aFJQXlIFbc9rEtLbmuhOoC+h1vj6sL8b
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="376416077"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="376416077"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 08:50:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="930246859"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="930246859"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 08:50:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qt8oQ-00000006cwJ-3Zqz;
        Wed, 18 Oct 2023 18:50:22 +0300
Date:   Wed, 18 Oct 2023 18:50:22 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sergei Korolev <dssoftsk@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: bmp280: fix eoc interrupt usage
Message-ID: <ZS/+vjVRNucewoQs@smile.fi.intel.com>
References: <20231018152816.56589-1-ak@it-klinger.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018152816.56589-1-ak@it-klinger.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Oct 18, 2023 at 05:28:16PM +0200, Andreas Klinger wrote:
> Only the bmp085 can have an End-Of-Conversion (EOC) interrupt. But the
> bmp085 and bmp180 share the same chip id. Therefore it's necessary to
> distinguish the case in which the interrupt is set.
> 
> Fix the if statement so that only when the interrupt is set and the chip
> id is recognized the interrupt is requested.
> 
> This bug exists since the support of EOC interrupt was introduced.
> Fixes: aae953949651 ("iio: pressure: bmp280: add support for BMP085 EOC interrupt")
> 
> Also add a link to bmp085 datasheet for reference.

...

> -	if (irq > 0 || (chip_id  == BMP180_CHIP_ID)) {
> +	if (irq > 0 && (chip_id  == BMP180_CHIP_ID)) {

While at it, perhaps drop extra space?

-- 
With Best Regards,
Andy Shevchenko


