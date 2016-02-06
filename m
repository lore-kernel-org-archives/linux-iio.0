Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-057.synserver.de ([212.40.185.57]:1518 "EHLO
	smtp-out-190.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751441AbcBFL2n (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 6 Feb 2016 06:28:43 -0500
Subject: Re: [PATCH 1/2] staging:iio:ad7606: Consolidate PM ops
To: Jonathan Cameron <jic23@kernel.org>
References: <1454668354-11450-1-git-send-email-lars@metafoo.de>
 <56B5D783.6040504@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <56B5D8E6.9060409@metafoo.de>
Date: Sat, 6 Feb 2016 12:28:38 +0100
MIME-Version: 1.0
In-Reply-To: <56B5D783.6040504@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/06/2016 12:22 PM, Jonathan Cameron wrote:
> On 05/02/16 10:32, Lars-Peter Clausen wrote:
>> Both the SPI and platform device driver for the ad7606 use the same set of
>> PM ops. Consolidate them in the common part of the driver.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Lars, this doesn't apply to the togreg branch.
> 
> Looks like you are locally missing the patch:
> 
> 0046a46a8f93f5b99b499118779521ba3b017d69
> staging/ad7606: Actually build the interface modules 

Which is not yet in the public togreg branch. I'll rebase and resend next
week when the public branch has been updated.

- Lars

