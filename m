Return-Path: <SRS0=pZra=RO=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E378C43381
	for <linux-iio@archiver.kernel.org>; Mon, 11 Mar 2019 16:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D70521734
	for <linux-iio@archiver.kernel.org>; Mon, 11 Mar 2019 16:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks-com.20150623.gappssmtp.com header.i=@gateworks-com.20150623.gappssmtp.com header.b="NKbfEr5H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfCKQcZ (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 11 Mar 2019 12:32:25 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40835 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfCKQcZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Mar 2019 12:32:25 -0400
Received: by mail-io1-f66.google.com with SMTP id p17so4571015iol.7
        for <linux-iio@vger.kernel.org>; Mon, 11 Mar 2019 09:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lZ6ntwFy11ktrvikUTtyt73Q+O7TcXnF0/k5s6t4E44=;
        b=NKbfEr5HXbIoZ39qHI45TxjjI/wy2Sc19lQ5iUUul1S7/qCIvFEZDyuvp6DCiRV9+W
         MU9k2XnzXwfmiQ3PeGwcf3I06ZIlOQ1g1CMR4I9uSgsEIQ+yODTcjUuBKR56FN5SitWx
         AUXag0eNeNC1bgbhU09G4DBjoazsVydCq7bG3HVUl7f8AK75nEGZzN2pytqSCU0Pgl0+
         01RX0MQKsWQLguMYFuyL4W+tKMJ/MGjq7oWTD6PJjD1SP4sFSJ9jVjxZmNm3rXqyZj+y
         PDL/GuKltLzorHuPjB+WRXywXYdiln/3tEI9+0xRJp/1qUpnmPboxlDG9+X5Ovt/hYXL
         Ib3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lZ6ntwFy11ktrvikUTtyt73Q+O7TcXnF0/k5s6t4E44=;
        b=cQrG86tzmRE4sE/CCEa1+9+y9FmEauS4pm4q9unlJovGf2oXcAva0gi4v7EC1RCyoC
         vlA8ZriOvKSZ0NT0NiEphZJc/gKEDIMkOinjKGo/mPkNsTjxMyG4OjXmLi5tWqvw2CpK
         ZKQpSlmO3nOHMxpTokO79UzJ4DmUO/3PC1NpNvX2pDRdOHq0v6KOmcw9bddJXBBQqvsO
         gJbGhNZ9/mMCrSWfOqsvZMLlq+3EgKPUgq4krtfK2VRw5EuyOf7jG7TYbDADQy7vO9qX
         FS4Nx0EN2Nho50Hzy70QWizhosDkrS+bOypAy6/B2KrF+zSLschuyqalKrvDz+hva+ga
         asLA==
X-Gm-Message-State: APjAAAXj6T6GLvfakAaI0KB9tPqjNzSs9gjMr863boFAX1aX0XXqdGLi
        YYpunbJ25zSKPhF5zOemcvmcjrJTOkC5ThSmBbO7pQ==
X-Google-Smtp-Source: APXvYqzd2l7qwNB5CPqTmwup/Ow3PQ1H9HzpcTc6iUMaO6dTMaWP7G8WajAuUDEnTbfHFGTvN82M+ulVa8/t4IZTEhY=
X-Received: by 2002:a5e:8609:: with SMTP id z9mr17738848ioj.48.1552321944307;
 Mon, 11 Mar 2019 09:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190305203252.13647-1-rjones@gateworks.com> <20190305203252.13647-2-rjones@gateworks.com>
 <2671a590a8394e76bd795c6bb187bfd1@SFHDAG2NODE1.st.com> <20190309182026.6866b037@archlinux>
 <20190309182310.25409803@archlinux>
In-Reply-To: <20190309182310.25409803@archlinux>
From:   Bobby Jones <rjones@gateworks.com>
Date:   Mon, 11 Mar 2019 09:31:48 -0700
Message-ID: <CALAE=UA=jALQ=6-Qitw5DX7_JfUctFrGGJ=qK4cMtDROoDwD2Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: accel: add LIS2DE12 sensor device binding
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc:     Denis CIOCCA <denis.ciocca@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Mar 9, 2019 at 10:23 AM Jonathan Cameron
<jic23@jic23.retrosnub.co.uk> wrote:
>
> On Sat, 9 Mar 2019 18:20:26 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
>
> > On Sat, 9 Mar 2019 01:14:14 +0000
> > Denis CIOCCA <denis.ciocca@st.com> wrote:
> >
> > > Acked-by: Denis Ciocca <denis.ciocca@st.com>
> > Applied to the togreg branch of iio.git and pushed
> > out as testing for the autobuilders to play with it.
> >
> > Thanks
> >
> > Jonathan
> Actually, sorry too fast to click send!
>
> Why the -accel postfix?
>
> That is normally only done for devices with multiple
> separate sensors within them.  That isn't true as
> far as I can see for this one.

To be completely honest, I simply mimicked the commit for the
st,lis2dh12-accel which appeared to be the closest equivalent after
comparing datasheets.
If this is incorrect I have no issues with removing the postfix.

Thanks,
Robert

> Jonathan
>
> >
> > >
> > > Thanks,
> > > Denis
> > >
> > >
> > > -----Original Message-----
> > > From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org> On Behalf Of Robert Jones
> > > Sent: Tuesday, March 5, 2019 12:33 PM
> > > To: Jonathan Cameron <jic23@kernel.org>; Rob Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>
> > > Cc: devicetree@vger.kernel.org; linux-iio@vger.kernel.org; Hartmut Knaack <knaack.h@gmx.de>; Lars-Peter Clausen <lars@metafoo.de>; Peter Meerwald-Stadler <pmeerw@pmeerw.net>; Robert Jones <rjones@gateworks.com>
> > > Subject: [PATCH 1/2] dt-bindings: iio: accel: add LIS2DE12 sensor device binding
> > >
> > > Signed-off-by: Robert Jones <rjones@gateworks.com>
> > > ---
> > >  Documentation/devicetree/bindings/iio/st-sensors.txt | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/iio/st-sensors.txt b/Documentation/devicetree/bindings/iio/st-sensors.txt
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
