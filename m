Return-Path: <SRS0=7En4=6N=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A919C83000
	for <linux-iio@archiver.kernel.org>; Wed, 29 Apr 2020 20:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB1B7214AF
	for <linux-iio@archiver.kernel.org>; Wed, 29 Apr 2020 20:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="HTOA934A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgD2UuB (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 29 Apr 2020 16:50:01 -0400
Received: from vern.gendns.com ([98.142.107.122]:59342 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726511AbgD2UuB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 29 Apr 2020 16:50:01 -0400
X-Greylist: delayed 1724 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Apr 2020 16:50:00 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Y8MYBDFCYPC4U8pxIx3v4pRrJy5sBdcHs+qbfFFaKhU=; b=HTOA934A6qy/XJhCXv7JieZkm9
        VDL/VwsXQXfZKMgebwhoX79DwCe1dEyeNLemwXBIk8tM5mFwdDDYFvPECAQCzz75BADr6511h+kZm
        b8xC6rq+M3ApF0SyHRlkvEHJekU7J0f4DZ8eUQvE4QuZoVDF0ga3EBnACXPC9HY9MiFJVOENmdDtj
        V6tmcJNN1od8LGMdW7BZHbnD6DX6UdWZuMsTjoiZDME+RGH4YX2Cz59VwIWX2x2edHepq3assRPm5
        7v+9TI4QaC6GTRJwyxxr7pBa0wkQ6YQmJFqwDC/WN7rMHSh9ev0BsCPqOzmnf/buNsVuHQbXNNHod
        d6QWNSXQ==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:40316 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1jTtCd-0005BN-Mc; Wed, 29 Apr 2020 16:21:07 -0400
Subject: Re: [PATCH 0/4] Introduce the Counter character device interface
To:     William Breathitt Gray <vilhelm.gray@gmail.com>, jic23@kernel.org
Cc:     kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, felipe.balbi@linux.intel.com,
        fabien.lahoudere@collabora.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
References: <cover.1588176662.git.vilhelm.gray@gmail.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <a6402ade-648d-6e49-85cd-a7fd7f58fd1d@lechnology.com>
Date:   Wed, 29 Apr 2020 15:21:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <cover.1588176662.git.vilhelm.gray@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 4/29/20 1:11 PM, William Breathitt Gray wrote:
> Over the past couple years we have noticed some shortcomings with the
> Counter sysfs interface. Although useful in the majority of situations,
> there are certain use-cases where interacting through sysfs attributes
> can become cumbersome and inefficient. A desire to support more advanced
> functionality such as timestamps, multi-axis positioning tables, and
> other such latency-sensitive applications, has motivated a reevaluation
> of the Counter subsystem. I believe a character device interface will be
> helpful for this more niche area of counter device use.

Nice to see some progress being made. :-)

> 
> Interaction with Counter character devices occurs via ioctl commands.
> This allows userspace applications to access and set counter data using
> native C datatypes rather than working through string translations.

For most aspects of the counter subsystem, this is not an issue since
configuring a counter is not a time-sensitive operation. Instead of
ioctls, I was expecting to just be able to read the character device
and receive counter events or poll to wait for events similar to how
the input subsystem works or how buffers work in the iio subsystem.

I'm afraid I don't really see much use in having ioctls that do
exactly what sysfs already does. And my intuition tells me that the
extra work needed to maintain it will probably cost more than any
benefit gained. (Maybe other have a different experience that leads
to a different conclusion?)
