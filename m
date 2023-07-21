Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DEFEB64DD
	for <linux-iio@archiver.kernel.org>; Fri, 21 Jul 2023 21:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjGUVhq (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 21 Jul 2023 17:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjGUVhp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 Jul 2023 17:37:45 -0400
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEA010CE
        for <linux-iio@vger.kernel.org>; Fri, 21 Jul 2023 14:37:41 -0700 (PDT)
Received: from localhost (88-113-24-87.elisa-laajakaista.fi [88.113.24.87])
        by fgw22.mail.saunalahti.fi (Halon) with ESMTP
        id cc4c06f2-280e-11ee-a9de-005056bdf889;
        Sat, 22 Jul 2023 00:37:32 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Sat, 22 Jul 2023 00:37:31 +0300
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH v2 6/8] iio: core: Fix issues and style of the comments
Message-ID: <ZLr6m5wHBSLKensj@surfacebook>
References: <20230721170022.3461-1-andriy.shevchenko@linux.intel.com>
 <20230721170022.3461-7-andriy.shevchenko@linux.intel.com>
 <db709099-a2aa-c03f-61bb-6130adfd6f4a@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db709099-a2aa-c03f-61bb-6130adfd6f4a@infradead.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fri, Jul 21, 2023 at 01:48:34PM -0700, Randy Dunlap kirjoitti:
> On 7/21/23 10:00, Andy Shevchenko wrote:

...

> > - * Return: 0 for successful release
> > + * Returns: 0 for successful release.

> As documented in Documentation/doc-guide/kernel-doc.rst:
>   The return value, if any, should be described in a dedicated section
>   named ``Return``.
> 
> However, as you (and I) have found, "Returns:" also works as a section name.

Plural allowed for some section(s):
'\s*(\@[.\w]+|\@\.\.\.|description|context|returns?|notes?|examples?)\s*:([^:].*)?$'

> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thank you!

-- 
With Best Regards,
Andy Shevchenko


