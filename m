Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:63555 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751219AbcFQVLQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 17 Jun 2016 17:11:16 -0400
Message-ID: <1466197963.24319.110.camel@linux.intel.com>
Subject: Re: [PATCH 2/6] hid: intel_ish-hid: ISH Transport layer
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: jic23@kernel.org, benjamin.tissoires@redhat.com,
	linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, chaya.golan@intel.com,
	daniel.drubin@intel.com, A.Bhattacharya@ulg.ac.be
Date: Fri, 17 Jun 2016 14:12:43 -0700
In-Reply-To: <alpine.LNX.2.00.1606172236520.6874@cbobk.fhfr.pm>
References: <1465647219-7798-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <1465647219-7798-3-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <alpine.LNX.2.00.1606172236520.6874@cbobk.fhfr.pm>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 2016-06-17 at 22:43 +0200, Jiri Kosina wrote:
> On Sat, 11 Jun 2016, Srinivas Pandruvada wrote:
> 
> [ ... snip ... ]
> > diff --git a/drivers/hid/intel-ish-hid/Kconfig b/drivers/hid/intel-
> ish-hid/Kconfig
> > new file mode 100644
> > index 0000000..8914f3b
> > --- /dev/null
> > +++ b/drivers/hid/intel-ish-hid/Kconfig
> > @@ -0,0 +1,22 @@
> > +menu "Intel ISH HID support"
> > +     depends on X86 && PCI
> > +
> > +config INTEL_ISH_HID_TRANSPORT
> > +     bool
> > +     default n
> > +
> > +config INTEL_ISH_HID
> > +     bool "Intel Integrated Sensor Hub"
> 
> Why can't the transport driver be built as a module?
In current use case for PM, we don't want anyone to unload and
complain.
But if this is a strong requirement, I will change this to a module.

Thanks,
Srinivas

> 
> [ ... snip ... ]
> > +/**
> > + * ishtp_bus_add_device() - Function to create device on bus
> > + *
> > + * @dev:     ishtp device
> > + * @uuid:    uuid of the client
> > + * @name:    Name of the client
> > + *
> > + * Allocate ISHTP bus client device, attach it to uuid
> > + * and register with ISHTP bus.
> > + */
> > +struct ishtp_cl_device *ishtp_bus_add_device(struct ishtp_device
> *dev,
> > +                                          uuid_le uuid, char
> *name)
> > +{
> 
> Should be static.
> 
> [ ... snip ... ]
> > +/**
> > + * ishtp_bus_remove_device() - Function to relase device on bus
> > + *
> > + * @device:  client device instance
> > + *
> > + * This is a counterpart of ishtp_bus_add_device.
> > + * Device is unregistered.
> > + * the device structure is freed in 'ishtp_cl_dev_release'
> function
> > + * Called only during error in pci driver init path.
> > + */
> > +void ishtp_bus_remove_device(struct ishtp_cl_device *device)
> > +{
> 
> Should be static.
> 
> [ ... snip ... ]
> > +/*
> > + * ishtp_hbm_dma_xfer_ack - receive ack for ISHTP-over-DMA client
> message
> > + *
> > + * Constraint:
> > + * First implementation is one ISHTP message per DMA transfer
> > + */
> > +void ishtp_hbm_dma_xfer_ack(struct ishtp_device *dev,
> 
> Should be static.
> 
> [ ... snip ... ]
> > +/* ishtp_hbm_dma_xfer - receive ISHTP-over-DMA client message */
> > +void ishtp_hbm_dma_xfer(struct ishtp_device *dev,
> > +                     struct dma_xfer_hbm *dma_xfer)
> 
> Should be static.
> 
> -- 
> Jiri Kosina
> SUSE Labs
> 
