Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46C8C07E95
	for <linux-iio@archiver.kernel.org>; Tue, 13 Jul 2021 18:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75E1E6136D
	for <linux-iio@archiver.kernel.org>; Tue, 13 Jul 2021 18:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbhGMSIB (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 13 Jul 2021 14:08:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:59138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229478AbhGMSIA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 13 Jul 2021 14:08:00 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F021C61369;
        Tue, 13 Jul 2021 18:05:08 +0000 (UTC)
Date:   Tue, 13 Jul 2021 19:07:27 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-iio@vger.kernel.org, kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: intel-qep: Remove linux/bitops.h include
Message-ID: <20210713190727.6a6c049c@jic23-huawei>
In-Reply-To: <YNsMk4qyfyZ43MfX@shinobu>
References: <20210629111657.2655688-1-jarkko.nikula@linux.intel.com>
        <YNsMk4qyfyZ43MfX@shinobu>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 29 Jun 2021 21:05:39 +0900
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> On Tue, Jun 29, 2021 at 02:16:57PM +0300, Jarkko Nikula wrote:
> > 0-DAY CI Kernel Test Service reported following iwyu warning:
> > 
> > drivers/counter/intel-qep.c:11:1: iwyu: warning: superfluous #include <linux/bitops.h>
> > 
> > Remove that include since we don't seem to use anything from it.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>  
> 
> Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Applied,

Thanks,

Jonathan

> 
> > ---
> >  drivers/counter/intel-qep.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/counter/intel-qep.c b/drivers/counter/intel-qep.c
> > index 8d7ae28fbd67..1a9512e28519 100644
> > --- a/drivers/counter/intel-qep.c
> > +++ b/drivers/counter/intel-qep.c
> > @@ -8,7 +8,6 @@
> >   * Author: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> >   * Author: Raymond Tan <raymond.tan@intel.com>
> >   */
> > -#include <linux/bitops.h>
> >  #include <linux/counter.h>
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> > -- 
> > 2.30.2
> >   

