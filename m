Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23D3C76196
	for <linux-iio@archiver.kernel.org>; Fri, 24 Mar 2023 11:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjCXLuN (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 24 Mar 2023 07:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjCXLuN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Mar 2023 07:50:13 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8592D1FFC;
        Fri, 24 Mar 2023 04:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679658612; x=1711194612;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Mld7Mo3TD47F918MtnNcdmlripEaM7/E08D75qy8iz4=;
  b=XSm/k5v+tVJD7us6j2Z8MJTLRFofDD+hZC5olx4oh2chtKFFTk8xPaHv
   h+n7VDiKJO8TpAvk+TH7nny7EBC0V/oM8Ato87rhbdeMpbW41DVIMXdZ9
   YjuesbEzawfxD01rREqpe/crOKz27gHHi+VRUfAHZzdRGD06JYsuvG966
   ynUyj+RHKZjOAHR4Yum90S0OGKYClxtKJLdMHFgjlyzzLG3IZM1hBapQB
   EMU3XCFTqIVsjY+9pbhjn89LW643TPhho+G5p6QSCxEV8JVLY8oAhDzSZ
   VToDcHmTwUaPsf5hCfWTcwd8OO5CcHo0tilfU2+dDfdGMiDcZUTiFVRDx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="404676595"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="404676595"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 04:50:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="856843520"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="856843520"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 24 Mar 2023 04:50:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pffvr-007t2N-1h;
        Fri, 24 Mar 2023 13:50:07 +0200
Date:   Fri, 24 Mar 2023 13:50:07 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     linux-iio@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] counter: 104-quad-8: Refactor to buffer states
 for CMR, IOR, and IDR
Message-ID: <ZB2Ob9VGe3GoEVko@smile.fi.intel.com>
References: <cover.1679605919.git.william.gray@linaro.org>
 <c5adb13b4b0887beb1df40b34d2ef03d63a2860d.1679605919.git.william.gray@linaro.org>
 <ZB2OG4zZXsqqyN8v@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZB2OG4zZXsqqyN8v@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Mar 24, 2023 at 01:48:43PM +0200, Andy Shevchenko wrote:
> On Thu, Mar 23, 2023 at 05:25:28PM -0400, William Breathitt Gray wrote:

...

> > +static void quad8_control_register_update(struct quad8 *const priv, u8 *const buf,
> > +					  const size_t channel, const u8 val, const u8 field)
> > +{
> > +	u8p_replace_bits(&buf[channel], val, field);
> > +	iowrite8(buf[channel], &priv->reg->channel[channel].control);
> > +}
> 
> How did you compile this?
> Due to nature of *_replace_bits() this may only be a macro.
> 
> That's what LKP is telling about I think.

Ah, no, that's because the last parameter is not constant in the last patch in
the series.

-- 
With Best Regards,
Andy Shevchenko


