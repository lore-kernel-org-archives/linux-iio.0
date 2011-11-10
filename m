Return-Path: <maxime.ripard@free-electrons.com>
Message-ID: <4EBB9CD7.4000408@free-electrons.com>
Date: Thu, 10 Nov 2011 10:43:51 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: linux-iio@vger.kernel.org
Subject: More questions about IIO
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

Now that the work on the AT91 adc driver using software triggers looks
well on its way to the kernel, I begin to work on hardware triggers for it.

Few questions raise though.

First, it seems that when using hardware triggers, we have to use the
iio ring buffers.

So the first implementation that comes to my mind is this one :
 - The probe function actually sets up the driver, the triggers, the
buffer, etc.
 - Each time an interrupt is raised, the handler either fill the buffer
with the values of the activated channels or store it in a temporary
variable just like I'm doing right now for the software triggers.
  - When a user reads the sysfs file, either read from the buffer or
from the temporary variable.

But :
  - Is it the right way to do so with iio ?
  - Is there a way for the user to select at runtime if he wants only
software trigger or hardware trigger (if they are enabled in the kernel) ?
  - What is the role of this pollfunc defined in the iio_dev struct ?

Also, the ADC has 4 external trigger sources, which are selected through
a register. 3 of them are muxed pins, so the pins available varies from
one board to another. Is there a way for the user at runtime to select
the source he wants ?

Finally, this ADC supports two resolutions : 8 and 10 bit. For now, only
10 bit resolution is supported, but the user might want to use 8 bit. Is
there a way to do so ?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
