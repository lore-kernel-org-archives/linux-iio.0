Return-Path: <SRS0=wbiz=B2=pmeerw.net=pmeerw@kernel.org>
Date: Fri, 27 Oct 2017 13:15:58 +0200 (CEST)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: SF Markus Elfring <elfring@users.sourceforge.net>
cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
    LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: iio/accel/stk8312: Improve unlocking of a mutex in two
 functions
In-Reply-To: <c2620449-b80a-f0ef-c0d2-92d0c7fb4906@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1710271254570.17368@vps.pmeerw.net>
References: <ae9d7e7f-541e-ce0c-1d41-6b9793c98f78@users.sourceforge.net> <20171026170913.5ff10718@archlinux> <c2620449-b80a-f0ef-c0d2-92d0c7fb4906@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="324302256-1852926522-1509102958=:17368"
List-ID: <linux-iio@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--324302256-1852926522-1509102958=:17368
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hello,

> Maybe …
> But I proposed an other source code layout for useful reasons.

I think there is a (hidden) cost of having pure cleanup patches:
they make backporting fixes harder (across the cleanup)

stylistic changes must have a clear benefit, readability is subjective, 
consistency per se doesn't buy anything

the discussion how code should be written in the first place is separate
from the discussion what is worth fixing up lateron (IMHO)

> > There is no firm rule about error handling in one place.
> 
> There are some design options available.
> 
> 
> > If it leads to more complex flow as here, don't do it.
> 
> I would appreciate to clarify such a view a bit more.
> How would you like to achieve a complete and efficient
> exception handling in shown places?

regards, p.

-- 

Peter Meerwald-Stadler
Mobile: +43 664 24 44 418
--324302256-1852926522-1509102958=:17368--
