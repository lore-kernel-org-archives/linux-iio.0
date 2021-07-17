Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6557DC636C9
	for <linux-iio@archiver.kernel.org>; Sat, 17 Jul 2021 17:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F1AE6115C
	for <linux-iio@archiver.kernel.org>; Sat, 17 Jul 2021 17:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbhGQRmU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 17 Jul 2021 13:42:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:37740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232935AbhGQRmT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 17 Jul 2021 13:42:19 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D034D6101D;
        Sat, 17 Jul 2021 17:39:19 +0000 (UTC)
Date:   Sat, 17 Jul 2021 18:41:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antti =?UTF-8?B?S2Vyw6RuZW4=?= <detegr@rbx.email>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, Hannu Hartikainen <hannu@hrtk.in>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno Sa <nuno.sa@analog.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: adis: set GPIO reset pin direction
Message-ID: <20210717184142.6999e309@jic23-huawei>
In-Reply-To: <20210714182507.4263dvarll5geacl@haukka.localdomain>
References: <60e5ac8c.1c69fb81.c69f0.abab@mx.google.com>
        <20210708095425.13295-1-detegr@rbx.email>
        <20210713185311.200023ef@jic23-huawei>
        <20210714100445.hr73r2dfkxf36f35@haukka.localdomain>
        <20210714134005.00001322@Huawei.com>
        <20210714182507.4263dvarll5geacl@haukka.localdomain>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 14 Jul 2021 21:25:07 +0300
Antti Keränen <detegr@rbx.email> wrote:

> On Wed, Jul 14, 2021 at 01:40:05PM +0100, Jonathan Cameron wrote:
> > Send the fixes tag in reply to this and I'll make sure it's added.
> > No need to bother with a v3 for just that.  
> 
> Fixes: ecb010d44108 ("iio: imu: adis: Refactor adis_initial_startup")
Great.

Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> 

