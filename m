Return-Path: <SRS0=N/LO=WX=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586F2C3A5A3
	for <linux-iio@archiver.kernel.org>; Tue, 27 Aug 2019 19:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BCCA2184D
	for <linux-iio@archiver.kernel.org>; Tue, 27 Aug 2019 19:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566935972;
	bh=ojJTAihZUqMEokPKLE9L8uVVoc+pBtHgjdGSEFAvIsk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=m/w94j6Sl26iFNBdfI0Z2Y02yPXX/Pc+jGGOarkYgYSztVRfhbnHOqfYYQ9DH66No
	 oC/xk7qEZcp2VYk15hMsFf1ShRmNGhM3dtwHBI+210oZ7FQ1U5EITP+JZGV0hXf6j2
	 Y4mmLVOETSGz+IxD3DilSU8XFlzVgj5OMnX+ZtMw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731077AbfH0T7b (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 27 Aug 2019 15:59:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:39676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730668AbfH0T7b (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 27 Aug 2019 15:59:31 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4731820674;
        Tue, 27 Aug 2019 19:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566935970;
        bh=ojJTAihZUqMEokPKLE9L8uVVoc+pBtHgjdGSEFAvIsk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C7xIPolsj58PGtDH6xrvPEO8rj8ZGeHz2D/fVKx1Sd2oMn/kbkLfVpe7DzCFMiFH+
         6B3pqeptERTcxSzDSKtjh9TVklpUB5pB1dFzHq2oInQP8a9LMQhdEuxGVd+h0bpc0c
         jvNXvQzR7cO6WRrqlsCAIIKLNKyHv5pVIDQ1g/ig=
Date:   Tue, 27 Aug 2019 20:59:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     lorenzo.bianconi83@gmail.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH v5 2/4] iio: imu: st_lsm6sdx: move register definitions
 to sensor_settings struct
Message-ID: <20190827205924.313344e4@archlinux>
In-Reply-To: <d3cb1cf5-f17f-38ef-66a2-23c1b7a7d08f@puri.sm>
References: <20190821132520.28225-1-martin.kepplinger@puri.sm>
        <20190821132520.28225-3-martin.kepplinger@puri.sm>
        <d3cb1cf5-f17f-38ef-66a2-23c1b7a7d08f@puri.sm>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 27 Aug 2019 08:54:57 +0200
Martin Kepplinger <martin.kepplinger@puri.sm> wrote:

> On 21.08.19 15:25, Martin Kepplinger wrote:
> > Move some register definitions to the per-device array of struct
> > st_lsm6dsx_sensor_settings in order to simplify adding new sensor
> > devices to the driver.
> > 
> > Also, remove completely unused register definitions.
> > 
> > Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> > Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  6 ++++
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 31 ++++++++++++++------
> >  2 files changed, 28 insertions(+), 9 deletions(-)
> >   
> 
> I just notices the commit message header typo "st_lsm6sdx" should be
> "st_lsm6dsx" of course. If you can still rebase/force-push to testing,
> would you be able to fix that? If it's too far out there already, so be
> it :) sorry for the typo, and thanks for adding "-imu" yourself where
> applicable.

I can indeed. Fixed up.

Added Rob's ack to the dt patch as well.

Thanks,

Jonathan

> 
> thanks,
> 
>                       martin

