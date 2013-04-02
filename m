Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35451 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757181Ab3DBRhM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 2 Apr 2013 13:37:12 -0400
Message-ID: <515B1747.30500@kernel.org>
Date: Tue, 02 Apr 2013 18:37:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Laxman Dewangan <ldewangan@nvidia.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 0/4] iio:magnetometer:ak8975 cleanup and move out of staging.
References: <1364144310-32251-1-git-send-email-jic23@kernel.org> <515A7A06.2090608@nvidia.com>
In-Reply-To: <515A7A06.2090608@nvidia.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/02/2013 07:26 AM, Laxman Dewangan wrote:
> On Sunday 24 March 2013 10:28 PM, Jonathan Cameron wrote:
>> When I proposed moving this out of staging a while back, Lars-Peter
>> pointed out a few 'unusual' elements in the driver.  This series
>> addresses those and the interesting question of what the NOSTART flag
>> was doing there in the read code (came up in the dicussion of one of
>> Lars-Peter's points).
>>
>> The caching in the write is a little unnecessary, but isn't technically
>> incorrect so I haven't touched that.
>>
>> If anyone has one of these to test and make sure the changes haven't
>> broken anything that would be great!
>>
>> Thanks,
> 
> This series looks good.
> Acked-by: Laxman Dewangan <ldewangan@nvidia.com>
> 
Thanks, applied to the togreg branch of iio.git


