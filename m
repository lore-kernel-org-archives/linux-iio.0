Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:39168 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750723AbbG0Hrn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jul 2015 03:47:43 -0400
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NS4001UUYZH9G30@mailout3.w1.samsung.com> for
 linux-iio@vger.kernel.org; Mon, 27 Jul 2015 08:47:41 +0100 (BST)
Message-id: <55B5E21B.6000107@samsung.com>
Date: Mon, 27 Jul 2015 09:47:39 +0200
From: Karol Wrona <k.wrona@samsung.com>
MIME-version: 1.0
To: Joo Aun Saw <jasaw@dius.com.au>, linux-iio@vger.kernel.org
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: iio_utils.c defines _IIO_UTILS_H
References: <CA+0Dg4o_D-U-=z=4FwC=aWe0CGH+wHPe1tqrDQudR1n89bBByg@mail.gmail.com>
In-reply-to: <CA+0Dg4o_D-U-=z=4FwC=aWe0CGH+wHPe1tqrDQudR1n89bBByg@mail.gmail.com>
Content-type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/27/2015 06:21 AM, Joo Aun Saw wrote:
> Hi,
> 
> What is the purpose of having ifndef _IIO_UTILS_H and define
> _IIO_UTILS_H at the top of iio_utils.c file? Is this a copy and paste
> error from the original iio_utils.h file?

Looks like sth added by merge: dc5f2c5f6aa159ebf4b29b169aa1f71cf98d3d6a
I think you can remove that guard.

> 
> 
> Joo.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

