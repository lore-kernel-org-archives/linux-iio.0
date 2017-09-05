Return-Path: <SRS0=B1td=AG=gmail.com=arndbergmann@kernel.org>
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <524a1c8e-93c1-d905-dc39-b154290beb86@zonque.org>
References: <be82f31ef2f0f39c7893b42dfe46c7235ea6144a.1504604178.git.lukas@wunner.de>
 <d5a12cb12480235e05315e9c8fa6e8b5f5a3dfb6.1504604178.git.lukas@wunner.de>
 <CAK8P3a2L+wOER7LwXApD_YrVA7Zi9D96FZC5zAm_+aSy+qG0rg@mail.gmail.com>
 <20170905101144.GA23808@wunner.de> <524a1c8e-93c1-d905-dc39-b154290beb86@zonque.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 5 Sep 2017 15:01:08 +0200
Message-ID: <CAK8P3a1XQBLsSmkKK75P1y6h8925L3K68v_5ARoBbEyLu3q_Fw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drivers: misc: ti_dac7512: Remove duplicate driver
To: Daniel Mack <daniel@zonque.org>
Cc: Lukas Wunner <lukas@wunner.de>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, "Andrew F. Davis" <afd@ti.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Tue, Sep 5, 2017 at 12:28 PM, Daniel Mack <daniel@zonque.org> wrote:
> On 09/05/2017 12:11 PM, Lukas Wunner wrote:
>> On Tue, Sep 05, 2017 at 11:56:02AM +0200, Arnd Bergmann wrote:
>>> On Tue, Sep 5, 2017 at 11:44 AM, Lukas Wunner <lukas@wunner.de> wrote:
> That's true, but the devices that do are EOL for a long time, and they
> don't use mainline kernels anyway, for multiple reasons. So that
> shouldn't constrain us, and I'm all for replacing that driver with
> something that has a real infrastructure.
>
>   Acked-by: Daniel Mack <daniel@zonque.org>

Ok, thanks for the confirmation. That's probably good enough to apply the
patch for 4.15. If someone else uses the driver without you knowing, they
can always complain later on and we revert the patch or think of an
alternative, but that seems unlikely.

       Arnd
