Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59711 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753139AbbC1LxH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 28 Mar 2015 07:53:07 -0400
Message-ID: <55169621.3080101@kernel.org>
Date: Sat, 28 Mar 2015 11:53:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>,
	Peter Meerwald <pmeerw@pmeerw.net>
CC: Joel Becker <jlbec@evilplan.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"octavian.purdila@intel.com" <octavian.purdila@intel.com>
Subject: Re: [PATCH 3/3] iio: Documentation: Add initial documentaton for
 IIO
References: <1427302832-9336-1-git-send-email-daniel.baluta@intel.com>	<1427302832-9336-4-git-send-email-daniel.baluta@intel.com>	<alpine.DEB.2.02.1503251817280.30570@pmeerw.net> <CAEnQRZA6Y2GcNqi7UT5ipcHRPvA_tOh+Eqd4-v8tdQ0BaaPiRQ@mail.gmail.com>
In-Reply-To: <CAEnQRZA6Y2GcNqi7UT5ipcHRPvA_tOh+Eqd4-v8tdQ0BaaPiRQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/03/15 19:28, Daniel Baluta wrote:
> On Wed, Mar 25, 2015 at 7:22 PM, Peter Meerwald <pmeerw@pmeerw.net> wrote:
>> On Wed, 25 Mar 2015, Daniel Baluta wrote:
>>
>>> This file wants to be a starting point document for anyone wanting
>>> to use IIO configfs support or adding new IIO configfs functionality.
>>
>> typos below; I'm just trying to understand what's going on...
> 
> Hi Peter,
> 
> Thanks a lot for your time. I agree with all your comments for this patch
> and will fix in v2.
> <snip>
> 
>>> +* IIO on IIO drivers
>>
>> ??
> 
> I will add more details about this. I was trying to describe the IIO
> elements that
> would make sense to be configured via configfs.
> 
> Have a look at Jonathan's email:
> 
> http://marc.info/?l=linux-iio&m=142693832028677&w=2
> 
> thanks,
> Daniel.
> 
Might be premature / confusing to put those in the help file!
If anyone cares about our motivation for the structure here
they can dig out the email threads!
