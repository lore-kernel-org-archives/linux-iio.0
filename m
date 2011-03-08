Return-Path: <tglx@linutronix.de>
Date: Tue, 8 Mar 2011 11:30:54 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
cc: LKML <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: Moving staging:iio over to threaded interrupts.
In-Reply-To: <4D6FCC99.6090202@cam.ac.uk>
Message-ID: <alpine.LFD.2.00.1103081055160.2787@localhost6.localdomain6>
References: <4D6FCC99.6090202@cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

On Thu, 3 Mar 2011, Jonathan Cameron wrote:
> So to my mind two solutions exist.
> 1) A single thread per trigger.  Everything prior to the work queue
> calls is moved into a handler that goes in the 'fast' list which stays
> in our top half handler.  The work queue bits are called one after
> another in the bottom half.
> 
> 2) Allow each consumer to attach it's own thread to the trigger
> controller and basically implement our own variant of the core threaded
> interrupt code that allows for a list of threads rather than a single one.
> 
> I rather like the idea of 2.  It might even end up with different
> devices being queried from different processor cores simultaneously
> which is quite cute.  The question is whether a simple enough
> implementation is possible that the originators of the threaded interrupt
> code would be happy with it (as it bypasses or would mean additions to their
> core code).

Don't implement another threading model. Look at the trigger irq as a
demultiplexing interrupt. So if you have several consumers of a single
trigger, then you can implement a pseudo irq_chip and register the sub
devices as separate interrupts.

That means your main trigger interrupt would look like this:

irqreturn_t hardirq_handler(int irq, void *dev)
{
     iio_trigger_dev *idev = dev;
     int i;

     store_state_as_necessary(idev);

     for (i = 0; i < idev->nr_subirqs; i++) {
     	    if (idev->subirqs[i].enabled)
		generic_handle_irq(idev->subirq_base + i);
     }
}

And you'd have an irq_chip implementation which does:

static void subirq_mask(struct irq_data *d)
{
     iio_trigger_dev *idev = irq_data_get_irq_chip_data(d);
     int idx = d->irq - idev->subirq_base;

     idev->subirqs[idx].enabled = false;
}

static void subirq_unmask(struct irq_data *d)
{
     iio_trigger_dev *idev = irq_data_get_irq_chip_data(d);
     int idx = d->irq - idev->subirq_base;

     idev->subirqs[idx].enabled = true;
}

static struct irq_chip subirq_chip = {
       .name = "iiochip",
       .mask = subirq_mask,
       .unmask = subirq_unmask,
};

init()
{
	for_each_subirq(i)
		irq_set_chip_and_handler(i, &subirq_chip, handle_simple_irq);
}

So now you can request the interrupts for your subdevices with
request_irq or request_threaded_irq.

You can also implement #1 this way, you just mark the sub device
interrupts as IRQ_NESTED_THREAD, and then call the handlers from the
main trigger irq thread.

Thanks,

	tglx
