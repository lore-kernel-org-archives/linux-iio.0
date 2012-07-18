Return-Path: <Darshan.KN@st.com>
From: Darshan Kumar NANDANWAR <Darshan.KN@st.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: "hennerich@blackfin.uclinux.org" <hennerich@blackfin.uclinux.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"dk.manit@gmail.com" <dk.manit@gmail.com>,
	Srikrishna Pramoda ATIKUKKE <srikrishna.pramodaatikukke@st.com>
Date: Wed, 18 Jul 2012 18:54:45 +0800
Subject: RE: Regarding iio-trigger   functioning
Message-ID: <D6068D304DED1F4FBFC1F56ECFA211D85BC804885C@EAPEX1MAIL1.st.com>
References: <D6068D304DED1F4FBFC1F56ECFA211D85BC80486F9@EAPEX1MAIL1.st.com>
 <500664AD.4060902@cam.ac.uk>
 <D6068D304DED1F4FBFC1F56ECFA211D85BC80487FF@EAPEX1MAIL1.st.com>
 <50068CD4.8070202@cam.ac.uk> <50068DD9.6060006@cam.ac.uk>
In-Reply-To: <50068DD9.6060006@cam.ac.uk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

> When you say internal do you mean in a soc or internal as in you can't
> point us to a datasheet?  Obviously if you can, a datasheet would
> save a lot of confusion rather than you having to repeat lots of
> it in this thread!

Yes , Indeed Datasheet could have saved a lot of fuss. But due to some Comp=
any's policy , i can't put it here.  But its just 10:8 ADC , nothing else..=
. Which has two interrupts coming out of it.. One is EOC (end of conversion=
) and another is AWDT(analog watch dog timer) ..

EOC: will be generated for each conversion , whether voltage is reference v=
oltage on any of the channel or fluctuated one...
AWDT: will be generated once voltage fluctuates between min and max .=20

