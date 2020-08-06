Return-Path: <SRS0=+PUP=BQ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DADC433DF
	for <linux-iio@archiver.kernel.org>; Thu,  6 Aug 2020 18:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E6E822C9F
	for <linux-iio@archiver.kernel.org>; Thu,  6 Aug 2020 18:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596739223;
	bh=8zguKyCfWypWM8hyJ77LIcdUtKkyyoE4Ky0FYhVvmeQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=JuaDLw/QYcrKe8KNANPGtevHskTC4OWlmwgSD2/g0/MJw+uH2Ic0FaHE5gCq/SJxQ
	 864sbdpwaiQaxikj4yBadQ1MbCoCxvgCsGCzwKC25FksDVQG3BpeiQXQSK9ieol3v2
	 dR+5isUrcZ5PhK4Q5ubzTnsU4Lsg4D3g39u8Bynk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729943AbgHFSkA (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:40:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:54064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727976AbgHFS3z (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 Aug 2020 14:29:55 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D0DE20716;
        Thu,  6 Aug 2020 18:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596737696;
        bh=8zguKyCfWypWM8hyJ77LIcdUtKkyyoE4Ky0FYhVvmeQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uWTLvWaH5zKSmC7BVEoGDkeBuhLJku628QYEY3Ord32GNJ9AmzpLIlWbFw5RjoQqI
         rbEK3EPMb4wpnw+6DYBPqJkEiyQgDbeKlA0WbcbyxaQyRigFd6eVt/6guY2tGNBBxU
         VESDB94fynRaFsWvIDqU0RJXNg1TTQweMJL0dpX8=
Date:   Thu, 6 Aug 2020 19:14:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Daniel Campello <campello@chromium.org>,
        LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Douglas Anderson <dianders@chromium.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3 01/15] dt-bindings: iio: Add bindings for sx9310
 sensor
Message-ID: <20200806191451.3ce5ec57@archlinux>
In-Reply-To: <CAL_JsqLs99Q7o32mqZROQSLuaf-_6vVg_wSVbpMr0u3eD9LVEw@mail.gmail.com>
References: <20200731164853.3020946-1-campello@chromium.org>
        <20200731104555.v3.1.I0925046377211b8b6f06764857f03b4ab592bddb@changeid>
        <20200801160639.1410944e@archlinux>
        <159648122347.1360974.1094560524092762187@swboyd.mtv.corp.google.com>
        <CAL_JsqLs99Q7o32mqZROQSLuaf-_6vVg_wSVbpMr0u3eD9LVEw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 3 Aug 2020 20:01:06 -0600
Rob Herring <robh+dt@kernel.org> wrote:

> On Mon, Aug 3, 2020 at 1:00 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Jonathan Cameron (2020-08-01 08:06:39)  
> > > On Fri, 31 Jul 2020 10:48:38 -0600
> > > Daniel Campello <campello@chromium.org> wrote:  
> > > > diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
> > > > new file mode 100644
> > > > index 00000000000000..5739074d3592fe
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
> > > > @@ -0,0 +1,65 @@  
> > [...]  
> > > > +
> > > > +  "#io-channel-cells":
> > > > +    const: 1
> > > > +
> > > > +required:
> > > > +  - compatible
> > > > +  - reg
> > > > +  - "#io-channel-cells"  
> > >
> > > Missed this in earlier review (only noticed when I saw whilst santity
> > > checking earlier versions.
> > >
> > > Fairly sure we should only need #io-channel-cells if we have
> > > a consumer of a channel somewhere else in DT.  So it's not
> > > required as far as I can see.
> > >  
> >
> > This is mostly a decision for Rob to make, but I would make it required
> > because the device is always an io channel provider. It may be that it
> > isn't providing anything in the DT to something else in the DT but it is
> > providing this information somewhere so always having to spell that out
> > is simple and doesn't hurt.  
> 
> I agree. If the user is split in a board file or overlay, we don't
> want to have to be adding it to the provider at that time.

That is perhaps a reasonable view point for devices with channels that
are likely to be used by consumer drivers, but in this particular case we
are talking about a proximity sensor.  So far I don't think we
have any consumer drivers for this type of sensor (I might have forgotten
one of course!)

I'm not that fussed though, so will leave it in.

The argument is a lot stronger for ADCs and such like, so we can
start encouraging it for those.

Jonathan


> 
> Rob

