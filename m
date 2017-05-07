Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57453 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752506AbdEGVvB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 May 2017 17:51:01 -0400
Subject: Re: Enabling auto-WAKE/SLEEP for mma8654 accelerometer
To: "Schaefer, Brandon" <brandon.schaefer@flukenetworks.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Martin Kepplinger <martink@posteo.de>
References: <BN6PR12MB14426A9685B9A0E0C5E7DE3F90160@BN6PR12MB1442.namprd12.prod.outlook.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <a984aa05-1461-d452-9fa7-fc7109ad151b@kernel.org>
Date: Sun, 7 May 2017 14:32:30 +0100
MIME-Version: 1.0
In-Reply-To: <BN6PR12MB14426A9685B9A0E0C5E7DE3F90160@BN6PR12MB1442.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/05/17 23:47, Schaefer, Brandon wrote:
Hi Brandon,

> The driver mma8452.c currently does not and, from the commit logs,
> plan to support auto-WAKE/SLEEP functionality. I'm endeavoring on
> adding this support as it would be useful to allow the use of this
> device to wake the system from suspend. In the current state of the
> driver, the device will go in to standby (no measurements/interrupts
> being generated) due to runtime suspend and suspend callbacks.
> 
> I've modified the driver to go into/out of auto-WAKE/SLEEP but it
> removes the capability of Linux PM code suspending and resuming the
> device. I'm looking for advice on how to make the current Linux power
> management code and the auto-WAKE/SLEEP code coexist. Some options,
> both don't seem very reasonable: 1) Optional device tree bindings for
> mma8652 that will enable auto-WAKE/SLEEP if present, otherwise rely
> on Linux PM. a. DT bindings should be hw description only, using a DT
> binding to specify configuration could be seen as unreasonable.Yeah, looking into this it looks decidedly configuration specific -
hard to argue it has much to do with the hardware platform itself.

> b. Examples of properties that can be configured for auto-WAKE/SLEEP
> mode: output data rate during sleep mode, delay till sleep, power
> mode of sleep (low-noise, normal, high, low-power), etc... 2)
> Configure device with linux PM on boot, but expose sysfs nodes to
> allow userspace to configure device and put into auto-WAKE/SLEEP.
> Also responsible for disabling the PM code that'll put the device
> into standby. a. As noted in a commit to this driver, auto-WAKE/SLEEP
> is a bit complicated and there is no current documented syfsfs
> inetrace
> 
> Any and all suggestions welcome,
> 
> Brandon

Hmm. So in brief (looking at the datasheet) we want to suport
automatic switching of sampling rates dependent on an event?
(or starting of sampling on an event).

To do this we would be in buffered mode so runtime pm
would be keeping the chip awake anyway...

However, it's going to be very hard to come up with a generic
interface for this.  There is some relevant work in the pipeline
to do something not dissimilar with DMA buffers so we might eventually
have a nice framework for it, but right now I think we are looking
at something pretty specific to this driver.

Also worth discussing use cases.  What is this actually
for on a linux system?  Might effect which elements (if not all)
make sense to support.

Right now the fifo isn't supported by this driver at all which
is probably the right place to start. As far as I can see there
isn't much point in dealing with the rest without using the fifo!

Always slightly interesting to move to fifo support from direct
reading.  Lots of devices have done it before though so take
a look at some of the other accelerometers (e.g. bmc150 -
though I can't remember if that does it terribly elegantly or not).

In the meantime it certainly needs a wider set of inputs than the iio
list alone so I've cc'd devicetree people .
(please do pull in others of relevance!)

Jonathan
> 
> ________________________________
> ________________________________
> 
> 
> Please be advised that this email may contain confidential information. If you are not the intended recipient, please notify us by email by replying to the sender and delete this message. The sender disclaims that the content of this email constitutes an offer to enter into, or the acceptance of, any agreement; provided that the foregoing does not invalidate the binding effect of any digital or other electronic reproduction of a manual signature that is included in any attachment.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

