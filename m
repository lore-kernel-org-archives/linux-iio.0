Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ua0-f169.google.com ([209.85.217.169]:42512 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750933AbeCFMgc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Mar 2018 07:36:32 -0500
Received: by mail-ua0-f169.google.com with SMTP id b23so12883173uak.9
        for <linux-iio@vger.kernel.org>; Tue, 06 Mar 2018 04:36:31 -0800 (PST)
Date: Tue, 6 Mar 2018 09:36:28 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Michael Hennerich <michael.hennerich@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "21cnbao@gmail.com" <21cnbao@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: Work plan to move meter out of staging
Message-ID: <20180306123628.sawzr3k7ek3rkz46@smtp.gmail.com>
References: <20180305140224.dgh3rcywgxgxsxbx@smtp.gmail.com>
 <1520259685.12790.12.camel@nxp.com>
 <e876642e-0286-9602-884f-00f026d6873f@metafoo.de>
 <f8f972b2-837d-b242-6fa3-40bf21952b0b@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <f8f972b2-837d-b242-6fa3-40bf21952b0b@analog.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

> On 05.03.2018 17:30, Lars-Peter Clausen wrote:
> In general I think this is a great idea, however looking at it from a
> different angle -
> Most of the supported metering circuits are already marked as not
> recommended for new designs.
> While Analog Devices have a very strong product portfolio in the Metering IC
> space, all of the parts in
> staging/iio/meter are from 2011 and before and have already seen multiple
> product iterations since then.
> A major rework of these drivers might require testing, unfortunately these
> drivers were developed by a different team which now pursues different
> responsibilities.
> So I won’t be able to test them again, and therefore I’m also a bit hesitant
> to lift them out of staging.

I have seen your message a few minutes ago, just after I sent a patch
series that removes checkpatch problems from meter module. Anyway, after
your comments, I believe that is a better idea to work on another module
in the staging. Is that ok Daniel?

Just for curiosity, what is the process to remove meter from staging?

Thanks
 
> -- 
> Greetings,
> Michael
> 
> --
> Analog Devices GmbH      Otl-Aicher Strasse 60-64      80807 München
> Sitz der Gesellschaft München, Registergericht München HRB 40368,
> Geschäftsführer: Peter Kolberg, Ali Raza Husain, Eileen Wynne
