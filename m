Return-Path: <SRS0=gatg=CJ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BECCC433E2
	for <linux-iio@archiver.kernel.org>; Mon, 31 Aug 2020 14:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C5F22083E
	for <linux-iio@archiver.kernel.org>; Mon, 31 Aug 2020 14:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598883129;
	bh=0zbntVXs1LHaboabZ4iwNpXCgnYxIBATEbzmeFCps7Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=B6K2aJEI6bPt5yXUCHqdJPKm1jcCLQnl13rAnUpwkSVik/4vf5bn0IsQPLAbVmNRi
	 D0eZUo5/MIQ5GJl6+SLSGoUUBVg3iwt3/qL85dzHUTu9o26bNcPhmNH9bezqaO4e2o
	 tFiOZ9Q0PADgJDJ+FiXMlQ0B2iILyrg7R0IZvn30=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgHaOMI (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 31 Aug 2020 10:12:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:58202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbgHaOMF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 31 Aug 2020 10:12:05 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B16620719;
        Mon, 31 Aug 2020 14:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598883125;
        bh=0zbntVXs1LHaboabZ4iwNpXCgnYxIBATEbzmeFCps7Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=quo4JmL2/fQ0Snl3IoQGsw6G/rGbkMzIENdv9sDmwyeuaOWsPwDy9GIk+S99Ju7Ht
         +aUO3/j6ISqrD7exFyxiV/KbBtv92t8wukM9/Y5jgeljw20LXAgey3kcq09PCqOJjG
         SWlIO3a7OxrZwVJnoemys/F20JP1doG/s9j9UWNg=
Date:   Mon, 31 Aug 2020 15:12:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v1 1/8] iio: accel: bma220: Fix returned codes from
 bma220_init(), bma220_deinit()
Message-ID: <20200831151201.076c0f94@archlinux>
In-Reply-To: <20200831114904.GH1891694@smile.fi.intel.com>
References: <20200831090813.78841-1-andriy.shevchenko@linux.intel.com>
        <20200831102145.0eaebb77@archlinux>
        <20200831114904.GH1891694@smile.fi.intel.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 31 Aug 2020 14:49:04 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Mon, Aug 31, 2020 at 10:21:45AM +0100, Jonathan Cameron wrote:
> > On Mon, 31 Aug 2020 12:08:06 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >   
> > > Potentially bma220_init() and bma220_deinit() may return positive codes.
> > > Fix the logic to return proper error codes instead.
> > > 
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>  
> > Hi Andy
> > 
> > A nice straight forward set and I suspect we aren't going to get any other
> > reviews, hence...
> > 
> > Series applied to the togreg branch of iio.git and pushed out as testing for
> > the autobuilders to poke at it.  
> 
> Thanks!
> 
> P.S. Consider this series as an example what can be done to many IIO drivers
> in order to clean them up. My focus, of course, ACPI interaction:
>  - use of ACPI_PTR / ifdeffery
>  - inclusion of acpi.h
>  - ...
> 

Thanks.  This is probably a good one for anyone who wants to grow their
experience in kernel patches etc.  I'll add it to my more or less
never ending list if not and get to it eventually.

In the meantime we'll try to avoid introducing any new variants!

Jonathan
