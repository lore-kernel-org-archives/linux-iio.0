Return-Path: <lars@metafoo.de>
Message-ID: <524A7EEF.9030805@metafoo.de>
Date: Tue, 01 Oct 2013 09:51:11 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 07/18] staging:iio:lis3l02dq: Switch to new event config
 interface
References: <1380200317-19355-1-git-send-email-lars@metafoo.de> <1380200317-19355-7-git-send-email-lars@metafoo.de> <5249E55B.8040205@kernel.org>
In-Reply-To: <5249E55B.8040205@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 09/30/2013 10:55 PM, Jonathan Cameron wrote:
> On 09/26/13 13:58, Lars-Peter Clausen wrote:
>> Switch the lis3l02dq driver to the new IIO event config interface as the old one
>> is going to be removed.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Hi Lars,
> 
> As this one is in staging, lets take advantage of the fact that we now
> have the ability to have shared elements.  It's an ABI change so I wouldn't
> suggest this for drivers outside staging.
> 
> The threshold value is shared by all channels (only one address to write) for each
> of the two types.

Ok, I'll add that to the series, but as a separate patch. One patch for
changing to the new API, one patch for changing the behavior.

- Lars
