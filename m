Return-Path: <SRS0=dRc7=6J=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18778C55194
	for <linux-iio@archiver.kernel.org>; Sat, 25 Apr 2020 17:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7B8C20704
	for <linux-iio@archiver.kernel.org>; Sat, 25 Apr 2020 17:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587836315;
	bh=wozh6fPngOaid+sufoR11TXXvYo49Yoy0laoXfwu+iQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Pz428Yl1fOdqLbD8f3QZ0sXOLEtzN+bi7lQ6rfMTYLVm9PvZshTKFfnn3jXQ5qeGr
	 p6oWunIsaHAMAajTF8/rdp6RSb1NdH3hsOwn14ezC34PDYdljExExfS3T+/dfLlY6s
	 M8+kLYKdWXS3fqdhMBfJ4GR64wES1AtUcp6+FDoA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgDYRie (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 25 Apr 2020 13:38:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:33702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbgDYRie (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Apr 2020 13:38:34 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F150720728;
        Sat, 25 Apr 2020 17:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587836313;
        bh=wozh6fPngOaid+sufoR11TXXvYo49Yoy0laoXfwu+iQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=neCfOoexTTvUUd7UtEOWURtYSzqhPRSlizBUrvV8193NP6RAufCPLsTg0eb+eVIaG
         cDtm/r8Vvlrf3uRFl9v+Omq4L9WOsC0rlNhZzJeewZ3h5A6atOC/ydCCZj0Cx2R8r0
         3aOmZspA+Y0/QNSx/2iOSTnvTap1J5pkIzPCFKRg=
Date:   Sat, 25 Apr 2020 18:38:29 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Nick Reitemeyer <nick.reitemeyer@web.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 2/3] dt-bindings: magnetometer: ak8974: Add Alps
 hscdtd008a
Message-ID: <20200425183829.4646e503@archlinux>
In-Reply-To: <20200415000945.GA24169@bogus>
References: <20200406141350.162036-1-nick.reitemeyer@web.de>
        <20200406141350.162036-2-nick.reitemeyer@web.de>
        <20200415000945.GA24169@bogus>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 14 Apr 2020 19:09:45 -0500
Rob Herring <robh@kernel.org> wrote:

> On Mon,  6 Apr 2020 16:13:51 +0200, Nick Reitemeyer wrote:
> > 
> > Add binding documentation for the Alps HSCDTD008A, which is similar
> > to the ak8974.
> > 
> > Signed-off-by: Nick Reitemeyer <nick.reitemeyer@web.de>
> > ---
> >  Documentation/devicetree/bindings/iio/magnetometer/ak8974.txt | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >   
> 
> Acked-by: Rob Herring <robh@kernel.org>

Applied to the togreg branch of iio.git.

thanks,

Jonathan
