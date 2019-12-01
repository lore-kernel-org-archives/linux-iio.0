Return-Path: <SRS0=MckS=ZX=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EA6C432C3
	for <linux-iio@archiver.kernel.org>; Sun,  1 Dec 2019 10:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAC7C20833
	for <linux-iio@archiver.kernel.org>; Sun,  1 Dec 2019 10:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575196037;
	bh=NPq9GQ15mUdgu0mXuzYDSkPC3bj5yMBNurMY/N44tu4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=QP5+3Hs2u2YjpxCibkUiJ8I7s27U2001Xm0GM+if7c3QUCLq0P1q/tL3jzllPkbPl
	 SdyGB7gW5tQvJ0Zzy4f8xT/UYR4HuxZbO+xdVU/4lBqSmziqd/uEYE3kuiu43dzmJQ
	 KfBHjndzJq44+kN6jBM9cJqlnwhvuohD61oCfChM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfLAK1Q (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 1 Dec 2019 05:27:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:34114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbfLAK1Q (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Dec 2019 05:27:16 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2E5A2082E;
        Sun,  1 Dec 2019 10:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575196035;
        bh=NPq9GQ15mUdgu0mXuzYDSkPC3bj5yMBNurMY/N44tu4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NqBgtwhN4Z9zyYmEhcZpxfRMoxWLYy4IGCfAfhzAUxci6ETSRDkwnK2Uhj1VzekXr
         OqTDfQi5GfmlDAG0ze76vIbhjh5zYh9NLgqiT8tpEGSYkKN2DRW7gZ1WUM/2M2Muak
         KtWxUyeHJ6A1+UmW1nhOIgMOJ+2fqfTkJTy8vxbY=
Date:   Sun, 1 Dec 2019 10:27:11 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     <tomislav.denis@avl.com>
Cc:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] Add support for DLH pressure sensors
Message-ID: <20191201102711.641e3f6f@archlinux>
In-Reply-To: <20191129073420.9800-1-tomislav.denis@avl.com>
References: <20191114100908.11180-1-tomislav.denis@avl.com>
        <20191129073420.9800-1-tomislav.denis@avl.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 29 Nov 2019 08:34:17 +0100
<tomislav.denis@avl.com> wrote:

> From: Tomislav Denis <tomislav.denis@avl.com>
> 
> This patchset adds support for All Sensors DLH series low
> voltage digital pressure sensors.
> 
> Datasheet: https://www.allsensors.com/cad/DS-0355_Rev_B.PDF
One generic comment before I look at the code.

Mostly (there may be exceptions) it is better to post a new version
as a separate email thread.   This avoid deep and extremely confusing
threads when we run into many versions.  Also, a lot of maintainers
have limited time so start at their most recent emails on the basis
that earlier discussions have often already been resolved by other
reviewers / contributors.  If you send in a reply to an older thread
you reduce the chance of anyone looking at it ;)

Thanks,

Jonathan

> 
> Changes in v2:
> - web page link in the MAINTAINERS file fixed
> - adjust the units of the output to the IIO ABI
> - unneceseary default case removed
> - define the channel member of the iio_chan_spec
>   struct for channels specification
> - remove explicit cast for pointers of type void *
> - add support for the EOC(data ready) pin
> - drop the unneceseary return ret;
> - rename dlh-i2c.yaml to asc,dlh-i2c.yaml
> - change the bindings copyright to GPL-2.0-only OR BSD-2-Clause
> - document EOC(data ready) pin
> 
> Tomislav Denis (3):
>   iio: pressure: Add driver for DLH pressure sensors
>   dt-bindings: Add asc vendor
>   bindings: iio: pressure: Add dlh-i2c documentation
> 
>  .../bindings/iio/pressure/asc,dlh-i2c.yaml         |  51 +++
>  .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
>  MAINTAINERS                                        |   8 +
>  drivers/iio/pressure/Kconfig                       |  12 +
>  drivers/iio/pressure/Makefile                      |   1 +
>  drivers/iio/pressure/dlh-i2c.c                     | 429 +++++++++++++++++++++
>  6 files changed, 503 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/pressure/asc,dlh-i2c.yaml
>  create mode 100644 drivers/iio/pressure/dlh-i2c.c
> 

