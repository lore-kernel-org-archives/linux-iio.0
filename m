Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:35920 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755887Ab1ERIg3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 May 2011 04:36:29 -0400
Message-ID: <4DD385B2.9070809@cam.ac.uk>
Date: Wed, 18 May 2011 09:39:14 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Drivers <Drivers@analog.com>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: IIO-onwards
References: <544AC56F16B56944AEC3BD4E3D5917713AAF21C49E@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D5917713AAF21C49E@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/18/11 08:58, Hennerich, Michael wrote:
> Hi Jonathan,
> 
> What are your plans for submitting IIO-onwards?
It would have gone about a weak ago, but Thomas Gleixner wants some slight
tweaks to the irq core exports patch that about 50% of 
our tree is dependent on.  Getting this sorted is being slowed down by (I think)
the fact Thomas is travelling at the moment and seems to only have
intermittent email access. The outstanding issue is that irq_to_descs
should not be exported, but rather handle_generic_irq shouldn't
be inline.  I'm waiting on a reply for where it should go as it
doesn't obviously fit in any of the files under kernel/irq/.

Greg knows what the situation is, so fingers crossed that we can
get it cleared up in time to catch the merge window.

I think I'll just plump for a vaguely reasonable location for the code
and hope I guessed right as that will speed things up a touch and can't
do any harm!

Jonathan
> 
> Greetings,
> Michael
> 
> --
> Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
> Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
> Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret Seif
> 
> 
> 

