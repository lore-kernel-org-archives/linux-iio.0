Return-Path: <SRS0=SkP8=X6=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2778CC4740A
	for <linux-iio@archiver.kernel.org>; Sat,  5 Oct 2019 14:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E070A222C8
	for <linux-iio@archiver.kernel.org>; Sat,  5 Oct 2019 14:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570287498;
	bh=Vc+YQJEsAFsoGb4fPTsygyli898B0N7NiXZC2OZEjzM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=DXMu3iVrdzpByp30HGDb2no4zSpyXrEZzCFRBzpfafKpDJaKPTNAzOmmaMg7629fd
	 zXWYH07WKPzb2UOdOIst8+XzlNEbReMTAKtrNkfhmMvAzgAzthson5NAQHM31O/C6I
	 PW7cjSjGgeROzVr5CiGIg8lVDs7tjf1uXPveQzk8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbfJEO6R (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 5 Oct 2019 10:58:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:48248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbfJEO6R (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Oct 2019 10:58:17 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC5F620862;
        Sat,  5 Oct 2019 14:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570287496;
        bh=Vc+YQJEsAFsoGb4fPTsygyli898B0N7NiXZC2OZEjzM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zsvd19lGqWpNHr8KAqqUD/QnFuH7f9r/jBkQtBTZc2xKSoaCGUnNyke3I1VbhWOLb
         5entkZmLjlaNOeL4LBJub5nylrHXaVPhFB1BMvv273d/5hvQ8MLcEmj8H2RfxeKVbr
         Fl6QPDUlZ90fV5o7ZNAqWYiipWb0R/iEPutzE5nc=
Date:   Sat, 5 Oct 2019 15:58:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Phil Reid <preid@electromag.com.au>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mark.rutland@arm.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        michal.simek@xilinx.com
Subject: Re: [PATCH v2 1/2] dt-binding: iio: Add optional label property
Message-ID: <20191005155811.29374f19@archlinux>
In-Reply-To: <20190927144419.GA26041@bogus>
References: <1568903768-65998-1-git-send-email-preid@electromag.com.au>
        <1568903768-65998-2-git-send-email-preid@electromag.com.au>
        <20190927144419.GA26041@bogus>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 27 Sep 2019 09:44:19 -0500
Rob Herring <robh@kernel.org> wrote:

> On Thu, Sep 19, 2019 at 10:36:07PM +0800, Phil Reid wrote:
> > This optional property defines a symbolic name for the device.
> > This helps to distinguish between more than one iio device
> > of the same type.
> > 
> > Suggested-by: Michal Simek <michal.simek@xilinx.com>
> > Signed-off-by: Phil Reid <preid@electromag.com.au>
> > ---
> >  Documentation/devicetree/bindings/iio/iio-bindings.txt | 5 +++++
> >  1 file changed, 5 insertions(+)  
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to the togreg branch of iio.git and pushed out as testing
for nothing much to happen to it.

Thanks,

Jonathan
