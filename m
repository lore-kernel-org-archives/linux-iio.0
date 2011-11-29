Return-Path: <rubini@mail.gnudd.com>
Date: Tue, 29 Nov 2011 15:44:49 +0100
From: Alessandro Rubini <rubini@gnudd.com>
To: michael.hennerich@analog.com
Cc: lars@metafoo.de, jic23@kernel.org, federico.vaga@gmail.com,
        linux-iio@vger.kernel.org, greg@kroah.com,
        device-drivers-devel@blackfin.uclinux.org
Subject: Re: ZIO wiki analysis of IIO and why it doesn't meet there
 requirements [was Re: Industrial Input Output analysis]
Message-ID: <20111129144449.GA14261@mail.gnudd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: rubini@gnudd.com
In-Reply-To: <4ED4D611.7030701@analog.com>
References: <4ED4D611.7030701@analog.com>  <4ED36B93.5020703@metafoo.de>
  <CAH5GJ0qTW_DwaAVhe6ZjGYg=1CPPVuQQn3biyg+2BuYHp1Hefw@mail.gmail.com>
 <4ED21960.1000002@kernel.org> <20111129110013.GA27762@mail.gnudd.com>
List-ID: <linux-iio@vger.kernel.org>

Hello.

> Right now we use IIO to capture single work loads at 250MSPS.
> User space requests - let's say 1M samples, the IIO driver captures and 
> returns data to user space.
> (sounds a bit similar to your use case)

Yes, it's similar.

> Hardware is a Virtex6 FPGA, microblaze softcore running Linux and the 
> converter is a AD9467
> on an FMC-LPC card.

That's similar too. Is the code available somewhere?
 
> The per-sample buffer implementations in IIO are purely optional!
> You can build your own buffer implementation by using the 
> INDIO_BUFFER_HARDWARE flag.

We noticed that flag, but the implementation seemed empty. Actually I
now checked and there are two users, so I'll look better how it is.

I still note that our code is way simpler. We don't deny special
buffers, but they are only needed for dma-aware user space (something
that IIO currently isn't offering even for BUFFER_HARDWARE things).

> But I'm pretty optimistic that there is nothing in IIO which
> prevents me from getting the right solution in place.

No, definitely. We'll keep our eyes open on the project, maybe the
final choice will be IIO for our use case, but it's too early to know.
 
> Ideally there is only one subsytem, and not one targeting low-speed
> and another for high speed.

I disagree. If you were right, iio woudn't be in the kernel, as comedi
was already there. (This doesn't mean I am pushing for in-kernel zio
at this point in time).

Thank you for the information
/alessandro
