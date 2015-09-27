Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36703 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755611AbbI0Nrt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 27 Sep 2015 09:47:49 -0400
Subject: Re: [PATCH 2/2] Staging: iio: cdc: Remove unnecessary dev_info
To: Lars-Peter Clausen <lars@metafoo.de>,
	Shraddha Barke <shraddha.6596@gmail.com>
References: <1443201782-25863-1-git-send-email-shraddha.6596@gmail.com>
 <1443201782-25863-3-git-send-email-shraddha.6596@gmail.com>
 <5606D26C.2000405@metafoo.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5607F383.6000701@kernel.org>
Date: Sun, 27 Sep 2015 14:47:47 +0100
MIME-Version: 1.0
In-Reply-To: <5606D26C.2000405@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 26/09/15 18:14, Lars-Peter Clausen wrote:
> On 09/25/2015 07:23 PM, Shraddha Barke wrote:
>> Remove dev_info as the information can be obtained by other means
>>
>> Signed-off-by: Shraddha Barke <shraddha.6596@gmail.com>
> 
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Applied, thanks Shraddha,

Keep up the good work, these drivers have been in staging way too long!

Jonathan
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

