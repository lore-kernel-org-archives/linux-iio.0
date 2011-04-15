Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:56526 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404Ab1DOLgX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 15 Apr 2011 07:36:23 -0400
Message-ID: <4DA82E28.5030206@cam.ac.uk>
Date: Fri, 15 Apr 2011 12:38:16 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: Channel mask out/hide
References: <544AC56F16B56944AEC3BD4E3D591771375475E2F5@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D591771375475E2F5@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/15/11 12:15, Hennerich, Michael wrote:
> Hi Jonathan,
> 
> A number of our ADC drivers use is_visible to hide some channels in certain configurations.
> Now that the channel registration is done in the core.
> How do you think we should do that, from now on?
Different channel sets for the different devices. It's slightly more static data, but
not too bad.  So basically how we did it before that is_visible function came along.
See max1363 or the version of adis16400 I'll push out to the onwards tree shortly.

That's the one big disadvantage I've seen, but I think the gains outweigh the slightly
larger amount of code in those places where is_visible is currently used.
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

