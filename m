Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57879 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087AbcGCMBZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 3 Jul 2016 08:01:25 -0400
Subject: Re: [PATCH 1/2] iio: sun4i-lradc: Add binding documentation
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Chen-Yu Tsai <wens@csie.org>
References: <1467406855-9677-1-git-send-email-alexandre.belloni@free-electrons.com>
 <CAGb2v66PzgVqVGxs4FSQkkX=2hX42UmftahOgJmepv4wA-mwnw@mail.gmail.com>
 <20160702133528.GC20045@piout.net>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
	linux-iio@vger.kernel.org,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree <devicetree@vger.kernel.org>,
	Hans De Goede <hdegoede@redhat.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <06b093dc-94ca-df0b-a441-4932ece18af2@kernel.org>
Date: Sun, 3 Jul 2016 13:01:23 +0100
MIME-Version: 1.0
In-Reply-To: <20160702133528.GC20045@piout.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/07/16 14:35, Alexandre Belloni wrote:
> On 02/07/2016 at 17:12:55 +0800, Chen-Yu Tsai wrote :
>> Hi,
>>
>> On Sat, Jul 2, 2016 at 5:00 AM, Alexandre Belloni
>> <alexandre.belloni@free-electrons.com> wrote:
>>> Document the bindings for the Allwinner LRADC.
>>
>> We already have Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt
>> and I'm pretty sure Hans (CC-ed) argued that this is not a generic ADC
>> block.
>>
>> Any plans to reconcile the different bindings?
>>
> 
> Yes, I already submitted an adc-keys driver that can work with any ADC:
> https://lkml.org/lkml/2016/7/1/670
> 
> I agree that because it is not yet handling interrupts and is polling
> the ADC, it is not as good as sun4i-lradc-keys yet. My plan is to solve
> that but it require significant work in iio.
> 
As I'm having fun confusing the two drivers submitted for different
ADCs on the A10 this morning - here is the relevant bit of text I stuck
in my review for the other driver...

 For the key detection you have already observed that IIO needs some
 additions to be able to have consumers of what we term 'events' e.g. threshold
 interrupts.
 
 Looking at the lradc-keys driver in tree, it looks like we only really have
 really simple threshold interrups - configured to detect a very low voltage?
 + only one per channel.
 
 So not too nasty a case, but you are right some work is needed in IIO as
 we simply don't have a means of passing these on as yet or configuring them
 from in kernel consumers.
 If we take the easy route and don't demux incoming events then it shouldn't
 be too hard to add (demux can follow later).  Hence any client device can try
 to enable events it wants, but may get events that other client devices wanted
 as well.
 
 Config interface should be much the same as the write support for channels.
 Data flow marginally harder, but pretty much a list of callbacks within
 iio_push_event.
 
 Not trivial, but not too tricky either.
 
 The events subsystem has a few 'limitations' we need to address long term
 but as this is in kernel interface only, we can do this now and fix stuff
 up in future without any ABI breakage. (limitations are things like only
 one event of a given type and direction per channel - main challenge on
 that is finding a way of doing it without abi breakage).
 
 Anyhow, sounds fun - wish I had the time to do it myself!
Jonathan
 

