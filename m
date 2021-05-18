Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0126C433B4
	for <linux-iio@archiver.kernel.org>; Tue, 18 May 2021 17:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C51E611BF
	for <linux-iio@archiver.kernel.org>; Tue, 18 May 2021 17:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351420AbhERSAr (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 18 May 2021 14:00:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:52880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351415AbhERSAq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 18 May 2021 14:00:46 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6404601FE;
        Tue, 18 May 2021 17:59:24 +0000 (UTC)
Date:   Tue, 18 May 2021 19:00:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Tang Bin <tangbin@cmss.chinamobile.com>, lars@metafoo.de,
        Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Lucas Stankus <lucas.p.stankus@gmail.com>
Subject: Re: [PATCH] staging: iio: cdc: ad7746: Remove unnecessary
 assignment in ad7746_probe()
Message-ID: <20210518190042.1666ca00@jic23-huawei>
In-Reply-To: <20210518101626.GO1955@kadam>
References: <20210518095647.3008-1-tangbin@cmss.chinamobile.com>
        <20210518101626.GO1955@kadam>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 18 May 2021 13:16:26 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> On Tue, May 18, 2021 at 05:56:47PM +0800, Tang Bin wrote:
> > In the function ad7746_probe(), the initialized value of 'ret' is unused,
> > because it will be assigned by the function i2c_smbus_write_byte_data(),
> > thus remove it.
> > 
> > Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>  
> 
> Thanks!
> 
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> regards,
> dan carpenter
> 
As this doesn't (I think) overlap with Lucas' series I've applied this
one to the togreg branch of iio.git and pushed it out as testing for the
autobuilders to see if we missed anything.

