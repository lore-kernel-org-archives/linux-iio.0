Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46249 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751598AbdCBUKY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Mar 2017 15:10:24 -0500
Subject: Re: [Outreachy kernel] [PATCH 1/3] staging: iio: meter: Remove unused
 definitions
To: Daniel Baluta <daniel.baluta@gmail.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Katie Dunne <kdunne@mail.ccsf.edu>
References: <cover.1488250884.git.kdunne@mail.ccsf.edu>
 <972438f1c7bc46153df933c5861fac91f6793e92.1488250885.git.kdunne@mail.ccsf.edu>
 <alpine.DEB.2.20.1702280746000.2078@hadrien>
 <CAEnQRZCeK0L4vbpTHOk78QP1iJYMrZSRmJvG=XNL_jo4OkRgZA@mail.gmail.com>
Cc: outreachy-kernel <outreachy-kernel@googlegroups.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <e3410f97-3328-ad78-883a-d996d768dcfc@kernel.org>
Date: Thu, 2 Mar 2017 19:14:56 +0000
MIME-Version: 1.0
In-Reply-To: <CAEnQRZCeK0L4vbpTHOk78QP1iJYMrZSRmJvG=XNL_jo4OkRgZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/02/17 08:13, Daniel Baluta wrote:
> On Tue, Feb 28, 2017 at 8:47 AM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>>
>>
>> On Mon, 27 Feb 2017, Katie Dunne wrote:
>>
>>> Remove definitions not used in kernel code.
>>
>> Did Alison ask for this?  Normally these kinds of constant definitions are
>> kept, because they describe the device in some way.  If you see macros
>> that perform more complex computations that are not used, you can get rid
>> of those.
> 
> Agree with Julia, lets keep this because they could be good documentation.
Agreed. Katie, would you mind posting a V2 of the series with just the other
two patches updated to account for this one not being there?

Thanks,

Jonathan
> 
> Daniel.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

