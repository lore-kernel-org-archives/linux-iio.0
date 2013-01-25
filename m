Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ee0-f52.google.com ([74.125.83.52]:49216 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753547Ab3AYXpC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 25 Jan 2013 18:45:02 -0500
Received: by mail-ee0-f52.google.com with SMTP id b15so449766eek.11
        for <linux-iio@vger.kernel.org>; Fri, 25 Jan 2013 15:45:00 -0800 (PST)
From: Denis Ciocca <denis.ciocca@gmail.com>
To: denis.ciocca@gmail.com, jic23@kernel.org, lars@metafoo.de,
	linux-iio@vger.kernel.org
Subject: STMicroelectronics IIO driver
Date: Sat, 26 Jan 2013 00:44:44 +0100
Message-Id: <1359157488-15969-1-git-send-email-denis.ciocca@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan, Lars,

I modified the drivers following the advice of Lars (about code duplication) and Jonathan patches.
I also used coccicheck to verify the code. I couldn't test the drivers on the physical devices because I was not in office. I hope to do some tests Monday morning. 

Thanks and Best Regards,

Denis
 
