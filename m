Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mo3.mail-out.ovh.net ([178.32.228.3]:59666 "EHLO
	mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790Ab2LVRXO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 22 Dec 2012 12:23:14 -0500
Received: from mail417.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with SMTP id 6DCEAFF9122
	for <linux-iio@vger.kernel.org>; Sat, 22 Dec 2012 18:35:37 +0100 (CET)
Date: Sat, 22 Dec 2012 18:21:33 +0100
From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: "ludovic.desroches" <ludovic.desroches@atmel.com>,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 1/3] ARM: AT91: IIO: add low and high res support for
 adc
Message-ID: <20121222172133.GT23971@game.jcrosoft.org>
References: <20121219183236.GP23971@game.jcrosoft.org>
 <1355942232-26251-1-git-send-email-plagnioj@jcrosoft.com>
 <50D2EBA1.4050305@free-electrons.com>
 <50D2EDE6.3090706@atmel.com>
 <50D3340F.3090209@free-electrons.com>
 <50D33940.4000607@atmel.com>
 <50D426C1.5050807@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <50D426C1.5050807@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10:07 Fri 21 Dec     , Maxime Ripard wrote:
> Le 20/12/2012 17:13, ludovic.desroches a écrit :
> > On 12/20/2012 04:51 PM, Maxime Ripard wrote:
> >> Hi Ludovic,
> >>
> >> Le 20/12/2012 11:52, ludovic.desroches a écrit :
> >>>> I'm wondering, why are you using such a complex dt parsing code, and
> >>>> bindings, when you only requires a boolean to switch between 8 and 10
> >>>> bits mode (which seem to be the only thing you support)?
> >>>
> >>> We will have a 10 and 12 bits mode on future ADCs and I would like to
> >>> have something which could manage more than two resolutions if it
> >>> happens one day.
> >>
> >> I see your point. I'm not fond at all of the existing bindings for the
> >> driver (putting things like registers offset in the dt is a non-sense to
> >> me, but hey...), so I'd like to still keep it as simple and non-bloated
> >> as possible, but it's true that in the current situation, we probably
> >> have no other choice.
> >>
> > 
> > I have the same feeling than you about ADC bindings, I think that there
> > are too many parameters exhibited. Moreover, most of them are chip
> > relative.
> > 
> > I have not found other ways to deal with it properly. I would like to
> > have them hidden into the driver (depending on the compatible string)
> > but it will be a mess if we split parameters into dt and driver.
> 
> I'm glad we feel the same way :)
I'm not I fee; exactly this opposte way

I do want to toucht the kernel code to add new soc

so no I like this binding

Best Regards,
J.
