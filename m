Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E83DC7EE29
	for <linux-iio@archiver.kernel.org>; Thu, 25 May 2023 13:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241085AbjEYNSB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 25 May 2023 09:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjEYNSA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 May 2023 09:18:00 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E47135
        for <linux-iio@vger.kernel.org>; Thu, 25 May 2023 06:17:56 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QRpTP6Lj5z67hv7;
        Thu, 25 May 2023 21:15:53 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 25 May
 2023 14:17:53 +0100
Date:   Thu, 25 May 2023 14:17:52 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: Upcoming patches for invensense sensors
Message-ID: <20230525141752.000038bb@Huawei.com>
In-Reply-To: <FR3P281MB1757168932252EB79484912ACE419@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <FR3P281MB1757168932252EB79484912ACE419@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 24 May 2023 13:48:04 +0000
Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:

> Hi Jonathan,
> 
> I'm planning to send patches for a refactorization of timestamp computation for our 2 drivers (inv_mpu6050, inv_icm42600).
> 
> The idea is to take out timestamping of inv_icm42600 into a separate common module, and use it for both inv_icm42600 and inv_mpu6050 drivers.
> 
> For that, I would need the last 2 patches of inv_icm42600 driver (fix timestamp reset & avoid frequent timestamp jitter) in a branch. And 1st one is in fixes-togreg branch while the other sit in testing branch.
> 
> Is it possible to get the fix timestamp reset patch inside the testing branch, so I can send my series?

That would make a bit of a mess of the various pull requests, so I'd rather not.
I should however get on with sending that fixes one given I wrote the signed tag message
last weekend but haven't sent it to greg yet.

It's fine to apply that patch locally for your dev branch then send the other patches
with a note in the cover letter to say that it's a prerequisite.

Jonathan

> 
> Thanks for your help,
> JB
