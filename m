Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:3170
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755242Ab2DXHw7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 24 Apr 2012 03:52:59 -0400
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Date: Tue, 24 Apr 2012 08:52:43 +0100
Subject: RE: necessity of manual reset attribute in drivers?
Message-ID: <544AC56F16B56944AEC3BD4E3D5917714E793C210F@LIMKCMBX1.ad.analog.com>
References: <4F943EC2.7030707@kernel.org>
In-Reply-To: <4F943EC2.7030707@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Jonathan Cameron wrote on 2012-04-22:
> Hi All,
>
> I vaguely recall asking this in response to certain drivers over the
> years, but what is the usecase for userspace 'resetting' a device via
> a reset attribute?  It's reasonably common in the drivers but not
> (as I've kept it out) in the abi docs.
>
> It is common in some of Analog's inertial sensor drivers but I think
> turns up in various other places.

Ideally we shouldn't have such an attribute.
Error checking and handling should be all done in the drivers, if possible.
I don't remember exactly why it went into one of the original inertial sensor drivers.
But I think it went there to provide error correction, in case plausibility/error checking
of the delivered data failed.
I also suspect it then got copied over and over again.

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret Seif


