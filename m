Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49723 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101AbbADQLi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 4 Jan 2015 11:11:38 -0500
Message-ID: <54A96639.6030203@kernel.org>
Date: Sun, 04 Jan 2015 16:11:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
	Octavian Purdila <octavian.purdila@intel.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 01/11] iio: buffer: fix custom buffer attributes copy
References: <1419122556-8100-1-git-send-email-octavian.purdila@intel.com> <1419122556-8100-2-git-send-email-octavian.purdila@intel.com> <54A9231E.1090706@kernel.org> <54A9253C.9080600@metafoo.de>
In-Reply-To: <54A9253C.9080600@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/01/15 11:34, Lars-Peter Clausen wrote:
> On 01/04/2015 12:25 PM, Jonathan Cameron wrote:
>> On 21/12/14 00:42, Octavian Purdila wrote:
>>> Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
>> Definitely looks like a bug has snuck in here.  Lars, it's your bit of code.
>> Want to just sanity check this fix before I apply it?
> 
> Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
Thanks.

Applied to the togreg branch of iio.git seeing as I haven't actually
sent the patch it is fixing upstream yet.

Jonathan
> 
> Thanks.
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

