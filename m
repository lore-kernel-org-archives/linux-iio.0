Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42739 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976AbaCBVqS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 2 Mar 2014 16:46:18 -0500
Message-ID: <5313A6D9.5030300@kernel.org>
Date: Sun, 02 Mar 2014 21:47:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: "fugang.duan@freescale.com" <fugang.duan@freescale.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] iio:adc:vf610 ensure correct handing of interruption
 of wait for completion
References: <1393711367-2210-1-git-send-email-jic23@kernel.org> <14cec064ee944b29baf52f88cca1cf15@BLUPR03MB373.namprd03.prod.outlook.com>
In-Reply-To: <14cec064ee944b29baf52f88cca1cf15@BLUPR03MB373.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/03/14 01:36, fugang.duan@freescale.com wrote:
> From: Jonathan Cameron <jic23@kernel.org>
> Data: Sunday, March 02, 2014 6:03 AM
>
>> To: linux-iio@vger.kernel.org
>> Cc: Jonathan Cameron; Dan Carpenter; Duan Fugang-B38611
>> Subject: [PATCH] iio:adc:vf610 ensure correct handing of interruption of wait
>> for completion
>>
>> Issue highlighted by smatch warning:
>>
>> CHECK   drivers/iio/adc/vf610_adc.c
>> drivers/iio/adc/vf610_adc.c:466 vf610_read_raw() warn: unsigned 'ret' is never
>> less than zero.
>>
>> As wait_for_completion_interruptible_timeout can return -ERESTARTSTSYS, if
>> interrupted, ret must be signed.
>>
>> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
>
> Acked-by: Fugang Duan <B38611@freescale.com>
Applied to the togreg branch of iio.git.

