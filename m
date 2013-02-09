Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ea0-f175.google.com ([209.85.215.175]:63781 "EHLO
	mail-ea0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757819Ab3BIRnX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 9 Feb 2013 12:43:23 -0500
Received: by mail-ea0-f175.google.com with SMTP id d1so2094690eab.20
        for <linux-iio@vger.kernel.org>; Sat, 09 Feb 2013 09:43:22 -0800 (PST)
From: Denis Ciocca <denis.ciocca@gmail.com>
To: jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org
Subject: Proposal to add full scale attribute
Date: Sat,  9 Feb 2013 18:34:56 +0100
Message-Id: <1360431297-18251-1-git-send-email-denis.ciocca@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

I everyone,

my patch (not working) is a proposal to add full scale attribute to change
the current full scale for devices. The patch doesn't work because the function
for_each_set_bit in the industrialio-core.c use the type unsigned long and
the new entry is too big. However, what do you think about?

Thanks,

Denis
 
