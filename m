Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:60565 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754482Ab2GBJzu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 2 Jul 2012 05:55:50 -0400
Date: Mon, 2 Jul 2012 11:55:48 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Lars-Peter Clausen <lars@metafoo.de>
cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH v3] iio: add adjd_s311 I2C digital color sensor driver
In-Reply-To: <4FF16CE3.60405@metafoo.de>
Message-ID: <alpine.DEB.2.01.1207021144120.1532@pmeerw.net>
References: <1341138013-28267-1-git-send-email-pmeerw@pmeerw.net> <4FF169B6.2000006@metafoo.de> <4FF16CE3.60405@metafoo.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

thank you for reviewing!

> >> +	ret = i2c_smbus_write_word_data(data->client,
> >> +		ADJD_S311_INT_REG(chan->address), int_time);
> >> +	if (ret < 0)
> >> +		return ret;
> >> +
> >> +	return ret ? ret : len;
> > 
> > ret will always be zero here.

right, I think that's a leftover from code calling 
i2c_smbus_read_block_data()

> > I wouldn't return ret here since this is the interrupt handler and I'm not
> > quite sure how the core reacts if it gets a value which is not a
> > irqreturn_t, especially considering that irqreturn_t is basically unsigned.
> > You also have to call iio_trigger_notify_done before leaving the function
> > 
> 
> Looks like you are not alone with this,  I've just wrote a cocci patch which
> finds paths which return form the trigger handler without calling
> iio_trigger_notify_done and it triggers on quite a few other drivers as well.

I know, but no wonder; there is zero documentation and even the sample in 
iio_simple_dummy_buffer.c looks odd:

static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
{
	struct iio_poll_func *pf = p;
...
	data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
	if (data == NULL)
		return -ENOMEM;

I am abusing you as my patch correctness oracle to learn things, sorry :)

regards, p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
