Return-Path: <lars@metafoo.de>
Message-ID: <540A09BB.5010709@metafoo.de>
Date: Fri, 05 Sep 2014 21:06:35 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
 linux-iio@vger.kernel.org
CC: Jonathan Cameron <jic23@kernel.org>,
 James Hartley <james.hartley@imgtec.com>,
 Naidu Tellapati <Naidu.Tellapati@imgtec.com>
Subject: Re: IIO hrtimer trigger
References: <20140905152203.42ff6868@arch>
In-Reply-To: <20140905152203.42ff6868@arch>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 09/05/2014 08:22 PM, Ezequiel Garcia wrote:
> Hello Lars,
>
> I'm picking this discussion, since we're also interested in using an hrtimer
> trigger.
>
>> On 10/06/2013 08:15 PM, Jonathan Cameron wrote:
>>> We are pretty much stuck with that for the sysfs trigger already...
>>
>> Unfortunately yes. I never liked its API and I still don't like it and we
>> have to live with it. But this doesn't mean we have to add more of the same.
>
> So the reason why the hrtimer trigger hasn't been merged in its current form is
> because we're still discussing the ABI, right?

I think the configfs documentation explains this quite well:

"Where sysfs is a filesystem-based view of kernel objects, configfs is a 
filesystem-based manager of kernel objects, or config_items." [1]

>
> Can you elaborate on why you don't like the sysfs trigger API? If you can give
> me some hints I can try to cook a patch for the configfs hrtimer trigger.

That would be great. I unfortunately only have a very foggy view of how the 
ABI and API should look like.

But I think the basic interface is have a toplevel iio configfs folder, 
maybe a subfolder called "triggers" and than a subfolder for each software 
trigger. E.g. "timer" (We shouldn't call it hrtimer cause that is just a 
implementation detail). Then in those trigger folders you can do mkdir to 
create a new instance of that trigger. In the folder there might be trigger 
specific config settings exposed as files.

- Lars

[1] https://www.kernel.org/doc/Documentation/filesystems/configfs/configfs.txt
