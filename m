Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:53137 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752866Ab2EDOmP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 4 May 2012 10:42:15 -0400
Message-ID: <4FA3EAC2.2080005@cam.ac.uk>
Date: Fri, 04 May 2012 15:42:10 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "jic23@kernel.org" <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [PATCH 3/3] iio: frequency: New driver for AD9523 SPI Low Jitter
 Clock Generator
References: <1336138266-25480-1-git-send-email-michael.hennerich@analog.com> <1336138266-25480-3-git-send-email-michael.hennerich@analog.com> <4FA3DE8E.6050802@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D5917714E797B4F51@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D5917714E797B4F51@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 5/4/2012 3:00 PM, Hennerich, Michael wrote:
> Jonathan Cameron wrote on 2012-05-04:
>> On 5/4/2012 2:31 PM, michael.hennerich@analog.com wrote:
>>> From: Michael Hennerich<michael.hennerich@analog.com>
>> Before I dive in here too far, let me ask the stupid question.
>>
>> Whilst I know nothing much about it, why is the kernel's clock framework
>> unsuitable for this device?
> Hi Jonathan,
>
> I think we had a similar discussion before.
>
> The in-kernel clock infrastructure HAVE_CLK<linux/clk.h>  is not suitable
> since it is designed for SoC like systems.
>
> 1) The API is exported by arch and platform code.
> 2) Data structures differ between the different implementations.
> 3) Coexistence with other clock providers is by design impossible.
>
> Greetings,
> Michael
>
Does ring a bell now you mention it :) Thanks for the summary.  I can 
imagine
there may be a suggestion to look at overcoming the above in the long term,
but can't see it being worth while for a small number of parts.
