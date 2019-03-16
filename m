Return-Path: <SRS0=kDFh=RT=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799D7C43381
	for <linux-iio@archiver.kernel.org>; Sat, 16 Mar 2019 15:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5154E218E0
	for <linux-iio@archiver.kernel.org>; Sat, 16 Mar 2019 15:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfCPPGI (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 16 Mar 2019 11:06:08 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:44536 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbfCPPGI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 16 Mar 2019 11:06:08 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 5751C9E7723;
        Sat, 16 Mar 2019 15:06:05 +0000 (GMT)
Date:   Sat, 16 Mar 2019 15:06:02 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Denis CIOCCA <denis.ciocca@st.com>
Cc:     Robert Jones <rjones@gateworks.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH 1/2] dt-bindings: iio: accel: add LIS2DE12 sensor device
 binding
Message-ID: <20190316150602.7f0010e3@archlinux>
In-Reply-To: <681ca9e5102c4b59a49c5db1789c366c@SFHDAG2NODE1.st.com>
References: <20190305203252.13647-1-rjones@gateworks.com>
        <20190305203252.13647-2-rjones@gateworks.com>
        <2671a590a8394e76bd795c6bb187bfd1@SFHDAG2NODE1.st.com>
        <20190309182026.6866b037@archlinux>
        <20190309182310.25409803@archlinux>
        <681ca9e5102c4b59a49c5db1789c366c@SFHDAG2NODE1.st.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 11 Mar 2019 23:02:16 +0000
Denis CIOCCA <denis.ciocca@st.com> wrote:

> Yes, you are right Jonathan.
> 
> I saw that before but since there are already 15 sensors that are not following my initial convention anymore, I decided to let it go...Not sure I'll be able to catch all of the patches.
> But your point is actually correct. I know it's a small thing but anyway what do you thing about?
Let's do best effort on this and I'll try to be careful to catch them
as well.  We could look at deprecating the inappropriate -accel bindings
and add the version with out as well.  Lots of appropriate comments
should stop people repeating this in future.

Anyhow, for now I've just fixed this one up to drop it.

Thanks,

Jonathan

> 
> Denis
> 
> 
> -----Original Message-----
> From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk> 
> Sent: Saturday, March 9, 2019 10:23 AM
> To: Denis CIOCCA <denis.ciocca@st.com>
> Cc: Robert Jones <rjones@gateworks.com>; Rob Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>; devicetree@vger.kernel.org; linux-iio@vger.kernel.org; Hartmut Knaack <knaack.h@gmx.de>; Lars-Peter Clausen <lars@metafoo.de>; Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Subject: Re: [PATCH 1/2] dt-bindings: iio: accel: add LIS2DE12 sensor device binding
> 
> On Sat, 9 Mar 2019 18:20:26 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Sat, 9 Mar 2019 01:14:14 +0000
> > Denis CIOCCA <denis.ciocca@st.com> wrote:
> >   
> > > Acked-by: Denis Ciocca <denis.ciocca@st.com>  
> > Applied to the togreg branch of iio.git and pushed out as testing for 
> > the autobuilders to play with it.
> > 
> > Thanks
> > 
> > Jonathan  
> Actually, sorry too fast to click send!
> 
> Why the -accel postfix?
> 
> That is normally only done for devices with multiple separate sensors within them.  That isn't true as far as I can see for this one.
> 
> Jonathan
> 
> >   
> > > 
> > > Thanks,
> > > Denis
> > > 
> > > 
> > > -----Original Message-----
> > > From: linux-iio-owner@vger.kernel.org 
> > > <linux-iio-owner@vger.kernel.org> On Behalf Of Robert Jones
> > > Sent: Tuesday, March 5, 2019 12:33 PM
> > > To: Jonathan Cameron <jic23@kernel.org>; Rob Herring 
> > > <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>
> > > Cc: devicetree@vger.kernel.org; linux-iio@vger.kernel.org; Hartmut 
> > > Knaack <knaack.h@gmx.de>; Lars-Peter Clausen <lars@metafoo.de>; 
> > > Peter Meerwald-Stadler <pmeerw@pmeerw.net>; Robert Jones 
> > > <rjones@gateworks.com>
> > > Subject: [PATCH 1/2] dt-bindings: iio: accel: add LIS2DE12 sensor 
> > > device binding
> > > 
> > > Signed-off-by: Robert Jones <rjones@gateworks.com>
> > > ---
> > >  Documentation/devicetree/bindings/iio/st-sensors.txt | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/st-sensors.txt 
> > > b/Documentation/devicetree/bindings/iio/st-sensors.txt
> > > index 52ee4ba..7f24b33 100644
> > > --- a/Documentation/devicetree/bindings/iio/st-sensors.txt
> > > +++ b/Documentation/devicetree/bindings/iio/st-sensors.txt
> > > @@ -49,6 +49,7 @@ Accelerometers:
> > >  - st,lis2dw12
> > >  - st,lis3dhh
> > >  - st,lis3de
> > > +- st,lis2de12-accel
> > >  
> > >  Gyroscopes:
> > >  - st,l3g4200d-gyro  
> >   
> 

