Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47813 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779AbaLZVyd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 26 Dec 2014 16:54:33 -0500
Message-ID: <549DD916.1050904@kernel.org>
Date: Fri, 26 Dec 2014 21:54:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
	Vlad Dogaru <vlad.dogaru@intel.com>, linux-iio@vger.kernel.org,
	knaack.h@gmx.de
Subject: Re: [PATCH v2] iio: ensure scan index is unique at buffer register
References: <1418394390-19690-1-git-send-email-vlad.dogaru@intel.com> <5493016D.7000602@metafoo.de>
In-Reply-To: <5493016D.7000602@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/12/14 16:31, Lars-Peter Clausen wrote:
> On 12/12/2014 03:26 PM, Vlad Dogaru wrote:
>> Having two or more channels with the same positive scan_index field
>> makes no sense.  Prevent this situation by failing to register a buffer
>> if two scan indexes are identical.
>>
>> Signed-off-by: Vlad Dogaru <vlad.dogaru@intel.com>
> 
> Looks ok, although I'm not convinced that we really need it.
> 
> Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
> 
> [...]
I'm kind of mildly in favour of things that make bugs
less likely.  However, I think this fell foul of Lars'
recent set of cleanups for the buffered code.

Could you rebase on my togreg branch.
https://git.kernel.org/cgit/linux/kernel/git/jic23/iio.git/log/?h=togreg

Thanks

Jonathan

