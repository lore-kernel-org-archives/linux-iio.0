Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-070.synserver.de ([212.40.185.70]:1082 "EHLO
	smtp-out-069.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756331Ab3APRPM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 16 Jan 2013 12:15:12 -0500
Message-ID: <50F6E053.7000002@metafoo.de>
Date: Wed, 16 Jan 2013 18:16:03 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>
CC: "jic23@kernel.org" <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/9] iio:accel: Add STMicroelectronics accelerometers
 driver
References: <1358238660-14929-1-git-send-email-denis.ciocca@st.com> <1358238660-14929-3-git-send-email-denis.ciocca@st.com> <50F6B90D.6020608@metafoo.de> <50F6DBC4.4050107@st.com>
In-Reply-To: <50F6DBC4.4050107@st.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/16/2013 05:56 PM, Denis CIOCCA wrote:
> Hi Lars-Peter,
> 
> 
>>> diff --git a/drivers/iio/accel/st_accel_buffer.c b/drivers/iio/accel/st_accel_buffer.c
>>
>> This file looks pretty much the same for all drivers, any reason why it
>> can't be shared?
> 
> 
>>> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
>>
>> Here again the function looks exactly the same in all three drivers and
>> could probably be moved to the common library.
> 
> 
> You are right, but the idea is that:
> one common library for all common functions, but leave the code clear ( 
> easy to read).
> In the future I want to patch the current driver to support other features.
> What do you think about?

I'd move the common bits to the common library. Once you get to extending
the drivers you can still add custom variants of theses functions. Only
having one copy of a particular piece of code also makes the reviewers job
easier.

- Lars
