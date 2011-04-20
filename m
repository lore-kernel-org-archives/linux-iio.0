Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:50448 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808Ab1DTJQh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 20 Apr 2011 05:16:37 -0400
Message-ID: <4DAEA4ED.5090608@cam.ac.uk>
Date: Wed, 20 Apr 2011 10:18:37 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>,
	Drivers <Drivers@analog.com>
Subject: Re: iio_trigger_poll_chained causes NULL pointer access
References: <544AC56F16B56944AEC3BD4E3D591771375475ED44@LIMKCMBX1.ad.analog.com> <4DADAD72.9070701@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D59177137547D64CA@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D59177137547D64CA@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/19/11 19:00, Hennerich, Michael wrote:
> Jonathan Cameron wrote on 2011-04-19:
>> On 04/19/11 16:22, Hennerich, Michael wrote:
>>> Hi Jonathan,
>>>
>>> The AD7606 ring buffer doesn't use the thread, and installs only the
>>> hard handler.
>>>
>>>         indio_dev->pollfunc->h = &ad7606_trigger_handler_th;
>>>         indio_dev->pollfunc->thread = NULL;
>>> This crashes the system in handle_nested_irq (null pointer
>>> action->thread_fn) called from iio_trigger_poll_chained().
>> I knew that wouldn't work, but didn't realize it wouldn't just fail
>> with an error...
>>
>> The only thing I can think to do is to actually set both h and thread
>> to ad7606_trigger_handler_th.
>>
>> As it returns IRQ_HANDLED, if it is called via irq_trigger_poll, it
>> will happen in interrupt context and thread will never run.
>>
>> If it is called via irq_trigger_poll_handler (e.g. for non interrupt
>> context) it'll happen outside interrupt context. Given timing is never
>> going to be that tight for userspace triggers, this probably isn't a
>> problem.
>>
>> Can you try that out and see if it works?
> 
> I know that setting the thread function will effectively avoid the crash.
> However I actually haven't traced if it's actually being called once the
> Hard handler returned IRQ_HANDLED.
It certainly shouldn't be. Feel free to check, but given handle_irq_event_percpu
(which is called from handle_simple_irq -> handle_irq_event)
contains

switch (res) {
		case IRQ_WAKE_THREAD:
			/*
			 * Set result to handled so the spurious check
			 * does not trigger.
			 */
			res = IRQ_HANDLED;

			/*
			 * Catch drivers which return WAKE_THREAD but
			 * did not set up a thread function
			 */
			if (unlikely(!action->thread_fn)) {
				warn_no_thread(irq, action);
				break;
			}

			irq_wake_thread(desc, action);

			/* Fall through to add to randomness */
		case IRQ_HANDLED:
			random |= action->flags;
			break;

		default:
			break;
		}

We should be completely safe in the hard irq case.

I'm not convinced what we have in the sysfs trig is the best
way of doing this, but haven't found a better one and only
reply to querying this said, 'that'll work' which whilst
encouraging doesn't say if it is the best plan.

The problem there is that whilst, the handle_irq code does a
sanity check and warn on no thread for the irq, handle_nested_irq
doesn't (which is reasonable considering it would pretty odd to call
this for an irq that doesn't have one!.
> 
> I'll have try.
> 
> -Michael
