Return-Path: <pshah.mumbai@gmail.com>
MIME-Version: 1.0
In-Reply-To: <4DBBDFE7.5060207@cam.ac.uk>
References: <BANLkTikjnjSRtDRBHjXeMfHAOEsVzkkwag@mail.gmail.com> <4DBBDFE7.5060207@cam.ac.uk>
From: Prashant Shah <pshah.mumbai@gmail.com>
Date: Sat, 30 Apr 2011 21:23:52 +0530
Message-ID: <BANLkTinejkJViZ_tX8QyivPh14nzVNfjWA@mail.gmail.com>
Subject: Re: drivers for usb daq card
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Hello,

On Sat, Apr 30, 2011 at 3:39 PM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
> On 04/30/11 08:33, Prashant Shah wrote:
>> Hi,
>> I was initially trying to do that with the comedi based system but I
>> was suggest to try working with the IIO sub system.
> That's curious. I was going to suggest you looked at comedi!
> Out of interest, what was the reason given?

http://lists.kernelnewbies.org/pipermail/kernelnewbies/2011-April/001616.ht=
ml

>> I am newbie so I dont want to do something that will be hard
>> for me to work with :)
> Two initial questions. =A0Do you have the full docs? NI haven't been
> helpful to my requests in the past (which has put me off ever using
> their kit again).

I dont have any docs other than what is available on their website. Is
it possible to track the usb traffic and work with that. The device
that I am working with in pretty basic and we are interested in only
the getting the analog input data for the time being.

> Secondly, why does this want to be in kernel space?

There are few similar devices in the staging/comedi/drivers area. I am
just following them! I dont know whether comedi can work with libusb.

Thanks.
