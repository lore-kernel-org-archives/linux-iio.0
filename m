Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:59189 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754068Ab2EPFqr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 16 May 2012 01:46:47 -0400
References: <6e6a0f27b1900226df5350cc320f25bb@mail.gmail.com>
In-Reply-To: <6e6a0f27b1900226df5350cc320f25bb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: sw_ring.c poll problem
From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Wed, 16 May 2012 06:46:44 +0100
To: Ge Gao <ggao@invensense.com>, Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org
Message-ID: <9d0339d0-2cde-4605-a8b0-99f568d05eb8@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



Ge Gao <ggao@invensense.com> wrote:

>Dear all,
>	I found that ring_sw.c the poll function has to read half of the
>data for poll to work. Basically, you have to fill half of the ring
>buffer
>in order for poll to be triggrerred. You have to also read more than
>half
>of the data for poll to be disappeared. This would pose problems. If
>you
>have big ring buffer, the data will lost its immediacy. If you have
>small
>ring buffer, the data could lost if not buffered enough. Is that
>possible
>this poll action configurable? Or I missed anything.

Use kfifobuf instead. Sw _ring is going away anyway.
>	Thanks.
>
>Best regards,
>
>Ge GAO
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
