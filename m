Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:57128 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752381AbeCQQz0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 17 Mar 2018 12:55:26 -0400
Date: Sat, 17 Mar 2018 16:55:18 +0000
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
        linux-iio@vger.kernel.org
Subject: Re: Hardware for testing resolver modules in staging
Message-ID: <20180317165518.680fe706@archlinux>
In-Reply-To: <20180316004120.dhnn7qax66saafiw@smtp.gmail.com>
References: <20180314190847.b7v5pllvl2qlle7e@smtp.gmail.com>
        <105a3c79-017b-53d4-22f2-8465e5ef5ac5@analog.com>
        <20180316004120.dhnn7qax66saafiw@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 15 Mar 2018 21:41:20 -0300
Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:

> Hi,
> 
> On 03/15, Michael Hennerich wrote:
> > On 14.03.2018 20:08, Rodrigo Siqueira wrote:  
> > > Hi,
> > > 
> > > I am working in the AD2S1210 with the intention to move it out of
> > > staging. However, I don't have the device and Jonathan alerted me to the
> > > lack of hardware for testing.
> > > 
> > > Michael, is it possible that someone in Analog Devices could help with
> > > the hardware tests? If Analog Devices can't help, there is someone else
> > > that could help with it?
> > > 
> > > P.s: Other guys are working in other modules in the resolver, I believe
> > > they could be interesting on this issue too.
> > > 
> > > Best regards
> > > Rodrigo Siqueira
> > >   
> > 
> > Hi Rodrigo,
> > 
> > Unfortunately I don't have HW to test these drivers.
> > Besides the EVAL board and some connection to an single board computer,
> > you would also need an industrial resolver which are quite expensive.
> > 
> > If you or someone else want to test things. I can certainly have someone
> > ship a free EVAL board if they are on stock, but the resolver would need to
> > be sourced from somewhere else.  
> 
> Nice.
Old school resolvers do turn up on ebay from time to time. I have a bid
in on one in the uk at the moment with a view to 'eventually' getting
around to testing these drivers (and other future parts)

> 
> > In general I think these drivers have been tested, if we are carefully we
> > could skip the additional test.  
> 
> Agree.
> I will keep send patches to improve the AD2S1210 driver.
Seeing as the chances are Michael would get pestered by anyone who found
these drivers didn't work, I'm happy to go with this so we can make quicker
progress than we would sourcing parts and getting around to testing properly.

Jonathan
> 
> > -- 
> > Greetings,
> > Michael
> > 
> > --
> > Analog Devices GmbH      Otl-Aicher Strasse 60-64      80807 München
> > Sitz der Gesellschaft München, Registergericht München HRB 40368,
> > Geschäftsführer: Peter Kolberg, Ali Raza Husain, Eileen Wynne  
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

