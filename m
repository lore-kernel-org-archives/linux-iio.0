Return-Path: <SRS0=ELbO=Q4=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B481C43381
	for <linux-iio@archiver.kernel.org>; Thu, 21 Feb 2019 11:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 610412086C
	for <linux-iio@archiver.kernel.org>; Thu, 21 Feb 2019 11:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725814AbfBULhs (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 21 Feb 2019 06:37:48 -0500
Received: from mga17.intel.com ([192.55.52.151]:43897 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbfBULhs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 21 Feb 2019 06:37:48 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2019 03:37:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,395,1544515200"; 
   d="scan'208";a="145345070"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga002.fm.intel.com with ESMTP; 21 Feb 2019 03:37:45 -0800
Received: from andy by smile with local (Exim 4.92-RC6)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gwmfg-00062E-Io; Thu, 21 Feb 2019 13:37:44 +0200
Date:   Thu, 21 Feb 2019 13:37:44 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v2] iio: Allow to read mount matrix from ACPI
Message-ID: <20190221113744.GE9224@smile.fi.intel.com>
References: <20190220175441.31455-1-andriy.shevchenko@linux.intel.com>
 <20190220183128.4ff6f950@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220183128.4ff6f950@archlinux>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Feb 20, 2019 at 06:31:28PM +0000, Jonathan Cameron wrote:
> On Wed, 20 Feb 2019 20:54:41 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Currently mount matrix is allowed in Device Tree, though there is
> > no technical issue to extend it to support ACPI.
> > 
> > Convert the function to use device_property_read_string_array() and
> > thus allow to read mount matrix from ACPI if available.
> > 
> > Example of use in _DSD method:
> > 
> >   Name (_DSD, Package ()
> >   {
> >      ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> >      Package ()
> >      {
> >         Package () { "mount-matrix", Package() {
> >                 "1", "0",     "0",
> >                 "0", "0.866", "0.5",
> >                 "0", "-0.5",  "0.866",
> >         } },
> >      }
> >   })
> > 
> > At the same time drop the "of" prefix from its name and
> > convert current users.
> > 
> > No functional change intended.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> You got a stray white space. I'll fix up.
> 
> Would like this to sit for a few days though before I take it.
> We have missed this merge window anyway so no rush.

Completely fine with me, thanks!

-- 
With Best Regards,
Andy Shevchenko


