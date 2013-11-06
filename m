Return-Path: <pmeerw@pmeerw.net>
Date: Wed, 6 Nov 2013 21:16:00 +0100 (CET)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
cc: Dongsoo Nathaniel Kim <dongsoo.kim@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: About MLX90620 thermal array sensor (IR sensor)
In-Reply-To: <69adfeb3-ef16-4cd4-a32b-db7be3b1b90b@email.android.com>
Message-ID: <alpine.DEB.2.01.1311062103580.31752@pmeerw.net>
References: <CAP+Vy9cm0apYAzEEV0mYn=2-Pq88eyZqR5_ERbd-Deto6c0cpg@mail.gmail.com> <69adfeb3-ef16-4cd4-a32b-db7be3b1b90b@email.android.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

Hello,

> >Here is the datasheet of this device:
> >http://www.melexis.com/Asset/Datasheet-IR-thermometer-16X4-sensor-array-MLX90620-DownloadLink-6099.aspx
> Interesting little device.

indeed

> Another interesting question is whether array sensors like this should 
> be handled as cameras or whether IIO makes more sense.
> If in IIO we need to think about how to handle the array coordinates.

one could just expose 64 IR channels and the temperature and leave the 
(complicated) calculations to user space, shouldn't be too hard (hope iio 
can handle 64+ channels :)

I think it is not worth to expose the array layout / coordinates

channels scan masks (i.e. which channels can be combined in a buffered 
read) are not discoverable as well I think (except trial-and-error)

regards, p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
