Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C63C83F22
	for <linux-iio@archiver.kernel.org>; Wed, 30 Aug 2023 18:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236588AbjH3Sgc (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343916AbjH3RPS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Aug 2023 13:15:18 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69999E
        for <linux-iio@vger.kernel.org>; Wed, 30 Aug 2023 10:15:15 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RbW5n2Hl4z67QKJ;
        Thu, 31 Aug 2023 01:10:53 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 30 Aug
 2023 18:15:12 +0100
Date:   Wed, 30 Aug 2023 18:15:12 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Nuno Sa <nuno.sa@analog.com>
CC:     <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [RFC PATCH 3/3] iio: adc: adi-axi-adc: add based on new
 converter framework
Message-ID: <20230830181512.00005204@Huawei.com>
In-Reply-To: <20230804145342.1600136-4-nuno.sa@analog.com>
References: <20230804145342.1600136-1-nuno.sa@analog.com>
        <20230804145342.1600136-4-nuno.sa@analog.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 4 Aug 2023 16:53:41 +0200
Nuno Sa <nuno.sa@analog.com> wrote:

> Signed-off-by: Nuno Sa <nuno.sa@analog.com>

Nothing stood out as a particular problem in here
either...

Jonathan
