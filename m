Return-Path: <SRS0=diYI=OZ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F9AC43387
	for <linux-iio@archiver.kernel.org>; Sun, 16 Dec 2018 12:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E774021839
	for <linux-iio@archiver.kernel.org>; Sun, 16 Dec 2018 12:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544963727;
	bh=02aw1iKJSqvUidm3X8ZEfa5LfO+wvhFx7Cdk+AZsFwg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=wgASWjrnLjlQNCl1fjwEx/lbGXvD5OXvRx3NcN54Y+arg1gBKPQ0g5DnkZG5WXpJc
	 wFAF7IETl0MLUito4Qr+l33TsGcREnnkqpGy7THJFeyzGoIBp59dlHLHRQBY/+kS+z
	 xzLWxf72TQ27TUbq90tCNdry3QOg7SbHsW4uNUsA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbeLPMf0 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 16 Dec 2018 07:35:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:42678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730269AbeLPMf0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 Dec 2018 07:35:26 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38788217F9;
        Sun, 16 Dec 2018 12:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544963725;
        bh=02aw1iKJSqvUidm3X8ZEfa5LfO+wvhFx7Cdk+AZsFwg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t6TDj+NSlBvKrxk+9jvnst8PYQzDy97FIHNje6G5ZZbF6nl/c1HGsY7kcSBx3WGtm
         pDtg1tRnkrrzaYS6H2fOycl19QHM2/7Ly/SjP24Rc4tgKQqTG9UikOn9FlQavLxj+m
         L+a1fPxoHG8NwnubIVG5E5wY4tTOnDqvlbD2Sx24=
Date:   Sun, 16 Dec 2018 12:35:21 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Slawomir Stepien <sst@poczta.fm>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH 2/2] staging: iio: adc: ad7280a: split
 ad7280_attr_init() to more functions
Message-ID: <20181216123521.187e2ace@archlinux>
In-Reply-To: <20181212172005.GC1738@t480s.localdomain>
References: <20181212170228.28498-1-sst@poczta.fm>
        <20181212170228.28498-3-sst@poczta.fm>
        <20181212172005.GC1738@t480s.localdomain>
X-Mailer: Claws Mail 3.17.2 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 12 Dec 2018 18:20:05 +0100
Slawomir Stepien <sst@poczta.fm> wrote:

> On gru 12, 2018 18:02, Slawomir Stepien wrote:
> > The ad7280_attr_init function has been split into more specific
> > functions to increase the code readability.
> > 
> > Signed-off-by: Slawomir Stepien <sst@poczta.fm>
> > ---
> > Since v1:
> > * Added ad7280_init_dev_attrs function.
> > * The new functions now operates on struct iio_dev_attr rather than on struct
> >   ad7280_state.
> > ---  
> 
> Sorry about not marking this as v2 in the subject line :( I'll fix that on next
> version (if that happens ;)).
> 

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan
