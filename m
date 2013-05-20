Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:60739 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751766Ab3ETJsJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 20 May 2013 05:48:09 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glki-linux-iio@m.gmane.org>)
	id 1UeMhI-0005QF-Gv
	for linux-iio@vger.kernel.org; Mon, 20 May 2013 11:48:04 +0200
Received: from 217-67-201-162.itsa.net.pl ([217.67.201.162])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-iio@vger.kernel.org>; Mon, 20 May 2013 11:48:04 +0200
Received: from j.anaszewski by 217-67-201-162.itsa.net.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-iio@vger.kernel.org>; Mon, 20 May 2013 11:48:04 +0200
To: linux-iio@vger.kernel.org
From: Jacek Anaszewski <j.anaszewski@samsung.com>
Subject: Re: [PATCH 3/3] iio:pressure: Add STMicroelectronics pressures driver
Date: Mon, 20 May 2013 11:47:54 +0200
Message-ID: <5199F14A.5040309@samsung.com>
References: <1368607493-4843-1-git-send-email-denis.ciocca@st.com> <1368607493-4843-4-git-send-email-denis.ciocca@st.com> <5197ED56.7000405@kernel.org> <4675748.2RFENMIBLW@ctocwl0124>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Jonathan Cameron
	<public-jic23-DgEjT+Ai2ygdnm+yROfE0A@plane.gmane.org>,
	"linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org"
	<public-linux-iio-u79uwXL29TY76Z2rM5mHXA@plane.gmane.org>,
	"lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org"
	<public-lars-Qo5EllUWu/uELgA04lAiVw@plane.gmane.org>,
	"j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org"
	<public-j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@plane.gmane.org>
In-Reply-To: <4675748.2RFENMIBLW@ctocwl0124>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/20/2013 09:51 AM, Denis CIOCCA wrote:
> Hi Jonathan,
>
>> Now going forward I'd of course like to see everyone happy with the
>> resulting driver.  Denis do you have plans to implement the threshold
>> events that were in the other driver proposal?
> Now I'm very full but in the future I have plans to support the threshold
> events, I'm very happy if Jacek will help me! ;)

Hi Jonathan, Denis,

The threshold events weren't supported in my driver proposal - the 
events were related only to the 'data ready' interrupts. I've been
playing with threshold interrupts during development, but I didn't
find the device reliable by minimal threshold levels. I've lately
devised a procedure of testing greater pressure differences and
I will test it within few weeks, as currently I am working on
another driver.

Thanks,
Jacek

