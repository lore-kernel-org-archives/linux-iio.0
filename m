Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-004.synserver.de ([212.40.185.4]:1088 "EHLO
	smtp-out-004.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566AbaFFOiz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 6 Jun 2014 10:38:55 -0400
Message-ID: <5391D279.5060909@metafoo.de>
Date: Fri, 06 Jun 2014 16:38:49 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Josselin Costanzi <josselin.costanzi@mobile-devices.fr>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: make blocking read wait for data
References: <1402065052-32161-1-git-send-email-josselin.costanzi@mobile-devices.fr>
In-Reply-To: <1402065052-32161-1-git-send-email-josselin.costanzi@mobile-devices.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/06/2014 04:30 PM, Josselin Costanzi wrote:
> Currently the IIO buffer blocking read only wait until at least one
> data element is available.

But that is how it is supposed to work. With this patch for example you 
won't be able to read the last data from the buffer after the buffer has 
been disabled. Or if for example n is not aligned to the sample size you'll 
also continue to loop forever.

- Lars
