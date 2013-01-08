Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eu1sys200aog117.obsmtp.com ([207.126.144.143]:33305 "EHLO
	eu1sys200aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755295Ab3AHQbL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 8 Jan 2013 11:31:11 -0500
From: Denis CIOCCA <denis.ciocca@st.com>
To: jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org
Subject: iio: STMicroelectronics iio drivers
Date: Tue,  8 Jan 2013 17:30:22 +0100
Message-Id: <1357662626-335-1-git-send-email-denis.ciocca@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi everybody,

I modified the ST drivers in accordance with Jonathan comments. I couldn't use
coccicheck because I have some problem when I run 'make coccichek' (I'm working on to
undestand why).

The others major updates are: 
- delete of try_reenable_callback (was not necessary);
- trigger code moved to sensors common code;
- bugfix DMA buffer cacheline-aligned;
- check if the device probed is corrected to avoid confusion;
- improvement of code style;

Thanks,

Denis

