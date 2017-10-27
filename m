Return-Path: <SRS0=GKZx=B2=users.sourceforge.net=elfring@kernel.org>
Subject: Re: iio/accel/stk8312: Improve unlocking of a mutex in two functions
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org
References: <ae9d7e7f-541e-ce0c-1d41-6b9793c98f78@users.sourceforge.net>
 <20171026170913.5ff10718@archlinux>
 <c2620449-b80a-f0ef-c0d2-92d0c7fb4906@users.sourceforge.net>
 <alpine.DEB.2.20.1710271254570.17368@vps.pmeerw.net>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <82e2fde9-2b35-be54-4614-977fc2894da1@users.sourceforge.net>
Date: Fri, 27 Oct 2017 14:37:04 +0200
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1710271254570.17368@vps.pmeerw.net>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

>> But I proposed an other source code layout for useful reasons.
> 
> I think there is a (hidden) cost of having pure cleanup patches:
> they make backporting fixes harder (across the cleanup)

There the usual software development consequences to consider
if you dare to change the source code at all.


> stylistic changes must have a clear benefit, readability is subjective, 
> consistency per se doesn't buy anything

There are also different opinions involved.


> the discussion how code should be written in the first place is separate
> from the discussion what is worth fixing up lateron (IMHO)

Are you looking for a corresponding agreement?

Regards,
Markus
