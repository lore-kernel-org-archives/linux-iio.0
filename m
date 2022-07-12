Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F201C433EF
	for <linux-iio@archiver.kernel.org>; Tue, 12 Jul 2022 15:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbiGLPa1 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 12 Jul 2022 11:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233732AbiGLPa0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Jul 2022 11:30:26 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33D3974BF
        for <linux-iio@vger.kernel.org>; Tue, 12 Jul 2022 08:30:25 -0700 (PDT)
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Lj4RJ2R73z6HJYw;
        Tue, 12 Jul 2022 23:29:00 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 12 Jul 2022 17:30:23 +0200
Received: from localhost (10.81.213.87) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 12 Jul
 2022 16:30:22 +0100
Date:   Tue, 12 Jul 2022 16:30:19 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <linux-iio@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>
Subject: IIO: Off sick....
Message-ID: <20220712163019.00000264@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.213.87]
X-ClientProxiedBy: lhreml726-chm.china.huawei.com (10.201.108.77) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi all,

Unfortunately after some travel / workshop I've come down with covid.
Recovering, but will going to take me a while to catch up with backlog
of reviews. I should manage to get a pull request out later this week, so
everything we already have queued up hopefully makes the merge window,
but may not catch up with everything that needs review for a little while.

Thanks,

Jonathan
