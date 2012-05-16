Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:49838 "HELO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758223Ab2EPB06 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 15 May 2012 21:26:58 -0400
Received: by werg1 with SMTP id g1so141563wer.13
        for <linux-iio@vger.kernel.org>; Tue, 15 May 2012 18:26:55 -0700 (PDT)
From: Ge Gao <ggao@invensense.com>
MIME-Version: 1.0
Date: Tue, 15 May 2012 18:26:54 -0700
Message-ID: <6e6a0f27b1900226df5350cc320f25bb@mail.gmail.com>
Subject: sw_ring.c poll problem
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear all,
	I found that ring_sw.c the poll function has to read half of the
data for poll to work. Basically, you have to fill half of the ring buffer
in order for poll to be triggrerred. You have to also read more than half
of the data for poll to be disappeared. This would pose problems. If you
have big ring buffer, the data will lost its immediacy. If you have small
ring buffer, the data could lost if not buffered enough. Is that possible
this poll action configurable? Or I missed anything.
	Thanks.

Best regards,

Ge GAO
