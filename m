Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 90-46-11-204.rar.beartech.net ([204.11.46.90]:61406 "EHLO
	exchsrvr.taosinc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932625Ab1CWTpS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 23 Mar 2011 15:45:18 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Interrupt_req vs. iio_register_interrupt_line
Date: Wed, 23 Mar 2011 14:45:17 -0500
Message-ID: <B4B07CCC7B7A084E989CF9386538EA1D63A8EA@exchsrvr.taosinc.com>
From: "Jon Brenner" <jbrenner@TAOSinc.com>
To: <linux-iio@vger.kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,
Can someone please explain the purpose / advantage of using:
'iio_register_interrupt_line' vs. just using using 'request_irq'?
It appears that the iio_register_interrupt_line uses request_irq anyway.
Can direct me to iio documentation that would present this.lin

Thanks!
Jon

jbrenner@taosinc.com

