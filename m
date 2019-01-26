Return-Path: <SRS0=WfKE=QC=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AACDC282C7
	for <linux-iio@archiver.kernel.org>; Sat, 26 Jan 2019 17:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 753DF21872
	for <linux-iio@archiver.kernel.org>; Sat, 26 Jan 2019 17:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbfAZR1c (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 26 Jan 2019 12:27:32 -0500
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:59666 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbfAZR1b (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 26 Jan 2019 12:27:31 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 8C5DB9E75D4;
        Sat, 26 Jan 2019 17:27:26 +0000 (GMT)
Date:   Sat, 26 Jan 2019 17:27:25 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Daniel Drake <drake@endlessm.com>
Cc:     Denis CIOCCA <denis.ciocca@st.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux@endlessm.com" <linux@endlessm.com>,
        "lorenzo.bianconi83@gmail.com" <lorenzo.bianconi83@gmail.com>,
        "hadess@hadess.net" <hadess@hadess.net>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>
Subject: Re: [PATCH 2/2] iio: st_accel: use ACPI orientation data
Message-ID: <20190126172704.6704d0ed@archlinux>
In-Reply-To: <20190119165015.2b44a64d@archlinux>
References: <20181220065933.25964-1-drake@endlessm.com>
        <20181220065933.25964-2-drake@endlessm.com>
        <20181222180914.6d3b5e5e@archlinux>
        <20190112191305.103daa46@archlinux>
        <49fe1df26d70489ca3b3c52cb5cf561c@SFHDAG2NODE1.st.com>
        <CAD8Lp47XPzqQrVpAMnyHKE92Zj7XB8fZnj5HW_TTddgHzUCmOQ@mail.gmail.com>
        <20190119165015.2b44a64d@archlinux>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 19 Jan 2019 16:50:15 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 15 Jan 2019 11:09:51 +0800
> Daniel Drake <drake@endlessm.com> wrote:
> 
> > Hi Denis,
> > 
> > On Tue, Jan 15, 2019 at 8:18 AM Denis CIOCCA <denis.ciocca@st.com> wrote:  
> > > I am not familiar with ACPI and I am not sure why axis orientation is not following the standard there.
> > > What I wonder is if this is related to SMO8840, Acer or in general to ST accelerometers integration. Your patch seems to be fine technically but are you able to confirm it will works even outside the 3 parts tested? The other accel supported by ACPI probing SMO8A90 is affected also?    
> > 
> > The _ONT data format was explained to us by a vendor support contact
> > at ST. (however, the fact that the _ONT transformation must be applied
> > after first applying another translation was determined experimentally
> > by me).
> > 
> > We have seen this _ONT data present in ACPI tables from multiple
> > product vendors, on SMO8820, SMO8821 and SMO8840 devices, so I believe
> > there is no doubt that it is a ST-specific thing.
> > 
> > The specific transformation behaviour in my patch has only been tested
> > on products with SMO8840 though, since those are the only ones we have
> > on hand.
> > 
> > Daniel  
> I suspect we aren't going to come to a firm conclusion on this any time
> soon.  As it only effects devices that do provide _ONT, it is fairly
> unlikely to cause a regression.  Ideally we would know if it worked on
> the other devices where this is known to exist but such is life.
> 
> If people agree that I'm right in patch 1 not being necessary and
> we don't have any objections to merging this I'll do so, probably next
> weekend now.
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> 
> Thanks,
> 
> Jonathan
> 
> 

