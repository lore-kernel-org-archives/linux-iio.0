Return-Path: <SRS0=A9f8=CH=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413AAC433E2
	for <linux-iio@archiver.kernel.org>; Sat, 29 Aug 2020 17:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A4FD20838
	for <linux-iio@archiver.kernel.org>; Sat, 29 Aug 2020 17:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598723988;
	bh=JqZ1JVWG2haY6cklZE91trDyQn6HRQiwNKCKAXA53Rw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=GabZCdwIu0G9C8v9pWlEar+TNhDDXIrQt4MiTwnmIn1qwIam89IUEgyVjUkfbv6Yc
	 kyLIEMoniAvlDOGgxa1QNaHVkUU3j7Keqxbta91X73mcPuE96tRJcnBPTwitI7ygwE
	 zniiVLDphovUK/Nq/QbsPgfDc1uboU9uIKN51XEw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbgH2R7r (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 29 Aug 2020 13:59:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:55370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728244AbgH2R7r (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 29 Aug 2020 13:59:47 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19B412071B;
        Sat, 29 Aug 2020 17:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598723987;
        bh=JqZ1JVWG2haY6cklZE91trDyQn6HRQiwNKCKAXA53Rw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ELt5mY8PRSa88TsIBfX0byJPUUjZ1d9jwi/KLaTsBacsBfxA96nGFSUwItOaQRA5d
         9byjXYlh1rn5aBsTxnHPiqThcqK2jKRTeTNQqz8xJLos4/G12aevsX99fpo3M8sHi3
         vMoYxI3G7lxh3c2n0sbV5LBCNgbs1pwbsMfGTRF0=
Date:   Sat, 29 Aug 2020 18:59:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        devicetree@vger.kernel.org, Phil Reid <preid@electromag.com.au>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 13/13] dt-bindings: iio: adc: ti,tlc4541 binding
 conversion
Message-ID: <20200829185943.6f69f310@archlinux>
In-Reply-To: <20200818023243.GA2176224@bogus>
References: <20200809111753.156236-1-jic23@kernel.org>
        <20200809111753.156236-14-jic23@kernel.org>
        <20200818023243.GA2176224@bogus>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 17 Aug 2020 20:32:43 -0600
Rob Herring <robh@kernel.org> wrote:

> On Sun, 09 Aug 2020 12:17:53 +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Simple binding so easy to convert.
> > Dropped the stated value of maximum spi bus frequency as it does
> > not seem to correspond to the datasheet.  The value of 200kHz
> > is the max sampling frequency of the ADC, not the clock frequency of
> > the SPI bus.
> > 
> > Added #io-channel-cells to allow use as a provider of channels to
> > other devices via the consumer binding.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Phil Reid <preid@electromag.com.au>
> > ---
> >  .../bindings/iio/adc/ti,tlc4541.yaml          | 52 +++++++++++++++++++
> >  .../bindings/iio/adc/ti-tlc4541.txt           | 17 ------
> >  2 files changed, 52 insertions(+), 17 deletions(-)
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied. Thanks.  I'll fix up the remaining patches that need it and send a v2.

Thanks,

Jonathan
