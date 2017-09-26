Return-Path: <SRS0=KiKQ=A3=jic23.retrosnub.co.uk=jic23@kernel.org>
Date: Tue, 26 Sep 2017 08:42:16 +0100
In-Reply-To: <20170926073640.GA8850@kroah.com>
References: <20170926080508.740a6158@archlinux> <20170926073640.GA8850@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [PATCH] iio:stm32-lp-timer and ep93xx: drop assign iio_info.driver_module and iio_trigger_ops.owner
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org,Stephen Rothwell <sfr@canb.auug.org.au>
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Message-ID: <D29D6C71-9C49-42F1-99DE-FC4A6DD9C0B2@jic23.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>



On 26 September 2017 08:36:40 BST, Greg Kroah-Hartman <gregkh@linuxfoundat=
ion=2Eorg> wrote:
>On Tue, Sep 26, 2017 at 08:05:08AM +0100, Jonathan Cameron wrote:
>>=20
>> The equivalent of both of these are now done via macro magic when
>> the relevant register calls are made=2E  The actual structure
>> elements have gone away=2E
>>=20
>> Signed-off-by: Jonathan Cameron <Jonathan=2ECameron@huawei=2Ecom>
>
>You forgot a "Reported-by:" tag here, I'll go add it by hand :)

Doh! Sorry Stephen and thanks Greg=2E

Jonathan
>
>thanks,
>
>greg k-h

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
