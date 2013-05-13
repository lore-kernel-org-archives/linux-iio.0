Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-32.csi.cam.ac.uk ([131.111.8.132]:41889 "EHLO
	ppsw-32.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830Ab3EMI5v (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 13 May 2013 04:57:51 -0400
Message-ID: <5190AB0B.8030704@jic23.retrosnub.co.uk>
Date: Mon, 13 May 2013 09:57:47 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
MIME-Version: 1.0
To: Jacek Anaszewski <j.anaszewski@samsung.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [NEW DRIVER] LPS331AP barometer sensor driver
References: <1368176965-23190-1-git-send-email-j.anaszewski@samsung.com> <2454453.7GbGA1kxYy@elitebook-8460p> <kmq4li$8a5$1@ger.gmane.org>
In-Reply-To: <kmq4li$8a5$1@ger.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/05/13 08:27, Jacek Anaszewski wrote:
> On 05/10/2013 11:31 AM, Denis CIOCCA wrote:
>> Hi Jacek,
>>
>> for the STMicroelectronics MEMS I have wrote one common library
>> (common/st_sensors) that implements some common features for our devices.
>> Now I'm working on to submit the patch for all our barometer sensors
>> using
>> also trigger and buffer.
>
>
> Hi Denis,
>
> Could you share your code, even if it is not entirely completed,
> so that I could compare it with my solution?
>
> Thanks,
> Jacek
>
Obviously the ideal is for you two to agree between you how to proceed 
but failing that I am in theory happy to take Jacek's driver in the 
meantime and then, when Denis' driver is feature comparable (or has
more as is likely) to then remove Jacek's.

I'll get round to reviewing Jacek's code at some point either way
as a useful exercise.

Jonathan



