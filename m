Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:47848 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752363Ab1EWPcw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 23 May 2011 11:32:52 -0400
Message-ID: <4DDA7ED2.5020807@cam.ac.uk>
Date: Mon, 23 May 2011 16:35:46 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [PATCH 0/2] IIO more resolver cleanups.
References: <1305884517-11168-1-git-send-email-jic23@cam.ac.uk> <1305889112-28814-1-git-send-email-jic23@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D5917713AAF293900@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D5917713AAF293900@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/23/11 15:52, Hennerich, Michael wrote:
> Jonathan Cameron wrote on 2011-05-20:
>> What can I say, this morning has turned out to be rather dull as well
>> and these other two drivers are small so here is a cleanup series for
>> them.
>>
>> Note in the ad2s1210 driver I forgot to clear the IN / OUT of
>> resolution bit out of the Kconfig file. I'm also not entirely sure I
>> understand how that is supposed to work, so may well have it wrong.
>>
>> Thanks,
> 
> Hi Jonathan,
> 
> Thanks for having dull times.
> Really nice cleanup!
> 
> Give me some time to review these - unfortunately I don't have hardware to
> test at the moment.
> 
Sure.  This is in the next big round anyway as I don't really want to push
anything else in this merge window.  Feel I've been mean enough to Greg
already!

Jonathan
