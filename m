Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:34963 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751593AbdB1INd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Feb 2017 03:13:33 -0500
Received: by mail-io0-f174.google.com with SMTP id j18so4677040ioe.2
        for <linux-iio@vger.kernel.org>; Tue, 28 Feb 2017 00:13:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1702280746000.2078@hadrien>
References: <cover.1488250884.git.kdunne@mail.ccsf.edu> <972438f1c7bc46153df933c5861fac91f6793e92.1488250885.git.kdunne@mail.ccsf.edu>
 <alpine.DEB.2.20.1702280746000.2078@hadrien>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Tue, 28 Feb 2017 10:13:23 +0200
Message-ID: <CAEnQRZCeK0L4vbpTHOk78QP1iJYMrZSRmJvG=XNL_jo4OkRgZA@mail.gmail.com>
Subject: Re: [Outreachy kernel] [PATCH 1/3] staging: iio: meter: Remove unused definitions
To: Julia Lawall <julia.lawall@lip6.fr>,
        Katie Dunne <kdunne@mail.ccsf.edu>
Cc: outreachy-kernel <outreachy-kernel@googlegroups.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Feb 28, 2017 at 8:47 AM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>
>
> On Mon, 27 Feb 2017, Katie Dunne wrote:
>
>> Remove definitions not used in kernel code.
>
> Did Alison ask for this?  Normally these kinds of constant definitions are
> kept, because they describe the device in some way.  If you see macros
> that perform more complex computations that are not used, you can get rid
> of those.

Agree with Julia, lets keep this because they could be good documentation.

Daniel.
