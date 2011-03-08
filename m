Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:51275 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755054Ab1CHOLs (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 8 Mar 2011 09:11:48 -0500
Message-ID: <4D763956.3040304@cam.ac.uk>
Date: Tue, 08 Mar 2011 14:12:38 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: Build iio as built in rather than module.
References: <4D763507.2090003@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D59177133FA8775EF@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D59177133FA8775EF@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/08/11 13:59, Hennerich, Michael wrote:
> Jonathan Cameron wrote on 2011-03-08:
>> Just a heads up.  Right now on a stargate 2 (pxa) I can't boot if IIO
>> is built in rather than the module I normally use.
>>
>> Chasing down exactly why now.  Annoyingly this is occurring before any
>> messages at all come out on the serial console so may take a while to
>> track down.
>>
>> Jonathan
> 
> Works ok on Blackfin - however one thing I noticed a while ago.
> In case IIO device drivers are build statically into the kernel,
> udev/mdev and friends doesn't generate the device nodes on the fly.
> 
False alarm on the booting kernel issue.  One of those stupid cases
of commenting out one line taking the image size down a tiny tiny
and letting it fit into the partition I was flashing it to.

The lack of device nodes is probably to do with missing some of
those magic udev related macro calls.

Jonathan
