Return-Path: <SRS0=sXLK=DR=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE30DC35257
	for <linux-iio@archiver.kernel.org>; Sat, 10 Oct 2020 23:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D42E2075E
	for <linux-iio@archiver.kernel.org>; Sat, 10 Oct 2020 23:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602371335;
	bh=tH/e3Syo1QlXY7NwxvGCWBJ4iF2Rv4uqN3ltx+4Topg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=AIoLA+cm0WJpD8cIv+9hLOGP7Pi2YW4DkwSWmOKbMUZyrCytb0WmJrl8+RHD89ntR
	 gniFIPHvJOAN+UkIEKSWtSUIwRNAowMotcdra8EaCyXY+nq4b4YkeyTHiiQhcyunUK
	 mXs37YKIgRCSRHou1hsK3ro4fqmm33R4EnuvQ6KM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731123AbgJJW5C (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 10 Oct 2020 18:57:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:50680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731363AbgJJTMW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 10 Oct 2020 15:12:22 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B0ED22384;
        Sat, 10 Oct 2020 15:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602344690;
        bh=tH/e3Syo1QlXY7NwxvGCWBJ4iF2Rv4uqN3ltx+4Topg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b/IjqYC3sUKU8cBRPJBBIkmpy4FpzB6TKGXAB5Ks7qoAkIUwcmEbwSJxrB/VMNx+I
         tIyIYLVSVGMUro6qzIYHqUkfunDAYdWunRP+CIcNOk2qUXVoaURDGNHe1haWBN9A+Q
         AgJPPwwSQsEncr2vUgJ0xYtaJjEZoYP1RLxj43mQ=
Date:   Sat, 10 Oct 2020 16:44:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Michael Auchter <michael.auchter@ni.com>,
        linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/3] dt-bindings: iio: dac: ad5686: add binding
Message-ID: <20201010164445.0d324bb9@archlinux>
In-Reply-To: <20200929185300.GA955613@bogus>
References: <20200924195215.49443-1-michael.auchter@ni.com>
        <20200924195215.49443-3-michael.auchter@ni.com>
        <20200929185300.GA955613@bogus>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 29 Sep 2020 13:53:00 -0500
Rob Herring <robh@kernel.org> wrote:

> On Thu, 24 Sep 2020 14:52:14 -0500, Michael Auchter wrote:
> > Add a binding for AD5686
> > 
> > Signed-off-by: Michael Auchter <michael.auchter@ni.com>
> > ---
> > Changes since v1:
> > - Keep supported device sorted
> > - fix adc -> dac typo in schema path
> > since v2:
> > - drop address-cells and size-cells from binding doc
> > - add "additionalProperties: false"
> > - end with ...
> > 
> >  .../bindings/iio/dac/adi,ad5686.yaml          | 57 +++++++++++++++++++
> >  1 file changed, 57 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Series applied with a slight tweak to patch 1 to constify the channel
macro inline with recent tidy up patch doing the same to other instances
in the driver.

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to poke at it and see if we missed anything.

Thanks,

Jonathan

