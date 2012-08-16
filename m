Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:59355 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756649Ab2HPRsl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 16 Aug 2012 13:48:41 -0400
Received: by pbbrr13 with SMTP id rr13so1907147pbb.19
        for <linux-iio@vger.kernel.org>; Thu, 16 Aug 2012 10:48:41 -0700 (PDT)
Date: Thu, 16 Aug 2012 10:40:19 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: anish kumar <anish198519851985@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	anish kumar <anish.singh@samsung.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH] [PATCH V6]Extcon: adc_jack: adc-jack driver to support
 3.5 pi or simliar devices
Message-ID: <20120816174019.GA10918@kroah.com>
References: <1344583783-12593-1-git-send-email-anish198519851985@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1344583783-12593-1-git-send-email-anish198519851985@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Aug 10, 2012 at 12:29:43AM -0700, anish kumar wrote:
> From: anish kumar <anish198519851985@gmail.com>
> 
> External connector devices that decides connection information based on
> ADC values may use adc-jack device driver. The user simply needs to
> provide a table of adc range and connection states. Then, extcon
> framework will automatically notify others.

This patch breaks the build:
	ERROR: "extcon_cable_name" [drivers/extcon/extcon-adc-jack.ko] undefined!

And, if you read the comment about extcon_cable_name, it says to not use
it like you are trying to use it.

So, care to fix this up?

thanks,

greg k-h
