Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-195.synserver.de ([212.40.185.195]:1107 "EHLO
	smtp-out-190.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751274AbcBCLWE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 3 Feb 2016 06:22:04 -0500
Subject: Re: using monotonic clok for timstamping
To: Gregor Boirie <gregor.boirie@parrot.com>, linux-iio@vger.kernel.org
References: <56B1DCA4.9050903@parrot.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <56B1E2D8.90308@metafoo.de>
Date: Wed, 3 Feb 2016 12:22:00 +0100
MIME-Version: 1.0
In-Reply-To: <56B1DCA4.9050903@parrot.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/03/2016 11:55 AM, Gregor Boirie wrote:
> Dear  all,
> 
> Our application relies on precise and monotonic timestamping of IMU samples
> (and other sensors).
> I am wondering what reasons / use cases led to the choice of realtime clock
> to implement
> iio_get_time_ns (not to mention time gaps that may be seen after wake up
> from sleep states).

It's more of an oversight than a deliberate design decision. I noticed this
problem as well a while ago and wanted to re-write things to use the
monotonic clock, but then realized that this would be a ABI change so
dropped it and forgot about it again.

> 
> As a dirty hack, I simply rewrote iio_get_time_ns on our platform. But I
> suspect it would be usefull as
> a long term solution, to give userland the ability to choose a particular
> posix clock (realtime, monotonic,
> etc...) on a per device and / or driver basis through a sysfs attribute for
> example.

This is probably the only viable solution while keeping the ABI backwards
compatible.

- Lars

