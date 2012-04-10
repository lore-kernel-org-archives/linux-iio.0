Return-Path: <omaplinuxkernel@gmail.com>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.01.1204101115470.17667@pmeerw.net>
References: <alpine.DEB.2.01.1204101115470.17667@pmeerw.net>
Date: Tue, 10 Apr 2012 15:30:55 +0530
Message-ID: <CAM=Q2csVsYXEvhN7v8SK4R=UpaEW2ELBmx42TcwpFMs_j6-5xg@mail.gmail.com>
Subject: Re: proximity sensor, input
From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Hi Peter,

Can you explain more about how your proximity device is?
How does it report through gpio / irq etc ?

Thanks,
Shubhro



On Tue, Apr 10, 2012 at 3:17 PM, Peter Meerwald <pmeerw@pmeerw.net> wrote:
> Hello,
>
> I am wondering how to support proximity sensors; goal is to trigger some
> application event when an object comes close (in that sense, the proximit=
y
> sensor is used like a button)
>
> there are several places in the kernel doing similar things:
> e.g. input/misc/gp2ap0002a00f.c
> e.g. drivers/misc/bh1770glc.c
> e.g. drivers/staging/iio/isl29018.c
>
> iio seems to be most active and has IIO_PROXIMITY, but I do not see how
> the application is easily notified: iio collects merely collects the
> sensor data
>
> drivers in misc just create some custom sysfs interface
>
> input/misc has just one driver dealing with proximity
>
> is there some advise where proximity driver support might best fit?
>
> thanks, regards, p.
>
> --
>
> Peter Meerwald
> +43-664-2444418 (mobile)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
