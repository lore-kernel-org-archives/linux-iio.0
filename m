Return-Path: <SRS0=WfKE=QC=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DB1C282C7
	for <linux-iio@archiver.kernel.org>; Sat, 26 Jan 2019 17:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06D79218A2
	for <linux-iio@archiver.kernel.org>; Sat, 26 Jan 2019 17:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548523204;
	bh=4GnSscUAF6+bhhzWuP8g/A6DgqZXApEyu279PWLze7E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=LvcT1yK092G2Y3HSDhy+AVSt5Q2ejynhRDAxx01DEOOfBlOiwz8xFRYevSOhsw1mn
	 WwM6m5mFc4Kv0jRHlWLARyYy95GMECN3QHpe2frXCUX6fKJT1MkdhyUkxPnrEs69op
	 jVu1d+FIP75eIwhzVfMrsk3nd2m2hm21ymNfinKk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbfAZRUD (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 26 Jan 2019 12:20:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:47358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbfAZRUD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 26 Jan 2019 12:20:03 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B71B72184C;
        Sat, 26 Jan 2019 17:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548523202;
        bh=4GnSscUAF6+bhhzWuP8g/A6DgqZXApEyu279PWLze7E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GwArrAD6mTmDY0GyE7SR235qVPRlchKgyX9G97EPdD4pa17gFDB9eMEWBd1ZfbmCM
         vYxRTA788u/9pAmjcmlBrQ76qP+pQYMUIXJWTFvsnejlw4eaLkflhwH66DgzbUbEIa
         zpYVHjFIrez37mwE0kDNw/PVdtzDteQ9HE4m0nFk=
Date:   Sat, 26 Jan 2019 17:19:58 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ibtsam Ul-Haq <ibtsam.haq.0x01@gmail.com>
Cc:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, stefan.popa@analog.com
Subject: Re: [PATCH] iio: Add driver for TLA202x ADCs
Message-ID: <20190126171958.11808be0@archlinux>
In-Reply-To: <CAPQseg1q=heJpKPQX-PcPkThHq2NVM1k2tQj1SpUTYTfC=D1Hg@mail.gmail.com>
References: <1542679806-5812-1-git-send-email-ibtsam.haq.0x01@gmail.com>
        <alpine.DEB.2.21.1811200637130.11466@vps.pmeerw.net>
        <20181125130102.62c32183@archlinux>
        <CAPQseg1q=heJpKPQX-PcPkThHq2NVM1k2tQj1SpUTYTfC=D1Hg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 21 Jan 2019 10:49:17 +0100
Ibtsam Ul-Haq <ibtsam.haq.0x01@gmail.com> wrote:

> Hi,
> 
> Thanks a lot for the review. I shall apply all these in the v2, I do
> have just one question, below.
> 
> > > > +
> > > > +static int tla2024_of_find_chan(struct tla2024 *priv, struct device_node *ch)
> > > > +{
> > > > +   u16 chan_idx = 0;
> > > > +   u32 tmp_p, tmp_n;
> > > > +   int ainp, ainn;
> > > > +   int ret;
> > > > +
> > > > +   ret = of_property_read_u32_index(ch, "single-ended", 0, &tmp_p);  
> > There is now (only very recently) a generic description in DT for
> > acpi channels.  Please look at that:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/tree/Documentation/devicetree/bindings/iio/adc/adc.txt?h=togreg&id=00426e99789357dbff7e719a092ce36a3ce49d94
> >
> > It is minimalist.  If it is single ended, you can tell that by the absence
> > of diff-channels.
> >  
> 
> How should we specify which single ended channel to use? For example,
> say I want to configure the driver for reading single-ended values
> only from input pin AIN3. When we only signify a single-ended channel
> by the absence of "diff-channels", where should the "3" be specified?

Fair question.  Stefan, what do you think makes sense?
(obviously others welcome but my guess is Stefan has thought about this
more than most ;)

Jonathan



> 
> > If the binding needs additional elements (it probably does)
> > then propose them for that generic binding.  We are trying to move
> > away from each driver doing it's own thing given all this stuff is
> > pretty generic!
> >  
> 
> Sorry for trimming the message. Gmail was otherwise blocking my
> outbound message, and I could not find any other way to get it
> through.
> 
> Best regards,
> Ibtsam Haq

