Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54893 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833Ab3KUPDp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 21 Nov 2013 10:03:45 -0500
In-Reply-To: <528DFC82.6090908@st.com>
References: <528DFC82.6090908@st.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 05/11] iio:st sensors: remove custom sampling frequence attribute in favour of core support.
From: Jonathan Cameron <jic23@kernel.org>
Date: Thu, 21 Nov 2013 15:03:04 +0000
To: Denis CIOCCA <denis.ciocca@st.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Message-ID: <ca9fd1ad-43a0-45a7-ab11-fde361636797@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



Denis CIOCCA <denis.ciocca@st.com> wrote:
>Hi Jonathan,
>
>I think is a good thing do the porting some features inside the 
>framework, but I think is also important don't change the userspace 
>interface.
>
>For example now we are developing same libraries and applications that 
>using those files. What do you think to add on each driver one sysfs 
>file called 'version' that will be updated when the userspace interface
>
>is changed?
Unfortunately the chances are that an app won't read it so that doesn't get around abi changes.

>
>Thanks,
>Denis

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
