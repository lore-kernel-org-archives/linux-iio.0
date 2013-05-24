Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eu1sys200aog118.obsmtp.com ([207.126.144.145]:54883 "EHLO
	eu1sys200aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752208Ab3EXO0A (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 24 May 2013 10:26:00 -0400
From: Denis CIOCCA <denis.ciocca@st.com>
To: jic23@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
	j.anaszewski@samsung.com, lee.jones@stericsson.com
Subject: Support pressure sensors 
Date: Fri, 24 May 2013 16:25:14 +0200
Message-Id: <1369405517-2619-1-git-send-email-denis.ciocca@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan, all,

I have modified the previous series of patch to support the pressure sensors.
The major modifications are:

- removed stuff macros;
- added support on st-sensor-library for 3 channel data;
- removed one-shot reading function on pressure driver (integrated on st-sensor-library);
- removed specific function for buffer in pressure driver (integrated on st-sensor-library), as Jonathan suggest me;

Thanks,
Denis

