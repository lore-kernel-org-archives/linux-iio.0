Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4478CC433FE
	for <linux-iio@archiver.kernel.org>; Mon,  7 Nov 2022 10:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiKGKgn (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 7 Nov 2022 05:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbiKGKgm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Nov 2022 05:36:42 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 342DFF49
        for <linux-iio@vger.kernel.org>; Mon,  7 Nov 2022 02:36:41 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24A4223A;
        Mon,  7 Nov 2022 02:36:47 -0800 (PST)
Received: from bogus (unknown [10.57.6.137])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA9943F534;
        Mon,  7 Nov 2022 02:36:39 -0800 (PST)
Date:   Mon, 7 Nov 2022 10:36:36 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     =?utf-8?Q?M=C3=A5rten?= Lindahl <marten.lindahl@axis.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH] iio: light: vcnl4000: Don't create sysfs PM nodes for
 child
Message-ID: <20221107103636.bua6xd5tghuisddb@bogus>
References: <20221101122151.221029-1-marten.lindahl@axis.com>
 <20221106152307.4bfb4e49@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221106152307.4bfb4e49@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Nov 06, 2022 at 03:23:07PM +0000, Jonathan Cameron wrote:
> On Tue, 1 Nov 2022 13:21:51 +0100
> Mårten Lindahl <marten.lindahl@axis.com> wrote:
> 
> > PM runtime is enabled for the parent i2c device, but it is disabled for
> > the iio child device and remains so in this driver. But as the child
> > sysfs PM directory is created by default by iio_device_register =>
> > cdev_device_add => dpm_sysfs_add it doesn't bring any value exposing it
> > since it won't give any usable data for the user.
> > 
> > Tell dpm_sysfs to not create the PM directory for the iio device.
> > 
> > Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
> 
> Ah this one..  +CC Sudeep who I am sure has considered such changes in other
> similar cases (he did the original ones that mean this infastructure exists).
>

Yes it was added for cache devices which are child devices of CPU devices via
Commit 85945c28b5a8 ("PM / core: Add support to skip power management in device/driver model")

Since CPU and its children are power managed quite differently(via cpuidle
or cpu hotplug), the new API(device_set_pm_not_required) fits the usecase
there well. I am not sure about this IIO usecase.

-- 
Regards,
Sudeep
