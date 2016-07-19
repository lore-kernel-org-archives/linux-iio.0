Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:52400 "EHLO mail.aswsp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751356AbcGSPQT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 19 Jul 2016 11:16:19 -0400
Message-ID: <578E4517.7040808@parrot.com>
Date: Tue, 19 Jul 2016 17:19:51 +0200
From: Gregor Boirie <gregor.boirie@parrot.com>
MIME-Version: 1.0
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: resource managed pollfunc
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear all,

I'm wondering why there are no resource managed versions of
iio_triggered_buffer_setup and iio_alloc_pollfunc.

Any particular reason ??

Regards,
Greg
