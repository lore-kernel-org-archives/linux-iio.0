Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50761 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751790AbdCCRpj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Mar 2017 12:45:39 -0500
Date: Fri, 03 Mar 2017 17:20:36 +0000
In-Reply-To: <20170303165247.el4mcsmo4fbnkjir@ninjato>
References: <1486568517-6997-1-git-send-email-peda@axentia.se> <6d87465f-b983-3f62-c7cf-41ed4e50170d@axentia.se> <20170228171842.GA11127@kroah.com> <569c18b3-b1d8-f2e6-7fc4-897aa7df6775@axentia.se> <20170303165247.el4mcsmo4fbnkjir@ninjato>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [PATCH v9 00/10] mux controller abstraction and iio/i2c muxes
To: Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-doc@vger.kernel.org
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Message-ID: <C3B088E3-75B2-4F7C-850D-99B788BA1FBC@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 3 March 2017 16:52:47 GMT+00:00, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> Jonathan, Wolfram, do you have any preferences on how this should be
>> coordinated regarding the new iio and i2c drivers (and iio changes)?
>
>You got the acks, all is fine, I think.
>
>> My plan is to at some point declare the branch immutable. Then both
>of
>> you can pull it in. Or? 
>
>Yup, sounds good.
>
>> But now that I think about it I wonder what the point is of having
>> Greg pull it in also? Sure, third time's a charm and all that, but...
>
>AFAIU, Greg will be your "upstream", so he should definately pull the
>branch. I will just pull it in to avoid merge conflicts in my tree.
>Or did I misunderstand your question?
Agreed, will do the same if needed. Btw Greg is a very nice upstream to have!

Jonathan

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
