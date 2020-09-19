Return-Path: <SRS0=/qDq=C4=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A077C43463
	for <linux-iio@archiver.kernel.org>; Sat, 19 Sep 2020 14:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D47E921481
	for <linux-iio@archiver.kernel.org>; Sat, 19 Sep 2020 14:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600525359;
	bh=COHXhNHo8MIv809b8MxbgN95Y1iodNWyzoxuJJX9eXc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=g6gzSPAWS3jmadduunCYWgiJuJRCYGL0j7m7CpgC7Fw4beCSiAZ5GXz78m+aNtt87
	 x4fS+L4fWWt4hZNTM2Z01okdxe1IT/HoRkJRDg6BZ76Fs9VJV52FPDhIbTE4rdchq3
	 TdGibL1c3ykfXki7PnrysUICAxMj4ixxFeahajpI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgISOWj (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 19 Sep 2020 10:22:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:55714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbgISOWj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 19 Sep 2020 10:22:39 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED9E520866;
        Sat, 19 Sep 2020 14:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600525359;
        bh=COHXhNHo8MIv809b8MxbgN95Y1iodNWyzoxuJJX9eXc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DIDfvbhb/JaK4H3Pyjqc04zZf7GVeW1zamZoyL/fK8COxcLpV/StsCas/BeFsPTgN
         SskGT57Os2WpLDqY7fHaE/PCoYDnSOp7plgrZ9oqQsueEqqIysulhSRtQ0XWE86oHM
         6EvjUM02BpZRRaGaKYXQO2/Y2U3SIC47lLV2wL4g=
Date:   Sat, 19 Sep 2020 15:22:34 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Gregory Clement <gregory.clement@bootlin.com>,
        devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 10/20] dt-bindings:iio:adc:lpc3220-adc yaml
 conversion
Message-ID: <20200919152234.4b185e42@archlinux>
In-Reply-To: <20200915190933.GA2327420@bogus>
References: <20200909175946.395313-1-jic23@kernel.org>
        <20200909175946.395313-11-jic23@kernel.org>
        <20200915190933.GA2327420@bogus>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 15 Sep 2020 13:09:33 -0600
Rob Herring <robh@kernel.org> wrote:

> On Wed, 09 Sep 2020 18:59:36 +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Renamed to remove the wild cards.  These go wrong far too often so
> > in general preferred to use the name of a specific part.  As this
> > binding only provides one compatible, I went with that.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Gregory Clement <gregory.clement@bootlin.com>
> > ---
> >  .../bindings/iio/adc/lpc32xx-adc.txt          | 21 --------
> >  .../bindings/iio/adc/nxp,lpc3220-adc.yaml     | 50 +++++++++++++++++++
> >  2 files changed, 50 insertions(+), 21 deletions(-)
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied,

thanks,

Jonathan

