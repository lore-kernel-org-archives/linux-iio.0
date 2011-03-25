Return-Path: <jic23@cam.ac.uk>
Message-ID: <4D8C8321.6020103@cam.ac.uk>
Date: Fri, 25 Mar 2011 11:57:21 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Thomas Gleixner <tglx@linutronix.de>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: Exporting a few bits of irq infrastructure.
References: <4D84E4E7.3080108@cam.ac.uk>
In-Reply-To: <4D84E4E7.3080108@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 03/19/11 17:16, Jonathan Cameron wrote:
> Hi Thomas,
Hi again, just wondering if you have a moment to comment on these
exports?  If not I'll post them to LKML and see if someone shouts!

Thanks,

Jonathan
> 
> Just a quick enquiry.  Is there a reason to not allow
> exporting the symbols handle_simple_irq and irq_to_desc?
> Or is it simply a case that there is not normally a reason
> for having irq chips registered via modules?
> 
> My implementation of what I think you were suggesting the other
> day for handling our IIO triggers registers a separate irq
> chip for each trigger (currently with a compile time number
> of irq's per trigger).  These are allocated from a pool set
> up in a boards platform init code. The device drivers can then query to
> get the next available irq for a given trigger and request
> that.  Some trigggers are entirely instantiated based on
> a request form userspace (or should be anyway - see Arnd's observations
> on iio-trig-sysfs).  This could be done with a layer of indirection, but
> that would be annoyingly fiddly!
> 
> Anyhow, right now the patch is dependent on (cut out of a larger patch)
> 
> iff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index baa5c4a..eb3d53b 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -487,6 +487,7 @@ handle_simple_irq(unsigned int irq, struct irq_desc *desc)
>  out_unlock:
>  	raw_spin_unlock(&desc->lock);
>  }
> +EXPORT_SYMBOL_GPL(handle_simple_irq);
>  
>  /**
>   *	handle_level_irq - Level type irq handler
> diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
> index 282f202..d3765e2 100644
> --- a/kernel/irq/irqdesc.c
> +++ b/kernel/irq/irqdesc.c
> @@ -109,6 +109,7 @@ struct irq_desc *irq_to_desc(unsigned int irq)
>  {
>  	return radix_tree_lookup(&irq_desc_tree, irq);
>  }
> +EXPORT_SYMBOL(irq_to_desc);
>  
>  static void delete_irq_desc(unsigned int irq)
>  {
