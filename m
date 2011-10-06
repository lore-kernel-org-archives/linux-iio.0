Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:49273 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935529Ab1JFQJ4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 6 Oct 2011 12:09:56 -0400
Message-ID: <4E8DD4CF.1080204@cam.ac.uk>
Date: Thu, 06 Oct 2011 17:18:23 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 0/6] iio:trivial dev_info rename +  remove unneeded existence
 checks
References: <1317654496-14484-1-git-send-email-jic23@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D59177146E73435AB@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D59177146E73435AB@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/05/11 07:37, Hennerich, Michael wrote:
> Jonathan Cameron wrote on 2011-10-03:
>> Hi All,
>>
>> The trigger patches should be trivial and obvious.
>>
>> The dev_info / indio_dev was entirely my fault as I introduced both
>> names a long time ago.  For a while drivers were at least internally
>> consistent, but with all the recent tree wide changes this is no
>> where near true.  Hence I did a word count, established dev_info
>> is no where near as common and hence have replaced all instances
>> in IIO with indio_dev (except for a few drivers for various reasons).
>>
>> Should have done this a long time ago.  Sorry for the churn of the
>> tree that will result.
>>
>> Note this is on top of all patches I have currently published.
> 
> Looks good.
> As far as the ADxxxx are concerned.
> 
> Acked-by: Michael Hennerich <michael.hennerich@analog.com>
I've done a bit of naughty history editing and broken this
set in two.  The rename patches have no gone to Greg. I'll
roll the other two into a later series.

(this is mostly because I got it into my head that I hadn't
posted the trigger ones yet and hence along with some other
patches shunted them forwards in time - one day I'll be good
and use topic branches rather than my stream of conciousness
and editing approach to patches).

Anyhow, they are now in the github master branch which I'm 
keeping at the point of whatever I have sent Greg.

Jonathan
