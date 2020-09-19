Return-Path: <SRS0=/qDq=C4=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57DCC43464
	for <linux-iio@archiver.kernel.org>; Sat, 19 Sep 2020 14:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9791A2085B
	for <linux-iio@archiver.kernel.org>; Sat, 19 Sep 2020 14:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600525254;
	bh=FSekFPTBL3wIT3/no7fBKyS7cOEpokdzSprdbTN2CDI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=yxxBEnM6g81XcfTQQs9AnAPcMDUpx1K8UOXPhSFYRcKmi6RugKr815RC771yx0G62
	 +FZTwUq9vx3/ltI12f85mXCmOJT61ubfoOErqCIc/mSJZleDSVwSwqJ9dy32FKc8Lt
	 MhQQxPm2ct/pgtnZWciRYhsAfQNYdCRbQowPs0YA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgISOUy (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 19 Sep 2020 10:20:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:54422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbgISOUy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 19 Sep 2020 10:20:54 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC60E206A4;
        Sat, 19 Sep 2020 14:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600525253;
        bh=FSekFPTBL3wIT3/no7fBKyS7cOEpokdzSprdbTN2CDI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nGWrEa0tgWxE8nZ4CQ+dQ7HcoQgOSFh32ptnePDxeLBTt0whs3+h0qUSjzI1Btjkt
         LTIZi4BlTRz+4RNlVwxl5RulHG4PTymWW2Z1qo1y5JXCLp6wffi41WDCTMwix2JXii
         ZEwWJlytEHuGM9xGv3++tol4pSCTHwcrYIZgeUJM=
Date:   Sat, 19 Sep 2020 15:20:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Joachim Eastwood <manabian@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 09/20] dt-bindings:iio:adc:nxp,lpc1850-adc yaml
 conversion
Message-ID: <20200919152049.056b9e76@archlinux>
In-Reply-To: <20200915190750.GA2324625@bogus>
References: <20200909175946.395313-1-jic23@kernel.org>
        <20200909175946.395313-10-jic23@kernel.org>
        <20200915190750.GA2324625@bogus>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 15 Sep 2020 13:07:50 -0600
Rob Herring <robh@kernel.org> wrote:

> On Wed, 09 Sep 2020 18:59:35 +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Most of the description in the original doc is effectively boilerplate
> > and does not bring much value so I have not carried it over into the yaml.
> > 
> > Added #io-channel-cells to simplify use of channels on this ADC by
> > consumer drivers.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Joachim Eastwood <manabian@gmail.com>
> > ---
> >  .../bindings/iio/adc/lpc1850-adc.txt          | 20 ------
> >  .../bindings/iio/adc/nxp,lpc1850-adc.yaml     | 61 +++++++++++++++++++
> >  2 files changed, 61 insertions(+), 20 deletions(-)
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied.  Thanks,

Jonathan


