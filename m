Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eu1sys200aog110.obsmtp.com ([207.126.144.129]:41927 "EHLO
	eu1sys200aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758076Ab3FCO7b (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 3 Jun 2013 10:59:31 -0400
From: Denis CIOCCA <denis.ciocca@st.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, frederic.pillon@stericsson.com,
	lee.jones@stericcson.com
Subject: STMicroelectronics series of patches to support pressure sensors 
Date: Mon,  3 Jun 2013 16:58:49 +0200
Message-Id: <1370271532-10194-1-git-send-email-denis.ciocca@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan,

I modified the series of patches to avoid the VLAs issues replacing them with kmalloc statements. It's correctly?
Thanks,

Denis

