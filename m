Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-165.synserver.de ([212.40.185.165]:1120 "EHLO
	smtp-out-165.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752708AbaGGMg1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 7 Jul 2014 08:36:27 -0400
Message-ID: <53BA9447.6070301@metafoo.de>
Date: Mon, 07 Jul 2014 14:36:23 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>,
	Himangi Saraogi <himangi774@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
CC: julia.lawall@lip6.fr
Subject: Re: [PATCH] staging: iio: Introduce the use of devm_ioremap_resource
References: <20140701184413.GA2980@himangi-Dell> <53BA9469.7000600@kernel.org>
In-Reply-To: <53BA9469.7000600@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/07/2014 02:36 PM, Jonathan Cameron wrote:
> On 01/07/14 19:44, Himangi Saraogi wrote:
>> This patch introduces the use of devm_ioremap_resource. It does away
>> with call to request_mem_region and the error checking on
>> platform_get_resource. Also, the calls to free the allocated resources
>> like release_mem_region and iounmap are done away with. The ret variable
>> in the probe function is also eliminated. Also, a bug is fixed as the
>> goto in the error handling of request_mem_region should not have
>> called release_mem_region which releases a resource that has not been
>> allocated.
>>
>> Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
>> Acked-by: Julia Lawall <julia.lawall@lip6.fr>
> Again, looks superficially fine, but I'd like an ack from someone
> at Analog ideally.
> Cc'd Lars

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.

