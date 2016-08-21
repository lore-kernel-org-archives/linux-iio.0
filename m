Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53287 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752804AbcHUTuv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 Aug 2016 15:50:51 -0400
Subject: Re: [PATCH 02/17] iio: accel: kxsd9: Fix raw read return
To: Linus Walleij <linus.walleij@linaro.org>
References: <1471354423-19186-1-git-send-email-linus.walleij@linaro.org>
 <1471354423-19186-3-git-send-email-linus.walleij@linaro.org>
 <DE81936B-E9FB-40A1-A139-9BCA6841C11F@kernel.org>
 <CACRpkdauRqmbms4t3jcypao32dxy0S+LcdEMH1+m2SW_9G=n3g@mail.gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        stable <stable@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <1e12578c-bf58-92a0-7d06-ea56b3c69108@kernel.org>
Date: Sun, 21 Aug 2016 20:40:17 +0100
MIME-Version: 1.0
In-Reply-To: <CACRpkdauRqmbms4t3jcypao32dxy0S+LcdEMH1+m2SW_9G=n3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/08/16 08:15, Linus Walleij wrote:
> On Tue, Aug 16, 2016 at 6:24 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> 
>> *whistles whilst pretending this driver has nothing to do with me*
>>
>> What's really odd is I ran this not long ago and didn't notice this little
>> quirk...
> 
> Yeah I remember you mentioned it... there must be something that
> made it work and tick anyways. Maybe core changes?
> 
> If you can get the SPI-based system up we can get the driver in
> really nice shape though! It's working like a charm for me at the
> end of the series.
> 
It may take me a while (couple of weeks possibly) to spin up that hardware
as I'm not quite on top of my back queue of patches.

I'll do a visual review in meantime but not apply anything until I can
test.

Jonathan
> Yours,
> Linus Walleij
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

