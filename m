Return-Path: <SRS0=e+7m=X7=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A42C4360C
	for <linux-iio@archiver.kernel.org>; Sun,  6 Oct 2019 09:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE89E2166E
	for <linux-iio@archiver.kernel.org>; Sun,  6 Oct 2019 09:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570355985;
	bh=t7shMzREGu9JJ635+JfS+tH6TkYFylBWcrmHXL5YXz4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=GP50AoiE9Bf5U0UFINF7WplNROOwyZJ0cS35XrKet1715KEPMQ9QHteBDIix6mBWL
	 bVn9U1dEU5zwBXfHqouejmLnVpEAzDl2KnNy6J9HrZp49C0524IE38RoIdF976u2im
	 1SoElOcGWIEbfYvQpm9hPdgh+GjLidb7RfNhCYlI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfJFJ7p (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 6 Oct 2019 05:59:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:57166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbfJFJ7p (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Oct 2019 05:59:45 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F01F220867;
        Sun,  6 Oct 2019 09:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570355984;
        bh=t7shMzREGu9JJ635+JfS+tH6TkYFylBWcrmHXL5YXz4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nl2Dq6cRdzvOZnmDXuCNx/GP7mBXo+xXx4FqVV0u3K14+VMlqcYQ1j5S1MMh3hUbT
         ZeyVX+B/7VmhwIdPze0IDRWvitVIjEyiQ8+N+W44EENDyuoJUZsmR08Zzg6fVJjTHD
         auz7HQEdqy3+79wy5IVNrmWcw2m6AZLLpDQ16POY=
Date:   Sun, 6 Oct 2019 10:59:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: ad7192: Fix Regulator Properties
Message-ID: <20191006105939.5e3fb2b1@archlinux>
In-Reply-To: <20191002191416.GA17605@bogus>
References: <20191002144542.114722-1-mripard@kernel.org>
        <20191002191416.GA17605@bogus>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 2 Oct 2019 14:14:16 -0500
Rob Herring <robh@kernel.org> wrote:

> On Wed,  2 Oct 2019 16:45:41 +0200, Maxime Ripard wrote:
> > The AD7192 binding describes two regulator properties, avdd-supply and
> > dvdd-supply, but describes it as a constant string that must be avdd and
> > dvdd. This is wrong since a *-supply property is actually a phandle, and
> > results in warnings when the example is validated (or any device tree using
> > that device, for that matter).
> > 
> > Let's remove that requirement.
> > 
> > Fixes: f7356e47032c ("dt-bindings: iio: adc: ad7192: Add binding documentation for AD7192")
> > Signed-off-by: Maxime Ripard <mripard@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml | 4 ----
> >  1 file changed, 4 deletions(-)
> >   
> 
> Applied, thanks.
> 
> Rob

Thanks for clearing this up.

Jonathan
