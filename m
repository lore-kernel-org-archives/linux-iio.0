Return-Path: <pthomas8589@gmail.com>
MIME-Version: 1.0
In-Reply-To: <4E48EC6D.5090102@cam.ac.uk>
References: <1313353117-25140-1-git-send-email-pthomas8589@gmail.com>
	<4E48EC6D.5090102@cam.ac.uk>
Date: Mon, 15 Aug 2011 08:57:11 -0700
Message-ID: <CAD56B7dVPpUB4twdYOdNx-pNMFVuxRANfNOjvqJV0Z357e_qQQ@mail.gmail.com>
Subject: Re: [PATCH] iio: [v2] add support for Analog Devices ad7194 a/d converter
From: Paul Thomas <pthomas8589@gmail.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On Mon, Aug 15, 2011 at 2:52 AM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
> On 08/14/11 21:18, Paul Thomas wrote:
>> This uses the iio sysfs interface, and inculdes gain
> includes
>
> Couple of left over bits from chan_spec conversion that need
> cleaning up and a that gain attribute wants to be done via the
> scale_shared chan_info element instead.
OK, most of that makes sense. I might have more questions latter, but
one question for now. You say to use the scale_shared for the gain
(can you point do a good example of this?)  I just want to make sure
we're on the same page as to what the gain is doing. It's really just
setting the range of the voltage input I scale the result back down to
volts. So if the input voltage is 0.2V you get 0.2V Whether you set
the gain to 1 or 8

thanks,
Paul
