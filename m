Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 3.mo5.mail-out.ovh.net ([46.105.40.108]:41367 "EHLO
	mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751321Ab1KCVLm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 3 Nov 2011 17:11:42 -0400
Received: from mail434.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with SMTP id 19FA3FF978F
	for <linux-iio@vger.kernel.org>; Thu,  3 Nov 2011 19:12:04 +0100 (CET)
Date: Thu, 3 Nov 2011 19:05:35 +0100
From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
	linux-iio@vger.kernel.org,
	Linus Walleij <linus.ml.walleij@gmail.com>,
	Patrice Vilchez <patrice.vilchez@atmel.com>,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 1/3] ARM: AT91: Add platform data for the ADCs
Message-ID: <20111103180535.GO7136@game.jcrosoft.org>
References: <1319041134-19712-1-git-send-email-maxime.ripard@free-electrons.com>
 <1320315070-1700-1-git-send-email-maxime.ripard@free-electrons.com>
 <1320315070-1700-2-git-send-email-maxime.ripard@free-electrons.com>
 <CAKnu2MqTVPxioKyr-F6JWcdF5SRZjzLSFPt5A-6CkZO7HyeHRw@mail.gmail.com>
 <4EB2C0F1.1030404@free-electrons.com>
 <CACRpkdZsNJwgC-7hp2zHNAcZVG-x8JN1CzV5KbYSiokD-9FUBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACRpkdZsNJwgC-7hp2zHNAcZVG-x8JN1CzV5KbYSiokD-9FUBw@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17:38 Thu 03 Nov     , Linus Walleij wrote:
> On Thu, Nov 3, 2011 at 5:27 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > [Me]
> >> We're not supposed to have platform data dependent to stuff in
> >> staging under arch/arm or anyplace else in the main kernel tree.
> >>
> >> Please move this to
> >> drivers/staging/iio/adc/at91adc-board.h
> >> or so.
> >
> > Won't moving this part to staging prevent from using this structure in
> > board files ? If so, how will I be able to declare a new board that is
> > using this ADC (or add the support for the ADC to a new one) ?
> 
> Put this into a separate board file living under staging/iio/adc
> 
> Compare:
> drivers/staging/ste_rmi4/board-mop500-u8500uib-rmi4.c
> 
> >> As for calling the at91_add_device_adc() function (which I guess
> >> you want to do at some point) the pattern I followed for other
> >> drivers is to declare a dummy function in arch/arm/mach-*
> >> with __weak and let the staging driver override that. This way
> >> the staging driver can go away without any compilation trouble
> >> happening.
> >
> > I don't really see why my changes will break the compilation if the
> > driver is no longer present in staging. At worst, the structure will be
> > filled but used by no one, right ?
> 
> You're right.
> 
> But still, we cannot add that header file for a driver that
> is in the staging tree. Header files go into the staging dir too.
agreed

Best Regards,
J.
