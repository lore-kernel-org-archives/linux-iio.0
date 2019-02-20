Return-Path: <SRS0=QBqV=Q3=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983CAC43381
	for <linux-iio@archiver.kernel.org>; Wed, 20 Feb 2019 17:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69E8C2146E
	for <linux-iio@archiver.kernel.org>; Wed, 20 Feb 2019 17:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550682503;
	bh=0FMaqj7BW2yh2QMCot8c6IUjwq/IilLoFYJECHXx3F0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=P8MmPo+l42SXiuAdAH30ws3Eonboxen21dTWtgutq4z7N8scLoBenVF8+oXRKrUuL
	 YA3ZoUvKS35UAOKSjaZdE2XOiE1rK8Bia2eelWYDQMtRJT+cHIvr7sCr9JqF/P/1r7
	 NAunsSx94LPe6OBAnfK66LADefq0GQcnJnp4wgXg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfBTRIW (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 20 Feb 2019 12:08:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:48790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbfBTRIW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 20 Feb 2019 12:08:22 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7748721841;
        Wed, 20 Feb 2019 17:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550682502;
        bh=0FMaqj7BW2yh2QMCot8c6IUjwq/IilLoFYJECHXx3F0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J7g7Jkt56b6b3PTISiHcxlr3Y54UcMHWMa6WsI4QTEn0ZGiXpzPvXF8G0geaCVbWF
         dhYGq/f20Ye6hNkb0zC9opYtttGrQVh5B0zAMoDm7wzcVp2vdEn92EWrdWeZMIcVd/
         wPN4zJ8MXQwV5mrg8Jv3TNhObYYDY9VeGOdK3HFY=
Date:   Wed, 20 Feb 2019 17:08:17 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1] iio: Allow to read mount matrix from ACPI
Message-ID: <20190220170817.1a6430c4@archlinux>
In-Reply-To: <20190220161912.GA9224@smile.fi.intel.com>
References: <20190220152052.31901-1-andriy.shevchenko@linux.intel.com>
        <A4C8B4CF-FA03-4330-8B02-6B6DE43CE8BC@goldelico.com>
        <20190220161912.GA9224@smile.fi.intel.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 20 Feb 2019 18:19:12 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Wed, Feb 20, 2019 at 05:08:52PM +0100, H. Nikolaus Schaller wrote:
> > Hi Andy,
> >   
> > > Am 20.02.2019 um 16:20 schrieb Andy Shevchenko <andriy.shevchenko@linux.intel.com>:
> > > 
> > > Currently mount matrix is allowed in Device Tree, though there is
> > > no technical issue to extend it to support ACPI.
> > > 
> > > Convert the function to use device_property_read_string_array() and
> > > thus allow to read mount matrix from ACPI if available.
> > > 
> > > At the same time drop the "of" prefix from its name and
> > > convert current users.  
> > 
> > Maybe we can drop the "of" prefix after my earlier patches have been accepted?
> > 
> > So that you patch does not break compile of my patch series.  
> 
> 
> Whatever Jonathan considers the best for the users and developers!
> 
Either way is easy to fix up. We are only talking a rename of a single
function.  Keep them separate and I'm sort it out.

Jonathan


