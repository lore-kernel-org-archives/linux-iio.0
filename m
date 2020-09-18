Return-Path: <SRS0=Hov9=C3=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1415CC43465
	for <linux-iio@archiver.kernel.org>; Fri, 18 Sep 2020 12:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C11B3208B8
	for <linux-iio@archiver.kernel.org>; Fri, 18 Sep 2020 12:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600432443;
	bh=GLGgObBgk5FzcSv1LJLsgpYxzpvv3RjfB1mnymQD/gE=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=ZT/R6zsOvaE3BOLxnAOG63GhwU9CGbOOdZ7/eSLbv/6AchddGCVAnK0ClbW0Ls+IE
	 pz+brbSO32tLiJSl46dpKnrC9pd438mPzdsP4BaBoWjCiQJxxb/gnK465w6tvncUSG
	 gIE0OL42WlDWtnIeEEsH6N73ccvck8In9WMUgctI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgIRMeD (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 18 Sep 2020 08:34:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:57348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbgIRMeD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 18 Sep 2020 08:34:03 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AA1C206D9;
        Fri, 18 Sep 2020 12:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600432442;
        bh=GLGgObBgk5FzcSv1LJLsgpYxzpvv3RjfB1mnymQD/gE=;
        h=Date:From:To:Cc:Subject:From;
        b=uUOLLzY5BZbSY6ESYrjs2vvdc+i8T9yLRMsh1WAePb1JpYi4/uWrDoZMqEfhcPvya
         gHl+lP6cxg8bD5YFJ8pzQPsPWj/cmI0NdQQYGDyp7D/bhS3q5x1F8ACsOWTH26Y0ps
         C441KecZyGWRfP2AlaW+Gq+6lw1CX7MeiEiUV4rk=
Date:   Fri, 18 Sep 2020 13:33:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: IIO: Review request.
Message-ID: <20200918133357.0ed56512@archlinux>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi All,

Classic being the maintainer problem, is that there is no one specific to pester
when you can't get reviews on your own patches.  Hence if anyone has some
time I'd appreciate sanity checks on:

[PATCH 2/3] iio: Add __printf() attributes to various allocation functions
https://lore.kernel.org/linux-iio/20200913132115.800131-3-jic23@kernel.org/

[PATCH 3/3] iio:core: Tidy up kernel-doc.
https://lore.kernel.org/linux-iio/20200913132115.800131-4-jic23@kernel.org/

[PATCH] iio:magn:hmc5843: Fix passing true where iio_shared_by enum required.
https://lore.kernel.org/linux-iio/20200913112546.715624-1-jic23@kernel.org/

[PATCH] iio:accel:bma180: Fix use of true when should be iio_shared_by enum
https://lore.kernel.org/linux-iio/20200913121227.764626-1-jic23@kernel.org/

For those last 2 I forgot I'd previously sent effectively the same fixes out
earlier in the year but didn't get any reviews then either :(

Note I've randomly picked a few people who have done reviews or posted a lot
of patches recently for the cc list.  I'm more than happy if anyone else
wants to join in with the fun :)  Reviews are always appreciated for any
code submitted to IIO from anyone.  If you are unsure about something in
a review, it is fine to say so.  Hence even relatively new people can
offer great value.  We all started somewhere!

Thanks,

Jonathan
