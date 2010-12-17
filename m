Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:49581 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359Ab0LQNCI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 17 Dec 2010 08:02:08 -0500
Received: from arcturus.eng.cam.ac.uk ([129.169.154.73]:33291)
	by ppsw-52.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.159]:25)
	with esmtpsa (PLAIN:jic23) (TLSv1:DHE-RSA-CAMELLIA256-SHA:256)
	id 1PTZwk-00022z-Fd (Exim 4.72) for linux-iio@vger.kernel.org
	(return-path <jic23@cam.ac.uk>); Fri, 17 Dec 2010 13:02:06 +0000
Message-ID: <4D0B5F5A.5000300@cam.ac.uk>
Date: Fri, 17 Dec 2010 13:02:18 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Discussion: Place of threaded interupts in IIO
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi All,

Given the timing of the writing of most of the IIO core was 
prior to threaded interrupts hitting the mainstream we didn't
use them originally. I suspect that the large numbers of old style
interrupts that we have is going to be a bit of a blocker when we
move out of staging so have been thinking about what to do about it.

This email is intended to get some initial thoughts from others
(some of home are hopefully more familiar with the ins and outs
of threaded interrupts than I am!)

As I understand it, the primary point of threaded interrupts is
to replace bottom half handlers (conventionally done on using
work queues) with kernel threads that are woken on the interrupt.
The reason is that kernel threads can be pre empted whereas work
queue items can not.

We have two common types of interrupt in IIO.

* Event interrupts (threshold detectors etc). I think these should
  be trivial to convert to threaded irq's.  For those that need
  timestamps we will still need a top half handler to grab that
  but it should be easy enough to do.

* Trigger interrupts - These are more complex.

For those not that familiar with the trigger infrastructure let
me run through its intent and give an outline of how it currently works.

Our current triggers fall into two classes:
1) Those associated with a device - data ready signals typically
2) Those independent of a device - gpio, timer (and when we get
   round to it a userspace trigger).

For simplicity (and because I have actual use cases for it with inertial
sensor rigs) we treat both of these classes the same.

Any trigger can have a number of devices registered with it.  This
allows for, as near a possible, simultaneous reading from a number
of devices.

There are two activation lists and each device can register in one or
both of these. The first 'fast' queue is intended for devices that
have a 'latch' or 'capture' signal typically consisting of a gpio
linked pin.  (no in tree users, but hardware with this
is common enough). Basically the intent is this list launches true
top half elements.

The second 'slow' queue currently queues up work queue items to read
from each of the devices.  This is the part that corresponds to the
area threaded interrupts cover.

Currently the infrastructure is nice and clean and more or less looks
the same as drivers doing their own handling of the relevant interrupts.

The problem lies in the fact each actual interrupt can effectively
call multiple bottom halves.

So to my mind two solutions exist.
1) A single thread per trigger.  Everything prior to the work queue
calls is moved into a handler that goes in the 'fast' list which stays
in our top half handler.  The work queue bits are called one after
another in the bottom half.

2) Allow each consumer to attach it's own thread to the trigger
controller and basically implement our own variant of the core threaded
interrupt code that allows for a list of threads rather than a single one.

I rather like the idea of 2.  It might even end up with different
devices being queried from different processor cores simultaneously
which is quite cute.  The question is whether a simple enough
implementation is possible that the originators of the threaded interrupt
code would be happy with it (as it bypasses or would mean additions to their
core code).

I wanted to get the opinions of those familiar with the IIO tree
before opening the question up to a wider audience (including those who
wrote the threaded interrupt code).

Jonathan
