Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43018 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751872Ab3A1UOm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 28 Jan 2013 15:14:42 -0500
Message-ID: <5106DC2F.60501@kernel.org>
Date: Mon, 28 Jan 2013 20:14:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Denis Ciocca <denis.ciocca@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: STMicroelectronics IIO driver
References: <1359157488-15969-1-git-send-email-denis.ciocca@st.com> <51068BAE.9090801@metafoo.de>
In-Reply-To: <51068BAE.9090801@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/28/2013 02:31 PM, Lars-Peter Clausen wrote:
> On 01/26/2013 12:44 AM, Denis Ciocca wrote:
>> Hi Jonathan, Lars,
>>
>> I modified the drivers following the advice of Lars (about code duplication) and Jonathan patches.
>> I also used coccicheck to verify the code. I couldn't test the drivers on the physical devices because I was not in office. I hope to do some tests Monday morning. 
>>
>> Thanks and Best Regards,
>>
>> Denis
>>  
> 
> Hi,
> 
> I think the driver is now in a state where we can merge it, good work.
> There are one or two rough edges left, but no blockers and nothing that
> can't be fixed in follow up patches. (And to be honest I'm kind of tired of
> reviewing the same code over and over again ;))
> 
> So for the whole series:
> 
> Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
Thanks Lars.

Applied to togreg branch of iio.git.  Note there was some fuzz on patches
2 and 3  + need to do a merge on patch 2 due to makefile changes.  Denis,
could you verify I didn't mess it up (as I am occasionally known to do ;)

This won't go to Greg until next weekend anyway now.

Jonathan
> 
> 
> - Lars
> 
