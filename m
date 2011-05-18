Return-Path: <jic23@cam.ac.uk>
Message-ID: <4DD39989.7000602@cam.ac.uk>
Date: Wed, 18 May 2011 11:03:53 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "Hennerich, Michael" <Michael.Hennerich@analog.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 Drivers <Drivers@analog.com>,
 "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>
Subject: Re: IIO-onwards
References: <544AC56F16B56944AEC3BD4E3D5917713AAF21C49E@LIMKCMBX1.ad.analog.com> <4DD385B2.9070809@cam.ac.uk>
In-Reply-To: <4DD385B2.9070809@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 05/18/11 09:39, Jonathan Cameron wrote:
> On 05/18/11 08:58, Hennerich, Michael wrote:
>> Hi Jonathan,
>>
>> What are your plans for submitting IIO-onwards?
> It would have gone about a weak ago, but Thomas Gleixner wants some slight
> tweaks to the irq core exports patch that about 50% of 
> our tree is dependent on.  Getting this sorted is being slowed down by (I think)
> the fact Thomas is travelling at the moment and seems to only have
> intermittent email access. The outstanding issue is that irq_to_descs
> should not be exported, but rather handle_generic_irq shouldn't
> be inline.  I'm waiting on a reply for where it should go as it
> doesn't obviously fit in any of the files under kernel/irq/.
> 
> Greg knows what the situation is, so fingers crossed that we can
> get it cleared up in time to catch the merge window.
> 
> I think I'll just plump for a vaguely reasonable location for the code
> and hope I guessed right as that will speed things up a touch and can't
> do any harm!
I've just pushed out exactly what I aim to send to Greg the moment
Thomas acks the irq element (or says he is pulling it via his tree).

Other than updates to that irq patch, I've cleaned up some commit
messages so it all looks nice and tidy ;)
