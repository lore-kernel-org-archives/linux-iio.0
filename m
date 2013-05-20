Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eu1sys200aog111.obsmtp.com ([207.126.144.131]:57883 "EHLO
	eu1sys200aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754240Ab3ETHwL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 20 May 2013 03:52:11 -0400
From: Denis CIOCCA <denis.ciocca@st.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"lars@metafoo.de" <lars@metafoo.de>,
	"j.anaszewski@samsung.com" <j.anaszewski@samsung.com>
Date: Mon, 20 May 2013 09:51:38 +0200
Subject: Re: [PATCH 3/3] iio:pressure: Add STMicroelectronics pressures
 driver
Message-ID: <4675748.2RFENMIBLW@ctocwl0124>
References: <1368607493-4843-1-git-send-email-denis.ciocca@st.com>
 <1368607493-4843-4-git-send-email-denis.ciocca@st.com>
 <5197ED56.7000405@kernel.org>
In-Reply-To: <5197ED56.7000405@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan,

> Now going forward I'd of course like to see everyone happy with the
> resulting driver.  Denis do you have plans to implement the threshold
> events that were in the other driver proposal?
Now I'm very full but in the future I have plans to support the threshold 
events, I'm very happy if Jacek will help me! ;)


> Other than the request
> from Jacek to handle the other interrupt line choice I think that is
> all that is missing from here that was present there?
> (Of course you two will probably have a better idea of the differences)
For the interrupt lines, I'm working to support in all ST drivers the choice 
of interrupt line.


Thanks,
Denis