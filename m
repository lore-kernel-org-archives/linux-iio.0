Return-Path: <SRS0=Zm7d=SJ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC498C10F0E
	for <linux-iio@archiver.kernel.org>; Sun,  7 Apr 2019 11:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF983218CD
	for <linux-iio@archiver.kernel.org>; Sun,  7 Apr 2019 11:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554636121;
	bh=PmbEgHOJHcKx9paKWYN0o4KT3kaEbP5hS86abRz2DoI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=EXbg5KRGUFrU9LkxEoN85gG4NQvsEi1hzmYFCmCWS8DSbmB6bqQZ2O/ik1BWDKEUj
	 V7RPDvntZYaRowKZPUZb6isZOLe5qZmfl8cYKB81is6LTEElUXb57SsDkNGL+qBKfc
	 4yAMmU8pzhvTIwO2iR7y5bpJsX7fb/v6+JsLrZT8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfDGLWB (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 7 Apr 2019 07:22:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:58396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbfDGLWB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Apr 2019 07:22:01 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C05820879;
        Sun,  7 Apr 2019 11:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554636120;
        bh=PmbEgHOJHcKx9paKWYN0o4KT3kaEbP5hS86abRz2DoI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KX+CHbrr1X+nGiSY0dHO9WrJfycf25qsw7bUvbmtRIuVsyg6tHpKn4CZgnMtix2sQ
         hwZy0wItTySyHcPyqT09btLphN651+p8L7fSo8KvrCYqVUXTwrYIy7ejn5s03dcQT2
         HYh+A0ZAzjJy7gYEqIXF1ZzcD/rpCgd7yIu8tEoQ=
Date:   Sun, 7 Apr 2019 12:21:54 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Andreas Klinger <ak@it-klinger.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] avia-hx711.yaml: transform DT binding to YAML
Message-ID: <20190407122154.043c2b18@archlinux>
In-Reply-To: <CAL_JsqKxdP=Xthpzg-stxKBLmA6RQffCVJh3ot-NDkMdTxPEVQ@mail.gmail.com>
References: <20190401173353.g4k5vb6flsfgtaaj@arbad>
        <CAL_JsqKxdP=Xthpzg-stxKBLmA6RQffCVJh3ot-NDkMdTxPEVQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 1 Apr 2019 20:47:19 -0500
Rob Herring <robh+dt@kernel.org> wrote:

> On Mon, Apr 1, 2019 at 12:34 PM Andreas Klinger <ak@it-klinger.de> wrote:
> >
> > replace avia-hx711.txt by avia-hx711.yaml as yaml devicetree
> > documentation for avia hx711 iio adc sensor
> >
> > Signed-off-by: Andreas Klinger <ak@it-klinger.de>
Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan

> > ---
> >  .../devicetree/bindings/iio/adc/avia-hx711.txt     | 24 --------
> >  .../devicetree/bindings/iio/adc/avia-hx711.yaml    | 66 ++++++++++++++++++++++
> >  2 files changed, 66 insertions(+), 24 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml  
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

