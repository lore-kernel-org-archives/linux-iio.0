Return-Path: <SRS0=QBqV=Q3=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E48C43381
	for <linux-iio@archiver.kernel.org>; Wed, 20 Feb 2019 16:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA26F20859
	for <linux-iio@archiver.kernel.org>; Wed, 20 Feb 2019 16:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfBTQTQ (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 20 Feb 2019 11:19:16 -0500
Received: from mga03.intel.com ([134.134.136.65]:56215 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbfBTQTQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 20 Feb 2019 11:19:16 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2019 08:19:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,391,1544515200"; 
   d="scan'208";a="127950543"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga003.jf.intel.com with ESMTP; 20 Feb 2019 08:19:13 -0800
Received: from andy by smile with local (Exim 4.92-RC6)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gwUaW-0005sV-92; Wed, 20 Feb 2019 18:19:12 +0200
Date:   Wed, 20 Feb 2019 18:19:12 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1] iio: Allow to read mount matrix from ACPI
Message-ID: <20190220161912.GA9224@smile.fi.intel.com>
References: <20190220152052.31901-1-andriy.shevchenko@linux.intel.com>
 <A4C8B4CF-FA03-4330-8B02-6B6DE43CE8BC@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A4C8B4CF-FA03-4330-8B02-6B6DE43CE8BC@goldelico.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Feb 20, 2019 at 05:08:52PM +0100, H. Nikolaus Schaller wrote:
> Hi Andy,
> 
> > Am 20.02.2019 um 16:20 schrieb Andy Shevchenko <andriy.shevchenko@linux.intel.com>:
> > 
> > Currently mount matrix is allowed in Device Tree, though there is
> > no technical issue to extend it to support ACPI.
> > 
> > Convert the function to use device_property_read_string_array() and
> > thus allow to read mount matrix from ACPI if available.
> > 
> > At the same time drop the "of" prefix from its name and
> > convert current users.
> 
> Maybe we can drop the "of" prefix after my earlier patches have been accepted?
> 
> So that you patch does not break compile of my patch series.


Whatever Jonathan considers the best for the users and developers!

-- 
With Best Regards,
Andy Shevchenko


