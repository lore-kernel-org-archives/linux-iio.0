Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB949C43334
	for <linux-iio@archiver.kernel.org>; Sat, 16 Jul 2022 15:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiGPPdA (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 16 Jul 2022 11:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGPPc7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 16 Jul 2022 11:32:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3871EACD;
        Sat, 16 Jul 2022 08:32:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A325EB8090C;
        Sat, 16 Jul 2022 15:32:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2311C34114;
        Sat, 16 Jul 2022 15:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657985576;
        bh=Fsb9/P/keB7qnvgsRy6sGL+85mVi6LM3d8slXwrJvwM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PPFpcOrt52ueYzaqnmYuw9eKJLzc3RIL4BdHTKjwREeoY1R3fk9RPOWpySM8YQgmF
         NVXox/QKw2AQXeIxo68EhxiZBhSFnPqM8T7fAbKOj2bN/pE4IzPcdBQxZltkdME8EO
         oldF3oqcyqKNXuP3rnhX7bFpqIlqtDBH8oM7wP7ZspGBfaiVwMhkC5sWP7wZvY5BBD
         aipmqIFgKgQh3NTIvSb84ChFv+K8J2o9klFALLcuyUzhdY7qVG1gMUeowJzMjVrTKZ
         PNsk24eyQUbpurUNg1lmwqhobonxpwXqkmH4OQ1Y6RlWaExbuEwS8gujQr3KEDPCoa
         eW2baAuzKIsOA==
Date:   Sat, 16 Jul 2022 16:42:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 2/2] iio: proximity: sx_common: Allow IIO core to
 take care of firmware node
Message-ID: <20220716164249.4cb9c942@jic23-huawei>
In-Reply-To: <YsG5qCQMXKHm3DWm@smile.fi.intel.com>
References: <20220615114746.2767-1-andriy.shevchenko@linux.intel.com>
        <20220615114746.2767-2-andriy.shevchenko@linux.intel.com>
        <CAPUE2use-nt7LRQ0g_L7EW7wWfPQ-c7LinRoyx_WeMzLfdWOag@mail.gmail.com>
        <YsG5qCQMXKHm3DWm@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 3 Jul 2022 18:45:44 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Wed, Jun 29, 2022 at 10:07:40AM -0700, Gwendal Grignou wrote:
> > On Wed, Jun 15, 2022 at 4:47 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:  
> > >
> > > IIO core correctly will take care of firmware node if it's not set in
> > > the driver. Drop ACPI and OF specifics from the driver and allow IIO
> > > core to handle this.
> > >
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>  
> > Reviewed-by: Gwendal Grignou <gwendal@chromium.org>  
> 
> Thanks!
> 
> Jonathan, I guess we are ready with this series. What do you think?
> 
Gwendal's happy and seems straight forwards to me.

Applied to the togreg branch of iio.git and pushed out as testing.
Note, unlikely to make this cycle so I'll probably hold it in testing only
until I can rebase on rc1.

Thanks,

Jonathan
