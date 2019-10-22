Return-Path: <SRS0=rhut=YP=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0C5CA9EB9
	for <linux-iio@archiver.kernel.org>; Tue, 22 Oct 2019 09:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8962321906
	for <linux-iio@archiver.kernel.org>; Tue, 22 Oct 2019 09:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571736334;
	bh=NKCvOoJ8OhYXT1igOfcj6CufHt1iLlf4Nj7cs9pXeXw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=o3DSjts/MrWRDe3uLX10XxB0rosBmXTsbXDYp02NXM20MCnT0NaMjykQzyC9geOYP
	 p/uwM2V2/Ygh4KbSjj8Q8REmYOOoEckGSQSLNXkjo6+yJm2iTEe7yrLyPKfKB2EiD8
	 CH/mkx7E8eemzCNE4s14z1pFBs0IwtFSTyVCrcTw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731475AbfJVJZd (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 22 Oct 2019 05:25:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:57972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731338AbfJVJZd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 22 Oct 2019 05:25:33 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2367E2084B;
        Tue, 22 Oct 2019 09:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571736332;
        bh=NKCvOoJ8OhYXT1igOfcj6CufHt1iLlf4Nj7cs9pXeXw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XpVbgurAm5gFWW27j7elpz2oEicHdj/+g9r7+hE+rn5/OBnijDW4tgCk/Kbhb5Gb6
         k+HpqT4bmIVlLFUnkNuFYbkROfrBuEzyToa8z18cnrNxvZjaZnsxnd75nIrr6/Lssw
         O0QJVSViCnSgMy/kEMrj7Y0THd1n+eJ22G8LnAuM=
Date:   Tue, 22 Oct 2019 10:25:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Robert Jones <rjones@gateworks.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: imu: add fxos8700 imu binding
Message-ID: <20191022102528.54975bd9@archlinux>
In-Reply-To: <CAL_Jsq+yspnFz5PTW9WU1LRgKv5SpmsBuPs-4qCgjYfaLvoWwg@mail.gmail.com>
References: <20191010175648.10830-1-rjones@gateworks.com>
        <20191014184921.22524-1-rjones@gateworks.com>
        <20191014184921.22524-2-rjones@gateworks.com>
        <CAL_Jsq+yspnFz5PTW9WU1LRgKv5SpmsBuPs-4qCgjYfaLvoWwg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 16 Oct 2019 07:55:34 -0500
Rob Herring <robh+dt@kernel.org> wrote:

> On Mon, Oct 14, 2019 at 1:49 PM Robert Jones <rjones@gateworks.com> wrote:
> >
> > This adds documentation for the Freescale FXOS8700 Inertial Measurement Unit
> > device-tree bindings.
> >
> > Signed-off-by: Robert Jones <rjones@gateworks.com>
> > ---
> >  .../devicetree/bindings/iio/imu/nxp,fxos8700.yaml  | 76 ++++++++++++++++++++++
> >  1 file changed, 76 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml  
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied,

Thanks,

Jonathan
