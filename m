Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60474 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbcBUUdT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 21 Feb 2016 15:33:19 -0500
Subject: Re: [RFC] i2c_check_functionality and error code
To: Matt Ranostay <mranostay@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Wolfram Sang <wsa@the-dreams.de>,
	Linux I2C <linux-i2c@vger.kernel.org>
References: <CAKzfze-B4dx9aghERaRDu7xz0i6pMJcAUGMQX7OWJpWh7i=bxw@mail.gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56CA1F0D.2060707@kernel.org>
Date: Sun, 21 Feb 2016 20:33:17 +0000
MIME-Version: 1.0
In-Reply-To: <CAKzfze-B4dx9aghERaRDu7xz0i6pMJcAUGMQX7OWJpWh7i=bxw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/02/16 23:09, Matt Ranostay wrote:
> Jonathan et all,
> 
> Has anyone noticed that there is no clear consensus on which error
> code to return when a i2c_check_functionality() check fails within the
> probe function. I've seen so far ENODEV, ENOTSUPP, EOPNOTSUPP, EIO,
> and ENOSYS in drivers/iio
> 
> Shouldn't these be made a standard value like -ENOTSUPP?
Would make sense - but is this the right choice.

Thought I'd grep HWMON as a possible source of a consensus on this and
got no clear answer.  The most common in there looks to be -ENODEV though
(From the first few pages of results anyway ;)

Hohum. Wolfram what do you think?

Worth cleaning this up?  Perhaps even kernel wise would lead to some
consistency. I've never been that sharp on this in IIO so I can't
really talk ;)

Jonathan


> 
> Thanks,
> 
> Matt
> 

