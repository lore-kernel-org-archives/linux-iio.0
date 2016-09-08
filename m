Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:47394 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756982AbcIHQOE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Sep 2016 12:14:04 -0400
Subject: Re: [PATCH v1 1/2] iio:buffer: properly handle polling of
 unregistered device
To: Gregor Boirie <gregor.boirie@parrot.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <cover.1473269007.git.gregor.boirie@parrot.com>
 <76209c68a95ae086878c35713e2ac6c2a3776f69.1473269007.git.gregor.boirie@parrot.com>
 <aeee1e9c-4f0b-3435-a96d-478e256ebdf4@metafoo.de>
 <57D11E30.7070509@parrot.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <4d908dc7-e2fc-62d8-76e8-35b7fbc92b00@metafoo.de>
Date: Thu, 8 Sep 2016 18:14:02 +0200
MIME-Version: 1.0
In-Reply-To: <57D11E30.7070509@parrot.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/08/2016 10:15 AM, Gregor Boirie wrote:
> Hi Lars,
> 
> On 09/07/2016 08:13 PM, Lars-Peter Clausen wrote:
>> On 09/07/2016 07:26 PM, Gregor Boirie wrote:
>>> Using iio_device_unregister() on a device currently in use may stall
>>> userspace process polling for data availability (poll syscall).
>>>
>>> If device has vanished before running the iio_buffer_fileops poll hook, the
>>> latter will return empty poll event mask. Process will be stalled waiting
>>> for events that will never come (if no timeout specified).
>>>
>>> This patch ensures iio_buffer_poll() returns POLLERR if device has just
>>> been unregistered in order to properly notify userspace process something
>>> wrong happened (such as removable device unplugged).
>>>
>>> Fixes: 1bdc029390 ("iio: industrialio-buffer: Fix iio_buffer_poll return
>>> value")
>>> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
>> Hi,
>>
>> Thanks for the patch. I agree with the solution, I don't quite agree with
>> the description. In my opinion the current behavior is not necessarily a
>> bug. Obviously there won't be a wakeup when the device has been removed
>> since no new data will be generated. But there are other scenarios where
>> this can happen as well (e.g. broken hardware). An application should be
>> prepared to handle this and if it is interactive for example allow the user
>> to interrupt the capture process.
> Ok. What do you want me to do then ? Remove the "Fixes" tag ? Reword
> something in the commit log ?
> I'll merge the 2 patches as recommended by Jonathan anyway.

I'd drop the Fixes tag and maybe change the subject to "Let poll report an
error for unregistered devices"

