Return-Path: <anish198519851985@gmail.com>
Subject: Re: adc-jack-driver opinion related to IIO
From: anish kumar <anish198519851985@gmail.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
In-Reply-To: <4FF6E766.7000503@cam.ac.uk>
References: 
	 <CAK7N6voPsDGJLoh71Kgcz=bnWDE4QYmXjOrMv0x+bN7RTCHF3g@mail.gmail.com>
	 <4FF6E766.7000503@cam.ac.uk>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 06 Jul 2012 22:15:54 +0530
Message-ID: <1341593155.1533.24.camel@anish-Inspiron-N5050>
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Fri, 2012-07-06 at 14:25 +0100, Jonathan Cameron wrote:
> On 7/6/2012 1:00 PM, anish singh wrote:
> > Hello Jonathan,
> >
> > I would be extremely happy if I can get your opinion on this.
> >
> > Recently Myungjoo Ham had posted Extcon: adc-jack driver patch.
> >
> > Description of this driver:
> > This is basically a Headset(jack) driver.Once the headset is inserted
> > a irq_handler is called and in this handler we have a callback(this
> > callback calls into pmic driver to get the adc value) to get
> > the adc value to determine the kind of headset: This headset could
> > be headset with mic, headset without mic or headset with
> > keys(volume-up/down) attached to it.One we have found out the kind
> > of headset we use extcon framework to notify the other interested drivers or
> > userspace that a headset with so and so capabilities has been inserted.
> >
> > Question:
> > Does this driver fall into IIO as pointed by Mark Brown in his review comments?
> The driver itself probably doesn't, but the adc part does in that IIO
> provides a means of talking to the relevant adc.
> >
> > Why do we need to use IIO to get the adc value?As for different boards the
> > method of getting adc is different.How does IIO help in this?
> Ultimately, IIO in this case is acting as an infrastructure for ALL 
> adcs. E.g. for different boards you'll need a mapping to tell it which
> adc channel is connected but that is it.  Hence you don't need a 
> specific callback for each pmic as you will be using generic interfaces 
> to query it.
After having a brief glance at IIO below is my understanding:
IIO is used to provide standard interfaces in the form of sysfs to
userspace _ONLY_.

My requirement:
ADC-JACK-Driver should get the adc value from other driver i.e. PMIC
driver.Here the requirement is communication between two drivers in
kernel.Can IIO be used here?

I had a look at drivers/staging/iio/Documentation/Overview.txt and some
ADC drivers.
> 
> Jonathan
