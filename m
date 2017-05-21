Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37808 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756551AbdEUOdf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 May 2017 10:33:35 -0400
Subject: Re: spear_adc driver help needed ?
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Stefan Roese <sr@denx.de>
References: <20170518094146.6504821a@free-electrons.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <73991880-8585-95a3-3d67-6544717c1264@kernel.org>
Date: Sun, 21 May 2017 15:33:31 +0100
MIME-Version: 1.0
In-Reply-To: <20170518094146.6504821a@free-electrons.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/05/17 08:41, Thomas Petazzoni wrote:
> Hello Jonathan,
> 
> I've been working on a SPEAr600 platform recently, which uses the
> spear_adc driver, and was about to start working on moving the driver
> out of staging... only to discover in 4.12-rc1 that you already moved
> it out of staging.
Yeah, this one hit the question of:
Is it is good enough to move it or should we bin it as no improvements are
really happening and no one seems to have one?

I went with the it's good enough option being an optimist.
> 
> In the commit log that moves it out of staging, you're saying:
> 
>      There are some unanswered questions due to disagreements between the code
>      and various datasheets (including between different datasheets for the same
>      part).
>      
>      I don't think that is necessarily a reason to keep it in staging however.
>      I'm partly posting this patch inorder to reignite debate and with a bit
>      of luck find someone who has one of these to test!
> 
> What are the unanswered questions you are talking about?
These all came up in the previous attempt to move the driver out of staging
back in 2014

http://www.spinics.net/lists/linux-iio/msg12443.html
In particular the results of Harmut tracking down a datahsheet and going
through some elements of it in detail.
> 
> Also, I am currently using the driver on a SPEAr600 device, so I can do
> some testing.
Cool.
> 
> The driver has support for the SPEAr3xx, but it isn't used anywhere:
> there is no compatible string for it, and nowhere is old-style probing
> used for "spear-adc".
Stefan (cc'd) might know who is likely to be using it...

However after a bit of digging in the history, his original patch said
that it was untested and proper support might eventually be added.
> 
> So I'm thinking of:
> 
>   - Dropping SPEAr3xx support, because it's unused. This will also
>     remove the ugly checks done on the compatible string all over the
>     place.
I agree.
> 
>   - Moving to a "base + offset" style of register accesses, rather than
>     the struct-based accesses.
Yeah, with the 3xx stuff gone that would tidy things up further.

Only exception would be if someone rapidly jumps up and down and says
they use the 3xx support as is or have working patches they were aiming to
submit to make it work.

Thanks for working on this.  I'd forgotten that stuff was even in there!
> 
> What do you think ?
Would be great to tidy this up, particularly as it sounds like there
are actually users.   Sometimes I wonder on some of the stuff I've
lifted out of staging over the years ;)

Jonathan
> 
> Best regards,
> 
> Thomas
> 

