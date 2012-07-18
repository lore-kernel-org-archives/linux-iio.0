Return-Path: <Darshan.KN@st.com>
From: Darshan Kumar NANDANWAR <Darshan.KN@st.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: "hennerich@blackfin.uclinux.org" <hennerich@blackfin.uclinux.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"dk.manit@gmail.com" <dk.manit@gmail.com>,
	Srikrishna Pramoda ATIKUKKE <srikrishna.pramodaatikukke@st.com>
Date: Wed, 18 Jul 2012 17:28:27 +0800
Subject: RE: Regarding iio-trigger   functioning
Message-ID: <D6068D304DED1F4FBFC1F56ECFA211D85BC80487FF@EAPEX1MAIL1.st.com>
References: <D6068D304DED1F4FBFC1F56ECFA211D85BC80486F9@EAPEX1MAIL1.st.com>
 <500664AD.4060902@cam.ac.uk>
In-Reply-To: <500664AD.4060902@cam.ac.uk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan,
>Just out of curiousity, which ADC are you working with?  Also please=20
>note that questions such as this are best posted to the mailing list.
>Everyone started from scratch once, hence there are lots of people who
>might help on there! linux-iio@vger.kernel.org.  Basically if there is
>no particularly strong reason to keep things confidential they should be
>on the list.

Thanks for your precious explanations.. I am working on ST's Internal Low B=
andwidth ADC having  10bit resolution with 8 Input Analog channels .. But h=
as different requirement... Every channel connects to different devices(sen=
sors,key scanner,SCART etc ) with the reference voltage will be different (=
~2V-5V)-can be changed on-the-fly .   So every  Analog channel  had to be c=
onfigured within (conversion_cycle_per_channel+ some buffer_jiffies) ..  So=
 my choice to design this is to use IIO subsystem.. But until i know this s=
ubsystem i will not be able to start   writing this...Meanwhile , i have co=
pied maillist too ...

>Note that a lot of triggers are from the devices themselves and hence
>lie in the relevant drivers.. (data ready signals typically on devices
>with their own clocking).

Yes ,  May be in IIO terminology this is trigger , but from device point of=
  view these can be called interrupts viz . EOC  or analog watchdog interru=
pts. Right?


>the interrupt routine fires off sub interrupts for any devices that have
>attached to it (attachment usually done by name from userspace - poke
>the trigger name into iio:deviceX/trigger/current_trigger iirc).
True..=20

>These ADCs register interrupt handlers for the subirqs and it is these=20
>that grab the data form the adc and push it into the buffers.  Current
>tree has pushing only to a single buffer, but there are patches on the
>mailing list to do it to multiple buffers (handy for bridging to other
>subsytems).

ADCs are registering interrupt_handler for their Interrupt_lines right?  An=
d during the iio_allocate_trigger call, which in turn being called from  tr=
igger_initialisation (referring at91_adc.c) we are doing following :
irq_set_handler(trig->subirq_base + i, &handle_simple_irq);

Its the generic handler for all sub_irqs.. Now during data_ready_signal or =
eoc , they are calling iio_trigger_poll(idev->trig, iio_get_time_ns(),if bu=
ffer is enabled); .. which is going to call nothing but handle_simple_irq .=
.. But still when i go through this call , i see  action->handler(irq, acti=
on->dev_id); is getting called.this must be someone which you are pointing =
out.. SO far no real handler is registered which is capturing the data from=
 ADC and  putting  the content into buffer .  But during ring_buffer setup =
, capture(bottom_half) and hard_handler(top half) is given which are going =
to form poll_function  , which is going to  be called when i do echo 1 > /s=
ys/bus/iio/devices/iio\:device0/buffer/enable along with preenable , and po=
stenable callbacks.. during the postenable this poll_func is getting called=
 which is running in trigger's irq context ,right? So where does the subirq=
 specific handlers are coming into play? And whats the usage? Please commen=
t on my understanding too..

For my ADC , i am prohibited to work on interrupts mechanism (EOC etc) , in=
stead i will use polling for my device (if needed )... but i want to genera=
te one soft_interrupt after (conversion_cycle+buffer_jiffies) to capture th=
e data from device and sleep for next cycle...=20


I hope , i sound legitimate..  Please make me come out of above doubts..

Thanks
Darshan=20






-----Original Message-----
From: Jonathan Cameron [mailto:jic23@cam.ac.uk]=20
Sent: 18 July 2012 12:54
To: Darshan Kumar NANDANWAR
Cc: hennerich@blackfin.uclinux.org
Subject: Re: Regarding iio-trigger functioning

On 7/18/2012 5:56 AM, Darshan Kumar NANDANWAR wrote:
> Jonathan/Hennerich ,
>
>      I am trying to use IIO subsystem for one of my  ADC with quite
> different functions.  So   traversing the code . There are few doubts
> regarding triggers which are placed in *drivers/staging/iio/trigger/
> directory..*
Note that a lot of triggers are from the devices themselves and hence
lie in the relevant drivers.. (data ready signals typically on devices
with their own clocking).
>
> *Lets say example of iio-trig-bfin-timer.c:*
>
> **
>
> =D8*How this trigger is going to communicate with actual device (say ADC)=
?*
the interrupt routine fires off sub interrupts for any devices that have
attached to it (attachment usually done by name from userspace - poke
the trigger name into iio:deviceX/trigger/current_trigger iirc).
Thus multiple ADCs or similar can run off a single trigger.
These ADCs register interrupt handlers for the subirqs and it is these=20
that grab the data form the adc and push it into the buffers.  Current
tree has pushing only to a single buffer, but there are patches on the
mailing list to do it to multiple buffers (handy for bridging to other
subsytems).
>
> =D8*What i see: this timer will have IRQ handler  for  its IRQ  and IRQ
> handler implementation is  like following in this driver:*
>
> **
>
> **
>
> *static irqreturn_t iio_bfin_tmr_trigger_isr(int irq, void *devid)*
>
> *{*
>
> *        struct bfin_tmr_state *st =3D devid;*
>
> **
>
> *        clear_gptimer_intr(st->t->id);*
>
> *        iio_trigger_poll(st->trig, 0);*
>
> **
>
> *        return IRQ_HANDLED;*
>
> *}*
>
> **
>
> **
>
> **
>
> *Where iio_trigger_poll will be working on subirqs assigned to
> consumers..  Unfortunately i am not able to establish the link between
>    how does  this trigger yields  me to  capture the data from ring
> buffer , as i don't see any such implementation in this trigger's ISR
> routine?*
The subirqs are not for 'consumers' but rather drive either retrieving
the data from the adc or initiate the capture.  Then the data is pushed
into buffers and on to consumers.

The adc capture logic lies in the adc driver not the trigger driver=20
(often they are the same driver, but as you've gone with blackfin timer
they aren't here).
>
> **
>
> *Please provide me insight into this , so that i can  use this subsystem
> to wrire a driver for my ADC...*
Just out of curiousity, which ADC are you working with?  Also please=20
note that questions such as this are best posted to the mailing list.
Everyone started from scratch once, hence there are lots of people who
might help on there! linux-iio@vger.kernel.org.  Basically if there is
no particularly strong reason to keep things confidential they should be
on the list.
>
> **
>
> **
>
> *Thanks*
>
> *Darshan Kumar*
>
> **
>
> **
>
