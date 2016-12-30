Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51895 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754130AbcL3QJ5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Dec 2016 11:09:57 -0500
Subject: Re: [PATCHv2] iio: adc: Add Maxim MAX11100 driver
To: Wolfram Sang <wsa@the-dreams.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <1481041823-18382-1-git-send-email-jacopo@jmondi.org>
 <1481632629-18826-1-git-send-email-jacopo@jmondi.org>
 <CAMuHMdUCuBs9Fm+YvsqEc1J_a_2sgg104DDBf39oUD2JQRxXtg@mail.gmail.com>
 <20161213155327.GA1451@katana>
Cc: Jacopo Mondi <jacopo@jmondi.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <4986d997-f536-6981-0b90-a7b110f68401@kernel.org>
Date: Fri, 30 Dec 2016 16:09:55 +0000
MIME-Version: 1.0
In-Reply-To: <20161213155327.GA1451@katana>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/12/16 15:53, Wolfram Sang wrote:
> 
>>> +struct max11100_state {
>>> +       const struct max11100_chip_desc *desc;
>>> +       struct spi_device *spi;
>>> +       int vref_uv;
>>
>> unsi
>> It's good practice to move the smaller members to the end of the structure,
>> to avoid gaps due to alignment rules (struct mutex needs to be 64-bit aligned
>> on 64-bit platforms).
> 
> One option. Another idea is to put the most used members to the front to
> increase chances of being in the same cacheline.
> 
Or more cynically, just put them in the order that makes most logical sense
as that gives you fewest grumpy reviewers.
We aren't really talking high performance stuff here!

Jonathan
