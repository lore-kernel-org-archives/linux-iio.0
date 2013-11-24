Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43284 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752661Ab3KXU65 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 24 Nov 2013 15:58:57 -0500
Message-ID: <5292688F.9050501@kernel.org>
Date: Sun, 24 Nov 2013 20:58:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 05/11] iio:st sensors: remove custom sampling frequence
 attribute in favour of core support.
References: <528DFC82.6090908@st.com> <ca9fd1ad-43a0-45a7-ab11-fde361636797@email.android.com>
In-Reply-To: <ca9fd1ad-43a0-45a7-ab11-fde361636797@email.android.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/21/13 15:03, Jonathan Cameron wrote:
> 
> 
> Denis CIOCCA <denis.ciocca@st.com> wrote:
>> Hi Jonathan,
>>
>> I think is a good thing do the porting some features inside the 
>> framework, but I think is also important don't change the userspace 
>> interface.
>>
>> For example now we are developing same libraries and applications that 
>> using those files. What do you think to add on each driver one sysfs 
>> file called 'version' that will be updated when the userspace interface
>>
>> is changed?
> Unfortunately the chances are that an app won't read it so that doesn't get around abi changes.
btw, the intent with this series is not to change the userspace interface.  If I have
then it is a bug so please do point it out!

> 
>>
>> Thanks,
>> Denis
> 
