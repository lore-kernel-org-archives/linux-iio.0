Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt0-f170.google.com ([209.85.216.170]:36843 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932501AbeCPAlY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Mar 2018 20:41:24 -0400
Received: by mail-qt0-f170.google.com with SMTP id c7so9276942qtn.3
        for <linux-iio@vger.kernel.org>; Thu, 15 Mar 2018 17:41:23 -0700 (PDT)
Date: Thu, 15 Mar 2018 21:41:20 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Michael Hennerich <michael.hennerich@analog.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: Hardware for testing resolver modules in staging
Message-ID: <20180316004120.dhnn7qax66saafiw@smtp.gmail.com>
References: <20180314190847.b7v5pllvl2qlle7e@smtp.gmail.com>
 <105a3c79-017b-53d4-22f2-8465e5ef5ac5@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <105a3c79-017b-53d4-22f2-8465e5ef5ac5@analog.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

On 03/15, Michael Hennerich wrote:
> On 14.03.2018 20:08, Rodrigo Siqueira wrote:
> > Hi,
> > 
> > I am working in the AD2S1210 with the intention to move it out of
> > staging. However, I don't have the device and Jonathan alerted me to the
> > lack of hardware for testing.
> > 
> > Michael, is it possible that someone in Analog Devices could help with
> > the hardware tests? If Analog Devices can't help, there is someone else
> > that could help with it?
> > 
> > P.s: Other guys are working in other modules in the resolver, I believe
> > they could be interesting on this issue too.
> > 
> > Best regards
> > Rodrigo Siqueira
> > 
> 
> Hi Rodrigo,
> 
> Unfortunately I don't have HW to test these drivers.
> Besides the EVAL board and some connection to an single board computer,
> you would also need an industrial resolver which are quite expensive.
> 
> If you or someone else want to test things. I can certainly have someone
> ship a free EVAL board if they are on stock, but the resolver would need to
> be sourced from somewhere else.

Nice.

> In general I think these drivers have been tested, if we are carefully we
> could skip the additional test.

Agree.
I will keep send patches to improve the AD2S1210 driver.

> -- 
> Greetings,
> Michael
> 
> --
> Analog Devices GmbH      Otl-Aicher Strasse 60-64      80807 München
> Sitz der Gesellschaft München, Registergericht München HRB 40368,
> Geschäftsführer: Peter Kolberg, Ali Raza Husain, Eileen Wynne
