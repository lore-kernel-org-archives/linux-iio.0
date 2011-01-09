Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from antcom.de ([188.40.178.216]:35904 "EHLO chuck.antcom.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751966Ab1AISJd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 9 Jan 2011 13:09:33 -0500
Message-ID: <4D29F9DB.9000006@antcom.de>
Date: Sun, 09 Jan 2011 19:09:31 +0100
From: Roland Stigge <stigge@antcom.de>
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: devel@driverdev.osuosl.org, linux-iio@vger.kernel.org
Subject: Re: Linux driver for MAX517/518/519
References: <4D21A2AA.6080006@antcom.de> <20110103222834.GA11277@kroah.com>
In-Reply-To: <20110103222834.GA11277@kroah.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

On 03/01/11 23:28, Greg KH wrote:
> It's best to convert to the iio subsystem, as that is the way to go in
> the future.

I'm also preparing a plain PWM driver for the LPC3250 SoC.

Would IIO be an appropriate place?

Thanks in advance,

Roland
