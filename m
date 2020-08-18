Return-Path: <SRS0=Jk4W=B4=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818EEC433DF
	for <linux-iio@archiver.kernel.org>; Tue, 18 Aug 2020 00:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6036E2078E
	for <linux-iio@archiver.kernel.org>; Tue, 18 Aug 2020 00:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgHRAT0 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 17 Aug 2020 20:19:26 -0400
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:47734 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbgHRATY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Aug 2020 20:19:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id C247720160C9;
        Tue, 18 Aug 2020 08:19:21 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HcIEno6LPT2x; Tue, 18 Aug 2020 08:19:21 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 9E4BD20160B5;
        Tue, 18 Aug 2020 08:19:21 +0800 (HKT)
Received: from [10.128.2.32] (unknown [203.145.95.142])
        by s01.gtsys.com.hk (Postfix) with ESMTPSA id 203D7C01B7A;
        Tue, 18 Aug 2020 08:19:21 +0800 (HKT)
Subject: Re: [PATCH] iio/dac: convert ltc2632.txt to lltc,ltc2632.yaml
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Michael Hennerich <michael.hennerich@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200810033806.15503-1-chris.ruehl@gtsys.com.hk>
 <20200816102733.7fa1d3ce@archlinux>
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
Message-ID: <e62dd384-3cce-dc84-cbf4-00fc6225d3cc@gtsys.com.hk>
Date:   Tue, 18 Aug 2020 08:19:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200816102733.7fa1d3ce@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan


On 16/8/2020 5:27 pm, Jonathan Cameron wrote:
> On Mon, 10 Aug 2020 11:37:52 +0800
> Chris Ruehl <chris.ruehl@gtsys.com.hk> wrote:
> 
> Hi Chris,
> 
> This will need a dt-binding maintainer review, but in the meantime...
> 
> Look at the title for dt-bindings patches and match that format.
> 
> One question for Rob inline.   A quick grep suggests we are
> very inconsistent on whether we use the multiline block
> thing for description fields or not.
> 
> Is it needed?

ok, next submit [PATCH] dt-bindings: iio/dac: ...

just wait for Rob and his advice on your question regarding the | in the
block.

Regards
Chris