EOC will not be of use for me as It will generate thousands of time dependi=
ng upon clock frequency.(that's what i am going for polling ) . and AWDT do=
esn't come to my CPU , instead its fed to other cpu which is not of use to =
me..=20

I guess it gives the clearer  picture now.. Nevertheless , if you want more=
 stuffs which can help in designing , i will surely tell you...







> -----Original Message-----
> From: Jonathan Cameron [mailto:jic23@cam.ac.uk]
> Sent: 18 July 2012 15:50
> To: Darshan Kumar NANDANWAR
> Cc: hennerich@blackfin.uclinux.org; linux-iio@vger.kernel.org;
> dk.manit@gmail.com; Srikrishna Pramoda ATIKUKKE
> Subject: Re: Regarding iio-trigger functioning
>=20
> On 7/18/2012 11:15 AM, Jonathan Cameron wrote:
> > On 7/18/2012 10:28 AM, Darshan Kumar NANDANWAR wrote:
> >> Jonathan,
> >>> Just out of curiousity, which ADC are you working with?  Also
> >>> please note that questions such as this are best posted to the
> >>> mailing list. Everyone started from scratch once, hence there are
> >>> lots of people who might help on there! linux-iio@vger.kernel.org.
> >>> Basically if there is no particularly strong reason to keep things
> >>> confidential they should be on the list.
> >>
> >> Thanks for your precious explanations.. I am working on ST's
> Internal
> >> Low Bandwidth ADC having  10bit resolution with 8 Input Analog
> >> channels ..
> When you say internal do you mean in a soc or internal as in you can't
> point us to a datasheet?  Obviously if you can, a datasheet would
> save a lot of confusion rather than you having to repeat lots of
> it in this thread!
>=20
>   But has different requirement... Every channel connects
> >> to different devices(sensors,key scanner,SCART etc ) with the
> >> reference voltage will be different (~2V-5V)-can be changed
> >> on-the-fly .
> > So far not that weird which is good...
> >> So every  Analog channel  had to be configured within
> >> (conversion_cycle_per_channel+ some buffer_jiffies) ..
> > Step one. Is there actually a use case for changing an individual
> > channels reference voltage all that often? A fair bit of kit can do
> > this, but to pull it off in software you'll need to effectively run
> > a triggered DAC alongside the adc and it'll get really fiddly.
> > Or having read more of your supply are you saying that we actually
> have
> > a mux and so only sample one channel at a time (and hence have to
> change
> > the reference voltage etc)?
> >>  So my choice
> >> to design this is to use IIO subsystem.. But until i know this
> >> subsystem i will not be able to start   writing this...Meanwhile , i
> >> have copied maillist too ...
> > Sure.
> >
> >>
> >>> Note that a lot of triggers are from the devices themselves and
> >>> hence lie in the relevant drivers.. (data ready signals typically
> >>> on devices with their own clocking).
> >>
> >> Yes ,  May be in IIO terminology this is trigger , but from device
> >> point of  view these can be called interrupts viz . EOC  or analog
> >> watchdog interrupts. Right?
> > Indeed. Sometimes these are inttrupts, sometimes they are other
> things
> > entirely (e.g. input from userspace).  The terminology comes from
> > oscilloscopes where a trigger is what causes data capture to occur.
> >>
> >>
> >>> the interrupt routine fires off sub interrupts for any devices that
> >>> have attached to it (attachment usually done by name from userspace
> >>> - poke the trigger name into iio:deviceX/trigger/current_trigger
> >>> iirc).
> >> True..
> >>
> >>> These ADCs register interrupt handlers for the subirqs and it is
> >>> these that grab the data form the adc and push it into the buffers.
> >>> Current tree has pushing only to a single buffer, but there are
> >>> patches on the mailing list to do it to multiple buffers (handy for
> >>> bridging to other subsytems).
> >>
> >> ADCs are registering interrupt_handler for their Interrupt_lines
> >> right?
> > Yes if they are data ready type interrupts). These typically feed
> > triggers which in turn cause this adc (and sometime other devices)
> > to capture.
> >    And during the iio_allocate_trigger call, which in turn being
> >> called from  trigger_initialisation (referring at91_adc.c) we are
> >> doing following : irq_set_handler(trig->subirq_base + i,
> >> &handle_simple_irq);
> >>
> >> Its the generic handler for all sub_irqs.. Now during
> >> data_ready_signal or eoc , they are calling
> >> iio_trigger_poll(idev->trig, iio_get_time_ns(),if buffer is
> enabled);
> >> .. which is going to call nothing but handle_simple_irq ... But
> still
> >> when i go through this call , i see  action->handler(irq,
> >> action->dev_id); is getting called.this must be someone which you
> are
> >> pointing out.. SO far no real handler is registered which is
> >> capturing the data from ADC and  putting  the content into buffer .
> >> But during ring_buffer setup , capture(bottom_half) and
> >> hard_handler(top half) is given which are going to form
> poll_function
> >> , which is going to  be called when i do echo 1 >
> >> /sys/bus/iio/devices/iio\:device0/buffer/enable along with preenable
> >> , and postenable callbacks.. during the postenable this poll_func is
> >> getting called which is running in trigger's irq context ,right?
> > Not during post enable it isn't. That will just be setting it up as
> the
> > interrupt handler.
> >   So
> >> where does the subirq specific handlers are coming into play?
> > They are wrapped up entirely so you shouldn't care about them.
> > Trigger fires all enabled subirqs.  ONE of these triggers has the
> > pollfunc stuff registered to handle it.  So the subirq handlers are
> > the pollfunc stuff.
> >   And
> >> whats the usage? Please comment on my understanding too..
> > subirq handled by pollfunc.   So conceptually a trigger is causing a
> > device to be polled for data.
> >>
> >> For my ADC , i am prohibited to work on interrupts mechanism (EOC
> >> etc) , instead i will use polling for my device (if needed )... but
> i
> >> want to generate one soft_interrupt after
> >> (conversion_cycle+buffer_jiffies) to capture the data from device
> and
> >> sleep for next cycle...
> > So you are really dead reckoning when the capture is done?  That is
> > fine. Look at how the sysfs-trigger works - that will show you how
> > to do a soft interrupt fire and cause capture to happen and you can
> > have whatever timing you like on the trigger.  Also are we capturing
> > all channels on each of these cycles, or just one of them?
> >
> > If just one channel per 'trigger' you have three options
> > 1) register separate iio devices for each channel (thus letting you
> don
> > any scheduling you like).
> > 2) Enforce some constraints such as all enabled channels wil be
> sampled
> > in a fixed order. E.g. 0123 - sleep - 0123 - sleep - 0123
> > Then your trigger will be for the set (and the timing between
> individual
> > samples will be entirely hidden inside your driver).
> > 3) If it's slow don't do a buffered interface at all - do it all
> through
> > the sysfs interface and do stuff on demand.
> >
> >
> >>
> >>
> >> I hope , i sound legitimate..  Please make me come out of above
> >> doubts..
> >>
> >> Thanks Darshan
> >>
> >>
> >>
> >>
> >>
> >>
> >> -----Original Message----- From: Jonathan Cameron
> >> [mailto:jic23@cam.ac.uk] Sent: 18 July 2012 12:54 To: Darshan Kumar
> >> NANDANWAR
> >> Cc: hennerich@blackfin.uclinux.org
> >> Subject: Re: Regarding iio-trigger functioning
> >>
> >> On 7/18/2012 5:56 AM, Darshan Kumar NANDANWAR wrote:
> >>> Jonathan/Hennerich ,
> >>>
> >>>       I am trying to use IIO subsystem for one of my  ADC with
> quite
> >>> different functions.  So   traversing the code . There are few
> doubts
> >>> regarding triggers which are placed in
> *drivers/staging/iio/trigger/
> >>> directory..*
> >> Note that a lot of triggers are from the devices themselves and
> hence
> >> lie in the relevant drivers.. (data ready signals typically on
> devices
> >> with their own clocking).
> >>>
> >>> *Lets say example of iio-trig-bfin-timer.c:*
> >>>
> >>> **
> >>>
> >>> =D8*How this trigger is going to communicate with actual device (say
> >>> ADC)?*
> >> the interrupt routine fires off sub interrupts for any devices that
> have
> >> attached to it (attachment usually done by name from userspace -
> poke
> >> the trigger name into iio:deviceX/trigger/current_trigger iirc).
> >> Thus multiple ADCs or similar can run off a single trigger.
> >> These ADCs register interrupt handlers for the subirqs and it is
> these
> >> that grab the data form the adc and push it into the buffers.
> Current
> >> tree has pushing only to a single buffer, but there are patches on
> the
> >> mailing list to do it to multiple buffers (handy for bridging to
> other
> >> subsytems).
> >>>
> >>> =D8*What i see: this timer will have IRQ handler  for  its IRQ  and
> IRQ
> >>> handler implementation is  like following in this driver:*
> >>>
> >>> **
> >>>
> >>> **
> >>>
> >>> *static irqreturn_t iio_bfin_tmr_trigger_isr(int irq, void *devid)*
> >>>
> >>> *{*
> >>>
> >>> *        struct bfin_tmr_state *st =3D devid;*
> >>>
> >>> **
> >>>
> >>> *        clear_gptimer_intr(st->t->id);*
> >>>
> >>> *        iio_trigger_poll(st->trig, 0);*
> >>>
> >>> **
> >>>
> >>> *        return IRQ_HANDLED;*
> >>>
> >>> *}*
> >>>
> >>> **
> >>>
> >>> **
> >>>
> >>> **
> >>>
> >>> *Where iio_trigger_poll will be working on subirqs assigned to
> >>> consumers..  Unfortunately i am not able to establish the link
> between
> >>>     how does  this trigger yields  me to  capture the data from
> ring
> >>> buffer , as i don't see any such implementation in this trigger's
> ISR
> >>> routine?*
> >> The subirqs are not for 'consumers' but rather drive either
> retrieving
> >> the data from the adc or initiate the capture.  Then the data is
> pushed
> >> into buffers and on to consumers.
> >>
> >> The adc capture logic lies in the adc driver not the trigger driver
> >> (often they are the same driver, but as you've gone with blackfin
> timer
> >> they aren't here).
> >>>
> >>> **
> >>>
> >>> *Please provide me insight into this , so that i can  use this
> subsystem
> >>> to wrire a driver for my ADC...*
> >> Just out of curiousity, which ADC are you working with?  Also please
> >> note that questions such as this are best posted to the mailing
> list.
> >> Everyone started from scratch once, hence there are lots of people
> who
> >> might help on there! linux-iio@vger.kernel.org.  Basically if there
> is
> >> no particularly strong reason to keep things confidential they
> should be
> >> on the list.
> >>>
> >>> **
> >>>
> >>> **
> >>>
> >>> *Thanks*
> >>>
> >>> *Darshan Kumar*
> >>>
> >>> **
> >>>
> >>> **
> >>>
> >>
> >>
> >
> >
>=20
