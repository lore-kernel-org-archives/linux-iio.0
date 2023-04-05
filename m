Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9FAC761AF
	for <linux-iio@archiver.kernel.org>; Wed,  5 Apr 2023 08:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236931AbjDEIuQ (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 5 Apr 2023 04:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237267AbjDEIuN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 Apr 2023 04:50:13 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876952D4B;
        Wed,  5 Apr 2023 01:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680684612; x=1712220612;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d4X4l4eWoadoe9XjyDvXrCm6FLnUWU6WjWeqxYZpAPE=;
  b=NiVTKeFPG9TF6LBjkESp76rXPrmNXcKMNxjWbCpcd26V2etLjV6+o4lo
   iKlrY+ZLjXsyuQgHdi6/CN+hnHvs31B6xmbsbeMElW43bC9dXGzmZ9wYF
   NDo6WlHzU+5qDAijzoYhAGdXzkkQVzG4R15IuvM4kB303wmeMpZHoDWLw
   FjjSZp4/0WYpYYW1xjkG9ACESbihMgjhPvcO/CrGVQkuLtSqZCkZ6XjvQ
   PxFcGQ+SDHtGgGbB2KkOvx5WCuL+nOegaGenOll1QAQwEv9CWgdtYVpJg
   SSbeij3L7HfAGTj2WE6ojEcbrW/all5Y7WwgchRLbcM3oJrihLEdsN/xd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="428688275"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="428688275"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 01:50:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="680209122"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="680209122"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 05 Apr 2023 01:50:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pjyqG-00Ckxq-2z;
        Wed, 05 Apr 2023 11:50:08 +0300
Date:   Wed, 5 Apr 2023 11:50:08 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/5] iio: addac: stx104: Improve indentation in
 stx104_write_raw()
Message-ID: <ZC02QAYZodp/cgi5@smile.fi.intel.com>
References: <cover.1680564468.git.william.gray@linaro.org>
 <ac00afab032039350d23cfc9752f8e9225537fd0.1680564468.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac00afab032039350d23cfc9752f8e9225537fd0.1680564468.git.william.gray@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Apr 04, 2023 at 10:12:00AM -0400, William Breathitt Gray wrote:
> By bailing out early if chan->output is false for the IIO_CHAN_INFO_RAW,
> indentation can be decreased by a tab and code readability improved.

...

> +		/* DAC can only accept up to a 16-bit value */
> +		if ((unsigned int)val > 65535)
> +			return -EINVAL;

While the patch is good per se, I don't like two things (which are also in the
original code):
- explicit casting (can it be avoided?)
- would be good to have U16_MAX or ?.. instead of hard coded number

Can it be addressed with (additional) patches?

-- 
With Best Regards,
Andy Shevchenko


