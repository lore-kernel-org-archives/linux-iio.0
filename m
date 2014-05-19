Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:63345 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751074AbaESPpI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 19 May 2014 11:45:08 -0400
Received: from [192.168.178.21] ([78.54.49.216]) by mail.gmx.com (mrgmx103)
 with ESMTPSA (Nemesis) id 0LaGfK-1XBGii34JS-00m3zR for
 <linux-iio@vger.kernel.org>; Mon, 19 May 2014 17:45:06 +0200
Message-ID: <537A2702.8090803@gmx.de>
Date: Mon, 19 May 2014 17:45:06 +0200
From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
MIME-Version: 1.0
To: linux-iio@vger.kernel.org
Subject: format string mismtach
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

cppcheck reported :

[drivers/staging/iio/Documentation/iio_utils.h:321]: (warning) %u in format string (no. 1) requires 'unsigned int *' but the argument type is 'int *'.
[drivers/staging/iio/Documentation/iio_utils.h:353]: (warning) %u in format string (no. 1) requires 'unsigned int *' but the argument type is 'int *'.

trivial patches IMO - are they already queued up ?

-- 
Toralf

