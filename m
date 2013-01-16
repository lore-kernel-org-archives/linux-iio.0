Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eu1sys200aog111.obsmtp.com ([207.126.144.131]:56719 "EHLO
	eu1sys200aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757539Ab3APQ4o convert rfc822-to-8bit
	(ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 16 Jan 2013 11:56:44 -0500
From: Denis CIOCCA <denis.ciocca@st.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "jic23@kernel.org" <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Wed, 16 Jan 2013 17:56:36 +0100
Subject: Re: [PATCH 2/9] iio:accel: Add STMicroelectronics accelerometers
 driver
Message-ID: <50F6DBC4.4050107@st.com>
References: <1358238660-14929-1-git-send-email-denis.ciocca@st.com>
 <1358238660-14929-3-git-send-email-denis.ciocca@st.com>
 <50F6B90D.6020608@metafoo.de>
In-Reply-To: <50F6B90D.6020608@metafoo.de>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Lars-Peter,


>> diff --git a/drivers/iio/accel/st_accel_buffer.c b/drivers/iio/accel/st_accel_buffer.c
>
> This file looks pretty much the same for all drivers, any reason why it
> can't be shared?


>> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
>
> Here again the function looks exactly the same in all three drivers and
> could probably be moved to the common library.


You are right, but the idea is that:
one common library for all common functions, but leave the code clear ( 
easy to read).
In the future I want to patch the current driver to support other features.
What do you think about?


Denis