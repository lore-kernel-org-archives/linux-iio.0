Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58139 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073AbbHLVIH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Aug 2015 17:08:07 -0400
Subject: Re: [PULL v2] Second set of new drivers, functionality and cleanup
 for IIO in the 4.3 cycle (+ some fixes)
To: Greg KH <gregkh@linuxfoundation.org>
References: <55CB9E42.907@kernel.org> <20150812194508.GA4279@kroah.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55CBB5B3.1050307@kernel.org>
Date: Wed, 12 Aug 2015 22:08:03 +0100
MIME-Version: 1.0
In-Reply-To: <20150812194508.GA4279@kroah.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/08/15 20:45, Greg KH wrote:
> On Wed, Aug 12, 2015 at 08:28:02PM +0100, Jonathan Cameron wrote:
>> The following changes since commit b8d1f261fe7e4967593a5637d62991b6197a03f8:
>>
>>   staging: dgap: remove duplicate code (2015-07-16 10:19:55 -0700)
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-4.3b-2
> 
> I had to do a merge conflict resolution in one driver, it was pretty
> trivial, but if you could check I got it right, that would be great.
> 
> thanks,
> 
> greg k-h
I guess that would be the mlx90614.c (mentioned in the reply to the previous
pull request so knew that one was coming!)

Looks fine to me.

Thanks

Jonathan


