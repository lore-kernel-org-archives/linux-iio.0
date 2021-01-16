Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C85C433E6
	for <linux-iio@archiver.kernel.org>; Sat, 16 Jan 2021 17:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D38D122AAB
	for <linux-iio@archiver.kernel.org>; Sat, 16 Jan 2021 17:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbhAPR3A (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 16 Jan 2021 12:29:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:34520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbhAPR3A (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 Jan 2021 12:29:00 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1703922AAB;
        Sat, 16 Jan 2021 17:28:19 +0000 (UTC)
Date:   Sat, 16 Jan 2021 17:28:18 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Cristian Pop <cristian.pop@analog.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v6 1/3] dt-bindings: iio: dac: AD5766 yaml documentation
Message-ID: <20210116172818.4091a0ee@archlinux>
In-Reply-To: <20210115164605.GA1425845@robh.at.kernel.org>
References: <20210115112105.58652-1-cristian.pop@analog.com>
        <20210115164605.GA1425845@robh.at.kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 15 Jan 2021 10:46:05 -0600
Rob Herring <robh@kernel.org> wrote:

> On Fri, 15 Jan 2021 13:21:03 +0200, Cristian Pop wrote:
> > This adds device tree bindings for the AD5766 DAC.
> > 
> > Signed-off-by: Cristian Pop <cristian.pop@analog.com>
> > ---
> > Changelog v6:
> > 	- Use microvolt unit
> > 	- Remove unrelevant to the binding comment
> >  .../bindings/iio/dac/adi,ad5766.yaml          | 63 +++++++++++++++++++
> >  1 file changed, 63 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Fixed up a line with just white space on it in the example and applied to the
togreg branch of iio.git, pushed out as testing for the autobuilders to poke
at it and see if we missed anything.
