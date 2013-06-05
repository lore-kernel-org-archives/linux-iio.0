Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eu1sys200aog107.obsmtp.com ([207.126.144.123]:52611 "EHLO
	eu1sys200aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751908Ab3FEHVo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 5 Jun 2013 03:21:44 -0400
From: Denis CIOCCA <denis.ciocca@st.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org
Subject: missed one VLA... 
Date: Wed,  5 Jun 2013 09:21:28 +0200
Message-Id: <1370416890-4659-1-git-send-email-denis.ciocca@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan,

I checked your modify and it's ok for me.
Only one thing to check memory allocation in the attached patch.
Many thanks Jonathan!

Denis

