Return-Path: <SRS0=9Bew=RM=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AECDC43381
	for <linux-iio@archiver.kernel.org>; Sat,  9 Mar 2019 18:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0566C20815
	for <linux-iio@archiver.kernel.org>; Sat,  9 Mar 2019 18:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552155896;
	bh=ptjD8mkNhqOFbBTyepNsMwh3Bqxakssmd0up4SjmIRE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=xpk4QpkkFhpK2Sxhk9K78SJCO6lJSSH4g6T04EaLOjmpDh8RI35AtwZmkvUnN0B3o
	 7q45wbI6k2G474+9izX4CE96jMDMxQSZ5U/HRB5C7Q1jdOQNqjfeU6yBNMWp4Pysht
	 L3yCq+ZheTQDSFSX3y2vMqBTiNGoi3VqWkFx2n18=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbfCISYz (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 9 Mar 2019 13:24:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:48086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbfCISYz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 9 Mar 2019 13:24:55 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5C92206DF;
        Sat,  9 Mar 2019 18:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552155894;
        bh=ptjD8mkNhqOFbBTyepNsMwh3Bqxakssmd0up4SjmIRE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dfIoNtJLFi6HxuypMAdaGGLxFQ2/AS6MwB9L0InR2XHt+2cLB+4xiP7A5R0aZXQuN
         LC+TS6VGLtHvpB08k7pg1jPLwSr39OR7ByiWXn4CxmNsNNfLSokGxiCnBlCKLRNcAf
         OKI/6WZ2LLaKAeUPFfGIm0geLAskDDKs1OOp+L9Y=
Date:   Sat, 9 Mar 2019 18:24:49 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: Re: [PATCH] iio: proximity: as3935: fix use-after-free on device
 remove
Message-ID: <20190309182449.45cd1b28@archlinux>
In-Reply-To: <CAGngYiUGcKrs86_ZARgfZxC_4hOAhW-e69GMpK6yAJMjHrYs6Q@mail.gmail.com>
References: <20190306174559.17362-1-TheSven73@gmail.com>
        <20190308171244.00001ec8@huawei.com>
        <CAGngYiUGcKrs86_ZARgfZxC_4hOAhW-e69GMpK6yAJMjHrYs6Q@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 8 Mar 2019 12:49:30 -0500
Sven Van Asbroeck <thesven73@gmail.com> wrote:

> On Fri, Mar 8, 2019 at 12:13 PM Jonathan Cameron
> <jonathan.cameron@huawei.com> wrote:
> >
> > Your description makes it clear that there are multiple things in the patch.
> > Don't do a 'while we were here' in a patch doing something else please.
> > Separate patches.
> >  
> 
> The proposed solution (adding devm_) fixes multiple issues, so that can stay
> as a single patch, right?
> 
> It's the 'while we're here' you'd like to see removed? Can do.

That's the one. Just the & removal.  The rest makes sense in
one patch as you say.

Jonathan
