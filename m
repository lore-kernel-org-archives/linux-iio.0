Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from na3sys009aog136.obsmtp.com ([74.125.149.85]:35767 "HELO
	na3sys009aog136.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932320Ab2EJXxr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 10 May 2012 19:53:47 -0400
Received: by wgbdr13 with SMTP id dr13so1520507wgb.13
        for <linux-iio@vger.kernel.org>; Thu, 10 May 2012 16:53:44 -0700 (PDT)
From: Ge Gao <ggao@invensense.com>
MIME-Version: 1.0
Date: Thu, 10 May 2012 16:53:43 -0700
Message-ID: <dca0c620c60e1144778bfea74da1336b@mail.gmail.com>
Subject: trigger removal problem.
To: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear all,

                I am building my IIO driver as a module and will
constantly need to use "insmod" and "rmmod" to install it and remove it
due to development. However, I found that if I write anything to the
"trigger/current_trigger", it will not be able to remove it. The error
code is (11). Even I write "null" to it, it will not be able to be
removed.
However, If I don't write anything to it, just insmod and rmmod, it will
be remove successfully. Any idea what could cause this problem? I followed
what is in the IIO subsystem driver to write my driver. I can post it if
anyone want to take a look.

                Thanks.



Ge
