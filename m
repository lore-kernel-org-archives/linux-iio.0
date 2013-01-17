Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail2.gnudd.com ([213.203.150.91]:50520 "EHLO mail.gnudd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756824Ab3AQQpE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 17 Jan 2013 11:45:04 -0500
Date: Thu, 17 Jan 2013 17:32:51 +0100
From: Alessandro Rubini <rubini@gnudd.com>
To: jic23@kernel.org
Cc: christophe.leroy@c-s.fr, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, patrick.vasseur@c-s.fr
Subject: Re: [PATCH] IIO ADC support for AD7923
Message-ID: <20130117163251.GA19637@mail.gnudd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <50F13D6B.4030703@kernel.org>
References: <50F13D6B.4030703@kernel.org>
  <201301080842.r088gKWO031124@localhost.localdomain>
 <20130108091414.GA28404@mail.gnudd.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Thank you Jonathan for replying, I apologize for the delay.

>> I wonder if IIO config symbols should have IIO_ in their name, [...]

> I have no particular problem with this for new drivers, but
> obviously it is an interface change for older ones that may
> cause some issues.

Yes, that's right. I just raised a problem, though a minor one.

thanks
/alessandro
