Return-Path: <jic23@jic23.retrosnub.co.uk>
In-Reply-To: <CAE1zot+-s9rmesdKu42=DxpbfQO2a4H0RgwD2xUyN1+DTZXPhw@mail.gmail.com>
References: <1430148841-30947-1-git-send-email-tiberiu.a.breana@intel.com> <1430148841-30947-3-git-send-email-tiberiu.a.breana@intel.com> <554B3F05.1010600@kernel.org> <CAE1zot+hMJAGr8xstZJTe_Doh=C+2Veruyo+S4Or7Y3n=gdbCQ@mail.gmail.com> <555F6D4D.5060508@kernel.org> <CAE1zot+-s9rmesdKu42=DxpbfQO2a4H0RgwD2xUyN1+DTZXPhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH v3 2/2] iio: light: Add threshold interrupt support for STK3310
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Tue, 02 Jun 2015 23:17:10 +0100
To: Octavian Purdila <octavian.purdila@intel.com>,Jonathan Cameron <jic23@kernel.org>
CC: Tiberiu Breana <tiberiu.a.breana@intel.com>,"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,Peter Meerwald <pmeerw@pmeerw.net>
Message-ID: <C3FF4439-FE28-4F20-8FE3-C7202AD8B0AA@jic23.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>



On 2 June 2015 21:47:39 BST, Octavian Purdila <octavian.purdila@intel.com> wrote:
>On Fri, May 22, 2015 at 8:54 PM, Jonathan Cameron <jic23@kernel.org>
>wrote:
>>
>> On 20/05/15 10:46, Octavian Purdila wrote:
>> > On Thu, May 7, 2015 at 1:31 PM, Jonathan Cameron <jic23@kernel.org>
>wrote:
>> >>
>> >> On 27/04/15 16:34, Tiberiu Breana wrote:
>> >>> Added interrupt support for proximity threshold events
>> >>> to the stk3310 driver.
>> >> I've not objection to the split, but also wouldn't have minded
>having
>> >> this in the original driver split (just in case you are doing it
>to make
>> >> reviewing easier - in this sort of thing it makes little
>difference!)
>> >>>
>> >>> Signed-off-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
>> >> Again, nice patch.  My only comment below is about the fact I
>should
>> >> find out what happened to the thoughts about moving the
>gpio/interrupt
>> >> setup code into ACPI to avoid having the same 10 lines in every
>driver.
>> >>
>> >
>> > Mika send another version of the patch set and it was accepted and
>> > merged into the GPIO tree:
>> >
>> > https://lkml.org/lkml/2015/5/6/281
>> Cool.  Once that has worked it's way through yets
>> have a general cleanup of the cut and paste versions we have
>throughout
>> IIO.  Anyone want to take this on?
>>
>
>I have the patches ready and I will send them once Mika's patches
>makes it into iio-dev/testing.
Cool!

Thanks for doing this.

J

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
