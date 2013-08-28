Return-Path: <holler@ahsoftware.de>
Message-ID: <521DF395.1060502@ahsoftware.de>
Date: Wed, 28 Aug 2013 14:56:53 +0200
From: Alexander Holler <holler@ahsoftware.de>
MIME-Version: 1.0
To: "Drubin, Daniel" <daniel.drubin@intel.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@cam.ac.uk>,
 "Yuniverg, Michael" <michael.yuniverg@intel.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "Haimovich, Yoav" <yoav.haimovich@intel.com>
Subject: Re: working with IIO
References: <0423FED8EB79934F939F077EAF96DBD717D8025F@HASMSX105.ger.corp.intel.com> <a761c167-aef3-42a3-a4bd-fa5078861dd1@email.android.com> <CE30B71206DDA24CBD6D43D23C236C034D8B11@HASMSX103.ger.corp.intel.com> <52160F47.2030403@metafoo.de> <CE30B71206DDA24CBD6D43D23C236C034D8BAA@HASMSX103.ger.corp.intel.com> <52161D55.8090201@metafoo.de> <CE30B71206DDA24CBD6D43D23C236C034D8BDE@HASMSX103.ger.corp.intel.com> <521625C5.4020504@metafoo.de> <CE30B71206DDA24CBD6D43D23C236C034D8C0B@HASMSX103.ger.corp.intel.com> <52163141.1080905@metafoo.de> <CE30B71206DDA24CBD6D43D23C236C034D8C47@HASMSX103.ger.corp.intel.com> <52163589.4080701@metafoo.de> <CE30B71206DDA24CBD6D43D23C236C034D8C69@HASMSX103.ger.corp.intel.com>
In-Reply-To: <CE30B71206DDA24CBD6D43D23C236C034D8C69@HASMSX103.ger.corp.intel.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

Am 22.08.2013 18:26, schrieb Drubin, Daniel:

>>>> So each time a process writes to a IIO sysfs file you want to record
>>>> which value that application wrote. So when I run `for i in `seq 0
>>>> 100000`; do echo $i
>>>>> sampling_frequency; done` I'd end up with a list with one million
>>>>> entries
>>>> which will stay in the list forever.
>>>
>>> No, there is only one entry per PID. Next value that the same process
>> writes will replace the previous one, not create a new entry. An entry will be
>> create only if the write request arrived from a PID currently not in list.
>>>
>>
>> Assume that echo is a /bin/echo, not a shell built-in command.
> 
> Then indeed a new entry will be created 100000 times. But before creating a new instance of /bin/echo, the previous one will terminate closing all file descriptors. A device driver would miss this event and thus an ability to remove PID from list only if the framework for some reason chose to ban it from knowing.

Try

sysctl kernel.pid_max

So the list would be likely smaller and reused PIDs will end up with a
funny behaviour. ;)

Regards,

Alexander Holler
