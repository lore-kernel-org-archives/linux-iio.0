Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-sn1nam01on0081.outbound.protection.outlook.com ([104.47.32.81]:34688
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752495AbeCOO23 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 15 Mar 2018 10:28:29 -0400
Reply-To: <michael.hennerich@analog.com>
Subject: Re: Hardware for testing resolver modules in staging
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        <linux-iio@vger.kernel.org>
References: <20180314190847.b7v5pllvl2qlle7e@smtp.gmail.com>
From: Michael Hennerich <michael.hennerich@analog.com>
Message-ID: <105a3c79-017b-53d4-22f2-8465e5ef5ac5@analog.com>
Date: Thu, 15 Mar 2018 15:31:36 +0100
MIME-Version: 1.0
In-Reply-To: <20180314190847.b7v5pllvl2qlle7e@smtp.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14.03.2018 20:08, Rodrigo Siqueira wrote:
> Hi,
> 
> I am working in the AD2S1210 with the intention to move it out of
> staging. However, I don't have the device and Jonathan alerted me to the
> lack of hardware for testing.
> 
> Michael, is it possible that someone in Analog Devices could help with
> the hardware tests? If Analog Devices can't help, there is someone else
> that could help with it?
> 
> P.s: Other guys are working in other modules in the resolver, I believe
> they could be interesting on this issue too.
> 
> Best regards
> Rodrigo Siqueira
> 

Hi Rodrigo,

Unfortunately I don't have HW to test these drivers.
Besides the EVAL board and some connection to an single board computer,
you would also need an industrial resolver which are quite expensive.

If you or someone else want to test things. I can certainly have someone 
ship a free EVAL board if they are on stock, but the resolver would need 
to be sourced from somewhere else.

In general I think these drivers have been tested, if we are carefully 
we could skip the additional test.


-- 
Greetings,
Michael

--
Analog Devices GmbH      Otl-Aicher Strasse 60-64      80807 München
Sitz der Gesellschaft München, Registergericht München HRB 40368,
Geschäftsführer: Peter Kolberg, Ali Raza Husain, Eileen Wynne
