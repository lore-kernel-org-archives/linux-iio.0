Return-Path: <SRS0=ElSe=5U=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBD0C2BA1A
	for <linux-iio@archiver.kernel.org>; Sat,  4 Apr 2020 14:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E55D206F8
	for <linux-iio@archiver.kernel.org>; Sat,  4 Apr 2020 14:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586008928;
	bh=FdTkhO0CcNJ2NJtSnAps910oS/H7t7DYtifPbRi25xE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=jeock4LPMQnEDeeeULqXR3sogvlJVRx491aIeJDygx0dnrwezgwXUNYSlYklFIDP4
	 vDEJEmIobb63cv0QN6Qj89NlRp1OaKJjnMwkaPsIDn62mBHFqpJvwHViCnlzyzoA9W
	 3EXe19Ayy42JDNdYT4PFJWGVjtySCPERrBhmi1NY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgDDOCH (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 4 Apr 2020 10:02:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:46888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbgDDOCH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 4 Apr 2020 10:02:07 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFD84206D4;
        Sat,  4 Apr 2020 14:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586008926;
        bh=FdTkhO0CcNJ2NJtSnAps910oS/H7t7DYtifPbRi25xE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Qhs9nOkLR8t9zt1YinO5M5JGRT04/Ui5sBYJHgmtTaHBCWyC6Vpo2fDYCmOrlF/YX
         6Gp1PmnosXmHOdamI7r9BhEfb1Tr8J+kXHJv/WTCPNrlg+CHAbQhGomkxvHN84GjSb
         +IyCR8eQDFmyuqtLJEwSkAbEOmQMgRg2WT0Qzwgw=
Date:   Sat, 4 Apr 2020 15:02:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Johan Jonker <jbx6244@gmail.com>, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, heiko@sntech.de, robh+dt@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] dt-bindings: iio: adc: rockchip-saradc: add
 description for rk3308
Message-ID: <20200404150201.3854d30b@archlinux>
In-Reply-To: <20200330181058.GA7814@bogus>
References: <20200313132926.10543-1-jbx6244@gmail.com>
        <20200313132926.10543-2-jbx6244@gmail.com>
        <20200330181058.GA7814@bogus>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 30 Mar 2020 12:10:58 -0600
Rob Herring <robh@kernel.org> wrote:

> On Fri, 13 Mar 2020 14:29:25 +0100, Johan Jonker wrote:
> > The description below is already in use for rk3308.dtsi,
> > but was somehow never added to a document, so add
> > "rockchip,rk3308-saradc", "rockchip,rk3399-saradc"
> > for saradc nodes on a rk3308 platform to rockchip-saradc.yaml.
> > 
> > Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >   
> 
> Acked-by: Rob Herring <robh@kernel.org>

Applied.
