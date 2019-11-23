Return-Path: <SRS0=9Qmd=ZP=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B100C432C0
	for <linux-iio@archiver.kernel.org>; Sat, 23 Nov 2019 14:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 115BD2071C
	for <linux-iio@archiver.kernel.org>; Sat, 23 Nov 2019 14:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574519749;
	bh=JaCZdP9Ao33i1qHvD6MoL6+hoFDplKbKB+r9+g0IrTo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=qqx1iEll/MmWm26T8Cy+uRLDks8f4ZfREvA0ZdX8oEuOxGgb6nb8KrRMdHPglsPFu
	 pNaV0GdDRKiKT6/I2DiyUKOOhj4dDqJpVAI45fbRzdpovVMoQrTyACikmJqyjmxk1h
	 GqVAPzsJlmuLYo5G4G+dbeT+PFT1HyRGRUiYO/0I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfKWOfs (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 23 Nov 2019 09:35:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:44766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbfKWOfs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 23 Nov 2019 09:35:48 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E7AD20714;
        Sat, 23 Nov 2019 14:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574519747;
        bh=JaCZdP9Ao33i1qHvD6MoL6+hoFDplKbKB+r9+g0IrTo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LpoYvbx+0oKHEHnHBdR4SCuCmxwrwIjXoYGXYjlZwogZxrpCeZj1Qvazn5krVOlZ1
         wswmSBg+HvlYpNsW5VLI8WmgaC0Q5ofem09dSscQTsn+b+6pRPoo5GLnxtAD7k1LF1
         WTahDidkg3nXlnB0kj88h62JRPrXY0SdqZuTQ9Go=
Date:   Sat, 23 Nov 2019 14:35:40 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, mripard@kernel.org,
        shawnguo@kernel.org, heiko@sntech.de, icenowy@aosc.io,
        laurent.pinchart@ideasonboard.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        christophe.jaillet@wanadoo.fr, tglx@linutronix.de,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        paulmck@linux.ibm.com, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] iio: ping: add parallax ping sensors
Message-ID: <20191123143540.79d9df7f@archlinux>
In-Reply-To: <20191118073629.54cjpk26zzf632bf@arbad>
References: <20191118073629.54cjpk26zzf632bf@arbad>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 18 Nov 2019 08:36:30 +0100
Andreas Klinger <ak@it-klinger.de> wrote:

> Add support for parallax ping and laser ping sensors with just one pin
> for trigger and echo signal.
> 
> This driver is based on srf04. In contrast to it it's necessary to
> change direction of the pin and to request the irq just for the period
> when the echo is rising and falling. Because this adds a lot of cases
> there is this individual driver for handling this type of sensors.
> 
> Add a new configuration variable CONFIG_PING to Kconfig and Makefile.
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
Applied,

Thanks,

Jonathan
