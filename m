Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723D3C433E0
	for <linux-iio@archiver.kernel.org>; Sun, 24 Jan 2021 14:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F8E0227BF
	for <linux-iio@archiver.kernel.org>; Sun, 24 Jan 2021 14:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbhAXO6X (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 24 Jan 2021 09:58:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:59736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725986AbhAXO6X (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 Jan 2021 09:58:23 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB8D222D73;
        Sun, 24 Jan 2021 14:57:40 +0000 (UTC)
Date:   Sun, 24 Jan 2021 14:57:36 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     fabrice.gasnier@foss.st.com, fabrice.gasnier@st.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        benjamin.gaignard@st.com
Subject: Re: [PATCH 0/2] Remove the IIO counter ABI
Message-ID: <20210124145736.091f795f@archlinux>
In-Reply-To: <cover.1611473891.git.vilhelm.gray@gmail.com>
References: <cover.1611473891.git.vilhelm.gray@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 24 Jan 2021 16:42:22 +0900
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> The IIO counter driver has been superseded by the Counter subsystem as
> discussed in [1]. This patchset removes the IIO counter ABI code and
> documentation.
> 
> [1] https://lore.kernel.org/lkml/20210119104105.000010df@Huawei.com/

I'm happy to see this go in general, but would like it to sit on the list for
a little while just in case anyone has a different opinion.

The ABI has been marked as deprecated for a while, but who knows if users
noticed that.  Fingers crossed no one notices us removing it.

It think it would also be good to note we still have one user of this ABI
in iio/triggers/stm32-timer-trigger.c
Hence we may want to introduce specific docs for that one case or try
to figure out a clean way to get rid of it...

Jonathan

> 
> William Breathitt Gray (2):
>   counter: 104-quad-8: Remove IIO counter ABI
>   iio: Remove the IIO counter ABI documentation
> 
>  Documentation/ABI/testing/sysfs-bus-iio       |  40 --
>  .../testing/sysfs-bus-iio-counter-104-quad-8  | 133 ----
>  MAINTAINERS                                   |   1 -
>  drivers/counter/104-quad-8.c                  | 652 ++----------------
>  drivers/counter/Kconfig                       |   2 +-
>  5 files changed, 65 insertions(+), 763 deletions(-)
>  delete mode 100644 Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8
> 

