Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:60717 "EHLO
	ppsw-1.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752537Ab0CVMD4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 22 Mar 2010 08:03:56 -0400
Message-ID: <4BA75D3E.1050008@cam.ac.uk>
Date: Mon, 22 Mar 2010 12:06:22 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: lewin <dlewin@free.fr>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: SPI Driver
References: <4BA552E2.4070308@free.fr>
In-Reply-To: <4BA552E2.4070308@free.fr>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/20/10 22:57, lewin wrote:
> Dear Sir,
> 
> I've seen that you wrote some drivers for accelerometers and would like
> to ask
> you if you did anything for an Analog Devices like ADIS16209 ?
I've not personally looked at that particular chip.  Recently
Analog Devices have been doing a lot of work on driver support
for their own chips.  For now most of this work has been going on in
the blackfin repositories.

http://blackfin.uclinux.org/gf/project/linux-kernel/scmsvn/?action=browse&path=%2Ftrunk%2Fdrivers%2Fstaging%2Fiio%2F

Doesn't look like they have looked at that particular chip as yet though.

I've also cc'd the linux-iio mailing list as anyone working on such
a driver is probably subscribed. (for others I'm just waiting on 
an archive being set up for that list before doing a formal announcement).
> If yes, please tell me where to find it. Elsewhere, may I ask you
> advices to write one.
> I'm a programer but lost with drivers. My intention is to read this A.D.
> sensor's data from a FriendlyArm board (S3C2440 too).
We will certainly be happy to assist.  The best bet is to look at existing
drivers and make sure you fully understand what they are up to.  Then it
is usually mostly a case of cut and paste!

Thanks,

Jonathan
