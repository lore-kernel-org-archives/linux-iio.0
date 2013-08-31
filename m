Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42428 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753286Ab3HaRJE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 31 Aug 2013 13:09:04 -0400
Message-ID: <52223142.2070106@kernel.org>
Date: Sat, 31 Aug 2013 19:09:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Josh Wu <josh.wu@atmel.com>,
	Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PULL] IIO fixes for 3.11 - set 4
References: <521FBB99.3040205@kernel.org> <20130829213234.GA24433@kroah.com>
In-Reply-To: <20130829213234.GA24433@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/29/13 22:32, Greg KH wrote:
> On Thu, Aug 29, 2013 at 10:22:33PM +0100, Jonathan Cameron wrote:
>> The following changes since commit d8dfad3876e4386666b759da3c833d62fb8b2267:
>>
>>   Linux 3.11-rc7 (2013-08-25 17:43:22 -0700)
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-3.11d
>>
>> for you to fetch changes up to 947b8ec78610fdfd891da249629f79cfa8e5da57:
>>
>>   iio: at91: fix adc_clk overflow (2013-08-29 21:42:11 +0100)
>>
>> ----------------------------------------------------------------
>> 4th round of fixes for IIO in the 3.11 series.
>>
>> Another one patch pull request, this one for an overflow issue that
>> can occur in the at91 adc driver.
> 
> How "necessary" is this for 3.11? 
> Is it something that a user can hit today?
> Is it a regression from 3.10?
> Is it for a new driver?
No
> 
> It's really late in the 3.11 cycle for me to want to send anything to
> Linus except for "this fixes a major issue" type patches.  Can we just
> tag this for stable and have it show up in 3.11 after 3.12-rc1 is out?
Fine by me - have cc'd Josh and Maxime as they should be able to answer
the above better than me.

> 
> thanks,
> 
> greg k-h
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
