Return-Path: <SRS0=qrlV=IG=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76206C433DB
	for <linux-iio@archiver.kernel.org>; Mon,  8 Mar 2021 04:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 454896513A
	for <linux-iio@archiver.kernel.org>; Mon,  8 Mar 2021 04:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbhCHE2y (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 7 Mar 2021 23:28:54 -0500
Received: from foss.arm.com ([217.140.110.172]:59154 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234125AbhCHE2v (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Mar 2021 23:28:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49018D6E;
        Sun,  7 Mar 2021 20:28:51 -0800 (PST)
Received: from bogus (unknown [10.57.15.109])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E43873F73C;
        Sun,  7 Mar 2021 20:28:45 -0800 (PST)
Date:   Mon, 8 Mar 2021 04:28:42 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jyoti Bhayana <jbhayana@google.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        Enrico Granata <egranata@google.com>,
        Mikhail Golubev <mikhail.golubev@opensynergy.com>,
        Igor Skalkin <Igor.Skalkin@opensynergy.com>,
        Peter Hilber <Peter.hilber@opensynergy.com>,
        Ankit Arora <ankitarora@google.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v6 1/1] iio/scmi: Adding support for IIO SCMI Based
 Sensors
Message-ID: <20210308042842.e6qr4xxp5tl5ahos@bogus>
References: <20210212172235.507028-1-jbhayana@google.com>
 <20210212172235.507028-2-jbhayana@google.com>
 <20210221144616.4eef6a79@archlinux>
 <CA+=V6c1aKy1nPDMJ+mhB6drUEs6T7SVKon8chH++6Zv1dkv+GA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+=V6c1aKy1nPDMJ+mhB6drUEs6T7SVKon8chH++6Zv1dkv+GA@mail.gmail.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On Tue, Feb 23, 2021 at 10:30:37AM -0800, Jyoti Bhayana wrote:
> Hi Jonathan,
>
> Thanks for the detailed and careful review of this patch. Good to hear
> that v7 is not required.   Please find below answers to your
> questions. Looking forward to seeing this patch merged in the next
> cycle. Thanks for your help in making this happen.
>

Any update on this ? Please share the branch with is patch so that I
can pull and ask Cristian to make his changes on top.

--
Regards,
Sudeep
