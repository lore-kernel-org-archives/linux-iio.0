Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-151.synserver.de ([212.40.185.151]:1051 "EHLO
	smtp-out-142.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932693AbaGWTYl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 23 Jul 2014 15:24:41 -0400
Message-ID: <53D00BBD.7080203@metafoo.de>
Date: Wed, 23 Jul 2014 21:23:41 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Gregory Fong <gregory.0xf0@gmail.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: ad5064: Explicitly configure whether to use
 external supply
References: <1392206518-1457-1-git-send-email-paul.cercueil@analog.com> <loom.20140723T010217-267@post.gmane.org>
In-Reply-To: <loom.20140723T010217-267@post.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/23/2014 01:06 AM, Gregory Fong wrote:
> Hi Paul,
>
> Paul Cercueil <paul.cercueil@...> writes:
>>
>> [snip]
>> - if CONFIG_REGULATOR is disabled, regulator_get() will always
>>    return a dummy regulator, which caused a device to always use
>>    the external vref mode, even though there is none.
>
> I noticed that this is still a problem in the current driver in the iio
> staging tree, are you planning to resubmit the fix for this part?

Yes. Although Paul is away for a few weeks, so this may take a while.

- Lars

