Return-Path: <SRS0=xsH8=BD=jic23.retrosnub.co.uk=jic23@kernel.org>
Date: Wed, 04 Oct 2017 21:53:07 +0100
In-Reply-To: <20171004195037.GB9195@wunner.de>
References: <cover.1504807204.git.lukas@wunner.de> <77df087e5d4a8954b3a7e019372884b877583558.1504807204.git.lukas@wunner.de> <20170910171514.714abfdd@archlinux> <20171004195037.GB9195@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [PATCH v2 5/6] iio: adc: mcp320x: Add support for mcp3550/1/3
To: Lukas Wunner <lukas@wunner.de>,Jonathan Cameron <jic23@kernel.org>
CC: Hartmut Knaack <knaack.h@gmx.de>,Lars-Peter Clausen <lars@metafoo.de>,Peter Meerwald-Stadler <pmeerw@pmeerw.net>,Mathias Duckeck <m.duckeck@kunbus.de>,Phil Elwell <phil@raspberrypi.org>,Oskar Andero <oskar.andero@gmail.com>,Andrea Galbusera <gizero@gmail.com>,Akinobu Mita <akinobu.mita@gmail.com>,Manfred Schlaegl <manfred.schlaegl@gmx.at>,Michael Welling <mwelling@ieee.org>,Soeren Andersen <san@rosetechnology.dk>,linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Message-ID: <1EB45962-79DA-41DF-ACB7-68D820710B88@jic23.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>



On 4 October 2017 20:50:37 BST, Lukas Wunner <lukas@wunner=2Ede> wrote:
>On Sun, Sep 10, 2017 at 05:15:14PM +0100, Jonathan Cameron wrote:
>> On Sat, 9 Sep 2017 20:32:41 +0200 Lukas Wunner <lukas@wunner=2Ede>
>wrote:
>> > These ADCs are marketed as single-channel 22 bit delta-sigma ADCs,
>but
>> > in reality their resolution is 21 bit with an overrange or
>underrange
>> > of 12% beyond Vref=2E  In other words, "full scale" means +/- 2^20=2E
>[snip]
>>=20
>> Excellent=2E  Applied to the togreg branch of iio=2Egit and pushed out =
as
>> testing=2E
>
>Just a gentle reminder, this patch isn't on your kernel=2Eorg branches
>yet=2E
>I assumed the reason was a dependency / merge conflict with my two
>patches
>on the fixes-togreg branch and you were waiting for them to be in
>upstream=2E
>They have landed in Linus' tree yesterday, I'm not sure if anything
>else is
>necessary (backmerge or some such)=2E
>
>Thanks,
>
>Lukas

Will investigate=2E  Odd that I didn't mention waiting for dependencies=2E=
=2E=2E  If necessary it may
 be another week or so for it to propagate back to the IIO tree=2E

Jonathan

>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger=2Ekernel=2Eorg
>More majordomo info at  http://vger=2Ekernel=2Eorg/majordomo-info=2Ehtml

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
