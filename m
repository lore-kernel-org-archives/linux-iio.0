Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D33C4321E
	for <linux-iio@archiver.kernel.org>; Mon,  5 Dec 2022 10:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiLEKjn (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 5 Dec 2022 05:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiLEKjm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Dec 2022 05:39:42 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8614B64CD;
        Mon,  5 Dec 2022 02:39:41 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5CB523A;
        Mon,  5 Dec 2022 02:39:47 -0800 (PST)
Received: from bogus (unknown [10.57.5.79])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A9993F73D;
        Mon,  5 Dec 2022 02:39:39 -0800 (PST)
Date:   Mon, 5 Dec 2022 10:39:37 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     ye.xingchen@zte.com.cn, jbhayana@google.com, lars@metafoo.de,
        Sudeep Holla <sudeep.holla@arm.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: Re: [PATCH] iio: common: scmi_iio: use sysfs_emit() to instead of
 scnprintf()
Message-ID: <20221205103937.5shuxyceadd6smex@bogus>
References: <202212011156314630626@zte.com.cn>
 <20221204154906.163c9c02@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221204154906.163c9c02@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Dec 04, 2022 at 03:49:06PM +0000, Jonathan Cameron wrote:
> On Thu, 1 Dec 2022 11:56:31 +0800 (CST)
> <ye.xingchen@zte.com.cn> wrote:
> 
> > From: ye xingchen <ye.xingchen@zte.com.cn>
> > 
> > Replace the open-code with sysfs_emit() to simplify the code.
> > 
> > Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> Applied. Cc'd scmi people as well just in case they are interested.

Thanks Ye for the patch and Jonathan for Cc-in and applying.

-- 
Regards,
Sudeep
