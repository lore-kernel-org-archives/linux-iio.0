Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52440 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180AbcFKQzG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 11 Jun 2016 12:55:06 -0400
Subject: Re: [RFC 6/7] iio: Refuse to register triggers with duplicate names
To: Lars-Peter Clausen <lars@metafoo.de>,
	Crestez Dan Leonard <leonard.crestez@intel.com>,
	linux-iio@vger.kernel.org
References: <cover.1464027859.git.leonard.crestez@intel.com>
 <643ac0601a74fadc842ccb83c8f3741293ef7299.1464027859.git.leonard.crestez@intel.com>
 <08913c84-b83f-8163-c766-5935a202b3c2@kernel.org>
 <96cbaba0-29bb-7282-3e30-b4ebdd859b99@intel.com>
 <574D99B0.6000105@metafoo.de>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <4bbe2fca-0479-7249-9598-c603fb3247e8@kernel.org>
Date: Sat, 11 Jun 2016 17:55:00 +0100
MIME-Version: 1.0
In-Reply-To: <574D99B0.6000105@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/05/16 15:03, Lars-Peter Clausen wrote:
> On 05/30/2016 02:49 PM, Crestez Dan Leonard wrote:
>> On 05/29/2016 10:48 PM, Jonathan Cameron wrote:
>>> On 23/05/16 19:40, Crestez Dan Leonard wrote:
>>>> The trigger name is documented as unique but drivers are currently
>>>> allowed to register triggers with duplicate names. This should be
>>>> considered a bug since it makes the 'current_trigger' interface
>>>> unusable.
>>>>
>>>> Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
>>> This feels like the right approach to my mind (and should have been there
>>> all along - oops).
>>>
>>> However, we do need to avoid breaking userspace. It's ugly but for those 3 drivers
>>> can we assume that using more than one on a board was impossible before this series
>>> and as such play a slight game in which we don't change the trigger name they
>>> are exporting, unless that name is already in use?
>>>
>>> It's ugly but it gets us the nicest solution for all drivers for a bit of ugly in
>>> 3 of them...
>>
>> How would that look like? I guess I could handle -EEXIST from
>> iio_trigger_register and try again with another name? Unfortunately the
>> name is initialized at alloc time while uniqueness can only be checked
>> at register time. This would require some refactoring in drivers for
>> devices I don't have.
>>
>> An alternative would be to just submit patches 4/5 and only give a
>> warning when non-unique trigger names are used. After all, iio device
>> names are not unique, the easy way would be to give up on this guarantee
>> for trigger names as well.
>>
> 
> I'd say apply this patch keep things as they are in the drivers and if
> somebody creates a board with more than one of those devices let them come
> up with a fix.

Fair call. Lets do that.

Applied this patch to the togreg branch of iio.git (usual testing blah blah)
Let's see who (hopefully no one) screams.

Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

