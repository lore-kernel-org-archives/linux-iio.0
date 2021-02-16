Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFF3C433DB
	for <linux-iio@archiver.kernel.org>; Tue, 16 Feb 2021 20:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 653FC64E63
	for <linux-iio@archiver.kernel.org>; Tue, 16 Feb 2021 20:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbhBPUR3 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 16 Feb 2021 15:17:29 -0500
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:52288 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbhBPUR1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 Feb 2021 15:17:27 -0500
X-Greylist: delayed 498 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Feb 2021 15:17:26 EST
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id F3E7C9E013D;
        Tue, 16 Feb 2021 20:09:13 +0000 (GMT)
Date:   Tue, 16 Feb 2021 20:09:12 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     linux-doc@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 0/5] docs: iio: misc fixes and improvements
Message-ID: <20210216200912.40ccb1c8@archlinux>
In-Reply-To: <20210215143511.25471-1-luca@lucaceresoli.net>
References: <20210215143511.25471-1-luca@lucaceresoli.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 15 Feb 2021 15:35:06 +0100
Luca Ceresoli <luca@lucaceresoli.net> wrote:

> Here are a few minor fixes and improvements to the IIO documentation.
> 
> Luca Ceresoli (5):
>   docs: iio: fix example formatting
>   docs: iio: fix directory naming
>   docs: iio: document the 'index' attribute too
>   docs: iio: fix bullet list formatting
>   docs: iio: mark "repeat" sysfs attribute as optional
> 
>  Documentation/driver-api/iio/buffers.rst | 15 ++++++++-------
>  Documentation/iio/iio_configfs.rst       |  2 +-
>  2 files changed, 9 insertions(+), 8 deletions(-)
> 
Applied to the togreg branch of iio.git and pushed out as testing
for reasons not particularly related to these patches (though I guess
0-day might do a docs build occasionally)

Jonathan

