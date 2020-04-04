Return-Path: <SRS0=ElSe=5U=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE2FC2BA1A
	for <linux-iio@archiver.kernel.org>; Sat,  4 Apr 2020 14:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23B3B206D4
	for <linux-iio@archiver.kernel.org>; Sat,  4 Apr 2020 14:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586008949;
	bh=EKRxVNbgw1zORqCuHwnitV+fHMklM3Un+Dg5wgAezPs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=xB+VS7/S20TUTz0EPVpPM+h/DoBzIbxPUkJLmBmQMs7JxiemCoYbRspedVHfdxg/2
	 bs98/WzM7e1zcg1ldd6DJGnQf/o5PxyGtD8izLy6S7e61eBv8C5yvApY1mo259oZtD
	 88mrEll2RDckjSTqz1nuQjVdJKdL4ZJx8MGE9gG0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgDDOCZ (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 4 Apr 2020 10:02:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:47168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbgDDOCY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 4 Apr 2020 10:02:24 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F69D206F5;
        Sat,  4 Apr 2020 14:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586008944;
        bh=EKRxVNbgw1zORqCuHwnitV+fHMklM3Un+Dg5wgAezPs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e8khb7TjTILjFGn8wV0aZ+RVF9ptaRdcXTk2oeELPMjuPBY3BqgbJE9/f4+DGOvoo
         ht95KZchQttOLrn8twzy3TFZ0SjgL0hFt2M1iB93oKFw3JzcTE0AFo6bLRvwgHIrlG
         y6bAqC89cFguPBAQR/Entwqi5L3vtpBUiG7+CB4g=
Date:   Sat, 4 Apr 2020 15:02:19 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Johan Jonker <jbx6244@gmail.com>, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, heiko@sntech.de, robh+dt@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] dt-bindings: iio: adc: rockchip-saradc: add
 description for px30
Message-ID: <20200404150219.0e66be93@archlinux>
In-Reply-To: <20200330181106.GA8102@bogus>
References: <20200313132926.10543-1-jbx6244@gmail.com>
        <20200313132926.10543-3-jbx6244@gmail.com>
        <20200330181106.GA8102@bogus>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 30 Mar 2020 12:11:06 -0600
Rob Herring <robh@kernel.org> wrote:

> On Fri, 13 Mar 2020 14:29:26 +0100, Johan Jonker wrote:
> > The description below is already in use for px30.dtsi,
> > but was somehow never added to a document, so add
> > "rockchip,px30-saradc", "rockchip,rk3399-saradc"
> > for saradc nodes on a px30 platform to rockchip-saradc.yaml.
> > 
> > Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >   
> 
> Acked-by: Rob Herring <robh@kernel.org>

Applied.

Thanks,

Jonathan

