Return-Path: <SRS0=SxNN=ZE=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9137C43331
	for <linux-iio@archiver.kernel.org>; Tue, 12 Nov 2019 15:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9565F20650
	for <linux-iio@archiver.kernel.org>; Tue, 12 Nov 2019 15:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfKLPBz (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 12 Nov 2019 10:01:55 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6213 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726964AbfKLPBz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 12 Nov 2019 10:01:55 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4D83E40F3321E03C7A5D;
        Tue, 12 Nov 2019 23:01:52 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Tue, 12 Nov 2019
 23:01:50 +0800
Date:   Tue, 12 Nov 2019 15:01:46 +0000
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: Testing branch lacking fix patch
Message-ID: <20191112150146.00005d99@huawei.com>
In-Reply-To: <MN2PR12MB3373790C6E13D3FB360B17C6C4770@MN2PR12MB3373.namprd12.prod.outlook.com>
References: <MN2PR12MB3373790C6E13D3FB360B17C6C4770@MN2PR12MB3373.namprd12.prod.outlook.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 12 Nov 2019 12:53:52 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> Hi Jonathan,
> 
> I am planning to send new patches for the inv_mpu6050 driver, but the
> actual testing branch is lacking the fix patch present in
> fixes-togreg branch and already sent upstream: iio: imu: inv_mpu6050:
> fix no data on MPU6050
> 
> The issue is that these new patches require the last development from
> the testing branch, but also this fix. Is there a plan to merge both
> of them at some point?

That should happen automatically when I rebase after Greg takes the
latest pull. If Greg doesn't take that pull it will only happen after the
merge window closes.

In meantime take what you get if you merge togreg into Greg's staging-next
branch and mention it in the cover letter.

Thanks,

Jonathan
> 
> Thanks for your help.
> JB

