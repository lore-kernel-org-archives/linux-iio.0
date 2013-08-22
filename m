Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:51886 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753714Ab3HVPlb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 22 Aug 2013 11:41:31 -0400
Message-ID: <52163141.1080905@metafoo.de>
Date: Thu, 22 Aug 2013 17:41:53 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: "Drubin, Daniel" <daniel.drubin@intel.com>
CC: Jonathan Cameron <jic23@cam.ac.uk>,
	"Yuniverg, Michael" <michael.yuniverg@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"Haimovich, Yoav" <yoav.haimovich@intel.com>
Subject: Re: working with IIO
References: <0423FED8EB79934F939F077EAF96DBD717D8025F@HASMSX105.ger.corp.intel.com> <a761c167-aef3-42a3-a4bd-fa5078861dd1@email.android.com> <CE30B71206DDA24CBD6D43D23C236C034D8B11@HASMSX103.ger.corp.intel.com> <52160F47.2030403@metafoo.de> <CE30B71206DDA24CBD6D43D23C236C034D8BAA@HASMSX103.ger.corp.intel.com> <52161D55.8090201@metafoo.de> <CE30B71206DDA24CBD6D43D23C236C034D8BDE@HASMSX103.ger.corp.intel.com> <521625C5.4020504@metafoo.de> <CE30B71206DDA24CBD6D43D23C236C034D8C0B@HASMSX103.ger.corp.intel.com>
In-Reply-To: <CE30B71206DDA24CBD6D43D23C236C034D8C0B@HASMSX103.ger.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/22/2013 05:16 PM, Drubin, Daniel wrote:
> [...]
>>>  From practical POV we don't have much choice (timeline), since we have to
>> reuse driver that is bound to IIO. From principle standpoint I somehow fail to
>> see a problem. It seems to me that all state handling that an IIO driver needs
>> to do is to keep associations of PIDs to sensor rates, configure sensor to the
>> highest rate in the list and replicate shared data at rates requested by the
>> clients. When a file descriptor is closed (due to process termination or
>> another reasons), the actual sensor is re-configured with next-highest rate
>> among the open FDs.
>>
>> But you can't track the configured rate per PID with the current API. That's
>> why I keep saying that the API is stateless. You can not track state per
>> application without inventing a new API.
>
> Why can't I during keep a list of PIDs that currently use a sensor and record current->pid together with "default" rate during the first sampling request that doesn't have a matching PID, and in write_raw() handler that updates rate match that current->pid against list of recorded PIDs? I didn't see a possibility that sensor driver's handler may get called in a different context than IIO core fops handler.

So each time a process writes to a IIO sysfs file you want to record which 
value that application wrote. So when I run `for i in `seq 0 100000`; do echo 
$i > sampling_frequency; done` I'd end up with a list with one million entries 
which will stay in the list forever.

- Lars

