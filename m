Return-Path: <SRS0=xl6o=2X=jic23.retrosnub.co.uk=jic23@kernel.org>
Date: Tue, 14 Mar 2017 22:44:12 +0000
In-Reply-To: <CAOCi2DEecT6tdxmz7_9Q5aWC7_+VZCKD1+Vwe9F5gA9jAuQ2=A@mail.gmail.com>
References: <1489351546-21008-1-git-send-email-gs051095@gmail.com> <alpine.DEB.2.20.1703122154130.7649@hadrien> <CAOCi2DH9bNChZj4kyt3t1eK7R7uSv77zeVc2PkPYxoRDDHZLsA@mail.gmail.com> <alpine.DEB.2.20.1703122235320.7649@hadrien> <20170312221350.GA14070@d830.WORKGROUP> <CAOCi2DEyu6_bBjsrSFzf0VcXcUnZ3LugLf==R9zsSmj+1JdFKw@mail.gmail.com> <35231dfd-af42-bbd3-3be6-4e03a728a92f@kernel.org> <73d214e0-46d0-0d4a-27e1-7c85cf3c05ed@metafoo.de> <CAOCi2DEecT6tdxmz7_9Q5aWC7_+VZCKD1+Vwe9F5gA9jAuQ2=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [Outreachy kernel] [PATCH] staging: iio: adc: Replace mlock with driver private lock
To: Gargi Sharma <gs051095@gmail.com>,Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@kernel.org>,Alison Schofield <amsfield22@gmail.com>,Julia Lawall <julia.lawall@lip6.fr>,outreachy-kernel@googlegroups.com,Michael.Hennerich@analog.com,knaack.h@gmx.de,Peter Meerwald-Stadler <pmeerw@pmeerw.net>,linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Message-ID: <38289FBC-9E24-4AC0-ADB2-58DB34DD208F@jic23.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>



On 14 March 2017 17:36:16 GMT+00:00, Gargi Sharma <gs051095@gmail=2Ecom> w=
rote:
>On Tue, Mar 14, 2017 at 2:24 AM, Lars-Peter Clausen <lars@metafoo=2Ede>
>wrote:
>> On 03/13/2017 09:51 PM, Jonathan Cameron wrote:
>> [=2E=2E=2E]
>>>>> Gargi,
>>>>>
>>>>> Please insert the new lock above the __cacheline_aligned struct
>>>>> member=2E
>>>>
>>>> I will do that, but is there any reason why the lock should be
>above
>>>> ____cacheline_aligned struct member?
>>> Yes=2E  It's in fact very important that nothing comes after that=2E
>>>
>>> Will leave the why as an exercise for the reader=2E   I'll give the
>>> hit of spi drivers that do DMA=2E=2E=2E
>>
>>
>> One hint though, the answer is somewhere in Documentation/DMA-API=2Etxt
>
>>From what I have understood is that cacheline is used for keeping most
>frequently accessed values in adjacent cachelines=2E=20

Why? What does cache line actually mean?

> We want the
>cacheline_aligned at the end in the struct definition so as to avoid
>any holes after the cacheline boundary=2E

Nope=2E  Try
http://www=2Epebblebay=2Ecom/a-guide-to-using-direct-memory-access-in-embe=
dded-systems-part-two/

(Hint, search for 'shares')

>>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger=2Ekernel=2Eorg
>More majordomo info at  http://vger=2Ekernel=2Eorg/majordomo-info=2Ehtml

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
