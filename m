Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:10282 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754087AbcE3MuS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 30 May 2016 08:50:18 -0400
Subject: Re: [RFC 6/7] iio: Refuse to register triggers with duplicate names
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
References: <cover.1464027859.git.leonard.crestez@intel.com>
 <643ac0601a74fadc842ccb83c8f3741293ef7299.1464027859.git.leonard.crestez@intel.com>
 <08913c84-b83f-8163-c766-5935a202b3c2@kernel.org>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>
From: Crestez Dan Leonard <leonard.crestez@intel.com>
Message-ID: <96cbaba0-29bb-7282-3e30-b4ebdd859b99@intel.com>
Date: Mon, 30 May 2016 15:49:58 +0300
MIME-Version: 1.0
In-Reply-To: <08913c84-b83f-8163-c766-5935a202b3c2@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/29/2016 10:48 PM, Jonathan Cameron wrote:
> On 23/05/16 19:40, Crestez Dan Leonard wrote:
>> The trigger name is documented as unique but drivers are currently
>> allowed to register triggers with duplicate names. This should be
>> considered a bug since it makes the 'current_trigger' interface
>> unusable.
>>
>> Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
> This feels like the right approach to my mind (and should have been there
> all along - oops).
> 
> However, we do need to avoid breaking userspace. It's ugly but for those 3 drivers
> can we assume that using more than one on a board was impossible before this series
> and as such play a slight game in which we don't change the trigger name they
> are exporting, unless that name is already in use?
> 
> It's ugly but it gets us the nicest solution for all drivers for a bit of ugly in
> 3 of them...

How would that look like? I guess I could handle -EEXIST from
iio_trigger_register and try again with another name? Unfortunately the
name is initialized at alloc time while uniqueness can only be checked
at register time. This would require some refactoring in drivers for
devices I don't have.

An alternative would be to just submit patches 4/5 and only give a
warning when non-unique trigger names are used. After all, iio device
names are not unique, the easy way would be to give up on this guarantee
for trigger names as well.

-- 
Regards,
Leonard
