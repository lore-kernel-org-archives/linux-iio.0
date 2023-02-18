Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C18C61DA4
	for <linux-iio@archiver.kernel.org>; Sat, 18 Feb 2023 17:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjBRRJi (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 18 Feb 2023 12:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBRRJh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Feb 2023 12:09:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952AE17CD6
        for <linux-iio@vger.kernel.org>; Sat, 18 Feb 2023 09:09:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41CD0B80860
        for <linux-iio@vger.kernel.org>; Sat, 18 Feb 2023 17:09:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD8AAC433D2;
        Sat, 18 Feb 2023 17:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676740174;
        bh=DuFqol2oKUj5il78ILv1Rgdao2Uo0HPeuj7VZ0n+QVE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hoCqCbywKyD25unYLHMjtPxxlGqoo0UfBImjoBw3yrpgr2ALRH7LxCNNuPGr7o2w6
         RAQzE5AA7yKHrSXuNStjogScAVwFHw/CkHqXfG4DbNra+luJeR08Gk/+RBj/BHd/jc
         yljdTKj9G9INPG58Luk9d4w5vLtrgktUwcrBKdRuSmn0Duld5CcQ+7pupq8DenuHta
         WFAoI2yMnEITXHa+Yj3NWUcGqikPbCstbh4Gdw/BzEHXj4lYnLpet99WUjBHhEJJh9
         k7V0TOn0Vl9OTQfyEYFEgKk5csdyTAaC8qZ2DD/uAb0ucI0W0BYZCDVB2zJVkiSbu+
         qPE5rmmEs+ztg==
Date:   Sat, 18 Feb 2023 17:23:53 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Darrell Kavanagh <darrell.kavanagh@gmail.com>
Cc:     linux-iio@vger.kernel.org, lorenzo@kernel.org, carnil@debian.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 2/2] iio: imu: lsm6dsx: Add ACPI mount matrix retrieval
Message-ID: <20230218172353.6255574f@jic23-huawei>
In-Reply-To: <CAMxBKG1wJYReeQSFp_NHBKWdDjxobsDBrbFP2f8WvMT=cZRj5w@mail.gmail.com>
References: <20230130201018.981024-1-jic23@kernel.org>
        <20230130201018.981024-3-jic23@kernel.org>
        <CAMxBKG2+XOvXs-89hakTcxH_FPnTjSBkbbuuCjGwVSObLPBFkw@mail.gmail.com>
        <20230205142312.4c75e7c6@jic23-huawei>
        <CAMxBKG1wJYReeQSFp_NHBKWdDjxobsDBrbFP2f8WvMT=cZRj5w@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 6 Feb 2023 00:49:24 +0000
Darrell Kavanagh <darrell.kavanagh@gmail.com> wrote:

> On Sun, 5 Feb 2023 at 14:09, Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > Hi Darrel,
> >
> > Once the other thread has reached a conclusion, if you could give
> > a Tested-by tag or reply here with what is wrong, that would be great.
> >
> > Due to bad timing this may well have to wait for next cycle now, but it
> > would be good to at least get it queued up for mainline.
> >
> > Jonathan
> >  
> 
> Hi Jonathan,
> 
> I confirm that the patches work as expected, both on kernel 6.2.0-rc6
> and backported to 6.1.0-2.
> 
> Tested-by: Darrell Kavanagh <darrell.kavanagh@gmail.org>
> 

Thanks.  I'm holding off on applying these to give Lorenzo a chance to
take a look.  They are too late for this cycle anyway so we have lots of
time.

Jonathan


> Darrell

