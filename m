Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eu1sys200aog121.obsmtp.com ([207.126.144.151]:60683 "EHLO
	eu1sys200aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753877Ab3IXJ1D (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 24 Sep 2013 05:27:03 -0400
From: Denis CIOCCA <denis.ciocca@st.com>
To: jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org
Subject: Added hrtimer trigger v2
Date: Tue, 24 Sep 2013 11:26:28 +0200
Message-Id: <1380014789-8636-1-git-send-email-denis.ciocca@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

This patch is the revision 2 of hrtimer iio trigger.
- Used int as trigger id instead of long;
- Fix Kconfig;
- checked maximium value of frequency (u16);

Thanks,
Denis

