Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eu1sys200aog121.obsmtp.com ([207.126.144.151]:59314 "EHLO
	eu1sys200aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751154Ab3KUM3J convert rfc822-to-8bit
	(ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 21 Nov 2013 07:29:09 -0500
From: Denis CIOCCA <denis.ciocca@st.com>
To: "jic23@kernel.org" <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Thu, 21 Nov 2013 13:28:50 +0100
Subject: [PATCH 05/11] iio:st sensors: remove custom sampling frequence
 attribute in favour of core support.
Message-ID: <528DFC82.6090908@st.com>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan,

I think is a good thing do the porting some features inside the 
framework, but I think is also important don't change the userspace 
interface.

For example now we are developing same libraries and applications that 
using those files. What do you think to add on each driver one sysfs 
file called 'version' that will be updated when the userspace interface 
is changed?

Thanks,
Denis