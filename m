Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:59283 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932127AbdJZRJb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 26 Oct 2017 13:09:31 -0400
Subject: Re: iio/accel/stk8ba50: Use common error handling code in
 stk8ba50_probe()
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Tiberiu Breana <tiberiu.a.breana@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <5ab7e200-2dea-63e2-06db-0e185f563d16@users.sourceforge.net>
 <0f26a13b-7bbf-525b-a864-8aa8e13c3aef@users.sourceforge.net>
 <20171026174200.5c00b06d@archlinux>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <c7ee7221-3feb-1e6c-5e57-abec8c350330@users.sourceforge.net>
Date: Thu, 26 Oct 2017 19:09:09 +0200
MIME-Version: 1.0
In-Reply-To: <20171026174200.5c00b06d@archlinux>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> Again, a general kernel development rule is to float only one
> patch of a given type until you have had feedback on it.

Some update suggestions according also to this general source code
transformation pattern were already integrated in other software areas.


> These backwards goto cases are sufficiently different from your earlier
> patch that got reviews that,

They are required if you would ever like to support software refactorings
in directions which I propose occasionally.


> at most, you should have sent one to the list and then given time
> for it to be properly reviewed (up to a week on IIO list typically).

Did I present my ideas a bit too quick in this case?

Regards,
Markus
