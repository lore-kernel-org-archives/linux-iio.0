Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:55356 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758492Ab2EASF0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 1 May 2012 14:05:26 -0400
References: <abd67b68b54fc6c88b83c91a200ace5e@mail.gmail.com> <4F9FAAB9.7060003@metafoo.de> <4F9FE357.6050004@cam.ac.uk> <4F9FE632.3040308@metafoo.de> <4F9FEA37.5040107@cam.ac.uk> <4F9FEDC6.8070400@metafoo.de> <4F9FF002.2060900@metafoo.de> <4F9FF82E.80906@cam.ac.uk> <4FA02576.2060607@metafoo.de>
In-Reply-To: <4FA02576.2060607@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: different data rate in IIO ?
From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Tue, 01 May 2012 19:05:02 +0100
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Ge Gao <ggao@invensense.com>, linux-iio@vger.kernel.org
Message-ID: <6adea11c-371d-4d73-bb36-f9681db7265d@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



Lars-Peter Clausen <lars@metafoo.de> wrote:

>On 05/01/2012 04:50 PM, Jonathan Cameron wrote:
>> On 5/1/2012 3:15 PM, Lars-Peter Clausen wrote:
>>> On 05/01/2012 04:05 PM, Lars-Peter Clausen wrote:
>>> [...]
>>> Ah, seems as if the refcounting infrastructure is already ready for
>>> use after
>>> we have called device_initialize, so the above plan should work
>quite
>>> well.
>>> Call device_del in iio_device_unregister and device_put in
>>> iio_device_free and
>>> free the struct in the release callback.
>> That makes sense given it just splits the two parts of
>device_unregister
>> apart.
>> Don't suppose you want to do the patch?
>
>I could write the patch, but I don't have a setup at hand right now
>where I
>could test it, so this would have to wait until next week. I wouldn't
>mind if
>you took care of it though :)
I'll aim to do it Saturday....  nothing to test on till then.
>
>- Lars

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
