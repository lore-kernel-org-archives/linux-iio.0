Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:54773 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754181Ab3EQPAf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 17 May 2013 11:00:35 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glki-linux-iio@m.gmane.org>)
	id 1UdM93-0003vc-WC
	for linux-iio@vger.kernel.org; Fri, 17 May 2013 17:00:34 +0200
Received: from 217-67-201-162.itsa.net.pl ([217.67.201.162])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-iio@vger.kernel.org>; Fri, 17 May 2013 17:00:33 +0200
Received: from j.anaszewski by 217-67-201-162.itsa.net.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-iio@vger.kernel.org>; Fri, 17 May 2013 17:00:33 +0200
To: linux-iio@vger.kernel.org
From: Jacek Anaszewski <j.anaszewski@samsung.com>
Subject: Re: [PATCH 3/3] iio:pressure: Add STMicroelectronics pressures driver
Date: Fri, 17 May 2013 17:00:21 +0200
Message-ID: <51964605.6050707@samsung.com>
References: <1368607493-4843-1-git-send-email-denis.ciocca@st.com> <1368607493-4843-4-git-send-email-denis.ciocca@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: public-jic23-DgEjT+Ai2ygdnm+yROfE0A@plane.gmane.org,
	public-linux-iio-u79uwXL29TY76Z2rM5mHXA@plane.gmane.org,
	public-lars-Qo5EllUWu/uELgA04lAiVw@plane.gmane.org
In-Reply-To: <1368607493-4843-4-git-send-email-denis.ciocca@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/15/2013 10:44 AM, Denis CIOCCA wrote:
> This patch adds a generic pressure driver for STMicroelectronics
> pressures, currently it supports: LPS331AP.
>
> Signed-off-by: Denis Ciocca<denis.ciocca@st.com>

Hi Denis,

I have tested your driver with Samsung Exynos4x12 PQ/M0 board and in 
general it works fine, except of one issue.
Triggers can be used only when INT1 interrupt source is exploited.
On the test board I am using there is INT2 interrupt source routed to 
the CPU, and I had to change ST_PRESS_1_DRDY_IRQ_MASK constant defined
in the st_pressure_core.c file to 0x20, to instruct the device to
to generate the 'data ready' interrupts on the INT2 pin.
I think that information about used interrupt source should be passed 
through platform_data and/or of_tree. For the of_tree there is ready 
solution available in my patch for this barometer.

Thanks,
Jacek

