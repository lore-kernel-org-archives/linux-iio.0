Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53412 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751851AbcAPMZO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 16 Jan 2016 07:25:14 -0500
Subject: Re: How to address a latency issue in a data acquisition system (IIO
 based)?
To: Julio Cruz <jcsistemas2001@gmail.com>, linux-iio@vger.kernel.org
References: <CAAn_ec90RULN=X=uoV4CrztyiQ0dsBOjYcSqgmbxqOheQR56ZA@mail.gmail.com>
 <CAAn_ec9QoS3iW8jAO2eRG9M73X56s23+fWWFk9meO6B0pANayA@mail.gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <569A36A8.2090407@kernel.org>
Date: Sat, 16 Jan 2016 12:25:12 +0000
MIME-Version: 1.0
In-Reply-To: <CAAn_ec9QoS3iW8jAO2eRG9M73X56s23+fWWFk9meO6B0pANayA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/01/16 08:29, Julio Cruz wrote:
> Hi again,
> 
> After digging on this issue, the SPI data loss was due to:
> 
> 1. The latency of some kernel drivers/modules. After disable some
> modules as suggested by Mat and tglx [1] the SPI handler latency was
> better, however still have some missing.
> 2. The SPI thread priority was too low. After setting the
> policy/priority as suggested by Daniel [2], the SPI response was as
> expected.
> 
> The interrupt latency depends on different factors, and those are very
> interesting once you research it (interrupt controller implementation,
> device priority of the interrupt, others drivers, etc...). Sorry for
> the noise about this issue.
> 
> Maybe this experience could be of interest for others SPI based drivers.
> 
> Julio
> 
Thanks for the updates.  Certainly of interest in general and good to have
a set of references to look at when next this question is raised!

Jonathan
> ----
> [1] Long max latencies on Wandbaord / Freescale i.MX6
> http://marc.info/?l=linux-rt-users&m=144368690819933&w=2
> ----
> [2] cyclictest versus custom SPI based system
> http://marc.info/?l=linux-rt-users&m=145271122200825&w=2
> 
> On Tue, Jan 12, 2016 at 11:50 PM, Julio Cruz <jcsistemas2001@gmail.com> wrote:
>> Hi,
>>
>> I'm running an acquisition system @1KHz sampling frequency (27
>> bytes/sample) with libiio as interface between the application and the
>> IIO driver (SPI based). The network and local context are working as
>> expected.
>>
>> However, the system have some data loss at SPI level (confirmed by
>> scope) even if the data is not pushed to the buffer
>> (iio_push_to_buffers). The scope show that every 1.4 sec (aprox), the
>> handler is not called. It seem other process is taking priority over
>> this.
>>
>> I'm trying to find the process that is taking over the SPI/IRQ handlers.
>>
>> - My system is running in ext4 (on SD) and maybe this could be the
>> problem (journal)?
>> - Implement a RT and review interrupt context as suggested by Xander
>> (http://marc.info/?l=linux-iio&m=143933412720586&w=2)?
>> - I would like to implement a DMA buffer as suggested by Lars (two
>> month ago) but I'm not sure this will help in this case
>> (http://marc.info/?l=linux-iio&m=144475305426138&w=2), for now.
>>
>> In any case, any advice to address this problem is welcome.
>>
>> Thanks
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

