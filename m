Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52907 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751939Ab3JAJKA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 1 Oct 2013 05:10:00 -0400
Message-ID: <524A9F93.1020904@kernel.org>
Date: Tue, 01 Oct 2013 11:10:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 01/15] staging:iio:hmc5843: Add pointer to i2c client
 to data struct
References: <1379619360-8150-1-git-send-email-pmeerw@pmeerw.net> <1379619360-8150-2-git-send-email-pmeerw@pmeerw.net> <523D78EB.9070205@kernel.org> <524A988E.4040707@kernel.org> <alpine.DEB.2.01.1310011042260.2833@pmeerw.net>
In-Reply-To: <alpine.DEB.2.01.1310011042260.2833@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/01/13 09:44, Peter Meerwald wrote:
> 
>> I clearly have too much time on my hands this morning.  Pesky teachers strike and kid
>> still asleep ;)
>> Anyhow have fixed the wrong paramter up and applied to the togreg branch of iio.git
> 
> opposite is true for me at the moment; I have yet to fix up the suggested 
> scale vs. calibscale cleanup
Sure, no particular rush.  I just like to minimize how many patches I have
queued up to make me feel slightly less guilty for the amount of time they
have been sitting there (even if it is only half a set ;)
> 
> I think the broken code gets removed in the next commit anyway
Indeed, it is gone fairly soon after.

The reset of this series are fine so I'll pick those up once you have
done the scale vs calibscale stuff in patch 7.

Thanks,

Jonathan
