Return-Path: <SRS0=8vNk=SM=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E191C10F11
	for <linux-iio@archiver.kernel.org>; Wed, 10 Apr 2019 11:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 535842054F
	for <linux-iio@archiver.kernel.org>; Wed, 10 Apr 2019 11:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbfDJL4u (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:56:50 -0400
Received: from mga05.intel.com ([192.55.52.43]:40124 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726776AbfDJL4u (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 10 Apr 2019 07:56:50 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2019 04:56:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,332,1549958400"; 
   d="scan'208";a="139086383"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga008.fm.intel.com with ESMTP; 10 Apr 2019 04:56:48 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hEBqR-0006qB-Lp; Wed, 10 Apr 2019 14:56:47 +0300
Date:   Wed, 10 Apr 2019 14:56:47 +0300
From:   "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "jic23@kernel.org" <jic23@kernel.org>
Subject: Re: [RFC] iio: Handle enumerated properties with gaps
Message-ID: <20190410115647.GC9224@smile.fi.intel.com>
References: <6bbbf2db5985ba9943571876ea72ee9762ccbc2a.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bbbf2db5985ba9943571876ea72ee9762ccbc2a.camel@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Apr 10, 2019 at 11:31:09AM +0000, Ardelean, Alexandru wrote:
> Lars sent this patch a while ago.
> https://patchwork.kernel.org/patch/10097913/
> 
> I'd like to pick up the discussion.
> 
> Any thoughts/input/suggestions ?

Best way is to resend with updated Cc list.
It's hard comment on URL.

-- 
With Best Regards,
Andy Shevchenko


