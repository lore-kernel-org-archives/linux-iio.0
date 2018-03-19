Return-Path: <SRS0=bgbc=GJ=users.sourceforge.net=elfring@kernel.org>
Subject: Re: iio/gyro/bmg160_core: Improve unlocking of a mutex in five
 functions
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Pravin Shedge <pravin.shedge4linux@gmail.com>,
 Quentin Schulz <quentin.schulz@free-electrons.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <16623de4-351d-135b-f3ff-701a465c5d92@users.sourceforge.net>
 <20180317195422.037a8b57@archlinux>
 <73f0a187-57d1-c877-ba9f-3b15f6a61640@users.sourceforge.net>
 <20180318101506.460f3967@archlinux>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <4f0c5eb0-e7c2-9c27-387a-e62b19f0578a@users.sourceforge.net>
Date: Mon, 19 Mar 2018 10:51:43 +0100
MIME-Version: 1.0
In-Reply-To: <20180318101506.460f3967@archlinux>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

>> The mutex was (and is still only) locked within case branches, isn't it?
>>
> You are correct, this does however reflect the issue with the resulting
> lack of balance here.

I suggest to reconsider affected software aspects a bit more.


> I saw the mutex was getting unlocked outside the local scope and so assumed
> that it was also take outside the local scope.

Assumptions and corresponding expectations might need further clarifications.


> That isn't true, so we have hurt readability.

Does your conclusion need any adjustment?


> I read it quickly and got the wrong idea which generally implies it is not
> as clear as we would like.
> 
> Hence this change isn't going anywhere I'm afraid.

I imagine that more time will be needed then to get used to additional adjustments
of implementation details in these functions.

Regards,
Markus
