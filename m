Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eu1sys200aog105.obsmtp.com ([207.126.144.119]:58911 "EHLO
	eu1sys200aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755920Ab3ETMqk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 20 May 2013 08:46:40 -0400
From: Denis CIOCCA <denis.ciocca@st.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Denis Ciocca <denis.ciocca@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Mon, 20 May 2013 14:45:45 +0200
Subject: Re: Use buffer without trigger
Message-ID: <19561183.S6vWajn81H@ctocwl0124>
References: <CAEE_umrLpNJo1kMbLtktK0RH6WCKCEYR+yiTiyPJu_8G3coE7A@mail.gmail.com>
 <5196280C.8070909@metafoo.de> <519755D6.10000@kernel.org>
In-Reply-To: <519755D6.10000@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> Lots of the ADC drivers do this.  See max1363 for example. No sign a trigger
> but it definitely has a buffer.  Often these parts convert on demand but
> can do it at very high rates.
I Jonathan,

I'm seeing the max1363 driver but I don't understand the caller of 
max1363_trigger_handler function.
Usually, the iio_trigger_generic_data_rdy_poll function inside the 
request_threaded_irq, call iio_trigger_poll function and I suppose that this 
function is the caller of handler declarated inside iio_triggered_buffer_setup.

Many thanks,
Denis