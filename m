Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:35805 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752943Ab3EMH2G (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 13 May 2013 03:28:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glki-linux-iio@m.gmane.org>)
	id 1UbnAz-0002yD-Oz
	for linux-iio@vger.kernel.org; Mon, 13 May 2013 09:28:05 +0200
Received: from 217-67-201-162.itsa.net.pl ([217.67.201.162])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-iio@vger.kernel.org>; Mon, 13 May 2013 09:28:05 +0200
Received: from j.anaszewski by 217-67-201-162.itsa.net.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-iio@vger.kernel.org>; Mon, 13 May 2013 09:28:05 +0200
To: linux-iio@vger.kernel.org
From: Jacek Anaszewski <j.anaszewski@samsung.com>
Subject: Re: [NEW DRIVER] LPS331AP barometer sensor driver
Date: Mon, 13 May 2013 09:27:51 +0200
Message-ID: <kmq4li$8a5$1@ger.gmane.org>
References: <1368176965-23190-1-git-send-email-j.anaszewski@samsung.com> <2454453.7GbGA1kxYy@elitebook-8460p>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
In-Reply-To: <2454453.7GbGA1kxYy@elitebook-8460p>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/10/2013 11:31 AM, Denis CIOCCA wrote:
> Hi Jacek,
>
> for the STMicroelectronics MEMS I have wrote one common library
> (common/st_sensors) that implements some common features for our devices.
> Now I'm working on to submit the patch for all our barometer sensors using
> also trigger and buffer.


Hi Denis,

Could you share your code, even if it is not entirely completed,
so that I could compare it with my solution?

Thanks,
Jacek

