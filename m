Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-165.synserver.de ([212.40.185.165]:1132 "EHLO
	smtp-out-165.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752917AbaGGMzR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 7 Jul 2014 08:55:17 -0400
Message-ID: <53BA98AD.4040407@metafoo.de>
Date: Mon, 07 Jul 2014 14:55:09 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Julia Lawall <julia.lawall@lip6.fr>,
	Jonathan Cameron <jic23@kernel.org>
CC: Himangi Saraogi <himangi774@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Michael Hennerich <hennerich@blackfin.uclinux.org>
Subject: Re: [PATCH v2] iio:trigger: Introduce the use of devm_kzalloc
References: <20140701211908.GA23193@himangi-Dell> <53BA93F2.2090200@kernel.org> <alpine.DEB.2.10.1407071451420.4757@hadrien>
In-Reply-To: <alpine.DEB.2.10.1407071451420.4757@hadrien>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/07/2014 02:52 PM, Julia Lawall wrote:
> On Mon, 7 Jul 2014, Jonathan Cameron wrote:
>
>> On 01/07/14 22:19, Himangi Saraogi wrote:
>>> This patch introduces the use of the managed version of kzalloc and
>>> removes the kfrees in the probe and remove functions. More return
>>> paths are added and the labels are renamed to order them.
>>>
>>> Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
>> Looks sane, but I'd like an ack or reviewed-by from someone as Analog for this
>> one.
>> cc'd Lars and Michael.
>
> Should MAINTAINERS be updated somehow?
>
> julia

yea, it's been on my todo list for a while.

