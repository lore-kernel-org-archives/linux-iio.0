Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eu1sys200aog101.obsmtp.com ([207.126.144.111]:51225 "EHLO
	eu1sys200aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754250Ab3EQQKO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 17 May 2013 12:10:14 -0400
From: Denis CIOCCA <denis.ciocca@st.com>
To: Jacek Anaszewski <j.anaszewski@samsung.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"public-jic23-DgEjT+Ai2ygdnm+yROfE0A@plane.gmane.org"
	<public-jic23-DgEjT+Ai2ygdnm+yROfE0A@plane.gmane.org>,
	"public-linux-iio-u79uwXL29TY76Z2rM5mHXA@plane.gmane.org"
	<public-linux-iio-u79uwXL29TY76Z2rM5mHXA@plane.gmane.org>,
	"public-lars-Qo5EllUWu/uELgA04lAiVw@plane.gmane.org"
	<public-lars-Qo5EllUWu/uELgA04lAiVw@plane.gmane.org>
Date: Fri, 17 May 2013 18:09:47 +0200
Subject: Re: [PATCH 3/3] iio:pressure: Add STMicroelectronics pressures
 driver
Message-ID: <1960700.DTgty5ARz5@ctocwl0124>
References: <1368607493-4843-1-git-send-email-denis.ciocca@st.com>
 <1368607493-4843-4-git-send-email-denis.ciocca@st.com>
 <51964605.6050707@samsung.com>
In-Reply-To: <51964605.6050707@samsung.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jacek,

> I have tested your driver with Samsung Exynos4x12 PQ/M0 board and in
> general it works fine, except of one issue.
ok good news.

> Triggers can be used only when INT1 interrupt source is exploited.
Yes you have right. Now all ST mems use INT1 as data-ready generator!

> I think that information about used interrupt source should be passed
> through platform_data and/or of_tree. For the of_tree there is ready
> solution available in my patch for this barometer.
I think the best solution is a new patch to fix this issue for all ST mems. I 
can do it in next days...


Thanks,
Denis