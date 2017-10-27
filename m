Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.web.de ([217.72.192.78]:50823 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752016AbdJ0KQR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 27 Oct 2017 06:16:17 -0400
Subject: Re: iio/accel/stk8312: Improve unlocking of a mutex in two functions
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <ae9d7e7f-541e-ce0c-1d41-6b9793c98f78@users.sourceforge.net>
 <20171026170913.5ff10718@archlinux>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <c2620449-b80a-f0ef-c0d2-92d0c7fb4906@users.sourceforge.net>
Date: Fri, 27 Oct 2017 12:15:54 +0200
MIME-Version: 1.0
In-Reply-To: <20171026170913.5ff10718@archlinux>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> In the second case, the jump backwards just makes the code harder
> to read than it currently is.

Maybe …

But I proposed an other source code layout for useful reasons.


> There is no firm rule about error handling in one place.

There are some design options available.


> If it leads to more complex flow as here, don't do it.

I would appreciate to clarify such a view a bit more.
How would you like to achieve a complete and efficient
exception handling in shown places?

Regards,
Markus
