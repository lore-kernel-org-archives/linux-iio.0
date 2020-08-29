Return-Path: <SRS0=A9f8=CH=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C51C433E6
	for <linux-iio@archiver.kernel.org>; Sat, 29 Aug 2020 17:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B82D320776
	for <linux-iio@archiver.kernel.org>; Sat, 29 Aug 2020 17:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598723464;
	bh=k6M2Cme6lxj969lnCVTCNtdRrFXEsrsFEP+Sr7Jbz9A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=GhdjhX3WdqIoizu8AaFKKze9jtzJ3fspNbqIU+KN5zE8R7+NJxwdkl7W5ZDc52Yfl
	 RaL8Yn52Am4jd2q1q5V+kDjhTwxdyVTpn+HcYoq2v1xj/z76eAIBp5gErrFgCDu4tV
	 Rxg5sg7zMkn6QHU7nvd8j2PSQphl9dU6KkVB6xRY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgH2RvE (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 29 Aug 2020 13:51:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:50380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728203AbgH2RvD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 29 Aug 2020 13:51:03 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 405DE204FD;
        Sat, 29 Aug 2020 17:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598723463;
        bh=k6M2Cme6lxj969lnCVTCNtdRrFXEsrsFEP+Sr7Jbz9A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o3SfjaPWbLsQUOaB/2UaO9A0gBhiefy4RwfFDUS4Ck5ylQPGKjS9N+urS56REyQ3R
         V8LbSihG3kQSNi3aeQ/oqAhH3Xr78LvR2lecgPC3gNVCWs4VFOoYHTK8A4IN58Uk1q
         1VLMvgXc2EK97XtNoa/4RNXCyfM+yhsW/VsPl46M=
Date:   Sat, 29 Aug 2020 18:50:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH 04/13] dt-bindings: iio: adc: lltc,ltc2497 yaml
 conversion.
Message-ID: <20200829185059.19dbd41b@archlinux>
In-Reply-To: <20200818022830.GA2168744@bogus>
References: <20200809111753.156236-1-jic23@kernel.org>
        <20200809111753.156236-5-jic23@kernel.org>
        <20200818022830.GA2168744@bogus>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 17 Aug 2020 20:28:30 -0600
Rob Herring <robh@kernel.org> wrote:

> On Sun, 09 Aug 2020 12:17:44 +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Very simple binding for this i2c device with a reference supply.
> > 
> > Added the #io-channel-cells property to allow for consumers.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Michael Hennerich <michael.hennerich@analog.com>
> > ---
> >  .../bindings/iio/adc/lltc,ltc2497.yaml        | 44 +++++++++++++++++++
> >  .../devicetree/bindings/iio/adc/ltc2497.txt   | 13 ------
> >  2 files changed, 44 insertions(+), 13 deletions(-)
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied
