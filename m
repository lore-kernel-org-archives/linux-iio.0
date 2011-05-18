Return-Path: <tglx@linutronix.de>
Date: Wed, 18 May 2011 12:51:12 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH V4] irq: uninline generic_handle_irq, export handle_simple_irq,
 irq_modify_status, generic_handle_irq, irq_alloc_descs and irq_free_descs
In-Reply-To: <1305711544-505-1-git-send-email-jic23@cam.ac.uk>
Message-ID: <alpine.LFD.2.02.1105181249470.3078@ionos>
References: <1305711544-505-1-git-send-email-jic23@cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

On Wed, 18 May 2011, Jonathan Cameron wrote:
> Hi Thomas,
> 
> Looking a bit more at possible locations it is clear that CONFIG_GENERIC_HARDIRQS
> only exists as an ifdef in irqdesc.c so I guess that is the least intrusive place
> to move this to.

Bah, that ifdef there is completely useless. kernel/irq/ is only built
when CONFIG_GENERIC_HARDIRQS=y. I fix that.

Thanks,

	tglx
