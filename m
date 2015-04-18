Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33145 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753801AbbDRSMo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 18 Apr 2015 14:12:44 -0400
Message-ID: <55329E9A.3020805@kernel.org>
Date: Sat, 18 Apr 2015 19:12:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Daniel Baluta <daniel.baluta@intel.com>
CC: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: light: hid-sensor-prox: Fix modifier
References: <1429048402-5311-1-git-send-email-srinivas.pandruvada@linux.intel.com>	 <CAEnQRZAxAWnQ_sGestwJ+NsHxCN=DqUHAjVhZpM04pWj3eQNgw@mail.gmail.com> <1429199662.24805.40.camel@spandruv-DESK3.jf.intel.com>
In-Reply-To: <1429199662.24805.40.camel@spandruv-DESK3.jf.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/04/15 16:54, Srinivas Pandruvada wrote:
> On Wed, 2015-04-15 at 15:01 +0300, Daniel Baluta wrote: 
>> On Wed, Apr 15, 2015 at 12:53 AM, Srinivas Pandruvada
>> <srinivas.pandruvada@linux.intel.com> wrote:
>>> Currently in_proximity_(null)_raw is getting presented as raw sysfs
>>> attribute. Same with the scan_elements.
>>> The modifier doesn't apply to this channel.
>>>
>>> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>>> ---
>>
>> Would be also nice to add a line like this:
>>
>> Fixes COMMIT_ID ("Commit subject")
It is a nice convention, but when it's been a bug for all versions of the
file that have ever been in the tree, it's not so important.
>>
>> in order for stable teams to pick this up.
> We can add tag
> Cc: stable@vger.kernel.org
> 
> Usually Jonathan copies after his merge.
I will indeed.

Applied to the fixes-togreg branch of iio.git and marked for
stable.
> 
> Thanks,
> Srinivas
> 
>>
>> thanks,
>> Daniel.
> 
> 

