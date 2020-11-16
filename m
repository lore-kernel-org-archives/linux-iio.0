Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7906C61DD8
	for <linux-iio@archiver.kernel.org>; Mon, 16 Nov 2020 20:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A783D20782
	for <linux-iio@archiver.kernel.org>; Mon, 16 Nov 2020 20:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFB+6AmG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733086AbgKPUfV (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 16 Nov 2020 15:35:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:56814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733083AbgKPUfV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 16 Nov 2020 15:35:21 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1264A208C3;
        Mon, 16 Nov 2020 20:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605558920;
        bh=jhUOvvAHDTaESBzHYQFhKVnmB4C5xBaHNH3HdupyLKA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iFB+6AmGkcDLfuuxTF5O5X1FZ3Hghye7yUyyxbxyMJQ36utPvwRqHcnWt/yzWY3wI
         j3DydNo4K1TmD2RF99sNYXhxc1jogU1OZcwKq2hcx+c1/fTR89uAhHkgiOvrGVGP9g
         0ez0KUV7T2emAymGyXuDf8BLEUD90CmIoeqZOaCA=
Date:   Mon, 16 Nov 2020 20:35:17 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 0/7] dt-bindings:iio: Move to trivial-devices.yaml from
 txt files.
Message-ID: <20201116203517.70e43273@archlinux>
In-Reply-To: <20201103023501.GA693302@bogus>
References: <20201031182922.743153-1-jic23@kernel.org>
        <20201103023501.GA693302@bogus>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 2 Nov 2020 20:35:01 -0600
Rob Herring <robh@kernel.org> wrote:

> On Sat, Oct 31, 2020 at 06:29:15PM +0000, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Rather than convert this group of bindings to yaml, let us just add
> > them to trivial-devices.yaml.
> > 
> > It is more than possible that we may need to give some of these their own
> > files at somepoint in the future (for example due to additional of
> > channel provider bindings for the potentiometers) but for now there seems
> > to be little advantage to keeping them separate.
> > 
> > Jonathan Cameron (7):
> >   dt-bindings:iio:chemical:sensirion,sgp30: Move to
> >     trivial-bindings.yaml
> >   dt-bindings:iio:chemical:bosch,bme180: Move to trivial devices
> >   dt-bindings:iio:potentiometer:maxim,ds1803 move to trivial devices.
> >   dt-bindings:iio:potentiometer:maxim,max5481 move to trivial devices
> >   dt-bindings:iio:light:renesas,isl29501: Move to trivial devices.
> >   dt-bindings:iio:magnetometer:memsic,mmc35240: move to
> >     trivial-devices.yaml
> >   dt-bindings:iio:accel:domintech,dmard06: Move to trivial-devices.yaml  
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Series applied.

thanks,

Jonathan

> 
> > 
> >  .../devicetree/bindings/iio/accel/dmard06.txt | 19 ------------
> >  .../bindings/iio/chemical/bme680.txt          | 11 -------
> >  .../bindings/iio/chemical/sensirion,sgp30.txt | 15 ----------
> >  .../bindings/iio/light/renesas,isl29501.txt   | 13 --------
> >  .../bindings/iio/magnetometer/mmc35240.txt    | 13 --------
> >  .../bindings/iio/potentiometer/ds1803.txt     | 21 -------------
> >  .../bindings/iio/potentiometer/max5481.txt    | 23 --------------
> >  .../devicetree/bindings/trivial-devices.yaml  | 30 +++++++++++++++++++
> >  8 files changed, 30 insertions(+), 115 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/iio/accel/dmard06.txt
> >  delete mode 100644 Documentation/devicetree/bindings/iio/chemical/bme680.txt
> >  delete mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,sgp30.txt
> >  delete mode 100644 Documentation/devicetree/bindings/iio/light/renesas,isl29501.txt
> >  delete mode 100644 Documentation/devicetree/bindings/iio/magnetometer/mmc35240.txt
> >  delete mode 100644 Documentation/devicetree/bindings/iio/potentiometer/ds1803.txt
> >  delete mode 100644 Documentation/devicetree/bindings/iio/potentiometer/max5481.txt
> > 
> > -- 
> > 2.28.0
> >   

