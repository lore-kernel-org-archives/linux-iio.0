Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-050.synserver.de ([212.40.185.50]:1041 "EHLO
	smtp-out-050.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905AbbADLe0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 4 Jan 2015 06:34:26 -0500
Message-ID: <54A9253C.9080600@metafoo.de>
Date: Sun, 04 Jan 2015 12:34:20 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>,
	Octavian Purdila <octavian.purdila@intel.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 01/11] iio: buffer: fix custom buffer attributes copy
References: <1419122556-8100-1-git-send-email-octavian.purdila@intel.com> <1419122556-8100-2-git-send-email-octavian.purdila@intel.com> <54A9231E.1090706@kernel.org>
In-Reply-To: <54A9231E.1090706@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/04/2015 12:25 PM, Jonathan Cameron wrote:
> On 21/12/14 00:42, Octavian Purdila wrote:
>> Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
> Definitely looks like a bug has snuck in here.  Lars, it's your bit of code.
> Want to just sanity check this fix before I apply it?

Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.
