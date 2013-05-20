Return-Path: <denis.ciocca@st.com>
From: Denis CIOCCA <denis.ciocca@st.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Denis Ciocca <denis.ciocca@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Mon, 20 May 2013 09:54:37 +0200
Subject: Re: Use buffer without trigger
Message-ID: <2222129.ltZC4niTHM@ctocwl0124>
References: <CAEE_umrLpNJo1kMbLtktK0RH6WCKCEYR+yiTiyPJu_8G3coE7A@mail.gmail.com>
 <5196280C.8070909@metafoo.de> <519755D6.10000@kernel.org>
In-Reply-To: <519755D6.10000@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Saturday, May 18, 2013 12:20:06 PM Jonathan Cameron wrote:
> On 05/17/2013 01:52 PM, Lars-Peter Clausen wrote:
> > On 05/17/2013 02:34 PM, Denis CIOCCA wrote:
> >>> Yes, but you still have to assign the trigger to the device in sysfs.
> >>=20
> >> Ok but I have to use a dummy trigger for every device?
> >>=20
> >> Denis
> >=20
> > No. Allocate your buffers and allocate your one trigger. Before you can
> > enable your buffer you need to assign the trigger to the buffer in sysf=
s
> > (By writing to trigger/current_trigger).
>=20
> Lots of the ADC drivers do this.  See max1363 for example. No sign a trig=
ger
> but it definitely has a buffer.  Often these parts convert on demand but
> can do it at very high rates.

Ok, I will look!

Thanks Jonathan & Lars,

Denis=
